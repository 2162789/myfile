if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoBD_1') then 
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoBD_1','CalTotalWage','ExcelICoBD_1',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoBD_2') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoBD_2','CalOTAmount','ExcelICoBD_1',2);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoBD_3') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoBD_3','CalOTBackPay','ExcelICoBD_1',3);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoBD_4') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoBD_4','CalShiftAmount','ExcelICoBD_1',4);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoBD_5') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoBD_5','CalLveDeductAmt','ExcelICoBD_1',5);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoBD_6') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoBD_6','CalBackPay','ExcelICoBD_1',6);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoBD_7') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoBD_7','CalTotalGrossWage','ExcelICoBD_1',7);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoBD_8') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoBD_8','CalGrossWage','ExcelICoBD_1',8);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoBD_9') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoBD_9','CalNetWage','ExcelICoBD_1',9);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoBD_10') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoBD_10','NPLDaysTaken','ExcelICoBD_1',10);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoBD_11') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoBD_11','NPLHours','ExcelICoBD_1',11);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoBD_12') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoBD_12','AbsDaysTaken','ExcelICoBD_1',12);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoBD_13') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoBD_13','LateHours','ExcelICoBD_1',13);
end if;
  
if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoBD_14') then  
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoBD_14','AnlCurrLvePeriodTaken','ExcelICoBD_1',14);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoBD_15') then 
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoBD_15','SickCurrLvePeriodTaken','ExcelICoBD_1',15);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoBD_16') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoBD_16','AllowanceAmount','ExcelICoBD_2',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpBD_1') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpBD_1','CalTotalWage','ExcelIEmpBD_1',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpBD_2') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpBD_2','CalOTAmount','ExcelIEmpBD_1',2);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpBD_3') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpBD_3','CalOTBackPay','ExcelIEmpBD_1',3);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpBD_4') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpBD_4','CalShiftAmount','ExcelIEmpBD_1',4);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpBD_5') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpBD_5','CalLveDeductAmt','ExcelIEmpBD_1',5);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpBD_6') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpBD_6','CalBackPay','ExcelIEmpBD_1',6);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpBD_7') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpBD_7','CalTotalGrossWage','ExcelIEmpBD_1',7);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpBD_8') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpBD_8','CalGrossWage','ExcelIEmpBD_1',8);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpBD_9') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpBD_9','CalNetWage','ExcelIEmpBD_1',9);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpBD_10') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpBD_10','NPLDaysTaken','ExcelIEmpBD_1',10);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpBD_11') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpBD_11','NPLHours','ExcelIEmpBD_1',11);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpBD_12') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpBD_12','AbsDaysTaken','ExcelIEmpBD_1',12);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpBD_13') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpBD_13','LateHours','ExcelIEmpBD_1',13);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpBD_14') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpBD_14','AnlCurrLvePeriodTaken','ExcelIEmpBD_1',14);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpBD_15') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpBD_15','SickCurrLvePeriodTaken','ExcelIEmpBD_1',15);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpBD_16') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpBD_16','AllowanceAmount','ExcelIEmpBD_2',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoAccu_1') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoAccu_1','CalTotalWage','ExcelICoAccu_1',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoAccu_2') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoAccu_2','CalOTAmount','ExcelICoAccu_1',2);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoAccu_3') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoAccu_3','CalOTBackPay','ExcelICoAccu_1',3);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoAccu_4') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoAccu_4','CalShiftAmount','ExcelICoAccu_1',4);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoAccu_5') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoAccu_5','CalLveDeductAmt','ExcelICoAccu_1',5);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoAccu_6') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoAccu_6','CalBackPay','ExcelICoAccu_1',6);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoAccu_7') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoAccu_7','FAllowanceAmount','ExcelICoAccu_2',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpAccu_1') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpAccu_1','CalTotalWage','ExcelIEmpAccu_1',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpAccu_2') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpAccu_2','CalOTAmount','ExcelIEmpAccu_1',2);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpAccu_3') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpAccu_3','CalOTBackPay','ExcelIEmpAccu_1',3);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpAccu_4') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpAccu_4','CalShiftAmount','ExcelIEmpAccu_1',4);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpAccu_5') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpAccu_5','CalLveDeductAmt','ExcelIEmpAccu_1',5);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpAccu_6') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpAccu_6','CalBackPay','ExcelIEmpAccu_1',6);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpAccu_7') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpAccu_7','FAllowanceAmount','ExcelIEmpAccu_2',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoStat_1') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoStat_1','CalTotalWage','ExcelICoStat_1',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoStat_2') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoStat_2','CalOTAmount','ExcelICoStat_1',2);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoStat_3') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoStat_3','CalOTBackPay','ExcelICoStat_1',3);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoStat_4') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoStat_4','CalShiftAmount','ExcelICoStat_1',4);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoStat_5') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoStat_5','CalLveDeductAmt','ExcelICoStat_1',5);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoStat_6') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoStat_6','CalBackPay','ExcelICoStat_1',6);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoStat_7') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoStat_7','FAllowanceAmount','ExcelICoStat_2',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpStat_1') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpStat_1','CalTotalWage','ExcelIEmpStat_1',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpStat_2') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpStat_2','CalOTAmount','ExcelIEmpStat_1',2);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpStat_3') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpStat_3','CalOTBackPay','ExcelIEmpStat_1',3);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpStat_4') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpStat_4','CalShiftAmount','ExcelIEmpStat_1',4);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpStat_5') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpStat_5','CalLveDeductAmt','ExcelIEmpStat_1',5);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpStat_6') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpStat_6','CalBackPay','ExcelIEmpStat_1',6);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpStat_7') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpStat_7','FAllowanceAmount','ExcelIEmpStat_2',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoVar_1') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoVar_1','CalTotalWage','ExcelICoVar_1',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoVar_2') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoVar_2','CalOTAmount','ExcelICoVar_1',2);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoVar_3') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoVar_3','CalOTBackPay','ExcelICoVar_1',3);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoVar_4') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoVar_4','CalShiftAmount','ExcelICoVar_1',4);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoVar_5') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoVar_5','CalLveDeductAmt','ExcelICoVar_1',5);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoVar_6') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoVar_6','CalBackPay','ExcelICoVar_1',6);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoVar_7') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoVar_7','FAllowanceAmount','ExcelICoVar_2',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpVar_1') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpVar_1','CalTotalWage','ExcelIEmpVar_1',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpVar_2') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpVar_2','CalOTAmount','ExcelIEmpVar_1',2);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpVar_3') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpVar_3','CalOTBackPay','ExcelIEmpVar_1',3);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpVar_4') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpVar_4','CalShiftAmount','ExcelIEmpVar_1',4);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpVar_5') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpVar_5','CalLveDeductAmt','ExcelIEmpVar_1',5);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpVar_6') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpVar_6','CalBackPay','ExcelIEmpVar_1',6);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpVar_7') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpVar_7','FAllowanceAmount','ExcelIEmpVar_2',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_1') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_1','PerEntEarned','ExcelICoLve_1',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_2') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_2','PerEntAdjEarned','ExcelICoLve_1',2);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_3') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_3','PerBFEarned','ExcelICoLve_1',3);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_4') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_4','PerBFForfeit','ExcelICoLve_1',4);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_5') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_5','PerTotalEnt','ExcelICoLve_1',5);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_6') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_6','PerDayTaken','ExcelICoLve_1',6);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_7') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_7','YTDEntEarned','ExcelICoLve_1',7);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_8') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_8','YTDEntAdjEarned','ExcelICoLve_1',8);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_9') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_9','YTDBFEarned','ExcelICoLve_1',9);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_10') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_10','YTDBFForfeit','ExcelICoLve_1',10);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_11') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_11','YTDTotalEnt','ExcelICoLve_1',11);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_12') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_12','YTDDayTaken','ExcelICoLve_1',12);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_13') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_13','YTDBalance','ExcelICoLve_1',13);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_14') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_14','FPerEntEarnedAmt','ExcelICoLve_1',14);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_15') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_15','FPerEntAdjEarnedAmt','ExcelICoLve_1',15);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_16') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_16','FPerBFEarnedAmt','ExcelICoLve_1',16);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_17') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_17','FPerBFForfeitAmt','ExcelICoLve_1',17);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_18') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_18','FPerTotalEntAmt','ExcelICoLve_1',18);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_19') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_19','FPerDayTakenAmt','ExcelICoLve_1',19);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_20') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_20','FYTDEntEarnedAmt','ExcelICoLve_1',20);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_21') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_21','FYTDEntAdjEarnedAmt','ExcelICoLve_1',21);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_22') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_22','FYTDBFEarnedAmt','ExcelICoLve_1',22);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_23') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_23','FYTDBFForfeitAmt','ExcelICoLve_1',23);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_24') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_24','FYTDTotalEntAmt','ExcelICoLve_1',24);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_25') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_25','FYTDDayTakenAmt','ExcelICoLve_1',25);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDCoLve_26') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDCoLve_26','FYTDBalanceAmt','ExcelICoLve_1',26);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_1') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_1','LveYearRpt','ExcelIEmpLve_1',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_2') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_2','LvePeriodRpt','ExcelIEmpLve_1',2);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_3') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_3','PeriodStartDate','ExcelIEmpLve_1',3);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_4') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_4','PeriodEndDate','ExcelIEmpLve_1',4);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_5') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_5','PerEntEarned','ExcelIEmpLve_1',5);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_6') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_6','PerEntAdjEarned','ExcelIEmpLve_1',6);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_7') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_7','PerBFEarned','ExcelIEmpLve_1',7);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_8') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_8','PerBFForfeit','ExcelIEmpLve_1',8);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_9') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_9','PerTotalEnt','ExcelIEmpLve_1',9);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_10') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_10','PerDayTaken','ExcelIEmpLve_1',10);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_11') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_11','YTDEntEarned','ExcelIEmpLve_1',11);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_12') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_12','YTDEntAdjEarned','ExcelIEmpLve_1',12);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_13') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_13','YTDBFEarned','ExcelIEmpLve_1',13);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_14') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_14','YTDBFForfeit','ExcelIEmpLve_1',14);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_15') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_15','YTDTotalEnt','ExcelIEmpLve_1',15);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_16') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_16','YTDDayTaken','ExcelIEmpLve_1',16);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_17') then 
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_17','YTDBalance','ExcelIEmpLve_1',17);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_18') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_18','FPerEntEarnedAmt','ExcelIEmpLve_1',18);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_19') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_19','FPerEntAdjEarnedAmt','ExcelIEmpLve_1',19);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_20') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_20','FPerBFEarnedAmt','ExcelIEmpLve_1',20);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_21') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_21','FPerBFForfeitAmt','ExcelIEmpLve_1',21);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_22') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_22','FPerTotalEntAmt','ExcelIEmpLve_1',22);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_23') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_23','FPerDayTakenAmt','ExcelIEmpLve_1',23);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_24') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_24','FYTDEntEarnedAmt','ExcelIEmpLve_1',24);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_25') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_25','FYTDEntAdjEarnedAmt','ExcelIEmpLve_1',25);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_26') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_26','FYTDBFEarnedAmt','ExcelIEmpLve_1',26);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_27') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_27','FYTDBFForfeitAmt','ExcelIEmpLve_1',27);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_28') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_28','FYTDTotalEntAmt','ExcelIEmpLve_1',28);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_29') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_29','FYTDDayTakenAmt','ExcelIEmpLve_1',29);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDEmpLve_30') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDEmpLve_30','FYTDBalanceAmt','ExcelIEmpLve_1',30);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDDeptMv_1') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDDeptMv_1','FMvPrevTotal','ExcelIDeptMv_1',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDDeptMv_2') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDDeptMv_2','FMvCurResign','ExcelIDeptMv_1',2);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDDeptMv_3') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDDeptMv_3','FMvCurIn','ExcelIDeptMv_1',3);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDDeptMv_4') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDDeptMv_4','FMvCurOut','ExcelIDeptMv_1',4);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDDeptMv_5') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDDeptMv_5','FMvCurNew','ExcelIDeptMv_1',5);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDDeptMv_6') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDDeptMv_6','FMvCurTotal','ExcelIDeptMv_1',6);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'SysDStaffMv_1') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStaffMv_1','FMvPrevTotal','SysIStaffMv_1',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'SysDStaffMv_2') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStaffMv_2','FMvCurResign','SysIStaffMv_1',2);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'SysDStaffMv_3') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStaffMv_3','FMvCurIn','SysIStaffMv_1',3);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'SysDStaffMv_4') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStaffMv_4','FMvCurOut','SysIStaffMv_1',4);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'SysDStaffMv_5') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStaffMv_5','FMvCurNew','SysIStaffMv_1',5);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'SysDStaffMv_6') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('SysDStaffMv_6','FMvCurTotal','SysIStaffMv_1',6);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDGenDeptPayRecon_1') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDGenDeptPayRecon_1','CalTotalWage','ExcelIGenDeptPayRecon_1',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDGenDeptPayRecon_2') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDGenDeptPayRecon_2','CalOTAmount','ExcelIGenDeptPayRecon_1',2);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDGenDeptPayRecon_3') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDGenDeptPayRecon_3','CalOTBackPay','ExcelIGenDeptPayRecon_1',3);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDGenDeptPayRecon_4') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDGenDeptPayRecon_4','CalShiftAmount','ExcelIGenDeptPayRecon_1',4);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDGenDeptPayRecon_5') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDGenDeptPayRecon_5','CalLveDeductAmt','ExcelIGenDeptPayRecon_1',5);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDGenDeptPayRecon_6') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDGenDeptPayRecon_6','CalBackPay','ExcelIGenDeptPayRecon_1',6);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDGenDeptPayRecon_7') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDGenDeptPayRecon_7','FAllowanceAmount','ExcelIGenDeptPayRecon_2',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDGenCoPayRecon_1') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDGenCoPayRecon_1','CalTotalWage','ExcelIGenCoPayRecon_1',1);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDGenCoPayRecon_2') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDGenCoPayRecon_2','CalOTAmount','ExcelIGenCoPayRecon_1',2);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDGenCoPayRecon_3') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDGenCoPayRecon_3','CalOTBackPay','ExcelIGenCoPayRecon_1',3);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDGenCoPayRecon_4') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDGenCoPayRecon_4','CalShiftAmount','ExcelIGenCoPayRecon_1',4);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDGenCoPayRecon_5') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDGenCoPayRecon_5','CalLveDeductAmt','ExcelIGenCoPayRecon_1',5);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDGenCoPayRecon_6') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDGenCoPayRecon_6','CalBackPay','ExcelIGenCoPayRecon_1',6);
end if;

if not exists(select * from AnlysDispSection where AnlysDisplaySysId = 'ExcelDGenCoPayRecon_7') then
  insert into AnlysDispSection(AnlysDisplaySysId,AnlysLookupId,AnlysItemSysId,DisplaySubSection) values('ExcelDGenCoPayRecon_7','FAllowanceAmount','ExcelIGenCoPayRecon_2',1);
end if;

commit work;