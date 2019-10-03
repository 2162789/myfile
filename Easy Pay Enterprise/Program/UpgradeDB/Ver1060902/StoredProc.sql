if exists(select * from sys.sysprocedure where proc_name = 'ASQLSyncApp') then
    drop procedure ASQLSyncApp
end if;

Create PROCEDURE "DBA"."ASQLSyncApp"(
in In_EmployeeSysId integer,
in In_TriggerAction char(20),
in In_TriggerTable char(20),
in In_TriggerRefID char(30))
begin
    declare ExeSyncString char(200);

    declare Get_AppSyncPath char(100);
    declare Get_DSN char(100);
    declare Get_SyncActivated smallint;
    declare Get_AppSyncProgramFile char(20);

    // Get App Sync Settings
    SELECT RegProperty1, RegProperty2, BooleanAttr, ShortStringAttr INTO Get_AppSyncPath, Get_DSN, Get_SyncActivated, Get_AppSyncProgramFile FROM Subregistry WHERE SubregistryId='AppSyncSetup' AND RegistryId='System';
    
    // Check activated and fields that required to sync. 
    IF (Get_SyncActivated=1) THEN

            // Compose string for shell cmd to execute 
            SET ExeSyncString = '""' + Get_AppSyncPath + Get_AppSyncProgramFile  
                                + '" "' + Get_DSN 
                                + '" "' + CAST(In_EmployeeSysId AS CHAR) 
                                + '" "' + In_TriggerAction  
                                + '" "' + In_TriggerTable
                                + '" "' + In_TriggerRefID
 				                + '" > "' + Get_AppSyncPath + 'Log\\EpeSync.log""';
            Call xp_cmdshell(ExeSyncString);

    END IF;
end;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewPaymentBankInfo') then
    drop procedure InsertNewPaymentBankInfo
end if;

create procedure dba.InsertNewPaymentBankInfo(
in In_EmployeeSysId integer,
in In_BankId char(20),
in In_BankBranchId char(20),
in In_BankAccountNo char(50),
in In_PaymentValue numeric(10,2),
in In_PaymentType char(20),
in In_BankAccTypeId char(20),
in In_PaymentMode char(20),
in In_BankRemarks char(100),
in In_BeneficiaryName char(150),
in In_BankAllocGpId char(20))
begin
  declare New_PayBankSGSPGenId char(30);
  set New_PayBankSGSPGenId = FGetNewSGSPGeneratedIndex('PaymentBankInfo');
  insert into PaymentBankInfo(PayBankSGSPGenId,
    EmployeeSysId,
    BankId,
    BankBranchId,
    BankAccountNo,
    PaymentValue,
    PaymentType,BankAccTypeId,PaymentMode,BankRemarks,
    BeneficiaryName,
    BankAllocGpId) values(
    New_PayBankSGSPGenId,
    In_EmployeeSysId,
    In_BankId,
    In_BankBranchId,
    In_BankAccountNo,
    In_PaymentValue,
    In_PaymentType,In_BankAccTypeId,In_PaymentMode,In_BankRemarks,
    In_BeneficiaryName,
    In_BankAllocGpId);

    call InsertNewCustomizedBankInfo(New_PayBankSGSPGenId,In_EmployeeSysId,In_BankId,In_BankBranchId,
         In_BankAccountNo,In_PaymentValue,In_PaymentType, In_BankAccTypeId,In_PaymentMode,In_BankRemarks,
         In_BeneficiaryName,In_BankAllocGpId);
  commit work
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdatePaymentBankInfo') then
    drop procedure UpdatePaymentBankInfo
end if;

