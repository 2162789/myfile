Read UpgradeDB\Ver1061001\ID_StoredProc.sql;
Read UpgradeDB\Ver1061001\ID_BPJSKes2014Jan.sql;
Read UpgradeDB\Ver1061001\ID_AnlysitItem.sql;

/* Default Statutory Scheme */
Update KeyWord set KeyWordDefaultName = 'Jamsostek', KeyWordUserDefinedName = 'Jamsostek' Where KeyWordId = 'Standard';
if not exists(select * from KeyWord where KeyWordId = 'BPJSKesehatan') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('BPJSKesehatan','BPJS Kesehatan','BPJS Kesehatan','CPFScheme',0,0,0,'',0,0,0,'');
end if;

/* Default Policy and Scheme*/
If not exists(select SUBREGISTRYID from SubRegistry where RegistryId='PaySetupData' and SubRegistryId='BPJSKSProgPolicyId') Then 
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PaySetupData','BPJSKSProgPolicyId','Combo','BPJS Kesehatan Policy','ShortStringAttr','Y','CPFPolicy','CPFPolicyId','Select * from CPFPolicy  ;','CPFPolicyId	20	Statutory Policy	F','CPFPolicyDesc	80	Description	F','',0,0,'',0,'BPJS-KS2014Jan','','1899-12-30','1899-12-30 00:00:00');
End If;

If not exists(select SUBREGISTRYID from SubRegistry where RegistryId='PaySetupData' and SubRegistryId='BPJSKSProgSchemeId') Then 
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('PaySetupData','BPJSKSProgSchemeId','Combo','BPJS Kesehatan Scheme','ShortStringAttr','Y','KeyWord','KeyWordId','Select * from KeyWord where KeyWordCategory=''CPFScheme'' and KeywordId like ''BPJS%'';','KeyWordId	20	Statutory Scheme	F','KeyWordUserDefinedName	80	Description	F','',0,0,'',0,'BPJSKesehatan','','1899-12-30','1899-12-30 00:00:00');
End If;

Update SubRegistry set  RegProperty7='Select * from KeyWord where KeyWordCategory=''CPFScheme'' and KeywordId not like ''BPJS%'';',Regproperty8='KeyWordId	20	Statutory Scheme	F'  where RegistryId='PaySetupData' and SubRegistryId='CPFProgSchemeId';
Update SubRegistry set  Regproperty8='CPFPolicyId	20	Statutory Policy	F'  where RegistryId='PaySetupData' and SubRegistryId='CPFProgPolicyId' ;

/* BPJS Kesehatan Wage */
If Not exists(select * from keyword where KeyWordId='SubjBPJSKS') Then
  insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup) 
  Values('SubjBPJSKS','Subject to BPJS Kesehatan','Subject to BPJS Kesehatan','System',1,0,0,'Only available if not Donation Code',0,0,30,'N');
end if;

if not exists(select * from Keyword where KeyWordId='BPJSKesehatanWage') Then
  insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('BPJSKesehatanWage','BPJS Kesehatan Wage','BPJS Kesehatan Wage','System',0,1,1,'',0,0,0,'');
End If;

if not exists(select * from Wageproperty where keywordId='SubjBPJSKS' and WageId='BPJSKesehatanWage') Then
  Insert into Wageproperty (keywordId,WageId,WagePropertyused)
  Values('SubjBPJSKS','BPJSKesehatanWage','1');
end if;

if not exists(select * from Wageproperty where keywordId='TotalWage' and WageId='BPJSKesehatanWage') Then
  Insert into Wageproperty (keywordId,WageId,WagePropertyused)
  Values('TotalWage','BPJSKesehatanWage','1');
end if;

if not exists(select * from Wageproperty where keywordId='LeaveDeductAmt' and WageId='BPJSKesehatanWage') Then
  Insert into Wageproperty (keywordId,WageId,WagePropertyused)
  Values('LeaveDeductAmt','BPJSKesehatanWage','0')
end if;

