/* KeyWord */
if not exists(select * from Keyword Where KeyWordId = 'TsTKWage') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsTKWage','BPJSTK Wage','BPJSTK Wage','Ts Distribute',0,0,0,'',0,0,2,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsTKEEOldAge') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsTKEEOldAge','Employee Old Age','Employee Old Age','Ts Distribute',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsTkEROldAge') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsTkEROldAge','Employer Old Age','Employer Old Age','Ts Distribute',0,0,0,'',0,0,1,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsTKERAccident') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsTKERAccident','Employer Accident','Employer Accident','Ts Distribute',0,0,0,'',0,0,1,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsTKERDeath') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsTKERDeath','Employer Death','Employer Death','Ts Distribute',0,0,0,'',0,0,1,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsKesWage') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsKesWage','BPJS Kesehatan Wage','BPJS Kesehatan Wage','Ts Distribute',0,0,0,'',0,0,2,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsKesEEContri') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsKesEEContri','Employee BPJS Kesehatan','Employee BPJS Kesehatan','Ts Distribute',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsKesERContri') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsKesERContri','Employer BPJS Kesehatan','Employer BPJS Kesehatan','Ts Distribute',0,0,0,'',0,0,1,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsPensWage') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsPensWage','BPJS Pensiun Wage','BPJS Pensiun Wage','Ts Distribute',0,0,0,'',0,0,2,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsPensEEContri') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsPensEEContri','Employee BPJS Pensiun','Employee BPJS Pensiun','Ts Distribute',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsPensERContri') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsPensERContri','Employer BPJS Pensiun','Employer BPJS Pensiun','Ts Distribute',0,0,0,'',0,0,1,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsTaxGross') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsTaxGross','Tax Gross Salary','Tax Gross Salary','Ts Distribute',0,0,0,'',0,0,2,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsEETaxAmount') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsEETaxAmount','Employee Tax Amount','Employee Tax Amount','Ts Distribute',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsERTaxAmount') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsERTaxAmount','Employer Tax Amount','Employer Tax Amount','Ts Distribute',0,0,0,'',0,0,1,'')
end if;

/* Cost KeyWord */
if not exists(select * from CostKeyword Where CostKeywordId = 'TsTKEEOldAge') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsTKEEOldAge','Time Sheet Employee Old Age','Time Sheet Employee Old Age','TsSystemItemType',1,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsTkEROldAge') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsTkEROldAge','Time Sheet Employer Old Age','Time Sheet Employer Old Age','TsSystemItemType',0,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsTKERAccident') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsTKERAccident','Time Sheet Employer Accident','Time Sheet Employer Accident','TsSystemItemType',0,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsTKERDeath') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsTKERDeath','Time Sheet Employer Death','Time Sheet Employer Death','TsSystemItemType',0,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsKesEEContri') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsKesEEContri','Time Sheet Employee BPJS Kesehatan','Time Sheet Employee BPJS Kesehatan','TsSystemItemType',1,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsKesERContri') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsKesERContri','Time Sheet Employer BPJS Kesehatan','Time Sheet Employer BPJS Kesehatan','TsSystemItemType',0,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsPensEEContri') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsPensEEContri','Time Sheet Employee BPJS Pensiun','Time Sheet Employee BPJS Pensiun','TsSystemItemType',1,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsPensERContri') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsPensERContri','Time Sheet Employer BPJS Pensiun','Time Sheet Employer BPJS Pensiun','TsSystemItemType',0,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsEETaxAmount') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsEETaxAmount','Time Sheet Employee Tax Amount','Time Sheet Employee Tax Amount','TsSystemItemType',1,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsERTaxAmount') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsERTaxAmount','Time Sheet Employer Tax Amount','Time Sheet Employer Tax Amount','TsSystemItemType',0,'','','','')
end if;

/* Export Designer -  SystemAttribute */
if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsTKWage') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsTKWage','BPJSTK Wage',1,'','','','','');
end if;  

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsTKEEOldAge') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsTKEEOldAge','Employee Old Age',1,'','','','','');
end if;   

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsTkEROldAge') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsTkEROldAge','Employer Old Age',1,'','','','','');
end if; 

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsTKERAccident') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsTKERAccident','Employer Accident',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsTKERDeath') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsTKERDeath','Employer Death',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsKesWage') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsKesWage','BPJS Kesehatan Wage',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsKesEEContri') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsKesEEContri','Employee BPJS Kesehatan',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsKesERContri') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsKesERContri','Employer BPJS Kesehatan',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsPensWage') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsPensWage','BPJS Pensiun Wage',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsPensEEContri') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsPensEEContri','Employee BPJS Pensiun',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsPensERContri') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsPensERContri','Employer BPJS Pensiun',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsTaxGross') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsTaxGross','Tax Gross Salary',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsEETaxAmount') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsEETaxAmount','Employee Tax Amount',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsERTaxAmount') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsERTaxAmount','Employer Tax Amount',1,'','','','','');
end if;

/* Export Designer -  AnItemLookup */
if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsTKWage') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsTKWage','TMSDistribute','Ana_TsTKWage','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsTKWage''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsTKEEOldAge') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsTKEEOldAge','TMSDistribute','Ana_TsTKEEOldAge','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsTKEEOldAge''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsTkEROldAge') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsTkEROldAge','TMSDistribute','Ana_TsTkEROldAge','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsTkEROldAge''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsTKERAccident') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsTKERAccident','TMSDistribute','Ana_TsTKERAccident','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsTKERAccident''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsTKERDeath') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsTKERDeath','TMSDistribute','Ana_TsTKERDeath','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsTKERDeath''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsKesWage') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsKesWage','TMSDistribute','Ana_TsKesWage','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsKesWage''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsKesEEContri') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsKesEEContri','TMSDistribute','Ana_TsKesEEContri','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsKesEEContri''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsKesERContri') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsKesERContri','TMSDistribute','Ana_TsKesERContri','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsKesERContri''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsPensWage') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsPensWage','TMSDistribute','Ana_TsPensWage','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsPensWage''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsPensEEContri') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsPensEEContri','TMSDistribute','Ana_TsPensEEContri','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsPensEEContri''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsPensERContri') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsPensERContri','TMSDistribute','Ana_TsPensERContri','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsPensERContri''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsTaxGross') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsTaxGross','TMSDistribute','Ana_TsTaxGross','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsTaxGross''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsEETaxAmount') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsEETaxAmount','TMSDistribute','Ana_TsEETaxAmount','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsEETaxAmount''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsERTaxAmount') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsERTaxAmount','TMSDistribute','Ana_TsERTaxAmount','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsERTaxAmount''','','');
end if;

/* Sub Registry */
if not exists(select * from Registry where RegistryId = 'SageProdIntegrate') then
   Insert into Registry (RegistryId,SubRegistryId)
   Values('SageProdIntegrate','Sage Product Integration');
end if;

if not exists(select * from SubRegistry where RegistryId = 'SageProdIntegrate' and SubRegistryId = 'TMSViewIDTimeSheet') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('SageProdIntegrate','TMSViewIDTimeSheet','View_Acc_ID_TimeSheet','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

commit work;