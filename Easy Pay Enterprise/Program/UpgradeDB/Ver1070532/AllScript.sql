Read UpgradeDB\Ver1070532\StoredProc.sql;

/*---------------------------------------------------------------------------
	Add in 2 new columns to LeaveRecord (LvePayrollYear and LvePayrollPeriod)
----------------------------------------------------------------------------*/
if not exists (select * from sys.syscolumns where tname = 'LeaveRecord' and cname = 'LvePayrollYear') then
    alter table LeaveRecord add LvePayrollYear int null;
end if;
if not exists (select * from sys.syscolumns where tname = 'LeaveRecord' and cname = 'LvePayrollPeriod') then
    alter table LeaveRecord add LvePayrollPeriod int null;
end if;

commit work;