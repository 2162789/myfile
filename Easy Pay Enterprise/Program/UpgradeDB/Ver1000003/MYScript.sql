//
// Malaysia CP 38 changes
//
if not exists (select 1 from sys.syscolumns where tname='MalTaxReceipt' and cname='MalTaxCP38ReceiptNo') then
   alter table dba.MalTaxReceipt add MalTaxCP38ReceiptNo char(30);
end if;

if not exists (select 1 from sys.syscolumns where tname='MalTaxReceipt' and cname='MalTaxCP38ReceiptDate') then
   alter table dba.MalTaxReceipt add MalTaxCP38ReceiptDate date;
end if;

if not exists (select 1 from sys.syscolumns where tname='MalTaxReceipt' and cname='MalTaxPrevYearIncomeType') then
   alter table dba.MalTaxReceipt add MalTaxPrevYearIncomeType char(30);
end if;

if not exists (select 1 from sys.syscolumns where tname='MalTaxReceipt' and cname='MalTaxPrevYearReceiptNo') then
   alter table dba.MalTaxReceipt add MalTaxPrevYearReceiptNo char(30);
end if;

if not exists (select 1 from sys.syscolumns where tname='MalTaxReceipt' and cname='MalTaxPrevYearReceiptDate') then
   alter table dba.MalTaxReceipt add MalTaxPrevYearReceiptDate date;
end if;
