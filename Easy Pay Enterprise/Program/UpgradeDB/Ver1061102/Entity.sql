if exists(SELECT * FROM sys.systable where table_name = 'iA8ASection2') then
  drop table iA8ASection2;
end if;

/*==============================================================*/
/* Table: iA8ASection2                                          */
/*==============================================================*/
create table DBA.iA8ASection2 
(
    A8ASection2SysId     integer                        not null default AUTOINCREMENT,
    A8AIdentityNo        char(30),
    YEYear               integer,
    AnnualValue          double,
    FurnishedStatus      char(20),
    FurnitureFittingsValue double,
    RentPaidToLandlord   double,
    ResidenceValue       double,
    RentPaidByEmployee   double,
    TotalTaxableResidenceValue double,
    UtilityTelPagerValue double,
    Driver               double,
    ServantGardener      double,
    TotalValueofUtilities double,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IA8ASECTION2 primary key (A8ASection2SysId)
);

/*==============================================================*/
/* Index: iA8ASection2_PK                                       */
/*==============================================================*/
create unique index iA8ASection2_PK on iA8ASection2 (
A8ASection2SysId ASC
);

if exists(SELECT * FROM sys.systable where table_name = 'iA8ASection3') then
  drop table iA8ASection3;
end if;
/*==============================================================*/
/* Table: iA8ASection3                                          */
/*==============================================================*/
create table DBA.iA8ASection3 
(
    A8ASection3SysId     integer                        not null default AUTOINCREMENT,
    A8AIdentityNo        char(30),
    YEYear               integer,
    HotelAccommodation   double,
    HotelAmtPaidByEmployee double,
    TotalHotelAccommodation double,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IA8ASECTION3 primary key (A8ASection3SysId)
);

/*==============================================================*/
/* Index: iA8ASection3_PK                                       */
/*==============================================================*/
create unique index iA8ASection3_PK on iA8ASection3 (
A8ASection3SysId ASC
);

commit work;