/* IndoTaxEmployer table */
if not exists(select 1 from sys.syscolumns where tname='IndoTaxEmployer' and cname='IndoAccidentOption') then
    alter table DBA.IndoTaxEmployer Add IndoAccidentOption smallint default 1;
end if;

if not exists(select 1 from sys.syscolumns where tname='IndoTaxEmployer' and cname='IndoDeathOption') then
    alter table DBA.IndoTaxEmployer Add IndoDeathOption smallint default 1;
end if;

update IndoTaxEmployer set IndoAccidentOption = 1, IndoDeathOption = 1;

/* iYTDIDPolicy table */
if exists(select 1 from sys.systable where table_name='iYTDIDPolicy') then
   drop table iYTDIDPolicy
end if;

/*==============================================================*/
/* Table: iYTDIDPolicy                                          */
/*==============================================================*/
create table DBA.iYTDIDPolicy 
(
    YTDIDPolicySysId     integer                        not null default AUTOINCREMENT,
    YTDIDPolicyEmployeeId char(30)                       not null,
    YTDIDPolicyYear      integer                        not null,
    YTDIDPolicyPeriod    integer                        not null,
    JamsostekStatus      char(20),
    EmployeeJamsostek    double,
    OldAgeJamsostek      double,
    AccidentJamsostek    double,
    DeathJamsostek       double,
    BPJSKesStatus        char(20),
    BPJSKesMarStatus     char(20),
    EmployeeBPJSKes      double,
    EmployerBPJSKes      double,
    TaxGrossSalary       double,
    TaxAmount            double,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IYTDIDPOLICY primary key (YTDIDPolicySysId)
);

/*==============================================================*/
/* Index: iYTDIDPolicy_PK                                       */
/*==============================================================*/
create unique index iYTDIDPolicy_PK on iYTDIDPolicy (
YTDIDPolicySysId ASC
);

/* Default Data */
if not exists (select * from KeyWord where KeyWordId = 'EX_Alias') then
insert into KeyWord
(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
values ('EX_Alias', 'Alias', 'Alias', 'EXPORT', 0, 0, 0, 'Alias', 613, 5, 0, '')
end if;

if not exists (select * from KeyWord where KeyWordId = 'EX_OtherID') then
insert into KeyWord
(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
values ('EX_OtherID', 'Other ID', 'Other ID', 'EXPORT', 0, 0, 0, 'OtherID', 614, 5, 0, '')
end if;

if not exists (select * from KeyWord where KeyWordId = 'EX_Religion') then
insert into KeyWord
(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
values ('EX_Religion', 'Religion', 'Religion', 'EXPORT', 0, 0, 0, 'ReligionID', 615, 5, 0, '')
end if;

if not exists (select * from KeyWord where KeyWordId = 'EX_Email_ePortal') then
insert into KeyWord
(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
values ('EX_Email_ePortal', 'Email (ePortal)', 'Email (ePortal)', 'EXPORT', 0, 0, 0, 'ePortalEmail', 616, 5, 0, '')
end if;

if not exists (select * from KeyWord where KeyWordId = 'EX_Supervisor') then
insert into KeyWord
(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
values ('EX_Supervisor', 'Supervisor ID', 'Supervisor ID', 'EXPORT', 0, 0, 0, 'Supervisor', 617, 5, 0, '')
end if;

if not exists (select * from KeyWord where KeyWordId = 'EX_SupervisorName') then
insert into KeyWord
(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
values ('EX_SupervisorName', 'Supervisor Name', 'Supervisor Name', 'EXPORT', 0, 0, 0, 'SupervisorName', 618, 5, 0, '')
end if;

if not exists (select * from KeyWord where KeyWordId = 'EX_WorkCalendar') then
insert into KeyWord
(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
values ('EX_WorkCalendar', 'Work Calendar', 'Work Calendar', 'EXPORT', 0, 0, 0, 'WorkCalendar', 619, 5, 0, '')
end if;

if not exists (select * from KeyWord where KeyWordId = 'EX_LeaveGroupID') then
insert into KeyWord
(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
values ('EX_LeaveGroupID', 'Leave Group ID', 'Leave Group ID', 'EXPORT', 0, 0, 0, 'LeaveGroupID', 620, 5, 0, '')
end if;

if exists (select * from sys.sysprocedure where proc_name = 'FGetPersonalOtherID') then
  drop function FGetPersonalOtherID
end if;
create function DBA.FGetPersonalOtherID(in In_PersonalSysId integer)
returns char(30)
begin
  declare Out_OtherID char(30);
  select Mal_OldIdentity into Out_OtherID
    from Personal where PersonalSysId = In_PersonalSysId;
  return(Out_OtherID)
end;

if exists (select * from sys.sysprocedure where proc_name = 'FGetPersonalAlias') then
  drop function FGetPersonalAlias
end if;
create function DBA.FGetPersonalAlias(in In_PersonalSysId integer)
returns char(100)
begin
  declare Out_Alias char(100);
  select Alias into Out_Alias
    from Personal where PersonalSysId = In_PersonalSysId;
  return(Out_Alias)
end;

commit work;