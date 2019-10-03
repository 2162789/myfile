IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_EmployeeStandard') THEN
    DROP VIEW "DBA"."View_Alc_EmployeeStandard";
END IF;


CREATE VIEW "DBA"."View_Alc_EmployeeStandard" AS 
 SELECT Employee.EmployeeId, Employee.EmployeeName
, PayEmployee.BonusFactor AS BonusFactor
, PayEmployee.LastPayDate AS LastPayDate
 FROM Employee
 LEFT OUTER JOIN PayEmployee