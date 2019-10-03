IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_LveYearSumm') THEN
    DROP VIEW "DBA"."View_Alc_LveYearSumm";
END IF;

CREATE VIEW "DBA"."View_Alc_LveYearSumm" AS 
 SELECT FGetEmployeeId(LeaveCycleRpt.EmployeeSysId) AS EmployeeId, FGetEmployeeName(LeaveCycleRpt.EmployeeSysId) AS EmployeeName, LeaveCycleRpt.LeaveTypeId, LeaveCycleRpt.LveYearRpt
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
 FROM LeaveCycleRpt
 LEFT OUTER JOIN Employee ON (LeaveCycleRpt.EmployeeSysId=Employee .EmployeeSysId)