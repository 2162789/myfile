/*==============================================================*/
/* Table: iMalTaxDetails                                       */
/*==============================================================*/
if not exists (select * from sys.systable where table_name = 'iMalTaxDetails') then
create table DBA.iMalTaxDetails
(
    MalTaxDetailsSysId    integer                        not null default AUTOINCREMENT,
    MalTaxDetailsIdentityNo char(30),
    MalTaxPolicyId        char(20),
    MalTaxEmployerId      char(20),
    MalTaxEETaxRefNo     char(20),
    MalTaxMethod          char(20),
    MalTaxChildRelief       double,
    MalTaxNoChildRelief     integer,
    MalTaxNoChildBelow18    integer,
    MalTaxSpouseTaxRefNo    char(20),
    MalTaxSpouseWorking       smallint,
    MalTaxSpouseTaxBranchId char(20),
    MalTaxPriority         smallint,
    MalTaxScheme       char(20),
    IsHandicapped       smallint,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IMALTAXDETAILS primary key (MalTaxDetailsSysId)
);

/*==============================================================*/
/* Index: iMalTaxDetails_PK                                      */
/*==============================================================*/
create unique index iMalTaxDetails_PK on iMalTaxDetails (
MalTaxDetailsSysId ASC
);

end if;

commit work;