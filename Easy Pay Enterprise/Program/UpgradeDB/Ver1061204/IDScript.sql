Read UpgradeDB\Ver1061204\IDBPJSPensiun2016Mar.sql;
Read UpgradeDB\Ver1061204\IDBPJSKesehatan2016Apr.sql;

/* Company Branch BPJS Kesehatan No */
if not exists(select * from SubRegistry where RegistryId = 'BranchGov' and SubRegistryId = 'BPJSKesNo') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('BranchGov','BPJSKesNo','BPJSKesNo','BPJS Kesehatan Account No','BPJSKes','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

BranchGovLoop: FOR BranchGovList AS DYNAMIC SCROLL CURSOR FOR    
   SELECT CompanyId AS OUT_CompanyId, BranchId AS OUT_BranchId FROM BranchGov 
   WHERE BranchGovCode = 'BPJSTKNo'
   DO 
	  if not exists(SELECT * FROM BranchGov Where CompanyId = OUT_CompanyId AND BranchId = OUT_BranchId AND BranchGovCode = 'BPJSKesNo') then
	     Insert Into BranchGov(CompanyId,BranchId,BranchSystem,BranchGovAccNo,BranchGovCode,BranchGovDesc,BranchGovCategory)
		 Values(OUT_CompanyId,OUT_BranchId,1,NULL,'BPJSKesNo','BPJS Kesehatan Account No','BPJSKes');
	  end if;
   END FOR;
   
/* Company Statutory Info */
if not exists(select * from CompanyGov where CompanyId = '001' and CompanyGovCode = 'EmployerBPJSKes') then
   Insert Into CompanyGov(CompanyId,CompanySystem,CompanyGovAccNo,CompanyGovCode,CompanyGovDesc,CompanyGovCategory)
   Values('001',1,NULL,'EmployerBPJSKes','Employer BPJS Kesehatan A/C','BPJSKes');
end if;

/* Pay Process Flow */
if not exists (select 1 from KeyWord where KeyWordId = 'Payslip') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('Payslip','InvokeRPayslipFrontend','Payslip','Reports','','','','RPayslipFrontend.dll',1,'',0,'');
end if;
if not exists (select 1 from KeyWord where KeyWordId = 'BPJSKesehatanRpt') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('BPJSKesehatanRpt','InvokeBPJSKSRpt','BPJS Kesehatan Reports','Reports','','','','RIndoBPJS.dll',2,'',0,'');
end if;
if not exists (select 1 from KeyWord where KeyWordId = 'BPJSPensiunRpt') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('BPJSPensiunRpt','InvokeBPJSPensiunRpt','BPJS Pensiun Report','Reports','','','','RIndoBPJS.dll',3,'',0,'');
end if;
if not exists (select 1 from KeyWord where KeyWordId = 'BPJSTKSubmission') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('BPJSTKSubmission','InvokeLoadRJamsostek','BPJSTK Submission','Reports','','','','RJamsostek.dll',4,'',0,'');
end if;
if not exists (select 1 from KeyWord where KeyWordId = 'MonthlyTaxSubmission') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('MonthlyTaxSubmission','InvokeRIndoTaxSSP','Monthly Tax Submission (SSP)','Reports','','','','RIndoIncomeTax.dll',5,'',0,'');
end if;
if not exists (select 1 from KeyWord where KeyWordId = 'SPTMasaRpt') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('SPTMasaRpt','InvokeIndoTaxSPTMasa','SPT Masa Report','Reports','','','','RIndoIncomeTax.dll',6,'',0,'');
end if;
if not exists (select 1 from KeyWord where KeyWordId = 'BonusProcessingRpt') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('BonusProcessingRpt','InvokeBonusProcessingReport','Bonus Processing Report','Reports','','','','RPayEngine.dll',7,'',0,'');
end if;
if not exists (select 1 from KeyWord where KeyWordId = 'PayrollSummaryRpt') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('PayrollSummaryRpt','InvokePayrollSummary','Payroll Summary Report','Reports','','','','RPayrollSummary.dll',8,'',0,'');
end if;
if not exists (select 1 from KeyWord where KeyWordId = 'StatisticRpt') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('StatisticRpt','InvokeAnlysStatistic','Statistic Report','Reports','','','','RPayEngine.dll',9,'',0,'');
end if;
if not exists (select 1 from KeyWord where KeyWordId = 'BankCashListingRpt') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('BankCashListingRpt','InvokeBankCashListing','Bank/Cash Listing Report','Reports','','','','RPayEngine.dll',10,'',0,'');
end if;
if not exists (select 1 from KeyWord where KeyWordId = 'PayrollVarianceRpt') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('PayrollVarianceRpt','InvokeAnlysVariance','Payroll Variance Report','Reports','','','','RPayEngine.dll',11,'',0,'');
end if;
if not exists (select 1 from KeyWord where KeyWordId = 'PayrollAnalysisRpt') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('PayrollAnalysisRpt','InvokePayrollAnalysis','Payroll Analysis Report','Reports','','','','RPayrollAnalysis.dll',12,'',0,'');
end if;
if not exists (select 1 from KeyWord where KeyWordId = 'AdvancePayProcessRpt') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('AdvancePayProcessRpt','InvokeAdvanceProcessingReport','Advance Pay Processing Report','Reports','','','','RPayEngine.dll',13,'',0,'');
end if;
if not exists (select 1 from KeyWord where KeyWordId = 'LoanRpt') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('LoanRpt','InvokeLoanReportGeneric','Loan Report','Reports','','','','RLoanGeneric.dll',14,'',0,'');
end if;

if not exists (select 1 from KeyWord where KeyWordId = 'BankDiskGeneration') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('BankDiskGeneration','InvokeRBankSubmissionFrontend','Bank Disk Generation','Submissions','','','','RBankSubmission.dll',1,'',0,'');
end if;
if not exists (select 1 from KeyWord where KeyWordId = 'SIPPOnlineUpload') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('SIPPOnlineUpload','InvokeBPJSSIPPOnline','SIPP Online Upload','Submissions','','','','RJamsostek.dll',2,'',0,'');
end if;
if not exists (select 1 from KeyWord where KeyWordId = 'Pemotongan') then
  insert into KeyWord (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
  KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('Pemotongan','InvokeeSPT21Monthly','Pemotongan Pajak Bulanan CSV','Submissions','','','','RIndoIncomeTax.dll',3,'',0,'');
end if;

/* Tax Policy for Non-Residents */
if not exists(select * from IndoTaxPolicy where IndoTaxPolicyId = 'Non-Residents Policy') then
   insert into IndoTaxPolicy(IndoTaxPolicyId,IndoTaxPolicyDesc)
   values('Non-Residents Policy','Income Tax Policy for Non-Residents Employee Less Than 183 Days');
end if;

if not exists(select * from IndoTaxMonthly where IndoTaxMonthlyId = 'Rate2016NonResidents') then
   insert into IndoTaxMonthly(IndoTaxMonthlyId,IndoTaxMonthlyDesc)
   values('Rate2016NonResidents','Non-Residents Tax Rate for Year 2016');
end if;

if not exists(select * from IndoTaxMthFormula where IndoTaxMonthlyId = 'Rate2016NonResidents' and IndoTaxRangeUpto = 9999999999) then
   insert into IndoTaxMthFormula(IndoTaxMonthlyId,IndoTaxRangeUpto,IndoTaxRate)
   values('Rate2016NonResidents',9999999999,20);
end if;

if not exists(select* from IndoTaxPolicyProg where IndoTaxPolicyId = 'Non-Residents Policy' and IndoTaxEffectiveDate = '2016-01-01') then
   insert into IndoTaxPolicyProg(IndoTaxPolicyId,IndoTaxMonthlyId,IndoTaxRegionId,IndoTaxEffectiveDate,IndoTaxFullBorneGovt,IndoTaxOccuPercent,IndoTaxOccuCapping,
	            IndoTaxPensionPercent,IndoTaxPensionCapping,IndoTaxPersonal,IndoTaxMarriage,IndoTaxDependent,IndoTaxDependentCap)
   values('Non-Residents Policy','Rate2016NonResidents','Default Region','2016-01-01',0,0,0,0,0,0,0,0,0);
end if;

commit work;