/*==============================================================*/
/* Table: iBank                                         */
/*==============================================================*/
if exists(select 1 from sys.syscolumns where tname='iBank' and cname='BankBoolean1') then
    alter table iBank alter BankBoolean1 smallint default 0;
end if;

if exists(select 1 from sys.syscolumns where tname='iBank' and cname='BankDate1') then
    alter table iBank alter BankDate1 date;
end if;

if exists(select 1 from sys.syscolumns where tname='iBank' and cname='BankInteger1') then
    alter table iBank alter BankInteger1 int default 0;
end if;

if exists(select 1 from sys.syscolumns where tname='iBank' and cname='BankNumeric1') then
    alter table iBank alter BankNumeric1 double default 0;
end if;

if exists(select 1 from sys.syscolumns where tname='iBank' and cname='BankString1') then
    alter table iBank alter BankString1 char(100);
end if;

if exists(select 1 from sys.syscolumns where tname='iBank' and cname='BankString2') then
    alter table iBank alter BankString2 char(100);
end if;

if exists(select 1 from sys.syscolumns where tname='iBank' and cname='BankString3') then
    alter table iBank alter BankString3 char(100);
end if;

commit work;