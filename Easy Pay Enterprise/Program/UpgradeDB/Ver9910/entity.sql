
/*==============================================================*/
/* Table: CustomisedPatchLog                                    */
/*==============================================================*/
create table dba.CustomisedPatchLog 
(
    CustomisedSysId      integer                        not null default autoincrement,
    UserId               char(20),
    Type                 char(30),
    Patch                char(50),
    TargetDSN            char(30),
    FileSize             char(20),
    PatchDateTime        timestamp,
    IsSuccess            smallint,
    constraint PK_CUSTOMISEDPATCHLOG primary key (CustomisedSysId)
);

/*==============================================================*/
/* Index: CustomisedPatchLog_PK                                 */
/*==============================================================*/
create unique index CustomisedPatchLog_PK on CustomisedPatchLog (
CustomisedSysId ASC
);

/*==============================================================*/
/* Index: Relation_1926593_FK                                   */
/*==============================================================*/
create  index Relation_1926593_FK on CustomisedPatchLog (
UserId ASC
);

Commit Work;