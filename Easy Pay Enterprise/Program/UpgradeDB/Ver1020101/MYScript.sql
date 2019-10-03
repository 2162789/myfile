if not exists (select 1 from sys.syscolumns where tname='MalBIKRecord' and cname='BIKRecRecurSysID') then
   alter table MalBIKRecord add BIKRecRecurSysID integer;
end if;

if exists (select 1 from sys.syscolumns where tname='MalBIKRecord' and cname='BIKRecurSysID') then
Update MalBIKRecord 
Set BIKRecRecurSysId = BIKRecurSysId;
end if;

if exists (select 1 from sys.sysconstraint where constraint_name ='FK_MALBIKRE_RELATIONS_MALBIKRE') then
	alter table MalBIKRecord DELETE FOREIGN KEY FK_MALBIKRE_RELATIONS_MALBIKRE;
end if;

if not exists (select 1 from sys.syscolumns where tname='MalBIKRecord' and cname='BIKRecRecurSysID') then
   alter table MalBIKRecord delete BIKRecurSysID;
end if;

COMMIT WORK;