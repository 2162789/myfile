IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_EmployeeCurFWLProgression') THEN
    DROP VIEW "DBA"."View_Alc_EmployeeCurFWLProgression";
END IF;

CREATE VIEW "DBA"."View_Alc_EmployeeCurFWLProgression" AS 
 SELECT Employee.EmployeeId, Employee.EmployeeName
, FWLProgression.FWLFormulaId AS FWLFormulaId
, FWLProgression.FWLPermitNumber AS FWLPermitNumber
 FROM Employee
 LEFT OUTER JOIN FWLProgression ON (FWLProgression.EmployeeSysId=Employee.EmployeeSysId AND FWLCurrent=1)