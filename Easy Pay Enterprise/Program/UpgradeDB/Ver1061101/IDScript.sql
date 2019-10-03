Read UpgradeDB\Ver1061101\ID_StoredProc.sql;
Read UpgradeDB\Ver1061101\ID_2015JulyBPJSKes.sql;

/* Set the default actual scheme for the BPJS kesehatan Progression */
Update MandatoryContributeProg Set ManContriActSchemeId = 'BPJSKesehatan' Where ManContriActSchemeId is null;
Read UpgradeDB\Ver1061101\ID_2015JulyBPJSPensiun.sql;
Read UpgradeDB\Ver1061101\ID_AnlysDispSection.sql;

/* Add NPWP Policy with effective from 2015-07-01 */
if exists(select * from IndoTaxPolicy where IndoTaxPolicyId = 'Default Policy') then
  if not exists(select* from IndoTaxPolicyProg where IndoTaxPolicyId = 'Default Policy' and IndoTaxEffectiveDate = '2015-07-01') then
      insert into IndoTaxPolicyProg(IndoTaxPolicyId,IndoTaxRegionId,IndoTaxMonthlyId,IndoTaxEffectiveDate,IndoTaxFullBorneGovt,IndoTaxOccuPercent,IndoTaxOccuCapping,
	            IndoTaxPensionPercent,IndoTaxPensionCapping,IndoTaxPersonal,IndoTaxMarriage,IndoTaxDependent,IndoTaxDependentCap)
	  values('Default Policy','Default Region','Rate2009','2015-07-01',0,5,6000000,5,2400000,36000000,3000000,3000000,3);
  end if;
end if;

/* Add No NPWP Policy with effective from 2015-07-01 */
if exists(select * from IndoTaxPolicy where IndoTaxPolicyId = 'No NPWP Policy') then
  if not exists(select* from IndoTaxPolicyProg where IndoTaxPolicyId = 'No NPWP Policy' and IndoTaxEffectiveDate = '2015-07-01') then
      insert into IndoTaxPolicyProg(IndoTaxPolicyId,IndoTaxRegionId,IndoTaxMonthlyId,IndoTaxEffectiveDate,IndoTaxFullBorneGovt,IndoTaxOccuPercent,IndoTaxOccuCapping,
	            IndoTaxPensionPercent,IndoTaxPensionCapping,IndoTaxPersonal,IndoTaxMarriage,IndoTaxDependent,IndoTaxDependentCap)
	  values('No NPWP Policy','Default Region','Rate2009NoNPWP','2015-07-01',0,5,6000000,5,2400000,36000000,3000000,3000000,3);
  end if;
end if;

/* Add Scheme "BPJSPensiun" */
if not exists(select * from Keyword Where KeyWordId = 'BPJSPensiun') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('BPJSPensiun','BPJSPensiun','BPJSPensiun','CPFScheme',0,0,0,NULL,0,0,0,'')
end if;

/* Add Pay Element Property */
if not exists(select * from Keyword Where KeyWordId = 'SubjBPJSPensiun') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   Values('SubjBPJSPensiun','Subject to BPJS Pensiun','Subject to BPJS Pensiun','System',1,0,0,'Only available if not Donation Code',0,0,30,'N')
end if;

/* Add Wage Formula "" */
if not exists(select * from Keyword Where KeyWordId = 'BPJSPensiunWage') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('BPJSPensiunWage','BPJS Pensiun Wage','BPJS Pensiun Wage','System',0,1,1,'',0,0,30,'')
end if;

if not exists(select * from Wageproperty where keywordId='SubjBPJSPensiun' and WageId='BPJSPensiunWage') Then
  Insert into Wageproperty (keywordId,WageId,WagePropertyused)
  Values('SubjBPJSPensiun','BPJSPensiunWage','1');
end if;

if not exists(select * from Wageproperty where keywordId='TotalWage' and WageId='BPJSPensiunWage') Then
  Insert into Wageproperty (keywordId,WageId,WagePropertyused)
  Values('TotalWage','BPJSPensiunWage','1');
end if;

if not exists(select * from Wageproperty where keywordId='LeaveDeductAmt' and WageId='BPJSPensiunWage') Then
  Insert into Wageproperty (keywordId,WageId,WagePropertyused)
  Values('LeaveDeductAmt','BPJSPensiunWage','0')
