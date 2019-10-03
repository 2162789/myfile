//Thailand Tax Record
if not exists (select 1 from sys.syscolumns where cname = 'ThDisabledAmt' and tname = 'ThTaxProgression') then
  alter table ThTaxProgression add ThDisabledAmt double;
end if;

if not exists (select 1 from sys.syscolumns where cname = 'ThChildUnmarriedAgeLimit' and tname = 'ThTaxProgression') then
  alter table ThTaxProgression add ThChildUnmarriedAgeLimit double;
end if;

if exists (select 1 from sys.syscolumns where cname = 'ThChildAgeLimit' and tname = 'ThTaxProgression') then
  alter table ThTaxProgression rename ThChildAgeLimit to ThChildStudyAgeLimit;
end if;

if not exists (select 1 from sys.syscolumns where cname = 'ThDisabledPerson' and tname = 'ThTaxDetails') then
  alter table ThTaxDetails add ThDisabledPerson smallint;
end if;

if not exists (select 1 from sys.syscolumns where cname = 'ThDisabledPerson' and tname = 'iThTaxDetails') then
  alter table iThTaxDetails add ThDisabledPerson smallint;
end if;

if not exists (select 1 from sys.syscolumns where cname = 'ThB_DisabledOldAgeAmt' and tname = 'ThTaxRecord') then
  alter table ThTaxRecord add ThB_DisabledOldAgeAmt double;
end if;

if not exists (select 1 from sys.syscolumns where cname = 'ThC_DisabledSupport' and tname = 'ThTaxRecord') then
  alter table ThTaxRecord add ThC_DisabledSupport double;
end if;

if not exists (select 1 from sys.syscolumns where cname = 'ThC_AnnuityInsurance' and tname = 'ThTaxRecord') then
  alter table ThTaxRecord add ThC_AnnuityInsurance double;
end if;

if not exists (select 1 from sys.syscolumns where cname = 'ThC_NationalSavings' and tname = 'ThTaxRecord') then
  alter table ThTaxRecord add ThC_NationalSavings double;
end if;

if not exists (select 1 from sys.syscolumns where cname = 'ThC_FirstHomeBuyer' and tname = 'ThTaxRecord') then
  alter table ThTaxRecord add ThC_FirstHomeBuyer double;
end if;

if not exists (select 1 from sys.syscolumns where cname = 'ThC_FoodDomestic' and tname = 'ThTaxRecord') then
  alter table ThTaxRecord add ThC_FoodDomestic double;
end if;

if not exists (select 1 from sys.syscolumns where cname = 'ThC_Domestic' and tname = 'ThTaxRecord') then
  alter table ThTaxRecord add ThC_Domestic double;
end if;

if not exists (select 1 from sys.syscolumns where cname = 'ThC_OTOPGoods' and tname = 'ThTaxRecord') then
  alter table ThTaxRecord add ThC_OTOPGoods double;
end if;

if not exists (select 1 from sys.syscolumns where cname = 'ThC_YearEndDomestic' and tname = 'ThTaxRecord') then
  alter table ThTaxRecord add ThC_YearEndDomestic double;
end if;

if not exists (select 1 from sys.syscolumns where cname = 'ThC_GoodsService' and tname = 'ThTaxRecord') then
  alter table ThTaxRecord add ThC_GoodsService double;
end if;

commit work;