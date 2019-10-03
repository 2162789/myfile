/* Table :SystemUser */
if not exists (select 1 from sys.syscolumns where tname='SystemUser' and cname='RemLastProcessDate') then
   alter table dba.SystemUser add RemLastProcessDate date;
end if;

/* Table : PaySlipFormat */
if exists(select 1 from sys.syscolumns where tname='PaySlipFormat' and cname='StringField1') then
    alter table DBA.PaySlipFormat alter StringField1 char(100);
end if;

if exists(select 1 from sys.syscolumns where tname='PaySlipFormat' and cname='StringField2') then
    alter table DBA.PaySlipFormat alter StringField2 char(100);
end if;

/*==============================================================*/
/* Table: RemDetailsTmpl                                        */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='RemDetailsTmpl') then
    drop table RemDetailsTmpl
end if;
create table DBA.RemDetailsTmpl 
(
    RemFunctionID        char(20)                       not null,
    RemDetailsTmplOrder  integer                        not null,
    Details              char(2000),
    constraint PK_REMDETAILSTMPL primary key (RemFunctionID, RemDetailsTmplOrder)
);

/*==============================================================*/
/* Index: RemDetailsTmpl_PK                                     */
/*==============================================================*/
create unique index RemDetailsTmpl_PK on RemDetailsTmpl (
RemFunctionID ASC,
RemDetailsTmplOrder ASC
);

/*==============================================================*/
/* Index: Relationship_760_FK                                   */
/*==============================================================*/
create  index Relationship_760_FK on RemDetailsTmpl (
RemFunctionID ASC
);

/*==============================================================*/
/* Table: RemFunction                                           */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='RemFunction') then
    drop table RemFunction
end if;

create table DBA.RemFunction 
(
    RemFunctionID        char(20)                       not null,
    TaskCategoryID       char(20)                       not null,
    IsCustomised         smallint,
    DllName              char(100),
    FuncMessage          char(255),
    SysDateTableID       char(100),
    SysDateAttributeID   char(100),
    SysDateSqlJoin       char(255),
    SysDateSqlCond       char(255),
    ParamNameU1          char(20),
    ParamNameU2          char(20),
    ParamNameU3          char(20),
    ParamNameU4          char(20),
    ParamNameU5          char(20),
    FuncKeyAttributeId1  char(20),
    FuncKeyAttributeId2  char(20),
    FuncKeyAttributeId3  char(20),
    FuncKeyAttributeId4  char(20),
    FuncKeyAttributeId5  char(20),
    FuncKeyword1         char(20),
    FuncKeyword2         char(20),
    FuncKeyword3         char(20),
    FuncKeyword4         char(20),
    FuncKeyword5         char(20),
    constraint PK_REMFUNCTION primary key (RemFunctionID)
);

/*==============================================================*/
/* Index: RemFunction_PK                                        */
/*==============================================================*/
create unique index RemFunction_PK on RemFunction (
RemFunctionID ASC
);

/*==============================================================*/
/* Index: Relationship_766_FK                                   */
/*==============================================================*/
create  index Relationship_766_FK on RemFunction (
TaskCategoryID ASC
);

/*==============================================================*/
/* Table: RemSetup                                              */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='RemSetup') then
    drop table RemSetup
end if;
create table DBA.RemSetup 
(
    RemSetupSysID        integer                        not null default AUTOINCREMENT,
    RemFunctionID        char(20)                       not null,
    TaskCategoryID       char(20)                       not null,
    "Message"            char(255),
    Details              char(2000),
    DueDate              date,
    Occurrence           char(20),
    OccurrenceValue      integer,
    ParamValueU1         char(100),
    ParamValueU2         char(100),
    ParamValueU3         char(100),
    ParamValueU4         char(100),
    ParamValueU5         char(100),
    CreatedBy            char(20),
    CreatedDateTime      timestamp                      default current timestamp,
    ModifiedBy           char(20),
    ModifiedDateTime     timestamp,
    constraint PK_REMSETUP primary key (RemSetupSysID)
);