create procedure dba.UpdatePaymentBankInfo(
in In_PayBankSGSPGenId char(30),
in In_BankId char(20),
in In_BankBranchId char(20),
in In_BankAccountNo char(50),
in In_PaymentValue numeric(10,2),
in In_PaymentType char(20),
in In_BankAccTypeId char(20),
in In_PaymentMode char(20),
in In_BankRemarks char(100),
in In_BeneficiaryName char(150),
in In_BankAllocGpId char(20))
begin
  if exists(select* from PaymentBankInfo where
      PaymentBankInfo.PayBankSGSPGenId = In_PayBankSGSPGenId) then
    update PaymentBankInfo set
      PaymentBankInfo.BankId = In_BankId,
      PaymentBankInfo.BankBranchId = In_BankBranchId,
      PaymentBankInfo.BankAccountNo = In_BankAccountNo,
      PaymentBankInfo.PaymentValue = In_PaymentValue,
      PaymentBankInfo.PaymentType = In_PaymentType,
      PaymentBankInfo.BankAccTypeId = In_BankAccTypeId,
      PaymentBankInfo.PaymentMode = In_PaymentMode,
      PaymentBankInfo.BankRemarks = In_BankRemarks,
      PaymentBankInfo.BeneficiaryName = In_BeneficiaryName,
      PaymentBankInfo.BankAllocGpId = In_BankAllocGpId where
      PaymentBankInfo.PayBankSGSPGenId = In_PayBankSGSPGenId;

   call DBA.UpdateCustomizedBankInfo(In_PayBankSGSPGenId,In_BankId,In_BankBranchId,
         In_BankAccountNo,In_PaymentValue,In_PaymentType, In_BankAccTypeId,In_PaymentMode,In_BankRemarks,
         In_BeneficiaryName,In_BankAllocGpId);
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewBankRecord') then
    drop procedure InsertNewBankRecord
end if;

create procedure dba.InsertNewBankRecord(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_PaymentBankCode char(20),
in In_PaymentBankBrCode char(20),
in In_PaymentBankAccNo char(50),
in In_PaymentAmt double,
in In_PaymentCategory char(20),
in In_PaymentType char(20),
in In_PaymentValue double,
in In_PaymentBankAccType char(20),
in In_PaymentMode char(20),
in In_BeneficiaryName char(150))
begin
  if not exists(select* from BankRecord where
      BankRecord.EmployeeSysId = In_EmployeeSysId and
      BankRecord.PayRecYear = In_PayRecYear and
      BankRecord.PayRecPeriod = In_PayRecPeriod and
      BankRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      BankRecord.PayRecID = In_PayRecID and
      BankRecord.PaymentBankCode = In_PaymentBankCode and
      BankRecord.PaymentBankBrCode = In_PaymentBankBrCode and
      BankRecord.PaymentBankAccNo = In_PaymentBankAccNo and
      BankRecord.BeneficiaryName = In_BeneficiaryName) then
    insert into BankRecord(BankRecSGSPGenId,
      EmployeeSysId,
      PayRecYear,
      PayRecPeriod,
      PayRecSubPeriod,
      PayRecID,
      PaymentBankCode,
      PaymentBankBrCode,
      PaymentBankAccNo,
      PaymentAmt,
      PaymentCategory,
      PaymentType,
      PaymentValue,
      PaymentBankAccType,
      PaymentMode,
      BeneficiaryName) values(
      FGetNewSGSPGeneratedIndex('BankRecord'),
      In_EmployeeSysId,
      In_PayRecYear,
      In_PayRecPeriod,
      In_PayRecSubPeriod,
      In_PayRecID,
      In_PaymentBankCode,
      In_PaymentBankBrCode,
      In_PaymentBankAccNo,
      In_PaymentAmt,
      In_PaymentCategory,
      In_PaymentType,
      In_PaymentValue,
      In_PaymentBankAccType,
      In_PaymentMode,
      In_BeneficiaryName);
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateBankRecord') then
    drop procedure UpdateBankRecord
end if;

create procedure dba.UpdateBankRecord(
in In_BankRecSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_PaymentBankCode char(20),
in In_PaymentBankBrCode char(20),
in In_PaymentBankAccNo char(50),
in In_PaymentAmt double,
in In_PaymentCategory char(20),
in In_PaymentType char(20),
in In_PaymentValue double,
in In_PaymentBankAccType char(20),
in In_PaymentMode char(20),
in In_BeneficiaryName char(150))
begin
  if exists(select* from BankRecord where
      BankRecord.BankRecSGSPGenId = In_BankRecSGSPGenId) then
    update BankRecord set
      BankRecSGSPGenId = In_BankRecSGSPGenId,
      EmployeeSysId = In_EmployeeSysId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      PayRecID = In_PayRecID,
      PaymentBankCode = In_PaymentBankCode,
      PaymentBankBrCode = In_PaymentBankBrCode,
      PaymentBankAccNo = In_PaymentBankAccNo,
      PaymentAmt = In_PaymentAmt,
      PaymentCategory = In_PaymentCategory,
      PaymentType = In_PaymentType,
      PaymentValue = In_PaymentValue,
      PaymentBankAccType = In_PaymentBankAccType,
      PaymentMode = In_PaymentMode,
      BeneficiaryName = In_BeneficiaryName where
      BankRecord.BankRecSGSPGenId = In_BankRecSGSPGenId;
    commit work
  end if
