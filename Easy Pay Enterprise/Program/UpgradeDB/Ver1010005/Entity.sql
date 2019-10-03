if not exists (select 1 from sys.syscolumns where tname='RebateGranted' and cname='RebatePaymentCount') 
then
   alter table dba.RebateGranted add RebatePaymentCount integer default 0;
end if;

commit work;


