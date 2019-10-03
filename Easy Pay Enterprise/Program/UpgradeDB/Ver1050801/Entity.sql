/*==============================================================*/
/* Table: UsageGrp                                              */
/*==============================================================*/
if not exists(select 1 from sys.systable where table_name='UsageGrp') then
create table dba.UsageGrp 
(
    UsageGrpID           char(20)                       not null,
    UsageGrpDesc         char(100),
    constraint PK_USAGEGRP primary key (UsageGrpID)
);

/*==============================================================*/
/* Index: UsageGrp_PK                                           */
/*==============================================================*/
create unique index UsageGrp_PK on UsageGrp (
UsageGrpID ASC
);
end if;

/*==============================================================*/
/* Table: UsageItem                                             */
/*==============================================================*/
if not exists(select 1 from sys.systable where table_name='UsageItem') then
create table dba.UsageItem 
(
    UsageItemID          char(20)                       not null,
    UsageGrpID           char(20)                       not null,
    ItemDesc             char(100),
    ItemKey1Desc         char(100),
    ItemKey2Desc         char(100),
    ItemKey3Desc         char(100),
    FieldLoc             char(50),
    Query                char(255),
    QueryCond            char(255),
    constraint PK_USAGEITEM primary key (UsageItemID)
);

/*==============================================================*/
/* Index: UsageItem_PK                                          */
/*==============================================================*/
create unique index UsageItem_PK on UsageItem (
UsageItemID ASC
);

/*==============================================================*/
/* Index: Relationship_755_FK                                   */
/*==============================================================*/
create  index Relationship_755_FK on UsageItem (
UsageGrpID ASC
);

alter table UsageItem
   add constraint FK_USAGEITE_RELATIONS_USAGEGRP foreign key (UsageGrpID)
      references UsageGrp (UsageGrpID)
      on update restrict
      on delete restrict;
end if;

/*==============================================================*/
/* Table: UsageItemRecord                                       */
/*==============================================================*/
if not exists(select 1 from sys.systable where table_name='UsageItemRecord') then
create table dba.UsageItemRecord 
(
    UsageItemRecSysID    integer                        not null default AUTOINCREMENT,
    UsageItemID          char(20)                       not null,
    ItemRefKey1          char(50)                       not null,
    ItemRefKey2          char(50)                       not null,
    ItemRefKey3          char(50)                       not null,
    IntegerValue         integer,
    DoubleValue          double,
    StringValue          char(100),
    DateValue            date,
    ModifyDateTime       timestamp,
    constraint PK_USAGEITEMRECORD primary key (UsageItemRecSysID)
);

/*==============================================================*/
/* Index: UsageItemRecord_PK                                    */
/*==============================================================*/
create unique index UsageItemRecord_PK on UsageItemRecord (
UsageItemRecSysID ASC
);

/*==============================================================*/
/* Index: Relationship_754_FK                                   */
/*==============================================================*/
create  index Relationship_754_FK on UsageItemRecord (
UsageItemID ASC
);

alter table UsageItemRecord
   add constraint FK_USAGEITE_RELATIONS_USAGEITE foreign key (UsageItemID)
      references UsageItem (UsageItemID)
      on update restrict
      on delete restrict;
end if;

commit work;