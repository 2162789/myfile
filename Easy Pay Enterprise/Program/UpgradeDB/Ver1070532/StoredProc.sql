/*--------------------------------------------------------------------------------
	Add in the 2 new columns (LvePayrollYear and LvePayrollPeriod) in StoredProc
--------------------------------------------------------------------------------*/
if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewLeaveRecord') then
   drop procedure DBA.InsertNewLeaveRecord
end if;

CREATE PROCEDURE "DBA"."InsertNewLeaveRecord"(
in In_LeaveAppSGSPGenId char(30),
in In_LveRecDate date,
in In_LveRecStartTime time,
in In_LveRecEndTime time,
in In_LveRecDays double,
in In_LveRecHours double,
in In_LveRecConvertDays double,
in In_LveRecCalendarDay double,
in In_LveCertificationDate date,
in In_LvePayrollYear integer default NULL ,
in In_LvePayrollPerid integer default NULL)
begin
  if not exists(select* from LeaveRecord where
      LeaveRecord.LeaveAppSGSPGenId = In_LeaveAppSGSPGenId and
      LeaveRecord.LveRecDate = In_LveRecDate and
      LeaveRecord.LveRecStartTime = In_LveRecStartTime) then
    insert into LeaveRecord(LeaveAppSGSPGenId,
      LveRecDate,
      LveRecStartTime,
      LveRecEndTime,
      LveRecDays,
      LveRecHours,
      LveRecConvertDays,
      LveRecCalendarDay,
      LveCertificationDate,
      LvePayrollYear,LvePayrollPeriod) values(
      In_LeaveAppSGSPGenId,
      In_LveRecDate,
      In_LveRecStartTime,
      In_LveRecEndTime,
      In_LveRecDays,
      In_LveRecHours,
      In_LveRecConvertDays,
      In_LveRecCalendarDay,
      In_LveCertificationDate,
      In_LvePayrollYear, In_LvePayrollPerid);
    commit work
  end if
end;

commit work;