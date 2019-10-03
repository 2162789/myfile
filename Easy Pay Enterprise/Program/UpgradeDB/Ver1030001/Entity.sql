if not exists (select 1 from sys.syscolumns where tname='Ph1601C' and cname='PhOtherPaymentMade') then
   alter table dba.Ph1601C add PhOtherPaymentMade double default 0;
end if;