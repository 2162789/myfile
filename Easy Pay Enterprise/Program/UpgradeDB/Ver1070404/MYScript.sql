if exists(select * from sys.sysprocedure where proc_name = 'FGetTimeSheetEISWage') then
   drop function FGetTimeSheetEISWage
end if;
Create FUNCTION "DBA"."FGetTimeSheetEISWage"(
in In_TMSSGSPGenId char(30))
returns double
Begin
  declare EISWage double;
  declare Out_EISWage double;
  set EISWage=0;
  set Out_EISWage=0;
  if(IsWageElementInUsed('SubjEIS','EISWage') = 1) then
    /*
    Pay Element
    */
    select SUM(CostingAmount) into EISWage
      from TMSAllowance where
      IsFormulaIdHasProperty(FormulaId,'SubjEIS') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if EISWage is not null then
      set Out_EISWage=Out_EISWage+EISWage;
      message '   Pay Element : '+cast(EISWage as char(20)) type info to client
    end if;
    /*
    OT Amount
    */
    select Sum(CurrentCostingAmt)+Sum(LastOTCostingAmt)+Sum(BackPayOTCostingAmt) into EISWage
      from TMSOvertime where
      IsFormulaIdHasProperty(FormulaId,'SubjEIS') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if EISWage is not null then
      set Out_EISWage=Out_EISWage+EISWage;
      message '   OT : '+cast(EISWage as char(20)) type info to client
    end if;
    /*
    Shift Amount
    */
    select Sum(CostingAmount) into EISWage from
      TMSShift where
      IsFormulaIdHasProperty(FormulaId,'SubjEIS') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if EISWage is not null then
      set Out_EISWage=Out_EISWage+EISWage;
      message '   Shift : '+cast(EISWage as char(20)) type info to client
    end if
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt','EISWage') = 1) then
    select Sum(CurrentCostingAmt)+Sum(PreviousCostingAmt) into EISWage
      from TMSLeaveDeduction where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if EISWage is not null then
      set Out_EISWage=Out_EISWage+EISWage;
      message '   Leave Deduction : '+cast(EISWage as char(20)) type info to client
    end if
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay','EISWage') = 1) then
    select Sum(BackPayCostingAmt) into EISWage
      from TMSDetail where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if EISWage is not null then
      set Out_EISWage=Out_EISWage+EISWage;
      message '   Back Pay : '+cast(EISWage as char(20)) type info to client
    end if
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage','EISWage') = 1) then
    select Sum(BasicRateCostingAmt) into EISWage
      from TMSDetail where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if EISWage is not null then
      set Out_EISWage=Out_EISWage+EISWage;
      message '   Total Wage : '+cast(EISWage as char(20)) type info to client
    end if
  end if;
  message '   Total EIS Wage : '+cast(Out_EISWage as char(20)) type info to client;
  return(Out_EISWage)
end
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeEIS') then
   drop procedure ASQLTimeSheetDistributeEIS
