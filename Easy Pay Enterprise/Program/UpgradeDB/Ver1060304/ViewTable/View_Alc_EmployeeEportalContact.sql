IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_EmployeeEportalContact') THEN
    DROP VIEW "DBA"."View_Alc_EmployeeEportalContact";
END IF;

CREATE VIEW "DBA"."View_Alc_EmployeeEportalContact" AS 
 SELECT Employee.EmployeeId, Employee.EmployeeName
, PersonalContact.ContactNumber AS ContactNumber
 FROM Employee
 LEFT OUTER JOIN PersonalContact ON(Employee.PersonalSysId=PersonalContact.PersonalSysId AND PersonalContact.ContactLocationId='ePortal')