/*==============================================================*/
/* Table: UpdatePatchLog                                        */
/*==============================================================*/

if not exists(select 1 from sys.systable where table_name='UpdatePatchLog') then
create table dba.UpdatePatchLog 
(
    UpdatePatchLogSysId  integer                        not null default AUTOINCREMENT,
    UserId               char(20),
    PatchCategory        char(20),
    PatchFilePath        char(200),
    PatchDescription     char(8192),
    Patch                char(50),
    PatchDateTime        timestamp,
    IsSuccess            smallint,
    PatchIPAddress       char(20),
    constraint PK_UPDATEPATCHLOG primary key (UpdatePatchLogSysId)
);

/*==============================================================*/
/* Index: UpdatePatchLog_PK                                     */
/*==============================================================*/
create unique index UpdatePatchLog_PK on UpdatePatchLog (
UpdatePatchLogSysId ASC
);

/*==============================================================*/
/* Index: Relationship_756_FK                                   */
/*==============================================================*/
create  index Relationship_756_FK on UpdatePatchLog (
UserId ASC
);	

alter table UpdatePatchLog
   add constraint FK_UPDATEPA_RELATIONS_SYSTEMUS foreign key (UserId)
      references SystemUser (UserId)
      on update restrict
      on delete restrict;

end if;

commit work;