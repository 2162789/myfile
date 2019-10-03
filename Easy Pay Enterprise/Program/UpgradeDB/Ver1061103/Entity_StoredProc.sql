/*==============================================================*/
/* Table: GovtCPFRpt                                            */
/*==============================================================*/
if not exists (select * from sys.systable where table_name = 'GovtCPFRpt') then
create table DBA.GovtCPFRpt 
(
    GovtCPFRptSysId      integer                        not null default AUTOINCREMENT,
    PersonalSysId        integer,
    YEYear               integer,
    Period               integer,
    OrdWages             double,
    AddWages             double,
    CappedOrdWage        double,
    CappedAddWage        double,
    ContriOrdEECPF       double,
    ContriOrdERCPF       double,
    ContriAddEECPF       double,
    ContriAddERCPF       double,
    ActualOrdEECPF       double,
    ActualOrdERCPF       double,
    ActualAddEECPF       double,
    ActualAddERCPF       double,
    GovtCPFRptCreatedBy  char(200),
    constraint PK_GOVTCPFRPT primary key (GovtCPFRptSysId)
);

/*==============================================================*/
/* Index: GovtCPFRpt_PK                                         */
/*==============================================================*/
create unique index GovtCPFRpt_PK on GovtCPFRpt (
GovtCPFRptSysId ASC
);
end if;

/*==============================================================*/
/* Table: GovtCPFRptEmpHistory                                  */
/*==============================================================*/
if not exists (select * from sys.systable where table_name = 'GovtCPFRptEmpHistory') then
create table DBA.GovtCPFRptEmpHistory 
(
    GovtCPFRptEmpHistorySysId integer                        not null default AUTOINCREMENT,
    PersonalSysId        integer,
    YEYear               integer,
    YEEmployeeSysId      integer,
    YEPayGroupId         char(20),
    FromDate             date,
    ToDate               date,
    GovtCPFRptEmpHistoryCreatedBy char(200),
    constraint PK_GOVTCPFRPTEMPHISTORY primary key (GovtCPFRptEmpHistorySysId)
);

/*==============================================================*/
/* Index: GovtCPFRptEmpHistory_PK                               */
/*==============================================================*/
create unique index GovtCPFRptEmpHistory_PK on GovtCPFRptEmpHistory (
GovtCPFRptEmpHistorySysId ASC
);
end if;

/*==============================================================*/
/* Table: CPFGovernmentProgression                                       */
/*==============================================================*/
if not exists(select 1 from sys.syscolumns where tname='CPFGovernmentProgression' and cname='CPFGovtSchemeId') then
    alter table DBA.CPFGovernmentProgression Add CPFGovtSchemeId char(20);
	if (FGetDBCountry() = 'Singapore') then
        Update CPFGovernmentProgression Set CPFGovtSchemeId = 'Private'; 
    end if;
  if exists(select 1 from sys.syscolumns where tname='CPFGovernmentProgression' and cname='CPFGovtSchemeId') then
    alter table DBA.CPFGovernmentProgression Alter CPFGovtSchemeId char(20) Not NULL;
  end if;
  alter table DBA.CPFGovernmentProgression drop Primary key;
  alter table DBA.CPFGovernmentProgression add Primary Key(CPFGovtEffectiveDate,CPFGovtSchemeId);
end if;

if exists (select * from sys.sysprocedure where proc_name = 'InsertNewCPFGovernmentProgression') then
  drop procedure InsertNewCPFGovernmentProgression
end if;
create procedure DBA.InsertNewCPFGovernmentProgression(
in In_CPFGovtEffectiveDate date,
in In_CPFGovtSchemeId char(20),
in In_CPFGovtPolicyId char(20),
in In_CPFGovtCurrent smallint,
in In_CPFGovtRemarks char(255))
begin
  if not exists(select* from CPFGovernmentProgression where
      CPFGovernmentProgression.CPFGovtEffectiveDate = In_CPFGovtEffectiveDate and 
      CPFGovernmentProgression.CPFGovtSchemeId = In_CPFGovtSchemeId) then
    insert into CPFGovernmentProgression(CPFGovtEffectiveDate,CPFGovtSchemeId,CPFGovtPolicyId,CPFGovtCurrent,
      CPFGovtRemarks) values(In_CPFGovtEffectiveDate,In_CPFGovtSchemeId,In_CPFGovtPolicyId,In_CPFGovtCurrent,
      In_CPFGovtRemarks);
    commit work
  end if
end
;

if exists (select * from sys.sysprocedure where proc_name = 'UpdateCPFGovernmentProgression') then
  drop procedure UpdateCPFGovernmentProgression
end if;
create procedure DBA.UpdateCPFGovernmentProgression(
in In_CPFGovtEffectiveDate date,
in In_CPFGovtSchemeId char(20),
in In_CPFGovtPolicyId char(20),
in In_CPFGovtCurrent smallint,
in In_CPFGovtRemarks char(255))
begin
  if exists(select* from CPFGovernmentProgression where
      CPFGovernmentProgression.CPFGovtEffectiveDate = In_CPFGovtEffectiveDate and
      CPFGovernmentProgression.CPFGovtSchemeId = In_CPFGovtSchemeId) then
    update CPFGovernmentProgression set
      CPFGovernmentProgression.CPFGovtPolicyId = In_CPFGovtPolicyId,
      CPFGovernmentProgression.CPFGovtCurrent = In_CPFGovtCurrent,
      CPFGovernmentProgression.CPFGovtRemarks = In_CPFGovtRemarks where
      CPFGovernmentProgression.CPFGovtEffectiveDate = In_CPFGovtEffectiveDate and
      CPFGovernmentProgression.CPFGovtSchemeId = In_CPFGovtSchemeId;
    commit work
  end if
end
;

if exists (select * from sys.sysprocedure where proc_name = 'DeleteCPFGovernmentProgression') then
  drop procedure DeleteCPFGovernmentProgression
end if;
create procedure DBA.DeleteCPFGovernmentProgression(
in In_CPFGovtEffectiveDate date,
in In_CPFGovtSchemeId char(20))
begin
  if exists(select* from CPFGovernmentProgression where
      CPFGovernmentProgression.CPFGovtEffectiveDate = In_CPFGovtEffectiveDate and
      CPFGovernmentProgression.CPFGovtSchemeId = In_CPFGovtSchemeId) then
    delete from CPFGovernmentProgression where
      CPFGovernmentProgression.CPFGovtEffectiveDate = In_CPFGovtEffectiveDate and 
      CPFGovernmentProgression.CPFGovtSchemeId = In_CPFGovtSchemeId ;
    commit work
  end if
end
;

commit work;