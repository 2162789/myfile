if not exists (select 1 from sys.syscolumns where tname='MalBIKItem' and cname='MalBIKAddTax') 
then
   alter table dba.MalBIKItem add MalBIKAddTax smallint default 0;
end if;


if not exists (select 1 from sys.syscolumns where tname='PhTaxEmployer' and cname='PhRegionNo') 
then
   alter table dba.PhTaxEmployer add PhRegionNo char(4);
end if;


if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='iYTDBIKRecord_PK'
     and t.table_name='iYTDBIKRecord'
) then
   drop index iYTDBIKRecord.iYTDBIKRecord_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iYTDBIKRecord'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iYTDBIKRecord
end if;

/*==============================================================*/
/* Table: iYTDBIKRecord                                         */
/*==============================================================*/
create table dba.iYTDBIKRecord 
(
    YTDBIKSysId          integer                        not null default AUTOINCREMENT,
    YTDBIKEmployeeId     char(30),
    YTDBIKYear           integer,
    YTDBIKPeriod         integer,
    YTDBIKId             char(20),
    BIKAmount            double,
    RecurBIKId           char(20),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IYTDBIKRECORD primary key (YTDBIKSysId)
);

/*==============================================================*/
/* Index: iYTDBIKRecord_PK                                      */
/*==============================================================*/
create unique index iYTDBIKRecord_PK on iYTDBIKRecord (
YTDBIKSysId ASC
);



if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='iYTDDMBRecord_PK'
     and t.table_name='iYTDDMBRecord'
) then
   drop index iYTDDMBRecord.iYTDDMBRecord_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iYTDDMBRecord'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iYTDDMBRecord
end if;


/*==============================================================*/
/* Table: iYTDDMBRecord                                         */
/*==============================================================*/
create table dba.iYTDDMBRecord 
(
    YTDDMBSysId          integer                        not null default AUTOINCREMENT,
    YTDDMBEmployeeId     char(30),
    YTDDMBYear           integer,
    YTDDMBPeriod         integer,
    YTDDMBId             char(20),
    DMBAmount            double,
    RecurDMBId           char(20),
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    InterfaceGranted     smallint,
    constraint PK_IYTDDMBRECORD primary key (YTDDMBSysId)
);

/*==============================================================*/
/* Index: iYTDDMBRecord_PK                                      */
/*==============================================================*/
create unique index iYTDDMBRecord_PK on iYTDDMBRecord (
YTDDMBSysId ASC
);
