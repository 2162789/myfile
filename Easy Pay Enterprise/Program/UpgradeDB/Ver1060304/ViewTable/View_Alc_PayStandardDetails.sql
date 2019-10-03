IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_PayStandardDetails') THEN
    DROP VIEW "DBA"."View_Alc_PayStandardDetails";
END IF;

CREATE VIEW "DBA"."View_Alc_PayStandardDetails" AS 
 SELECT FGetEmployeeId(PayPeriodRecord.EmployeeSysId) AS EmployeeId, FGetEmployeeName(PayPeriodRecord.EmployeeSysId) AS EmployeeName, PayPeriodRecord.PayRecYear, PayPeriodRecord.PayRecPeriod
, PayEmployee.LastPayDate AS LastPayDate
 FROM PayPeriodRecord
 LEFT OUTER JOIN PayEmployee