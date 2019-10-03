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
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_10','AllowanceKeywordUserDefinedName','SysIStat_2',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_11','CalTotalGrossWage','SysIStat_3',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_12','CalGrossWage','SysIStat_3',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_13','TAP1Wage','SysIStat_3',3);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_14','TAP2Wage','SysIStat_3',4);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_15','TAP3Wage','SysIStat_3',5);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_16','SCPWage','SysIStat_3',6);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_17','TotalEmpeeTAP1','SysIStat_3',7);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_18','TotalEmpeeTAP2','SysIStat_3',8);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_19','TotalEmpeeTAP3','SysIStat_3',9);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_20','TotalEmpeeSCP','SysIStat_3',10);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_21','CalNetWage','SysIStat_3',11);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_22','TotalEmperTAP1','SysIStat_3',12);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_23','TotalEmperTAP2','SysIStat_3',13);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_24','TotalEmperTAP3','SysIStat_3',14);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_25','TotalEmperSCP','SysIStat_3',15);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_26','TotalTAP','SysIStat_3',16);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_27','NPLDaysTaken','SysIStat_3',17);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_28','NPLHours','SysIStat_3',18);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_29','AbsDaysTaken','SysIStat_3',19);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_30','LateHours','SysIStat_3',20);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_31','FreeNumeric1','SysIStat_3',21);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_32','FreeNumeric2','SysIStat_3',22);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_33','FreeNumeric3','SysIStat_3',23);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_34','FreeNumeric4','SysIStat_3',24);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_35','FreeNumeric5','SysIStat_3',25);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_36','SumOTFreq','SysIStat_4',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_37','ShiftFrequency','SysIStat_5',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_38','AnlCurrLvePeriodTaken','SysIStat_6',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_39','SickCurrLvePeriodTaken','SysIStat_6',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDStat_40','PayHeadCount','SysIStat_6',3);
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
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_15','TAP1Wage','SysIVar_5',3);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_16','TAP2Wage','SysIVar_5',4);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_17','TAP3Wage','SysIVar_5',5);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_18','SCPWage','SysIVar_5',6);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_19','TotalEmpeeTAP1','SysIVar_5',7);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_20','TotalEmpeeTAP2','SysIVar_5',8);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_21','TotalEmpeeTAP3','SysIVar_5',9);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_22','TotalEmpeeSCP','SysIVar_5',10);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_23','CalNetWage','SysIVar_5',11);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_24','TotalEmperTAP1','SysIVar_5',12);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_25','TotalEmperTAP2','SysIVar_5',13);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_26','TotalEmperTAP3','SysIVar_5',14);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_27','TotalEmperSCP','SysIVar_5',15);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_28','TotalTAP','SysIVar_5',16);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_29','NPLDaysTaken','SysIVar_5',17);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_30','NPLHours','SysIVar_5',18);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_31','AbsDaysTaken','SysIVar_5',19);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_32','LateHours','SysIVar_5',20);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_33','FreeNumeric1','SysIVar_5',21);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_34','FreeNumeric2','SysIVar_5',22);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_35','FreeNumeric3','SysIVar_5',23);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_36','FreeNumeric4','SysIVar_5',24);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_37','FreeNumeric5','SysIVar_5',25);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_38','SumOTFreq','SysIVar_6',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_39','ShiftFrequency','SysIVar_7',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_40','AnlCurrLvePeriodTaken','SysIVar_8',1);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_41','SickCurrLvePeriodTaken','SysIVar_8',2);
INSERT INTO AnlysDispSection (AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) VALUES ('SysDVar_42','PayHeadCount','SysIVar_8',3);