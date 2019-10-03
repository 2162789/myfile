/* KeyWord */
if not exists(select * from Keyword Where KeyWordId = 'TsCurEEManEPFWage') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsCurEEManEPFWage','Current Employee Mandatory EPF Wage','Current Employee Mandatory EPF Wage','Ts Distribute',0,0,0,'',0,0,2,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsEECurManEPF') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsEECurManEPF','Employee Current Mandatory EPF Contribution','Employee Current Mandatory EPF Contribution','Ts Distribute',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsCurERManEPFWage') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsCurERManEPFWage','Current Employer Mandatory EPF Wage','Current Employer Mandatory EPF Wage','Ts Distribute',0,0,0,'',0,0,3,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsERCurManEPF') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsERCurManEPF','Employer Current Mandatory EPF Contribution','Employer Current Mandatory EPF Contribution','Ts Distribute',0,0,0,'',0,0,1,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsPreEEManEPFWage') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsPreEEManEPFWage','Previous Employee Mandatory EPF Wage','Previous Employee Mandatory EPF Wage','Ts Distribute',0,0,0,'',0,0,2,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsEEPreManEPF') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsEEPreManEPF','Employee Previous Mandatory EPF Contribution','Employee Previous Mandatory EPF Contribution','Ts Distribute',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsPreERManEPFWage') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsPreERManEPFWage','Previous Employer Mandatory EPF Wage','Previous Employer Mandatory EPF Wage','Ts Distribute',0,0,0,'',0,0,3,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsERPreManEPF') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsERPreManEPF','Employer Previous Mandatory EPF Contribution','Employer Previous Mandatory EPF Contribution','Ts Distribute',0,0,0,'',0,0,1,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsCurEEVolEPFWage') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsCurEEVolEPFWage','Current Employee Voluntary EPF Wage','Current Employee Voluntary EPF Wage','Ts Distribute',0,0,0,'',0,0,2,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsEECurVolEPF') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsEECurVolEPF','Employee Current Voluntary EPF Contribution','Employee Current Voluntary EPF Contribution','Ts Distribute',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsCurERVolEPFWage') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsCurERVolEPFWage','Current Employer Voluntary EPF Wage','Current Employer Voluntary EPF Wage','Ts Distribute',0,0,0,'',0,0,3,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsERCurVolEPF') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsERCurVolEPF','Employer Current Voluntary EPF Contribution','Employer Current Voluntary EPF Contribution','Ts Distribute',0,0,0,'',0,0,1,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsPreEEVolEPFWage') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsPreEEVolEPFWage','Previous Employee Voluntary EPF Wage','Previous Employee Voluntary EPF Wage','Ts Distribute',0,0,0,'',0,0,2,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsEEPreVolEPF') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsEEPreVolEPF','Employee Previous Voluntary EPF Contribution','Employee Previous Voluntary EPF Contribution','Ts Distribute',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsPreERVolEPFWage') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsPreERVolEPFWage','Previous Employer Voluntary EPF Wage','Previous Employer Voluntary EPF Wage','Ts Distribute',0,0,0,'',0,0,3,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsERPreVolEPF') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsERPreVolEPF','Employer Previous Voluntary EPF Contribution','Employer Previous Voluntary EPF Contribution','Ts Distribute',0,0,0,'',0,0,1,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsSOCSOWage') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsSOCSOWage','SOCSO Wage','SOCSO Wage','Ts Distribute',0,0,0,'',0,0,2,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsEESOCSO') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsEESOCSO','Employee SOCSO Contribution','Employee SOCSO Contribution','Ts Distribute',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsERSOCSO') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsERSOCSO','Employer SOCSO Contribution','Employer SOCSO Contribution','Ts Distribute',0,0,0,'',0,0,1,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsHRDLevy') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsHRDLevy','HRD Levy','HRD Levy','Ts Distribute',0,0,0,'',0,0,1,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsPaidPreTaxAmt') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsPaidPreTaxAmt','Paid Previous Tax Amount','Paid Previous Tax Amount','Ts Distribute',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsPaidCurTaxAmt') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsPaidCurTaxAmt','Paid Current Tax Amount','Paid Current Tax Amount','Ts Distribute',0,0,0,'',0,0,0,'')
end if;

if not exists(select * from Keyword Where KeyWordId = 'TsTaxBenefit') then
  Insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                         KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  Values('TsTaxBenefit','Tax Benefit','Tax Benefit','Ts Distribute',0,0,0,'',0,0,1,'')
end if;

