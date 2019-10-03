IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_PayPeriodBalance') THEN
    DROP VIEW "DBA"."View_Alc_PayPeriodBalance";
END IF;

CREATE VIEW "DBA"."View_Alc_PayPeriodBalance" AS 
 SELECT FGetEmployeeId(PayPeriodRecord.EmployeeSysId) AS EmployeeId, FGetEmployeeName(PayPeriodRecord.EmployeeSysId) AS EmployeeName, PayPeriodRecord.PayRecYear, PayPeriodRecord.PayRecPeriod
, FGetPeriodGrossWage(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodGrossWage
, FGetPeriodNetWage(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodNetWage
, FGetPeriodTotalGrossWage(PayPeriodRecord.EmployeeSysId,PayPeriodRecord.PayRecYear,PayPeriodRecord.PayRecPeriod) AS PeriodTotalGrossWage
 FROM PayPeriodRecord