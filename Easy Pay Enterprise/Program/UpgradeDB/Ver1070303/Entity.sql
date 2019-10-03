/*==============================================================*/
/* Table: PersonalAttachment                               */
/*==============================================================*/
if not exists(select * from sys.syscolumns where tname = 'PersonalAttachment' and cname = 'PersonalAttCreatedByEPE') then
  alter table DBA.PersonalAttachment add PersonalAttCreatedByEPE smallint default 0;
end if;

commit work;