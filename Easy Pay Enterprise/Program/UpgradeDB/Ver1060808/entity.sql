
if not exists(select 1 from sys.syscolumns where tname='Employee' and cname='IsSalaryDeductCap') then
    alter table DBA.Employee Add IsSalaryDeductCap smallint                       default 0;
end if;

if not exists(select 1 from sys.syscolumns where tname='PayRecord' and cname='IsExceedAuthDeductCap') then
    alter table DBA.PayRecord Add IsExceedAuthDeductCap smallint                       default 0;
end if;

commit work;