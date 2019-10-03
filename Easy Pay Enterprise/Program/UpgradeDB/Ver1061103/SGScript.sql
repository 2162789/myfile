if exists(select * from sys.sysprocedure where proc_name = 'ASQLYEProcessGovtCPFRpt') then
   drop procedure ASQLYEProcessGovtCPFRpt
end if;
create PROCEDURE "DBA"."ASQLYEProcessGovtCPFRpt"(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_Period integer,
in In_OrdWages double,
in In_AddWages double,
in In_CappedOrdWage double,
in In_CappedAddWage double,
in In_ContriOrdEECPF double,
in In_ContriOrdERCPF double,
in In_ContriAddEECPF double,
in In_ContriAddERCPF double,
in In_ActualOrdEECPF double,
in In_ActualOrdERCPF double,
in In_ActualAddEECPF double,
in In_ActualAddERCPF double,
in In_GovtCPFRptCreatedBy char(200)
)
begin
      insert into GovtCPFRpt(PersonalSysId,
              YEYear,
              Period,
              OrdWages,
              AddWages,
              CappedOrdWage,
              CappedAddWage,
              ContriOrdEECPF,
              ContriOrdERCPF,
              ContriAddEECPF,
              ContriAddERCPF,
              ActualOrdEECPF,
              ActualOrdERCPF,
              ActualAddEECPF,
              ActualAddERCPF,
              GovtCPFRptCreatedBy)
       Values(In_PersonalSysId,
              In_YEYear,
              In_Period,
              In_OrdWages,
              In_AddWages,
              In_CappedOrdWage,
              In_CappedAddWage,
              In_ContriOrdEECPF,
              In_ContriOrdERCPF,
              In_ContriAddEECPF,
              In_ContriAddERCPF,
              In_ActualOrdEECPF,
              In_ActualOrdERCPF,
              In_ActualAddEECPF,
              In_ActualAddERCPF,
              In_GovtCPFRptCreatedBy);
end;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLYEGovtCPFRptEmpHistory') then
   drop procedure ASQLYEGovtCPFRptEmpHistory
end if;
Create PROCEDURE "DBA"."ASQLYEGovtCPFRptEmpHistory"(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_CreatedBy char(200))
begin
  CreateEmploymentLoop: for EmploymentFor as curs dynamic scroll cursor for
    select Employee.EmployeeSysId as Out_YEEmployeeSysId,
      HireDate as Out_FromDate,
      CessationDate as Out_ToDate,
      PayGroupId as Out_YEPayGroupId from
      Employee join PayEmployee where Employee.PersonalSysId = In_PersonalSysId and
      (CessationDate = '1899-12-30' or Year(LastPayDate) >= In_YEYear) do
    select first PayPayGroupId into Out_YEPayGroupId from
      PayPeriodRecord where EmployeeSysId = Out_YEEmployeeSysId and
      PayRecYear = In_YEYear order by PayRecPeriod desc;
    insert into GovtCPFRptEmpHistory(
                PersonalSysId,
                YEYear,
                YEEmployeeSysId,
                YEPayGroupId,
                FromDate,
                ToDate,
                GovtCPFRptEmpHistoryCreatedBy)
    values(In_PersonalSysId,
           In_YEYear,
           Out_YEEmployeeSysId,
           Out_YEPayGroupId,
           Out_FromDate,
           Out_ToDate,
           In_CreatedBy); end for
End;

/* MOM Voluntary Paternity Leave */
UPDATE Subregistry SET RegProperty4='0' WHERE SubRegistryId='SGPaternity2013';

IF NOT EXISTS (select * from SubRegistry WHERE SubRegistryId='SGPaternity2015') THEN
  insert into SubRegistry 
(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('SGPaternityPolicy','SGPaternity2015','0','1','3','1','','','','','','',0.0,0,'',0,'','','2015-01-01','1899-12-30 00:00:00.000');
end if;

IF NOT EXISTS (select * from SubRegistry WHERE SubRegistryId='HasMOMVolPaternityLv') THEN
  insert into SubRegistry 
(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('LeaveSetupData','HasMOMVolPaternityLv','Check','Has Voluntary Paternity Leave','BooleanAttr','N','','','','','','',0.0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00.000')
end if;

/* Income Tax Wizard to remove the format address */
UPDATE SubRegistry SET IntegerAttr = IntegerAttr-1, Regproperty2=0 WHERE RegistryId = 'YEProcess' AND SubRegistryId = 'Step' AND IntegerAttr >= 4;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'DBS (IDEAL G3)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'DBS (IDEAL G3)', 'RSingBankFormatDBSIdealG3.dll', 'InvokeSalaryFormatter', 0)
end if;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'UOB (Manual)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'UOB (Manual)', 'RSingBankFormatUOBManual.dll', 'InvokeSalaryFormatter', 0);
  update BankSubmitFormat set StringField5 = 'SALA' where BankSubmitSubmitForId = 'Salary' and FormatName = 'UOB (Manual)';
end if;

/* Income Tax Preparation Checklist */
if not exists(select * from SubRegistry where RegistryId = 'YEProcess' and SubRegistryid = 'PreChecklistStep') then
   Insert into SubRegistry(RegistryId,SubRegistryid,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   Values('YEProcess','PreChecklistStep','','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from Keyword Where KeyWordId = 'CR_SGCPFContriSum') then
   Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   Values('CR_SGCPFContriSum','Pay','CPF Contribution Summary Report','CrystalRpt Cus Mgr',NULL,NULL,NULL,'CPF Contribution Summary Report',NULL,NULL,1,NULL);
end if;

if not exists(select * from Keyword Where KeyWordId = 'CR_SGCPFContriDetail') then
   Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   Values('CR_SGCPFContriDetail','Pay','CPF Contribution Detail Report','CrystalRpt Cus Mgr',NULL,NULL,NULL,'CPF Contribution Detail Report',NULL,NULL,1,NULL);
end if;

if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'PayCPFContriRpt') then
  insert into ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
  values ('PayCPFContriRpt','PayAnalysisRpts','CPF Contribution Report','Pay',0,1,0,'')
end if;

if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'AdjustmentLeave') then
  insert into EmployeeRpt select 'AdjustmentLeave','Adjustment Leave','LeaveAdjustRpt',0,'',0,1;
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'BroughtForwardLeave') then
  insert into EmployeeRpt select 'BroughtForwardLeave','Brought Forward Leave','LeaveBFRpt',0,'',0,1;
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'CPFProgression') then
  insert into EmployeeRpt select 'CPFProgression','CPF Progression','CPFProgRpt',0,'',0,1;
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'CreditLeave') then
  insert into EmployeeRpt select 'CreditLeave','Credit Leave','LeaveCreditRpt',0,'',0,1;
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'EmpPassProgression') then
  insert into EmployeeRpt select 'EmpPassProgression','Employee Pass Progression','EPProgRpt',0,'',0,1;
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'FWLProgression') then
  insert into EmployeeRpt select 'FWLProgression','FWL Progression','FWLProgRpt',0,'',0,1;
end if;
if not exists (select 1 from EmployeeRpt where EmpInfoRptId = 'LeaveApplication') then
  insert into EmployeeRpt select 'LeaveApplication','Leave Application','LeaveApplicationRpt',0,'',0,1;;
end if;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'HSBC (iFile)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'HSBC (iFile)', 'RSingBankFormatHSBCiFile.dll', 'InvokeSalaryFormatter', 0);
end if;

commit work;