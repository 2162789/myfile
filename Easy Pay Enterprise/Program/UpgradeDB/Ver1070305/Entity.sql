if not exists(select 1 from sys.syscolumns where tname='Department' and cname='DepartmentHist') then
    alter table DBA.Department Add DepartmentHist smallint default 0;
end if;

commit work;