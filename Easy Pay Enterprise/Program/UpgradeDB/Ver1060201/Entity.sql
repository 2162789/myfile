/*==============================================================*/
/* Table: MalSTDPolicy                                    */
/*==============================================================*/
if not exists(select 1 from sys.syscolumns where tname='MalSTDPolicy' and cname='MalTaxScheme') then
    alter table DBA.MalSTDPolicy add MalTaxScheme char(20);
end if;

/*==============================================================*/
/* Table: MalTaxDetails                                   */
/*==============================================================*/
if not exists(select 1 from sys.syscolumns where tname='MalTaxDetails' and cname='MalTaxScheme') then
    alter table DBA.MalTaxDetails add MalTaxScheme char(20);
end if;

if not exists(select 1 from sys.syscolumns where tname='MalTaxDetails' and cname='IsHandicapped') then
    alter table DBA.MalTaxDetails add IsHandicapped smallint default 0;
end if;

/*==============================================================*/
/* Table: MalTaxFormula                                         */
/*==============================================================*/
if exists(select 1 from sys.systable where table_name='MalTaxFormula') then
    drop table MalTaxFormula
end if;

create table DBA.MalTaxFormula 
(
    MalTaxPolicyProgSysId integer                        not null,
    PolicyProgTaxScheme  char(20)                       not null,
    MalSTDPolicyId       char(20),
    constraint PK_MALTAXFORMULA primary key (MalTaxPolicyProgSysId, PolicyProgTaxScheme)
);

/*==============================================================*/
/* Index: MalTaxFormula_PK                                      */
/*==============================================================*/
create unique index MalTaxFormula_PK on MalTaxFormula (
MalTaxPolicyProgSysId ASC,
PolicyProgTaxScheme ASC
);

/*==============================================================*/
/* Index: Relationship_759_FK                                   */
/*==============================================================*/
create  index Relationship_759_FK on MalTaxFormula (
MalSTDPolicyId ASC
);

/*==============================================================*/
/* Index: Relationship_760_FK                                   */
/*==============================================================*/
create  index Relationship_760_FK on MalTaxFormula (
MalTaxPolicyProgSysId ASC
);

alter table MalTaxFormula
   add constraint FK_MALTAXFO_RELATIONS_MALSTDPO foreign key (MalSTDPolicyId)
      references MalSTDPolicy (MalSTDPolicyId)
      on update restrict
      on delete restrict;

alter table MalTaxFormula
   add constraint FK_MALTAXFO_RELATIONS_MALTAXPO foreign key (MalTaxPolicyProgSysId)
      references MalTaxPolicyProg (MalTaxPolicyProgSysId)
      on update restrict
      on delete restrict;

commit work;