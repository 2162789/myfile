Read UpgradeDB\Ver1061005\IDStoredProc.sql;

/* Crystal report for BPJS Kesehatan Report */
if not exists(select * from keyword where keywordid = 'CR_IDPayListOfCesEmp') then
   insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
                       KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('CR_IDPayListOfCesEmp','Pay','Health Insurance Contributions','CrystalRpt Cus Mgr',NULL,NULL,NULL,'BPJS Kesehatan Report - Health Insurance Contributions',NULL,NULL,1,'');
end if;

if not exists(select * from keyword where keywordid = 'CR_IDPayHealthIns') then
   insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
                       KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('CR_IDPayHealthIns','Pay','List of Cessation Employees','CrystalRpt Cus Mgr',NULL,NULL,NULL,'BPJS Kesehatan Report - List of Cessation Employees',NULL,NULL,1,'');
end if;

/* Crystal report for Income Tax Reports -> 1770SS */
if not exists(select * from keyword where keywordid = 'CR_IDPayTax1770SS') then
   insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
                       KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('CR_IDPayTax1770SS','Pay','Income Tax Reports - 1770SS','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Income Tax Reports - 1770SS',NULL,NULL,1,'');
end if;

/* Crystal report for Income Tax Reports -> 1770S */
if not exists(select * from keyword where keywordid = 'CR_IDPayTax1770S') then
   insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
                       KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('CR_IDPayTax1770S','Pay','Income Tax Reports - 1770S','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Income Tax Reports - 1770S',NULL,NULL,1,'');
end if;

