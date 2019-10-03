if not exists (select 1 from sys.syscolumns where tname='PhTaxDetails' and cname='PhMWEOption') then
   alter table dba.PhTaxDetails add PhMWEOption smallint DEFAULT 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='PhPrevEmployer' and cname='PEBasicSalaryMWE') then
   alter table dba.PhPrevEmployer add PEBasicSalaryMWE double DEFAULT 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='PhPrevEmployer' and cname='PEHolidayPayMWE') then
   alter table dba.PhPrevEmployer add PEHolidayPayMWE double DEFAULT 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='PhPrevEmployer' and cname='PEOvertimeMWE') then
   alter table dba.PhPrevEmployer add PEOvertimeMWE double DEFAULT 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='PhPrevEmployer' and cname='PENightShiftMWE') then
   alter table dba.PhPrevEmployer add PENightShiftMWE double DEFAULT 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='PhPrevEmployer' and cname='PEHazardPayMWE') then
   alter table dba.PhPrevEmployer add PEHazardPayMWE double DEFAULT 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='PhPrevEmployer' and cname='PETaxBasicSalary') then
   alter table dba.PhPrevEmployer add PETaxBasicSalary double DEFAULT 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='PhPrevEmployer' and cname='PEDeMinimis') then
   alter table dba.PhPrevEmployer add PEDeMinimis double DEFAULT 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='PhTaxRecord' and cname='PhBasicSalaryMWE') then
   alter table dba.PhTaxRecord add PhBasicSalaryMWE double DEFAULT 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='PhTaxRecord' and cname='PhHolidayPayMWE') then
   alter table dba.PhTaxRecord add PhHolidayPayMWE double DEFAULT 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='PhTaxRecord' and cname='PhOvertimePayMWE') then
   alter table dba.PhTaxRecord add PhOvertimePayMWE double DEFAULT 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='PhTaxRecord' and cname='PhNightShiftMWE') then
   alter table dba.PhTaxRecord add PhNightShiftMWE double DEFAULT 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='PhTaxRecord' and cname='PhHazardPayMWE') then
   alter table dba.PhTaxRecord add PhHazardPayMWE double DEFAULT 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='PhTaxRecord' and cname='PhDeMinimis') then
   alter table dba.PhTaxRecord add PhDeMinimis double DEFAULT 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='PhTaxRecord' and cname='PhSMWPerDay') then
   alter table dba.PhTaxRecord add PhSMWPerDay double DEFAULT 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='PhTaxRecord' and cname='PhSMWPerMonth') then
   alter table dba.PhTaxRecord add PhSMWPerMonth double DEFAULT 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='PhTaxRecord' and cname='PhMWEOption') then
   alter table dba.PhTaxRecord add PhMWEOption  smallint DEFAULT 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='PhTaxEmployer' and cname='PhTaxBranch') then
   alter table dba.PhTaxEmployer add PhTaxBranch  char(4);
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DEMINIMI_RELATIONS_PHTAXPOL') then
    alter table DeMinimisSetup
       delete foreign key FK_DEMINIMI_RELATIONS_PHTAXPOL
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='DeMinimisSetup_PK'
     and t.table_name='DeMinimisSetup'
) then
   drop index DeMinimisSetup.DeMinimisSetup_PK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='Relationship_743_FK'
     and t.table_name='DeMinimisSetup'
) then
   drop index DeMinimisSetup.Relationship_743_FK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='DeMinimisSetup'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table DeMinimisSetup
end if;

/*==============================================================*/
/* Table: DeMinimisSetup                                        */
/*==============================================================*/
create table dba.DeMinimisSetup 
(
    PhTaxPolicySysId     integer                        not null,
    DeMinimisProperty    char(20)                       not null,
    DMBMthCap            double,
    DMBYearCap           double,
    DMBPercentMW         double,
    constraint PK_DEMINIMISSETUP primary key (PhTaxPolicySysId, DeMinimisProperty)
);

/*==============================================================*/
/* Index: DeMinimisSetup_PK                                     */
/*==============================================================*/
create unique index DeMinimisSetup_PK on DeMinimisSetup (
PhTaxPolicySysId ASC,
DeMinimisProperty ASC
);

/*==============================================================*/
/* Index: Relationship_743_FK                                   */
/*==============================================================*/
create  index Relationship_743_FK on DeMinimisSetup (
PhTaxPolicySysId ASC
);


