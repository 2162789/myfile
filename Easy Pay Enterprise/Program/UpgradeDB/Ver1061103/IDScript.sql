/* Pay Detail Default to only show corresponding policy */
Update SubRegistry Set RegProperty7 = 'Select * from CPFPolicy where CPFPolicyId in (select CPFPolicyId from CPFPolicyMember m Join CPFTableCode c on m.CPFTableCodeId = c.CPFTableCodeId and c.CPFSchemeId = ''BPJSTK'');'
Where RegistryId='PaySetupData' and SubRegistryId='CPFProgPolicyId';

Update SubRegistry Set RegProperty7 = 'Select * from CPFPolicy where CPFPolicyId in (select CPFPolicyId from CPFPolicyMember m Join CPFTableCode c on m.CPFTableCodeId = c.CPFTableCodeId and c.CPFSchemeId = ''BPJSKesehatan'');'
Where RegistryId='PaySetupData' and SubRegistryId='BPJSKSProgPolicyId';

Update SubRegistry Set RegProperty7 = 'Select * from CPFPolicy where CPFPolicyId in (select CPFPolicyId from CPFPolicyMember m Join CPFTableCode c on m.CPFTableCodeId = c.CPFTableCodeId and c.CPFSchemeId = ''BPJSPensiun'');'
Where RegistryId='PaySetupData' and SubRegistryId='BPJSPensProgPolicyId';

/* BPJSTK submission Report */
Update Subregistry Set RegProperty3 = '', RegProperty10 = '' Where registryid = 'JamsostekReport' and subregistryid = 'JamRepSum';

/* ModuleScreen Group */
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'PayCPFGovtRpt') then
  insert into ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
  values ('PayCPFGovtRpt','PayCPFSetupRpts','Statutory Government Report','Pay',0,0,0,'')
end if;

if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'PayCPFGovtSetup') then
  insert into ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
  values ('PayCPFGovtSetup','PayCPFSetup','Statutory Government Setup','Pay',0,0,0,'')
end if;

commit work;