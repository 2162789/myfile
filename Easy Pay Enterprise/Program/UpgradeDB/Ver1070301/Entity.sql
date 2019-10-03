/*==============================================================*/
/* Table: iMalBIKRecord                                       */
/*==============================================================*/
if not exists (select * from sys.systable where table_name = 'iMalBIKRecord') then
create table DBA.iMalBIKRecord
(
    MalBIKSysId    integer                        not null default AUTOINCREMENT,
    MalBIKEmployeeID char(30),
    MalBIKItemId     char(20),
    MalBIKPaidDate  date,
    PayRecID  char(20),
    MalBIKAmount    double,
    PayRecYear      integer,
    PayRecPeriod    integer,
    PayRecSubPeriod  integer,   
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IMALBIKRECORD primary key (MalBIKSysId)
);

/*==============================================================*/
/* Index: iMalBIKRecord_PK                                      */
/*==============================================================*/
create unique index iMalBIKRecord_PK on iMalBIKRecord (
MalBIKSysId ASC
);

end if;

/*==============================================================*/
/* Table: MalBIKRecord                                       */
/*==============================================================*/
if not exists(select * from sys.syscolumns where tname = 'MalBIKRecord' and cname = 'BIKCreatedBy') then
  alter table DBA.MalBIKRecord add BIKCreatedBy char(20);
  Update MalBIKRecord Set BIKCreatedBy = '';
end if;

commit work;