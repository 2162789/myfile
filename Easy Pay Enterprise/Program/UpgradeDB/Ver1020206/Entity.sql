if not exists (select 1 from sys.syscolumns where tname='AccpacExportLog' and cname='APVersion') then
   alter table dba.AccpacExportLog add APVersion char(5);
end if;

commit work;