end if;

if not exists(select * from Wageproperty where keywordId='BackPay' and WageId='BPJSPensiunWage') Then
  Insert into Wageproperty (keywordId,WageId,WagePropertyused)
  Values('BackPay','BPJSPensiunWage','0');
end if;

/* Default Policy */
If not exists(select SUBREGISTRYID from SubRegistry where RegistryId='PaySetupData' and SubRegistryId='BPJSPensProgPolicyId') Then 
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PaySetupData','BPJSPensProgPolicyId','Combo','BPJS Pensiun Policy','ShortStringAttr','Y','CPFPolicy','CPFPolicyId','Select * from CPFPolicy  ;','CPFPolicyId	20	Statutory Policy	F','CPFPolicyDesc	80	Description	F','',0,0,'',0,'BPJS-Pensiun2015Jul','','1899-12-30','1899-12-30 00:00:00');
End If;

/* Pay Record & Pay Period */
Update SubRegistry set IntegerAttr = 3 where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'IncomeTax';
Update SubRegistry set IntegerAttr = 3 where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'IncomeTax';

/* Pay Period */
if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'BPJSPensiun') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PayPeriodPolicy','BPJSPensiun','Local','','BPJS Pensiun','','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'BPJSPensiunWage') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PayPeriodPolicy','BPJSPensiunWage','Local','BPJSPensiun','BPJS Pensiun Wage','CurAdditionalWage','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'BPJSPensiunEECon') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PayPeriodPolicy','BPJSPensiunEECon','Local','BPJSPensiun','Employee Contribution','VolOrdEECPF','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'BPJSPensiunERCon') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PayPeriodPolicy','BPJSPensiunERCon','Local','BPJSPensiun','Employer Contribution','VolOrdERCPF','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

/* Pay Record */
if not exists(select * from SubRegistry where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'BPJSPensiun') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PayRecordPolicy','BPJSPensiun','Local','','BPJS Pensiun','','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'BPJSPensiunWage') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PayRecordPolicy','BPJSPensiunWage','Local','BPJSPensiun','BPJS Pensiun Wage','CurrEEVolWage','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'BPJSPensiunEECon') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PayRecordPolicy','BPJSPensiunEECon','Local','BPJSPensiun','Employee Contribution','CurrEEVolContri','','','','','','',0,1,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'BPJSPensiunERCon') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PayRecordPolicy','BPJSPensiunERCon','Local','BPJSPensiun','Employer Contribution','CurrERVolContri','','','','','','',0,2,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

/* Employee Other Info -> BPJS Pensiun No */
if not exists(select * from SubRegistry where RegistryId = 'EmpeeOtherInfo' and SubRegistryId = 'BPJSPensiunNo') then
     Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   Values('EmpeeOtherInfo','BPJSPensiunNo','BPJS Pensiun No','String','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');  
end if;

EmpeeOtherInfoLoop: for EmpeeOtherInfoForLoop as Cur_EmpeeOtherInfo dynamic scroll cursor for
     select EmployeeSysId as In_EmployeeSysId from employee do 
	    if not exists(select* from EmpeeOtherInfo where EmployeeSysId = In_EmployeeSysId and EmpeeOtherInfoId = 'BPJSPensiunNo') then
		    insert into EmpeeOtherInfo(EmployeeSysId,EmpeeOtherInfoId,EmpeeOtherInfoCaption,EmpeeOtherInfoType,EmpeeOtherInfoDate,EmpeeOtherInfoString,EmpeeOtherInfoBoolean,EmpeeOtherInfoDouble)
			values(In_EmployeeSysId,'BPJSPensiunNo','BPJS Pensiun No','String',NULL,'',0,0);
		end if;       	 
end for;

/* Keyword for BPJS Pensiun Progression Report */
if not exists(select * from Keyword Where KeyWordId = 'CR_IDPayBPJSPensProg') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
   Values('CR_IDPayBPJSPensProg','Pay','BPJS Pensiun Progression Report','CrystalRpt Cus Mgr',NULL,NULL,NULL,'BPJS Pensiun Progression Report',NULL,NULL,1,NULL)
end if;

/* ModuleScreenGroup */
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'PayIndoBPJSPensProg') then
  insert into ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
  values ('PayIndoBPJSPensProg','PayModules','BPJS Pensiun Progression','Pay',0,0,0,'')