if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='DeMinimisItem_PK'
     and t.table_name='DeMinimisItem'
) then
   drop index DeMinimisItem.DeMinimisItem_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='DeMinimisItem'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table DeMinimisItem
end if;

/*==============================================================*/
/* Table: DeMinimisItem                                         */
/*==============================================================*/
create table dba.DeMinimisItem 
(
    DMBItemId            char(20)                       not null,
    DMBProperty          char(20)                       not null,
    DMBDesc              char(100),
    constraint PK_DEMINIMISITEM primary key (DMBItemId)
);

/*==============================================================*/
/* Index: DeMinimisItem_PK                                      */
/*==============================================================*/
create unique index DeMinimisItem_PK on DeMinimisItem (
DMBItemId ASC
);

if exists(select 1 from sys.sysforeignkey where role='FK_DMBRECUR_RELATIONS_PAYEMPLO') then
    alter table DMBRecurring
       delete foreign key FK_DMBRECUR_RELATIONS_PAYEMPLO
end if;


if exists(select 1 from sys.sysforeignkey where role='FK_DMBRECUR_RELATIONS_DEMINIMI') then
    alter table DMBRecurring
       delete foreign key FK_DMBRECUR_RELATIONS_DEMINIMI
end if;


if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='DMBRecurring_PK'
     and t.table_name='DMBRecurring'
) then
   drop index DMBRecurring.DMBRecurring_PK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='Relationship_749_FK'
     and t.table_name='DMBRecurring'
) then
   drop index DMBRecurring.Relationship_749_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='Relationship_750_FK'
     and t.table_name='DMBRecurring'
) then
   drop index DMBRecurring.Relationship_750_FK
end if;


if exists(
   select 1 from sys.systable 
   where table_name='DMBRecurring'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table DMBRecurring
end if;

/*==============================================================*/
/* Table: DMBRecurring                                          */
/*==============================================================*/
create table dba.DMBRecurring 
(
    DMBRecurSysId        integer                        not null default AUTOINCREMENT,
    DMBItemId            char(20)                       not null,
    EmployeeSysId        integer,
    DMBStartYear         double,
    DMBStartPeriod       double,
    DMBEndPeriod         double,
    DMBAnnualAmount      double,
    DMBNoOfPayment       double,
    DMBPaymentPerSubPeriod double,
    DMBPreviousPayment   double,
    Remarks              char(100),
    constraint PK_DMBRECURRING primary key (DMBRecurSysId)
);

/*==============================================================*/
/* Index: DMBRecurring_PK                                       */
/*==============================================================*/
create unique index DMBRecurring_PK on DMBRecurring (
DMBRecurSysId ASC
);

/*==============================================================*/
/* Index: Relationship_749_FK                                   */
/*==============================================================*/
create  index Relationship_749_FK on DMBRecurring (
EmployeeSysId ASC
);

/*==============================================================*/
/* Index: Relationship_750_FK                                   */
/*==============================================================*/
create  index Relationship_750_FK on DMBRecurring (
DMBItemId ASC
);

if exists(select 1 from sys.sysforeignkey where role='FK_DMBRECOR_RELATIONS_PAYEMPLO') then
    alter table DMBRecord
       delete foreign key FK_DMBRECOR_RELATIONS_PAYEMPLO
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DMBRECOR_RELATIONS_DMBRECUR') then
    alter table DMBRecord
       delete foreign key FK_DMBRECOR_RELATIONS_DMBRECUR
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DMBRECOR_RELATIONS_DEMINIMI') then
    alter table DMBRecord
       delete foreign key FK_DMBRECOR_RELATIONS_DEMINIMI
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='DMBRecord_PK'
     and t.table_name='DMBRecord'
) then
   drop index DMBRecord.DMBRecord_PK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='Relationship_747_FK'
     and t.table_name='DMBRecord'
) then
   drop index DMBRecord.Relationship_747_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='Relationship_748_FK'
     and t.table_name='DMBRecord'
) then
   drop index DMBRecord.Relationship_748_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='Relationship_751_FK'
     and t.table_name='DMBRecord'
) then
   drop index DMBRecord.Relationship_751_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='DMBRecurring_PK'
     and t.table_name='DMBRecurring'
) then
   drop index DMBRecurring.DMBRecurring_PK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='Relationship_749_FK'
     and t.table_name='DMBRecurring'
) then
   drop index DMBRecurring.Relationship_749_FK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='DMBRecord'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table DMBRecord
end if;

