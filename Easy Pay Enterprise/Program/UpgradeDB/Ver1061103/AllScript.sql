Read UpgradeDB\Ver1061103\Entity_StoredProc.sql;

--Employee Report Setup
if not exists (select 1 from sys.syscolumn join sys.systable on syscolumn.table_id = systable.table_id where column_name = 'ExcelEmpRptModule' and table_name = 'ExcelEmpRpt') then
  alter table ExcelEmpRpt add ExcelEmpRptModule char(20) null;
end if;
update ExcelEmpRpt set ExcelEmpRptModule = 'Leave' where ExcelEmpRptId like '%leave%';
update ExcelEmpRpt set ExcelEmpRptModule = 'HR' where ExcelEmpRptId like '%train%';
update ExcelEmpRpt set ExcelEmpRptModule = 'Core' where ExcelEmpRptId not like '%leave%' and ExcelEmpRptId not like '%train%';
update ExcelEmpRpt set ExcelEmpRptModule = 'Payroll' where ExcelEmpRptId in ('CPFProgRpt', 'FWLProgRpt', 'TAPProgRpt', 'JamsostekProgRpt', 'EPFProgRpt', 'SOCSOProgRpt', 'StatContriProgRpt');
if not exists (select 1 from ExcelEmpRpt where ExcelEmpRptId = 'TrainingRpt') then
  insert into ExcelEmpRpt (ExcelEmpRptId,ExcelEmpRptDesc,ExcelEmpRptTable1,ExcelEmpRptTable2,ExcelEmpRptTable3,IsEmployeeRpt,ExcelEmpRptModule)
  select 'TrainingRpt', ExcelEmpRptDesc, ExcelEmpRptTable1, ExcelEmpRptTable2, ExcelEmpRptTable3, 1, ExcelEmpRptModule
  from ExcelEmpRpt where ExcelEmpRptId = 'PTrainingRpt';
end if;

