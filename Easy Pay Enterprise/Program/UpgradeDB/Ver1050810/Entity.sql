/*==============================================================*/
/* Table: RptGridSettings                                       */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='RptGridSettings') then
    drop table RptGridSettings
end if;

create table DBA.RptGridSettings 
(
    RptGridSettingsId    char(20)                       not null,
    RptGridModule        char(20)                       not null,
    RptGridCreatedBy     char(20)                       not null,
    RptGridSettingsObj   long binary                    not null,
    constraint PK_RPTGRIDSETTINGS primary key (RptGridSettingsId, RptGridModule)
);

/*==============================================================*/
/* Index: RptGridSettings_PK                                    */
/*==============================================================*/
create unique index RptGridSettings_PK on RptGridSettings (
RptGridSettingsId ASC,
RptGridModule ASC
);

commit work;