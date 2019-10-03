/*==============================================================*/
/* Table: PasswordHistory                                       */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='PasswordHistory') then
    drop table PasswordHistory
end if;

create table dba.PasswordHistory 
(
    PasswordHxSysId      integer                        not null default AUTOINCREMENT,
    UserId               char(20)                       not null,
    UserPassword         char(50),
    constraint PK_PASSWORDHISTORY primary key (PasswordHxSysId)
);

/*==============================================================*/
/* Index: PasswordHistory_PK                                    */
/*==============================================================*/
create unique index PasswordHistory_PK on PasswordHistory (
PasswordHxSysId ASC
);

/*==============================================================*/
/* Index: Relationship_753_FK                                   */
/*==============================================================*/
create  index Relationship_753_FK on PasswordHistory (
UserId ASC
);

alter table PasswordHistory
   add constraint FK_PASSWORD_RELATIONS_SYSTEMUS foreign key (UserId)
      references SystemUser (UserId)
      on update restrict
      on delete restrict;

if not exists (select 1 from sys.syscolumns where tname='SystemUser' and cname='LastFailDateTime') then
   alter table dba.SystemUser add LastFailDateTime timestamp;
end if;

if not exists (select 1 from sys.syscolumns where tname='SystemUser' and cname='AccumulatedFails') then
   alter table dba.SystemUser add AccumulatedFails integer default 0;
end if;

commit work;