IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_PayPeriodSummary') THEN
    DROP VIEW "DBA"."View_Alc_PayPeriodSummary";
END IF;

CREATE VIEW "DBA"."View_Alc_PayPeriodSummary" AS 
 SELECT FGetEmployeeId(PayPeriodRecord.EmployeeSysId) AS EmployeeId, FGetEmployeeName(PayPeriodRecord.EmployeeSysId) AS EmployeeName, PayPeriodRecord.PayRecYear, PayPeriodRecord.PayRecPeriod
, Employee.CessationCode AS CessationCode
, Employee.CessationDate AS CessationDate
, Employee.ConfirmationDate AS ConfirmationDate
, Employee.HireDate AS HireDate
, Employee.RetirementDate AS RetirementDate
, PayEmployee.CurrentBasicRateType AS CurrentBasicRateType
, PayEmployee.LastPayDate AS LastPayDate
, PayPeriodRecord.PayBranchId AS PayBranchId
, PayPeriodRecord.PayCategoryId AS PayCategoryId
, PayPeriodRecord.PayClassification AS PayClassification
, PayPeriodRecord.PayCostCenterId AS PayCostCenterId
, PayPeriodRecord.PayDepartmentId AS PayDepartmentId
, PayPeriodRecord.PayPayGroupId AS PayPayGroupId
, PayPeriodRecord.PayPositionId AS PayPositionId
, PayPeriodRecord.PaySalaryGradeId AS PaySalaryGradeId
, PayPeriodRecord.PaySectionId AS PaySectionId
, PayPeriodRecord.PayWorkCalendarId AS PayWorkCalendarId
, PayPeriodRecord.PayWTCalendarId AS PayWTCalendarId
, FGetPeriodAllowance(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodAllowance
, FGetPeriodBackPay(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodBackPay
, FGetPeriodBasicRate(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodBasicRate
, FGetPeriodBonus(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodBonus
, FGetPeriodDeduction(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodDeduction
, FGetPeriodGrossWage(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodGrossWage
, FGetPeriodLveDeductAmt(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodLveDeductAmt
, FGetPeriodMVC(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodMVC
, FGetPeriodNetWage(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodNetWage
, FGetPeriodNWC(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodNWC
, FGetPeriodOTAmount(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodOTAmount
, FGetPeriodOTBackPay(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodOTBackPay
, FGetPeriodReimbursement(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodReimbursement
, FGetPeriodShiftAmount(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodShiftAmount
, FGetPeriodTotalGrossWage(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodTotalGrossWage
, FGetPeriodTotalWage(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodTotalWage
, PeriodPolicySummary.ContriAddEECPF AS ContriAddEECPF
, PeriodPolicySummary.ContriAddERCPF AS ContriAddERCPF
, PeriodPolicySummary.ContriFWL AS ContriFWL
, PeriodPolicySummary.ContriOrdEECPF AS ContriOrdEECPF
, PeriodPolicySummary.ContriOrdERCPF AS ContriOrdERCPF
, PeriodPolicySummary.ContriSDF AS ContriSDF
, PeriodPolicySummary.CPFClass AS CPFClass
, PeriodPolicySummary.CPFStatus AS CPFStatus
, PeriodPolicySummary.CPFWage AS CPFWage
, PeriodPolicySummary.CurAdditionalWage AS CurAdditionalWage
, PeriodPolicySummary.CurOrdinaryWage AS CurOrdinaryWage
, PeriodPolicySummary.MAWContriCurAddWage AS MAWContriCurAddWage
, PeriodPolicySummary.MAWContriLimit AS MAWContriLimit
, PeriodPolicySummary.MAWContriOption AS MAWContriOption
, PeriodPolicySummary.MAWContriPrevAddWage AS MAWContriPrevAddWage
, PeriodPolicySummary.OverseasEECPF AS OverseasEECPF
, PeriodPolicySummary.OverseasERCPF AS OverseasERCPF
, PeriodPolicySummary.PrevAdditionalWage AS PrevAdditionalWage
, PeriodPolicySummary.PrevOrdinaryWage AS PrevOrdinaryWage
, PeriodPolicySummary.SDFWage AS SDFWage
, PeriodPolicySummary.TotalCDAC AS TotalCDAC
, PeriodPolicySummary.TotalComm AS TotalComm
, PeriodPolicySummary.TotalContriEECPF AS TotalContriEECPF
, PeriodPolicySummary.TotalContriERCPF AS TotalContriERCPF
, PeriodPolicySummary.TotalEUCF AS TotalEUCF
, PeriodPolicySummary.TotalMOSQ AS TotalMOSQ
, PeriodPolicySummary.TotalSINDA AS TotalSINDA
, PeriodPolicySummary.TotalYMF AS TotalYMF
, PeriodPolicySummary.VolAddEECPF AS VolAddEECPF
, PeriodPolicySummary.VolAddERCPF AS VolAddERCPF
, PeriodPolicySummary.VolOrdEECPF AS VolOrdEECPF
, PeriodPolicySummary.VolOrdERCPF AS VolOrdERCPF
 FROM PayPeriodRecord
 LEFT OUTER JOIN Employee ON PayPeriodRecord.EmployeeSysId=Employee.EmployeeSysId
 LEFT OUTER JOIN PayEmployee
 LEFT OUTER JOIN PeriodPolicySummary