if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'BasicRateProgression') then
  insert into EmployeeRpt (EmpInfoRptId,EmpInfoRptDesc,EmpInfoRptType,EmployeeRptHasFilter,EmployeeRptFilterCond,EmployeeRptHasEmpCt,EmployeeRptHasEmpOnly)
  values ('BasicRateProgression','Basic Rate Progression','BasicRateRpt',0,'',0,1);
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'CareerProgression') then
  insert into EmployeeRpt (EmpInfoRptId,EmpInfoRptDesc,EmpInfoRptType,EmployeeRptHasFilter,EmployeeRptFilterCond,EmployeeRptHasEmpCt,EmployeeRptHasEmpOnly)
  values ('CareerProgression','Career Progression','CareerProgRpt',0,'',0,1);
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'ContractProgression') then
  insert into EmployeeRpt (EmpInfoRptId,EmpInfoRptDesc,EmpInfoRptType,EmployeeRptHasFilter,EmployeeRptFilterCond,EmployeeRptHasEmpCt,EmployeeRptHasEmpOnly)
  values ('ContractProgression','Contract Progression','ContractProgRpt',0,'',0,1);
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'Education') then
  insert into EmployeeRpt (EmpInfoRptId,EmpInfoRptDesc,EmpInfoRptType,EmployeeRptHasFilter,EmployeeRptFilterCond,EmployeeRptHasEmpCt,EmployeeRptHasEmpOnly)
  values ('Education','Education','EducationRpt',0,'',0,1);
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'EmpBankAllocation') then
  insert into EmployeeRpt (EmpInfoRptId,EmpInfoRptDesc,EmpInfoRptType,EmployeeRptHasFilter,EmployeeRptFilterCond,EmployeeRptHasEmpCt,EmployeeRptHasEmpOnly)
  values ('EmpBankAllocation','Employee Bank Allocation','EmpBankAllocRpt',0,'',0,1);
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'EmploymentDetails') then
  insert into EmployeeRpt (EmpInfoRptId,EmpInfoRptDesc,EmpInfoRptType,EmployeeRptHasFilter,EmployeeRptFilterCond,EmployeeRptHasEmpCt,EmployeeRptHasEmpOnly)
  values ('EmploymentDetails','Employment Details','PersonalEmpDetRpt',0,'',0,1);
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'Family') then
  insert into EmployeeRpt (EmpInfoRptId,EmpInfoRptDesc,EmpInfoRptType,EmployeeRptHasFilter,EmployeeRptFilterCond,EmployeeRptHasEmpCt,EmployeeRptHasEmpOnly)
  values ('Family','Family','FamilyRpt',0,'',0,1);
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'PersonalAddress') then
  insert into EmployeeRpt (EmpInfoRptId,EmpInfoRptDesc,EmpInfoRptType,EmployeeRptHasFilter,EmployeeRptFilterCond,EmployeeRptHasEmpCt,EmployeeRptHasEmpOnly)
  values ('PersonalAddress','Personal Address','PersonalAddressRpt',0,'',0,1);
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'PersonalContact') then
  insert into EmployeeRpt (EmpInfoRptId,EmpInfoRptDesc,EmpInfoRptType,EmployeeRptHasFilter,EmployeeRptFilterCond,EmployeeRptHasEmpCt,EmployeeRptHasEmpOnly)
  values ('PersonalContact','Personal Contact','PersonalContactRpt',0,'',0,1);
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'PersonalEmail') then
  insert into EmployeeRpt (EmpInfoRptId,EmpInfoRptDesc,EmpInfoRptType,EmployeeRptHasFilter,EmployeeRptFilterCond,EmployeeRptHasEmpCt,EmployeeRptHasEmpOnly)
  values ('PersonalEmail','Personal Email','PersonalEmailRpt',0,'',0,1);
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'Recurring') then
  insert into EmployeeRpt (EmpInfoRptId,EmpInfoRptDesc,EmpInfoRptType,EmployeeRptHasFilter,EmployeeRptFilterCond,EmployeeRptHasEmpCt,EmployeeRptHasEmpOnly)
  values ('Recurring','Recurring','RecurringRpt',0,'',0,1);
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'ResidenceStatus') then
  insert into EmployeeRpt (EmpInfoRptId,EmpInfoRptDesc,EmpInfoRptType,EmployeeRptHasFilter,EmployeeRptFilterCond,EmployeeRptHasEmpCt,EmployeeRptHasEmpOnly)
  values ('ResidenceStatus','Residence Status','PersonalResidenceRpt',0,'',0,1);
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'Training') then
  insert into EmployeeRpt (EmpInfoRptId,EmpInfoRptDesc,EmpInfoRptType,EmployeeRptHasFilter,EmployeeRptFilterCond,EmployeeRptHasEmpCt,EmployeeRptHasEmpOnly)
  values ('Training','Training','TrainingRpt',1,'YEAR(CourseSchedule.CourseStartDate) = YEAR(NOW(*))',0,1);
end if;

--Financial Report Setup
if not exists (select 1 from FinancialRpt where FinancialRptId = 'LeaveSummary') then
  insert into FinancialRpt (FinancialRptId,LayoutSchemeId,FinancialRptDesc,FinancialAnalysProjId,FinancialHasGrandTot,FinancialHasTotEmpCt) values ('LeaveSummary','LeaveList','Leave Summary','Excel_LeaveSummary',0,0);
end if;
if not exists (select 1 from AnlysSetup where AnlysSetupId = 'Excel_LeaveSummary') then
  insert into AnlysSetup (AnlysSetupId,AnlysSetupDesc) values ('Excel_LeaveSummary','Leave Summary');
