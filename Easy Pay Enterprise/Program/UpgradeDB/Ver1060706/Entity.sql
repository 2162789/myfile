if not exists(select 1 from sys.syscolumns where tname='YEEmployee' and cname='NationalityDesc') then
    alter table DBA.YEEmployee Add NationalityDesc char(100);
end if;

commit work;