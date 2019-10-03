--MBMF Update
--1. No of basis must be 2 with basis 1 as 'Residence Status' and basis 2 as 'Race'
--2. No ??? or *All* is used in the mapping
--3. Religion ID 'Muslim' must exist
--4. Race ID 'Chinese', 'Eurasian', 'Indian' must exist
--5. Donation Code 'CDAC2015', 'EUCF2015', 'SIND2015', 'MOSQ2016', 'YMF2016' must exist
if exists (select 1 from SubRegistry where RegistryId = 'MapAutomationBasis' and SubRegistryId = 'MapDonationBasis'
and IntegerAttr = 2 and RegProperty1 = 'DonateResStatus' and RegProperty2 = 'DonateRace')
and not exists (select 1 from MapDonation where DonationBasis1 in ('???', '*All*')) and exists (select 1 from Religion where ReligionID = 'Muslim')
and (select count(1) from Race where RaceId in ('Chinese', 'Eurasian', 'Indian')) = 3
and (select count(1) from Formula where FormulaId in ('CDAC2015', 'EUCF2015', 'SIND2015', 'MOSQ2016', 'YMF2016')) = 5 then
  --Step 1: Extend basis from 2 to 3
  update SubRegistry set IntegerAttr = 3, RegProperty1 = 'DonateReligion', RegProperty2 = 'DonateResStatus', RegProperty3 = 'DonateRace'
  where RegistryId = 'MapAutomationBasis' and SubRegistryId = 'MapDonationBasis';

  --Step 2: Append religion basis for existing mappings
  update MapDonation set DonationBasis3 = DonationBasis2, DonationBasis2 = DonationBasis1, DonationBasis1 = '*NA*';
  
  --Step 3: Insert new mapping *NA* + DP + Malay
  if exists (select 1 from Race where RaceId = 'Malay') and not exists (select 1 from MapDonation where DonationBasis2 = 'DP' and DonationBasis3 = 'Malay') then
    insert into MapDonation (DonationBasis1, DonationBasis2, DonationBasis3) values ('*NA*', 'DP', 'Malay');
	insert into MapDonation_mm (FormulaId, MapDonationSysId)
	select 'MOSQ2016', MapDonationSysId from MapDonation where DonationBasis2 = 'DP' and DonationBasis3 = 'Malay';
    insert into MapDonation_mm (FormulaId, MapDonationSysId)
    select 'YMF2016', MapDonationSysId from MapDonation where DonationBasis2 = 'DP' and DonationBasis3 = 'Malay';
  end if;
  
  --Step 4: Insert new mappings with religion as Muslim for Chinese, Eurasian, Indian only
  --Step 4.1: For combination of Residence Status & Race existing in old default data, check that Donation Code must match
  insert into MapDonation (DonationBasis1, DonationBasis2, DonationBasis3)
  select 'Muslim', MD.DonationBasis2, MD.DonationBasis3 from MapDonation MD join (
    select 'Local' as DonateResStatus, 'Chinese' as DonateRace, 'CDAC2015' as DonationCode union
    select 'PR1' as DonateResStatus, 'Chinese' as DonateRace, 'CDAC2015' as DonationCode union
    select 'PR2' as DonateResStatus, 'Chinese' as DonateRace, 'CDAC2015' as DonationCode union
    select 'PR3' as DonateResStatus, 'Chinese' as DonateRace, 'CDAC2015' as DonationCode union
    select 'Local' as DonateResStatus, 'Eurasian' as DonateRace, 'EUCF2015' as DonationCode union
    select 'PR1' as DonateResStatus, 'Eurasian' as DonateRace, 'EUCF2015' as DonationCode union
    select 'PR2' as DonateResStatus, 'Eurasian' as DonateRace, 'EUCF2015' as DonationCode union
    select 'PR3' as DonateResStatus, 'Eurasian' as DonateRace, 'EUCF2015' as DonationCode union
    select 'Local' as DonateResStatus, 'Indian' as DonateRace, 'SIND2015' as DonationCode union
    select 'PR1' as DonateResStatus, 'Indian' as DonateRace, 'SIND2015' as DonationCode union
    select 'PR2' as DonateResStatus, 'Indian' as DonateRace, 'SIND2015' as DonationCode union
    select 'PR3' as DonateResStatus, 'Indian' as DonateRace, 'SIND2015' as DonationCode union
    select 'EP' as DonateResStatus, 'Indian' as DonateRace, 'SIND2015' as DonationCode
  ) DefaultData on MD.DonationBasis1 = '*NA*' and MD.DonationBasis2 = DefaultData.DonateResStatus and MD.DonationBasis3 = DefaultData.DonateRace
  join (select MapDonationSysId from MapDonation_mm group by MapDonationSysId having count(1) = 1) MDM1 on MD.MapDonationSysId = MDM1.MapDonationSysId
  join MapDonation_mm MDM2 on MDM1.MapDonationSysId = MDM2.MapDonationSysId and DefaultData.DonationCode = MDM2.FormulaId order by MD.MapDonationSysId;
  
  --Step 4.2: For the following combination of Residence Status & Race in new default data, only create if user never created any corresponding 2-basis mapping manually
  if not exists (select 1 from MapDonation where DonationBasis2 = 'DP' and DonationBasis3 = 'Chinese') then
    insert into MapDonation (DonationBasis1, DonationBasis2, DonationBasis3) values ('Muslim', 'DP', 'Chinese');
  end if;
  if not exists (select 1 from MapDonation where DonationBasis2 = 'EP' and DonationBasis3 = 'Chinese') then
    insert into MapDonation (DonationBasis1, DonationBasis2, DonationBasis3) values ('Muslim', 'EP', 'Chinese');
  end if;
  if not exists (select 1 from MapDonation where DonationBasis2 = 'FW' and DonationBasis3 = 'Chinese') then
    insert into MapDonation (DonationBasis1, DonationBasis2, DonationBasis3) values ('Muslim', 'FW', 'Chinese');
  end if;
  if not exists (select 1 from MapDonation where DonationBasis2 = 'Others' and DonationBasis3 = 'Chinese') then
    insert into MapDonation (DonationBasis1, DonationBasis2, DonationBasis3) values ('Muslim', 'Others', 'Chinese');
  end if;
  if not exists (select 1 from MapDonation where DonationBasis2 = 'DP' and DonationBasis3 = 'Eurasian') then
    insert into MapDonation (DonationBasis1, DonationBasis2, DonationBasis3) values ('Muslim', 'DP', 'Eurasian');
  end if;
  if not exists (select 1 from MapDonation where DonationBasis2 = 'EP' and DonationBasis3 = 'Eurasian') then
    insert into MapDonation (DonationBasis1, DonationBasis2, DonationBasis3) values ('Muslim', 'EP', 'Eurasian');
  end if;
  if not exists (select 1 from MapDonation where DonationBasis2 = 'FW' and DonationBasis3 = 'Eurasian') then
    insert into MapDonation (DonationBasis1, DonationBasis2, DonationBasis3) values ('Muslim', 'FW', 'Eurasian');
  end if;
  if not exists (select 1 from MapDonation where DonationBasis2 = 'Others' and DonationBasis3 = 'Eurasian') then
    insert into MapDonation (DonationBasis1, DonationBasis2, DonationBasis3) values ('Muslim', 'Others', 'Eurasian');
  end if;
  if not exists (select 1 from MapDonation where DonationBasis2 = 'DP' and DonationBasis3 = 'Indian') then
    insert into MapDonation (DonationBasis1, DonationBasis2, DonationBasis3) values ('Muslim', 'DP', 'Indian');
  end if;
  if not exists (select 1 from MapDonation where DonationBasis2 = 'FW' and DonationBasis3 = 'Indian') then
    insert into MapDonation (DonationBasis1, DonationBasis2, DonationBasis3) values ('Muslim', 'FW', 'Indian');
  end if;
  if not exists (select 1 from MapDonation where DonationBasis2 = 'Others' and DonationBasis3 = 'Indian') then
    insert into MapDonation (DonationBasis1, DonationBasis2, DonationBasis3) values ('Muslim', 'Others', 'Indian');
  end if;
  
  --Step 5: Insert donation code for all newly created mappings for Muslim in step 4
  insert into MapDonation_mm (FormulaId, MapDonationSysId)
  select 'CDAC2015', MapDonationSysId from MapDonation where DonationBasis1 = 'Muslim' and DonationBasis2 not in ('DP', 'EP', 'FW', 'Others') and DonationBasis3 = 'Chinese';
  insert into MapDonation_mm (FormulaId, MapDonationSysId)
  select 'MOSQ2016', MapDonationSysId from MapDonation where DonationBasis1 = 'Muslim' and DonationBasis3 = 'Chinese';
  insert into MapDonation_mm (FormulaId, MapDonationSysId)
  select 'YMF2016', MapDonationSysId from MapDonation where DonationBasis1 = 'Muslim' and DonationBasis3 = 'Chinese';
  
  insert into MapDonation_mm (FormulaId, MapDonationSysId)
  select 'EUCF2015', MapDonationSysId from MapDonation where DonationBasis1 = 'Muslim' and DonationBasis2 not in ('DP', 'EP', 'FW', 'Others') and DonationBasis3 = 'Eurasian';
  insert into MapDonation_mm (FormulaId, MapDonationSysId)
  select 'MOSQ2016', MapDonationSysId from MapDonation where DonationBasis1 = 'Muslim' and DonationBasis3 = 'Eurasian';
  insert into MapDonation_mm (FormulaId, MapDonationSysId)
  select 'YMF2016', MapDonationSysId from MapDonation where DonationBasis1 = 'Muslim' and DonationBasis3 = 'Eurasian';
  
  insert into MapDonation_mm (FormulaId, MapDonationSysId)
  select 'SIND2015', MapDonationSysId from MapDonation where DonationBasis1 = 'Muslim' and DonationBasis2 not in ('DP', 'FW', 'Others') and DonationBasis3 = 'Indian';
  insert into MapDonation_mm (FormulaId, MapDonationSysId)
  select 'MOSQ2016', MapDonationSysId from MapDonation where DonationBasis1 = 'Muslim' and DonationBasis3 = 'Indian';
  insert into MapDonation_mm (FormulaId, MapDonationSysId)
  select 'YMF2016', MapDonationSysId from MapDonation where DonationBasis1 = 'Muslim' and DonationBasis3 = 'Indian';
end if;

commit work;