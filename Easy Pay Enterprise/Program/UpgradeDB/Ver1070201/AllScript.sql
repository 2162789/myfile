// PH Tax Incentives for Benefactors
if not exists (select 1 from sys.syscolumns where cname = 'PhTaxIncentivesEx' and tname = 'PhTaxPolicyProg') then
  alter table PhTaxPolicyProg add PhTaxIncentivesEx double;
end if;

if not exists (select 1 from sys.syscolumns where cname = 'PhTaxIncentivesEx' and tname = 'PhTaxDetails') then
  alter table PhTaxDetails add PhTaxIncentivesEx smallint;
end if;

if not exists (select 1 from sys.syscolumns where cname = 'PhTaxIncentivesEx' and tname = 'PhTaxRecord') then
  alter table PhTaxRecord add PhTaxIncentivesEx smallint;
end if;

// TH Charitable Donation
if not exists (select 1 from sys.syscolumns where cname = 'Th_CharitableDonation' and tname = 'ThTaxRecord') then
  alter table ThTaxRecord add Th_CharitableDonation double;
end if;

commit work;