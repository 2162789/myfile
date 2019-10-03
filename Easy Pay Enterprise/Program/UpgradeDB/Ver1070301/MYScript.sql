if exists(select * from sys.sysprocedure where proc_name = 'InsertNewMalBIKRecord') then
   drop procedure InsertNewMalBIKRecord
end if;
CREATE PROCEDURE "DBA"."InsertNewMalBIKRecord"(
in In_MalBIKItemId char(20),
in In_EmployeeSysId integer,
in In_BIKRecRecurSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_BIKAmount double,
in In_BIKCreatedBy char(20),
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
    BIKAmount,
    BIKCreatedBy) values(
    Out_MalBIKRecSGSPGenId,
    In_MalBIKItemId,
    In_EmployeeSysId,
    In_BIKRecRecurSysId,
    In_PayRecYear,
    In_PayRecPeriod,
    In_PayRecSubPeriod,
    In_PayRecID,
    In_BIKAmount,
    In_BIKCreatedBy);
  commit work;
  if not exists(select* from MalBIKRecord where
      MalBIKRecSGSPGenId = Out_MalBIKRecSGSPGenId) then
    set Out_ErrorCode=0
  else
    set Out_ErrorCode=1
  end if
end;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateMalBIKRecord') then
   drop procedure UpdateMalBIKRecord
end if;
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
in In_BIKCreatedBy char(20),
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
      BIKAmount = In_BIKAmount,
      BIKCreatedBy = In_BIKCreatedBy where
      MalBIKRecord.MalBIKRecSGSPGenId = In_MalBIKRecSGSPGenId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end;

/* SubRegistry */
if not exists(select * from SubRegistry where RegistryId = 'Viewer' and SubRegistryId = 'MalBIKRecordViewer') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('Viewer','MalBIKRecordViewer','BIK Record Viewer','PayModule','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

/* ModuleScreenGroup */
if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'MalBIKRecordViewer') then
  insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values('MalBIKRecordViewer','InterfaceViewer','BIK Record Viewer','InterfaceViewer',0,0,0,'');
end if;

/* ImportFieldTable */
if not exists(select * from ImportFieldTable where TableNamePhysical = 'iMalBIKRecord') then 
   insert into ImportFieldTable(TableNamePhysical,TableNameUserDefined)
   values('iMalBIKRecord','BIK Record');
end if;

/* ImportFieldName */
if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalBIKRecord' and FieldNamePhysical = 'MalBIKEmployeeID') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalBIKRecord','MalBIKEmployeeID','Employee ID','String',1);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalBIKRecord' and FieldNamePhysical = 'MalBIKItemId') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalBIKRecord','MalBIKItemId','BIK Item ID','String',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalBIKRecord' and FieldNamePhysical = 'MalBIKPaidDate') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalBIKRecord','MalBIKPaidDate','Paid Date','Date',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalBIKRecord' and FieldNamePhysical = 'PayRecID') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalBIKRecord','PayRecID','Pay Record ID','String',0);
end if;

if not exists(select * from ImportFieldName where TableNamePhysical = 'iMalBIKRecord' and FieldNamePhysical = 'MalBIKAmount') then
  insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values('iMalBIKRecord','MalBIKAmount','Amount','Numeric',0);
end if;

/* Interface Process Selection */
if not exists(select * from SubRegistry where RegistryId = 'InterfaceProcess' and SubRegistryId = 'BIK Record Process') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('InterfaceProcess','BIK Record Process','BIKRecordProcess.rtf','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

/* Interface Process */
insert into InterfaceProcess(InterfaceProjectID, InterfaceProcessID, InterfaceConnectionId, IntProcExtConnection, IntProcActivate, IntProcRemarks)
select InterfaceProjectID, 'BIK Record Process', NULL, 0,0,''
from InterfaceProject where InterfaceProjectID not in (select InterfaceProjectID from InterfaceProcess where InterfaceProcessID = 'BIK Record Process');

/* Interface Code Table */
if not exists(select * from SubRegistry where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'MalBIKCode') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('InterfaceCodeTable','MalBIKCode','BIK Record Process','','','','','','SELECT MalBIKItemId as EPEID, MalBIKItemDesc as EPEIDDesc FROM MalBIKItem','BIK Item','','',NULL,NULL,'',NULL,'','','1899-12-30','1899-12-30 00:00:00');
end if;

/* Interface Project Code */
insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
select InterfaceProjectID, 'BIK Record Process', 'MalBIKCode', '', 1, 0, ''
from InterfaceProject where InterfaceProjectID not in (select InterfaceProjectID from InterfaceCodeTable where InterfaceProcessID = 'BIK Record Process' and CodeTableID = 'MalBIKCode');

commit work;