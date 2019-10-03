if exists(select * from sys.syscolumns where tname='BankSubmitCompanyBank' and cname='AccountNo') then
    alter table DBA.BankSubmitCompanyBank DELETE PRIMARY KEY;
    alter table DBA.BankSubmitCompanyBank Alter AccountNo char(50); 
    alter table DBA.BankSubmitCompanyBank ADD PRIMARY KEY (BankSubmitSubmitForId,FormatName,BankCode,BankBranchCode,AccountNo);   
end if;



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
    IF (In_TriggerTable = 'LeaveApplication') THEN
        SELECT RegProperty1, RegProperty2, IntegerAttr, ShortStringAttr INTO Get_AppSyncPath, Get_DSN, Get_SyncActivated, Get_AppSyncProgramFile FROM Subregistry WHERE SubregistryId='AppSyncSetup' AND RegistryId='System';
    ELSE
        SELECT RegProperty1, RegProperty2, BooleanAttr, ShortStringAttr INTO Get_AppSyncPath, Get_DSN, Get_SyncActivated, Get_AppSyncProgramFile FROM Subregistry WHERE SubregistryId='AppSyncSetup' AND RegistryId='System';
    END IF;

    // Check activated and fields that required to sync. 
    IF (Get_SyncActivated=1) THEN
            // Compose string for shell cmd to execute 
            SET ExeSyncString = '""' + Get_AppSyncPath + Get_AppSyncProgramFile  
                                + '" "' + Get_DSN 
                                + '" "' + CAST(In_EmployeeSysId AS CHAR) 
                                + '" "' + In_TriggerAction  
                                + '" "' + In_TriggerTable
                                + '" "' + In_TriggerRefID
 				                + '" >> "' + Get_AppSyncPath + 'Log\\EpeSync_' + (SELECT CAST(TODAY()AS CHAR)) + '.log""';
            Call xp_cmdshell(ExeSyncString);
    END IF;
end;


if exists(select * from sys.systrigger where  trigger_name = 'SyncLeaveApplicationDelete') then
    drop trigger SyncLeaveApplicationDelete
end if;

if exists(select * from sys.systrigger where  trigger_name = 'SyncLeaveApplicationInsert') then
    drop trigger SyncLeaveApplicationInsert
end if;

if exists(select * from sys.systrigger where  trigger_name = 'SyncLeaveApplicationUpdate') then
    drop trigger SyncLeaveApplicationUpdate
end if;

CREATE TRIGGER "SyncLeaveApplicationUpdate" after update order 21 on
DBA.LeaveApplication
referencing old as old_LeaveApplication new as new_LeaveApplication
for each row
BEGIN
    //UnApproved => Approved : Trigger Action = "Insert" (Approved Leave)
    IF (old_LeaveApplication.LveRecApproved = 0 AND new_LeaveApplication.LveRecApproved = 1) THEN
        Call ASQLSyncApp(new_LeaveApplication.EmployeeSysID,'Insert','LeaveApplication',new_LeaveApplication.LeaveAppSGSPGenId); 
    //Approved => Unapproved : Trigger Action = "Delete" (Unapproved Leave Application) 
    ELSEIF (old_LeaveApplication.LveRecApproved = 1 AND new_LeaveApplication.LveRecApproved = 0) THEN
        Call ASQLSyncApp(new_LeaveApplication.EmployeeSysID,'Delete','LeaveApplication',new_LeaveApplication.LeaveAppSGSPGenId);
    //Approved => Approved : Trigger Action = "Update" (Undate Approved Leave)
    ELSEIF (old_LeaveApplication.LveRecApproved = 1 AND new_LeaveApplication.LveRecApproved = 1) THEN
        Call ASQLSyncApp(new_LeaveApplication.EmployeeSysID,'Update','LeaveApplication',new_LeaveApplication.LeaveAppSGSPGenId);
    END IF;
END;


if exists(select * from sys.sysprocedure where proc_name = 'DeleteBankSubmitCompanyBank') then
    drop procedure DeleteBankSubmitCompanyBank
end if;

