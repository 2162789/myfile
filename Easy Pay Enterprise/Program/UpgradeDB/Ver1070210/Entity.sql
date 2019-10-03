if exists(select 1 from sys.syscolumns where tname='BankSubmitFormat' and cname='StringField1') then
    alter table DBA.BankSubmitFormat alter StringField1 char(100);
end if;

if exists(select 1 from sys.syscolumns where tname='BankSubmitFormat' and cname='StringField2') then
    alter table DBA.BankSubmitFormat alter StringField2 char(100);
end if;

commit work;