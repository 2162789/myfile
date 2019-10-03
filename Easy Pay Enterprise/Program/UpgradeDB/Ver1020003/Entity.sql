if not exists (select 1 from sys.syscolumns where tname='MalTaxRecord' and cname='MalTaxPrevIncomeType2') then
   alter table dba.MalTaxRecord add MalTaxPrevIncomeType2 char(50);
end if;

commit work;