/*==============================================================*/
/* Index: RemSetup_PK                                           */
/*==============================================================*/
create unique index RemSetup_PK on RemSetup (
RemSetupSysID ASC
);

/*==============================================================*/
/* Index: Relationship_762_FK                                   */
/*==============================================================*/
create  index Relationship_762_FK on RemSetup (
RemFunctionID ASC
);

/*==============================================================*/
/* Index: Relationship_763_FK                                   */
/*==============================================================*/
create  index Relationship_763_FK on RemSetup (
TaskCategoryID ASC
);

/*==============================================================*/
/* Table: Task                                                  */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='Task') then
    drop table Task
end if;
create table DBA.Task 
(
    TaskSysID            integer                        not null default AUTOINCREMENT,
    RemSetupSysID        integer,
    TaskCategoryID       char(20)                       not null,
    "Message"            char(255),
    Details              char(2000),
    DueDate              date,
    ReminderDate         date,
    Priority             char(20),
    IsCompleted          smallint,
    CompletedBy          char(20),
    CompletedDate        date,
    CreatedBy            char(20),
    CreatedDateTime      timestamp                      default current timestamp,
    ModifiedBy           char(20),
    ModifiedDateTime     timestamp,
    FuncKey1             char(50),
    FuncKey2             char(50),
    FuncKey3             char(50),
    FuncKey4             char(50),
    FuncKey5             char(50),
    constraint PK_TASK primary key (TaskSysID)
);

/*==============================================================*/
/* Index: Task_PK                                               */
/*==============================================================*/
create unique index Task_PK on Task (
TaskSysID ASC
);

/*==============================================================*/
/* Index: Relationship_761_FK                                   */
/*==============================================================*/
create  index Relationship_761_FK on Task (
TaskCategoryID ASC
);

/*==============================================================*/
/* Index: Relationship_767_FK                                   */
/*==============================================================*/
create  index Relationship_767_FK on Task (
RemSetupSysID ASC
);


/*==============================================================*/
/* Table: TaskCategory                                          */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='TaskCategory') then
    drop table TaskCategory
end if;
/*==============================================================*/
/* Table: TaskCategory                                          */
/*==============================================================*/
create table DBA.TaskCategory 
(
    TaskCategoryID       char(20)                       not null,
    TaskCategoryDesc     char(100),
    constraint PK_TASKCATEGORY primary key (TaskCategoryID)
);

/*==============================================================*/
/* Index: TaskCategory_PK                                       */
/*==============================================================*/
create unique index TaskCategory_PK on TaskCategory (
TaskCategoryID ASC
);

/*==============================================================*/
/* Constraint                               */
/*==============================================================*/
	  
alter table DBA.RemDetailsTmpl
   add constraint FK_REMDETAI_RELATIONS_REMFUNCT foreign key (RemFunctionID)
      references RemFunction (RemFunctionID)
      on update restrict
      on delete restrict;

alter table DBA.RemFunction
   add constraint FK_REMFUNCT_RELATIONS_TASKCATE foreign key (TaskCategoryID)
      references TaskCategory (TaskCategoryID)
      on update restrict
      on delete restrict;

alter table DBA.RemSetup
   add constraint FK_REMSETUP_RELATIONS_REMFUNCT foreign key (RemFunctionID)
      references RemFunction (RemFunctionID)
      on update restrict
      on delete restrict;

alter table DBA.RemSetup
   add constraint FK_REMSETUP_RELATIONS_TASKCATE foreign key (TaskCategoryID)
      references TaskCategory (TaskCategoryID)
      on update restrict
      on delete restrict;
	  
alter table DBA.Task
   add constraint FK_TASK_RELATIONS_TASKCATE foreign key (TaskCategoryID)
      references TaskCategory (TaskCategoryID)
      on update restrict
      on delete restrict;

alter table DBA.Task
   add constraint FK_TASK_RELATIONS_REMSETUP foreign key (RemSetupSysID)
      references RemSetup (RemSetupSysID)
      on update restrict
      on delete restrict;

COMMIT WORK;