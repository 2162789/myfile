READ UpgradeDB\Ver1060903\StoredProc.sql;



//-----------------------------------
// Create View_TMS_JobCode
//-----------------------------------

if exists(select table_name FROM systable where table_type='view' and table_name = 'View_TMS_JobCode')
then

ALTER VIEW "DBA"."View_TMS_JobCode"
   AS
   SELECT JobCode, JobCodeDesc,JobCodeRefNo,TMSProjectId,TMSCostCentreId FROM JobCode;

else
   CREATE VIEW "DBA"."View_TMS_JobCode"
   AS
   SELECT JobCode, JobCodeDesc,JobCodeRefNo,TMSProjectId,TMSCostCentreId FROM JobCode;
end if;

//--------------------------------------
// ALTER View_TMS_SmartTouch_LeaveRecord
//--------------------------------------

if exists(select table_name FROM systable where table_type='view' and table_name = 'View_TMS_SmartTouch_LeaveRecord')
then

ALTER VIEW "DBA"."View_TMS_SmartTouch_LeaveRecord"
     as SELECT A.LeaveAppSGSPGenId, C.EmployeeSysId, EmployeeId,CompanyId,A.LeaveTypeId,LeaveTypeDesc,
       LveRecDate,LveRecStartTime,LveRecEndTime,LveRecDays,LveRecHours, LeaveReasonId from(
       DBA.LeaveRecord join DBA.LeaveApplication as A join DBA.LeaveType as B) natural join DBA.Employee as C where
       LveRecApproved = 1
       AND C.EmployeeSysId in (Select EmployeeSysID from DBA.View_TMS_Query)

else

CREATE VIEW "DBA"."View_TMS_SmartTouch_LeaveRecord"
     as SELECT A.LeaveAppSGSPGenId, C.EmployeeSysId, EmployeeId,CompanyId,A.LeaveTypeId,LeaveTypeDesc,
       LveRecDate,LveRecStartTime,LveRecEndTime,LveRecDays,LveRecHours, LeaveReasonId from(
       DBA.LeaveRecord join DBA.LeaveApplication as A join DBA.LeaveType as B) natural join DBA.Employee as C where
       LveRecApproved = 1
       AND C.EmployeeSysId in (Select EmployeeSysID from DBA.View_TMS_Query)


end if;

//-----------------------------------
// Create View_Acc_TimeSheetPayElement
//-----------------------------------
If NOT exists(select table_name FROM systable where table_type='view' and table_name = 'View_Acc_TimeSheetPayElement')
then
CREATE VIEW "DBA"."View_Acc_TimeSheetPayElement"
AS
   SELECT TimeSheet.TMSSGSPGenID, FormulaId, CostingAmount FROM TMSAllowance JOIN TimeSheet
   WHERE
       TimeSheet.EmployeeSysId in (Select EmployeeSysId from DBA.View_TMS_Query);
else
ALTER VIEW "DBA"."View_Acc_TimeSheetPayElement"
AS
   SELECT TimeSheet.TMSSGSPGenID, FormulaId, CostingAmount FROM TMSAllowance JOIN TimeSheet
   WHERE
       TimeSheet.EmployeeSysId in (Select EmployeeSysId from DBA.View_TMS_Query);
end if;


Update PayRecord
Set IsExceedAuthDeductCap = 0
Where IsExceedAuthDeductCap <> 0 and CreatedBy  ='Y' ;


IF exists(select * FROM SubRegistry where SubRegistryId='AppSyncSetup') THEN
    UPDATE Subregistry SET IntegerAttr=0 WHERE SubRegistryId='AppSyncSetup';
END IF;



commit work;