/* Cost KeyWord */
if not exists(select * from CostKeyword Where CostKeywordId = 'TsEECurManEPF') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsEECurManEPF','Time Sheet Employee Current Mandatory EPF Contribution','Time Sheet Employee Current Mandatory EPF Contribution','TsSystemItemType',1,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsERCurManEPF') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsERCurManEPF','Time Sheet Employer Current Mandatory EPF Contribution','Time Sheet Employer Current Mandatory EPF Contribution','TsSystemItemType',0,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsEEPreManEPF') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsEEPreManEPF','Time Sheet Employee Previous Mandatory EPF Contribution','Time Sheet Employee Previous Mandatory EPF Contribution','TsSystemItemType',1,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsERPreManEPF') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsERPreManEPF','Time Sheet Employer Previous Mandatory EPF Contribution','Time Sheet Employer Previous Mandatory EPF Contribution','TsSystemItemType',0,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsEECurVolEPF') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsEECurVolEPF','Time Sheet Employee Current Voluntary EPF Contribution','Time Sheet Employee Current Voluntary EPF Contribution','TsSystemItemType',1,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsERCurVolEPF') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsERCurVolEPF','Time Sheet Employer Current Voluntary EPF Contribution','Time Sheet Employer Current Voluntary EPF Contribution','TsSystemItemType',0,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsEEPreVolEPF') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsEEPreVolEPF','Time Sheet Employee Previous Voluntary EPF Contribution','Time Sheet Employee Previous Voluntary EPF Contribution','TsSystemItemType',1,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsERPreVolEPF') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsERPreVolEPF','Time Sheet Employer Previous Voluntary EPF Contribution','Time Sheet Employer Previous Voluntary EPF Contribution','TsSystemItemType',0,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsEESOCSO') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsEESOCSO','Time Sheet Employee SOCSO Contribution','Time Sheet Employee SOCSO Contribution','TsSystemItemType',1,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsERSOCSO') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsERSOCSO','Time Sheet Employer SOCSO Contribution','Time Sheet Employer SOCSO Contribution','TsSystemItemType',0,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsHRDLevy') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsHRDLevy','Time Sheet HRD Levy','Time Sheet HRD Levy','TsSystemItemType',0,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsPaidPreTaxAmt') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsPaidPreTaxAmt','Time Sheet Paid Previous Tax Amount','Time Sheet Paid Previous Tax Amount','TsSystemItemType',1,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsPaidCurTaxAmt') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsPaidCurTaxAmt','Time Sheet Paid Current Tax Amount','Time Sheet Paid Current Tax Amount','TsSystemItemType',1,'','','','')
end if;

if not exists(select * from CostKeyword Where CostKeywordId = 'TsTaxBenefit') then
  Insert into CostKeyword(CostKeywordId,CostKeywordUserDefinedName,CostKeywordDesc,CostCategory,IsCreditItem,CostKeywordRef,CostKeywordTableId,
                         CostKeywordStr1,CostKeywordStr2)
  Values('TsTaxBenefit','Time Sheet Tax Benefit','Time Sheet Tax Benefit','TsSystemItemType',0,'','','','')
end if;

/* Export Designer -  SystemAttribute */
if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsCurEEManEPFWage') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsCurEEManEPFWage','Current Employee Mandatory EPF Wage',1,'','','','','');
end if;  

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsEECurManEPF') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsEECurManEPF','Employee Current Mandatory EPF Contribution',1,'','','','','');
end if;   

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsCurERManEPFWage') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsCurERManEPFWage','Current Employer Mandatory EPF Wage',1,'','','','','');
end if; 

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsERCurManEPF') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsERCurManEPF','Employer Current Mandatory EPF Contribution',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsPreEEManEPFWage') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsPreEEManEPFWage','Previous Employee Mandatory EPF Wage',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsEEPreManEPF') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsEEPreManEPF','Employee Previous Mandatory EPF Contribution',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsPreERManEPFWage') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsPreERManEPFWage','Previous Employer Mandatory EPF WageEmployee BPJS Kesehatan',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsERPreManEPF') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsERPreManEPF','Employer Previous Mandatory EPF Contribution',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsCurEEVolEPFWage') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsCurEEVolEPFWage','Current Employee Voluntary EPF Wage',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsEECurVolEPF') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsEECurVolEPF','Employee Current Voluntary EPF Contribution',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsCurERVolEPFWage') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsCurERVolEPFWage','Current Employer Voluntary EPF Wage',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsERCurVolEPF') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsERCurVolEPF','Employer Current Voluntary EPF Contribution',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsPreEEVolEPFWage') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsPreEEVolEPFWage','Previous Employee Voluntary EPF Wage',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsEEPreVolEPF') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsEEPreVolEPF','Employee Previous Voluntary EPF Contribution',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsPreERVolEPFWage') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsPreERVolEPFWage','Previous Employer Voluntary EPF Wage',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsERPreVolEPF') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsERPreVolEPF','Employer Previous Voluntary EPF Contribution',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsSOCSOWage') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsSOCSOWage','SOCSO Wage',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsEESOCSO') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsEESOCSO','Employee SOCSO Contribution',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsERSOCSO') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsERSOCSO','Employer SOCSO Contribution',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsHRDLevy') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsHRDLevy','HRD Levy',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsPaidPreTaxAmt') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsPaidPreTaxAmt','Paid Previous Tax Amount',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsPaidCurTaxAmt') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsPaidCurTaxAmt','Paid Current Tax Amount',1,'','','','','');
end if;

