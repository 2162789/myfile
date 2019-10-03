IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_EmployeePayCalc') THEN
    DROP VIEW "DBA"."View_Alc_EmployeePayCalc";
END IF;

CREATE VIEW "DBA"."View_Alc_EmployeePayCalc" AS 
 SELECT Employee.EmployeeId, Employee.EmployeeName
, EmpeeWkCalen.CalendarId AS CalendarId
, PayEmployee.EEHoursperDay AS EEHoursperDay
, PayEmployee.OTTableId AS OTTableId
, PayEmployee.ShiftTableId AS ShiftTableId
 FROM Employee
 LEFT OUTER JOIN EmpeeWkCalen
 LEFT OUTER JOIN PayEmployee