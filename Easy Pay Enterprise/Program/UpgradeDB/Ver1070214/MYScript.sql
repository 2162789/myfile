if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'MalTaxDetailsViewer') then
  insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values('MalTaxDetailsViewer','InterfaceViewer','Income Tax Details Viewer','InterfaceViewer',0,0,0,'');
end if;

commit work;