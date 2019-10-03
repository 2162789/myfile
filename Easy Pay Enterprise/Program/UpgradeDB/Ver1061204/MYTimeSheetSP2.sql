if exists(select * from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeIndividualEPF') then
   drop PROCEDURE ASQLTimeSheetDistributeIndividualEPF;
end if;
CREATE PROCEDURE "DBA"."ASQLTimeSheetDistributeIndividualEPF"(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
in In_WageType char(20),
in In_TMSEPFWageDistributeId char(20),
in In_TMSEFPContrDistributeId char(20),
in In_TotalEPFContri double,
in In_EPFErrorCode integer,
in In_Message char(100),
out Out_EPFErrorCode integer)
BEGIN
  declare In_TotalEPFWage double;
  declare Accu_EPFContri double;
  declare In_EPFContri double; 
  declare Out_ErrorCode integer;
  declare In_TotalRecord integer;
  declare In_DecimalPlace integer;
  set In_DecimalPlace=FGetDBPayDecimal(*);

  if In_TotalEPFContri is null then set In_TotalEPFContri=0
  end if;
  message '   ' +  In_Message + ' EPF     : '+cast(In_TotalEPFContri as char(20)) type info to client;
  /*
  No EPF Contribution
  */
  if(In_TotalEPFContri = 0) then
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = In_TMSEPFWageDistributeId and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod);
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = In_TMSEFPContrDistributeId and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod);
    message '   No ' + In_Message + ' Contribution' type info to client;
    set Out_EPFErrorCode=0;
    commit work;
    return 
  end if;
 
  /*
  Distribute EPF Wage
  */
  message ' Distribute ' + In_Message + ' Wage' type info to client;
  set In_TotalEPFWage = 0;
  EPFWageLoop: for EPFWageFor as EPFWage_curs dynamic scroll cursor for
    select TMSSGSPGenId as In_TMSSGSPGenId,
      FGetTimeSheetEPFWage(TMSSGSPGenId,In_WageType) as In_EPFContriWage from
      TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod do
   
    /*
    Compute EPF Wage for each Time Sheet
    */ 
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = In_TMSEPFWageDistributeId) then
      if(In_EPFContriWage <> 0) then        
        call InsertNewTMSDistribute(In_TMSEPFWageDistributeId,In_TMSSGSPGenId,In_EPFContriWage,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute(In_TMSEPFWageDistributeId,In_TMSSGSPGenId,In_EPFContriWage,Out_ErrorCode)
    end if;	
    if(Out_ErrorCode <> 1) then
      set Out_EPFErrorCode=In_EPFErrorCode;
      message '   Fail to update ' + In_Message + ' EPF Wage' type info to client;
      return
    end if;
	
    set In_TotalEPFWage=In_TotalEPFWage+In_EPFContriWage;
  end for;
  
  /*
  Count for EPF Wage Records 
  */
  set In_TotalRecord = 0;
  select Count(*) into In_TotalRecord from
    TimeSheet join TMSDistribute where EmployeeSysId = In_EmployeeSysId and
    TMSYear = In_TMSYear and
    TMSPeriod = In_TMSPeriod and
    TMSDistributeId = In_TMSEPFWageDistributeId;
  /*
  Distribute EPF Contribution
  */
  message ' Distribute ' +  In_Message + ' EPF Contribution' type info to client;
  set Accu_EPFContri=0;
  EECurManEPFLoop: for EECurManEPFFor as EECurManEPF_curs dynamic scroll cursor for
    select Number(*) as In_ID, 
      TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId,
      CostingAmount as In_EECurManEPFWage from
      TimeSheet join TMSDistribute where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSDistributeId = In_TMSEPFWageDistributeId do
    if(In_TotalRecord = 1) then
      set In_EPFContri=Round(In_TotalEPFContri-Accu_EPFContri,In_DecimalPlace);
    else
     /* EPF Contribution */
      if(In_TotalEPFContri = 0) then
        set In_EPFContri=0
      else
        set In_EPFContri=Round(In_EECurManEPFWage/In_TotalEPFWage*In_TotalEPFContri,In_DecimalPlace);
        if (In_ID = In_TotalRecord) then
             set In_EPFContri=Round(In_TotalEPFContri-Accu_EPFContri,In_DecimalPlace);
        else
           if(In_EPFContri+Accu_EPFContri > In_TotalEPFContri) then
             set In_EPFContri=Round(In_TotalEPFContri-Accu_EPFContri,In_DecimalPlace);
           end if;
        end if;
      end if;
    end if;
    set Accu_EPFContri=Accu_EPFContri+In_EPFContri;
    /*
    Update EPF Contribution
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = In_TMSEFPContrDistributeId) then
      if(In_EPFContri <> 0) then
        call InsertNewTMSDistribute(In_TMSEFPContrDistributeId,In_TMSSGSPGenId,In_EPFContri,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute(In_TMSEFPContrDistributeId,In_TMSSGSPGenId,In_EPFContri,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then set 
	  Out_EPFErrorCode=(In_EPFErrorCode+1);
      message '   Fail to update ' + In_Message + ' EPF Contribution' type info to client;
      return
    end if;
  end for;

  set Out_EPFErrorCode=0;
  message '   End ' + In_Message + ' EPF' type info to client;
  commit work;   
END
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeEPF') then
   drop PROCEDURE ASQLTimeSheetDistributeEPF;
end if;
CREATE PROCEDURE "DBA"."ASQLTimeSheetDistributeEPF"(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
out Out_EPFErrorCode integer)
BEGIN
  declare In_TotalCurEEManEPF double;
  declare In_TotalCurERManEPF double;
  declare In_TotalPreEEManEPF double;
  declare In_TotalPreERManEPF double;
  declare In_TotalCurEEVolEPF double;
  declare In_TotalCurERVolEPF double;
  declare In_TotalPreEEVolEPF double;
  declare In_TotalPreERVolEPF double;
  set Out_EPFErrorCode = 0;

  /*
  Get the EPF Contribution for Time Sheet Records only
  */
  select Sum(CurrEEManContri), Sum(CurrERManContri), Sum(PrevEEManContri), Sum(PrevERManContri),
    Sum(CurrEEVolContri), Sum(CurrERVolContri), Sum(PrevEEVolContri), Sum(PrevERVolContri) into In_TotalCurEEManEPF,In_TotalCurERManEPF,In_TotalPreEEManEPF,In_TotalPreERManEPF,
	In_TotalCurEEVolEPF,In_TotalCurERVolEPF,In_TotalPreEEVolEPF,In_TotalPreERVolEPF from PayRecord join PolicyRecord on
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
	
	/* Output Error Code is 1 & 2 */
	call ASQLTimeSheetDistributeIndividualEPF(In_EmployeeSysId,In_TMSYear,In_TMSPeriod,'CurrEEManEPFWage','TsCurEEManEPFWage','TsEECurManEPF',In_TotalCurEEManEPF,1,'Current Employee Mandatory',Out_EPFErrorCode);
	if Out_EPFErrorCode <> 0 then return end if;
	/* Output Error Code is 3 & 4 */
	call ASQLTimeSheetDistributeIndividualEPF(In_EmployeeSysId,In_TMSYear,In_TMSPeriod,'CurrERManEPFWage','TsCurERManEPFWage','TsERCurManEPF',In_TotalCurERManEPF,3,'Current Employer Mandatory',Out_EPFErrorCode);
	if Out_EPFErrorCode <> 0 then return end if;
	/* Output Error Code is 5 & 6 */
	call ASQLTimeSheetDistributeIndividualEPF(In_EmployeeSysId,In_TMSYear,In_TMSPeriod,'PrevEEManEPFWage','TsPreEEManEPFWage','TsEEPreManEPF',In_TotalPreEEManEPF,5,'Previous Employee Mandatory',Out_EPFErrorCode);
	if Out_EPFErrorCode <> 0 then return end if;
	/* Output Error Code is 7 & 8 */
	call ASQLTimeSheetDistributeIndividualEPF(In_EmployeeSysId,In_TMSYear,In_TMSPeriod,'PrevERManEPFWage','TsPreERManEPFWage','TsERPreManEPF',In_TotalPreERManEPF,7,'Previous Employer Mandatory',Out_EPFErrorCode);
	if Out_EPFErrorCode <> 0 then return end if; 
	/* Output Error Code is 9 & 10 */
	call ASQLTimeSheetDistributeIndividualEPF(In_EmployeeSysId,In_TMSYear,In_TMSPeriod,'CurrEEVolEPFWage','TsCurEEVolEPFWage','TsEECurVolEPF',In_TotalCurEEVolEPF,9,'Current Employee Voluntary',Out_EPFErrorCode);
	if Out_EPFErrorCode <> 0 then return end if; 
	/* Output Error Code is 11 & 12 */
	call ASQLTimeSheetDistributeIndividualEPF(In_EmployeeSysId,In_TMSYear,In_TMSPeriod,'CurrERVolEPFWage','TsCurERVolEPFWage','TsERCurVolEPF',In_TotalCurERVolEPF,11,'Current Employer Voluntary',Out_EPFErrorCode);
	if Out_EPFErrorCode <> 0 then return end if;
	/* Output Error Code is 13 & 14 */
	call ASQLTimeSheetDistributeIndividualEPF(In_EmployeeSysId,In_TMSYear,In_TMSPeriod,'PrevEEVolEPFWage','TsPreEEVolEPFWage','TsEEPreVolEPF',In_TotalPreEEVolEPF,13,'Previous Employee Voluntary',Out_EPFErrorCode);
	if Out_EPFErrorCode <> 0 then return end if;
	/* Output Error Code is 15 & 16 */
	call ASQLTimeSheetDistributeIndividualEPF(In_EmployeeSysId,In_TMSYear,In_TMSPeriod,'PrevERVolEPFWage','TsPreERVolEPFWage','TsERPreVolEPF',In_TotalPreERVolEPF,15,'Previous Employer Voluntary',Out_EPFErrorCode);
	
END
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeSOCSO') then
   drop PROCEDURE ASQLTimeSheetDistributeSOCSO;
end if;
CREATE PROCEDURE "DBA"."ASQLTimeSheetDistributeSOCSO"(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
out Out_SOCSOErrorCode integer)
BEGIN
  declare In_TotalSOCSOWage double;
  declare In_TotalSOCSOEEContri double;
  declare In_TotalSOCSOERContri double;
  declare Accu_SOCSOEEContri double;
  declare Accu_SOCSOERContri double;
  declare In_SOCSOEEContri double; 
  declare In_SOCSOERContri double; 
  declare Out_ErrorCode integer;
  declare In_TotalRecord integer;
  declare In_DecimalPlace integer;
  set In_DecimalPlace=FGetDBPayDecimal(*);
  set Out_SOCSOErrorCode = 0;

  /*
  Get the SOCSO Contribution for Time Sheet Records only
  */
  select Sum(ContriOrdEECPF), 
    Sum(ContriOrdERCPF) into In_TotalSOCSOEEContri,In_TotalSOCSOERContri from PayRecord join PolicyRecord on
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
  if In_TotalSOCSOEEContri is null then set In_TotalSOCSOEEContri=0
  end if;
  if In_TotalSOCSOERContri is null then set In_TotalSOCSOERContri=0
  end if;
  message '   SOCSO Employee Contribution     : '+cast(In_TotalSOCSOEEContri as char(20)) type info to client;
  message '   SOCSO Employer Contribution     : '+cast(In_TotalSOCSOERContri as char(20)) type info to client;
  /*
  No SOCSO Contribution
  */
  if(In_TotalSOCSOEEContri = 0 and
     In_TotalSOCSOERContri = 0) then
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsSOCSOWage' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod);
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsEESOCSO' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod);
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsERSOCSO' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod);
    message '   No SOCSO Contribution' type info to client;
    set Out_SOCSOErrorCode=0;
    commit work;
    return 
  end if;
 
  /*
  Distribute SOCSO Wage
  */
  message ' Distribute SOCSO Wage' type info to client;
  set In_TotalSOCSOWage = 0;
  SOCSOWageLoop: for SOCSOWageFor as SOCSOWage_curs dynamic scroll cursor for
    select TMSSGSPGenId as In_TMSSGSPGenId,
      FGetTimeSheetSOCSOWage(TMSSGSPGenId) as In_SOCSOWage from
      TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod do
   
    /*
    Compute SOCSO Wage for each Time Sheet
    */ 
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsSOCSOWage') then
      if(In_SOCSOWage <> 0) then        
        call InsertNewTMSDistribute('TsSOCSOWage',In_TMSSGSPGenId,In_SOCSOWage,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsSOCSOWage',In_TMSSGSPGenId,In_SOCSOWage,Out_ErrorCode)
    end if;	
    if(Out_ErrorCode <> 1) then
      set Out_SOCSOErrorCode=1;
      message '   Fail to update SOCSO Wage' type info to client;
      return
    end if;
	
    set In_TotalSOCSOWage=In_TotalSOCSOWage+In_SOCSOWage;
  end for;
  
  /*
  Count for SOCSO Wage Records 
  */
  set In_TotalRecord = 0;
  select Count(*) into In_TotalRecord from
    TimeSheet join TMSDistribute where EmployeeSysId = In_EmployeeSysId and
    TMSYear = In_TMSYear and
    TMSPeriod = In_TMSPeriod and
    TMSDistributeId = 'TsSOCSOWage';
  /*
  Distribute SOCSO Contribution
  */
  message ' Distribute SOCSO Contribution' type info to client;
  set Accu_SOCSOEEContri=0;
  set Accu_SOCSOERContri=0;
  SOCSOContriLoop: for SOCSOContriFor as SOCSOContri_curs dynamic scroll cursor for
    select Number(*) as In_ID, 
      TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId,
      CostingAmount as In_SOCSOContriWage from
      TimeSheet join TMSDistribute where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSDistributeId = 'TsSOCSOWage' do
    if(In_TotalRecord = 1) then
      set In_SOCSOEEContri=Round(In_TotalSOCSOEEContri-Accu_SOCSOEEContri,In_DecimalPlace);
      set In_SOCSOERContri=Round(In_TotalSOCSOERContri-Accu_SOCSOERContri,In_DecimalPlace);
    else
     /* SOCSO Employee Contribution */
      if(In_TotalSOCSOEEContri = 0) then
        set In_SOCSOEEContri=0;       
      else
        set In_SOCSOEEContri=Round(In_SOCSOContriWage/In_TotalSOCSOWage*In_TotalSOCSOEEContri,In_DecimalPlace);
        if (In_ID = In_TotalRecord) then
             set In_SOCSOEEContri=Round(In_TotalSOCSOEEContri-Accu_SOCSOEEContri,In_DecimalPlace);
        else
           if(In_SOCSOEEContri+Accu_SOCSOEEContri > In_TotalSOCSOEEContri) then
             set In_SOCSOEEContri=Round(In_TotalSOCSOEEContri-Accu_SOCSOEEContri,In_DecimalPlace);
           end if;
        end if;
      end if;

     /* SOCSO Employer Contribution */
      if(In_TotalSOCSOERContri = 0) then
        set In_SOCSOERContri=0;       
      else
        set In_SOCSOERContri=Round(In_SOCSOContriWage/In_TotalSOCSOWage*In_TotalSOCSOERContri,In_DecimalPlace);
        if (In_ID = In_TotalRecord) then
             set In_SOCSOERContri=Round(In_TotalSOCSOERContri-Accu_SOCSOERContri,In_DecimalPlace);
        else
           if(In_SOCSOERContri+Accu_SOCSOERContri > In_TotalSOCSOERContri) then
             set In_SOCSOERContri=Round(In_TotalSOCSOERContri-Accu_SOCSOERContri,In_DecimalPlace);
           end if;
        end if;
      end if;
    end if;
    set Accu_SOCSOEEContri=Accu_SOCSOEEContri+In_SOCSOEEContri;
    set Accu_SOCSOERContri=Accu_SOCSOERContri+In_SOCSOERContri;
    /*
    Update Employee Contribution
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsEESOCSO') then
      if(In_SOCSOEEContri <> 0) then
        call InsertNewTMSDistribute('TsEESOCSO',In_TMSSGSPGenId,In_SOCSOEEContri,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsEESOCSO',In_TMSSGSPGenId,In_SOCSOEEContri,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then set 
	  Out_SOCSOErrorCode=2;
      message '   Fail to update SOCSO Employee Contribution' type info to client;
      return
    end if;
    /*
    Update Employer Contribution
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsERSOCSO') then
      if(In_SOCSOERContri <> 0) then
        call InsertNewTMSDistribute('TsERSOCSO',In_TMSSGSPGenId,In_SOCSOERContri,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsERSOCSO',In_TMSSGSPGenId,In_SOCSOERContri,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then set 
	  Out_SOCSOErrorCode=3;
      message '   Fail to update SOCSO Employer Contribution' type info to client;
      return
    end if;
   
  end for;

  set Out_SOCSOErrorCode=0;
  message '   End SOCSO' type info to client;
  commit work;   
END
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeIndividualMYTaxAmount') then
   drop PROCEDURE ASQLTimeSheetDistributeIndividualMYTaxAmount;
end if;
CREATE PROCEDURE "DBA"."ASQLTimeSheetDistributeIndividualMYTaxAmount"(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
in In_TotalTaxAmount double,
in In_CurrentYear char(20),
in In_TMSTaxAmtDistributeId char(20),
in In_TaxErrorCode integer,
in In_Message char(100),
out Out_TaxErrorCode integer)
BEGIN
  declare In_TotalTaxSalary double;
  declare Accu_TaxAmount double;
  declare In_TaxAmount double; 
  declare Out_ErrorCode integer;
  declare In_TotalRecord integer;
  declare In_DecimalPlace integer;
  set In_DecimalPlace=FGetDBPayDecimal(*);
  set Out_TaxErrorCode = 0;

  if In_TotalTaxAmount is null then set In_TotalTaxAmount=0
  end if;
  message '   ' + In_Message + ' Tax Amount     : '+cast(In_TotalTaxAmount as char(20)) type info to client;
  /*
  No Tax Amount
  */
  if(In_TotalTaxAmount = 0) then
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsPaidPreTaxAmt' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod);
    message '   No ' + In_Message + ' Tax Amount' type info to client;
    set Out_TaxErrorCode=0;
    commit work;
    return 
  end if;

  /*
  Get Total Time Sheet Amount  
  */
  set In_TotalTaxSalary = 0;
  TotalTaxSalaryLoop: for TotalTaxSalaryFor as TotalTaxSalary_curs dynamic scroll cursor for
    select TMSSGSPGenId as In_TMSSGSPGenId,
      (FGetTimeSheetTaxGrossSalary(TMSSGSPGenId,In_CurrentYear) + FGetTimeSheetTaxAddGrossSalary(TMSSGSPGenId,In_CurrentYear)) as In_TaxSalary from
      TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod do  
    set In_TotalTaxSalary=In_TotalTaxSalary+In_TaxSalary;
  end for; 
  
  /*
  Count for Time Sheet Records for Tax Salary
  */
  set In_TotalRecord = 0;
  select Count(*) into In_TotalRecord from
    TimeSheet where EmployeeSysId = In_EmployeeSysId and
    TMSYear = In_TMSYear and
    TMSPeriod = In_TMSPeriod and
    (FGetTimeSheetTaxGrossSalary(TMSSGSPGenId,In_CurrentYear) + FGetTimeSheetTaxAddGrossSalary(TMSSGSPGenId,In_CurrentYear) <> 0);

  /*
  Distribute Tax Amount
  */
  message ' Distribute ' + In_Message + ' Tax Amount' type info to client;
  set Accu_TaxAmount=0;
  PreTaxAmtLoop: for PreTaxAmtFor as PreTaxAmt_curs dynamic scroll cursor for
    select Number(*) as In_ID, 
      TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId,
      (FGetTimeSheetTaxGrossSalary(TMSSGSPGenId,In_CurrentYear) + FGetTimeSheetTaxAddGrossSalary(TMSSGSPGenId,In_CurrentYear)) as In_TaxSalary from
      TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      In_TaxSalary <> 0 do
    if(In_TotalRecord = 1) then
      set In_TaxAmount=Round(In_TotalTaxAmount-Accu_TaxAmount,In_DecimalPlace);
    else
     /* Tax Amount */
      if(In_TotalTaxAmount = 0) then
        set In_TaxAmount=0;       
      else
        set In_TaxAmount=Round(In_TaxSalary/In_TotalTaxSalary*In_TotalTaxAmount,In_DecimalPlace);
        if (In_ID = In_TotalRecord) then
             set In_TaxAmount=Round(In_TotalTaxAmount-Accu_TaxAmount,In_DecimalPlace);
        else
           if(In_TaxAmount+Accu_TaxAmount > In_TotalTaxAmount) then
             set In_TaxAmount=Round(In_TotalTaxAmount-Accu_TaxAmount,In_DecimalPlace);
           end if;
        end if;
      end if;
    end if; 
    set Accu_TaxAmount=Accu_TaxAmount+In_TaxAmount;
    /*
    Update Tax Amount
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = In_TMSTaxAmtDistributeId) then
      if(In_TaxAmount <> 0) then
        call InsertNewTMSDistribute(In_TMSTaxAmtDistributeId,In_TMSSGSPGenId,In_TaxAmount,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute(In_TMSTaxAmtDistributeId,In_TMSSGSPGenId,In_TaxAmount,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then set 
	  Out_TaxErrorCode=In_TaxErrorCode;
      message '   Fail to update ' + In_Message + ' Tax Amount' type info to client;
      return
    end if;
   
  end for;

  set Out_TaxErrorCode=0;
  message '   End ' + In_Message + ' Tax' type info to client;
  commit work;   
END
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeMYTaxAmount') then
   drop PROCEDURE ASQLTimeSheetDistributeMYTaxAmount;
end if;
CREATE PROCEDURE "DBA"."ASQLTimeSheetDistributeMYTaxAmount"(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
out Out_TaxErrorCode integer)
BEGIN
  declare In_TotalPreTaxAmount double;
  declare In_TotalCurTaxAmount double;
  declare Out_ErrorCode integer;
  declare Temp_TaxMethod char(20);
  declare Temp_PreTaxAmt double;
  declare Temp_CurTaxAmt double;
  set Out_TaxErrorCode = 0;

  /*
  Get the Tax Amount for Time Sheet Records only
  */
  select Sum(PreviousTaxAmount), 
    Sum(CurrentTaxAmount) into In_TotalPreTaxAmount,In_TotalCurTaxAmount from PayRecord join PolicyRecord on
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
	
  /* Output Error Code is 1 */   
  call ASQLTimeSheetDistributeIndividualMYTaxAmount(In_EmployeeSysId,In_TMSYear,In_TMSPeriod,In_TotalPreTaxAmount,0,'TsPaidPreTaxAmt',1,'Previous',Out_TaxErrorCode);
  if Out_TaxErrorCode <> 0 then return end if;
  /* Output Error Code is 2 */   
  call ASQLTimeSheetDistributeIndividualMYTaxAmount(In_EmployeeSysId,In_TMSYear,In_TMSPeriod,In_TotalCurTaxAmount,1,'TsPaidCurTaxAmt',2,'Current',Out_TaxErrorCode);  
  
  /* Compute the Tax Benefit */
  select MalTaxMethod into Temp_TaxMethod from MalTaxDetails where PersonalSysId = FGetPersonalSysIdByEmployeeSysId(In_EmployeeSysId);
  if Temp_TaxMethod = 'ERTaxBenefit' then 
    TMSRecordLoop: for TMSRecordFor as TMSRecord_curs dynamic scroll cursor for
    select TMSSGSPGenId as In_TMSSGSPGenId from
      TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod do
      /*
      Update Tax Benefit
      */
      set Temp_PreTaxAmt = 0;
	  set Temp_CurTaxAmt = 0;
	  select CostingAmount into Temp_PreTaxAmt from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsPaidPreTaxAmt';
	  select CostingAmount into Temp_CurTaxAmt from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsPaidCurTaxAmt';
      if not exists(select * from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsTaxBenefit') then 
          call InsertNewTMSDistribute('TsTaxBenefit',In_TMSSGSPGenId,(Temp_PreTaxAmt+Temp_CurTaxAmt),Out_ErrorCode)
      else
        call UpdateTMSDistribute('TsTaxBenefit',In_TMSSGSPGenId,(Temp_PreTaxAmt+Temp_CurTaxAmt),Out_ErrorCode)
      end if;
	  end for;   
  end if;	  

  set Out_TaxErrorCode=0;
  message '   End Tax' type info to client;
  commit work;   
END
;

commit work;