/* BPJSTK contribution for the resign employees*/
delete from SubRegistry Where RegistryID='Indonesia' And SubRegistryID='JamsoCessPayment';
if not exists(select * from SubRegistry where RegistryId = 'PayOption' and SubRegistryId = 'BPJSResignProcess') then
   insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,
                           RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('PayOption','BPJSResignProcess','','','','','','','','','','',0,0,'',0,'BPJSFull','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from keyword where keywordid = 'BPJSProrate') then
   insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
                       KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('BPJSProrate','Prorate','Prorate','BPJSResignProcess',0,0,0,'',0,0,0,'');
end if;

if not exists(select * from keyword where keywordid = 'BPJSFull') then
   insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
                       KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('BPJSFull','No Prorate','No Prorate','BPJSResignProcess',0,0,0,'',0,0,0,'');
end if;

if not exists(select * from keyword where keywordid = 'BPJSNoContri') then
   insert into keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
                       KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values('BPJSNoContri','No Contribution','No Contribution','BPJSResignProcess',0,0,0,'',0,0,0,'');
end if;

/* BPJSTK policy*/
BPJSTKLoop: FOR BPJSTK AS BPJSTKCus DYNAMIC SCROLL CURSOR FOR    
  SELECT FormulaId as OUT_FormulaId, FormulaRangeId as OUT_FormulaRangeId,
         Constant1 as OUT_Constant1
    FROM FormulaRange 
	WHERE FormulaId IN (SELECT FormulaId FROM Formula WHERE FormulaCategory = 'JamsoFormula' 
	                     AND FormulaType in ('EEJamso','OldAge','Accident','Death'))
DO 
   Update FormulaRange Set Formula = '@ROUND(U1 * (C1/100),0);', UserDef1 = '@LIMIT(K1,C2,C3);',
     Constant2 = 0, Constant3 = 9999999999, 
	 Constant4 = 0, Constant5 = Round(9999999999 * (OUT_Constant1/100),0)
   WHERE FormulaId = OUT_FormulaId AND FormulaRangeId = OUT_FormulaRangeId;
 END FOR;

/* BPJS Kesehatan policy*/
BPJSKesLoop: FOR BPJSKes AS BPJSKesCus DYNAMIC SCROLL CURSOR FOR    
  SELECT FormulaId as OUT_FormulaId, FormulaRangeId as OUT_FormulaRangeId,
         Constant1 as OUT_Constant1, Constant2 as OUT_Constant2, Constant3 as OUT_Constant3, 
    	 Constant4 as OUT_Constant4, Constant5 as OUT_Constant5
    FROM FormulaRange 
	WHERE FormulaId IN (SELECT FormulaId FROM Formula WHERE FormulaCategory = 'JamsoFormula' 
	                     AND FormulaType in ('EEBPJSKS','ERBPJSKS'))
DO 
   // Only update if the constant2 is refer to contribution not wage
   if (OUT_Constant2 < OUT_Constant4) then
      Update FormulaRange Set Formula = '@ROUND(U1 * (C1/100),0);', UserDef1 = '@LIMIT(K1,C2,C3);',
        Constant2 = OUT_Constant4, Constant3 = OUT_Constant5, 
	    Constant4 = Round(OUT_Constant4 * (OUT_Constant1/100),0), Constant5 = Round(OUT_Constant5 * (OUT_Constant1/100),0)
      WHERE FormulaId = OUT_FormulaId AND FormulaRangeId = OUT_FormulaRangeId;
    end if;
 END FOR;

if not exists (select 1 from KeyWord where KeyWordId = 'EX_BPJSKesehatanWage') then
  insert into KeyWord
  (KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values ('EX_BPJSKesehatanWage','BPJS Kes Wage','BPJS Kes Wage','EXPORT',0,0,0,'CurrEEManWage',120,2,0,'')
end if;

if not exists (select 1 from KeyWord where KeyWordId = 'EX_BPJSKesWage_Prev') then
  insert into KeyWord
  (KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values ('EX_BPJSKesWage_Prev','BPJS Kes Wage (Prev)','BPJS Kes Wage (Prev)','EXPORT',0,0,0,'CurrEEManWage',120,8,0,'')
end if;

if not exists (select 1 from KeyWord where KeyWordId = 'EX_EmpeeBPJSKes') then
  insert into KeyWord
  (KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values ('EX_EmpeeBPJSKes','Employee BPJS Kes','Employee BPJS Kes','EXPORT',0,0,0,'CurrEEManContri',121,2,0,'')
end if;

if not exists (select 1 from KeyWord where KeyWordId = 'EX_EmpeeBPJSKes_Prev') then
  insert into KeyWord
  (KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values ('EX_EmpeeBPJSKes_Prev','Employee BPJS Kes (Prev)','Employee BPJS Kes (Prev)','EXPORT',0,0,0,'CurrEEManContri',121,8,0,'')
end if;

if not exists (select 1 from KeyWord where KeyWordId = 'EX_EmperBPJSKes') then
  insert into KeyWord
  (KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values ('EX_EmperBPJSKes','Employer BPJS Kes','Employer BPJS Kes','EXPORT',0,0,0,'CurrERManContri',122,2,0,'')
end if;

if not exists (select 1 from KeyWord where KeyWordId = 'EX_EmperBPJSKes_Prev') then
  insert into KeyWord
  (KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values ('EX_EmperBPJSKes_Prev','Employer BPJS Kes (Prev)','Employer BPJS Kes (Prev)','EXPORT',0,0,0,'CurrERManContri',122,8,0,'')
end if;

/* Report Export -> Update Jamsostek to BPJSTk */
Update Keyword Set KeyWordDefaultName = 'BPJSTK Wage', KeyWordUserDefinedName = 'BPJSTK Wage' where KeyWordId = 'EX_CPFWage';
Update Keyword Set KeyWordDefaultName = 'BPJSTK Wage (Prev)', KeyWordUserDefinedName = 'BPJSTK Wage (Prev)' where KeyWordId = 'EX_CPFWage_PREV';
Update ExportPayItems Set ExPayItems = 'BPJSTK Wage', ExUserDefineName = 'BPJSTK Wage' where ExPayItems = 'Jamsostek Wage';
Update ExportPayItems Set ExPayItems = 'BPJSTK Wage (Prev)', ExUserDefineName = 'BPJSTK Wage (Prev)' where ExPayItems = 'Jamsostek Wage (Prev)';
Update Keyword Set KeyWordDefaultName = 'BPJSTK Formula', KeyWordUserDefinedName = 'BPJSTK Formula' where KeyWordId = 'JamsoFormula';

/* BPJS Kesehatan Progression Report */
if not exists (select 1 from keyword where keywordid = 'CR_IDPayBPJSKP') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,
                       KeyWordRangeSelection,KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   values ('CR_IDPayBPJSKP','Pay','BPJS Kesehatan Progression Report','CrystalRpt Cus Mgr',NULL,NULL,NULL,'BPJS Kesehatan Progression Report',NULL,NULL,1,'')
end if;

if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'PayBPJSKesProgRpt') then
  insert into ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
  values ('PayBPJSKesProgRpt','PayEmpeeReports','BPJS Kesehatan Progression Report','Pay',0,0,0,'')
end if;

/* Import Designer -> Update Jamsostek to BPJSTK */
Update ImportFieldName Set FieldNameUserDefined = 'Employee BPJSTK' Where TableNamePhysical = 'iYTDIDPolicy' and FieldNamePhysical = 'EmployeeJamsostek';
Update ImportFieldName Set FieldNameUserDefined = 'Employer BPJSTK - Old Age' Where TableNamePhysical = 'iYTDIDPolicy' and FieldNamePhysical = 'OldAgeJamsostek';
Update ImportFieldName Set FieldNameUserDefined = 'Employer BPJSTK - Accident' Where TableNamePhysical = 'iYTDIDPolicy' and FieldNamePhysical = 'AccidentJamsostek';
Update ImportFieldName Set FieldNameUserDefined = 'Employer BPJSTK - Death' Where TableNamePhysical = 'iYTDIDPolicy' and FieldNamePhysical = 'DeathJamsostek';

/* Employee Tax Forms */
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'PayEmployeeTaxForms') then
  insert into ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
  values ('PayEmployeeTaxForms','PayIncomeTaxRpt','Employee Tax Forms','Pay',0,1,0,'')
end if;

if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'PayeSPTImport') then
  insert into ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
  values ('PayeSPTImport','PayIncomeTaxRpt','eSPT Import','Pay',0,1,0,'')
end if;

Update ModuleScreenGroup Set HideScreenForWage = 1 Where ModuleScreenId in ('PayBPJSKSReports', 'PayBPJSKSListRpt');
Update ModuleScreenGroup Set Mod_ModuleScreenId = 'PayeSPTImport' Where ModuleScreenId in ('PayTax1721A1CSV', 'PayTaxeSPTMonthly');

/* Interface -> Update Jamsostek to BJSTK */
Update SubRegistry Set RegProperty8 = 'BPJSTK Status' Where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'YTDJamsostek';
Update SubRegistry Set RegProperty8 = 'BPJSTK Policy' Where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'CPFProgPolicyId';
Update SubRegistry Set RegProperty8 = 'BPJSTK Scheme' Where RegistryId = 'InterfaceCodeTable' and SubRegistryId = 'CPFProgSchemeId';
Update SubRegistry Set RegProperty7 = 'BPJSTK Progression' Where RegistryId = 'InterfaceSelection' and SubRegistryId = 'iCPFProgression';

/* Update Cessation Code */
if not exists(select * from Cessation Where CessationCode = 'Dipindahkan') then
   Insert into Cessation(CessationCode,CessationDesc) Values('Dipindahkan','Dipindahkan ke kantor pusat atau kantor cabang lainnya dengan pemberi kerja yang sama (Transfer)');
end if;

if not exists(select * from Cessation Where CessationCode = 'Pindah kerja') then
   Insert into Cessation(CessationCode,CessationDesc) Values('Pindah kerja','Pindah ke pemberi kerja lainnya di Indonesia (Change employer)');
end if;

if not exists(select * from Cessation Where CessationCode = 'Pensiun') then
   Insert into Cessation(CessationCode,CessationDesc) Values('Pensiun','Berhenti karena pensiun (Pension)');
end if;

if not exists(select * from Cessation Where CessationCode = 'Pindah keluar negeri') then
   Insert into Cessation(CessationCode,CessationDesc) Values('Pindah keluar negeri','Berhenti dan meninggalkan Indonesia untuk selama-lamanya (Leaving country)');
end if;

if not exists(select * from Cessation Where CessationCode = 'Meninggal') then
   Insert into Cessation(CessationCode,CessationDesc) Values('Meninggal','Berhenti karena meninggal dunia (Pass away)');
end if;

Update Employee Set CessationCode = 'Dipindahkan' Where CessationCode = 'Trans to subsidiary';
Update Employee Set CessationCode = 'Pindah kerja' Where CessationCode = 'Resigned';
Update Employee Set CessationCode = 'Pensiun' Where CessationCode = 'Retired';
Update Employee Set CessationCode = 'Pindah keluar negeri' Where CessationCode = 'Leave Country';
Update Employee Set CessationCode = 'Meninggal' Where CessationCode = 'Deceased';

delete from Cessation where CessationCode in ('Trans to subsidiary','Resigned','Retired','Leave Country','Deceased');

commit work;