/*==============================================================*/
/* Table: DMBRecord                                             */
/*==============================================================*/
create table dba.DMBRecord 
(
    DMBRecSGSPGenId      char(30)                       not null,
    DMBRecurSysId        integer,
    DMBItemId            char(20)                       not null,
    EmployeeSysId        integer,
    PayRecYear           integer,
    PayRecPeriod         integer,
    PayRecSubPeriod      integer,
    PayRecID             char(20),
    DMBAmount            double,
    constraint PK_DMBRECORD primary key (DMBRecSGSPGenId)
);

/*==============================================================*/
/* Index: DMBRecord_PK                                          */
/*==============================================================*/
create unique index DMBRecord_PK on DMBRecord (
DMBRecSGSPGenId ASC
);

/*==============================================================*/
/* Index: Relationship_747_FK                                   */
/*==============================================================*/
create  index Relationship_747_FK on DMBRecord (
EmployeeSysId ASC
);

/*==============================================================*/
/* Index: Relationship_748_FK                                   */
/*==============================================================*/
create  index Relationship_748_FK on DMBRecord (
DMBRecurSysId ASC
);

/*==============================================================*/
/* Index: Relationship_751_FK                                   */
/*==============================================================*/
create  index Relationship_751_FK on DMBRecord (
DMBItemId ASC
);

if exists(select 1 from sys.sysforeignkey where role='FK_DEMINIMI_RELATIONS_PHTAXDET') then
    alter table DeMinimisGranted
       delete foreign key FK_DEMINIMI_RELATIONS_PHTAXDET
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='DeMinimisGranted_PK'
     and t.table_name='DeMinimisGranted'
) then
   drop index DeMinimisGranted.DeMinimisGranted_PK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='Relationship_745_FK'
     and t.table_name='DeMinimisGranted'
) then
   drop index DeMinimisGranted.Relationship_745_FK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='DeMinimisGranted'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table DeMinimisGranted
end if;

/*==============================================================*/
/* Table: DeMinimisGranted                                      */
/*==============================================================*/
create table dba.DeMinimisGranted 
(
    DMBGrantSysId        integer                        not null default AUTOINCREMENT,
    PersonalSysId        integer                        not null,
    DMBProperty          char(20)                       not null,
    DMBPayrollYear       integer,
    DMBPayrollPeriod     integer,
    DMBGrantedAmt        double,
    DMBExceedingAmt      double,
    CreatedBy            char(1),
    constraint PK_DEMINIMISGRANTED primary key (DMBGrantSysId)
);

/*==============================================================*/
/* Index: DeMinimisGranted_PK                                   */
/*==============================================================*/
create unique index DeMinimisGranted_PK on DeMinimisGranted (
DMBGrantSysId ASC
);

/*==============================================================*/
/* Index: Relationship_745_FK                                   */
/*==============================================================*/
create  index Relationship_745_FK on DeMinimisGranted (
PersonalSysId ASC
);


alter table DeMinimisSetup
   add constraint FK_DEMINIMI_RELATIONS_PHTAXPOL foreign key (PhTaxPolicySysId)
      references PhTaxPolicyProg (PhTaxPolicySysId)
      on update restrict
      on delete restrict;

alter table DMBRecord
   add constraint FK_DMBRECOR_RELATIONS_PAYEMPLO foreign key (EmployeeSysId)
      references PayEmployee (EmployeeSysId)
      on update restrict
      on delete restrict;

alter table DMBRecord
   add constraint FK_DMBRECOR_RELATIONS_DMBRECUR foreign key (DMBRecurSysId)
      references DMBRecurring (DMBRecurSysId)
      on update restrict
      on delete restrict;

alter table DMBRecord
   add constraint FK_DMBRECOR_RELATIONS_DEMINIMI foreign key (DMBItemId)
      references DeMinimisItem (DMBItemId)
      on update restrict
      on delete restrict;

alter table DMBRecurring
   add constraint FK_DMBRECUR_RELATIONS_PAYEMPLO foreign key (EmployeeSysId)
      references PayEmployee (EmployeeSysId)
      on update restrict
      on delete restrict;

alter table DMBRecurring
   add constraint FK_DMBRECUR_RELATIONS_DEMINIMI foreign key (DMBItemId)
      references DeMinimisItem (DMBItemId)
      on update restrict
      on delete restrict;

alter table DeMinimisGranted
   add constraint FK_DEMINIMI_RELATIONS_PHTAXDET foreign key (PersonalSysId)
      references PhTaxDetails (PersonalSysId)
      on update restrict
      on delete restrict;

commit work;