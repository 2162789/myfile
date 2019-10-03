IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_LvePeriodPolicySumm') THEN
    DROP VIEW "DBA"."View_Alc_LvePeriodPolicySumm";
END IF;

CREATE VIEW "DBA"."View_Alc_LvePeriodPolicySumm" AS 
 SELECT FGetEmployeeId(LvePeriodBalRpt.EmployeeSysId) AS EmployeeId, FGetEmployeeName(LvePeriodBalRpt.EmployeeSysId) AS EmployeeName, LvePeriodBalRpt.LeaveTypeId, LvePeriodBalRpt.LveYearRpt, LvePeriodBalRpt.LvePeriodRpt
, Employee.HireDate AS HireDate
, LvePeriodBalRpt.HisBranchId AS HisBranchId
, LvePeriodBalRpt.HisCategoryId AS HisCategoryId
, LvePeriodBalRpt.HisDepartmentId AS HisDepartmentId
, LvePeriodBalRpt.HisPositionId AS HisPositionId
, LvePeriodBalRpt.HisSectionId AS HisSectionId
, LvePeriodBalRpt.PerBFEarned AS PerBFEarned
, LvePeriodBalRpt.PerBFForfeit AS PerBFForfeit
, LvePeriodBalRpt.PerDayTaken AS PerDayTaken
, LvePeriodBalRpt.PerEntAdjEarned AS PerEntAdjEarned
, LvePeriodBalRpt.PerEntEarned AS PerEntEarned
, LvePeriodBalRpt.PeriodEndDate AS PeriodEndDate
, LvePeriodBalRpt.PeriodStartDate AS PeriodStartDate
, LvePeriodBalRpt.PerTotalEnt AS PerTotalEnt
, (LvePeriodBalRpt.YTDBalance-FGetCrossCycTaken(LvePeriodBalRpt.EmployeeSysID,LvePeriodBalRpt.LeaveTypeId,LvePeriodBalRpt.LveYearRpt) ) AS YTDActualBalance
, LvePeriodBalRpt.YTDBalance AS YTDBalance
, LvePeriodBalRpt.YTDBFEarned AS YTDBFEarned
, LvePeriodBalRpt.YTDBFForfeit AS YTDBFForfeit
, LvePeriodBalRpt.YTDDayTaken AS YTDDayTaken
, LvePeriodBalRpt.YTDEntAdjEarned AS YTDEntAdjEarned
, LvePeriodBalRpt.YTDEntEarned AS YTDEntEarned
, LvePeriodBalRpt.YTDTotalEnt AS YTDTotalEnt
 FROM LvePeriodBalRpt
 LEFT OUTER JOIN Employee ON (LvePeriodBalRpt.EmployeeSysId=Employee.EmployeeSysId)