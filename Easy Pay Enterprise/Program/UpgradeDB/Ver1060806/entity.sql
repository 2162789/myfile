
/*==============================================================*/
/* Table: IR21A1S4S5                                       */
/*==============================================================*/

if not exists (select * from sys.systable where table_name = 'IR21A1S4S5') then

create table DBA.IR21A1S4S5 
(
    PersonalSysId        integer                        not null,
    YEYear               integer                        not null,
    ResidenceAddress1    char(100),
    Address1OccupationFrom date,
    Address1OccupationTo date,
    Address1OccupationDays integer,
    Address1AnnualValue  double,
    Address1FurnishedStatus char(20),
    Address1FurnitureFittingsValue double,
    Address1PaidByEmployer double,
    Address1ResidenceValue double,
    ResidenceAddress2    char(100),
    Address2OccupationFrom date,
    Address2OccupationTo date,
    Address2OccupationDays integer,
    Address2AnnualValue  double,
    Address2FurnishedStatus char(20),
    Address2FurnitureFittingsValue double,
    Address2PaidByEmployer double,
    Address2ResidenceValue double,
    Address12PaidByEmployee double,
    PUBTelPagerValue     double,
    Driver               double,
    ServantGardener      double,
    TotalValueofAccommodation double,
    HotelAccommodation   double,
    TotalHotelAccommodation double,
    TotalValueofUtilities double,
    constraint PK_IR21A1S4S5 primary key clustered (PersonalSysId, YEYear)
);

/*==============================================================*/
/* Index: IR21A1S4S5_PK                                         */
/*==============================================================*/

create unique index IR21A1S4S5_PK on IR21A1S4S5 (
PersonalSysId ASC,
YEYear ASC
);



end if;


commit work;