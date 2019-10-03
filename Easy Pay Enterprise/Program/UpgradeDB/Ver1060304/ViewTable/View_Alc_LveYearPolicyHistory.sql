IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_LveYearPolicyHistory') THEN
    DROP VIEW "DBA"."View_Alc_LveYearPolicyHistory";
END IF;

CREATE VIEW "DBA"."View_Alc_LveYearPolicyHistory" AS 
 SELECT FGetEmployeeId(LeaveCycleRpt.EmployeeSysId) AS EmployeeId, FGetEmployeeName(LeaveCycleRpt.EmployeeSysId) AS EmployeeName, LeaveCycleRpt.LeaveTypeId, LeaveCycleRpt.LveYearRpt
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
 FROM LeaveCycleRpt
 LEFT OUTER JOIN Employee ON (LeaveCycleRpt.EmployeeSysId=Employee .EmployeeSysId)
 LEFT OUTER JOIN LvePeriodBalRpt ON (LeaveCycleRpt.EmployeeSysId=LvePeriodBalRpt.EmployeeSysId AND LeaveCycleRpt.LveYearRpt = LvePeriodBalRpt.LveYearRpt AND LeaveCycleRpt.LeaveTypeId = LvePeriodBalRpt.LeaveTypeId AND LvePeriodBalRpt.LvePeriodRpt = 12)