IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_Employee') THEN
    DROP VIEW "DBA"."View_Alc_Employee";
END IF;

CREATE VIEW "DBA"."View_Alc_Employee" AS 
SELECT 
  Employee.EmployeeId
, Employee.EmployeeName
, Employee.CompanyId AS CompanyID
, FGetCompanyName(Employee.CompanyId) AS CompanyName
, Employee.BranchId AS BranchId
, FGetBranchName(Employee.BranchId) AS BranchName
, Employee.CategoryId AS CategoryId
, FGetCategoryDesc(Employee.CategoryId) AS CategoryDesc
, Employee.CessationDate AS CessationDate
, Employee.CessationCode AS CessationCode
, FGetCessationDesc(Employee.CessationCode) AS CessationDesc
, Employee.ClassificationCode AS ClassificationCode
, FGetClassificationDesc(Employee.ClassificationCode) AS ClassificationDesc
, Employee.ConfirmationDate AS ConfirmationDate
, Employee.DepartmentId AS DepartmentId
, FGetDepartmentDesc(Employee.DepartmentId) AS DepartmentDesc
, Employee.EmpCode1Id AS EmpCode1Id
, FGetEmpCode1Desc(Employee.EmpCode1Id) AS EmpCode1Desc
, Employee.EmpCode2Id AS EmpCode2Id
, FGetEmpCode2Desc(Employee.EmpCode2Id) AS EmpCode2Desc
, Employee.EmpCode3Id AS EmpCode3Id
, FGetEmpCode3Desc(Employee.EmpCode3Id) AS EmpCode3Desc
, Employee.EmpCode4Id AS EmpCode4Id
, FGetEmpCode4Desc(Employee.EmpCode4Id) AS EmpCode4Desc
, Employee.EmpCode5Id AS EmpCode5Id
, FGetEmpCode5Desc(Employee.EmpCode5Id) AS EmpCode5Desc
, Employee.EmpLocation1Id AS EmpLocation1Id
, FGetEmpLocation1Desc(Employee.EmpLocation1Id) AS EmpLocation1Desc
, Employee.HireDate AS HireDate
, Employee.PreviousSvcYear
, Employee.PositionId AS PositionId
, FGetPositionDesc(Employee.PositionId) AS PositionDesc
, Employee.ResidenceStatus AS ResidenceStatus
, Employee.RetirementDate AS RetirementDate
, Employee.SalaryGradeId AS SalaryGradeId
, FGetSalaryGradeDesc(Employee.SalaryGradeId) AS SalaryGradeDesc
, Employee.SectionId AS SectionId
, FGetSectionDesc(Employee.SectionId) AS SectionDesc
, Employee.Supervisor AS Supervisor
 FROM Employee
 