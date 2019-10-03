if not exists (select 1 from sys.syscolumns where tname='ModuleScreenGroup' and cname='IsEPClassic') then
   alter table dba.ModuleScreenGroup add IsEPClassic smallint;
end if;

if not exists (select 1 from sys.syscolumns where tname='ModuleScreenGroup' and cname='EC_ModuleScreenId') then
   alter table dba.ModuleScreenGroup add EC_ModuleScreenId char(20);
end if;