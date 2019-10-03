IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_EmployeeCurCPFProgression') THEN
    DROP VIEW "DBA"."View_Alc_EmployeeCurCPFProgression";
END IF;

CREATE VIEW "DBA"."View_Alc_EmployeeCurCPFProgression" AS 
 SELECT Employee.EmployeeId, Employee.EmployeeName
, CPFProgression.CPFMAWLimit AS CPFMAWLimit
, CPFProgression.CPFMAWOption AS CPFMAWOption
, CPFProgression.CPFProgAccountNo AS CPFProgAccountNo
, CPFProgression.CPFProgPolicyId AS CPFProgPolicyId
, CPFProgression.CPFProgSchemeId AS CPFProgSchemeId
 FROM Employee
 LEFT OUTER JOIN CPFProgression ON (CPFProgression.EmployeeSysId=Employee.EmployeeSysId AND CPFProgCurrent=1)