if not exists(select * from SystemAttribute Where SysTableId = 'TMSDistribute' and SysAttributeId = 'Ana_TsTaxBenefit') then
   Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,
                               SysParameter4,SysParameter5)
   Values('TMSDistribute','Ana_TsTaxBenefit','Tax Benefit',1,'','','','','');
end if;


/* Export Designer -  AnItemLookup */
if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsCurEEManEPFWage') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsCurEEManEPFWage','TMSDistribute','Ana_TsCurEEManEPFWage','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsCurEEManEPFWage''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsEECurManEPF') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsEECurManEPF','TMSDistribute','Ana_TsEECurManEPF','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsEECurManEPF''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsCurERManEPFWage') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsCurERManEPFWage','TMSDistribute','Ana_TsCurERManEPFWage','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsCurERManEPFWage''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsERCurManEPF') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsERCurManEPF','TMSDistribute','Ana_TsERCurManEPF','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsERCurManEPF''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsPreEEManEPFWage') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsPreEEManEPFWage','TMSDistribute','Ana_TsPreEEManEPFWage','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsPreEEManEPFWage''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsEEPreManEPF') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsEEPreManEPF','TMSDistribute','Ana_TsEEPreManEPF','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsEEPreManEPF''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsPreERManEPFWage') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsPreERManEPFWage','TMSDistribute','Ana_TsPreERManEPFWage','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsPreERManEPFWage''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsERPreManEPF') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsERPreManEPF','TMSDistribute','Ana_TsERPreManEPF','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsERPreManEPF''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsCurEEVolEPFWage') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsCurEEVolEPFWage','TMSDistribute','Ana_TsCurEEVolEPFWage','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsCurEEVolEPFWage''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsEECurVolEPF') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsEECurVolEPF','TMSDistribute','Ana_TsEECurVolEPF','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsEECurVolEPF''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsCurERVolEPFWage') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsCurERVolEPFWage','TMSDistribute','Ana_TsCurERVolEPFWage','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsCurERVolEPFWage''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsERCurVolEPF') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsERCurVolEPF','TMSDistribute','Ana_TsERCurVolEPF','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsERCurVolEPF''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsPreEEVolEPFWage') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsPreEEVolEPFWage','TMSDistribute','Ana_TsPreEEVolEPFWage','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsPreEEVolEPFWage''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsEEPreVolEPF') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsEEPreVolEPF','TMSDistribute','Ana_TsEEPreVolEPF','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsEEPreVolEPF''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsPreERVolEPFWage') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsPreERVolEPFWage','TMSDistribute','Ana_TsPreERVolEPFWage','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsPreERVolEPFWage''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsERPreVolEPF') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsERPreVolEPF','TMSDistribute','Ana_TsERPreVolEPF','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsERPreVolEPF''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsSOCSOWage') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsSOCSOWage','TMSDistribute','Ana_TsSOCSOWage','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsSOCSOWage''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsEESOCSO') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsEESOCSO','TMSDistribute','Ana_TsEESOCSO','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsEESOCSO''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsERSOCSO') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsERSOCSO','TMSDistribute','Ana_TsERSOCSO','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsERSOCSO''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsHRDLevy') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsHRDLevy','TMSDistribute','Ana_TsHRDLevy','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsHRDLevy''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsPaidPreTaxAmt') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsPaidPreTaxAmt','TMSDistribute','Ana_TsPaidPreTaxAmt','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsPaidPreTaxAmt''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsPaidCurTaxAmt') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsPaidCurTaxAmt','TMSDistribute','Ana_TsPaidCurTaxAmt','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsPaidCurTaxAmt''','','');
end if;

if not exists(select * from AnItemLookup Where AnlysLookupId = 'TsTaxBenefit') then
   Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,
                            AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
   Values('TsTaxBenefit','TMSDistribute','Ana_TsTaxBenefit','TsDistribute','AnlysAmount1','TMSDistribute','sum(CostingAmount)','TMSDistributeId = ''TsTaxBenefit''','','');
end if;

/* Sub Registry */
if not exists(select * from Registry where RegistryId = 'SageProdIntegrate') then
   Insert into Registry (RegistryId,SubRegistryId)
   Values('SageProdIntegrate','Sage Product Integration');
end if;

if not exists(select * from SubRegistry where RegistryId = 'SageProdIntegrate' and SubRegistryId = 'TMSViewMYTimeSheet') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('SageProdIntegrate','TMSViewMYTimeSheet','View_Acc_MY_TimeSheet','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

commit work;