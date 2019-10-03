Read UpgradeDB\Ver1061101\SG_2015JulyFWL.sql; 

if exists(select 1 from Holidays where CountryId = 'Singapore' and HolidayStartDate = '2015-08-07' group by CountryId, HolidayStartDate having COUNT(1) > 1) then
   delete from Holidays where CountryId = 'Singapore' and HolidayId = 'SG50 Public Holiday' and HolidayStartDate = '2015-08-07';
end if;

/* Insert data to the SystemAttribute Table */

IF EXISTS (select * from subregistry where registryid='system' and subregistryid='dbcountry' and regproperty1='Singapore') Then
  IF NOT EXISTS(Select * from dba.SystemAttribute where SysTableId='PersonalAddress' and SysAttributeId='CustString1') Then
   Insert into  dba.SystemAttribute (SYSTABLEID,SYSATTRIBUTEID,SYSUSERDEFINEDNAME,SYSSPECIALATTRIBUTE)
   values ('PersonalAddress','CustString1','Address Type',0);
  END IF;

 IF NOT EXISTS(Select * from dba.SystemAttribute where SysTableId='PersonalAddress' and SysAttributeId='CustString2') Then
   Insert into  dba.SystemAttribute (SYSTABLEID,SYSATTRIBUTEID,SYSUSERDEFINEDNAME,SYSSPECIALATTRIBUTE)
   values ('PersonalAddress','CustString2','Block/House No',0);
  END IF;

 IF NOT EXISTS(Select * from dba.SystemAttribute where SysTableId='PersonalAddress' and SysAttributeId='CustString3') Then
  Insert into  dba.SystemAttribute (SYSTABLEID,SYSATTRIBUTEID,SYSUSERDEFINEDNAME,SYSSPECIALATTRIBUTE)
  values ('PersonalAddress','CustString3','Street Name',0)
 END IF;

  IF NOT EXISTS(Select * from dba.SystemAttribute where SysTableId='PersonalAddress' and SysAttributeId='CustString4') Then
   Insert into  dba.SystemAttribute (SYSTABLEID,SYSATTRIBUTEID,SYSUSERDEFINEDNAME,SYSSPECIALATTRIBUTE)
   values ('PersonalAddress','CustString4','Level No',0)
  END IF;

  IF NOT EXISTS(Select * from dba.SystemAttribute where SysTableId='PersonalAddress' and SysAttributeId='CustString5') Then
    Insert into  dba.SystemAttribute (SYSTABLEID,SYSATTRIBUTEID,SYSUSERDEFINEDNAME,SYSSPECIALATTRIBUTE)
    values ('PersonalAddress','CustString5','Unit No',0);
  END IF;

  IF NOT EXISTS(Select * from dba.SystemAttribute where SysTableId='PersonalAddress' and SysAttributeId='CustString6') Then
    Insert into  dba.SystemAttribute (SYSTABLEID,SYSATTRIBUTEID,SYSUSERDEFINEDNAME,SYSSPECIALATTRIBUTE)
    values ('PersonalAddress','CustString6','CustString6',0);
  END IF;

/* Create Triggers on PesonalAddress Table (Update) */

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_CustString1') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_CustString1" after update of CustString1
order 9 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'CustString1', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.CustString1,new_record.CustString1,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_CustString2') then
 CREATE TRIGGER "AuditTrailUpdatePersonalAddress_CustString2" after update of CustString2
order 10 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'CustString2', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.CustString2,new_record.CustString2,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_CustString3') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_CustString3" after update of CustString3
order 11 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'CustString3', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.CustString3,new_record.CustString3,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_CustString4') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_CustString4" after update of CustString4
order 12 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'CustString4', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.CustString4,new_record.CustString4,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_CustString5') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_CustString5" after update of CustString5
order 13 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'CustString5', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.CustString5,new_record.CustString5,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;

IF NOT EXISTS(select * from sys.systrigger where trigger_name='AuditTrailUpdatePersonalAddress_CustString6') then
CREATE TRIGGER "AuditTrailUpdatePersonalAddress_CustString6" after update of CustString6
order 14 on DBA.PersonalAddress
referencing old as old_record new as new_record
for each row
begin
  insert into AuditTrailTable(AuditUserID,AuditIP,AuditTimeStamp,AuditEventType,
	 AuditTableName,AuditFieldName,AuditEmpID,BeforeValue,AfterValue,AuditKey1,AuditKey2,AuditKey3) values(
	 connection_property('Userid'),connection_property('NodeAddress'),NOW(*),'Update','PersonalAddress',
    'CustString6', FGetEmployeeIdByPersonalSysId(new_record.PersonalSysId),old_record.CustString6,new_record.CustString6,
    new_record.PersonalAddressId,new_record.PersonalSysId,new_record.ContactLocationId);
end;
END IF;


END IF;




commit work;