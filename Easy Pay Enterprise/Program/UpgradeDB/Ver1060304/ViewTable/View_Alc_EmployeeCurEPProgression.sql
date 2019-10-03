IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_EmployeeCurEPProgression') THEN
    DROP VIEW "DBA"."View_Alc_EmployeeCurEPProgression";
END IF;

CREATE VIEW "DBA"."View_Alc_EmployeeCurEPProgression" AS 
 SELECT Employee.EmployeeId, Employee.EmployeeName
, EmployPassProgression.EPFin AS EPFin
 FROM Employee
 LEFT OUTER JOIN EmployPassProgression ON (EmployPassProgression.EmployeeSysId=Employee.EmployeeSysId AND EPCurrent=1)