if not exists(select * from Wageproperty where keywordId='BackPay' and WageId='BPJSKesehatanWage') Then
  Insert into Wageproperty (keywordId,WageId,WagePropertyused)
  Values('BackPay','BPJSKesehatanWage','0');
end if;

/* Keyword for BPJS KS Marital Status & Current Status */
if not exists(select * from KeyWord where KeyWordId = 'BPJSKSMarS') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('BPJSKSMarS','S (Single)','S (Single)','BPJSKSMarStatus',0,0,0,'S',0,0,0,'');
end if;

if not exists(select * from KeyWord where KeyWordId = 'BPJSKSMarK0') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('BPJSKSMarK0','K+0 (Married + 0 child)','K+0 (Married + 0 child)','BPJSKSMarStatus',0,0,0,'K+0',0,0,1,'');
end if;

if not exists(select * from KeyWord where KeyWordId = 'BPJSKSMarK1') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('BPJSKSMarK1','K+1 (Married + 1 child)','K+1 (Married + 1 child)','BPJSKSMarStatus',0,0,0,'K+1',0,0,2,'');
end if;

if not exists(select * from KeyWord where KeyWordId = 'BPJSKSMarK2') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('BPJSKSMarK2','K+2 (Married + 2 child)','K+2 (Married + 2 child)','BPJSKSMarStatus',0,0,0,'K+2',0,0,3,'');
end if;

if not exists(select * from KeyWord where KeyWordId = 'BPJSKSMarK3') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('BPJSKSMarK3','K+3 (Married + 3 child)','K+3 (Married + 3 child)','BPJSKSMarStatus',0,0,0,'K+3',0,0,4,'');
end if;

if not exists(select * from KeyWord where KeyWordId = 'BPJSKSCessation') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('BPJSKSCessation','Cessation','Cessation','BPJSKSStatus',0,0,0,'',0,0,0,'');
end if;

if not exists(select * from KeyWord where KeyWordId = 'BPJSKSExisting') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('BPJSKSExisting','Existing','Existing','BPJSKSStatus',0,0,0,'',0,0,0,'');
end if;

if not exists(select * from KeyWord where KeyWordId = 'BPJSKSJoinLeave') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('BPJSKSJoinLeave','Join & Leave','Join & Leave','BPJSKSStatus',0,0,0,'',0,0,0,'');
end if;

if not exists(select * from KeyWord where KeyWordId = 'BPJSKSNewJoin') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('BPJSKSNewJoin','New Join','New Join','BPJSKSStatus',0,0,0,'',0,0,0,'');
end if;

if not exists(select * from KeyWord where KeyWordId = 'BPJSKSNone') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                     KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('BPJSKSNone','None','None','BPJSKSStatus',0,0,0,'',0,0,0,'');
end if;

/* Pay Period */
Update SubRegistry set RegProperty3 = 'Jamsostek' where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'ERContri';
Update SubRegistry set IntegerAttr = 2 where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'IncomeTax';
Update SubRegistry set IntegerAttr = 2 where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'IncomeTax';

