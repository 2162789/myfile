Read UpgradeDB\Ver1070302\MY_EISYr2018Jan.sql;
Read UpgradeDB\Ver1070302\MY_AnlysDispSection.sql;

/* Keyword */
/* Policy Scheme */
if not exists(select * from KeyWord where KeyWordId = 'EIS') then
  insert into KeyWord(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, 
                      KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values('EIS','EIS','EIS','EISScheme',0,0,0,'',0,0,0,'');
end if;

/* Wage formula */
if not exists(select * from KeyWord where KeyWordId = 'EISWage') then
  insert into KeyWord(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, 
                      KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values('EISWage','EIS Wage','EIS Wage','System',0,1,1,'',0,0,30,'');
end if;

/* Property */
if not exists(select * from KeyWord where KeyWordId = 'SubjEIS') then
  insert into KeyWord(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, 
                      KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values('SubjEIS','Subject to EIS','Subject to EIS','System',1,0,0,'Only available if not Donation Code',0,0,30,'N');
end if;

/* Pay Detail Export */
if not exists(select * from KeyWord where KeyWordId = 'EX_EIS_WAGE') then
  insert into KeyWord(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, 
                      KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values('EX_EIS_WAGE','EIS Wage','EIS Wage','EXPORT',0,0,0,'CurAdditionalWage',313,2,0,'');
end if;

if not exists(select * from KeyWord where KeyWordId = 'EX_EE_EIS_CON') then
  insert into KeyWord(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, 
                      KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values('EX_EE_EIS_CON','EE EIS Contri','EE EIS Contri','EXPORT',0,0,0,'ContriAddEECPF',314,2,0,'');
end if;

if not exists(select * from KeyWord where KeyWordId = 'EX_ER_EIS_CON') then
  insert into KeyWord(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, 
                      KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values('EX_ER_EIS_CON','ER EIS Contri','ER EIS Contri','EXPORT',0,0,0,'ContriAddERCPF',315,2,0,'');
end if;

if not exists(select * from KeyWord where KeyWordId = 'EX_EIS_WAGE_Prev') then
  insert into KeyWord(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, 
                      KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values('EX_EIS_WAGE_Prev','EIS Wage (Prev)','EIS Wage (Prev)','EXPORT',0,0,0,'CurAdditionalWage',316,8,0,'');
end if;

if not exists(select * from KeyWord where KeyWordId = 'EX_EE_EIS_CON_Prev') then
  insert into KeyWord(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, 
                      KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values('EX_EE_EIS_CON_Prev','EE EIS Contri (Prev)','EE EIS Contri (Prev)','EXPORT',0,0,0,'ContriAddEECPF',317,8,0,'');
end if;

if not exists(select * from KeyWord where KeyWordId = 'EX_ER_EIS_CON_Prev') then
  insert into KeyWord(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, 
                      KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values('EX_ER_EIS_CON_Prev','ER EIS Contri (Prev)','ER EIS Contri (Prev)','EXPORT',0,0,0,'ContriAddERCPF',318,8,0,'');
end if;

/* EIS Progression Crystal Report */
if not exists(select * from KeyWord where KeyWordId = 'CR_MYPayEISProg') then
  insert into KeyWord(KeyWordId, KeyWordDefaultName, KeyWordUserDefinedName, KeyWordCategory, KeyWordPropertySelection, KeyWordFormulaSelection, 
                      KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup)
  values('CR_MYPayEISProg','Pay','EIS Progression Report','CrystalRpt Cus Mgr',NULL,NULL,NULL,'EIS Progression Report',NULL,NULL,1,NULL);
end if;

/* WageProperty */
if not exists(select * from WageProperty where KeyWordId = 'SubjEIS' and WageId = 'EISWage') then
  insert into WageProperty(KeyWordId,WageId,WagePropertyUsed)
  values('SubjEIS','EISWage',1);
end if;

if not exists(select * from WageProperty where KeyWordId = 'TotalWage' and WageId = 'EISWage') then
  insert into WageProperty(KeyWordId,WageId,WagePropertyUsed)
  values('TotalWage','EISWage',1);
end if;

if not exists(select * from WageProperty where KeyWordId = 'LeaveDeductAmt' and WageId = 'EISWage') then
  insert into WageProperty(KeyWordId,WageId,WagePropertyUsed)
  values('LeaveDeductAmt','EISWage',1);
end if;

if not exists(select * from WageProperty where KeyWordId = 'BackPay' and WageId = 'EISWage') then
  insert into WageProperty(KeyWordId,WageId,WagePropertyUsed)
  values('BackPay','EISWage',1);
end if;

/* SubRegistry */
/* Pay Record */
if not exists(select * from SubRegistry where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'EIS') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('PayRecordPolicy','EIS','Local','','EIS','','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'EISWage') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('PayRecordPolicy','EISWage','Local','EIS','EIS Wage','CurAdditionalWage','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'EEEIS') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('PayRecordPolicy','EEEIS','Local','EIS','Employee EIS','ContriAddEECPF','','','','','','',0,1,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'EREIS') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('PayRecordPolicy','EREIS','Local','EIS','Employer EIS','ContriAddERCPF','','','','','','',0,2,'',0,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

Update SubRegistry Set IntegerAttr = 3 Where RegistryId = 'PayRecordPolicy' and SubRegistryId = 'IncomeTax';

/* Pay Period */
if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'EIS') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('PayPeriodPolicy','EIS','Local','','EIS','','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'EISWage') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('PayPeriodPolicy','EISWage','Local','EIS','EIS Wage','CurAdditionalWage','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'EEEIS') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('PayPeriodPolicy','EEEIS','Local','EIS','Employee EIS','ContriAddEECPF','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

if not exists(select * from SubRegistry where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'EREIS') then
  insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                          RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  values('PayPeriodPolicy','EREIS','Local','EIS','Employer EIS','ContriAddERCPF','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00.000');
end if;

Update SubRegistry Set IntegerAttr = 3 Where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'IncomeTax';
Update SubRegistry Set IntegerAttr = 4 Where RegistryId = 'PayPeriodPolicy' and SubRegistryId = 'HRDF';

/* ModuleScreenGroup */
IF not exists(select * from ModuleScreenGroup where ModuleScreenId = 'PayEISProg') Then
   Insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId) 
   Values ('PayEISProg','PayModules','EIS Progression','Pay',0,0,0,'');
End if;

IF not exists(select * from ModuleScreenGroup where ModuleScreenId = 'PayEISProgRpt') Then
   Insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId) 
   Values ('PayEISProgRpt','PayEmpeeReports','EIS Progression Report','Pay',0,0,0,'');
End if;

/* CostKeyWord */
If not exists(select * from CostKeyword where CostKeywordId = 'EEEIS') then
    Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,
	                        CostKeywordRef,CostKeywordTableId,CostKeywordStr1,CostKeywordStr2)
	values('EEEIS','Employee EIS Contribution','Employee EIS Contribution','SystemItemType',1,'','','','');
end if;

If not exists(select * from CostKeyword where CostKeywordId = 'EREIS') then
    Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,
	                        CostKeywordRef,CostKeywordTableId,CostKeywordStr1,CostKeywordStr2)
	values('EREIS','Employer EIS Contribution','Employer EIS Contribution','SystemItemType',0,'','','','');
end if;

commit work;