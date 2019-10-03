if not exists (select 1 from sys.syscolumns where tname='RebateGranted' and cname='TRebateAmt') then
   alter table dba.RebateGranted add TRebateAmt double default 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='RebateGranted' and cname='TLPAmt') then
   alter table dba.RebateGranted add TLPAmt double default 0;
end if;

if not exists (select 1 from sys.syscolumns where tname='RebateGranted' and cname='TEmployeeSysId') then
   alter table dba.RebateGranted add TEmployeeSysId integer default 0;
end if;

commit work;