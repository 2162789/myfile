/* default CPFGovernmentProgression */
if not exists(select * from CPFGovernmentProgression where CPFGovtEffectiveDate = '2004-01-01' and CPFGovtSchemeId = 'BPJSTK') then
   insert into CPFGovernmentProgression(CPFGovtEffectiveDate,CPFGovtSchemeId,CPFGovtPolicyId,CPFGovtCurrent,CPFGovtRemarks)
   values('2004-01-01','BPJSTK','BPJS-TKGrp3-2004Jan',1,'');
end if;

if not exists(select * from CPFGovernmentProgression where CPFGovtEffectiveDate = '2014-01-01' and CPFGovtSchemeId = 'BPJSKesehatan') then
   insert into CPFGovernmentProgression(CPFGovtEffectiveDate,CPFGovtSchemeId,CPFGovtPolicyId,CPFGovtCurrent,CPFGovtRemarks)
   values('2014-01-01','BPJSKesehatan','BPJS-Kes2014Jan',1,'');
end if;

if not exists(select * from CPFGovernmentProgression where CPFGovtEffectiveDate = '2015-07-01' and CPFGovtSchemeId = 'BPJSKesehatan') then
   insert into CPFGovernmentProgression(CPFGovtEffectiveDate,CPFGovtSchemeId,CPFGovtPolicyId,CPFGovtCurrent,CPFGovtRemarks)
   values('2015-07-01','BPJSKesehatan','BPJS-Kes2015Jul',1,'');
end if;

if not exists(select * from CPFGovernmentProgression where CPFGovtEffectiveDate = '2015-07-01' and CPFGovtSchemeId = 'BPJSPensiun') then
   insert into CPFGovernmentProgression(CPFGovtEffectiveDate,CPFGovtSchemeId,CPFGovtPolicyId,CPFGovtCurrent,CPFGovtRemarks)
   values('2015-07-01','BPJSPensiun','BPJS-Pensiun2015Jul',1,'');
end if;

/* ModuleScreenGroup */
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'PayBPJSTKSIPPOnline') then
  insert into ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
  values ('PayBPJSTKSIPPOnline','PayCPFSubmissRpts','SIPP Online Upload','Pay',0,0,0,'')
end if;

/* SubRegistry */
if not exists(select * from SubRegistry where RegistryId = 'JamsostekReport' and SubRegistryId = 'SIPPUbahTK') then
  Insert into SubRegistry (RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,
                           DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
  Values('JamsostekReport','SIPPUbahTK','','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

commit work;