end if;

if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'PayBPJSPensProgRpt') then
  insert into ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
  values ('PayBPJSPensProgRpt','PayEmpeeReports','BPJS Pensiun Progression Report','Pay',0,0,0,'')
end if;

if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'PayBPJSPensReports') then
  insert into ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
  values ('PayBPJSPensReports','PayReports','BPJS Pensiun Reports','Pay',0,1,0,'')
end if;

if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'PayBPJSPensRpt') then
  insert into ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
  values ('PayBPJSPensRpt','PayBPJSPensReports','BPJS Pensiun Report','Pay',0,1,0,'')
end if;

/* Import Designer -> YTD Policy */
if not exists(select * from ImportFieldName Where TableNamePhysical = 'iYTDIDPolicy' and FieldNamePhysical = 'EmployeeBPJSPensiun') then
   Insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   Values('iYTDIDPolicy','EmployeeBPJSPensiun','Employee BPJS Pensiun','Numeric',0);
end if;

if not exists(select * from ImportFieldName Where TableNamePhysical = 'iYTDIDPolicy' and FieldNamePhysical = 'EmployerBPJSPensiun') then
   Insert into ImportFieldName(TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
   Values('iYTDIDPolicy','EmployerBPJSPensiun','Employer BPJS Pensiun','Numeric',0);
end if;

/* Cost Item */
if not exists(select * from CostKeyword where CostKeywordId = 'EEBPJSPensiun') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,CostKeywordStr1,CostKeywordStr2)
  values('EEBPJSPensiun','Employee BPJS Pensiun','Employee BPJS Pensiun','SystemItemType',1,'','','','');
end if;

if not exists(select * from CostKeyword where CostKeywordId = 'ERBPJSPensiun') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,CostKeywordStr1,CostKeywordStr2)
  values('ERBPJSPensiun','Employer BPJS Pensiun','Employer BPJS Pensiun','SystemItemType',0,'','','','');
end if;

/* Pay Detail Export */
if not exists (select 1 from KeyWord where KeyWordId = 'EX_BPJSPensWage') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('EX_BPJSPensWage','BPJS Pensiun Wage','BPJS Pensiun Wage','EXPORT',0,0,0,'CurrEEVolWage',123,2,0,'')
end if;

if not exists (select 1 from KeyWord where KeyWordId = 'EX_BPJSPensWage_Prev') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('EX_BPJSPensWage_Prev','BPJS Pensiun Wage (Prev)','BPJS Pensiun Wage (Prev)','EXPORT',0,0,0,'CurrEEVolWage',123,8,0,'')
end if;

if not exists (select 1 from KeyWord where KeyWordId = 'EX_EEBPJSPens') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('EX_EEBPJSPens','Employee BPJS Pensiun','Employee BPJS Pensiun','EXPORT',0,0,0,'CurrEEVolContri',124,2,0,'')
end if;

if not exists (select 1 from KeyWord where KeyWordId = 'EX_EEBPJSPens_Prev') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('EX_EEBPJSPens_Prev','Employee BPJS Pensiun (Prev)','Employee BPJS Pensiun (Prev)','EXPORT',0,0,0,'CurrEEVolContri',124,8,0,'')
end if;

if not exists (select 1 from KeyWord where KeyWordId = 'EX_ERBPJSPens') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('EX_ERBPJSPens','Employer BPJS Pensiun','Employer BPJS Pensiun','EXPORT',0,0,0,'CurrERVolContri',125,2,0,'')
end if;

if not exists (select 1 from KeyWord where KeyWordId = 'EX_ERBPJSPens_Prev') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values ('EX_ERBPJSPens_Prev','Employer BPJS Pensiun (Prev)','Employer BPJS Pensiun (Prev)','EXPORT',0,0,0,'CurrERVolContri',125,8,0,'')
end if;

/* BPJSTK Submission */
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'PayBPJSTKSubRpt') then
  insert into ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
  values ('PayBPJSTKSubRpt','PayCPFSubmissRpts','BPJSTK Submission','Pay',0,0,0,'')
end if;

if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'PayBPJSTKDBSubRpt') then
  insert into ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
  values ('PayBPJSTKDBSubRpt','PayCPFSubmissRpts','BPJSTK DB Submission','Pay',0,0,0,'')
end if;

Commit Work;