/*==============================================================*/
/* Table: ESSBatch                                       */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='ESSBatch') then
    drop table ESSBatch
end if;
create table DBA.ESSBatch 
(
    ESSBatchSysId        integer                        not null default autoincrement,
    ESSBSyncDateTime     timestamp,
    ESSBBatchRefID       char(30),
    ESSBAction           char(20),
    ESSBStatus           smallint,
    ESSBMessage          char(1000),
    constraint PK_ESSBATCH primary key (ESSBatchSysId)
);

/*==============================================================*/
/* Index: ESSBatch_PK                                           */
/*==============================================================*/
create unique index ESSBatch_PK on ESSBatch (
ESSBatchSysId ASC
);

/*==============================================================*/
/* Table: ESSBatchDetails                                       */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='ESSBatchDetails') then
    drop table ESSBatchDetails
end if;
create table DBA.ESSBatchDetails 
(
    ESSBatchSysId        integer                        not null,
    ESSBDEPETableName    char(50),
    ESSBDEPESysId        integer,
    ESSBDStatus          smallint,
    ESSBDMessage         char(1000),
    constraint PK_ESSBATCHDETAILS primary key clustered (ESSBatchSysId)
);

/*==============================================================*/
/* Index: ESSBatchDetails_PK                                    */
/*==============================================================*/
create unique index ESSBatchDetails_PK on ESSBatchDetails (
ESSBatchSysId ASC
);

alter table ESSBatchDetails
   add constraint FK_ESSBATCH_RELATIONS_ESSBATCH foreign key (ESSBatchSysId)
      references ESSBatch (ESSBatchSysId)
      on update restrict
      on delete restrict;

/*==============================================================*/
/* Table: ESSEmployee                                           */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='ESSEmployee') then
    drop table ESSEmployee
end if;
create table DBA.ESSEmployee 
(
    EmployeeSysId        integer                        not null,
    ESSEEmpModifiedDate  timestamp,
    ESSEEmpESSBatchSysId integer,
    ESSELveModifiedDate  timestamp,
    ESSELveESSBatchSysId integer,
    constraint PK_ESSEMPLOYEE primary key clustered (EmployeeSysId)
);

/*==============================================================*/
/* Index: ESSEmployee_PK                                        */
/*==============================================================*/
create unique index ESSEmployee_PK on ESSEmployee (
EmployeeSysId ASC
);

alter table ESSEmployee
   add constraint FK_ESSEMPLO_RELATIONS_EMPLOYEE foreign key (EmployeeSysId)
      references Employee (EmployeeSysId)
      on update restrict
      on delete restrict;

/*==============================================================*/
/* Table: BatchRptItem                                           */
/*==============================================================*/
if not exists(select * from sys.syscolumns where tname = 'BatchRptItem' and cname = 'RptWebAPIRefNo') then
    alter table DBA.BatchRptItem add RptWebAPIRefNo integer default autoincrement;
end if;

commit work;