end if;
Create PROCEDURE "DBA"."ASQLTimeSheetDistributeEIS"(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
out Out_EISErrorCode integer)
BEGIN
  declare In_TotalEISWage double;
  declare In_TotalEISEEContri double;
  declare In_TotalEISERContri double;
  declare Accu_EISEEContri double;
  declare Accu_EISERContri double;
  declare In_EISEEContri double; 
  declare In_EISERContri double; 
  declare Out_ErrorCode integer;
  declare In_TotalRecord integer;
  declare In_DecimalPlace integer;
  set In_DecimalPlace=FGetDBPayDecimal(*);
  set Out_EISErrorCode = 0;

  /*
  Get the EIS Contribution for Time Sheet Records only
  */
  select Sum(ContriAddEECPF), 
    Sum(ContriAddERCPF) into In_TotalEISEEContri,In_TotalEISERContri from PayRecord join PolicyRecord on
    (PayRecord.PayRecYear = PolicyRecord.PayRecYear and
    PayRecord.PayRecPeriod = PolicyRecord.PayRecPeriod and
    PayRecord.PayRecSubPeriod = PolicyRecord.PayRecSubPeriod and
    PayRecord.PayRecID = PolicyRecord.PayRecID and
    PayRecord.EmployeeSysId = PolicyRecord.EmployeeSysId) where
    PayRecord.EmployeeSysId = In_EmployeeSysId and
    PayRecord.PayRecYear = In_TMSYear and
    PayRecord.PayRecPeriod = In_TMSPeriod and
    (PayRecord.PayRecType = 'RegularTimeSheetPay' or PayRecord.PayRecType = 'AdHocTimeSheetPay')
	group by PayRecord.EmployeeSysId;
  if In_TotalEISEEContri is null then set In_TotalEISEEContri=0
  end if;
  if In_TotalEISERContri is null then set In_TotalEISERContri=0
  end if;
  message '   EIS Employee Contribution     : '+cast(In_TotalEISEEContri as char(20)) type info to client;
  message '   EIS Employer Contribution     : '+cast(In_TotalEISERContri as char(20)) type info to client;
  /*
  No EIS Contribution
  */
  if(In_TotalEISEEContri = 0 and
     In_TotalEISERContri = 0) then
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId in ('TsEISWage', 'TsEEEIS', 'TsEREIS') and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod);
    message '   No EIS Contribution' type info to client;
    set Out_EISErrorCode=0;
    commit work;
    return 
  end if;
 
  /*
  Distribute EIS Wage
  */
  message ' Distribute EIS Wage' type info to client;
  set In_TotalEISWage = 0;
  EISWageLoop: for EISWageFor as EISWage_curs dynamic scroll cursor for
    select TMSSGSPGenId as In_TMSSGSPGenId,
      FGetTimeSheetEISWage(TMSSGSPGenId) as In_EISWage from
      TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod do
   
    /*
    Compute EIS Wage for each Time Sheet
    */ 
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsEISWage') then
      if(In_EISWage <> 0) then        
        call InsertNewTMSDistribute('TsEISWage',In_TMSSGSPGenId,In_EISWage,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsEISWage',In_TMSSGSPGenId,In_EISWage,Out_ErrorCode)
    end if;	
    if(Out_ErrorCode <> 1) then
      set Out_EISErrorCode=1;
      message '   Fail to update EIS Wage' type info to client;
      return
    end if;
	
    set In_TotalEISWage=In_TotalEISWage+In_EISWage;
  end for;
  
  /*
  Count for EIS Wage Records 
  */
  set In_TotalRecord = 0;
  select Count(*) into In_TotalRecord from
    TimeSheet join TMSDistribute where EmployeeSysId = In_EmployeeSysId and
    TMSYear = In_TMSYear and
    TMSPeriod = In_TMSPeriod and
    TMSDistributeId = 'TsEISWage';
  /*
  Distribute EIS Contribution
  */
  message ' Distribute EIS Contribution' type info to client;
  set Accu_EISEEContri=0;
  set Accu_EISERContri=0;
  EISContriLoop: for EISContriFor as EISContri_curs dynamic scroll cursor for
    select Number(*) as In_ID, 
      TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId,
      CostingAmount as In_EISContriWage from
      TimeSheet join TMSDistribute where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSDistributeId = 'TsEISWage' do
    if(In_TotalRecord = 1) then
      set In_EISEEContri=Round(In_TotalEISEEContri-Accu_EISEEContri,In_DecimalPlace);
      set In_EISERContri=Round(In_TotalEISERContri-Accu_EISERContri,In_DecimalPlace);
    else
     /* EIS Employee Contribution */
      if(In_TotalEISEEContri = 0) then
        set In_EISEEContri=0;       
      else
        set In_EISEEContri=Round(In_EISContriWage/In_TotalEISWage*In_TotalEISEEContri,In_DecimalPlace);
        if (In_ID = In_TotalRecord) then
             set In_EISEEContri=Round(In_TotalEISEEContri-Accu_EISEEContri,In_DecimalPlace);
        else
           if(In_EISEEContri+Accu_EISEEContri > In_TotalEISEEContri) then
             set In_EISEEContri=Round(In_TotalEISEEContri-Accu_EISEEContri,In_DecimalPlace);
           end if;
        end if;
      end if;

     /* EIS Employer Contribution */
      if(In_TotalEISERContri = 0) then
        set In_EISERContri=0;       
      else
        set In_EISERContri=Round(In_EISContriWage/In_TotalEISWage*In_TotalEISERContri,In_DecimalPlace);
        if (In_ID = In_TotalRecord) then
             set In_EISERContri=Round(In_TotalEISERContri-Accu_EISERContri,In_DecimalPlace);
        else
           if(In_EISERContri+Accu_EISERContri > In_TotalEISERContri) then
             set In_EISERContri=Round(In_TotalEISERContri-Accu_EISERContri,In_DecimalPlace);
           end if;
        end if;
      end if;
    end if;
    set Accu_EISEEContri=Accu_EISEEContri+In_EISEEContri;
    set Accu_EISERContri=Accu_EISERContri+In_EISERContri;
    /*
    Update Employee Contribution
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsEEEIS') then
      if(In_EISEEContri <> 0) then
        call InsertNewTMSDistribute('TsEEEIS',In_TMSSGSPGenId,In_EISEEContri,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsEEEIS',In_TMSSGSPGenId,In_EISEEContri,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then set 
	  Out_EISErrorCode=2;
      message '   Fail to update EIS Employee Contribution' type info to client;
      return
    end if;
    /*
    Update Employer Contribution
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsEREIS') then
      if(In_EISERContri <> 0) then
        call InsertNewTMSDistribute('TsEREIS',In_TMSSGSPGenId,In_EISERContri,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsEREIS',In_TMSSGSPGenId,In_EISERContri,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then set 
	  Out_EISErrorCode=3;
      message '   Fail to update EIS Employer Contribution' type info to client;
      return
    end if;
   
  end for;

  set Out_EISErrorCode=0;
  message '   End EIS' type info to client;
  commit work;   
END
;

/*==============================================================*/
/* Rebate Claim                                   */
/*==============================================================*/
/* Interface Viewer */
if not exists(select * from SubRegistry where RegistryId = 'Viewer' and SubRegistryId = 'RebateClaimViewer') then
   insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
	        RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('Viewer','RebateClaimViewer','Rebate Claim Record Viewer','PayModule','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

/* ModuleScreenGroup */
if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'RebateClaimViewer') then
  insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values('RebateClaimViewer','InterfaceViewer','Rebate Claim Record Viewer','InterfaceViewer',0,0,0,'');
end if;

/* ImportFieldTable */
if not exists(select * from ImportFieldTable where TableNamePhysical = 'iRebateClaimRecord') then 
   insert into ImportFieldTable(TableNamePhysical,TableNameUserDefined)
   values('iRebateClaimRecord','Rebate Claim Record');
end if;

/* ImportFieldName */
if not exists(select * from ImportFieldName where TableNamePhysical = 'iRebateClaimRecord' and FieldNamePhysical = 'RebateIdentityNo') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iRebateClaimRecord','RebateIdentityNo','Identity No','String',1);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iRebateClaimRecord' and FieldNamePhysical = 'RebateDate') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iRebateClaimRecord','RebateDate','Processing Date','Date',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iRebateClaimRecord' and FieldNamePhysical = 'RebateePortalStatus') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iRebateClaimRecord','RebateePortalStatus','Approve Status','String',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iRebateClaimRecord' and FieldNamePhysical = 'RebateID') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iRebateClaimRecord','RebateID','Rebate ID','String',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iRebateClaimRecord' and FieldNamePhysical = 'RebateClaimAmt') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iRebateClaimRecord','RebateClaimAmt','Claim Amount','Numeric',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iRebateClaimRecord' and FieldNamePhysical = 'RebateReferenceNo') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iRebateClaimRecord','RebateReferenceNo','Reference No','String',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iRebateClaimRecord' and FieldNamePhysical = 'RebateReceiptDate') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iRebateClaimRecord','RebateReceiptDate','Receipt Date','Date',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iRebateClaimRecord' and FieldNamePhysical = 'RebateRemarks') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iRebateClaimRecord','RebateRemarks','Remarks','String',0);
end if;

