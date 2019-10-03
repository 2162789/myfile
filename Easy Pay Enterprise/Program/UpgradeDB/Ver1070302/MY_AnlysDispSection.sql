/* Statistics Report */
/* SystemAttribute */
If not exists(Select SysTableId from SystemAttribute where SysTableId='PolicyRecord' and SysAttributeId='Ana_EISWage') Then
  Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5)
  Values('PolicyRecord','Ana_EISWage','EIS Wage',1,'','','','','');
end if;

If not exists(Select SysTableId from SystemAttribute where SysTableId='PolicyRecord' and SysAttributeId='Ana_TotalEmpeeEIS') Then
  Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5)
  Values('PolicyRecord','Ana_TotalEmpeeEIS','Total Employee EIS',1,'','','','','');
end if;

If not exists(Select SysTableId from SystemAttribute where SysTableId='PolicyRecord' and SysAttributeId='Ana_TotalEmperEIS') Then
  Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5)
  Values('PolicyRecord','Ana_TotalEmperEIS','Total Employer EIS',1,'','','','','');
end if;

If not exists(Select SysTableId from SystemAttribute where SysTableId='PolicyRecord' and SysAttributeId='Ana_TotalEIS') Then
  Insert into SystemAttribute(SysTableId,SysAttributeId,SysUserdefinedName,SysSpecialAttribute,SysParameter1,SysParameter2,SysParameter3,SysParameter4,SysParameter5)
  Values('PolicyRecord','Ana_TotalEIS','Total EIS',1,'','','','','');
end if;

/* AnItemLookup */
If not exists(Select AnlysLookupId from AnItemLookup where AnlysLookupId='EISWage') Then
  Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
  Values('EISWage','PolicyRecord','Ana_EISWage','PaySystem','AnlysAmount1','PolicyRecord','sum(CurAdditionalWage)','','AnlysFAmount1','AnlysDoubleValue1');
end if;

If not exists(Select AnlysLookupId from AnItemLookup where AnlysLookupId='TotalEmpeeEIS') Then
  Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
  Values('TotalEmpeeEIS','PolicyRecord','Ana_TotalEmpeeEIS','PaySystem','AnlysAmount1','PolicyRecord','sum(ContriAddEECPF)','','AnlysFAmount1','AnlysDoubleValue1');
end if;

If not exists(Select AnlysLookupId from AnItemLookup where AnlysLookupId='TotalEmperEIS') Then
  Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
  Values('TotalEmperEIS','PolicyRecord','Ana_TotalEmperEIS','PaySystem','AnlysAmount1','PolicyRecord','sum(ContriAddERCPF)','','AnlysFAmount1','AnlysDoubleValue1');
end if;

If not exists(Select AnlysLookupId from AnItemLookup where AnlysLookupId='TotalEIS') Then
  Insert into AnItemLookup(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
  Values('TotalEIS','PolicyRecord','Ana_TotalEIS','PaySystem','AnlysAmount1','PolicyRecord','sum(ContriAddEECPF+ContriAddERCPF)','','AnlysFAmount1','AnlysDoubleValue1');
end if;

/* AnlysDispSection */
Truncate table AnlysItemRecord;
Delete from AnlysDispSection Where AnlysDisplaySysId like 'SysDStat_%';
Delete from AnlysDispSection Where AnlysDisplaySysId like 'SysDVar_%';

INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_1','SysIStat_1','CalTotalWage',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_2','SysIStat_1','AllocatedMVC',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_3','SysIStat_1','AllocatedNWC',3);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_4','SysIStat_1','CalOTAmount',4);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_5','SysIStat_1','CalOTBackPay',5);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_6','SysIStat_1','CalShiftAmount',6);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_7','SysIStat_1','CalLveDeductAmt',7);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_8','SysIStat_1','CalBackPay',8);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_9','SysIStat_2','AUserDef1Value',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_10','SysIStat_2','FAllowanceAmount',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_11','SysIStat_3','FDeductionAmount',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_12','SysIStat_4','FReimbursementAmount',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_13','SysIStat_5','CalTotalGrossWage',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_14','SysIStat_5','CalGrossWage',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_15','SysIStat_5','EmpeeEPFManWage',3);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_16','SysIStat_5','EmpeeEPFVolWage',4);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_17','SysIStat_5','ArrearEmpeeEPFWage',5);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_18','SysIStat_5','SocsoWage',6);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_19','SysIStat_5','EISWage',7);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_20','SysIStat_5','TotalCurTaxWage',8);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_21','SysIStat_5','TotalPrevTaxWage',9);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_22','SysIStat_5','ArrearTotalTaxWage',10);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_23','SysIStat_5','EmpeeEPFManSub',11);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_24','SysIStat_5','EmpeeEPFVolSub',12);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_25','SysIStat_5','ArrearEmpeeEPF',13);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_26','SysIStat_5','TotalEmpeeSocso',14);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_27','SysIStat_5','TotalEmpeeEIS',15);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_28','SysIStat_5','TotalCurTaxAmt',16);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_29','SysIStat_5','TotalPrevTaxAmt',17);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_30','SysIStat_5','ArrearTotalTaxAmt',18);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_31','SysIStat_5','CalNetWage',19);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_32','SysIStat_5','EmperEPFManWage',20);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_33','SysIStat_5','EmperEPFVolWage',21);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_34','SysIStat_5','ArrearEmperEPFWage',22);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_35','SysIStat_5','EmperEPFManSub',23);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_36','SysIStat_5','EmperEPFVolSub',24);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_37','SysIStat_5','ArrearEmperEPF',25);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_38','SysIStat_5','TotalEPF',26);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_39','SysIStat_5','TotalEmperSocso',27);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_40','SysIStat_5','TotalSocso',28);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_41','SysIStat_5','TotalEmperEIS',29);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_42','SysIStat_5','TotalEIS',30);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_43','SysIStat_5','TotalZakat',31);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_44','SysIStat_5','HRDLevy',32);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_45','SysIStat_5','HRDWage',33);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_46','SysIStat_6','TotalWP39Amt',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_47','SysIStat_6','TotalCP38Amt',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_48','SysIStat_6','TotalTaxAmt',3);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_49','SysIStat_6','TaxCategory',4);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_50','SysIStat_6','TaxEPFRelief',5);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_51','SysIStat_6','TaxChildRelief',6);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_52','SysIStat_6','TaxZakatRelief',7);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_53','SysIStat_6','TaxBenefit',8);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_54','SysIStat_7','NPLDaysTaken',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_55','SysIStat_7','NPLHours',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_56','SysIStat_7','AbsDaysTaken',3);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_57','SysIStat_7','LateHours',4);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_58','SysIStat_7','FreeNumeric1',5);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_59','SysIStat_7','FreeNumeric2',6);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_60','SysIStat_7','FreeNumeric3',7);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_61','SysIStat_7','FreeNumeric4',8);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_62','SysIStat_7','FreeNumeric5',9);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_63','SysIStat_8','SumOTFreq',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_64','SysIStat_9','ShiftFrequency',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_65','SysIStat_10','AnlCurrLvePeriodTaken',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_66','SysIStat_10','SickCurrLvePeriodTaken',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDStat_67','SysIStat_10','PayHeadCount',3);

INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_1','SysIVar_1','AllocatedBasicRate',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_2','SysIVar_1','AllocatedMVC',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_3','SysIVar_1','AllocatedNWC',3);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_4','SysIVar_1','CalTotalWage',4);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_5','SysIVar_1','CalOTAmount',5);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_6','SysIVar_1','CalOTBackPay',6);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_7','SysIVar_1','CalShiftAmount',7);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_8','SysIVar_1','CalLveDeductAmt',8);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_9','SysIVar_1','CalBackPay',9);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_10','SysIVar_2','AUserDef1Value',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_11','SysIVar_2','FAllowanceAmount',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_12','SysIVar_3','FDeductionAmount',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_13','SysIVar_4','FReimbursementAmount',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_14','SysIVar_5','CalTotalGrossWage',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_15','SysIVar_5','CalGrossWage',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_16','SysIVar_5','EmpeeEPFManWage',3);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_17','SysIVar_5','EmpeeEPFVolWage',4);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_18','SysIVar_5','ArrearEmpeeEPFWage',5);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_19','SysIVar_5','SocsoWage',6);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_20','SysIVar_5','EISWage',7);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_21','SysIVar_5','TotalCurTaxWage',8);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_22','SysIVar_5','TotalPrevTaxWage',9);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_23','SysIVar_5','ArrearTotalTaxWage',10);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_24','SysIVar_5','EmpeeEPFManSub',11);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_25','SysIVar_5','EmpeeEPFVolSub',12);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_26','SysIVar_5','ArrearEmpeeEPF',13);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_27','SysIVar_5','TotalEmpeeSocso',14);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_28','SysIVar_5','TotalEmpeeEIS',15);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_29','SysIVar_5','TotalCurTaxAmt',16);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_30','SysIVar_5','TotalPrevTaxAmt',17);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_31','SysIVar_5','ArrearTotalTaxAmt',18);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_32','SysIVar_5','CalNetWage',19);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_33','SysIVar_5','EmperEPFManWage',20);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_34','SysIVar_5','EmperEPFVolWage',21);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_35','SysIVar_5','ArrearEmperEPFWage',22);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_36','SysIVar_5','EmperEPFManSub',23);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_37','SysIVar_5','EmperEPFVolSub',24);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_38','SysIVar_5','ArrearEmperEPF',25);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_39','SysIVar_5','TotalEPF',26);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_40','SysIVar_5','TotalEmperSocso',27);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_41','SysIVar_5','TotalSocso',28);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_42','SysIVar_5','TotalEmperEIS',29);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_43','SysIVar_5','TotalEIS',30);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_44','SysIVar_5','TotalZakat',31);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_45','SysIVar_6','TotalWP39Amt',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_46','SysIVar_6','TotalCP38Amt',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_47','SysIVar_6','TotalTaxAmt',3);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_48','SysIVar_6','TaxCategory',4);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_49','SysIVar_6','TaxEPFRelief',5);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_50','SysIVar_6','TaxChildRelief',6);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_51','SysIVar_6','TaxZakatRelief',7);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_52','SysIVar_6','TaxBenefit',8);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_53','SysIVar_7','NPLDaysTaken',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_54','SysIVar_7','NPLHours',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_55','SysIVar_7','AbsDaysTaken',3);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_56','SysIVar_7','LateHours',4);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_57','SysIVar_8','SumOTFreq',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_58','SysIVar_9','ShiftFrequency',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_59','SysIVar_10','AnlCurrLvePeriodTaken',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_60','SysIVar_10','SickCurrLvePeriodTaken',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_61','SysIVar_5','HRDLevy',18);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_62','SysIVar_5','HRDWage',19);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_63','SysIVar_7','FreeNumeric1',5);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_64','SysIVar_7','FreeNumeric2',6);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_65','SysIVar_7','FreeNumeric3',7);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_66','SysIVar_7','FreeNumeric4',8);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_67','SysIVar_7','FreeNumeric5',9);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysItemSysId,AnlysLookupId,DisplaySubSection) VALUES('SysDVar_68','SysIVar_10','PayHeadCount',3);

commit work;