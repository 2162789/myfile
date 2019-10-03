if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'PayTP1') then
  insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('PayTP1','PayMalGovForm','TP1','Pay',0,1,0,'');
end if;

commit work;