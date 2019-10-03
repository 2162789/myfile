UPDATE AnItemType SET AnlysItem3Field='FGetFormulaType(AllowanceFormulaId)' WHERE AnlysItemTypeId='Allowance';

if not exists(Select * From AnItemLookup  Where AnlysLookupId='ArrearEmpeeEPFWage') then
Insert into AnItemLookup 
(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
Values ('ArrearEmpeeEPFWage','PolicyRecord','Ana_ArrearEmpeeEPFWage','PaySystem','AnlysAmount1','PolicyRecord','sum(FGetMalArrearEEEPFWageByGenId(PolicyRecSGSPGenId,''PolicyRecord''))','','AnlysFAmount1','AnlysDoubleValue1');
end if;

if not exists(Select * From AnItemLookup  Where AnlysLookupId='ArrearEmperEPFWage') then
Insert into AnItemLookup 
(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
Values ('ArrearEmperEPFWage','PolicyRecord','Ana_ArrearEmperEPFWage','PaySystem','AnlysAmount1','PolicyRecord','sum(FGetMalArrearEEEPFWageByGenId(PolicyRecSGSPGenId,''PolicyRecord''))','','AnlysFAmount1','AnlysDoubleValue1');
end if;

if not exists(Select * From AnItemLookup  Where AnlysLookupId='ArrearEmpeeEPF') then
Insert into AnItemLookup 
(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
Values ('ArrearEmpeeEPF','PolicyRecord','Ana_ArrearEmpeeEPF','PaySystem','AnlysAmount1','PolicyRecord','sum(FGetMalArrearEEEPFByGenId(PolicyRecSGSPGenId,''PolicyRecord''))','','AnlysFAmount1','AnlysDoubleValue1');
end if;

if not exists(Select * From AnItemLookup  Where AnlysLookupId='ArrearEmperEPF') then
Insert into AnItemLookup 
(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
Values ('ArrearEmperEPF','PolicyRecord','Ana_ArrearEmperEPF','PaySystem','AnlysAmount1','PolicyRecord','sum(FGetMalArrearEREPFByGenId(PolicyRecSGSPGenId,''PolicyRecord''))','','AnlysFAmount1','AnlysDoubleValue1');
end if;

if not exists(Select * From AnItemLookup  Where AnlysLookupId='ArrearTotalTaxWage') then
Insert into AnItemLookup 
(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
Values ('ArrearTotalTaxWage','PolicyRecord','Ana_ArrearTotalTaxWage','PaySystem','AnlysAmount1','PolicyRecord','sum(FGetMalArrearEEEPFWageByGenId(PolicyRecSGSPGenId,''PolicyRecord''))','','AnlysFAmount1','AnlysDoubleValue1');
end if;

if not exists(Select * From AnItemLookup  Where AnlysLookupId='ArrearTotalTaxAmt') then
Insert into AnItemLookup 
(AnlysLookupId,SysTableId,SysAttributeId,AnlysItemTypeId,AnlysMapField,AnlysTable,AnlysFunction,AnlysCondition,AnlysMapFieldPrev,AnlysMapFieldVar)
Values ('ArrearTotalTaxAmt','PolicyRecord','Ana_ArrearTotalTaxAmt','PaySystem','AnlysAmount1','PolicyRecord','sum(FGetMalArrearTaxByGenId(PolicyRecSGSPGenId,''PolicyRecord''))','','AnlysFAmount1','AnlysDoubleValue1');
end if;

Update AnItemLookup 
SET AnlysFunction='sum(PaidCurrentTaxAmt+PaidPreviousTaxAmt+TotalSINDA+TotalEUCF+FGetMalArrearTaxByGenId(PeriodPolicySummary.PayPeriodSGSPGenId,''PeriodPolicySummary''))' WHERE AnlysLookupId='TotalTaxAmt';

Update AnItemLookup 
SET AnlysFunction='sum(FGetMalPolicyRecTotalEPF(PolicyRecSGSPGenId))' WHERE AnlysLookupId='TotalEPF';
