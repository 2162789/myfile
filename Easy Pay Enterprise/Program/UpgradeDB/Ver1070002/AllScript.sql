Read UpgradeDB\Ver1070002\StoredProc.sql;

/* Pay Detail OT Table */
if not exists (select 1 from sys.syscolumns where tname = 'iPayEmployee' and cname = 'OTTableId') then
  alter table iPayEmployee add OTTableId char(20)
end if;
if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iPayEmployee' and FieldNamePhysical = 'OTTableId') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values ('iPayEmployee','OTTableId','Overtime Table','String',0);
end if;
if not exists (select 1 from SubRegistry where RegistryId = 'InterfaceAttribute' and SubRegistryId = 'OTTableId') then
  insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values ('InterfaceAttribute','OTTableId','PayEmployee','','','','','','OTTableId','Overtime Table','','',NULL,NULL,'',NULL,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;
insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
select InterfaceProject.InterfaceProjectID,'OTTableId','PayEmployee',0,'OTTableId' from InterfaceProject left join InterfaceAttribute
on InterfaceProject.InterfaceProjectID = InterfaceAttribute.InterfaceProjectID and InterfaceAttribute.InterfaceAttributeID = 'OTTableId' and InterfaceAttrTableID = 'PayEmployee'
where InterfaceAttribute.InterfaceProjectID is null;

/* Process Supervisor Employment Record first during Interface Processing */
if exists (select 1 from sys.sysprocedure where proc_name = 'ASQLReOrderiEmployee') then
  drop procedure ASQLReOrderiEmployee
end if;
create procedure DBA.ASQLReOrderiEmployee()
begin
declare EmployeePicked smallint;
if exists (select 1 from sys.systable where table_name = 'iEmployeeTemp') then
  drop table iEmployeeTemp
end if;
select * into iEmployeeTemp from iEmployee;
truncate table iEmployeeTemp;
lbl:
loop
  set EmployeePicked = 0;
  EmployeeLoop: for SupervisorFor as SupervisorCurs dynamic scroll cursor for
    select EmployeeId as In_EmployeeId, Supervisor as In_Supervisor from iEmployee do
    if ISNULL(In_Supervisor, '') = '' or exists (select 1 from iEmployeeTemp where EmployeeId = In_Supervisor and ISNULL(Processed, 0) = 0) then
      insert into iEmployeeTemp select * from iEmployee where EmployeeId = In_EmployeeId and ISNULL(Supervisor, '') = ISNULL(In_Supervisor, '');
      delete from iEmployee where EmployeeId = In_EmployeeId and ISNULL(Supervisor, '') = ISNULL(In_Supervisor, '');
	  set EmployeePicked = 1;
    end if;
  end for;
  if EmployeePicked = 0 or not exists (select 1 from iEmployee) then
    insert into iEmployeeTemp select * from iEmployee;
    truncate table iEmployee;
    leave lbl;
  end if;
end loop lbl;
insert into iEmployee select * from iEmployeeTemp;
if exists (select 1 from sys.systable where table_name = 'iEmployeeTemp') then
  drop table iEmployeeTemp
end if;
end;

/* Default Payment Method */
if not exists (select 1 from SubRegistry where RegistryId = 'PayOption' and SubRegistryId = 'DefaultPaymentMethod') then
  insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values ('PayOption','DefaultPaymentMethod','','','','','','','','','','',0.0,0,'',0,'ByCash','','1899-12-30','1899-12-30 00:00:00.000')
end if;

commit work;