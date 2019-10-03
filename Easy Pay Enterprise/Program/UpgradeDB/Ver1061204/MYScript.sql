Read UpgradeDB\Ver1061204\MYTimeSheet.sql;
Read UpgradeDB\Ver1061204\MYTimeSheetSP1.sql;
Read UpgradeDB\Ver1061204\MYTimeSheetSP2.sql;

/* KeyWord */
if not exists(select * from Keyword Where KeyWordId = 'SOCSOEmpE') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('SOCSOEmpE','','[Blank] - Existing','SOCSOEmpStatus',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'SOCSOEmpB') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('SOCSOEmpB','B','B - New Join','SOCSOEmpStatus',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'SOCSOEmpH') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('SOCSOEmpH','H','H - Cessation','SOCSOEmpStatus',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'SOCSOEmpM') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('SOCSOEmpM','M','M - Decease','SOCSOEmpStatus',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'SOCSOEmpS') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('SOCSOEmpS','S','S - On SOCSO Benefit Leave','SOCSOEmpStatus',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'SOCSOEmpT') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('SOCSOEmpT','T','T - On 1 Month NPL','SOCSOEmpStatus',0,0,0,'',0,0,0,'')
end if;

Delete From Keyword Where KeyWordId in ('0','1','2','3','4','5');


/* PeriodPolicySummary */
Update PeriodPolicySummary Set SocsoEmpStatus = 'SOCSOEmpE' Where MAWContriOption = 0 and (SocsoEmpStatus is null);
Update PeriodPolicySummary Set SocsoEmpStatus = 'SOCSOEmpB' Where MAWContriOption = 1 and (SocsoEmpStatus is null);
Update PeriodPolicySummary Set SocsoEmpStatus = 'SOCSOEmpH' Where MAWContriOption = 2 and (SocsoEmpStatus is null);
Update PeriodPolicySummary Set SocsoEmpStatus = 'SOCSOEmpM' Where MAWContriOption = 3 and (SocsoEmpStatus is null);
Update PeriodPolicySummary Set SocsoEmpStatus = 'SOCSOEmpS' Where MAWContriOption = 4 and (SocsoEmpStatus is null); 
Update PeriodPolicySummary Set SocsoEmpStatus = 'SOCSOEmpT' Where MAWContriOption = 5 and (SocsoEmpStatus is null);
Update PeriodPolicySummary Set MAWContriOption = 0;



/* Pay Process Flow Default Data */

if not exists(select keywordid from keyword where keywordid='Payslip') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('Payslip','InvokeRPayslipFrontend','Payslip','Reports','','','','RPayslipFrontend.dll',1,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='BonusProcessReport') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('BonusProcessReport','InvokeBonusProcessingReport','Bonus Processing Report','Reports','','','','RPayEngine.dll',2,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='PayrollSummaryReport') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('PayrollSummaryReport','InvokePayrollSummary','Payroll Summary Report','Reports','','','','RPayrollSummary.dll',3,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='StatisticsReport') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('StatisticsReport','InvokeAnlysStatistic','Statistics Report','Reports','','','','RPayEngine.dll',4,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='Bank/CashListing') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('Bank/CashListing','InvokeBankCashListing','Bank/Cash Listing Report','Reports','','','','RPayEngine.dll',5,'',0,'');
end if ;


if not exists(select keywordid from keyword where keywordid='PayrollVarianceRpt') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('PayrollVarianceRpt','InvokeAnlysVariance','Payroll Variance Report','Reports','','','','RPayEngine.dll',6,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='PayAnalysisReport') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('PayAnalysisReport','InvokePayrollAnalysis','Payroll Analysis Report','Reports','','','','RPayrollAnalysis.dll',7,'',0,'');
end if ;


if not exists(select keywordid from keyword where keywordid='AdvPayProReport') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('AdvPayProReport','InvokeAdvanceProcessingReport','Advance Pay Processing Report','Reports','','','','RPayEngine.dll',8,'',0,'');
end if ;


if not exists(select keywordid from keyword where keywordid='LoanReport') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('LoanReport','InvokeLoanReportGeneric','Loan Report','Reports','','','','RLoanGeneric.dll',9,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='BankDiskSubmission') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('BankDiskSubmission','InvokeRBankSubmissionFrontend','BankDisk Submission','Submissions','','','','RBankSubmission.dll',1,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='EPFReturn') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('EPFReturn','InvokeEPFReturnReport','EPF Return (Bornag A)','Submissions','','','','RMalGovForm.dll',2,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='ZakatDiskSub') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('ZakatDiskSub','InvokeZakatSub','Zakat Diskette Submission','Submissions','','','','RMalGovForm.dll',3,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='ZakatFormSub') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('ZakatFormSub','InvokeZakatForm','Zakat Form Submission','Submissions','','','','RMalGovForm.dll',4,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='Socso8A') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('Socso8A','InvokeSocso8AReport','Socso8A','Submissions','','','','RMalGovForm.dll',5,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='Socso2/3') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('Socso2/3','InvokeSocso2Report','Socso2/3','Submissions','','','','RMalGovForm.dll',6,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='CP39') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('CP39','InvokeCP39Report','CP 39(Monthly Tax Submission)','Submissions','','','','RMalGovForm.dll',7,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='CP22') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('CP22','InvokeCP22Report','CP 22(New Join Staff)','Submissions','','','','RMalGovForm.dll',8,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='CP21') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('CP21','InvokeCP22AReport','CP21 (Leaver) / CP22A / CP22B','Submissions','','','','RMalGovForm.dll',9,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='TabungHaji') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('TabungHaji','InvokeTbhjReport','Tabung Haji','Submissions','','','','RMalGovForm.dll',10,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='ASB') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('ASB','InvokeASBReport','ASB','Submissions','','','','RMalGovForm.dll',11,'',0,'');
end if ;

if not exists(select keywordid from keyword where keywordid='HRDF') then
     insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,
     KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
     Values ('HRDF','InvokeRHRDFSubmission','HRDF','Submissions','','','','RMalGovForm.dll',12,'',0,'');
end if ;


/* SubRegistry */
Update Subregistry Set RegProperty4 = 'SocsoEmpStatus' Where Registryid = 'PayPeriodPolicy' and SubRegistryid = 'SOCSOEmpStatus';

/* Maybank 2E-RC */
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'EPF' and FormatName = 'Maybank 2E-RC') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('EPF', 'Maybank 2E-RC', 'RMalayBankFormatMaybank2ERC.dll', 'InvokeEPFFormatter', 0);
end if;
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'SOCSO' and FormatName = 'Maybank 2E-RC') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('SOCSO', 'Maybank 2E-RC', 'RMalayBankFormatMaybank2ERC.dll', 'InvokeSOCSOFormatter', 0);
end if;
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'CP39' and FormatName = 'Maybank 2E-RC') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('CP39', 'Maybank 2E-RC', 'RMalayBankFormatMaybank2ERC.dll', 'InvokeCP39Formatter', 0);
end if;

commit work;