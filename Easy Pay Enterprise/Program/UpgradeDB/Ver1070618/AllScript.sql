Read UpgradeDB\Ver1070618\StoredProc.sql;

if not exists(select * from sys.syscolumns where tname = 'iLeaveApplication' and cname = 'LveAppProcessedID') then
	ALTER TABLE iLeaveApplication ADD LveAppProcessedID integer;
end if;

commit work;