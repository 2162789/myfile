if not exists(select * from keyword where keywordid = 'CR_SGPayLPayslip') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_SGPayLPayslip','Pay','Laser Payslip','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Laser Payslip Report');
end if;

if not exists(select * from keyword where keywordid = 'CR_SGPayPPayslip') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_SGPayPPayslip','Pay','Pre-printed Payslip','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Pre-printed Payslip Report');
end if;

if not exists(select * from keyword where keywordid = 'CR_SGPayPaySum') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_SGPayPaySum','Pay','Payroll Summary','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Payroll Summary Report');
end if;