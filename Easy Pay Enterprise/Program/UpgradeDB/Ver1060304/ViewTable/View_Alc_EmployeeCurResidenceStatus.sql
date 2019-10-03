IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_EmployeeCurResidenceStatus') THEN
    DROP VIEW "DBA"."View_Alc_EmployeeCurResidenceStatus";
END IF;

CREATE VIEW "DBA"."View_Alc_EmployeeCurResidenceStatus" AS 
 SELECT Employee.EmployeeId, Employee.EmployeeName
, Employee.ResidenceStatus AS ResidenceStatus
 FROM Employee