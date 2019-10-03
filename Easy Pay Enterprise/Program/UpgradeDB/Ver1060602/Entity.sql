if exists (select * from sys.systable where table_name = 'CRCustom') then 
 drop table CRCustom;
end if;


/*==============================================================*/
/* Table: CRCustom                                              */
/*==============================================================*/
if not exists (select * from sys.systable where table_name = 'CRCustom') then
/*==============================================================*/
/* Table: CRCustom                                              */
/*==============================================================*/
create table DBA.CRCustom 
(
    CRCustomSysId        integer                        not null default AUTOINCREMENT,
    CRId                 char(20),
    CRFilename           char(50),
    CRTitle              char(50),
    CRDesc               char(100),
    CRTemplate           long binary,
    LastImportDateTime   timestamp,
    constraint PK_CRCUSTOM primary key (CRCustomSysId)
);

/*==============================================================*/
/* Index: CRCustom_PK                                           */
/*==============================================================*/
create unique index CRCustom_PK on CRCustom (
CRCustomSysId ASC
);


end if;


commit work;