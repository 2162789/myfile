
/*==============================================================*/
/* Table: PersonalAttachment                                    */
/*==============================================================*/
if not exists (select * from sys.systable where table_name = 'PersonalAttachment') then
create table DBA.PersonalAttachment 
(
    PersonalSysId        integer                        not null,
    PersonalAttachmentId integer                        not null default AUTOINCREMENT,
    PersonalAttFileName  char(100),
    PersonalAttOrgFilePath char(255),
    PersonalAttDescription char(255),
    PersonalAttCategory  char(100),
    constraint PK_PERSONALATTACHMENT primary key (PersonalSysId, PersonalAttachmentId)
);

/*==============================================================*/
/* Index: PersonalAttachment_PK                                 */
/*==============================================================*/
create unique index PersonalAttachment_PK on PersonalAttachment (
PersonalSysId ASC,
PersonalAttachmentId ASC
);

/*==============================================================*/
/* Index: Relationship_765_FK                                   */
/*==============================================================*/
create  index Relationship_765_FK on PersonalAttachment (
PersonalSysId ASC
);

end if;


commit work;