/*==============================================================*/
/* Table: iBank                                         */
/*==============================================================*/
if not exists(select 1 from sys.syscolumns where tname='iBank' and cname='BankBoolean1') then
    alter table iBank add BankBoolean1 smallint default 0;
end if;

if not exists(select 1 from sys.syscolumns where tname='iBank' and cname='BankDate1') then
    alter table iBank add BankDate1 date;
end if;

if not exists(select 1 from sys.syscolumns where tname='iBank' and cname='BankInteger1') then
    alter table iBank add BankInteger1 int default 0;
end if;

if not exists(select 1 from sys.syscolumns where tname='iBank' and cname='BankNumeric1') then
    alter table iBank add BankNumeric1 double default 0;
end if;

if not exists(select 1 from sys.syscolumns where tname='iBank' and cname='BankString1') then
    alter table iBank add BankString1 char(100);
end if;

if not exists(select 1 from sys.syscolumns where tname='iBank' and cname='BankString2') then
    alter table iBank add BankString2 char(100);
end if;

if not exists(select 1 from sys.syscolumns where tname='iBank' and cname='BankString3') then
    alter table iBank add BankString3 char(100);
end if;

commit work;