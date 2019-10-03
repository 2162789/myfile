If exists(Select viewname From SysViews Where viewname='View_Acc_SG_TimeSheet') Then
    ALTER VIEW "DBA"."View_Acc_SG_TimeSheet"
AS
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

   (CASE WHEN _TsCurOrdCPFWage IS NULL THEN 0 ELSE _TsCurOrdCPFWage END) AS TsCurOrdCPFWage,
   (CASE WHEN _TsEECurOrdCPF IS NULL THEN 0 ELSE _TsEECurOrdCPF END) AS TsEECurOrdCPF,
   (CASE WHEN _TsERCurOrdCPF IS NULL THEN 0 ELSE _TsERCurOrdCPF END) AS TsERCurOrdCPF,
   (CASE WHEN _TsAddOrdCPFWage IS NULL THEN 0 ELSE _TsAddOrdCPFWage END) AS TsAddOrdCPFWage,
   (CASE WHEN _TsEEAddOrdCPF IS NULL THEN 0 ELSE _TsEEAddOrdCPF END) AS TsEEAddOrdCPF,
   (CASE WHEN _TsERAddOrdCPF IS NULL THEN 0 ELSE _TsERAddOrdCPF END) AS TsERAddOrdCPF,
   (CASE WHEN _TsSDF IS NULL THEN 0 ELSE _TsSDF END) AS TsSDF,
   (CASE WHEN _TsFWL IS NULL THEN 0 ELSE _TsFWL END) AS TsFWL,

   (CASE WHEN _TotalAllowance IS NULL THEN 0 ELSE _TotalAllowance END) AS TotalAllowance,
   (CASE WHEN _TotalDeduction IS NULL THEN 0 ELSE _TotalDeduction END) AS TotalDeduction,
   (CASE WHEN _TotalReimbursement IS NULL THEN 0 ELSE _TotalReimbursement END) AS TotalReimbursement,

   (SELECT sum(CurrentCostingAmt+PreviousCostingAmt) FROM TMSLeaveDeduction WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _LeaveDeductionAmt,
   (SELECT sum(CurrentCostingAmt+LastOTCostingAmt+BackPayOTCostingAmt) FROM TMSOvertime WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _OTAmt,
   (SELECT sum(CostingAmount) FROM TMSShift WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _ShiftAmt,

   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsCurOrdCPFWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsCurOrdCPFWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsEECurOrdCPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsEECurOrdCPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsERCurOrdCPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsERCurOrdCPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsCurAddCPFWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsAddOrdCPFWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsEECurAddCPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsEEAddOrdCPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsERCurAddCPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsERAddOrdCPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsSDF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsSDF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsFWL' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsFWL,

   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Allowance' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalAllowance,
   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Deduction' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalDeduction,
   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Reimbursement' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalReimbursement
 
   FROM (TimeSheet LEFT OUTER JOIN TMSDetail) JOIN Employee ON TimeSheet.EmployeeSysID=Employee.EmployeeSysID JOIN JobCode ON JobCode.JobCode=TimeSheet.JobCode
   WHERE
       TimeSheet.EmployeeSysId in (Select EmployeeSysId from DBA.View_TMS_Query);
else
   CREATE VIEW "DBA"."View_Acc_SG_TimeSheet"
AS
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

   (CASE WHEN _TsCurOrdCPFWage IS NULL THEN 0 ELSE _TsCurOrdCPFWage END) AS TsCurOrdCPFWage,
   (CASE WHEN _TsEECurOrdCPF IS NULL THEN 0 ELSE _TsEECurOrdCPF END) AS TsEECurOrdCPF,
   (CASE WHEN _TsERCurOrdCPF IS NULL THEN 0 ELSE _TsERCurOrdCPF END) AS TsERCurOrdCPF,
   (CASE WHEN _TsAddOrdCPFWage IS NULL THEN 0 ELSE _TsAddOrdCPFWage END) AS TsAddOrdCPFWage,
   (CASE WHEN _TsEEAddOrdCPF IS NULL THEN 0 ELSE _TsEEAddOrdCPF END) AS TsEEAddOrdCPF,
   (CASE WHEN _TsERAddOrdCPF IS NULL THEN 0 ELSE _TsERAddOrdCPF END) AS TsERAddOrdCPF,
   (CASE WHEN _TsSDF IS NULL THEN 0 ELSE _TsSDF END) AS TsSDF,
   (CASE WHEN _TsFWL IS NULL THEN 0 ELSE _TsFWL END) AS TsFWL,

   (CASE WHEN _TotalAllowance IS NULL THEN 0 ELSE _TotalAllowance END) AS TotalAllowance,
   (CASE WHEN _TotalDeduction IS NULL THEN 0 ELSE _TotalDeduction END) AS TotalDeduction,
   (CASE WHEN _TotalReimbursement IS NULL THEN 0 ELSE _TotalReimbursement END) AS TotalReimbursement,

   (SELECT sum(CurrentCostingAmt+PreviousCostingAmt) FROM TMSLeaveDeduction WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _LeaveDeductionAmt,
   (SELECT sum(CurrentCostingAmt+LastOTCostingAmt+BackPayOTCostingAmt) FROM TMSOvertime WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _OTAmt,
   (SELECT sum(CostingAmount) FROM TMSShift WHERE TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _ShiftAmt,

   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsCurOrdCPFWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsCurOrdCPFWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsEECurOrdCPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsEECurOrdCPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsERCurOrdCPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsERCurOrdCPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsCurAddCPFWage' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsAddOrdCPFWage,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsEECurAddCPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsEEAddOrdCPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsERCurAddCPF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsERAddOrdCPF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsSDF' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsSDF,
   (SELECT sum(CostingAmount) FROM TMSDistribute WHERE TMSDistributeId='TsFWL' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TsFWL,

   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Allowance' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalAllowance,
   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Deduction' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalDeduction,
   (SELECT sum(CostingAmount) FROM TMSAllowance JOIN Formula where FormulaSubCategory='Reimbursement' AND TMSSGSPGenId=TimeSheet.TMSSGSPGenId) AS _TotalReimbursement
 
   FROM (TimeSheet LEFT OUTER JOIN TMSDetail) JOIN Employee ON TimeSheet.EmployeeSysID=Employee.EmployeeSysID JOIN JobCode ON JobCode.JobCode=TimeSheet.JobCode
   WHERE
       TimeSheet.EmployeeSysId in (Select EmployeeSysId from DBA.View_TMS_Query);
End if;

if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'ProjectCostingSumRpt') then
   insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
   values('ProjectCostingSumRpt','TMSProcessedRpt','Project Costing Summary Report','Pay',0,0,0,'');
end if;

commit work;