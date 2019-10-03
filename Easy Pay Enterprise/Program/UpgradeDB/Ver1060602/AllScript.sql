READ UpgradeDB\Ver1060602\Entity.sql;
READ UpgradeDB\Ver1060602\StoredProc.sql;

/* Table Keyword */
if not exists(select * from keyword where keywordid = 'CR_GNDeptAllowance') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_GNDeptAllowance','Pay','Pay Element Record Report By Department','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Pay Element Record Report By Department');
end if;

if not exists(select * from keyword where keywordid = 'CR_GNDetailAllowance') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_GNDetailAllowance','Pay','Pay Element Record Report By Detail','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Pay Element Record Report By Detail');
end if;

if not exists(select * from keyword where keywordid = 'CR_GNBnkCsh') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_GNBnkCsh','Pay','Bank/Cash Listing','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Bank/Cash Listing Report');
end if;

if not exists(select * from keyword where keywordid = 'CR_GNBnkCshWOBasis') then
   insert into keyword (KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,
                       KeyWordFormulaSelection,KeyWordRangeSelection,KeyWordDesc )
   values('CR_GNBnkCshWOBasis','Pay','Bank/Cash Listing Without Basis and Beneficiary','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Bank/Cash Listing Report Without Basis and Beneficiary')
end if;

/* Table ModuleScreenGroup */
if not exists(SELECT * FROM ModuleScreenGroup where ModuleScreenId = 'PayCRCustom') then
   insert into ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
   values('PayCRCustom','PayReports','Customized Crystal Reports','Pay',0,0,0,'');
end if;

if not exists(SELECT * FROM ModuleScreenGroup where ModuleScreenId = 'PayCRCustomMgr') then
   insert into ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
   values('PayCRCustomMgr','PaySetup','Managed Customized Crystal Reports','Pay',0,0,0,'');
end if;

if not exists(SELECT * FROM ModuleScreenGroup where ModuleScreenId = 'LvCRCustom') then
   insert into ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
   values('LvCRCustom','LeaveReports','Customized Crystal Reports','Leave',0,0,0,'');
end if;

if not exists(SELECT * FROM ModuleScreenGroup where ModuleScreenId = 'LvCRCustomMgr') then
   insert into ModuleScreenGroup (ModuleScreenId, Mod_ModuleScreenId, ModuleScreenName, MainModuleName, HideOnlyWage, HideScreenForWage, IsEPClassic, EC_ModuleScreenId)
   values('LvCRCustomMgr','LeaveSetup','Managed Customized Crystal Reports','Leave',0,0,0,'');
end if;

commit work;