IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_LvePeriodPolicyHistory') THEN
    DROP VIEW "DBA"."View_Alc_LvePeriodPolicyHistory";
END IF;

CREATE VIEW "DBA"."View_Alc_LvePeriodPolicyHistory" AS 
 SELECT FGetEmployeeId(LvePeriodBalRpt.EmployeeSysId) AS EmployeeId, FGetEmployeeName(LvePeriodBalRpt.EmployeeSysId) AS EmployeeName, LvePeriodBalRpt.LeaveTypeId, LvePeriodBalRpt.LveYearRpt, LvePeriodBalRpt.LvePeriodRpt
, Employee.HireDate AS HireDate
, LvePeriodBalRpt.HisBranchId AS HisBranchId
, FGetBranchName(LvePeriodBalRpt.HisBranchId) AS HisBranchName
, LvePeriodBalRpt.HisCategoryId AS HisCategoryId
, FGetCategoryDesc(LvePeriodBalRpt.HisCategoryId) AS HisCategoryDesc
, LvePeriodBalRpt.HisDepartmentId AS HisDepartmentId
, FGetDepartmentDesc(LvePeriodBalRpt.HisDepartmentId) AS HisDepartmentDesc
, LvePeriodBalRpt.HisLeaveGroupID AS HisLeaveGroupID 
, FGetLeaveGroupDesc(LvePeriodBalRpt.HisLeaveGroupID) AS HisLeaveGroupDesc 
, LvePeriodBalRpt.HisPositionId AS HisPositionId
, FGetPositionDesc(LvePeriodBalRpt.HisPositionId) AS HisPositionDesc
, LvePeriodBalRpt.HisSectionId AS HisSectionId
, FGetSectionDesc(LvePeriodBalRpt.HisSectionId) AS HisSectionDesc
 FROM LvePeriodBalRpt
 LEFT OUTER JOIN Employee ON (LvePeriodBalRpt.EmployeeSysId=Employee.EmployeeSysId)