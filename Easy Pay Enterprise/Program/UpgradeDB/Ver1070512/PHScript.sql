/* Statistic Report */
if not exists(select * from SystemAttribute where SysTableId = 'PolicyRecord' and SysAttributeId = 'Ana_ATCTaxAmt') then
  insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5)
  values('PolicyRecord','Ana_ATCTaxAmt','ATC Tax Amount',1,'','','','','');
end if;

if not exists(select * from AnItemLookup where AnlysLookupId = 'ATCTaxAmt') then
  insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
  values('ATCTaxAmt','PolicyRecord','Ana_ATCTaxAmt','PaySystem','AnlysAmount1','PolicyRecord','sum(CurrEEVolWage)','','AnlysFAmount1','AnlysDoubleValue1');
end if;

Delete from AnlysItemRecord;
Delete from AnlysDispSection WHERE AnlysDisplaySysId like 'SysDStat%';
Delete from AnlysDispSection WHERE AnlysDisplaySysId like 'SysDVar%';
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_1','CalTotalWage','SysIStat_1',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_2','AllocatedMVC','SysIStat_1',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_3','AllocatedNWC','SysIStat_1',3);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_4','CalOTAmount','SysIStat_1',4);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_5','CalOTBackPay','SysIStat_1',5);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_6','CalShiftAmount','SysIStat_1',6);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_7','CalLveDeductAmt','SysIStat_1',7);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_8','CalBackPay','SysIStat_1',8);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_9','AllowanceAmount','SysIStat_2',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_10','CalTotalGrossWage','SysIStat_3',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_11','CalGrossWage','SysIStat_3',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_12','PHICWage','SysIStat_3',3);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_13','HDMFWage','SysIStat_3',4);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_14','SSSWage','SysIStat_3',5);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_15','ECOLAAmt','SysIStat_3',6);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_16','EmpeePHIC','SysIStat_3',7);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_17','EmpeeHDMF','SysIStat_3',8);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_18','EmpeeSSS','SysIStat_3',9);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_19','CalNetWage','SysIStat_3',10);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_20','EmperPHIC','SysIStat_3',11);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_21','EmperHDMF','SysIStat_3',12);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_22','EmperSSSss','SysIStat_3',13);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_23','EmperSSSec','SysIStat_3',14);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_24','PaidTaxAmt','SysIStat_3',15);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_25','TaxBenefit','SysIStat_3',16);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_26','ATCTaxAmt','SysIStat_3',17);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_27','NPLDaysTaken','SysIStat_3',18);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_28','NPLHours','SysIStat_3',19);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_29','AbsDaysTaken','SysIStat_3',20);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_30','LateHours','SysIStat_3',21);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_31','SumOTFreq','SysIStat_4',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_32','ShiftFrequency','SysIStat_5',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_33','AnlCurrLvePeriodTaken','SysIStat_6',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_34','SickCurrLvePeriodTaken','SysIStat_6',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_35','PayHeadCount','SysIStat_6',3);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_36','FreeNumeric1','SysIStat_3',22);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_37','FreeNumeric2','SysIStat_3',23);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_38','FreeNumeric3','SysIStat_3',24);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_39','FreeNumeric4','SysIStat_3',25);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_40','FreeNumeric5','SysIStat_3',26);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_1','AllocatedBasicRate','SysIVar_1',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_2','AllocatedMVC','SysIVar_1',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_3','AllocatedNWC','SysIVar_1',3);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_4','CalTotalWage','SysIVar_1',4);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_5','CalOTAmount','SysIVar_1',5);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_6','CalOTBackPay','SysIVar_1',6);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_7','CalShiftAmount','SysIVar_1',7);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_8','CalLveDeductAmt','SysIVar_1',8);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_9','CalBackPay','SysIVar_1',9);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_10','FAllowanceAmount','SysIVar_2',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_11','FDeductionAmount','SysIVar_3',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_12','FReimbursementAmount','SysIVar_4',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_13','CalTotalGrossWage','SysIVar_5',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_14','CalGrossWage','SysIVar_5',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_15','PHICWage','SysIVar_5',3);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_16','HDMFWage','SysIVar_5',4);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_17','SSSWage','SysIVar_5',5);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_18','ECOLAAmt','SysIVar_5',6);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_19','EmpeePHIC','SysIVar_5',7);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_20','EmpeeHDMF','SysIVar_5',8);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_21','EmpeeSSS','SysIVar_5',9);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_22','CalNetWage','SysIVar_5',10);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_23','EmperPHIC','SysIVar_5',11);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_24','EmperHDMF','SysIVar_5',12);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_25','EmperSSSss','SysIVar_5',13);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_26','EmperSSSec','SysIVar_5',14);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_27','PaidTaxAmt','SysIVar_5',15);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_28','TaxBenefit','SysIVar_5',16);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_29','ATCTaxAmt','SysIVar_5',17);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_30','NPLDaysTaken','SysIVar_5',18);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_31','NPLHours','SysIVar_5',19);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_32','AbsDaysTaken','SysIVar_5',20);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_33','LateHours','SysIVar_5',21);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_34','SumOTFreq','SysIVar_6',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_35','ShiftFrequency','SysIVar_7',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_36','AnlCurrLvePeriodTaken','SysIVar_8',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_37','SickCurrLvePeriodTaken','SysIVar_8',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_38','FreeNumeric1','SysIVar_5',22);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_39','FreeNumeric2','SysIVar_5',23);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_40','FreeNumeric3','SysIVar_5',24);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_41','FreeNumeric4','SysIVar_5',25);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_42','FreeNumeric5','SysIVar_5',26);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_43','PayHeadCount','SysIVar_8',3);

/* Report Export */
if not exists(select * from keyword where keywordid = 'EX_ATCTaxAmt') then
    insert into keyword(KeyWordId, KeyWordDefaultName, KeywordUserDefinedName, KeyWordCategory, KeywordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup) 
	values('EX_ATCTaxAmt','ATC Tax Amt','ATC Tax Amt','EXPORT',0,0,0,'CurrEEVolWage',173,2,0,'')
end if;

if not exists(select * from keyword where keywordid = 'EX_ATCTaxAmt_PREV') then
    insert into keyword(KeyWordId, KeyWordDefaultName, KeywordUserDefinedName, KeyWordCategory, KeywordPropertySelection, KeyWordFormulaSelection, KeyWordRangeSelection, KeyWordDesc, KeyWordSubCategory, KeyWordSubProperty, KeyWordStage, KeyWordGroup) 
	values('EX_ATCTaxAmt_PREV','ATC Tax Amt (Prev)','ATC Tax Amt (Prev)','EXPORT',0,0,0,'CurrEEVolWage',174,8,0,'')
end if;

commit work;