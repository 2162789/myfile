Read UpgradeDB\Ver1061004\ID_RenameJamso.sql;
Read UpgradeDB\Ver1061004\ID_InterfaceBPJSKes.sql;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayPeriodBPJSKSWage') then
   drop procedure ASQLCalPayPeriodBPJSKSWage;
end if;
Create PROCEDURE "DBA"."ASQLCalPayPeriodBPJSKSWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
out Out_BPJSKeseWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  set Out_BPJSKeseWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if(IsWageElementInUsed('SubjBPJSKS','BPJSKesehatanWage') = 1) then
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
    end if;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  if(IsWageElementInUsed('LeaveDeductAmt','BPJSKesehatanWage') = 1) then
    select Sum(CalLveDeductAmt) into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_LveDeductAmt
  end if;
  if(IsWageElementInUsed('BackPay','BPJSKesehatanWage') = 1) then
    select Sum(CalBackPay) into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_BackPayAmt
  end if;
  if(IsWageElementInUsed('TotalWage','BPJSKesehatanWage') = 1) then
    select Sum(CalTotalWage) into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_TotalWageAmt
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayRecBPJSKSWage') then
   drop procedure ASQLCalPayRecBPJSKSWage;
end if;
CREATE PROCEDURE "DBA"."ASQLCalPayRecBPJSKSWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_BPJSKeseWage double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  set Out_BPJSKeseWage=0;
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if(IsWageElementInUsed('SubjBPJSKS','BPJSKesehatanWage') = 1) then
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
    end if;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  if(IsWageElementInUsed('LeaveDeductAmt','BPJSKesehatanWage') = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_LveDeductAmt
  end if;
  if(IsWageElementInUsed('BackPay','BPJSKesehatanWage') = 1) then
    select CalBackPay into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_BackPayAmt
  end if;
  if(IsWageElementInUsed('TotalWage','BPJSKesehatanWage') = 1) then
    select CalTotalWage into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    set Out_BPJSKeseWage=Out_BPJSKeseWage+Out_TotalWageAmt
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewIndoTaxEmployer') then
   drop procedure InsertNewIndoTaxEmployer;
end if;
create procedure DBA.InsertNewIndoTaxEmployer(
in In_IndoTaxEmployerId char(20),
in In_IndoTaxEmployerDesc char(100),
in In_IndoTaxAuthoriseName char(150),
in In_IndoTaxERTaxRefNo char(35),
in In_IndoTaxAuthoriseTaxRefNo char(35),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_State char(20),
in In_City char(20),
in In_PostalCode char(6),
in In_TelephoneNo char(30),
in In_TypeOfBusiness char(20),
in In_RegistrationNo char(35),
in In_IndoOldAgeOption smallint,
in In_Signature smallint,
in In_IndoBPJSKSOption smallint,
in In_IndoAccidentOption smallint,
in In_IndoDeathOption smallint,
out Out_ErrorCode integer)
begin
  if not exists(select* from IndoTaxEmployer where IndoTaxEmployer.IndoTaxEmployerId = In_IndoTaxEmployerId) then
    if(In_State is not null) and(In_State <> '') and(In_City is not null) and(In_City <> '') and
      not exists(select* from City where CountryId = 'Indonesia' and StateId = In_State and CityId = In_City) then
      set Out_ErrorCode=-1;
      return
    end if;
    insert into IndoTaxEmployer(IndoTaxEmployerId,
      IndoTaxEmployerDesc,
      IndoTaxAuthoriseName,
      IndoTaxERTaxRefNo,
      IndoTaxAuthoriseTaxRefNo,
      Address1,Address2,Address3,
      State,City,PostalCode,
      TelephoneNo,
      TypeOfBusiness,
      RegistrationNo,
      IndoOldAgeOption,
      Signature,
      IndoBPJSKSOption,
      IndoAccidentOption,
      IndoDeathOption) values(
      In_IndoTaxEmployerId,
      In_IndoTaxEmployerDesc,
      In_IndoTaxAuthoriseName,
      In_IndoTaxERTaxRefNo,
      In_IndoTaxAuthoriseTaxRefNo,
      In_Address1,In_Address2,In_Address3,
      In_State,In_City,In_PostalCode,
      In_TelephoneNo,
      In_TypeOfBusiness,
      In_RegistrationNo,
      In_IndoOldAgeOption,
      In_Signature,
      In_IndoBPJSKSOption,
      In_IndoAccidentOption,
      In_IndoDeathOption);
    commit work;
    if not exists(select* from IndoTaxEmployer where IndoTaxEmployer.IndoTaxEmployerId = In_IndoTaxEmployerId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateIndoTaxEmployer') then
   drop procedure UpdateIndoTaxEmployer;
end if;
create procedure DBA.UpdateIndoTaxEmployer(
in In_IndoTaxEmployerId char(20),
in In_IndoTaxEmployerDesc char(100),
in In_IndoTaxAuthoriseName char(150),
in In_IndoTaxERTaxRefNo char(35),
in In_IndoTaxAuthoriseTaxRefNo char(35),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_State char(20),
in In_City char(20),
in In_PostalCode char(6),
in In_TelephoneNo char(30),
in In_TypeOfBusiness char(20),
in In_RegistrationNo char(35),
in In_IndoOldAgeOption smallint,
in In_Signature smallint,
in In_IndoBPJSKSOption smallint,
in In_IndoAccidentOption smallint,
in In_IndoDeathOption smallint,
out Out_ErrorCode 
integer)
begin
  if exists(select* from IndoTaxEmployer where IndoTaxEmployerId = In_IndoTaxEmployerId) then
    if(In_State is not null) and(In_State <> '') and(In_City is not null) and(In_City <> '') and
      not exists(select* from City where CountryId = 'Indonesia' and StateId = In_State and CityId = In_City) then
      set Out_ErrorCode=-1;
      return
    end if;
    update IndoTaxEmployer set
      IndoTaxEmployerDesc = In_IndoTaxEmployerDesc,
      IndoTaxAuthoriseName = In_IndoTaxAuthoriseName,
      IndoTaxERTaxRefNo = In_IndoTaxERTaxRefNo,
      IndoTaxAuthoriseTaxRefNo = In_IndoTaxAuthoriseTaxRefNo,
      Address1 = In_Address1,
      Address2 = In_Address2,
      Address3 = In_Address3,
      State = In_State,
      City = In_City,
      PostalCode = In_PostalCode,
      TelephoneNo = In_TelephoneNo,
      TypeOfBusiness = In_TypeOfBusiness,
      RegistrationNo = In_RegistrationNo,
      IndoOldAgeOption = In_IndoOldAgeOption,
      Signature = In_Signature, 
      IndoBPJSKSOption = In_IndoBPJSKSOption,
      IndoAccidentOption = In_IndoAccidentOption,
      IndoDeathOption = In_IndoDeathOption where
      IndoTaxEmployerId = In_IndoTaxEmployerId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

/* BPJS Kesehatan item for the costing */
if not exists(select * from CostKeyword where CostKeywordId = 'EEBPJSKes') then
    insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,CostKeywordStr1,CostKeywordStr2)
	values('EEBPJSKes','Employee BPJS Kesehatan','Employee BPJS Kesehatan','SystemItemType',1,'','','','');
end if;

if not exists(select * from CostKeyword where CostKeywordId = 'ERBPJSKes') then
    insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,CostKeywordStr1,CostKeywordStr2)
	values('ERBPJSKes','Employer BPJS Kesehatan','Employer BPJS Kesehatan','SystemItemType',0,'','','','');
end if;

/* ModuleScreenGroup */
if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'PayTaxeSPTMonthly') then
   insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
   values('PayTaxeSPTMonthly','PayIncomeTaxRpt','Pemotongan Pajak Bulanan CSV','Pay',0,1,0,NULL);
end if;

if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'PayTax1721A1CSV') then
   insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
   values('PayTax1721A1CSV','PayIncomeTaxRpt','1721-A1 CSV','Pay',0,1,0,NULL);
end if;

commit work;