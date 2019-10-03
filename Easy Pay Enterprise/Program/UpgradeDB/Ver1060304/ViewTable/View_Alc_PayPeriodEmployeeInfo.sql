IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_PayPeriodEmployeeInfo') THEN
    DROP VIEW "DBA"."View_Alc_PayPeriodEmployeeInfo";
END IF;


CREATE VIEW "DBA"."View_Alc_PayPeriodEmployeeInfo" AS 
 SELECT FGetEmployeeId(PayPeriodRecord.EmployeeSysId) AS EmployeeId, FGetEmployeeName(PayPeriodRecord.EmployeeSysId) AS EmployeeName, PayPeriodRecord.PayRecYear, PayPeriodRecord.PayRecPeriod
, PayPeriodRecord.PayBranchId AS PayBranchId
, FGetBranchName(PayPeriodRecord.PayBranchId) AS PayBranchName
, PayPeriodRecord.PayCategoryId AS PayCategoryId
, FGetCategoryDesc(PayPeriodRecord.PayCategoryId) AS PayCategoryDesc
, PayPeriodRecord.PayClassification AS PayClassification
, FGetClassificationDesc(PayPeriodRecord.PayClassification) AS PayClassificationDesc
, PayPeriodRecord.PayCostCenterId AS PayCostCenterId
, FGetCostCentreDesc(PayPeriodRecord.PayCostCenterId) AS PayCostCenterDesc
, PayPeriodRecord.PayDepartmentId AS PayDepartmentId
, FGetDepartmentDesc(PayPeriodRecord.PayDepartmentId) AS PayDepartmentDesc
, PayPeriodRecord.PayPayGroupId AS PayPayGroupId
, PayPeriodRecord.PayPositionId AS PayPositionId
, FGetPositionDesc(PayPeriodRecord.PayPositionId) AS PayPositionDesc
, PayPeriodRecord.PaySalaryGradeId AS PaySalaryGradeId
, FGetSalaryGradeDesc(PayPeriodRecord.PaySalaryGradeId) AS PaySalaryGradeDesc
, PayPeriodRecord.PaySectionId AS PaySectionId
, FGetSectionDesc(PayPeriodRecord.PaySectionId) AS PaySectionDesc
, PayPeriodRecord.PayWorkCalendarId AS PayWorkCalendarId
, PayPeriodRecord.PayWTCalendarId AS KeyShiftTeam
, PayPeriodRecord.PayEmpCode1Id AS PayEmpCode1Id
, FGetEmpCode1Desc(PayPeriodRecord.PayEmpCode1Id) AS PayEmpCode1Desc
, PayPeriodRecord.PayEmpCode2Id AS PayEmpCode2Id
, FGetEmpCode2Desc(PayPeriodRecord.PayEmpCode2Id) AS PayEmpCode2Desc
, PayPeriodRecord.PayEmpCode3Id AS PayEmpCode3Id
, FGetEmpCode3Desc(PayPeriodRecord.PayEmpCode3Id) AS PayEmpCode3Desc
, PayPeriodRecord.PayEmpCode4Id AS PayEmpCode4Id
, FGetEmpCode4Desc(PayPeriodRecord.PayEmpCode4Id) AS PayEmpCode4Desc
, PayPeriodRecord.PayEmpCode5Id AS PayEmpCode5Id
, FGetEmpCode5Desc(PayPeriodRecord.PayEmpCode5Id) AS PayEmpCode5Desc
 FROM PayPeriodRecord