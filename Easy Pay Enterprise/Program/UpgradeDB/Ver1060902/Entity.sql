if exists(select 1 from sys.syscolumns where tname='PaymentBankInfo' and cname='BankAccountNo') then
    alter table DBA.PaymentBankInfo Alter BankAccountNo char(50);
end if;

if exists(select 1 from sys.syscolumns where tname='BankRecord' and cname='PaymentBankAccNo') then
    alter table DBA.BankRecord Alter PaymentBankAccNo char(50);
end if;

if exists(select 1 from sys.syscolumns where tname='iPaymentBankInfo' and cname='BankAccountNo') then
    alter table DBA.iPaymentBankInfo Alter BankAccountNo char(50);
end if;

if exists(select 1 from sys.syscolumns where tname='iPaymentBankInfo' and cname='NewBankAccountNo') then
    alter table DBA.iPaymentBankInfo Alter NewBankAccountNo char(50);
end if;

if not exists(select 1 from sys.syscolumns where tname='YEEmployee' and cname='BankSalaryCredited') then
    alter table DBA.YEEmployee Add BankSalaryCredited char(100);
end if;

if not exists(select 1 from sys.syscolumns where tname='A8AS2S3')  then
/*==============================================================*/
/* Table: A8AS2S3                                               */
/*==============================================================*/
create table DBA.A8AS2S3 
(
    PersonalSysId        integer                        not null,
    YEYear               integer                        not null,
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
    HotelAccommodation   double,
    HotelAmtPaidByEmployee double,
    TotalHotelAccommodation double,
    constraint PK_A8AS2S3 primary key clustered (PersonalSysId, YEYear)
);

/*==============================================================*/
/* Index: A8AS2S3_PK                                            */
/*==============================================================*/
create unique index A8AS2S3_PK on DBA.A8AS2S3 (
PersonalSysId ASC,
YEYear ASC
);

end if;

commit work;