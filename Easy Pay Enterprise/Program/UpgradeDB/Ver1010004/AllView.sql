if exists(select 1 from sys.sysviews where viewname = 'View_TMS_SmartTouch_LeaveRecord') then
   drop view View_TMS_SmartTouch_LeaveRecord;
end if
;

create view
  DBA.View_TMS_SmartTouch_LeaveRecord
  as select EmployeeId,CompanyId,A.LeaveTypeId,LeaveTypeDesc,
    LveRecDate,LveRecStartTime,LveRecEndTime,LveRecDays,LveRecHours from(
    DBA.LeaveRecord join DBA.LeaveApplication as A join DBA.LeaveType as B) natural join DBA.Employee as C where
    LveRecApproved = 1
;

commit work;


