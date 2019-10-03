if exists(select 1 from sys.sysprocedure where proc_name = 'IsEPClassicDB') then
   drop FUNCTION IsEPClassicDB
end if;

CREATE FUNCTION DBA.IsEPClassicDB()
returns smallint
begin
  declare Out_IsEPClassic smallint;

  select locate(FunctionList, 'EP Standard', 1) into Out_IsEPClassic 
    from LicenseRecord where 
    ProductName = 'Easy Pay Enterprise' and 
    SubProductName = 'Main' and
    length(FunctionList) > 0;

  return(FConvertNull(Out_IsEPClassic))
end
;

if exists(select 1 from sys.sysviews where viewname = 'View_TMS_SmartTouch_LeaveRecord') then
  drop view View_TMS_SmartTouch_LeaveRecord
end if
;

CREATE VIEW DBA.View_TMS_SmartTouch_LeaveRecord
  as select EmployeeId,CompanyId,A.LeaveTypeId,LeaveTypeDesc,
    LveRecDate,LveRecStartTime,LveRecEndTime,LveRecDays,LveRecHours, LeaveReasonId from(
    DBA.LeaveRecord join DBA.LeaveApplication as A join DBA.LeaveType as B) natural join DBA.Employee as C where
    LveRecApproved = 1
;

COMMIT WORK;