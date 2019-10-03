IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_EmployeeMailAddress') THEN
    DROP VIEW "DBA"."View_Alc_EmployeeMailAddress";
END IF;

CREATE VIEW "DBA"."View_Alc_EmployeeMailAddress" AS 
 SELECT Employee.EmployeeId, Employee.EmployeeName
, PersonalAddress.CustString1 AS PersonalAddCustString1
, PersonalAddress.CustString2 AS PersonalAddCustString2
, PersonalAddress.CustString3 AS PersonalAddCustString3
, PersonalAddress.CustString4 AS PersonalAddCustString4
, PersonalAddress.CustString5 AS PersonalAddCustString5
, PersonalAddress.PersonalAddAddress AS PersonalAddAddress
, PersonalAddress.PersonalAddAddress2 AS PersonalAddAddress2
, PersonalAddress.PersonalAddAddress3 AS PersonalAddAddress3
, PersonalAddress.PersonalAddCity AS PersonalAddCity
, PersonalAddress.PersonalAddCountry AS PersonalAddCountry
, PersonalAddress.PersonalAddPCode AS PersonalAddPCode
, PersonalAddress.PersonalAddState AS PersonalAddState
 FROM Employee
 LEFT OUTER JOIN PersonalAddress ON(Employee.PersonalSysId=PersonalAddress.PersonalSysId AND PersonalAddMailing=1)