if not exists(select * from keyword where keywordid = 'CR_MYPayLPayslip') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_MYPayLPayslip','Pay','Laser Payslip','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Laser Payslip Report');
end if;

if not exists(select * from keyword where keywordid = 'CR_MYPayPPayslip') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )	
   values('CR_MYPayPPayslip','Pay','Pre-printed Payslip','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Pre-printed Payslip Report');
end if;

if not exists(select * from keyword where keywordid = 'CR_MYPayPaySum') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_MYPayPaySum','Pay','Payroll Summary','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Payroll Summary Report');
end if;

commit work;