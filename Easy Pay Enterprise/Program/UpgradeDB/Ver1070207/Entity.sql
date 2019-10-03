if not exists(select 1 from sys.syscolumns where tname='IR8A' and cname='OverseasPostingPeriod') then
    alter table DBA.IR8A Add OverseasPostingPeriod char(20);
end if;

commit work;