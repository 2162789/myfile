IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_PayPeriodSumm') THEN
    DROP VIEW "DBA"."View_Alc_PayPeriodSumm";
END IF;

CREATE VIEW "DBA"."View_Alc_PayPeriodSumm" AS 
 SELECT FGetEmployeeId(PayPeriodRecord.EmployeeSysId) AS EmployeeId, FGetEmployeeName(PayPeriodRecord.EmployeeSysId) AS EmployeeName, PayPeriodRecord.PayRecYear, PayPeriodRecord.PayRecPeriod
, FGetPeriodAllowance(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodAllowance
, FGetPeriodBackPay(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodBackPay
, FGetPeriodBasicRate(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodBasicRate
, FGetPeriodBonus(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodBonus
, FGetPeriodDeduction(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodDeduction
, FGetPeriodLveDeductAmt(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodLveDeductAmt
, FGetPeriodMVC(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodMVC
, FGetPeriodNWC(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodNWC
, FGetPeriodOTAmount(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodOTAmount
, FGetPeriodOTBackPay(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodOTBackPay
, FGetPeriodReimbursement(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodReimbursement
, FGetPeriodShiftAmount(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodShiftAmount
, FGetPeriodTotalWage(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodTotalWage
 FROM PayPeriodRecord