/*--------------------------------------------------------------------------------
	Add in 2 new columns (LvePayrollYear, LvePayrollPeriod) for UpdateLeaveRecord
--------------------------------------------------------------------------------*/
if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateLeaveRecord') then
   drop procedure DBA.UpdateLeaveRecord
end if;

create procedure dba.UpdateLeaveRecord(
in In_LeaveAppSGSPGenId char(30),
in In_LveRecDate date,
in In_LveRecStartTime time,
in In_LveRecEndTime time,
in In_LveRecDays double,
in In_LveRecHours double,
in In_LveRecConvertDays double,
in In_LveRecCalendarDay double,
in In_LveCertificationDate date,
in In_LvePayrollYear integer default null,
in In_LvePayrollPeriod integer default null)
begin
  if exists(select* from LeaveRecord where
      LeaveRecord.LeaveAppSGSPGenId = In_LeaveAppSGSPGenId and
      LeaveRecord.LveRecDate = In_LveRecDate and
      LeaveRecord.LveRecStartTime = In_LveRecStartTime) then
    update LeaveRecord set
      LveRecEndTime = In_LveRecEndTime,
      LveRecDays = In_LveRecDays,
      LveRecHours = In_LveRecHours,
      LveRecConvertDays = In_LveRecConvertDays,
      LveRecCalendarDay = In_LveRecCalendarDay,
      LveCertificationDate = In_LveCertificationDate,
	  LvePayrollYear = In_LvePayrollYear,
      LvePayrollPeriod = In_LvePayrollPeriod where
      LeaveRecord.LeaveAppSGSPGenId = In_LeaveAppSGSPGenId and
      LeaveRecord.LveRecDate = In_LveRecDate and
      LeaveRecord.LveRecStartTime = In_LveRecStartTime;
    commit work
  end if
end
;

commit work;