If exists(select * from sys.sysprocedure where proc_name = 'DeleteLeaveApplicationForESS') then 
  drop procedure DeleteLeaveApplicationForESS
end if;
CREATE PROCEDURE "DBA"."DeleteLeaveApplicationForESS"(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_LveAppFromDate date,
in In_LveAppToDate date, 
in In_LveAppStartTime time default null, /* Only for Half Day Leave */
in In_LveAppEndTime time default null, /* Only for Half Day Leave */
in In_LveAppType smallint) /* 0: Half Day Leave, 1: Full Day Leave */ 
begin
  declare In_LeaveAppSGSPGenId char(30);
  
  /* Half Day Leave, delete specific leave */
  if In_LveAppType = 0 then 
	  if exists(select* from LeaveApplication where
		  LeaveApplication.EmployeeSysId = In_EmployeeSysId and
		  LeaveApplication.LeaveTypeId = In_LeaveTypeId and
		  LeaveApplication.LveAppFromDate = In_LveAppFromDate and
		  LeaveApplication.LveAppToDate = In_LveAppToDate and
		  LeaveApplication.LveAppStartTime = In_LveAppStartTime and
		  LeaveApplication.LveAppEndTime = In_LveAppEndTime) then
		select LeaveAppSGSPGenId into In_LeaveAppSGSPGenId from LeaveApplication where
		  LeaveApplication.EmployeeSysId = In_EmployeeSysId and
		  LeaveApplication.LeaveTypeId = In_LeaveTypeId and
		  LeaveApplication.LveAppFromDate = In_LveAppFromDate and
		  LeaveApplication.LveAppToDate = In_LveAppToDate and
		  LeaveApplication.LveAppStartTime = In_LveAppStartTime and
		  LeaveApplication.LveAppEndTime = In_LveAppEndTime;
        call DeleteLeaveApplicationByGenId(In_LeaveAppSGSPGenId);
		commit work
	  end if;
  else
      /* Full day leave, delete all the leave for the same start and end date */
	  if exists(select* from LeaveApplication where
		  LeaveApplication.EmployeeSysId = In_EmployeeSysId and
		  LeaveApplication.LeaveTypeId = In_LeaveTypeId and
		  LeaveApplication.LveAppFromDate = In_LveAppFromDate and
		  LeaveApplication.LveAppToDate = In_LveAppToDate) then
        delete from LeaveRecord 
        where LeaveAppSGSPGenId In (Select LeaveAppSGSPGenId from LeaveApplication where
		  LeaveApplication.EmployeeSysId = In_EmployeeSysId and
		  LeaveApplication.LeaveTypeId = In_LeaveTypeId and
		  LeaveApplication.LveAppFromDate = In_LveAppFromDate and
		  LeaveApplication.LveAppToDate = In_LveAppToDate);
		delete from LeaveApplication where LeaveApplication.EmployeeSysId = In_EmployeeSysId and
		  LeaveApplication.LeaveTypeId = In_LeaveTypeId and
		  LeaveApplication.LveAppFromDate = In_LveAppFromDate and
		  LeaveApplication.LveAppToDate = In_LveAppToDate;
		commit work
	  end if;    
  end if;
end;

commit work;