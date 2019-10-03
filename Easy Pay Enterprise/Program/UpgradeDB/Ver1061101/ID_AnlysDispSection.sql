/* Statistics Report */ 
/* System Attribute  */
If not exists(Select SysTableId from SystemAttribute where SysTableId='PolicyRecord' and SysAttributeId='Ana_BPJSPensiunWage') Then
  Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5)
  Values('PolicyRecord','Ana_BPJSPensiunWage','BPJS Pensiun Wage',1,'','','','','');
end if;

If not exists(Select SysTableId from SystemAttribute where SysTableId='PolicyRecord' and SysAttributeId='Ana_TotalEmpeeBPJSPensiun') Then
  Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5)
  Values('PolicyRecord','Ana_TotalEmpeeBPJSPensiun','Total Employee BPJS Pensiun',1,'','','','','');
end if;

If not exists(Select SysTableId from SystemAttribute where SysTableId='PolicyRecord' and SysAttributeId='Ana_TotalEmperBPJSPensiun') Then
  Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5)
  Values('PolicyRecord','Ana_TotalEmperBPJSPensiun','Total EmpER BPJS Pensiun',1,'','','','','');
end if;

/* AnItem Lookup  */
If not exists(Select AnlysLookupId from AnItemLookup where AnlysLookupId='BPJSPensiunWage') Then
  Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
  Values('BPJSPensiunWage','PolicyRecord','Ana_BPJSPensiunWage','PaySystem','AnlysAmount1','PolicyRecord','sum(CurrEEVolWage)','','AnlysFAmount1','AnlysDoubleValue1');
end if;

If not exists(Select AnlysLookupId from AnItemLookup where AnlysLookupId='TotalEmpeeBPJSPensiun') Then
  Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
  Values('TotalEmpeeBPJSPensiun','PolicyRecord','Ana_TotalEmpeeBPJSPensiun','PaySystem','AnlysAmount1','PolicyRecord','sum(CurrEEVolContri)','','AnlysFAmount1','AnlysDoubleValue1');
end if;

If not exists(Select AnlysLookupId from AnItemLookup where AnlysLookupId='TotalEmperBPJSPensiun') Then
  Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
  Values('TotalEmperBPJSPensiun','PolicyRecord','Ana_TotalEmperBPJSPensiun','PaySystem','AnlysAmount1','PolicyRecord','sum(CurrERVolContri)','','AnlysFAmount1','AnlysDoubleValue1');
end if;

/* AnlysDispSection */
Delete from AnlysItemRecord;
Delete from AnlysDispSection Where AnlysDisplaySysId like 'SysDStat_%';
Delete from AnlysDispSection Where AnlysDisplaySysId like 'SysDVar_%';

insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_1','CalTotalWage','SysIStat_1',1);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_2','AllocatedMVC','SysIStat_1',2);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_3','AllocatedNWC','SysIStat_1',3);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_4','CalOTAmount','SysIStat_1',4);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_5','CalOTBackPay','SysIStat_1',5);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_6','CalShiftAmount','SysIStat_1',6);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_7','CalLveDeductAmt','SysIStat_1',7);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_8','CalBackPay','SysIStat_1',8);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_9','AllowanceAmount','SysIStat_2',1);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_10','AllowanceKeywordUserDefinedName','SysIStat_2',2);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_11','CalTotalGrossWage','SysIStat_3',1);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_12','JamsostekWage','SysIStat_3',2);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_13','BPJSKesehatanWage','SysIStat_3',3);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_14','BPJSPensiunWage','SysIStat_3',4);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_15','TaxGrossWage','SysIStat_3',5);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_16','TotalEmpeeJamsostek','SysIStat_3',6);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_17','TotalEmpeeBPJSKesehatan','SysIStat_3',7);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_18','TotalEmpeeBPJSPensiun','SysIStat_3',8);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_19','TotalTaxAmt','SysIStat_3',9);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_20','CalNetWage','SysIStat_3',10);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_21','TotalEmperPaymentOldAge','SysIStat_3',11);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_22','TotalEmperPaymentAccident','SysIStat_3',12);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_23','TotalEmplyerPaymentDeath','SysIStat_3',13);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_24','TotalEmperBPJSKesehatan','SysIStat_3',14);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_25','TotalEmperBPJSPensiun','SysIStat_3',15);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_26','NPLDaysTaken','SysIStat_3',16);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_27','NPLHours','SysIStat_3',17);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_28','AbsDaysTaken','SysIStat_3',18);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_29','LateHours','SysIStat_3',19);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_30','FreeNumeric1','SysIStat_3',20);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_31','FreeNumeric2','SysIStat_3',21);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_32','FreeNumeric3','SysIStat_3',22);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_33','FreeNumeric4','SysIStat_3',23);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_34','FreeNumeric5','SysIStat_3',24);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_35','SumOTFreq','SysIStat_4',1);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_36','ShiftFrequency','SysIStat_5',1);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_37','AnlCurrLvePeriodTaken','SysIStat_6',1);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_38','SickCurrLvePeriodTaken','SysIStat_6',2);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStat_39','PayHeadCount','SysIStat_6',3);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_1','AllocatedBasicRate','SysIVar_1',1);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_2','AllocatedMVC','SysIVar_1',2);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_3','AllocatedNWC','SysIVar_1',3);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_4','CalTotalWage','SysIVar_1',4);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_5','CalOTAmount','SysIVar_1',5);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_6','CalOTBackPay','SysIVar_1',6);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_7','CalShiftAmount','SysIVar_1',7);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_8','CalLveDeductAmt','SysIVar_1',8);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_9','CalBackPay','SysIVar_1',9);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_10','FAllowanceAmount','SysIVar_2',1);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_11','FDeductionAmount','SysIVar_3',1);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_12','FReimbursementAmount','SysIVar_4',1);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_13','CalTotalGrossWage','SysIVar_5',1);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_14','CalGrossWage','SysIVar_5',2);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_15','JamsostekWage','SysIVar_5',3);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_16','BPJSKesehatanWage','SysIVar_5',4);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_17','BPJSPensiunWage','SysIVar_5',5);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_18','TaxGrossWage','SysIVar_5',6);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_19','TotalEmpeeJamsostek','SysIVar_5',7);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_20','TotalEmpeeBPJSKesehatan','SysIVar_5',8);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_21','TotalEmpeeBPJSPensiun','SysIVar_5',9);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_22','TotalTaxAmt','SysIVar_5',10);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_23','CalNetWage','SysIVar_5',11);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_24','TotalEmperPaymentOldAge','SysIVar_5',12);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_25','TotalEmperPaymentAccident','SysIVar_5',13);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_26','TotalEmplyerPaymentDeath','SysIVar_5',14);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_27','TotalEmperBPJSKesehatan','SysIVar_5',15);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_28','TotalEmperBPJSPensiun','SysIVar_5',16);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_29','NPLDaysTaken','SysIVar_5',17);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_30','NPLHours','SysIVar_5',18);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_31','AbsDaysTaken','SysIVar_5',19);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_32','LateHours','SysIVar_5',20);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_33','FreeNumeric1','SysIVar_5',21);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_34','FreeNumeric2','SysIVar_5',22);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_35','FreeNumeric3','SysIVar_5',23);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_36','FreeNumeric4','SysIVar_5',24);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_37','FreeNumeric5','SysIVar_5',25);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_38','SumOTFreq','SysIVar_6',1);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_39','ShiftFrequency','SysIVar_7',1);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_40','AnlCurrLvePeriodTaken','SysIVar_8',1);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_41','SickCurrLvePeriodTaken','SysIVar_8',2);
insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDVar_42','PayHeadCount','SysIVar_8',3);

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDGenDeptPayRecon_2') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDGenDeptPayRecon_2','CalOTAmount','ExcelIGenDeptPayRecon_1',2);
end if;

commit work;