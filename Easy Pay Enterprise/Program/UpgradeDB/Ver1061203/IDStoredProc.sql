IF EXISTS(SELECT * FROM SysViews WHERE viewname='View_Acc_ID_TimeSheet') THEN
    DROP VIEW View_Acc_ID_TimeSheet;
END IF;
create view DBA.View_Acc_ID_TimeSheet
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

   (CASE WHEN _TsTsTKWage IS NULL THEN 0 ELSE _TsTsTKWage END) AS TsTKWage,
   (CASE WHEN _TsTKEEOldAge IS NULL THEN 0 ELSE _TsTKEEOldAge END) AS TsTKEEOldAge,
   (CASE WHEN _TsTkEROldAge IS NULL THEN 0 ELSE _TsTkEROldAge END) AS TsTkEROldAge,
   (CASE WHEN _TsTKERAccident IS NULL THEN 0 ELSE _TsTKERAccident END) AS TsTKERAccident,
   (CASE WHEN _TsTKERDeath IS NULL THEN 0 ELSE _TsTKERDeath END) AS TsTKERDeath,
   (CASE WHEN _TsKesWage IS NULL THEN 0 ELSE _TsKesWage END) AS TsKesWage,
   (CASE WHEN _TsKesEEContri IS NULL THEN 0 ELSE _TsKesEEContri END) AS TsKesEEContri,
   (CASE WHEN _TsKesERContri IS NULL THEN 0 ELSE _TsKesERContri END) AS TsKesERContri,
   (CASE WHEN _TsPensWage IS NULL THEN 0 ELSE _TsPensWage END) AS TsPensWage,
   (CASE WHEN _TsPensEEContri IS NULL THEN 0 ELSE _TsPensEEContri END) AS TsPensEEContri,
   (CASE WHEN _TsPensERContri IS NULL THEN 0 ELSE _TsPensERContri END) AS TsPensERContri,
   (CASE WHEN _TsTaxGross IS NULL THEN 0 ELSE _TsTaxGross END) AS TsTaxGross,
   (CASE WHEN _TsEETaxAmount IS NULL THEN 0 ELSE _TsEETaxAmount END) AS TsEETaxAmount,
   (CASE WHEN _TsERTaxAmount IS NULL THEN 0 ELSE _TsERTaxAmount END) AS TsERTaxAmount,

   (CASE WHEN _TotalAllowance IS NULL THEN 0 ELSE _TotalAllowance END) AS TotalAllowance,
   (CASE WHEN _TotalDeduction IS NULL THEN 0 ELSE _TotalDeduction END) AS TotalDeduction,
   (CASE WHEN _TotalReimbursement IS NULL THEN 0 ELSE _TotalReimbursement END) AS TotalReimbursement,

   (SELECT sum(CurrentCostingAmt+PreviousCostingAmt) FROM TMSLeaveDeduction WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _LeaveDeductionAmt,
   (SELECT sum(CurrentCostingAmt+LastOTCostingAmt+BackPayOTCostingAmt) FROM TMSOvertime WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _OTAmt,
   (SELECT sum(CostingAmount) FROM TMSShift WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _ShiftAmt,

   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsTKWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsTsTKWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsTKEEOldAge' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsTKEEOldAge,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsTkEROldAge' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsTkEROldAge,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsTKERAccident' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsTKERAccident,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsTKERDeath' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsTKERDeath,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsKesWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsKesWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsKesEEContri' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsKesEEContri,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsKesERContri' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsKesERContri,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsPensWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsPensWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsPensEEContri' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsPensEEContri,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsPensERContri' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsPensERContri,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsTaxGross' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsTaxGross,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsEETaxAmount' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsEETaxAmount,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsERTaxAmount' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsERTaxAmount,

   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Allowance' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalAllowance,
   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Deduction' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalDeduction,
   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Reimbursement' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalReimbursement
 
   FROM (TimeSheet LEFT OUTER JOIN TMSDetail) JOIN Employee ON TimeSheet.EmployeeSysID=Employee.EmployeeSysID JOIN JobCode ON JobCode.JobCode=TimeSheet.JobCode
   WHERE
       TimeSheet.EmployeeSysId in (Select EmployeeSysId from DBA.View_TMS_Query);

if exists(select * from sys.sysprocedure where proc_name = 'FGetIndoTaxMethod') then
   drop FUNCTION FGetIndoTaxMethod;
end if;
CREATE FUNCTION "DBA"."FGetIndoTaxMethod"(
In In_PersonalSysId integer
)
returns char(20)
begin
	declare Out_TaxMethod char(20);
	Select IndoTaxMethod into Out_TaxMethod From IndoTaxDetails Where PersonalSysId = In_PersonalSysId;
	return Out_TaxMethod;
end
;

if exists(select * from sys.sysprocedure where proc_name = 'FGetPayPeriodBPJSKesehatanWage') then
   drop FUNCTION FGetPayPeriodBPJSKesehatanWage;
end if;
CREATE FUNCTION "DBA"."FGetPayPeriodBPJSKesehatanWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare BPJSKesehatanWage double;
  declare Out_BPJSKesehatanWage double;
  set BPJSKesehatanWage=0;
  set Out_BPJSKesehatanWage = 0;
  if(IsWageElementInUsed('SubjBPJSKS','BPJSKesehatanWage') = 1) then
    select Sum(AllowanceAmount) into BPJSKesehatanWage from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if BPJSKesehatanWage is not null then
      set Out_BPJSKesehatanWage=Out_BPJSKesehatanWage+BPJSKesehatanWage;
    end if;
    
    select Sum(CurrentOTAmount)+Sum(LastOTAmount)+Sum(BackPayOTAmount) into BPJSKesehatanWage from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if BPJSKesehatanWage is not null then
      set Out_BPJSKesehatanWage=Out_BPJSKesehatanWage+BPJSKesehatanWage;
    end if;

    select Sum(ShiftAmount) into BPJSKesehatanWage from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjBPJSKS') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if BPJSKesehatanWage is not null then
      set Out_BPJSKesehatanWage=Out_BPJSKesehatanWage+BPJSKesehatanWage;
    end if;
  end if;

  if(IsWageElementInUsed('LeaveDeductAmt','BPJSKesehatanWage') = 1) then
    select Sum(CalLveDeductAmt) into BPJSKesehatanWage from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if BPJSKesehatanWage is not null then
      set Out_BPJSKesehatanWage=Out_BPJSKesehatanWage+BPJSKesehatanWage;
    end if;
  end if;

  if(IsWageElementInUsed('BackPay','BPJSKesehatanWage') = 1) then
    select Sum(CalBackPay) into BPJSKesehatanWage from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if BPJSKesehatanWage is not null then
      set Out_BPJSKesehatanWage=Out_BPJSKesehatanWage+BPJSKesehatanWage;
    end if;
  end if;

  if(IsWageElementInUsed('TotalWage','BPJSKesehatanWage') = 1) then
    select Sum(CalTotalWage) into BPJSKesehatanWage from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if BPJSKesehatanWage is not null then
      set Out_BPJSKesehatanWage=Out_BPJSKesehatanWage+BPJSKesehatanWage;
    end if;
  end if;
  return(Out_BPJSKesehatanWage);
end
;

if exists(select * from sys.sysprocedure where proc_name = 'FGetPayPeriodBPJSPensiunWage') then
   drop FUNCTION FGetPayPeriodBPJSPensiunWage;
end if;
CREATE FUNCTION "DBA"."FGetPayPeriodBPJSPensiunWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare BPJSPensiunWage double;
  declare Out_BPJSPensiunWage double;
  set BPJSPensiunWage=0;
  set Out_BPJSPensiunWage = 0;
  if(IsWageElementInUsed('SubjBPJSPensiun','BPJSPensiunWage') = 1) then
    select Sum(AllowanceAmount) into BPJSPensiunWage from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjBPJSPensiun') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if BPJSPensiunWage is not null then
      set Out_BPJSPensiunWage=Out_BPJSPensiunWage+BPJSPensiunWage;
    end if;
    
    select Sum(CurrentOTAmount)+Sum(LastOTAmount)+Sum(BackPayOTAmount) into BPJSPensiunWage from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjBPJSPensiun') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if BPJSPensiunWage is not null then
      set Out_BPJSPensiunWage=Out_BPJSPensiunWage+BPJSPensiunWage;
    end if;

    select Sum(ShiftAmount) into BPJSPensiunWage from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjBPJSPensiun') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if BPJSPensiunWage is not null then
      set Out_BPJSPensiunWage=Out_BPJSPensiunWage+BPJSPensiunWage;
    end if;
  end if;

  if(IsWageElementInUsed('LeaveDeductAmt','BPJSPensiunWage') = 1) then
    select Sum(CalLveDeductAmt) into BPJSPensiunWage from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if BPJSPensiunWage is not null then
      set Out_BPJSPensiunWage=Out_BPJSPensiunWage+BPJSPensiunWage;
    end if;
  end if;

  if(IsWageElementInUsed('BackPay','BPJSPensiunWage') = 1) then
    select Sum(CalBackPay) into BPJSPensiunWage from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if BPJSPensiunWage is not null then
      set Out_BPJSPensiunWage=Out_BPJSPensiunWage+BPJSPensiunWage;
    end if;
  end if;

  if(IsWageElementInUsed('TotalWage','BPJSPensiunWage') = 1) then
    select Sum(CalTotalWage) into BPJSPensiunWage from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if BPJSPensiunWage is not null then
      set Out_BPJSPensiunWage=Out_BPJSPensiunWage+BPJSPensiunWage;
    end if;
  end if;
  return(Out_BPJSPensiunWage);
end
;

if exists(select * from sys.sysprocedure where proc_name = 'FGetPayPeriodBPJSTKWage') then
   drop FUNCTION FGetPayPeriodBPJSTKWage;
end if;
CREATE FUNCTION "DBA"."FGetPayPeriodBPJSTKWage"(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns double
begin
  declare JamsostekWage double;
  declare Out_JamsostekWage double;
  set JamsostekWage=0;
  set Out_JamsostekWage = 0;
  if(IsWageElementInUsed('SubjJamsostek','JamsostekWage') = 1) then
    select Sum(AllowanceAmount) into JamsostekWage from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjJamsostek') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if JamsostekWage is not null then
      set Out_JamsostekWage=Out_JamsostekWage+JamsostekWage;
    end if;
    
    select Sum(CurrentOTAmount)+Sum(LastOTAmount)+Sum(BackPayOTAmount) into JamsostekWage from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,'SubjJamsostek') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if JamsostekWage is not null then
      set Out_JamsostekWage=Out_JamsostekWage+JamsostekWage;
    end if;

    select Sum(ShiftAmount) into JamsostekWage from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,'SubjJamsostek') = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if JamsostekWage is not null then
      set Out_JamsostekWage=Out_JamsostekWage+JamsostekWage;
    end if;
  end if;

  if(IsWageElementInUsed('LeaveDeductAmt','JamsostekWage') = 1) then
    select Sum(CalLveDeductAmt) into JamsostekWage from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if JamsostekWage is not null then
      set Out_JamsostekWage=Out_JamsostekWage+JamsostekWage;
    end if;
  end if;

  if(IsWageElementInUsed('BackPay','JamsostekWage') = 1) then
    select Sum(CalBackPay) into JamsostekWage from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if JamsostekWage is not null then
      set Out_JamsostekWage=Out_JamsostekWage+JamsostekWage;
    end if;
  end if;

  if(IsWageElementInUsed('TotalWage','JamsostekWage') = 1) then
    select Sum(CalTotalWage) into JamsostekWage from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if JamsostekWage is not null then
      set Out_JamsostekWage=Out_JamsostekWage+JamsostekWage;
    end if;
  end if;
  return(Out_JamsostekWage);
end
;

if exists(select * from sys.sysprocedure where proc_name = 'FGetTimeSheetBPJSKesehatanWage') then
   drop FUNCTION FGetTimeSheetBPJSKesehatanWage;
end if;
CREATE FUNCTION "DBA"."FGetTimeSheetBPJSKesehatanWage"(
in In_TMSSGSPGenId char(30))
returns double
Begin
  declare BPJSKesehatanWage double;
  declare Out_BPJSKesehatanWage double;
  set BPJSKesehatanWage=0;
  set Out_BPJSKesehatanWage=0;
  if(IsWageElementInUsed('SubjBPJSKS','BPJSKesehatanWage') = 1) then
    /*
    Pay Element
    */
    select SUM(CostingAmount) into BPJSKesehatanWage
      from TMSAllowance where
      IsFormulaIdHasProperty(FormulaId,'SubjBPJSKS') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSKesehatanWage is not null then
      set Out_BPJSKesehatanWage=Out_BPJSKesehatanWage+BPJSKesehatanWage;
      message '   Pay Element : '+cast(BPJSKesehatanWage as char(20)) type info to client
    end if;
    /*
    OT Amount
    */
    select Sum(CurrentCostingAmt)+Sum(LastOTCostingAmt)+Sum(BackPayOTCostingAmt) into BPJSKesehatanWage
      from TMSOvertime where
      IsFormulaIdHasProperty(FormulaId,'SubjBPJSKS') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSKesehatanWage is not null then
      set Out_BPJSKesehatanWage=Out_BPJSKesehatanWage+BPJSKesehatanWage;
      message '   OT : '+cast(BPJSKesehatanWage as char(20)) type info to client
    end if;
    /*
    Shift Amount
    */
    select Sum(CostingAmount) into BPJSKesehatanWage from
      TMSShift where
      IsFormulaIdHasProperty(FormulaId,'SubjBPJSKS') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSKesehatanWage is not null then
      set Out_BPJSKesehatanWage=Out_BPJSKesehatanWage+BPJSKesehatanWage;
      message '   Shift : '+cast(BPJSKesehatanWage as char(20)) type info to client
    end if
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt','BPJSKesehatanWage') = 1) then
    select Sum(CurrentCostingAmt)+Sum(PreviousCostingAmt) into BPJSKesehatanWage
      from TMSLeaveDeduction where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSKesehatanWage is not null then
      set Out_BPJSKesehatanWage=Out_BPJSKesehatanWage+BPJSKesehatanWage;
      message '   Leave Deduction : '+cast(BPJSKesehatanWage as char(20)) type info to client
    end if
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay','BPJSKesehatanWage') = 1) then
    select Sum(BackPayCostingAmt) into BPJSKesehatanWage
      from TMSDetail where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSKesehatanWage is not null then
      set Out_BPJSKesehatanWage=Out_BPJSKesehatanWage+BPJSKesehatanWage;
      message '   Back Pay : '+cast(BPJSKesehatanWage as char(20)) type info to client
    end if
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage','BPJSKesehatanWage') = 1) then
    select Sum(BasicRateCostingAmt) into BPJSKesehatanWage
      from TMSDetail where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSKesehatanWage is not null then
      set Out_BPJSKesehatanWage=Out_BPJSKesehatanWage+BPJSKesehatanWage;
      message '   Total Wage : '+cast(BPJSKesehatanWage as char(20)) type info to client
    end if
  end if;
  message '   Total BPJS Kesehatan Wage : '+cast(Out_BPJSKesehatanWage as char(20)) type info to client;
  return(Out_BPJSKesehatanWage)
end
;

if exists(select * from sys.sysprocedure where proc_name = 'FGetTimeSheetBPJSPensiunWage') then
   drop FUNCTION FGetTimeSheetBPJSPensiunWage;
end if;
CREATE FUNCTION "DBA"."FGetTimeSheetBPJSPensiunWage"(
in In_TMSSGSPGenId char(30))
returns double
Begin
  declare BPJSPensiunWage double;
  declare Out_BPJSPensiunWage double;
  set BPJSPensiunWage=0;
  set Out_BPJSPensiunWage=0;
  if(IsWageElementInUsed('SubjBPJSPensiun','BPJSPensiunWage') = 1) then
    /*
    Pay Element
    */
    select SUM(CostingAmount) into BPJSPensiunWage
      from TMSAllowance where
      IsFormulaIdHasProperty(FormulaId,'SubjBPJSPensiun') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSPensiunWage is not null then
      set Out_BPJSPensiunWage=Out_BPJSPensiunWage+BPJSPensiunWage;
      message '   Pay Element : '+cast(BPJSPensiunWage as char(20)) type info to client
    end if;
    /*
    OT Amount
    */
    select Sum(CurrentCostingAmt)+Sum(LastOTCostingAmt)+Sum(BackPayOTCostingAmt) into BPJSPensiunWage
      from TMSOvertime where
      IsFormulaIdHasProperty(FormulaId,'SubjBPJSPensiun') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSPensiunWage is not null then
      set Out_BPJSPensiunWage=Out_BPJSPensiunWage+BPJSPensiunWage;
      message '   OT : '+cast(BPJSPensiunWage as char(20)) type info to client
    end if;
    /*
    Shift Amount
    */
    select Sum(CostingAmount) into BPJSPensiunWage from
      TMSShift where
      IsFormulaIdHasProperty(FormulaId,'SubjBPJSPensiun') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSPensiunWage is not null then
      set Out_BPJSPensiunWage=Out_BPJSPensiunWage+BPJSPensiunWage;
      message '   Shift : '+cast(BPJSPensiunWage as char(20)) type info to client
    end if
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt','BPJSPensiunWage') = 1) then
    select Sum(CurrentCostingAmt)+Sum(PreviousCostingAmt) into BPJSPensiunWage
      from TMSLeaveDeduction where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSPensiunWage is not null then
      set Out_BPJSPensiunWage=Out_BPJSPensiunWage+BPJSPensiunWage;
      message '   Leave Deduction : '+cast(BPJSPensiunWage as char(20)) type info to client
    end if
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay','BPJSPensiunWage') = 1) then
    select Sum(BackPayCostingAmt) into BPJSPensiunWage
      from TMSDetail where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSPensiunWage is not null then
      set Out_BPJSPensiunWage=Out_BPJSPensiunWage+BPJSPensiunWage;
      message '   Back Pay : '+cast(BPJSPensiunWage as char(20)) type info to client
    end if
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage','BPJSPensiunWage') = 1) then
    select Sum(BasicRateCostingAmt) into BPJSPensiunWage
      from TMSDetail where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSPensiunWage is not null then
      set Out_BPJSPensiunWage=Out_BPJSPensiunWage+BPJSPensiunWage;
      message '   Total Wage : '+cast(BPJSPensiunWage as char(20)) type info to client
    end if
  end if;
  message '   Total BPJS Pensiun Wage : '+cast(Out_BPJSPensiunWage as char(20)) type info to client;
  return(Out_BPJSPensiunWage)
end
;

if exists(select * from sys.sysprocedure where proc_name = 'FGetTimeSheetBPJSTKWage') then
   drop FUNCTION FGetTimeSheetBPJSTKWage;
end if;
CREATE FUNCTION "DBA"."FGetTimeSheetBPJSTKWage"(
in In_TMSSGSPGenId char(30))
returns double
Begin
  declare BPJSTKWage double;
  declare Out_BPJSTKWage double;
  set BPJSTKWage=0;
  set Out_BPJSTKWage=0;
  if(IsWageElementInUsed('SubjJamsostek','JamsostekWage') = 1) then
    /*
    Pay Element
    */
    select SUM(CostingAmount) into BPJSTKWage
      from TMSAllowance where
      IsFormulaIdHasProperty(FormulaId,'SubjJamsostek') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSTKWage is not null then
      set Out_BPJSTKWage=Out_BPJSTKWage+BPJSTKWage;
      message '   Pay Element : '+cast(BPJSTKWage as char(20)) type info to client
    end if;
    /*
    OT Amount
    */
    select Sum(CurrentCostingAmt)+Sum(LastOTCostingAmt)+Sum(BackPayOTCostingAmt) into BPJSTKWage
      from TMSOvertime where
      IsFormulaIdHasProperty(FormulaId,'SubjJamsostek') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSTKWage is not null then
      set Out_BPJSTKWage=Out_BPJSTKWage+BPJSTKWage;
      message '   OT : '+cast(BPJSTKWage as char(20)) type info to client
    end if;
    /*
    Shift Amount
    */
    select Sum(CostingAmount) into BPJSTKWage from
      TMSShift where
      IsFormulaIdHasProperty(FormulaId,'SubjJamsostek') = 1 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSTKWage is not null then
      set Out_BPJSTKWage=Out_BPJSTKWage+BPJSTKWage;
      message '   Shift : '+cast(BPJSTKWage as char(20)) type info to client
    end if
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt','JamsostekWage') = 1) then
    select Sum(CurrentCostingAmt)+Sum(PreviousCostingAmt) into BPJSTKWage
      from TMSLeaveDeduction where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSTKWage is not null then
      set Out_BPJSTKWage=Out_BPJSTKWage+BPJSTKWage;
      message '   Leave Deduction : '+cast(BPJSTKWage as char(20)) type info to client
    end if
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay','JamsostekWage') = 1) then
    select Sum(BackPayCostingAmt) into BPJSTKWage
      from TMSDetail where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSTKWage is not null then
      set Out_BPJSTKWage=Out_BPJSTKWage+BPJSTKWage;
      message '   Back Pay : '+cast(BPJSTKWage as char(20)) type info to client
    end if
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage','JamsostekWage') = 1) then
    select Sum(BasicRateCostingAmt) into BPJSTKWage
      from TMSDetail where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if BPJSTKWage is not null then
      set Out_BPJSTKWage=Out_BPJSTKWage+BPJSTKWage;
      message '   Total Wage : '+cast(BPJSTKWage as char(20)) type info to client
    end if
  end if;
  message '   Total BPJSTK Wage : '+cast(Out_BPJSTKWage as char(20)) type info to client;
  return(Out_BPJSTKWage)
end
;

if exists(select * from sys.sysprocedure where proc_name = 'FGetTimeSheetTaxGrossSalary') then
   drop FUNCTION FGetTimeSheetTaxGrossSalary;
end if;
CREATE FUNCTION "DBA"."FGetTimeSheetTaxGrossSalary"(
in In_TMSSGSPGenId char(30))
returns double
Begin
  declare TaxGrossSalary double;
  declare Out_TaxGrossSalary double;
  declare Temp_IndoOldAgeOption smallint;
  declare Temp_IndoAccidentOption smallint;
  declare Temp_IndoDeathOption smallint;
  declare Temp_IndoBPJSKSOption smallint;
  declare Temp_IndoBPJSPensiunOption smallint;
  declare Temp_EmployeeSysId integer; 
  set TaxGrossSalary=0;
  set Out_TaxGrossSalary=0;
  set Temp_IndoOldAgeOption=0;
  set Temp_IndoAccidentOption=0;
  set Temp_IndoDeathOption=0;
  set Temp_IndoBPJSKSOption=0;
  set Temp_IndoBPJSPensiunOption=0;
    /*
    Pay Element
    */
    select SUM(CostingAmount) into TaxGrossSalary
      from TMSAllowance where
      IsFormulaIdHasProperty(FormulaId,'NonTaxableCode') = 0 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if TaxGrossSalary is not null then
      set Out_TaxGrossSalary=Out_TaxGrossSalary+TaxGrossSalary;
      message '   Pay Element : '+cast(TaxGrossSalary as char(20)) type info to client
    end if;
    /*
    OT Amount
    */
    select Sum(CurrentCostingAmt)+Sum(LastOTCostingAmt)+Sum(BackPayOTCostingAmt) into TaxGrossSalary
      from TMSOvertime where
      IsFormulaIdHasProperty(FormulaId,'NonTaxableCode') = 0 and
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
      IsFormulaIdHasProperty(FormulaId,'NonTaxableCode') = 0 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if TaxGrossSalary is not null then
      set Out_TaxGrossSalary=Out_TaxGrossSalary+TaxGrossSalary;
      message '   Shift : '+cast(TaxGrossSalary as char(20)) type info to client
    end if;

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
  Back Pay
  */
    select Sum(BackPayCostingAmt) into TaxGrossSalary
      from TMSDetail where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if TaxGrossSalary is not null then
      set Out_TaxGrossSalary=Out_TaxGrossSalary+TaxGrossSalary;
      message '   Back Pay : '+cast(TaxGrossSalary as char(20)) type info to client
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

 Select EmployeeSysId into Temp_EmployeeSysId From TimeSheet Where TMSSGSPGenId = In_TMSSGSPGenId; 
 Select IndoOldAgeOption,IndoAccidentOption,IndoDeathOption,IndoBPJSKSOption,IndoBPJSPensiunOption 
        into Temp_IndoOldAgeOption,Temp_IndoAccidentOption,Temp_IndoDeathOption,Temp_IndoBPJSKSOption,Temp_IndoBPJSPensiunOption
 from IndoTaxDetails join IndoTaxEmployer on IndoTaxDetails.IndoTaxEmployerId = IndoTaxEmployer.IndoTaxEmployerId
 where personalsysid in (select personalsysid from employee where employeesysid = Temp_EmployeeSysId);

 if Temp_IndoOldAgeOption = 1 then
    select Sum(CostingAmount) into TaxGrossSalary 
    from TMSDistribute where 
    TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsTkEROldAge';
    if TaxGrossSalary is not null then
    set Out_TaxGrossSalary=Out_TaxGrossSalary+TaxGrossSalary;
    message '   Employer Old Age : '+cast(TaxGrossSalary as char(20)) type info to client
   end if;
 end if;

 if Temp_IndoAccidentOption = 1 then
    select Sum(CostingAmount) into TaxGrossSalary 
    from TMSDistribute where 
    TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsTKERAccident';
    if TaxGrossSalary is not null then
    set Out_TaxGrossSalary=Out_TaxGrossSalary+TaxGrossSalary;
    message '   Employer Accident : '+cast(TaxGrossSalary as char(20)) type info to client
   end if;
 end if;

 if Temp_IndoDeathOption = 1 then
    select Sum(CostingAmount) into TaxGrossSalary 
    from TMSDistribute where 
    TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsTKERDeath';
    if TaxGrossSalary is not null then
    set Out_TaxGrossSalary=Out_TaxGrossSalary+TaxGrossSalary;
    message '   Employer Death : '+cast(TaxGrossSalary as char(20)) type info to client
   end if;
 end if;

 if Temp_IndoBPJSKSOption = 1 then
    select Sum(CostingAmount) into TaxGrossSalary 
    from TMSDistribute where 
    TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsKesERContri';
    if TaxGrossSalary is not null then
    set Out_TaxGrossSalary=Out_TaxGrossSalary+TaxGrossSalary;
    message '   Employer BPJS Kesehatan : '+cast(TaxGrossSalary as char(20)) type info to client
   end if;
 end if;

 if Temp_IndoBPJSPensiunOption = 1 then
    select Sum(CostingAmount) into TaxGrossSalary 
    from TMSDistribute where 
    TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsPensERContri';
    if TaxGrossSalary is not null then
    set Out_TaxGrossSalary=Out_TaxGrossSalary+TaxGrossSalary;
    message '   Employer BPJS Pensiun : '+cast(TaxGrossSalary as char(20)) type info to client
   end if;
 end if;
  
  set Out_TaxGrossSalary = Round(Out_TaxGrossSalary,0); 
  message '   Total Tax Gross Salary : '+cast(Out_TaxGrossSalary as char(20)) type info to client;
  return(Out_TaxGrossSalary)
end
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeBPJSKesehatan') then
   drop PROCEDURE ASQLTimeSheetDistributeBPJSKesehatan;
end if;
CREATE PROCEDURE "DBA"."ASQLTimeSheetDistributeBPJSKesehatan"(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
out Out_BPJSKesehatanErrorCode integer)
BEGIN
  declare In_TotalBPJSKesehatanWage double;
  declare In_PayPeriodBPJSKesWage double;
  declare In_TotalEEContri double;
  declare In_TotalERContri double;
  declare Accu_BPJSKesehatanWage integer;
  declare Accu_EEContri double;
  declare Accu_ERContri double;
  declare In_BPJSKesehatanWage integer;
  declare In_EEContri double;
  declare In_ERContri double;
  declare Out_ErrorCode integer;
  declare In_TotalRecord integer;
  declare In_TSRecord integer;
  declare In_DecimalPlace integer;
  set In_DecimalPlace=0;

  /*
  Get the BPJS Kesehatan Contribution for Time Sheet Records only
  */
  select Sum(CurrEEManWage),
    FGetPayPeriodBPJSKesehatanWage(PayRecord.EmployeeSysId,PayRecord.PayRecYear,PayRecord.PayRecPeriod),
    Sum(CurrEEManContri),
    Sum(CurrERManContri) into In_TotalBPJSKesehatanWage,
    In_PayPeriodBPJSKesWage,
    In_TotalEEContri,
    In_TotalERContri from PayRecord join PolicyRecord on
    (PayRecord.PayRecYear = PolicyRecord.PayRecYear and
    PayRecord.PayRecPeriod = PolicyRecord.PayRecPeriod and
    PayRecord.PayRecSubPeriod = PolicyRecord.PayRecSubPeriod and
    PayRecord.PayRecID = PolicyRecord.PayRecID and
    PayRecord.EmployeeSysId = PolicyRecord.EmployeeSysId) where
    PayRecord.EmployeeSysId = In_EmployeeSysId and
    PayRecord.PayRecYear = In_TMSYear and
    PayRecord.PayRecPeriod = In_TMSPeriod and
    (PayRecord.PayRecType = 'RegularTimeSheetPay' or PayRecord.PayRecType = 'AdHocTimeSheetPay')
    group by PayRecord.EmployeeSysId,PayRecord.PayRecYear,PayRecord.PayRecPeriod;
  if In_TotalBPJSKesehatanWage is null then set In_TotalBPJSKesehatanWage=0
  end if;
  if In_TotalEEContri is null then set In_TotalEEContri=0
  end if;
  if In_TotalERContri is null then set In_TotalERContri=0
  end if;
  message '   BPJS Kesehatan Wage  : '+cast(In_TotalBPJSKesehatanWage as char(20)) type info to client;
  message '   EE Contribution      : '+cast(In_TotalEEContri as char(20)) type info to client;
  message '   ER Contribution      : '+cast(In_TotalERContri as char(20)) type info to client;
  /*
  No BPJS Kesehatan Contribution
  */
  if(In_TotalEEContri = 0 and
     In_TotalERContri = 0) then
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsKesWage' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod);
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsKesEEContri' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod);
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsKesERContri' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod); 
    message '   No BPJS Kesehatan Contribution' type info to client;
    set Out_BPJSKesehatanErrorCode=0;
    commit work;
    return 
  end if; 

  /*
  Count for Time Sheet Record
  */
  select Count(*) into In_TSRecord from
      TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod;
  /*
  Distribute BPJS Kesehatan Wage
  */
  message ' Distribute BPJS Kesehatan Wage' type info to client;
  set Accu_BPJSKesehatanWage = 0;
  BPJSKesWageLoop: for BPJSKesWageFor as BPJSKesWage_curs dynamic scroll cursor for
    select Number(*) as In_ID, 
      TMSSGSPGenId as In_TMSSGSPGenId,
      FGetTimeSheetBPJSKesehatanWage(TMSSGSPGenId) as Temp_BPJSKesehatanWage from
      TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod do
    /*
    Compute BPJS Kesehatan Wage for each Time Sheet
    */
    if(In_PayPeriodBPJSKesWage =0) then
       set In_BPJSKesehatanWage = 0;
    else
       set In_BPJSKesehatanWage = Round(Temp_BPJSKesehatanWage/In_PayPeriodBPJSKesWage*In_TotalBPJSKesehatanWage,In_DecimalPlace);
       if (In_ID = In_TSRecord) then
          set In_BPJSKesehatanWage=Round(In_TotalBPJSKesehatanWage-Accu_BPJSKesehatanWage,In_DecimalPlace);
       else
          if(In_BPJSKesehatanWage+Accu_BPJSKesehatanWage > In_TotalBPJSKesehatanWage) then
             set In_BPJSKesehatanWage=Round(In_TotalBPJSKesehatanWage-Accu_BPJSKesehatanWage,In_DecimalPlace);
           end if;
       end if;        
    end if;

    set Accu_BPJSKesehatanWage = Accu_BPJSKesehatanWage + In_BPJSKesehatanWage;
  
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsKesWage') then
      if(In_BPJSKesehatanWage <> 0) then        
        call InsertNewTMSDistribute('TsKesWage',In_TMSSGSPGenId,In_BPJSKesehatanWage,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsKesWage',In_TMSSGSPGenId,In_BPJSKesehatanWage,Out_ErrorCode)
    end if;

    /*
    If Successful Insert and Update Store Procedure return 1
    */
    if(Out_ErrorCode <> 1) then
      set Out_BPJSKesehatanErrorCode=1;
      message '   Fail to update BPJS Kesehatan Wage' type info to client;
      return
    end if;
  end for;

  /*
  Count for BPJS Kesehatan Records 
  */
  select Count(*) into In_TotalRecord from
    TimeSheet join TMSDistribute where EmployeeSysId = In_EmployeeSysId and
    TMSYear = In_TMSYear and
    TMSPeriod = In_TMSPeriod and
    TMSDistributeId = 'TsKesWage';
  /*
  Distribute EE/ER Contribution
  */
  message ' Distribute BPJS Kesehatan' type info to client;
  set Accu_EEContri=0;
  set Accu_ERContri=0;
  BPJSKesLoop: for BPJSKesFor as BPJSKes_curs dynamic scroll cursor for
    select Number(*) as In_ID, 
      TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId,
      CostingAmount as Temp_BPJSKesehatanWage from
      TimeSheet join TMSDistribute where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSDistributeId = 'TsKesWage' do
    if(In_TotalRecord = 1) then
      set In_EEContri=Round(In_TotalEEContri-Accu_EEContri,In_DecimalPlace);
      set In_ERContri=Round(In_TotalERContri-Accu_ERContri,In_DecimalPlace);
    else
     /* EE Contribution */
      if(In_TotalEEContri = 0) then
        set In_EEContri=0
      else
        set In_EEContri=Round(Temp_BPJSKesehatanWage/In_TotalBPJSKesehatanWage*In_TotalEEContri,In_DecimalPlace);
        if (In_ID = In_TotalRecord) then
             set In_EEContri=Round(In_TotalEEContri-Accu_EEContri,In_DecimalPlace)
        else
           if(In_EEContri+Accu_EEContri > In_TotalEEContri) then
             set In_EEContri=Round(In_TotalEEContri-Accu_EEContri,In_DecimalPlace)
           end if;
        end if;
      end if;

     /* ER Contribution */
      if(In_TotalERContri = 0) then
        set In_ERContri=0
      else
        set In_ERContri=Round(Temp_BPJSKesehatanWage/In_TotalBPJSKesehatanWage*In_TotalERContri,In_DecimalPlace);
        if (In_ID = In_TotalRecord) then
             set In_ERContri=Round(In_TotalERContri-Accu_ERContri,In_DecimalPlace);
        else 
           if(In_ERContri+Accu_ERContri > In_TotalERContri) then
             set In_ERContri=Round(In_TotalERContri-Accu_ERContri,In_DecimalPlace);
           end if;
        end if;
      end if;

    end if;
    set Accu_EEContri=Accu_EEContri+In_EEContri;
    set Accu_ERContri=Accu_ERContri+In_ERContri;
    /*
    Update EE Contribution
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsKesEEContri') then
      if(In_EEContri <> 0) then
        call InsertNewTMSDistribute('TsKesEEContri',In_TMSSGSPGenId,In_EEContri,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsKesEEContri',In_TMSSGSPGenId,In_EEContri,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then set
        Out_BPJSKesehatanErrorCode=2;
      message '   Fail to update EE Contribution' type info to client;
      return
    end if;
    /*
    Update ER Contribution
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsKesERContri') then
      if(In_ERContri <> 0) then
        call InsertNewTMSDistribute('TsKesERContri',In_TMSSGSPGenId,In_ERContri,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsKesERContri',In_TMSSGSPGenId,In_ERContri,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then
      set Out_BPJSKesehatanErrorCode=3;
      message '   Fail to update ER Contribution' type info to client;
      return
    end if;

  end for;

  set Out_BPJSKesehatanErrorCode=0;
  message '   End BPJS Kesehatan' type info to client;
  commit work;   
END
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeBPJSPensiun') then
   drop PROCEDURE ASQLTimeSheetDistributeBPJSPensiun;
end if;
CREATE PROCEDURE "DBA"."ASQLTimeSheetDistributeBPJSPensiun"(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
out Out_BPJSPensiunErrorCode integer)
BEGIN
  declare In_TotalBPJSPensiunWage double;
  declare In_PayPeriodBPJSPensWage double;
  declare In_TotalEEContri double;
  declare In_TotalERContri double;
  declare Accu_BPJSPensWage integer;
  declare Accu_EEContri double;
  declare Accu_ERContri double;
  declare In_BPJSPensWage integer;
  declare In_EEContri double;
  declare In_ERContri double;
  declare Out_ErrorCode integer;
  declare In_TotalRecord integer;
  declare In_TSRecord integer;
  declare In_DecimalPlace integer;
  set In_DecimalPlace=0;

  /*
  Get the BPJS Pensiun Contribution for Time Sheet Records only
  */
  select Sum(CurrEEVolWage),
    FGetPayPeriodBPJSPensiunWage(PayRecord.EmployeeSysId,PayRecord.PayRecYear,PayRecord.PayRecPeriod),
	Sum(CurrEEVolContri),
    Sum(CurrERVolContri) into In_TotalBPJSPensiunWage,
    In_PayPeriodBPJSPensWage,
    In_TotalEEContri,
    In_TotalERContri from PayRecord join PolicyRecord on
    (PayRecord.PayRecYear = PolicyRecord.PayRecYear and
    PayRecord.PayRecPeriod = PolicyRecord.PayRecPeriod and
    PayRecord.PayRecSubPeriod = PolicyRecord.PayRecSubPeriod and
    PayRecord.PayRecID = PolicyRecord.PayRecID and
    PayRecord.EmployeeSysId = PolicyRecord.EmployeeSysId) where
    PayRecord.EmployeeSysId = In_EmployeeSysId and
    PayRecord.PayRecYear = In_TMSYear and
    PayRecord.PayRecPeriod = In_TMSPeriod and
    (PayRecord.PayRecType = 'RegularTimeSheetPay' or PayRecord.PayRecType = 'AdHocTimeSheetPay')
    group by PayRecord.EmployeeSysId,PayRecord.PayRecYear,PayRecord.PayRecPeriod;
  if In_TotalBPJSPensiunWage is null then set In_TotalBPJSPensiunWage=0
  end if;
  if In_TotalEEContri is null then set In_TotalEEContri=0
  end if;
  if In_TotalERContri is null then set In_TotalERContri=0
  end if;
  message '   BPJS Pensiun Wage  : '+cast(In_TotalBPJSPensiunWage as char(20)) type info to client;
  message '   EE Contribution  : '+cast(In_TotalEEContri as char(20)) type info to client;
  message '   ER Contribution  : '+cast(In_TotalERContri as char(20)) type info to client;
  /*
  No BPJS Pensiun Contribution
  */
  if(In_TotalEEContri = 0 and
     In_TotalERContri = 0) then
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsPensWage' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod);
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsPensEEContri' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod);
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsPensERContri' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod); 
    message '   No BPJS Pensiun Contribution' type info to client;
    set Out_BPJSPensiunErrorCode=0;
    commit work;
    return 
  end if; 

  /*
  Count for Time Sheet Record
  */
  select Count(*) into In_TSRecord from
      TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod;
  /*
  Distribute BPJS Pensiun Wage
  */
  message ' Distribute BPJS Pensiun Wage' type info to client;
  set Accu_BPJSPensWage = 0;
  BPJSPensWageLoop: for BPJSPensWageFor as BPJSPensWage_curs dynamic scroll cursor for
    select Number(*) as In_ID, 
      TMSSGSPGenId as In_TMSSGSPGenId,
      FGetTimeSheetBPJSPensiunWage(TMSSGSPGenId) as Temp_BPJSPensiunWage from
      TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod do
    /*
    Compute BPJS Pensiun Wage for each Time Sheet
    */
    if(In_PayPeriodBPJSPensWage =0) then
       set In_BPJSPensWage = 0;
    else
       set In_BPJSPensWage = Round(Temp_BPJSPensiunWage/In_PayPeriodBPJSPensWage*In_TotalBPJSPensiunWage,In_DecimalPlace);
       if (In_ID = In_TSRecord) then
           set In_BPJSPensWage=Round(In_TotalBPJSPensiunWage-Accu_BPJSPensWage,In_DecimalPlace);
       else   
          if(In_BPJSPensWage+Accu_BPJSPensWage > In_TotalBPJSPensiunWage) then
             set In_BPJSPensWage=Round(In_TotalBPJSPensiunWage-Accu_BPJSPensWage,In_DecimalPlace);
          end if;
       end if;        
    end if;

    set Accu_BPJSPensWage = Accu_BPJSPensWage + In_BPJSPensWage;

    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsPensWage') then
      if(In_BPJSPensWage <> 0) then
        call InsertNewTMSDistribute('TsPensWage',In_TMSSGSPGenId,In_BPJSPensWage,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsPensWage',In_TMSSGSPGenId,In_BPJSPensWage,Out_ErrorCode)
    end if;

    /*
    If Successful Insert and Update Store Procedure return 1
    */
    if(Out_ErrorCode <> 1) then
      set Out_BPJSPensiunErrorCode=1;
      message '   Fail to update BPJS Pensiun Wage' type info to client;
      return
    end if;
  end for;

  /*
  Count for BPJS Pensiun Records 
  */
  select Count(*) into In_TotalRecord from
    TimeSheet join TMSDistribute where EmployeeSysId = In_EmployeeSysId and
    TMSYear = In_TMSYear and
    TMSPeriod = In_TMSPeriod and
    TMSDistributeId = 'TsPensWage';
  /*
  Distribute EE/ER Contribution
  */
  message ' Distribute BPJS Pensiun' type info to client;
  set Accu_EEContri=0;
  set Accu_ERContri=0;
  BPJSPensLoop: for BPJSPensFor as BPJSPens_curs dynamic scroll cursor for
    select Number(*) as In_ID, 
      TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId,
      CostingAmount as Temp_BPJSPensWage from
      TimeSheet join TMSDistribute where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSDistributeId = 'TsPensWage' do
    if(In_TotalRecord = 1) then
      set In_EEContri=Round(In_TotalEEContri-Accu_EEContri,In_DecimalPlace);
      set In_ERContri=Round(In_TotalERContri-Accu_ERContri,In_DecimalPlace);
    else
     /* EE Contribution */
      if(In_TotalEEContri = 0) then
        set In_EEContri=0
      else
        set In_EEContri=Round(Temp_BPJSPensWage/In_TotalBPJSPensiunWage*In_TotalEEContri,In_DecimalPlace);
        if (In_ID = In_TotalRecord) then
            set In_EEContri=Round(In_TotalEEContri-Accu_EEContri,In_DecimalPlace);
        else 
           if(In_EEContri+Accu_EEContri > In_TotalEEContri) then
             set In_EEContri=Round(In_TotalEEContri-Accu_EEContri,In_DecimalPlace);
           end if;
         end if;
      end if;

     /* ER Contribution */
      if(In_TotalERContri = 0) then
        set In_ERContri=0
      else
        set In_ERContri=Round(Temp_BPJSPensWage/In_TotalBPJSPensiunWage*In_TotalERContri,In_DecimalPlace);
        if (In_ID = In_TotalRecord) then
            set In_ERContri=Round(In_TotalERContri-Accu_ERContri,In_DecimalPlace);
        else   
            if(In_ERContri+Accu_ERContri > In_TotalERContri) then
              set In_ERContri=Round(In_TotalERContri-Accu_ERContri,In_DecimalPlace);
            end if;
        end if;
      end if;

    end if;
    set Accu_EEContri=Accu_EEContri+In_EEContri;
    set Accu_ERContri=Accu_ERContri+In_ERContri;
    /*
    Update EE Contribution
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsPensEEContri') then
      if(In_EEContri <> 0) then
        call InsertNewTMSDistribute('TsPensEEContri',In_TMSSGSPGenId,In_EEContri,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsPensEEContri',In_TMSSGSPGenId,In_EEContri,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then set
        Out_BPJSPensiunErrorCode=2;
      message '   Fail to update EE Contribution' type info to client;
      return
    end if;
    /*
    Update ER Contribution
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsPensERContri') then
      if(In_ERContri <> 0) then
        call InsertNewTMSDistribute('TsPensERContri',In_TMSSGSPGenId,In_ERContri,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsPensERContri',In_TMSSGSPGenId,In_ERContri,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then
      set Out_BPJSPensiunErrorCode=3;
      message '   Fail to update ER Contribution' type info to client;
      return
    end if;

  end for;

  set Out_BPJSPensiunErrorCode=0;
  message '   End BPJS Pensiun' type info to client;
  commit work;   
END
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeBPJSTK') then
   drop PROCEDURE ASQLTimeSheetDistributeBPJSTK;
end if;
CREATE PROCEDURE "DBA"."ASQLTimeSheetDistributeBPJSTK"(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
out Out_BPJSTKErrorCode integer)
BEGIN
  declare In_TotalBPJSTKWage double;
  declare In_PayPeriodBPJSTKWage double;
  declare In_TotalEEOldAge double;
  declare In_TotalEROldAge double;
  declare In_TotalERAccident double;
  declare In_TotalERDeath double;
  declare Accu_BPJSTKWage double;
  declare Accu_EEOldAge double;
  declare Accu_EROldAge double;
  declare Accu_ERAccident double;
  declare Accu_ERDeath double;
  declare In_BPJSTKWage double;
  declare In_EEOldAge double;
  declare In_EROldAge double;
  declare In_ERAccident double;
  declare In_ERDeath double;
  declare Out_ErrorCode integer;
  declare In_TotalRecord integer;
  declare In_TSRecord integer;
  declare In_DecimalPlace integer;
  set In_DecimalPlace=0;

  /*
  Get the BPJSTK Contribution for Time Sheet Records only
  */
  select Sum(CPFWage),
    FGetPayPeriodBPJSTKWage(PayRecord.EmployeeSysId,PayRecord.PayRecYear,PayRecord.PayRecPeriod),
    Sum(ContriOrdEECPF),Sum(ContriOrdERCPF),
    Sum(ContriAddEECPF),Sum(ContriAddERCPF) into In_TotalBPJSTKWage,
    In_PayPeriodBPJSTKWage,
    In_TotalEEOldAge,
    In_TotalEROldAge,
    In_TotalERAccident,
    In_TotalERDeath from PayRecord join PolicyRecord on
    (PayRecord.PayRecYear = PolicyRecord.PayRecYear and
    PayRecord.PayRecPeriod = PolicyRecord.PayRecPeriod and
    PayRecord.PayRecSubPeriod = PolicyRecord.PayRecSubPeriod and
    PayRecord.PayRecID = PolicyRecord.PayRecID and
    PayRecord.EmployeeSysId = PolicyRecord.EmployeeSysId) where
    PayRecord.EmployeeSysId = In_EmployeeSysId and
    PayRecord.PayRecYear = In_TMSYear and
    PayRecord.PayRecPeriod = In_TMSPeriod and
    (PayRecord.PayRecType = 'RegularTimeSheetPay' or PayRecord.PayRecType = 'AdHocTimeSheetPay')
	group by PayRecord.EmployeeSysId,PayRecord.PayRecYear,PayRecord.PayRecPeriod;

  if In_TotalBPJSTKWage is null then set In_TotalBPJSTKWage=0
  end if;
  if In_TotalEEOldAge is null then set In_TotalEEOldAge=0
  end if;
  if In_TotalEROldAge is null then set In_TotalEROldAge=0
  end if;
  if In_TotalERAccident is null then set In_TotalERAccident=0
  end if;
  if In_TotalERDeath is null then set In_TotalERDeath=0
  end if;
  message '   BPJSTK Wage  : '+cast(In_TotalBPJSTKWage as char(20)) type info to client;
  message '   EE Old Age  : '+cast(In_TotalEEOldAge as char(20)) type info to client;
  message '   ER Old Age  : '+cast(In_TotalEROldAge as char(20)) type info to client;
  message '   ER Accident : '+cast(In_TotalERAccident as char(20)) type info to client;
  message '   ER Death    : '+cast(In_TotalERDeath as char(20)) type info to client; 
  /*
  No BPJSTK Contribution
  */
  if(In_TotalEEOldAge = 0 and
     In_TotalEROldAge = 0 and
     In_TotalERAccident = 0 and
     In_TotalERDeath = 0) then
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsTKWage' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod);
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsTKEEOldAge' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod);
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsTkEROldAge' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod); 
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsTKERAccident' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod); 
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsTKERDeath' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod);
    message '   No BPJSTK Contribution' type info to client;
    set Out_BPJSTKErrorCode=0;
    commit work;
    return 
  end if; 
  /*
  Count for Time Sheet Record
  */
  select Count(*) into In_TSRecord from
      TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod;

  /*
  Distribute BPJSTK Wage
  */
  message ' Distribute BPJSTK Wage' type info to client;
  set Accu_BPJSTKWage = 0;
  BPJSTKWageLoop: for BPJSTKWageFor as BPJSTKWage_curs dynamic scroll cursor for
    select Number(*) as In_ID, 
      TMSSGSPGenId as In_TMSSGSPGenId,
      FGetTimeSheetBPJSTKWage(TMSSGSPGenId) as Temp_BPJSTKWage from
      TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod do
    /*
    Compute BPJSTK Wage for each Time Sheet
    */
    if(In_PayPeriodBPJSTKWage =0) then
       set In_BPJSTKWage = 0;
    else
       set In_BPJSTKWage = Round(Temp_BPJSTKWage/In_PayPeriodBPJSTKWage*In_TotalBPJSTKWage,In_DecimalPlace);
       if (In_ID = In_TSRecord) then
          set In_BPJSTKWage=Round(In_TotalBPJSTKWage-Accu_BPJSTKWage,In_DecimalPlace);
       else 
          if(In_BPJSTKWage+Accu_BPJSTKWage > In_TotalBPJSTKWage) then
             set In_BPJSTKWage=Round(In_TotalBPJSTKWage-Accu_BPJSTKWage,In_DecimalPlace);
          end if; 
        end if;       
    end if;

    set Accu_BPJSTKWage = Accu_BPJSTKWage + In_BPJSTKWage;

	
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsTKWage') then
      if(In_BPJSTKWage <> 0) then
        call InsertNewTMSDistribute('TsTKWage',In_TMSSGSPGenId,In_BPJSTKWage,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsTKWage',In_TMSSGSPGenId,In_BPJSTKWage,Out_ErrorCode)
    end if;
    /*
    If Successful Insert and Update Store Procedure return 1
    */
    if(Out_ErrorCode <> 1) then
      set Out_BPJSTKErrorCode=1;
      message '   Fail to update BPJSTK Wage' type info to client;
      return
    end if;
  end for;
  /*
  Count for BPJSTK Records 
  */
  select Count(*) into In_TotalRecord from
    TimeSheet join TMSDistribute where EmployeeSysId = In_EmployeeSysId and
    TMSYear = In_TMSYear and
    TMSPeriod = In_TMSPeriod and
    TMSDistributeId = 'TsTKWage';
  /*
  Distribute EE/ER Old Age, ER Accident & ER Death
  */
  message ' Distribute BPJSTK' type info to client;
  set Accu_EEOldAge=0;
  set Accu_EROldAge=0;
  set Accu_ERAccident=0;
  set Accu_ERDeath=0;
  BPJSTKLoop: for BPJSTKFor as BPJSTK_curs dynamic scroll cursor for
    select Number(*) as In_ID, 
      TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId,
      CostingAmount as Temp_BPJSTKWage from
      TimeSheet join TMSDistribute where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSDistributeId = 'TsTKWage' do
    if(In_TotalRecord = 1) then
      set In_EEOldAge=Round(In_TotalEEOldAge-Accu_EEOldAge,In_DecimalPlace);
      set In_EROldAge=Round(In_TotalEROldAge-Accu_EROldAge,In_DecimalPlace);
      set In_ERAccident=Round(In_TotalERAccident-Accu_ERAccident,In_DecimalPlace);
      set In_ERDeath=Round(In_TotalERDeath-Accu_ERDeath,In_DecimalPlace);
    else
     /* EE Old Age */
      if(In_TotalEEOldAge = 0) then
        set In_EEOldAge=0
      else
        set In_EEOldAge=Round(Temp_BPJSTKWage/In_TotalBPJSTKWage*In_TotalEEOldAge,In_DecimalPlace);
        if(In_EEOldAge+Accu_EEOldAge > In_TotalEEOldAge) then
          set In_EEOldAge=Round(In_TotalEEOldAge-Accu_EEOldAge,In_DecimalPlace)
        end if
      end if;

     /* ER Old Age */
      if(In_TotalEROldAge = 0) then
        set In_EROldAge=0
      else
        set In_EROldAge=Round(Temp_BPJSTKWage/In_TotalBPJSTKWage*In_TotalEROldAge,In_DecimalPlace);
        if (In_ID = In_TotalRecord) then
           set In_EROldAge=Round(In_TotalEROldAge-Accu_EROldAge,In_DecimalPlace);
        else   
           if(In_EROldAge+Accu_EROldAge > In_TotalEROldAge) then
             set In_EROldAge=Round(In_TotalEROldAge-Accu_EROldAge,In_DecimalPlace);
           end if;
        end if;
      end if;

     /* ER Accident */
      if(In_TotalERAccident = 0) then
        set In_ERAccident=0
      else
        set In_ERAccident=Round(Temp_BPJSTKWage/In_TotalBPJSTKWage*In_TotalERAccident,In_DecimalPlace);
        if (In_ID = In_TotalRecord) then
             set In_ERAccident=Round(In_TotalERAccident-Accu_ERAccident,In_DecimalPlace);
        else
           if(In_ERAccident+Accu_ERAccident > In_TotalERAccident) then
             set In_ERAccident=Round(In_TotalERAccident-Accu_ERAccident,In_DecimalPlace);
           end if;
        end if;
      end if;

     /* ER Death */
      if(In_TotalERDeath = 0) then
        set In_ERDeath=0
      else
        set In_ERDeath=Round(Temp_BPJSTKWage/In_TotalBPJSTKWage*In_TotalERDeath,In_DecimalPlace);
        if (In_ID = In_TotalRecord) then
           set In_ERDeath=Round(In_TotalERDeath-Accu_ERDeath,In_DecimalPlace);
        else
           if(In_ERDeath+Accu_ERDeath > In_TotalERDeath) then
             set In_ERDeath=Round(In_TotalERDeath-Accu_ERDeath,In_DecimalPlace);
           end if;
        end if;
      end if;

    end if;
    set Accu_EEOldAge=Accu_EEOldAge+In_EEOldAge;
    set Accu_EROldAge=Accu_EROldAge+In_EROldAge;
    set Accu_ERAccident=Accu_ERAccident+In_ERAccident;
    set Accu_ERDeath=Accu_ERDeath+In_ERDeath;
    /*
    Update EE Old Age
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsTKEEOldAge') then
      if(In_EEOldAge <> 0) then
        call InsertNewTMSDistribute('TsTKEEOldAge',In_TMSSGSPGenId,In_EEOldAge,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsTKEEOldAge',In_TMSSGSPGenId,In_EEOldAge,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then set
        Out_BPJSTKErrorCode=2;
      message '   Fail to update EE Old Age' type info to client;
      return
    end if;
    /*
    Update ER Old Age
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsTkEROldAge') then
      if(In_EROldAge <> 0) then
        call InsertNewTMSDistribute('TsTkEROldAge',In_TMSSGSPGenId,In_EROldAge,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsTkEROldAge',In_TMSSGSPGenId,In_EROldAge,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then
      set Out_BPJSTKErrorCode=3;
      message '   Fail to update ER Old Age' type info to client;
      return
    end if;
    /*
    Update EE Accident
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsTKERAccident') then
      if(In_ERAccident <> 0) then
        call InsertNewTMSDistribute('TsTKERAccident',In_TMSSGSPGenId,In_ERAccident,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsTKERAccident',In_TMSSGSPGenId,In_ERAccident,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then set
        Out_BPJSTKErrorCode=4;
      message '   Fail to update ER Accident' type info to client;
      return
    end if;
    /*
    Update ER Death
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsTKERDeath') then
      if(In_ERDeath <> 0) then
        call InsertNewTMSDistribute('TsTKERDeath',In_TMSSGSPGenId,In_ERDeath,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsTKERDeath',In_TMSSGSPGenId,In_ERDeath,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then
      set Out_BPJSTKErrorCode=5;
      message '   Fail to update ER Death' type info to client;
      return
    end if; 
  end for;

  set Out_BPJSTKErrorCode=0;
  message '   End BPJSTK' type info to client;
  commit work;   
END;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeTaxAmount') then
   drop PROCEDURE ASQLTimeSheetDistributeTaxAmount;
end if;
CREATE PROCEDURE "DBA"."ASQLTimeSheetDistributeTaxAmount"(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
out Out_TaxAmountErrorCode integer)
BEGIN
  declare In_TotalTaxGrossSalary double;
  declare In_TotalEETaxAmt double;
  declare In_TotalERTaxAmt double;
  declare Accu_EETaxAmt double;
  declare Accu_ERTaxAmt double;
  declare In_EETaxAmt double;
  declare In_ERAmt double;
  declare Out_ErrorCode integer;
  declare In_TotalRecord integer;
  declare In_DecimalPlace integer;
  set In_DecimalPlace=0;

  /*
  Get the Tax Contribution for Time Sheet Records only
  */
  select (Case FGetIndoTaxMethod(FGetPersonalSysIdByEmployeeSysId(PayRecord.EmployeeSysId)) when 'GrossToNet' then Sum(CurAdditionalWage) else 0 end),
    (Case FGetIndoTaxMethod(FGetPersonalSysIdByEmployeeSysId(PayRecord.EmployeeSysId)) when 'GrossToNet' then 0 else Sum(CurAdditionalWage) end) into In_TotalEETaxAmt,
    In_TotalERTaxAmt from PayRecord join PolicyRecord on
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
  if In_TotalEETaxAmt is null then set In_TotalEETaxAmt=0
  end if;
  if In_TotalERTaxAmt is null then set In_TotalERTaxAmt=0
  end if;
  message '   EE Tax Amount      : '+cast(In_TotalEETaxAmt as char(20)) type info to client;
  message '   ER Tax Amount      : '+cast(In_TotalERTaxAmt as char(20)) type info to client;
  /*
  No Tax Amount
  */
  if(In_TotalEETaxAmt = 0 and
     In_TotalERTaxAmt = 0) then
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsTaxGross' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod);
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsEETaxAmount' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod);
     update TMSDistribute set CostingAmount = 0 
     where TMSDistributeId = 'TsERTaxAmount' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
       EmployeeSysId = In_EmployeeSysId and
       TMSYear = In_TMSYear and
       TMSPeriod = In_TMSPeriod); 
    message '   No Tax Amount' type info to client;
    set Out_TaxAmountErrorCode=0;
    commit work;
    return 
  end if;
 
  /*
  Distribute Tax Gross Salary
  */
  message ' Distribute Tax Gross Salary' type info to client;
  set In_TotalTaxGrossSalary = 0;
  TaxGrossSalaryLoop: for TaxGrossSalaryFor as TaxGrossSalary_curs dynamic scroll cursor for
    select TMSSGSPGenId as In_TMSSGSPGenId,
      FGetTimeSheetTaxGrossSalary(TMSSGSPGenId) as In_TaxGrossSalary from
      TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod do
   
    /*
    Compute Tax Gross Salary for each Time Sheet
    */ 
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsTaxGross') then
      if(In_TaxGrossSalary <> 0) then        
        call InsertNewTMSDistribute('TsTaxGross',In_TMSSGSPGenId,In_TaxGrossSalary,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsTaxGross',In_TMSSGSPGenId,In_TaxGrossSalary,Out_ErrorCode)
    end if;
    /*
    If Successful Insert and Update Store Procedure return 1
    */
    if(Out_ErrorCode <> 1) then
      set Out_TaxAmountErrorCode=1;
      message '   Fail to update Tax Gross Salary' type info to client;
      return
    end if;
    set In_TotalTaxGrossSalary=In_TotalTaxGrossSalary+In_TaxGrossSalary;
  end for;
  
  /*
  Count for Tax Gross Salary Records 
  */
  select Count(*) into In_TotalRecord from
    TimeSheet join TMSDistribute where EmployeeSysId = In_EmployeeSysId and
    TMSYear = In_TMSYear and
    TMSPeriod = In_TMSPeriod and
    TMSDistributeId = 'TsTaxGross';
  /*
  Distribute EE/ER Tax Amount
  */
  message ' Distribute EE/ER Tax Amount' type info to client;
  set Accu_EETaxAmt=0;
  set Accu_ERTaxAmt=0;
  TaxAmtLoop: for TaxAmtFor as TaxAmt_curs dynamic scroll cursor for
    select Number(*) as In_ID, 
      TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId,
      CostingAmount as In_TaxGrossSalary from
      TimeSheet join TMSDistribute where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSDistributeId = 'TsTaxGross' do
    if(In_TotalRecord = 1) then
      set In_EETaxAmt=Round(In_TotalEETaxAmt-Accu_EETaxAmt,In_DecimalPlace);
      set In_ERAmt=Round(In_TotalERTaxAmt-Accu_ERTaxAmt,In_DecimalPlace);
    else
     /* EE Tax Amount */
      if(In_TotalEETaxAmt = 0) then
        set In_EETaxAmt=0
      else
        set In_EETaxAmt=Round(In_TaxGrossSalary/In_TotalTaxGrossSalary*In_TotalEETaxAmt,In_DecimalPlace);
        if (In_ID = In_TotalRecord) then
             set In_EETaxAmt=Round(In_TotalEETaxAmt-Accu_EETaxAmt,In_DecimalPlace);
        else
           if(In_EETaxAmt+Accu_EETaxAmt > In_TotalEETaxAmt) then
             set In_EETaxAmt=Round(In_TotalEETaxAmt-Accu_EETaxAmt,In_DecimalPlace);
           end if;
        end if;
      end if;

     /* ER Tax Amount */
      if(In_TotalERTaxAmt = 0) then
        set In_ERAmt=0
      else
        set In_ERAmt=Round(In_TaxGrossSalary/In_TotalTaxGrossSalary*In_TotalERTaxAmt,In_DecimalPlace);
        if (In_ID = In_TotalRecord) then
            set In_ERAmt=Round(In_TotalERTaxAmt-Accu_ERTaxAmt,In_DecimalPlace);
        else      
            if(In_ERAmt+Accu_ERTaxAmt > In_TotalERTaxAmt) then
              set In_ERAmt=Round(In_TotalERTaxAmt-Accu_ERTaxAmt,In_DecimalPlace);
            end if;
        end if;
      end if;

    end if;
    set Accu_EETaxAmt=Accu_EETaxAmt+In_EETaxAmt;
    set Accu_ERTaxAmt=Accu_ERTaxAmt+In_ERAmt;
    /*
    Update EE Tax Amount
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsEETaxAmount') then
      if(In_EETaxAmt <> 0) then
        call InsertNewTMSDistribute('TsEETaxAmount',In_TMSSGSPGenId,In_EETaxAmt,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsEETaxAmount',In_TMSSGSPGenId,In_EETaxAmt,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then set
        Out_TaxAmountErrorCode=2;
      message '   Fail to update EE Tax Amount' type info to client;
      return
    end if;
    /*
    Update ER Tax Amount
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsERTaxAmount') then
      if(In_ERAmt <> 0) then
        call InsertNewTMSDistribute('TsERTaxAmount',In_TMSSGSPGenId,In_ERAmt,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsERTaxAmount',In_TMSSGSPGenId,In_ERAmt,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then
      set Out_TaxAmountErrorCode=3;
      message '   Fail to update ER Tax Amount' type info to client;
      return
    end if;

  end for;

  set Out_TaxAmountErrorCode=0;
  message '   End Tax' type info to client;
  commit work;   
END
;

commit work;