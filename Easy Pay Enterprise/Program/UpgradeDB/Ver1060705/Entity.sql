if exists(select 1 from sys.syscolumns where tname='A8AS2' and cname='Sec2Items') then
    alter table DBA.A8AS2 Modify Sec2Items char(100);
end if;

if not exists(select 1 from sys.syscolumns where tname='IR8A' and cname='RetirementPaymentDate') then
    alter table DBA.IR8A Add RetirementPaymentDate date;
end if;

commit work;