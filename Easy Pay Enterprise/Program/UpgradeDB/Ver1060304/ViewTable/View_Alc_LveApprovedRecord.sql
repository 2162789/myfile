IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_LveApprovedRecord') THEN
    DROP VIEW "DBA"."View_Alc_LveApprovedRecord";
END IF;

CREATE VIEW "DBA"."View_Alc_LveApprovedRecord"
  as 
SELECT EmployeeId, EmployeeName
, A.LeaveTypeId
, LeaveTypeDesc
, LveRecDate
, LveRecStartTime
, LveRecEndTime
, LveRecDays
, LveRecHours
, LeaveReasonId 
FROM(
    LeaveRecord JOIN LeaveApplication AS A JOIN LeaveType AS B) NATURAL JOIN Employee AS C WHERE
    LveRecApproved = 1