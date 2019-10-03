/* MalTaxRecord table */
if not exists(select 1 from sys.syscolumns where tname='MalTaxRecord' and cname='MalTaxCorrespAddress1') then
    alter table DBA.MalTaxRecord Add MalTaxCorrespAddress1 char(100);
end if;

if not exists(select 1 from sys.syscolumns where tname='MalTaxRecord' and cname='MalTaxCorrespAddress2') then
    alter table DBA.MalTaxRecord Add MalTaxCorrespAddress2 char(100);
end if;

if not exists(select 1 from sys.syscolumns where tname='MalTaxRecord' and cname='MalTaxAgentAddress') then
    alter table DBA.MalTaxRecord Add MalTaxAgentAddress smallint default 0;
end if;

if not exists(select 1 from sys.syscolumns where tname='MalTaxRecord' and cname='MalTaxStockOfferDate') then
    alter table DBA.MalTaxRecord Add MalTaxStockOfferDate date;
end if;

if not exists(select 1 from sys.syscolumns where tname='MalTaxRecord' and cname='MalTaxStockExerciseDate') then
    alter table DBA.MalTaxRecord Add MalTaxStockExerciseDate date;
end if;

if not exists(select 1 from sys.syscolumns where tname='MalTaxRecord' and cname='MalTaxStockTotalBenefit') then
    alter table DBA.MalTaxRecord Add MalTaxStockTotalBenefit double;
end if;

if not exists(select 1 from sys.syscolumns where tname='MalTaxRecord' and cname='MalTaxOtherAmtPaymentType') then
    alter table DBA.MalTaxRecord Add MalTaxOtherAmtPaymentType char(100);
end if;

if not exists(select 1 from sys.syscolumns where tname='MalTaxRecord' and cname='MalTaxOtherAmtPaymentDate') then
    alter table DBA.MalTaxRecord Add MalTaxOtherAmtPaymentDate date;
end if;

if not exists(select 1 from sys.syscolumns where tname='MalTaxRecord' and cname='MalTaxOtherAmtPaymentAmt') then
    alter table DBA.MalTaxRecord Add MalTaxOtherAmtPaymentAmt double;
end if;

if not exists(select 1 from sys.syscolumns where tname='MalTaxRecord' and cname='MalTaxShareSchemeType') then
    alter table DBA.MalTaxRecord Add MalTaxShareSchemeType char(100);
end if;

if not exists(select 1 from sys.syscolumns where tname='MalTaxRecord' and cname='MalTaxShareNoOfShare') then
    alter table DBA.MalTaxRecord Add MalTaxShareNoOfShare integer;
end if;

if not exists(select 1 from sys.syscolumns where tname='MalTaxRecord' and cname='MalTaxShareOptionDate') then
    alter table DBA.MalTaxRecord Add MalTaxShareOptionDate date;
end if;

if not exists(select 1 from sys.syscolumns where tname='MalTaxRecord' and cname='MalTaxShareRemainingAmt') then
    alter table DBA.MalTaxRecord Add MalTaxShareRemainingAmt double;
end if;

if not exists(select 1 from sys.syscolumns where tname='MalTaxRecord' and cname='MalTaxOtherAwsPerquisitesCode') then
    alter table DBA.MalTaxRecord Add MalTaxOtherAwsPerquisitesCode double;
end if;

commit work;