end if;
if not exists (select 1 from AnlysProject where AnlysProjectId = 'Excel_LeaveSummary') then
  insert into AnlysProject (AnlysProjectId,AnlysSetupId,AnlysProjectDesc,AnlysProjectType,Basis1,Basis2,Basis3,CycleMethod,CycleGroupBy,CycleSubGroupBy,SummaryLevel,IsSystemProject,AnlysProjectSubType)
  values ('Excel_LeaveSummary','Excel_LeaveSummary','Leave Summary','ProjectTypePay','','','','CycMtdPeriod','PeriodGrpPd','SubGrpLeaveTypeId','SumLevelEmpee',0,'ProjSubTypeLveSumm');
end if;
if not exists (select 1 from FinancialRpt where FinancialRptId = 'PayRecords') then
  insert into FinancialRpt (FinancialRptId,LayoutSchemeId,FinancialRptDesc,FinancialAnalysProjId,FinancialHasGrandTot,FinancialHasTotEmpCt) values ('PayRecords','BreakdownList','Pay Records','Excel_PayRecords',0,0);
end if;
if not exists (select 1 from AnlysSetup where AnlysSetupId = 'Excel_PayRecords') then
  insert into AnlysSetup (AnlysSetupId,AnlysSetupDesc) values ('Excel_PayRecords','Pay Records');
end if;
if not exists (select 1 from AnlysProject where AnlysProjectId = 'Excel_PayRecords') then
  insert into AnlysProject (AnlysProjectId,AnlysSetupId,AnlysProjectDesc,AnlysProjectType,Basis1,Basis2,Basis3,CycleMethod,CycleGroupBy,CycleSubGroupBy,SummaryLevel,IsSystemProject,AnlysProjectSubType)
  values ('Excel_PayRecords','Excel_PayRecords','Pay Records','ProjectTypePay','','','','CycMtdCalen','CalenGrpMth','SubGrpALL','SumLevelEmpee',0,'ProjSubTypePayRec');
end if;
update AnlysKeyword set AnlysKeywordRef = 'Leave' where AnlysKeywordCategory = 'AnlysProjectSubType' and AnlysKeywordId = 'ProjSubTypeLveSumm';
update AnlysKeyword set AnlysKeywordRef = 'Payroll' where AnlysKeywordCategory = 'AnlysProjectSubType' and AnlysKeywordId = 'ProjSubTypePayRec';

/*------------------ Create iYTDTHPolicy ------------------------*/
if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='iYTDTHPolicy_PK'
     and t.table_name='iYTDTHPolicy'
) then
   drop index iYTDTHPolicy.iYTDTHPolicy_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='iYTDTHPolicy'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table iYTDTHPolicy
end if;

/*==============================================================*/
/* Table: iYTDTHPolicy                                          */
/*==============================================================*/
create table DBA.iYTDTHPolicy 
(
    YTDTHPolicySysId     integer                        not null default AUTOINCREMENT,
    YTDTHPolicyEmployeeId char(30)                       not null,
    YTDTHPolicyYear      integer                        not null,
    YTDTHPolicyPeriod    integer                        not null,
    SSEE                 double,
    SSER                 double,
    PF1EE                double,
    PF1ERNormal          double,
    PF1ERSpecial         double,
    PF2EE                double,
    PF2ERNormal          double,
    PF2ERSpecial         double,
    PF3EE                double,
    PF3ERNormal          double,
    PF3ERSpecial         double,
    PF4EE                double,
    PF4ERNormal          double,
    PF4ERSpecial         double,
    PF5EE                double,
    PF5ERNormal          double,
    PF5ERSpecial         double,
    PaidTaxAmt           double,
    Processed            smallint,
    ProcessedDateTime    timestamp,
    ErrorMessage         char(100),
    CreatedBy            char(1),
    InterfaceGranted     smallint,
    constraint PK_IYTDTHPOLICY primary key (YTDTHPolicySysId)
);

/*==============================================================*/
/* Index: iYTDTHPolicy_PK                                       */
/*==============================================================*/
create unique index iYTDTHPolicy_PK on iYTDTHPolicy (
YTDTHPolicySysId ASC
);



commit work;