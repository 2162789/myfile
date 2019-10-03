/* Update the scheme from jamsostek to BPJSTK */
if not exists(select * from KeyWord where KeyWordId = 'BPJSTK') then
   Insert into KeyWord(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   Values('BPJSTK','BPJSTK','BPJSTK','CPFScheme',0,0,0,'',0,0,0,'');
end if; 
update CPFProgression set CPFProgSchemeId = 'BPJSTK';
update CPFTableCode set CPFSchemeId = 'BPJSTK' where CPFSchemeId = 'Standard';
Update KeyWord set KeyWordDefaultName = 'BPJSKesehatan', KeyWordUserDefinedName = 'BPJSKesehatan' where KeyWordId = 'BPJSKesehatan';
delete from KeyWord where KeyWordId = 'Standard';

/* Pay Record and Pay Period*/
Update subregistry set RegProperty3 = 'BPJSTK' Where registryid = 'PayPeriodPolicy' and SubRegistryId = 'Jamsostek';
Update subregistry set RegProperty3 = 'BPJSTK Status' Where registryid = 'PayPeriodPolicy' and SubRegistryId = 'JamsostekStatus';
Update subregistry set RegProperty3 = 'BPJSTK Wage' Where registryid = 'PayPeriodPolicy' and SubRegistryId = 'JamsostekWage';
Update subregistry set RegProperty3 = 'BPJSTK' Where registryid = 'PayRecordPolicy' and SubRegistryId = 'ERContri';
Update subregistry set RegProperty3 = 'BPJSTK Wage' Where registryid = 'PayRecordPolicy' and SubRegistryId = 'JamsostekWage';

/* Wage Formula */
Update keyword Set KeyWordDefaultName = 'BPJSTK Wage', KeyWordUserDefinedName = 'BPJSTK Wage' Where keywordid = 'JamsostekWage';
Update keyword Set KeyWordDefaultName = 'Subject to BPJSTK', KeyWordUserDefinedName = 'Subject to BPJSTK' Where keywordid = 'SubjJamsostek';
Update keyword Set KeyWordDefaultName = 'BPJSTK Allowance', KeyWordUserDefinedName = 'BPJSTK Allowance' Where keywordid = 'JamsoAllowance';
Update keyword Set KeyWordDefaultName = 'BPJSTK Deduction', KeyWordUserDefinedName = 'BPJSTK Deduction' Where keywordid = 'JamsoDeduction';
Update keyword Set KeyWordDefaultName = 'Non BPJSTK Allowance', KeyWordUserDefinedName = 'Non BPJSTK Allowance' Where keywordid = 'NonJamsoAllowance';
Update keyword Set KeyWordDefaultName = 'Non BPJSTK Deduction', KeyWordUserDefinedName = 'Non BPJSTK Deduction' Where keywordid = 'NonJamsoDeduction';
Update keyword Set KeyWordDefaultName = 'Employer BPJSTK', KeyWordUserDefinedName = 'Employer BPJSTK' Where keywordid = 'ERJamsostek';
Update keyword Set KeyWordDefaultName = 'BPJSTK Allowance (Ex User Defined)', KeyWordUserDefinedName = 'BPJSTK Allowance (Ex User Defined)' Where keywordid = 'UDJamsoAllowance';
Update keyword Set KeyWordDefaultName = 'BPJSTK Deduction (Ex User Defined)', KeyWordUserDefinedName = 'BPJSTK Deduction (Ex User Defined)' Where keywordid = 'UDJamsoDeduction';
Update keyword Set KeyWordDefaultName = 'Non BPJSTK Allowance (Ex User Defined)', KeyWordUserDefinedName = 'Non BPJSTK Allowance (Ex User Defined)' Where keywordid = 'UDNonJamsoAllowance';
Update keyword Set KeyWordDefaultName = 'Non BPJSTK Deduction (Ex User Defined)', KeyWordUserDefinedName = 'Non BPJSTK Deduction (Ex User Defined)' Where keywordid = 'UDNonJamsoDeduction';

/* Pay Details Default */
Update SubRegistry set RegProperty2 = 'BPJSTK Policy' where RegistryId='PaySetupData' and SubRegistryid = 'CPFProgPolicyId';
Update SubRegistry set RegProperty2 = 'BPJSTK Scheme', RegProperty7 = 'Select * from KeyWord where KeywordId = ''BPJSTK'';',ShortStringAttr = 'BPJSTK' where RegistryId='PaySetupData' and SubRegistryid = 'CPFProgSchemeId';
Update SubRegistry set RegProperty7 = 'Select * from KeyWord where KeywordId = ''BPJSKesehatan'';' where RegistryId='PaySetupData' and SubRegistryid = 'BPJSKSProgSchemeId';

/* Jamsostek Progression Viewer */
Update SubRegistry set RegProperty1 = 'BPJSTK Progression Viewer' Where RegistryId='Viewer' and SubRegistryId = 'CPFProgViewer'

/* Costing -> Cost Item*/
Update CostKeyword Set CostKeywordUserDefinedName = 'Employee BPJSTK Contribution',CostKeywordDesc = 'Employee BPJSTK Contribution' Where CostKeywordId = 'EEJamso';
Update CostKeyword Set CostKeywordUserDefinedName = 'Employer BPJSTK Contribution',CostKeywordDesc = 'Employer BPJSTK Contribution' Where CostKeywordId = 'ERJamso';

/* Import Designer */
update ImportFieldTable set TableNameUserDefined = 'BPJSTK Progression' where TableNamePhysical = 'iCPFProgression';
Update ImportFieldName Set FieldNameUserDefined = 'BPJSTK Status' Where TableNamePhysical = 'iYTDIDPolicy' and FieldNamePhysical = 'JamsostekStatus';

/* Statistic Report */
Update SystemAttribute Set SysUserdefinedName = 'BPJSTK Wage' where SysTableId = 'PolicyRecord' and SysAttributeId = 'Ana_JamsostekWage';
Update SystemAttribute Set SysUserdefinedName = 'Total Employee BPJSTK' where SysTableId = 'PolicyRecord' and SysAttributeId = 'Ana_TotalEmpeeJamsostek';

/* Company Setup */
Update SubRegistry Set RegProperty1 = 'BPJSTKNo', RegProperty2 = 'BPJSTK Account No', RegProperty3 = 'BPJSTK' Where RegistryId = 'BranchGov' and SubRegistryId = 'JamsostekNo';
if not exists(select * from BranchGov where CompanyId = '001' and BranchId = 'None') then
   insert into BranchGov(CompanyId,BranchId,BranchSystem,BranchGovAccNo,BranchGovCode,BranchGovDesc,BranchGovCategory)
   values('001','None',1,NULL,'BPJSTKNo','BPJSTK Account No','BPJSTK');
end if;
Update BranchGov Set BranchGovCode = 'BPJSTKNo', BranchGovDesc = 'BPJSTK Account No', BranchGovCategory = 'BPJSTK';
Update CompanyGov Set CompanyGovCode = 'EmployerBPJSTK', CompanyGovDesc = 'Employer BPJSTK A/C', CompanyGovCategory = 'BPJSTK' Where CompanyId = '001' and CompanyGovTypeSysId = 2;

/* Security Setup */
Update ModuleScreenGroup Set ModuleScreenName = 'BPJSTK Progression' Where ModuleScreenId = 'PayCPFProg' and Mod_ModuleScreenId = 'PayModules';
Update ModuleScreenGroup Set ModuleScreenName = 'BPJSTK Progression Report' Where ModuleScreenId = 'PayCPFProgRpt' and Mod_ModuleScreenId = 'PayEmpeeReports';
Update ModuleScreenGroup Set ModuleScreenName = 'Statutory Setup Reports' Where ModuleScreenId = 'PayCPFSetupRpts' and Mod_ModuleScreenId = 'PaySetupReports';
Update ModuleScreenGroup Set ModuleScreenName = 'Statutory Table Report' Where ModuleScreenId = 'PayCPFTableRpt' and Mod_ModuleScreenId = 'PayCPFSetupRpts';
Update ModuleScreenGroup Set ModuleScreenName = 'Statutory Policy Report' Where ModuleScreenId = 'PayCPFPolicyRpt' and Mod_ModuleScreenId = 'PayCPFSetupRpts';
Update ModuleScreenGroup Set ModuleScreenName = 'BPJSTK Submission' Where ModuleScreenId = 'PayCPFSubmissRpts' and Mod_ModuleScreenId = 'PayReports';
Update ModuleScreenGroup Set ModuleScreenName = 'Statutory Setup' Where ModuleScreenId = 'PayCPFSetup' and Mod_ModuleScreenId = 'PaySetup';
Update ModuleScreenGroup Set ModuleScreenName = 'Statutory Table Setup' Where ModuleScreenId = 'PayCPFTableSetup' and Mod_ModuleScreenId = 'PayCPFSetup';
Update ModuleScreenGroup Set ModuleScreenName = 'Statutory Policy Setup' Where ModuleScreenId = 'PayCPFPolicySetup' and Mod_ModuleScreenId = 'PayCPFSetup';
Update ModuleScreenGroup Set ModuleScreenName = 'BPJSTK Progression Viewer' Where ModuleScreenId = 'CPFProgViewer' and Mod_ModuleScreenId = 'InterfaceViewer';

commit work;