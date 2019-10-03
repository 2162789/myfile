IF EXISTS(SELECT * FROM SysViews WHERE viewname='View_Acc_MY_TimeSheet') THEN
    DROP VIEW View_Acc_MY_TimeSheet;
END IF;
create view DBA.View_Acc_MY_TimeSheet
as
  SELECT
   TimeSheet.TMSSGSPGenID, 

   TMSYear, 
   TMSPeriod,
   TMSSubPeriod, 
   TMSPayRecId, 
   TMSType,
   TMSDate,

   TMSProjectId,
   TimeSheet.JobCode,
   TMSCostCentreId,
   JobCodeRefNo,
   JobCodeDesc,

   EmployeeID,
   EmployeeName,
   HireDate,
   CessationDate,
   BranchId,
   CategoryId,
   DepartmentId,

   TMSPaymentType,
   (SELECT CurrentBasicRateType FROM PayEmployee WHERE EmployeeSysId=TimeSheet.EmployeeSysId) AS CurrentSalaryType,
   TMSBRDayHourRate,
   TMSWorkingDayHour,
   Description AS TMSDescription,
   BasicRateCostingAmt,
   BackPayCostingAmt,

   (CASE WHEN _LeaveDeductionAmt IS NULL THEN 0 ELSE _LeaveDeductionAmt END) AS LeaveDeductionAmt,
   (CASE WHEN _OTAmt IS NULL THEN 0 ELSE _OTAmt END) AS OTAmt,
   (CASE WHEN _ShiftAmt IS NULL THEN 0 ELSE _ShiftAmt END) AS ShiftAmt,

   (CASE WHEN _TsCurEEManEPFWage IS NULL THEN 0 ELSE _TsCurEEManEPFWage END) AS TsCurEEManEPFWage,
   (CASE WHEN _TsEECurManEPF IS NULL THEN 0 ELSE _TsEECurManEPF END) AS TsEECurManEPF,
   (CASE WHEN _TsCurERManEPFWage IS NULL THEN 0 ELSE _TsCurERManEPFWage END) AS TsCurERManEPFWage,
   (CASE WHEN _TsERCurManEPF IS NULL THEN 0 ELSE _TsERCurManEPF END) AS TsERCurManEPF,
   (CASE WHEN _TsPreEEManEPFWage IS NULL THEN 0 ELSE _TsPreEEManEPFWage END) AS TsPreEEManEPFWage,
   (CASE WHEN _TsEEPreManEPF IS NULL THEN 0 ELSE _TsEEPreManEPF END) AS TsEEPreManEPF,
   (CASE WHEN _TsPreERManEPFWage IS NULL THEN 0 ELSE _TsPreERManEPFWage END) AS TsPreERManEPFWage,
   (CASE WHEN _TsERPreManEPF IS NULL THEN 0 ELSE _TsERPreManEPF END) AS TsERPreManEPF,
   (CASE WHEN _TsCurEEVolEPFWage IS NULL THEN 0 ELSE _TsCurEEVolEPFWage END) AS TsCurEEVolEPFWage,
   (CASE WHEN _TsEECurVolEPF IS NULL THEN 0 ELSE _TsEECurVolEPF END) AS TsEECurVolEPF,
   (CASE WHEN _TsCurERVolEPFWage IS NULL THEN 0 ELSE _TsCurERVolEPFWage END) AS TsCurERVolEPFWage,
   (CASE WHEN _TsERCurVolEPF IS NULL THEN 0 ELSE _TsERCurVolEPF END) AS TsERCurVolEPF,
   (CASE WHEN _TsPreEEVolEPFWage IS NULL THEN 0 ELSE _TsPreEEVolEPFWage END) AS TsPreEEVolEPFWage,
   (CASE WHEN _TsEEPreVolEPF IS NULL THEN 0 ELSE _TsEEPreVolEPF END) AS TsEEPreVolEPF,
   (CASE WHEN _TsPreERVolEPFWage IS NULL THEN 0 ELSE _TsPreERVolEPFWage END) AS TsPreERVolEPFWage,
   (CASE WHEN _TsERPreVolEPF IS NULL THEN 0 ELSE _TsERPreVolEPF END) AS TsERPreVolEPF,
   (CASE WHEN _TsSOCSOWage IS NULL THEN 0 ELSE _TsSOCSOWage END) AS TsSOCSOWage,
   (CASE WHEN _TsEESOCSO IS NULL THEN 0 ELSE _TsEESOCSO END) AS TsEESOCSO,
   (CASE WHEN _TsERSOCSO IS NULL THEN 0 ELSE _TsERSOCSO END) AS TsERSOCSO,
   (CASE WHEN _TsHRDLevy IS NULL THEN 0 ELSE _TsHRDLevy END) AS TsHRDLevy,
   (CASE WHEN _TsPaidPreTaxAmt IS NULL THEN 0 ELSE _TsPaidPreTaxAmt END) AS TsPaidPreTaxAmt,
   (CASE WHEN _TsPaidCurTaxAmt IS NULL THEN 0 ELSE _TsPaidCurTaxAmt END) AS TsPaidCurTaxAmt,
   (CASE WHEN _TsTaxBenefit IS NULL THEN 0 ELSE _TsTaxBenefit END) AS TsTaxBenefit,

   (CASE WHEN _TotalAllowance IS NULL THEN 0 ELSE _TotalAllowance END) AS TotalAllowance,
   (CASE WHEN _TotalDeduction IS NULL THEN 0 ELSE _TotalDeduction END) AS TotalDeduction,
   (CASE WHEN _TotalReimbursement IS NULL THEN 0 ELSE _TotalReimbursement END) AS TotalReimbursement,

   (SELECT sum(CurrentCostingAmt+PreviousCostingAmt) FROM TMSLeaveDeduction WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _LeaveDeductionAmt,
   (SELECT sum(CurrentCostingAmt+LastOTCostingAmt+BackPayOTCostingAmt) FROM TMSOvertime WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _OTAmt,
   (SELECT sum(CostingAmount) FROM TMSShift WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _ShiftAmt,

   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsCurEEManEPFWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsCurEEManEPFWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsEECurManEPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsEECurManEPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsCurERManEPFWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsCurERManEPFWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsERCurManEPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsERCurManEPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsPreEEManEPFWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsPreEEManEPFWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsEEPreManEPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsEEPreManEPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsPreERManEPFWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsPreERManEPFWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsERPreManEPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsERPreManEPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsCurEEVolEPFWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsCurEEVolEPFWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsEECurVolEPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsEECurVolEPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsCurERVolEPFWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsCurERVolEPFWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsERCurVolEPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsERCurVolEPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsPreEEVolEPFWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsPreEEVolEPFWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsEEPreVolEPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsEEPreVolEPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsPreERVolEPFWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsPreERVolEPFWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsERPreVolEPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsERPreVolEPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsSOCSOWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsSOCSOWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsEESOCSO' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsEESOCSO,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsERSOCSO' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsERSOCSO,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsHRDLevy' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsHRDLevy,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsPaidPreTaxAmt' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsPaidPreTaxAmt,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsPaidCurTaxAmt' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsPaidCurTaxAmt,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsTaxBenefit' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsTaxBenefit,

   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Allowance' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalAllowance,
   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Deduction' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalDeduction,
   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Reimbursement' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalReimbursement
 
   FROM (TimeSheet LEFT OUTER JOIN TMSDetail) JOIN Employee ON TimeSheet.EmployeeSysID=Employee.EmployeeSysID JOIN JobCode ON JobCode.JobCode=TimeSheet.JobCode
   WHERE
       TimeSheet.EmployeeSysId in (Select EmployeeSysId from DBA.View_TMS_Query);

if exists(select * from sys.sysprocedure where proc_name = 'FGetTimeSheetEPFWage') then
   drop FUNCTION FGetTimeSheetEPFWage;
end if;
CREATE FUNCTION "DBA"."FGetTimeSheetEPFWage"(
in In_TMSSGSPGenId char(30),
in In_EPFWageType char(20))
returns double
Begin
  declare In_SubjectString char(20);
  declare EPFWage double;
  declare Out_EPFWage double;
  declare In_TMSPayPeriod int;
  declare In_OutputMessage char(100); 
  set EPFWage=0;
  set Out_EPFWage=0;
  select TMSPeriod into In_TMSPayPeriod from TimeSheet Where TMSSGSPGenId = In_TMSSGSPGenId;
  case In_EPFWageType when 'CurrEEManEPFWage' then
    set In_SubjectString='SubjEEManEPF';
    set In_OutputMessage='Current Employee Mandatory EPF Wage'; when 'CurrERManEPFWage' then
    set In_SubjectString='SubjERManEPF';
    set In_OutputMessage='Current Employer Mandatory EPF Wage'; when 'CurrEEVolEPFWage' then
    set In_SubjectString='SubjEEVolEPF'; 
    set In_OutputMessage='Current Employee Voluntary EPF Wage'; when 'CurrERVolEPFWage' then
    set In_SubjectString='SubjERVolEPF';
    set In_OutputMessage='Current Employer Voluntary EPF Wage'; when 'PrevEEManEPFWage' then
    set In_SubjectString='SubjEEManEPF'; 
    set In_OutputMessage='Previous Employee Mandatory EPF Wage'; when 'PrevERManEPFWage' then
    set In_SubjectString='SubjERManEPF'; 
    set In_OutputMessage='Previous Employer Mandatory EPF Wage'; when 'PrevEEVolEPFWage' then
    set In_SubjectString='SubjEEVolEPF'; 
    set In_OutputMessage='Previous Employee Voluntary EPF Wage'; when 'PrevERVolEPFWage' then
    set In_SubjectString='SubjERVolEPF';
    set In_OutputMessage='Previous Employer Voluntary EPF Wage';
  else
    return
  end case
  ;
  if(IsWageElementInUsed(In_SubjectString,In_EPFWageType) = 1) then
    /*
    Pay Element, OT and Shift Amount only applicable to Current
    */
    if(In_EPFWageType = 'CurrEEManEPFWage' or
      In_EPFWageType = 'CurrERManEPFWage' or
      In_EPFWageType = 'CurrEEVolEPFWage' or
      In_EPFWageType = 'CurrERVolEPFWage') then
    /*
    Pay Element
    */
    select SUM(CostingAmount) into EPFWage 
      from TMSAllowance where
      IsFormulaIdHasProperty(FormulaId,In_SubjectString) = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if EPFWage is not null then
      set Out_EPFWage=Out_EPFWage+EPFWage;
      message '   Pay Element : '+cast(EPFWage as char(20)) type info to client
    end if;
    /*
    OT Amount
    */
    select Sum(CurrentCostingAmt)+Sum(LastOTCostingAmt) into EPFWage
      from TMSOvertime where
      IsFormulaIdHasProperty(FormulaId,In_SubjectString) = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if EPFWage is not null then
      set Out_EPFWage=Out_EPFWage+EPFWage;
      message '   OT : '+cast(EPFWage as char(20)) type info to client
    end if;
    /*
    Shift Amount
    */
    select Sum(CostingAmount) into EPFWage from
        TMSShift where
        IsFormulaIdHasProperty(FormulaId,In_SubjectString) = 1 and
        TMSSGSPGenId = In_TMSSGSPGenId;
    end if;
    if EPFWage is not null then
      set Out_EPFWage=Out_EPFWage+EPFWage;
      message '   Shift : '+cast(EPFWage as char(20)) type info to client
    end if;
  end if;
  /*
  OT Back Pay Amount Only applicable to Period 1 if Previous 
  */
  if((In_TMSPayPeriod > 1 and
    (In_EPFWageType = 'CurrEEManEPFWage' or
    In_EPFWageType = 'CurrERManEPFWage' or
    In_EPFWageType = 'CurrEEVolEPFWage' or
    In_EPFWageType = 'CurrERVolEPFWage')) or
    (In_TMSPayPeriod = 1 and
    (In_EPFWageType = 'PrevEEManEPFWage' or
    In_EPFWageType = 'PrevERManEPFWage' or
    In_EPFWageType = 'PrevEEVolEPFWage' or
    In_EPFWageType = 'PrevERVolEPFWage'))) then
      select Sum(BackPayOTCostingAmt) into EPFWage
        from TMSOvertime where
        IsFormulaIdHasProperty(FormulaId,In_SubjectString) = 1 and
        TMSSGSPGenId = In_TMSSGSPGenId;
      if EPFWage is not null then
        set Out_EPFWage=Out_EPFWage+EPFWage;
        message '   OT Back Pay : '+cast(EPFWage as char(20)) type info to client
      end if;
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt',In_EPFWageType) = 1) then
    select Sum(CurrentCostingAmt)+Sum(PreviousCostingAmt) into EPFWage
      from TMSLeaveDeduction where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if EPFWage is not null then
      set Out_EPFWage=Out_EPFWage+EPFWage;
      message '   Leave Deduction : '+cast(EPFWage as char(20)) type info to client
    end if;
  end if;
  /*
  Back Pay Only applicable to Period 1 if Previous 
  */
  if((In_TMSPayPeriod > 1 and
    (In_EPFWageType = 'CurrEEManEPFWage' or
    In_EPFWageType = 'CurrERManEPFWage' or
    In_EPFWageType = 'CurrEEVolEPFWage' or
    In_EPFWageType = 'CurrERVolEPFWage')) or
    (In_TMSPayPeriod = 1 and
    (In_EPFWageType = 'PrevEEManEPFWage' or
    In_EPFWageType = 'PrevERManEPFWage' or
    In_EPFWageType = 'PrevEEVolEPFWage' or
    In_EPFWageType = 'PrevERVolEPFWage'))) then
    if(IsWageElementInUsed('BackPay',In_EPFWageType) = 1) then
      select Sum(BackPayCostingAmt) into EPFWage
        from TMSDetail where
        TMSSGSPGenId = In_TMSSGSPGenId;
      if EPFWage is not null then
        set Out_EPFWage=Out_EPFWage+EPFWage;
        message '   Back Pay : '+cast(EPFWage as char(20)) type info to client
      end if;
    end if;
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage',In_EPFWageType) = 1) then
    select Sum(BasicRateCostingAmt) into EPFWage
      from TMSDetail where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if EPFWage is not null then
      set Out_EPFWage=Out_EPFWage+EPFWage;
      message '   Total Wage : '+cast(EPFWage as char(20)) type info to client
    end if;
  end if;
  message '   ' + In_OutputMessage + ' : '+cast(Out_EPFWage as char(20)) type info to client;
  return(Out_EPFWage)
end
;

if exists(select * from sys.sysprocedure where proc_name = 'FGetTimeSheetSOCSOWage') then
   drop FUNCTION FGetTimeSheetSOCSOWage;
end if;
CREATE FUNCTION "DBA"."FGetTimeSheetSOCSOWage"(
in In_TMSSGSPGenId char(30))
returns double
Begin
  declare SOCSOWage double;
  declare Out_SOCSOWage double;
  set SOCSOWage=0;
  set Out_SOCSOWage=0;
  if(IsWageElementInUsed('SubjSOCSO','SOCSOWage') = 1) then
    /*
    Pay Element
    */
    select SUM(CostingAmount) into SOCSOWage
      from TMSAllowance where
      IsFormulaIdHasProperty(FormulaId,'SubjSOCSO') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if SOCSOWage is not null then
      set Out_SOCSOWage=Out_SOCSOWage+SOCSOWage;
      message '   Pay Element : '+cast(SOCSOWage as char(20)) type info to client
    end if;
    /*
    OT Amount
    */
    select Sum(CurrentCostingAmt)+Sum(LastOTCostingAmt)+Sum(BackPayOTCostingAmt) into SOCSOWage
      from TMSOvertime where
      IsFormulaIdHasProperty(FormulaId,'SubjSOCSO') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if SOCSOWage is not null then
      set Out_SOCSOWage=Out_SOCSOWage+SOCSOWage;
      message '   OT : '+cast(SOCSOWage as char(20)) type info to client
    end if;
    /*
    Shift Amount
    */
    select Sum(CostingAmount) into SOCSOWage from
      TMSShift where
      IsFormulaIdHasProperty(FormulaId,'SubjSOCSO') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if SOCSOWage is not null then
      set Out_SOCSOWage=Out_SOCSOWage+SOCSOWage;
      message '   Shift : '+cast(SOCSOWage as char(20)) type info to client
    end if
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt','SOCSOWage') = 1) then
    select Sum(CurrentCostingAmt)+Sum(PreviousCostingAmt) into SOCSOWage
      from TMSLeaveDeduction where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if SOCSOWage is not null then
      set Out_SOCSOWage=Out_SOCSOWage+SOCSOWage;
      message '   Leave Deduction : '+cast(SOCSOWage as char(20)) type info to client
    end if
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay','SOCSOWage') = 1) then
    select Sum(BackPayCostingAmt) into SOCSOWage
      from TMSDetail where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if SOCSOWage is not null then
      set Out_SOCSOWage=Out_SOCSOWage+SOCSOWage;
      message '   Back Pay : '+cast(SOCSOWage as char(20)) type info to client
    end if
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage','SOCSOWage') = 1) then
    select Sum(BasicRateCostingAmt) into SOCSOWage
      from TMSDetail where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if SOCSOWage is not null then
      set Out_SOCSOWage=Out_SOCSOWage+SOCSOWage;
      message '   Total Wage : '+cast(SOCSOWage as char(20)) type info to client
    end if
  end if;
  message '   Total SOCSO Wage : '+cast(Out_SOCSOWage as char(20)) type info to client;
  return(Out_SOCSOWage)
end
;

if exists(select * from sys.sysprocedure where proc_name = 'FGetTimeSheetTaxGrossSalary') then
   drop FUNCTION FGetTimeSheetTaxGrossSalary;
end if;
CREATE FUNCTION "DBA"."FGetTimeSheetTaxGrossSalary"(
in In_TMSSGSPGenId char(30),
in In_CurrentYear smallint)
returns double
Begin
  declare TaxGrossSalary double;
  declare Out_TaxGrossSalary double;
  declare Temp_EmployeeSysId integer; 
  declare Temp_TMSYear integer;
  declare Temp_TMSPeriod integer;
  set TaxGrossSalary=0;
  set Out_TaxGrossSalary=0;
  select EmployeeSysId, TMSYear, TMSPeriod into Temp_EmployeeSysId, Temp_TMSYear,Temp_TMSPeriod from TimeSheet where TMSSGSPGenId = In_TMSSGSPGenId;
   
  /* Only applicable for current year */
  if In_CurrentYear = 1 then 
     /*
     Leave Deduction
     */
     select Sum(CurrentCostingAmt)+Sum(PreviousCostingAmt) into TaxGrossSalary
       from TMSLeaveDeduction where
       TMSSGSPGenId = In_TMSSGSPGenId;
     if TaxGrossSalary is not null then
       set Out_TaxGrossSalary=Out_TaxGrossSalary+TaxGrossSalary;
       message '   Leave Deduction : '+cast(TaxGrossSalary as char(20)) type info to client
     end if;

     /*
     Total Wage
     */
     select Sum(BasicRateCostingAmt) into TaxGrossSalary
      from TMSDetail where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if TaxGrossSalary is not null then
      set Out_TaxGrossSalary=Out_TaxGrossSalary+TaxGrossSalary;
      message '   Total Wage : '+cast(TaxGrossSalary as char(20)) type info to client
    end if;

    /*
    OT Amount
    */
    select Sum(CurrentCostingAmt)+Sum(LastOTCostingAmt) into TaxGrossSalary
      from TMSOvertime where
      IsFormulaIdHasProperty(FormulaId,'SubjTaxAddWage') = 0 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if TaxGrossSalary is not null then
      set Out_TaxGrossSalary=Out_TaxGrossSalary+TaxGrossSalary;
      message '   OT : '+cast(TaxGrossSalary as char(20)) type info to client
    end if;

    /*
    Shift Amount
    */
    select Sum(CostingAmount) into TaxGrossSalary from
      TMSShift where
      IsFormulaIdHasProperty(FormulaId,'SubjTaxAddWage') = 0 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if TaxGrossSalary is not null then
      set Out_TaxGrossSalary=Out_TaxGrossSalary+TaxGrossSalary;
      message '   Shift : '+cast(TaxGrossSalary as char(20)) type info to client
    end if;

    /*
    Pay Element
    */
    select SUM(CostingAmount) into TaxGrossSalary
      from TMSAllowance where
      IsFormulaIdHasProperty(FormulaId,'SubjTaxAddWage') = 0 and
      IsFormulaIdHasProperty(FormulaId,'NonTaxableCode') = 0 and
      IsFormulaIdHasProperty(FormulaId,'ZakatCode') = 0 and
      IsFormulaIdHasProperty(FormulaId,'EPFDedCode') = 0 and
      IsFormulaIdHasProperty(FormulaId,'SOCSODedCode') = 0 and
      IsFormulaIdHasProperty(FormulaId,'WP39Code') = 0 and
      IsFormulaIdHasProperty(FormulaId,'CP38Code') = 0 and
      IsFormulaIdHasProperty(FormulaId,'LevyCode') = 0 and
      IsMalAllowanceHasRebateProperty(Temp_EmployeeSysId, Temp_TMSYear, FormulaId) = 0 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if TaxGrossSalary is not null then
      set Out_TaxGrossSalary=Out_TaxGrossSalary+TaxGrossSalary;
      message '   Pay Element : '+cast(TaxGrossSalary as char(20)) type info to client
    end if;

  end if; 

  /*
  OT BackPay Amount
  */
  if ((In_CurrentYear = 1 and Temp_TMSYear > 2009 and Temp_TMSPeriod = 1) or
     (In_CurrentYear = 0 and Temp_TMSYear = 2009 and Temp_TMSPeriod > 1)) then
  else
    select Sum(BackPayOTCostingAmt) into TaxGrossSalary
      from TMSOvertime where
      IsFormulaIdHasProperty(FormulaId,'SubjTaxAddWage') = 0 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if TaxGrossSalary is not null then
      set Out_TaxGrossSalary=Out_TaxGrossSalary+TaxGrossSalary;
      message '   OT Back Pay : '+cast(TaxGrossSalary as char(20)) type info to client
    end if;      
  end if;  

  set Out_TaxGrossSalary = Round(Out_TaxGrossSalary,0); 
  message '   Total Tax Gross Salary : '+cast(Out_TaxGrossSalary as char(20)) type info to client;
  return(Out_TaxGrossSalary)
end
;

if exists(select * from sys.sysprocedure where proc_name = 'FGetTimeSheetTaxAddGrossSalary') then
   drop PROCEDURE FGetTimeSheetTaxAddGrossSalary;
end if;
CREATE FUNCTION "DBA"."FGetTimeSheetTaxAddGrossSalary"(
in In_TMSSGSPGenId char(30),
in In_CurrentYear smallint)
returns double
Begin
  declare TaxAddGrossSalary double;
  declare Out_TaxAddGrossSalary double;
  declare Temp_TMSYear integer;
  declare Temp_TMSPeriod integer;
  set TaxAddGrossSalary=0;
  set Out_TaxAddGrossSalary=0;
  select TMSYear, TMSPeriod into Temp_TMSYear,Temp_TMSPeriod from TimeSheet where TMSSGSPGenId = In_TMSSGSPGenId;

  /* Only applicable for current year */
  if In_CurrentYear = 1 then 
    /*
    OT Amount
    */
    select Sum(CurrentCostingAmt)+Sum(LastOTCostingAmt) into TaxAddGrossSalary
      from TMSOvertime where
      IsFormulaIdHasProperty(FormulaId,'SubjTaxAddWage') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if TaxAddGrossSalary is not null then
      set Out_TaxAddGrossSalary=Out_TaxAddGrossSalary+TaxAddGrossSalary;
      message '   OT : '+cast(TaxAddGrossSalary as char(20)) type info to client
    end if;

    /*
    Shift Amount
    */
    select Sum(CostingAmount) into TaxAddGrossSalary from
      TMSShift where
      IsFormulaIdHasProperty(FormulaId,'SubjTaxAddWage') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if TaxAddGrossSalary is not null then
      set Out_TaxAddGrossSalary=Out_TaxAddGrossSalary+TaxAddGrossSalary;
      message '   Shift : '+cast(TaxAddGrossSalary as char(20)) type info to client
    end if;

    /*
    Pay Element
    */
    select SUM(CostingAmount) into TaxAddGrossSalary
      from TMSAllowance where
      IsFormulaIdHasProperty(FormulaId,'SubjTaxAddWage') = 1 and
      IsFormulaIdHasProperty(FormulaId,'NonTaxableCode') = 0 and
      IsFormulaIdHasProperty(FormulaId,'ZakatCode') = 0 and
      IsFormulaIdHasProperty(FormulaId,'EPFDedCode') = 0 and
      IsFormulaIdHasProperty(FormulaId,'SOCSODedCode') = 0 and
      IsFormulaIdHasProperty(FormulaId,'WP39Code') = 0 and
      IsFormulaIdHasProperty(FormulaId,'CP38Code') = 0 and
      IsFormulaIdHasProperty(FormulaId,'LevyCode') = 0 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if TaxAddGrossSalary is not null then
      set Out_TaxAddGrossSalary=Out_TaxAddGrossSalary+TaxAddGrossSalary;
      message '   Pay Element : '+cast(TaxAddGrossSalary as char(20)) type info to client
    end if;

  end if;   

  /*
  Back Pay
  */
  if In_CurrentYear = 1 then 
     if (Temp_TMSYear > 2009 and Temp_TMSPeriod = 1) then
     else 
       select Sum(BackPayCostingAmt) into TaxAddGrossSalary
         from TMSDetail where
         TMSSGSPGenId = In_TMSSGSPGenId;
       if TaxAddGrossSalary is not null then
         set Out_TaxAddGrossSalary=Out_TaxAddGrossSalary+TaxAddGrossSalary;
         message '   Back Pay : '+cast(TaxAddGrossSalary as char(20)) type info to client
       end if; 
      end if;
  else
     if (Temp_TMSYear > 2009 and Temp_TMSPeriod = 1) then
       select Sum(BackPayCostingAmt) into TaxAddGrossSalary
         from TMSDetail where
         TMSSGSPGenId = In_TMSSGSPGenId;
       if TaxAddGrossSalary is not null then
         set Out_TaxAddGrossSalary=Out_TaxAddGrossSalary+TaxAddGrossSalary;
         message '   Back Pay : '+cast(TaxAddGrossSalary as char(20)) type info to client
       end if;         
     end if;
  end if;

  /*
  OT BackPay Amount
  */
  if ((In_CurrentYear = 1 and Temp_TMSYear > 2009 and Temp_TMSPeriod = 1) or
     (In_CurrentYear = 0 and Temp_TMSYear = 2009 and Temp_TMSPeriod > 1)) then
  else
    select Sum(BackPayOTCostingAmt) into TaxAddGrossSalary
      from TMSOvertime where
      IsFormulaIdHasProperty(FormulaId,'SubjTaxAddWage') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if TaxAddGrossSalary is not null then
      set Out_TaxAddGrossSalary=Out_TaxAddGrossSalary+TaxAddGrossSalary;
      message '   OT Back Pay : '+cast(TaxAddGrossSalary as char(20)) type info to client
    end if;      
  end if;    
  
  set Out_TaxAddGrossSalary = Round(Out_TaxAddGrossSalary,0); 
  message '   Total Tax Additional Gross Salary : '+cast(Out_TaxAddGrossSalary as char(20)) type info to client;
  return(Out_TaxAddGrossSalary)
end
;

commit work;