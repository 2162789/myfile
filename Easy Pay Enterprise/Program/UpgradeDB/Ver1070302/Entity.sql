/*==============================================================*/
/* Table: MandatoryContributeProg                               */
/*==============================================================*/
if not exists(select * from sys.syscolumns where tname = 'MandatoryContributeProg' and cname = 'ManContriP1Payment') then
  alter table DBA.MandatoryContributeProg add ManContriP1Payment smallint;
end if;

commit work;