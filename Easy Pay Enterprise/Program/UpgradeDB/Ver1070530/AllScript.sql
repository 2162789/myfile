if not exists (select * from sys.syscolumns where tname = 'LeaveApplication' and cname = 'ApplicationType') then
    alter table LeaveApplication add ApplicationType char(10) null;
end if;

IF EXISTS (select * from sys.sysprocedure where proc_name = 'InsertNewLeaveApplication') then
	drop procedure InsertNewLeaveApplication;
end if;
CREATE PROCEDURE "DBA"."InsertNewLeaveApplication"(
in In_EmployeeSysId integer,
in In_LeaveReasonId char(20),
in In_LeaveTypeId char(20),
in In_LveRecCategory char(20),
in In_LveAppFromDate date,
in In_LveAppStartTime time,
in In_LveAppToDate date,
in In_LveAppEndTime time,
in In_LveAppIsHour smallint,
in In_LveRecApproved smallint,
in In_Remarks char(200),
in In_Status char(20),
in In_LastModified timestamp,
in In_CreatedBy char(1),
out Out_LeaveAppSGSPGenId char(30),
in In_ApplicationType char(10) default NULL)
begin
  select FGetNewSGSPGeneratedIndex('LeaveApplication') into Out_LeaveAppSGSPGenId;
  if not exists(select* from LeaveApplication where
      LeaveApplication.EmployeeSysId = In_EmployeeSysId and
      LeaveApplication.LeaveTypeId = In_LeaveTypeId and
      LeaveApplication.LveAppFromDate = In_LveAppFromDate and
      LeaveApplication.LveAppToDate = In_LveAppToDate and
      LeaveApplication.LveAppStartTime = In_LveAppStartTime) then
    insert into LeaveApplication(LeaveAppSGSPGenId,
      EmployeeSysId,
      LeaveReasonId,
      LeaveTypeId,
      LveRecCategory,
      LveAppFromDate,
      LveAppStartTime,
      LveAppToDate,
      LveAppEndTime,
      LveAppIsHour,
      LveRecApproved,
      Remarks,
      Status,
      LastModified,
      CreatedBy,
      ApplicationType) values(
      Out_LeaveAppSGSPGenId,
      In_EmployeeSysId,
      In_LeaveReasonId,
      In_LeaveTypeId,
      In_LveRecCategory,
      In_LveAppFromDate,
      In_LveAppStartTime,
      In_LveAppToDate,
      In_LveAppEndTime,
      In_LveAppIsHour,
      In_LveRecApproved,
      In_Remarks,
      In_Status,
      In_LastModified,
      In_CreatedBy,
      In_ApplicationType);
    commit work
  end if
end;

IF EXISTS (select * from sys.sysprocedure where proc_name = 'UpdateLeaveApplication') then
	drop procedure UpdateLeaveApplication;
end if;
CREATE PROCEDURE "DBA"."UpdateLeaveApplication"(
in In_LeaveAppSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_LeaveReasonId char(20),
in In_LeaveTypeId char(20),
in In_LveRecCategory char(20),
in In_LveAppFromDate date,
in In_LveAppStartTime time,
in In_LveAppToDate date,
in In_LveAppEndTime time,
in In_LveAppIsHour smallint,
in In_LveRecApproved smallint,
in In_Remarks char(200),
in In_Status char(20),
in In_LastModified timestamp,
in In_CreatedBy char(1),
in In_ApplicationType char(10) default NULL)
begin
  if exists(select* from LeaveApplication where
      LeaveApplication.LeaveAppSGSPGenId = In_LeaveAppSGSPGenId) then
    update LeaveApplication set
      EmployeeSysId = In_EmployeeSysId,
      LeaveReasonId = In_LeaveReasonId,
      LeaveTypeId = In_LeaveTypeId,
      LveRecCategory = In_LveRecCategory,
      LveAppFromDate = In_LveAppFromDate,
      LveAppStartTime = In_LveAppStartTime,
      LveAppToDate = In_LveAppToDate,
      LveAppEndTime = In_LveAppEndTime,
      LveAppIsHour = In_LveAppIsHour,
      LveRecApproved = In_LveRecApproved,
      Remarks = In_Remarks,
      Status = In_Status,
      LastModified = In_LastModified,
      CreatedBy = In_CreatedBy,
      ApplicationType = In_ApplicationType
      where
      LeaveApplication.LeaveAppSGSPGenId = In_LeaveAppSGSPGenId;
    commit work
  end if
end;

commit work;