CREATE PROCEDURE "DBA"."DeleteBankSubmitCompanyBank"(
in In_BankSubmitSubmitForId char(20),
in In_FormatName char(50),
in In_BankCode char(20),
in In_BankBranchCode char(20),
in In_AccountNo char(50),
out Out_ErrorCode integer)
begin
  if not exists(select* from BankSubmitCompanyBank where BankSubmitSubmitForId = In_BankSubmitSubmitForId and FormatName = In_FormatName and BankCode = In_BankCode and BankBranchCode = In_BankBranchCode and AccountNo = In_AccountNo) then
    set Out_ErrorCode=-1; // Record not exists
    return
  else
    delete from BankSubmitCompanyBank where
      BankSubmitSubmitForId = In_BankSubmitSubmitForId and
      FormatName = In_FormatName and
      BankCode = In_BankCode and
      BankBranchCode = In_BankBranchCode and
      AccountNo = In_AccountNo;
    commit work
  end if;
  if exists(select* from BankSubmitCompanyBank where BankSubmitSubmitForId = In_BankSubmitSubmitForId and FormatName = In_FormatName and BankCode = In_BankCode and BankBranchCode = In_BankBranchCode and AccountNo = In_AccountNo) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if;
end;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewBankSubmitCompanyBank') then
    drop procedure InsertNewBankSubmitCompanyBank
end if;


CREATE PROCEDURE "DBA"."InsertNewBankSubmitCompanyBank"(
in In_BankSubmitSubmitForId char(20),
in In_FormatName char(50),
in In_BankCode char(20),
in In_BankBranchCode char(20),
in In_AccountNo char(50),
in In_BooleanField1 smallint,
in In_BooleanField2 smallint,
in In_BooleanField3 smallint,
in In_IntegerField1 integer,
in In_IntegerField2 integer,
in In_IntegerField3 integer,
in In_NumericField1 double,
in In_NumericField2 double,
in In_NumericField3 double,
in In_DateField1 date,
in In_DateField2 date,
in In_DateField3 date,
in In_StringField1 char(50),
in In_StringField2 char(50),
in In_StringField3 char(50),
in In_StringField4 char(50),
in In_StringField5 char(50),
in In_StringField6 char(50),
in In_StringField7 char(50),
in In_StringField8 char(50),
in In_StringField9 char(50),
in In_StringField10 char(50),
in In_StringField11 char(50),
in In_StringField12 char(50),
in In_StringField13 char(50),
in In_StringField14 char(50),
in In_StringField15 char(50),
in In_StringField16 char(50),
in In_StringField17 char(50),
in In_StringField18 char(50),
in In_StringField19 char(50),
in In_StringField20 char(50),
out Out_ErrorCode integer)
begin
  if not exists(select* from CompanyBank where ComBankCode = In_BankCode and ComBankBranchCode = In_BankBranchCode and ComAccountNo = In_AccountNo) then
    set Out_ErrorCode=-1; // Company Bank info must exist in CompanyBank
    return
  elseif not exists(select* from BankSubmitFormat where BankSubmitSubmitForId = In_BankSubmitSubmitForId and FormatName = In_FormatName) then
    set Out_ErrorCode=-2; // format info must exist in BankSubmitFormat
    return
  else
    insert into BankSubmitCompanyBank(BankSubmitSubmitForId,
      FormatName,
      BankCode,
      BankBranchCode,
      AccountNo,
      BooleanField1,
      BooleanField2,
      BooleanField3,
      IntegerField1,
      IntegerField2,
      IntegerField3,
      NumericField1,
      NumericField2,
      NumericField3,
      DateField1,
      DateField2,
      DateField3,
      StringField1,
      StringField2,
      StringField3,
      StringField4,
      StringField5,
      StringField6,
      StringField7,
      StringField8,
      StringField9,
      StringField10,
      StringField11,
      StringField12,
      StringField13,
      StringField14,
      StringField15,
      StringField16,
      StringField17,
      StringField18,
      StringField19,
      StringField20) values(In_BankSubmitSubmitForId,
      In_FormatName,
      In_BankCode,
      In_BankBranchCode,
      In_AccountNo,
      In_BooleanField1,
      In_BooleanField2,
      In_BooleanField3,
      In_IntegerField1,
      In_IntegerField2,
      In_IntegerField3,
      In_NumericField1,
      In_NumericField2,
      In_NumericField3,
      In_DateField1,
      In_DateField2,
      In_DateField3,
      In_StringField1,
      In_StringField2,
      In_StringField3,
      In_StringField4,
      In_StringField5,
      In_StringField6,
      In_StringField7,
      In_StringField8,
      In_StringField9,
      In_StringField10,
      In_StringField11,
      In_StringField12,
      In_StringField13,
      In_StringField14,
      In_StringField15,
      In_StringField16,
      In_StringField17,
      In_StringField18,
      In_StringField19,
      In_StringField20);
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end;


