Read UpgradeDB\Ver1070102\InterfaceProject.sql;

// EA Form
if not exists (select 1 from sys.syscolumns where cname = 'MalTaxGratuityFrom' and tname = 'MalTaxRecord') then
  alter table MalTaxRecord add MalTaxGratuityFrom date;
end if;
if not exists (select 1 from sys.syscolumns where cname = 'MalTaxGratuityTo' and tname = 'MalTaxRecord') then
  alter table MalTaxRecord add MalTaxGratuityTo date;
end if;
if not exists (select 1 from sys.syscolumns where cname = 'MalTaxGratuity' and tname = 'MalTaxRecord') then
  alter table MalTaxRecord add MalTaxGratuity double;
end if;
if not exists (select 1 from sys.syscolumns where cname = 'MalTaxBenefitsDetails' and tname = 'MalTaxRecord') then
  alter table MalTaxRecord add MalTaxBenefitsDetails char(100);
end if;
if not exists (select 1 from sys.syscolumns where cname = 'MalTaxBenefitsInKind' and tname = 'MalTaxRecord') then
  alter table MalTaxRecord add MalTaxBenefitsInKind double;
end if;
if not exists (select 1 from sys.syscolumns where cname = 'MalTaxChildRebate' and tname = 'MalTaxRecord') then
  alter table MalTaxRecord add MalTaxChildRebate double;
end if;

commit work;