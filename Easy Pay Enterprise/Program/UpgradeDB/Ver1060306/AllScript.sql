READ UpgradeDB\Ver1060306\AlchemexView.sql;
READ UpgradeDB\Ver1060306\StoredProc.sql;
READ UpgradeDB\Ver1060306\Keyword.sql;

If not exists(select * from subregistry where registryid = 'Application' and subregistryid = 'TaskReminder') then
   insert into subregistry values('Application','TaskReminder','CoreTaskReminder','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'CoreAlchemexReports') then  
   INSERT INTO ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic) VALUES('CoreAlchemexReports','Core','Management Reports','Core',0,1,0);
end if;

if not exists(select * from ModuleScreenGroup where ModuleScreenId  = 'CoreAlchemexAdmin') then
   INSERT INTO ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic) VALUES('CoreAlchemexAdmin','CoreAlchemexReports','Administrator Tool','Core',0,1,0);
end if;

if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'CoreAlchemexRptMgr') then
   INSERT INTO ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic) VALUES('CoreAlchemexRptMgr','CoreAlchemexReports','Report Manager','Core',0,1,0);
end if;

if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'CoreAlchemexViewer') then
   INSERT INTO ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic) VALUES('CoreAlchemexViewer','CoreAlchemexReports','Report Viewer','Core',0,1,0);
end if;

commit work;