if exists(select * from sys.sysprocedure where proc_name = 'UpdateBankSubmitCompanyBank') then
    drop procedure UpdateBankSubmitCompanyBank
end if;

CREATE PROCEDURE "DBA"."UpdateBankSubmitCompanyBank"(
in In_BankSubmitSubmitForId char(20),
in In_FormatName char(50),
in In_BankCode char(20),
in In_BankBranchCode char(20),
in In_AccountNo char(50),
in In_BooleanField1 smallint,
in In_BooleanField2 smallint,
in In_BooleanField3 smallint,
in In_IntegerField1 integer,
in In_IntegerField2 integer,
in In_IntegerField3 integer,
in In_NumericField1 double,
in In_NumericField2 double,
in In_NumericField3 double,
in In_DateField1 date,
in In_DateField2 date,
in In_DateField3 date,
in In_StringField1 char(50),
in In_StringField2 char(50),
in In_StringField3 char(50),
in In_StringField4 char(50),
in In_StringField5 char(50),
in In_StringField6 char(50),
in In_StringField7 char(50),
in In_StringField8 char(50),
in In_StringField9 char(50),
in In_StringField10 char(50),
in In_StringField11 char(50),
in In_StringField12 char(50),
in In_StringField13 char(50),
in In_StringField14 char(50),
in In_StringField15 char(50),
in In_StringField16 char(50),
in In_StringField17 char(50),
in In_StringField18 char(50),
in In_StringField19 char(50),
in In_StringField20 char(50),
out Out_ErrorCode integer)
begin
  if not exists(select* from BankSubmitCompanyBank where BankSubmitSubmitForId = In_BankSubmitSubmitForId and FormatName = In_FormatName and BankCode = In_BankCode and BankBranchCode = In_BankBranchCode and AccountNo = In_AccountNo) then
    set Out_ErrorCode=-1; // Record not exists
    return
  else
    update BankSubmitCompanyBank set
      BooleanField1 = In_BooleanField1,
      BooleanField2 = In_BooleanField2,
      BooleanField3 = In_BooleanField3,
      IntegerField1 = In_IntegerField1,
      IntegerField2 = In_IntegerField2,
      IntegerField3 = In_IntegerField3,
      NumericField1 = In_NumericField1,
      NumericField2 = In_NumericField2,
      NumericField3 = In_NumericField3,
      DateField1 = In_DateField1,
      DateField2 = In_DateField2,
      DateField3 = In_DateField3,
      StringField1 = In_StringField1,
      StringField2 = In_StringField2,
      StringField3 = In_StringField3,
      StringField4 = In_StringField4,
      StringField5 = In_StringField5,
      StringField6 = In_StringField6,
      StringField7 = In_StringField7,
      StringField8 = In_StringField8,
      StringField9 = In_StringField9,
      StringField10 = In_StringField10,
      StringField11 = In_StringField11,
      StringField12 = In_StringField12,
      StringField13 = In_StringField13,
      StringField14 = In_StringField14,
      StringField15 = In_StringField15,
      StringField16 = In_StringField16,
      StringField17 = In_StringField17,
      StringField18 = In_StringField18,
      StringField19 = In_StringField19,
      StringField20 = In_StringField20 where
      BankSubmitSubmitForId = In_BankSubmitSubmitForId and
      FormatName = In_FormatName and
      BankCode = In_BankCode and
      BankBranchCode = In_BankBranchCode and
      AccountNo = In_AccountNo;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end;


commit work;

	





