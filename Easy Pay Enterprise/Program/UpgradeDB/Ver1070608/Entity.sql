/*==============================================================*/
/* Table: BatchRptItem                                       */
/*==============================================================*/
if exists(select 1 from sys.syscolumns where tname = 'BatchRptItem' and cname = 'RptWebAPIRefNo') then
    alter table DBA.BatchRptItem delete RptWebAPIRefNo;
end if;

/*==============================================================*/
/* Table: BatchRptItemAdd                                       */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='BatchRptItemAdd') then
    drop table BatchRptItemAdd
end if;
create table DBA.BatchRptItemAdd 
(
	BatRptItemAddSysId   integer                        not null default autoincrement,
	BatchRptSysId        char(30),
	BatchRptItemSysId    integer,
	BatRptItModule       char(30),
	BatRptItSubModule    char(30),
	BatRptItFileName     char(255),
	BatRptItFileSize     integer,
	BatRptItFilePageCount integer,
	BatRptItProcess      smallint,
	BatRptItProcessDateTime timestamp,
	constraint PK_BATCHRPTITEMADD primary key (BatRptItemAddSysId)
);

/*==============================================================*/
/* Index: BatchRptItemAdd_PK                                    */
/*==============================================================*/
create unique index BatchRptItemAdd_PK on BatchRptItemAdd (
BatRptItemAddSysId ASC
);

/*==============================================================*/
/* Index: Relationship_773_FK                                   */
/*==============================================================*/
create  index Relationship_773_FK on BatchRptItemAdd (
BatchRptSysId ASC,
BatchRptItemSysId ASC
);

alter table BatchRptItemAdd
   add constraint FK_BATCHRPT_RELATIONS_BATCHRPT foreign key (BatchRptSysId, BatchRptItemSysId)
      references BatchRptItem (BatchRptSysId, BatchRptItemSysId)
      on update restrict
      on delete restrict;

commit work;