/* Interface Process */
if not exists(select * from SubRegistry where RegistryId = 'InterfaceProcess' and SubRegistryId = 'Rebate Claim Process') then
   insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
	        RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('InterfaceProcess','Rebate Claim Process','RebateClaimProcess.rtf','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

insert into InterfaceProcess(InterfaceProjectID, InterfaceProcessID, InterfaceConnectionId, IntProcExtConnection, IntProcActivate, IntProcRemarks)
select InterfaceProjectID, 'Rebate Claim Process', NULL, 0,0,''
from InterfaceProject where InterfaceProjectID not in (select InterfaceProjectID from InterfaceProcess where InterfaceProcessID = 'Rebate Claim Process');

/* Interface Code Table */
if not exists(select * from SubRegistry where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'RebateePortalStatus') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('InterfaceCodeTable','RebateePortalStatus','Rebate Claim Process','','','','','UNION SELECT 3 as EPEID, ''Rejected'' as EPEIDDesc UNION SELECT 4 as EPEID, ''Request For Change'' as EPEIDDesc Order by EPEID','SELECT 0 as EPEID, ''Pending'' as EPEIDDesc UNION SELECT 1 as EPEID, ''Approved'' as EPEIDDesc UNION SELECT 2 as EPEID, ''Cancelled'' as EPEIDDesc','Approve Status','','',NULL,NULL,'',NULL,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'RebateID') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('InterfaceCodeTable','RebateID','Rebate Claim Process','','','','','AND RebateID not in (''Lve Passage'' ,''Lve Passage Overseas'',''Childcare'',''Meal'',''Parking'',''Petrol Official'',''Petrol Non Official'',''Compensation'',''Loan Interest'') Order By RebateId','SELECT RebateID as EPEID, RebateDesc as EPEIDDesc From RebateItem WHERE RebateERApproval=1','Rebate ID','','',NULL,NULL,'',NULL,'','','1899-12-30','1899-12-30 00:00:00');
end if;

/* Interface Project Code */
insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
select InterfaceProjectID, 'Rebate Claim Process', 'RebateePortalStatus', '', 1, 0, ''
from InterfaceProject where InterfaceProjectID not in (select InterfaceProjectID from InterfaceCodeTable where InterfaceProcessID = 'Rebate Claim Process' and CodeTableID = 'RebateePortalStatus');

insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
select InterfaceProjectID, 'Rebate Claim Process', 'RebateID', '', 1, 0, ''
from InterfaceProject where InterfaceProjectID not in (select InterfaceProjectID from InterfaceCodeTable where InterfaceProcessID = 'Rebate Claim Process' and CodeTableID = 'RebateID');

/*==============================================================*/
/* Import EIS                               */
/*==============================================================*/
/* ImportFieldName */
if not exists(select * from ImportFieldName where TableNamePhysical = 'iYTDMYPolicy' and FieldNamePhysical = 'EISEmployeeContri') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iYTDMYPolicy','EISEmployeeContri','EIS Employee Contribution','Numeric',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iYTDMYPolicy' and FieldNamePhysical = 'EISEmployerContri') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iYTDMYPolicy','EISEmployerContri','EIS Employer Contribution','Numeric',0);
end if;

