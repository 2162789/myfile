IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_EmployeeEportalEmail') THEN
    DROP VIEW "DBA"."View_Alc_EmployeeEportalEmail";
END IF;

CREATE VIEW "DBA"."View_Alc_EmployeeEportalEmail" AS 
 SELECT Employee.EmployeeId, Employee.EmployeeName
, PersonalEmail.PersonalEmail AS PersonalEmail
 FROM Employee
 LEFT OUTER JOIN PersonalEmail ON(Employee.PersonalSysId=PersonalEmail.PersonalSysId AND PersonalEmail.ContactLocationId='ePortal')