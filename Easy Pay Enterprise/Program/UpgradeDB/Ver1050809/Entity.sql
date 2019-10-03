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
    constraint PK_RPTGRIDSETTINGS primary key (RptGridSettingsId, RptGridModule),
    constraint AK_IDENTIFIER_2_RPTGRIDS unique (RptGridSettingsId)
);

/*==============================================================*/
/* Index: RptGridSettings_PK                                    */
/*==============================================================*/
create unique index RptGridSettings_PK on RptGridSettings (
RptGridSettingsId ASC,
RptGridModule ASC
);


/*==============================================================*/
/* Table: TmplVariables                                         */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='TmplVariables') then
    drop table TmplVariables
end if;

create table DBA.TmplVariables 
(
    TmplFolderID         char(20)                       not null,
    Keyword1Id           char(20),
    Keyword2Id           char(20),
    Keyword3Id           char(20),
    Keyword4Id           char(20),
    Keyword5Id           char(20),
    Keyword1Desc         char(50),
    Keyword2Desc         char(50),
    Keyword3Desc         char(50),
    Keyword4Desc         char(50),
    Keyword5Desc         char(50),
    StrVar1              char(50),
    StrVar2              char(50),
    StrVar3              char(50),
    StrVar4              char(50),
    StrVar5              char(50),
    NumVar1              char(50),
    NumVar2              char(50),
    NumVar3              char(50),
    NumVar4              char(50),
    NumVar5              char(50),
    DateVar1             char(50),
    DateVar2             char(50),
    Keyword1DefValue     char(50),
    Keyword2DefValue     char(50),
    Keyword3DefValue     char(50),
    Keyword4DefValue     char(50),
    Keyword5DefValue     char(50),
    StrVar1DefValue      char(50),
    StrVar2DefValue      char(50),
    StrVar3DefValue      char(50),
    StrVar4DefValue      char(50),
    StrVar5DefValue      char(50),
    NumVar1DefValue      double,
    NumVar2DefValue      double,
    NumVar3DefValue      double,
    NumVar4DefValue      double,
    NumVar5DefValue      double,
    DateVar1DefValue     date,
    DateVar2DefValue     date,
    constraint PK_TMPLVARIABLES primary key clustered (TmplFolderID)
);

/*==============================================================*/
/* Index: TmplVariables_PK                                      */
/*==============================================================*/
create unique index TmplVariables_PK on TmplVariables (
TmplFolderID ASC
);

alter table TmplVariables
   add constraint FK_TMPLVARI_RELATIONS_TMPLFOLD foreign key (TmplFolderID)
      references TmplFolder (TmplFolderID)
      on update restrict
      on delete restrict;

commit work;