/*==============================================================*/
/* Table: ProductFeatures                                       */
/*==============================================================*/
if not exists (select * from sys.systable where table_name = 'ProductFeatures') then
create table DBA.ProductFeatures 
(
    ProductFeaturesSysId integer                        not null,
    Module               char(20),
    Function             varchar(2048),
    Details              varchar(3000),
    ExpiryDate           date,
    PublishDate          date,
    CheckCode            char(40),
    constraint PK_PRODUCTFEATURES primary key (ProductFeaturesSysId)
);

/*==============================================================*/
/* Index: ProductFeatures_PK                                    */
/*==============================================================*/
create unique index ProductFeatures_PK on ProductFeatures (
ProductFeaturesSysId ASC
);
end if;

/*==============================================================*/
/* Table: CRCustom                                              */
/*==============================================================*/
if not exists (select * from sys.systable where table_name = 'CRCustom') then
create table DBA.CRCustom 
(
    CRCustomSysId        integer                        not null default AUTOINCREMENT,
    CRId                 char(20),
    CRFilename           char(50),
    CRTitle              char(50),
    CRDesc               char(100),
    CRTemplate           long binary,
    LastModified         timestamp                      default timestamp,
    constraint PK_CRCUSTOM primary key (CRCustomSysId)
);

/*==============================================================*/
/* Index: CRCustom_PK                                           */
/*==============================================================*/
create unique index CRCustom_PK on CRCustom (
CRCustomSysId ASC
);
end if;

/*==============================================================*/
/* Table: GeneralBlob                                              */
/*==============================================================*/
if not exists(select * from sys.syscolumns where tname = 'GeneralBlob' and cname = 'IsCustom') then
   Alter table DBA.GeneralBlob Add IsCustom smallint Default NULL;
end if;

commit work;