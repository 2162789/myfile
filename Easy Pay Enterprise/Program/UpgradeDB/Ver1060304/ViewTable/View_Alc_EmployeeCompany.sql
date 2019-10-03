IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_EmployeeCompany') THEN
    DROP VIEW "DBA"."View_Alc_EmployeeCompany";
END IF;

CREATE VIEW "DBA"."View_Alc_EmployeeCompany" AS 
 SELECT 
  Employee.EmployeeId
, Employee.EmployeeName
, Employee.CompanyID AS CompanyID
, FGetCompanyName(Employee.CompanyID) As CompanyName
 FROM Employee
