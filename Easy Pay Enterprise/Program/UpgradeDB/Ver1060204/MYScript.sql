READ UpgradeDB\Ver1060204\MY_StoredProc.sql;
READ UpgradeDB\Ver1060204\My_AnalysisSystemAttribute.sql;
READ UpgradeDB\Ver1060204\My_AnItemLookup.sql;
READ UpgradeDB\Ver1060204\My_AnlysDispSection.sql;

if not exists(Select * From SubRegistry Where RegistryId='PayPeriodPolicy' and SubRegistryId='ArrearEPF') then
    Insert into SubRegistry Values('PayPeriodPolicy','ArrearEPF','Local','EPF','Arrear','','','','','','','',0,4,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(Select * From SubRegistry Where RegistryId='PayPeriodPolicy' and SubRegistryId='ArrearEPFWage') then   
    Insert into SubRegistry Values('PayPeriodPolicy','ArrearEPFWage','Local','ArrearEPF','Employee Wage','ArrearEPFWage','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(Select * From SubRegistry Where RegistryId='PayPeriodPolicy' and SubRegistryId='ArrearEEEPF') then
    Insert into SubRegistry Values('PayPeriodPolicy','ArrearEEEPF','Local','ArrearEPF','Employee EPF Submission','ArrearEEEPF','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(Select * From SubRegistry Where RegistryId='PayPeriodPolicy' and SubRegistryId='ArrearEREPF') then
    Insert into SubRegistry Values('PayPeriodPolicy','ArrearEREPF','Local','ArrearEPF','Employer EPF Submission','ArrearEREPF','','','','','','',0,2,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(Select * From SubRegistry Where RegistryId='PayPeriodPolicy' and SubRegistryId='ArrearTax') then
    Insert into SubRegistry Values('PayPeriodPolicy','ArrearTax','Local','IncomeTax','Arrear','','','','','','','',0,9,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(Select * From SubRegistry Where RegistryId='PayPeriodPolicy' and SubRegistryId='ArrearTaxWage') then
    Insert into SubRegistry Values('PayPeriodPolicy','ArrearTaxWage','Local','ArrearTax','Arrear Tax Wage','ArrearTaxWage','','','','','','',0,0,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(Select * From SubRegistry Where RegistryId='PayPeriodPolicy' and SubRegistryId='ArrearTaxAmt') then
    Insert into SubRegistry Values('PayPeriodPolicy','ArrearTaxAmt','Local','ArrearTax','Arrear Tax Amount','ArrearTaxAmt','','','','','','',0,1,'',1,'','','1899-12-30','1899-12-30 00:00:00');
end if;

commit work;