end
;

if exists(select * from sys.systrigger where trigger_name = 'SyncEmpeeWkCalenUpdate') then
   drop trigger SyncEmpeeWkCalenUpdate
end if;

Create TRIGGER SyncEmpeeWkCalenUpdate AFTER UPDATE OF CalendarId
ORDER 20 ON DBA.EmpeeWkCalen
 REFERENCING OLD AS old_EmpeeWkCalen NEW AS new_EmpeeWkCalen 
FOR EACH ROW 
BEGIN
	Call ASQLSyncApp(new_EmpeeWkCalen.EmployeeSysID,'Update','EmpeeWkCalen','');
END
;

if exists(select * from sys.systrigger where trigger_name = 'SyncEmployeeDelete') then
   drop trigger SyncEmployeeDelete
end if;

Create TRIGGER SyncEmployeeDelete AFTER DELETE
ORDER 19 ON DBA.Employee
 REFERENCING OLD AS old_Employee 
FOR EACH ROW 
BEGIN
	Call ASQLSyncApp(old_Employee.EmployeeSysID,'Delete','Employee','');
END
;

if exists(select * from sys.systrigger where trigger_name = 'SyncEmployeeInsert') then
   drop trigger SyncEmployeeInsert
end if;

Create TRIGGER SyncEmployeeInsert after insert order 18 on
DBA.Employee
referencing new as new_Employee
for each row
BEGIN
   Call ASQLSyncApp(new_Employee.EmployeeSysID,'Insert','Employee','');
END
;

if exists(select * from sys.systrigger where trigger_name = 'SyncEmployeeUpdate') then
   drop trigger SyncEmployeeUpdate
end if;

Create TRIGGER "SyncEmployeeUpdate" AFTER UPDATE OF "BranchId", "EmpCode1Id", "SalaryGradeId", "EmpCode2Id", "EmpCode3Id", "EmpCode5Id", "ClassificationCode", "EmpCode4Id", "PositionId", "DepartmentId", "SectionId", "CategoryId", "EmployeeId", "IdentityNo", "EmployeeName", "CessationDate", "HireDate", "Supervisor", "CustBoolean1", "CustBoolean2", "CustBoolean3", "CustDate1", "CustDate2", "CustDate3", "CustInteger1", "CustInteger2", "CustInteger3", "CustNumeric1", "CustNumeric2", "CustNumeric3", "CustString1", "CustString2", "CustString3", "CustString4", "CustString5"
ORDER 17 ON "DBA"."Employee"
 REFERENCING OLD AS old_Employee NEW AS new_Employee
FOR EACH ROW 
BEGIN
    Call ASQLSyncApp(new_Employee.EmployeeSysID,'Update','Employee','');
END
;

if exists(select * from sys.systrigger where trigger_name = 'SyncLeaveApplicationDelete') then
   drop trigger SyncLeaveApplicationDelete
end if;

Create TRIGGER "SyncLeaveApplicationDelete" after delete order 23 on
DBA.LeaveApplication
referencing old as old_LeaveApplication
for each row
BEGIN
   Call ASQLSyncApp(old_LeaveApplication.EmployeeSysID,'Delete','LeaveApplication',old_LeaveApplication.LeaveAppSGSPGenId);
END
;

if exists(select * from sys.systrigger where trigger_name = 'SyncLeaveApplicationInsert') then
   drop trigger SyncLeaveApplicationInsert
end if;

Create TRIGGER "SyncLeaveApplicationInsert" after insert order 22 on
DBA.LeaveApplication
referencing new as new_LeaveApplication
for each row
BEGIN
   Call ASQLSyncApp(new_LeaveApplication.EmployeeSysID,'Insert','LeaveApplication',new_LeaveApplication.LeaveAppSGSPGenId);
END
;

if exists(select * from sys.systrigger where trigger_name = 'SyncLeaveApplicationUpdate') then
   drop trigger SyncLeaveApplicationUpdate
end if;

Create TRIGGER "SyncLeaveApplicationUpdate" after update order 21 on
DBA.LeaveApplication
referencing old as old_LeaveApplication new as new_LeaveApplication
for each row
BEGIN
   Call ASQLSyncApp(new_LeaveApplication.EmployeeSysID,'Update','LeaveApplication',new_LeaveApplication.LeaveAppSGSPGenId);
END
;

commit work;