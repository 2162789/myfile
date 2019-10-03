IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_LveYearPolicySumm') THEN
    DROP VIEW "DBA"."View_Alc_LveYearPolicySumm";
END IF;

CREATE VIEW "DBA"."View_Alc_LveYearPolicySumm" AS 
 SELECT FGetEmployeeId(LeaveCycleRpt.EmployeeSysId) AS EmployeeId, FGetEmployeeName(LeaveCycleRpt.EmployeeSysId) AS EmployeeName, LeaveCycleRpt.LeaveTypeId, LeaveCycleRpt.LveYearRpt
, Employee.HireDate AS HireDate
, LeaveCycleRpt.CycBalance AS CycBalance
, LeaveCycleRpt.CycBFEarned AS CycBFEarned
, LeaveCycleRpt.CycBFForfeit AS CycBFForfeit
, LeaveCycleRpt.CycCrossCycTaken AS CycCrossCycTaken
, LeaveCycleRpt.CycDayTaken AS CycDayTaken
, LeaveCycleRpt.CycEndDate AS CycEndDate
, LeaveCycleRpt.CycEntAdjEarned AS CycEntAdjEarned
, LeaveCycleRpt.CycEntEarned AS CycEntEarned
, LeaveCycleRpt.CycStartDate AS CycStartDate
, LeaveCycleRpt.CycTotalEnt AS CycTotalEnt
, (LeaveCycleRpt.CycBalance-LeaveCycleRpt.CycCrossCycTaken) AS LeaveActualBalance
, LvePeriodBalRpt.HisBranchId AS HisBranchId
, LvePeriodBalRpt.HisCategoryId AS HisCategoryId
, LvePeriodBalRpt.HisDepartmentId AS HisDepartmentId
, LvePeriodBalRpt.HisPositionId AS HisPositionId
, LvePeriodBalRpt.HisSectionId AS HisSectionId
 FROM LeaveCycleRpt
 LEFT OUTER JOIN Employee ON (LeaveCycleRpt.EmployeeSysId=Employee .EmployeeSysId)
 LEFT OUTER JOIN LvePeriodBalRpt ON (LeaveCycleRpt.EmployeeSysId=LvePeriodBalRpt.EmployeeSysId AND LeaveCycleRpt.LveYearRpt = LvePeriodBalRpt.LveYearRpt AND LeaveCycleRpt.LeaveTypeId = LvePeriodBalRpt.LeaveTypeId AND LvePeriodBalRpt.LvePeriodRpt = 12)