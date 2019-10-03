/*==============================================================*/
/* Table: ESSBatchDetails                                       */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='ESSBatchDetails') then
    drop table ESSBatchDetails
end if;
create table DBA.ESSBatchDetails 
(
    ESSBatchDetailsSysId integer                        not null default autoincrement,
    ESSBatchSysId        integer                        not null,
    ESSBDEPETableName    char(50),
    ESSBDEPESysId        integer,
    ESSBDStatus          smallint,
    ESSBDMessage         char(1000),
    constraint PK_ESSBATCHDETAILS primary key (ESSBatchDetailsSysId)
);

/*==============================================================*/
/* Index: ESSBatchDetails_PK                                    */
/*==============================================================*/
create unique index ESSBatchDetails_PK on ESSBatchDetails (
ESSBatchDetailsSysId ASC
);

/*==============================================================*/
/* Index: Relationship_771_FK                                   */
/*==============================================================*/
create  index Relationship_771_FK on ESSBatchDetails (
ESSBatchSysId ASC
);

alter table ESSBatchDetails
   add constraint FK_ESSBATCH_RELATIONS_ESSBATCH foreign key (ESSBatchSysId)
      references ESSBatch (ESSBatchSysId)
      on update restrict
      on delete restrict;

commit work;