// Correct Rabate Setup for 2018
if exists(select 1 from sys.sysprocedure where proc_name = 'PatchMalaysiaTaxPolicy1') then
   drop PROCEDURE PatchMalaysiaTaxPolicy1
end if;

CREATE PROCEDURE "DBA"."PatchMalaysiaTaxPolicy1"()
begin
  declare In_MalTaxPolicyProgSysId integer;
 
  /* Check for Malaysia DB */
  if FGetDBCountry(*) <> 'Malaysia' then
    return;
  end if;


  /* Check Tax Policy */
  if not exists(select * from MalTaxPolicy where MalTaxPolicyId = 'DefaultPolicy') then 
    return;
  end if;

  /* Check for Tax Policy Progression */
  if exists(select * from MalTaxPolicyProg where MalTaxPolicyEffDate = '2018-01-01' and MalTaxPolicyId = 'DefaultPolicy') then
    select MalTaxPolicyProgSysId into In_MalTaxPolicyProgSysId from MalTaxPolicyProg where MalTaxPolicyEffDate = '2018-01-01' and MalTaxPolicyId = 'DefaultPolicy';
    delete from RebateSetup where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId and RebateID = 'Books';
    delete from RebateSetup where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId and RebateID = 'Computer';
    delete from RebateSetup where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId and RebateID = 'Sports Equip';

    if not exists(select * from RebateSetup where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId and RebateID = 'Perquisites') then
      insert into RebateSetup values(In_MalTaxPolicyProgSysId,'Perquisites',0,1,0);
    end if;
    if not exists(select * from RebateSetup where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId and RebateID = 'Lifestyle Relief') then
      insert into RebateSetup values(In_MalTaxPolicyProgSysId,'Lifestyle Relief',2500,1,0);
    end if;
    if not exists(select * from RebateSetup where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId and RebateID = 'BreastFeedingEquip') then
      insert into RebateSetup values(In_MalTaxPolicyProgSysId,'BreastFeedingEquip',1000,2,1);
    end if;
    if not exists(select * from RebateSetup where MalTaxPolicyProgSysId = In_MalTaxPolicyProgSysId and RebateID = 'Kindergartens Fee') then
      insert into RebateSetup values(In_MalTaxPolicyProgSysId,'Kindergartens Fee',1000,1,0);
    end if;
  end if;

  commit work;

end;

call dba.PatchMalaysiaTaxPolicy1();
drop procedure dba.PatchMalaysiaTaxPolicy1;

if exists (select * from SubRegistry where RegistryId = 'PaySetupData' and SubRegistryId = 'EPFProgSchemeId' and ShortStringAttr = 'EPFManVol' and BooleanAttr = 0) then
  update CPFTableCode set CPFSchemeId = 'EPFManVol' from (
    select replace(CPFTableCodeId, '16', '18') as EPFTableCodeId from CPFTableCode
    where CPFTableCodeId in ('EP16ST', 'EP16PR', 'EP16EX') and CPFSchemeId = 'EPFManVol') a
    where CPFTableCodeId = a.EPFTableCodeId;
  update Formula set FormulaType = a.FType from (
    select replace(f.FormulaId, '16', '18') as FId, f.FormulaType as FType from Formula f
    join CPFTableComponent ctc on f.FormulaId in (ctc.EEOrdCPFFormula, ctc.EROrdCPFFormula, ctc.EEAddCPFFormula, ctc.ERAddCPFFormula)
    join CPFTableCode cc on ctc.CPFTableCodeId = cc.CPFTableCodeId
    where cc.CPFTableCodeId in ('EP16ST', 'EP16PR', 'EP16EX') and cc.CPFSchemeId = 'EPFManVol' and f.FormulaType not in ('T4', 'Adv') and f.FormulaId like 'EP16%A%$%E%') a
  where FormulaId = a.FId and FormulaType not in ('T4', 'Adv');
  update FormulaRange set Formula = a.Fm, UserDef1 = a.UDef1, UserDef2 = a.UDef2 from (
    select replace(fr.FormulaId, '16', '18') as FId, fr.Formula as Fm, fr.UserDef1 as UDef1, fr.UserDef2 as UDef2
    from FormulaRange fr join Formula f on fr.FormulaId = f.FormulaId
    join CPFTableComponent ctc on f.FormulaId in (ctc.EEOrdCPFFormula, ctc.EROrdCPFFormula, ctc.EEAddCPFFormula, ctc.ERAddCPFFormula)
    join CPFTableCode cc on ctc.CPFTableCodeId = cc.CPFTableCodeId
    where cc.CPFTableCodeId in ('EP16ST', 'EP16PR', 'EP16EX') and cc.CPFSchemeId = 'EPFManVol' and f.FormulaType not in ('T4', 'Adv') and fr.FormulaId like 'EP16%A%$%E%') a
  where FormulaId = a.FId and (select FormulaType from Formula where FormulaId = a.FId) not in ('T4', 'Adv');
end if;
update SubRegistry set BooleanAttr = 0 where RegistryId = 'PaySetupData' and SubRegistryId = 'EPFProgSchemeId' and BooleanAttr = 1;

commit work;