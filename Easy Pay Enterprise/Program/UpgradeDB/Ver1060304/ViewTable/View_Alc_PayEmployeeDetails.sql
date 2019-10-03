IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_PayEmployeeDetails') THEN
    DROP VIEW "DBA"."View_Alc_PayEmployeeDetails";
END IF;

CREATE VIEW "DBA"."View_Alc_PayEmployeeDetails" AS 
 SELECT FGetEmployeeId(PayPeriodRecord.EmployeeSysId) AS EmployeeId, FGetEmployeeName(PayPeriodRecord.EmployeeSysId) AS EmployeeName, PayPeriodRecord.PayRecYear, PayPeriodRecord.PayRecPeriod
, Employee.CessationCode AS CessationCode
, Employee.CessationDate AS CessationDate
, Employee.ConfirmationDate AS ConfirmationDate
, Employee.HireDate AS HireDate
, Employee.RetirementDate AS RetirementDate
, PayEmployee.CurrentBasicRateType AS CurrentBasicRateType
 FROM PayPeriodRecord
 LEFT OUTER JOIN Employee ON PayPeriodRecord.EmployeeSysId=Employee.EmployeeSysId
 LEFT OUTER JOIN PayEmployee