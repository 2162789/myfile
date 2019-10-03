if not exists(select 1 from sys.syscolumns where tname='IR8A' and cname='EROutsideContriTaxName') then
    alter table DBA.IR8A Add EROutsideContriTaxName char(150);
end if;

if not exists(select 1 from sys.syscolumns where tname='IR8A' and cname='EROutsideContriTaxAmt') then
    alter table DBA.IR8A Add EROutsideContriTaxAmt double;
end if;

if not exists(select 1 from sys.syscolumns where tname='IR8A' and cname='EROutsideContriTaxMand') then
    alter table DBA.IR8A Add EROutsideContriTaxMand char(20);
end if;

if not exists(select 1 from sys.syscolumns where tname='IR8A' and cname='EROutsideContriTaxPR') then
    alter table DBA.IR8A Add EROutsideContriTaxPR char(20);
end if;

if not exists(select 1 from sys.syscolumns where tname='IR8A' and cname='RemissionAmt') then
    alter table DBA.IR8A Add RemissionAmt double;
end if;

Update IR8A Set EROutsideContriTaxName = '', EROutsideContriTaxAmt = 0, EROutsideContriTaxMand = '',  EROutsideContriTaxPR = '', RemissionAmt = 0;

--IR21
if not exists(select 1 from sys.syscolumns where tname='IR21Details' and cname='ReasonsLessThan1MthOpt') then
    alter table DBA.IR21Details Add ReasonsLessThan1MthOpt char(100);
end if;
if not exists(select 1 from sys.syscolumns where tname='IR21Details' and cname='ReasonsNotWithholdingOpt') then
    alter table DBA.IR21Details Add ReasonsNotWithholdingOpt char(100);
end if;
if not exists(select 1 from sys.syscolumns where tname='IR21Details' and cname='SpouseMoreThan4000') then
    alter table DBA.IR21Details Add SpouseMoreThan4000 smallint;
end if;
if not exists(select 1 from sys.syscolumns where tname='IR21Details' and cname='SpouseEmployer') then
    alter table DBA.IR21Details Add SpouseEmployer char(100);
end if;

/* foreign key for A8AS2S3 & IR21A1S4S5 */
Delete from A8AS2S3 Where PersonalSysid not in (Select PersonalSysid From A8A);
Delete from IR21A1S4S5 Where PersonalSysid not in (Select PersonalSysid From A8A);
if exists(select 1 from sys.sysforeignkey where role='FK_A8AS2S3_RELATIONS_A8A') then
    alter table DBA.A8AS2S3
       delete foreign key FK_A8AS2S3_RELATIONS_A8A
end if;
alter table DBA.A8AS2S3
   add constraint FK_A8AS2S3_RELATIONS_A8A foreign key (PersonalSysId, YEYear)
      references A8A (PersonalSysId, YEYear)
      on update restrict
      on delete restrict;

if exists(select 1 from sys.sysforeignkey where role='FK_IR21A1S4_RELATIONS_A8A') then
    alter table DBA.IR21A1S4S5
       delete foreign key FK_IR21A1S4_RELATIONS_A8A
end if;
alter table DBA.IR21A1S4S5
   add constraint FK_IR21A1S4_RELATIONS_A8A foreign key (PersonalSysId, YEYear)
      references A8A (PersonalSysId, YEYear)
      on update restrict
      on delete restrict;

/* primary key & index for CPFGovernmentProgression */
if exists(select 1 from sys.syscolumns where tname='CPFGovernmentProgression' and cname='CPFGovtSchemeId') then
  alter table DBA.CPFGovernmentProgression drop Primary key;
  alter table DBA.CPFGovernmentProgression add constraint PK_CPFGOVERNMENTPROGRESSION Primary Key (CPFGovtEffectiveDate,CPFGovtSchemeId);
  if exists( select 1 from sys.sysindex i, sys.systable t
    where i.table_id=t.table_id 
     and i.index_name='CPFGovernmentProgression_PK'
     and t.table_name='CPFGovernmentProgression'
) then
   drop index DBA.CPFGovernmentProgression.CPFGovernmentProgression_PK
  end if;
  create unique index CPFGovernmentProgression_PK on DBA.CPFGovernmentProgression (
  CPFGovtEffectiveDate ASC,
  CPFGovtSchemeId ASC
  );
end if;

commit work;