/*==============================================================*/
/* Socso8A - iPerkeso                                   */
/*==============================================================*/
/* Include 2 New Race */
if not exists(select * from Race where RaceId = 'Bumiputera Sabah') then
	INSERT INTO Race (RaceId, RaceDesc) VALUES ('Bumiputera Sabah', 'Bumiputera Sabah');
end if;

if not exists(select * from Race where RaceId = 'Bumiputera Sarawak') then
	INSERT INTO Race (RaceId, RaceDesc) VALUES ('Bumiputera Sarawak', 'Bumiputera Sarawak');
end if;

/* Requirement for New Socso8A Format - iPerkeso */
if not exists(select * from Subregistry where SubRegistryId = 'ContriToSocso') then
	
	/* Add ContriToSocso to Employee Other Info - For future New Employee (default to Yes) */
	INSERT INTO Subregistry (RegistryId, SubRegistryId, RegProperty1, RegProperty2, BooleanAttr) VALUES ('EmpeeOtherInfo', 'ContriToSocso', 'Contributed to Socso Before (iPerkeso)', 'Boolean', 0);
	
	/* Add ContriToSocso To Employee Other Info - Existing Empployee (default to Yes)*/
	INSERT INTO EmpeeOtherInfo (EmployeeSysId, EmpeeOtherInfoId, EmpeeOtherInfoCaption, EmpeeOtherInfoType, EmpeeOtherInfoDate, EmpeeOtherInfoString, EmpeeOtherInfoBoolean, EmpeeOtherInfoDouble) 
	select EmployeeSysId, 'ContriToSocso', 'Contributed to Socso Before (iPerkeso)', 'Boolean', NULL, '', 1, 0 from employee;
	
	/* Security Setup for new screen (Socso8A - iPerkeso) */
	INSERT INTO ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId) 
	VALUES ('PayiPERKESO','PayMalGovForm','Socso 8A Submission (iPerkeso)','Pay',0,1,0,'');
	
end if;

/* KeyWord */
if not exists(select * from KeyWord where KeyWordId = 'TsEISWage') then
  insert into KeyWord(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
	                    KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('TsEISWage','EIS Wage','EIS Wage','Ts Distribute',0,0,0,'',0,0,0,'');
end if;

if not exists(select * from KeyWord where KeyWordId = 'TsEEEIS') then
  insert into KeyWord(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
	                    KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('TsEEEIS','Employee EIS Contribution','Employee EIS Contribution','Ts Distribute',0,0,0,'',0,0,0,'');
end if;

if not exists(select * from KeyWord where KeyWordId = 'TsEREIS') then
  insert into KeyWord(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
	                    KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('TsEREIS','Employer EIS Contribution','Employer EIS Contribution','Ts Distribute',0,0,0,'',0,0,1,'');
end if;

/* CostKeyWord */
if not exists(select * from CostKeyWord where CostKeywordId = 'TsEEEIS') then
  insert into CostKeyWord(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,CostKeywordStr1,CostKeywordStr2)
  values('TsEEEIS','Time Sheet Employee EIS Contribution','Time Sheet Employee EIS Contribution','TsSystemItemType',1,'','','','');
end if;

if not exists(select * from CostKeyWord where CostKeywordId = 'TsEREIS') then
  insert into CostKeyWord(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,CostKeywordStr1,CostKeywordStr2)
  values('TsEREIS','Time Sheet Employer EIS Contribution','Time Sheet Employer EIS Contribution','TsSystemItemType',0,'','','','');
end if;

commit work;