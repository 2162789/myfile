/*==============================================================*/
/* Table: MedisaveScheme                                        */
/*==============================================================*/
if not exists(select 1 from sys.syscolumns where tname='MedisaveScheme')  then
   create table DBA.MedisaveScheme 
   (
       MedisaveSchemeId     char(20) not null,
       MedisaveSchemeDesc   char(100),
       constraint PK_MEDISAVESCHEME primary key (MedisaveSchemeId)
   );

   /*==============================================================*/
   /* Index: MedisaveScheme_PK                                     */
   /*==============================================================*/
   create unique index MedisaveScheme_PK on DBA.MedisaveScheme (
   MedisaveSchemeId ASC
   );
end if;

/*==============================================================*/
/* Table: CPFProgression                                        */
/*==============================================================*/
if not exists(select 1 from sys.syscolumns where tname='CPFProgression' and cname='CPFMedisaveSchemeId') then
    alter table DBA.CPFProgression Add CPFMedisaveSchemeId char(20);
end if;

/*==============================================================*/
/* Table: MedisaveProgression                                        */
/*==============================================================*/
if not exists(select 1 from sys.syscolumns where tname='MedisaveProgression' and cname='MedisaveMinOrdContri') then
    alter table DBA.MedisaveProgression Add MedisaveMinOrdContri double DEFAULT 0;
end if;

if not exists(select 1 from sys.syscolumns where tname='MedisaveProgression' and cname='MedisaveSchemeId') then
    alter table DBA.MedisaveProgression Add MedisaveSchemeId char(20);
	if (FGetDBCountry() = 'Singapore' and exists(select * from MedisaveProgression)) then 
	   if not exists(select * from MedisaveScheme where MedisaveSchemeId = 'Scheme 1') then
	       insert into MedisaveScheme(MedisaveSchemeId,MedisaveSchemeDesc)
		   values('Scheme 1','Scheme 1');
	   end if;
       update MedisaveProgression set MedisaveSchemeId = 'Scheme 1' where MedisaveSchemeId is null or (MedisaveSchemeId = ''); 
       update CPFProgression set CPFMedisaveSchemeId = 'Scheme 1' where CPFMedisavePaidByER = 1;	
    end if;
	
	/* Update Primary Key */
    alter table DBA.MedisaveProgression Alter MedisaveSchemeId char(20) Not NULL;
	alter table DBA.MedisaveProgression drop Primary key;
    alter table DBA.MedisaveProgression add constraint PK_MEDISAVEPROGRESSION primary key (MedisaveSchemeId, MedisaveEffectiveDate);

   /* foreign key */
   alter table DBA.MedisaveProgression
      add constraint FK_MEDISAVE_RELATIONS_MEDISAVE foreign key (MedisaveSchemeId)
         references MedisaveScheme (MedisaveSchemeId)
         on update restrict
         on delete restrict;	
		 
   /* Index */	
   if exists(
      select 1 from sys.sysindex i, sys.systable t
      where i.table_id=t.table_id 
        and i.index_name='MedisaveProgression_PK'
        and t.table_name='MedisaveProgression'
   ) then
      drop index DBA.MedisaveProgression.MedisaveProgression_PK
   end if;	
   create unique index MedisaveProgression_PK on DBA.MedisaveProgression (
   MedisaveSchemeId ASC,
   MedisaveEffectiveDate ASC
   );
end if;

commit work;