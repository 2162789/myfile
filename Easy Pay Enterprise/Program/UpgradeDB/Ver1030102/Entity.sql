if not exists (select 1 from sys.syscolumns where tname='LoanEmployee' and cname='LoanPrincipalAmt') then
   alter table dba.LoanEmployee add LoanPrincipalAmt double default 0;
end if;

commit work;