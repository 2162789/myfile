if not exists(select 1 from sys.syscolumns where tname='IndoTaxEmployer' and cname='IndoBPJSKSOption') then
    alter table DBA.IndoTaxEmployer Add IndoBPJSKSOption smallint;
end if;

if not exists(select 1 from sys.syscolumns where tname='IndoTaxRecord' and cname='IndoTaxBPJSKSAmt') then
    alter table DBA.IndoTaxRecord Add IndoTaxBPJSKSAmt double;
end if;

if not exists(select 1 from sys.syscolumns where tname='BankBranch' and cname='BankBranchString1') then
    alter table DBA.BankBranch Add BankBranchString1 char(100);
end if;

Update IndoTaxEmployer Set IndoBPJSKSOption = 1;
Update IndoTaxRecord Set IndoTaxBPJSKSAmt = 0; 

commit work;