if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'BPJSKesehatan') then
     Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   Values('PayPeriodPolicy','BPJSKesehatan','Local','','BPJS Kesehatan','','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'BPJSKesehatanStatus') then
     Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   Values('PayPeriodPolicy','BPJSKesehatanStatus','Local','BPJSKesehatan','BPJS Kesehatan Status','TaxCategory','','','SELECT KeywordId, KeywordUserDefinedName FROM Keyword WHERE KeywordCategory = ''BPJSKSStatus'' ORDER BY KeywordUserDefinedName','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'BPJSKesehatanMStatus') then
     Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   Values('PayPeriodPolicy','BPJSKesehatanMStatus','Local','BPJSKesehatan','BPJS Kesehatan Marital Status','TaxMaritalStatus','','','SELECT KeywordId, KeywordUserDefinedName FROM Keyword WHERE KeywordCategory = ''BPJSKSMarStatus'' ORDER BY KeyWordStage','','','',0,1,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'BPJSKesehatanWage') then
     Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   Values('PayPeriodPolicy','BPJSKesehatanWage','Local','BPJSKesehatan','BPJS Kesehatan Wage','CurOrdinaryWage','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'BPJSKesehatanEECon') then
     Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   Values('PayPeriodPolicy','BPJSKesehatanEECon','Local','BPJSKesehatan','Employee Contribution','ActualOrdEECPF','','','','','','',0,3,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'BPJSKesehatanERCon') then
     Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   Values('PayPeriodPolicy','BPJSKesehatanERCon','Local','BPJSKesehatan','Employer Contribution','ActualOrdERCPF','','','','','','',0,4,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

/* Pay Record */
if not exists(select * from SubRegistry where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'BPJSKesehatan') then
     Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   Values('PayRecordPolicy','BPJSKesehatan','Local','','BPJS Kesehatan','','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'BPJSKesehatanWage') then
     Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   Values('PayRecordPolicy','BPJSKesehatanWage','Local','BPJSKesehatan','BPJS Kesehatan Wage','CurrEEManWage','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'BPJSKesehatanEECon') then
     Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   Values('PayRecordPolicy','BPJSKesehatanEECon','Local','BPJSKesehatan','Employee Contribution','CurrEEManContri','','','','','','',0,1,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'BPJSKesehatanERCon') then
     Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   Values('PayRecordPolicy','BPJSKesehatanERCon','Local','BPJSKesehatan','Employer Contribution','CurrERManContri','','','','','','',0,2,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

/* Employee Other Info */
if not exists(select * from SubRegistry where RegistryId = 'EmpeeOtherInfo' and SubRegistryId = 'JPKNo') then
     Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   Values('EmpeeOtherInfo','JPKNo','JPK No','String','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

EmpeeOtherInfoLoop: for EmpeeOtherInfoForLoop as Cur_EmpeeOtherInfo dynamic scroll cursor for
     select EmployeeSysId as In_EmployeeSysId from employee do 
	    if not exists(select* from EmpeeOtherInfo where EmployeeSysId = In_EmployeeSysId and EmpeeOtherInfoId = 'JPKNo') then
		    insert into EmpeeOtherInfo(EmployeeSysId,EmpeeOtherInfoId,EmpeeOtherInfoCaption,EmpeeOtherInfoType,EmpeeOtherInfoDate,EmpeeOtherInfoString,EmpeeOtherInfoBoolean,EmpeeOtherInfoDouble)
			values(In_EmployeeSysId,'JPKNo','JPK No','String',NULL,'',0,0);
		end if;       	 
end for;

/* Module Screen Group*/

if not exists (select ModuleScreenID from ModuleScreenGroup where ModuleScreenId='PayManContriProg') Then
  Insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  Values('PayManContriProg','PayModules','BPJS Kesehatan Progression','Pay',0,0,0,'');
end if;

if not exists (select ModuleScreenID from ModuleScreenGroup where ModuleScreenId='PayBPJSKSReports') Then
  Insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  Values('PayBPJSKSReports','PayReports','BPJS Kesehatan Reports','Pay',0,0,0,'');
end if;

if not exists (select ModuleScreenID from ModuleScreenGroup where ModuleScreenId='PayBPJSKSListRpt') Then
  Insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  Values('PayBPJSKSListRpt','PayBPJSKSReports','BPJS Kesehatan Reports','Pay',0,0,0,'');
end if;

/* Sub Registry */
if not exists(select * from Registry where RegistryId = 'IndoBPJSKesRpt') then
   Insert into Registry(RegistryId,RegistryDesc)
   values('IndoBPJSKesRpt','Indonesia BPJS Kesehatan Report');
end if;

If not exists(select SUBREGISTRYID from SubRegistry where RegistryId='IndoBPJSKesRpt' and SubRegistryId='IndoBPJSKesRptInfo') Then 
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('IndoBPJSKesRpt','IndoBPJSKesRptInfo','','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
End If;

commit work;