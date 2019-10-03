if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewMalBIKRecord') then
   drop procedure InsertNewMalBIKRecord
end if
;

CREATE PROCEDURE "DBA"."InsertNewMalBIKRecord"(
in In_MalBIKItemId char(20),
in In_EmployeeSysId integer,
in In_BIKRecRecurSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_BIKAmount double,
out Out_MalBIKRecSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  select FGetNewSGSPGeneratedIndex('MalBIKRecord') into Out_MalBIKRecSGSPGenId;
  insert into MalBIKRecord(MalBIKRecSGSPGenId,
    MalBIKItemId,
    EmployeeSysId,
    BIKRecRecurSysId,
    PayRecYear,
    PayRecPeriod,
    PayRecSubPeriod,
    PayRecID,
    BIKAmount) values(
    Out_MalBIKRecSGSPGenId,
    In_MalBIKItemId,
    In_EmployeeSysId,
    In_BIKRecRecurSysId,
    In_PayRecYear,
    In_PayRecPeriod,
    In_PayRecSubPeriod,
    In_PayRecID,
    In_BIKAmount);
  commit work;
  if not exists(select* from MalBIKRecord where
      MalBIKRecSGSPGenId = Out_MalBIKRecSGSPGenId) then
    set Out_ErrorCode=0
  else
    set Out_ErrorCode=1
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateMalBIKRecord') then
   drop procedure UpdateMalBIKRecord
end if
;

CREATE PROCEDURE "DBA"."UpdateMalBIKRecord"(
in In_MalBIKRecSGSPGenId char(30),
in In_MalBIKItemId char(20),
in In_EmployeeSysId integer,
in In_BIKRecRecurSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_BIKAmount double,
out Out_ErrorCode integer)
begin
  if exists(select* from MalBIKRecord where
      MalBIKRecord.MalBIKRecSGSPGenId = In_MalBIKRecSGSPGenId) then
    update MalBIKRecord set
      MalBIKItemId = In_MalBIKItemId,
      EmployeeSysId = In_EmployeeSysId,
      BIKRecRecurSysId = In_BIKRecRecurSysId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      PayRecID = In_PayRecID,
      BIKAmount = In_BIKAmount where
      MalBIKRecord.MalBIKRecSGSPGenId = In_MalBIKRecSGSPGenId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

commit work;