if not exists (select 1 from sys.syscolumns where tname='iBankBranch' and cname='BankBranchString1') then
    alter table DBA.iBankBranch Add BankBranchString1 char(100);
end if;

commit work;