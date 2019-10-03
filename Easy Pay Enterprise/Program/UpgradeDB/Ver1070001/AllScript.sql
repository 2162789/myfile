Read UpgradeDB\Ver1070001\Entity.sql;

/* Leave Entitlement Report */
Update ModuleScreenGroup Set HideOnlyWage = 1 Where ModuleScreenId = 'LvEntRpt';

/* HDMF */
if exists (select 1 from sys.syscolumns where tname = 'HDMFP2_4UseCodeMapping' and cname = 'EPECessationCodeII') then
  alter table HDMFP2_4UseCodeMapping rename EPECessationCodeII to EPECessationCode;
end if;

/* Loan Setup */
Update ModuleScreenGroup Set Mod_ModuleScreenId = 'PayModules' Where ModuleScreenId = 'PayLoanSetup';

commit work;