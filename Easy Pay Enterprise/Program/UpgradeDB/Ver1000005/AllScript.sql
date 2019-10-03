UPDATE ModuleScreenGroup SET EC_ModuleScreenId = 'EC_EECodeSetup' WHERE ModuleScreenId = 'CoreCodeSetup';
UPDATE ModuleScreenGroup SET EC_ModuleScreenId = 'EC_WTProfile' WHERE ModuleScreenId = 'LvWTProfile';

UPDATE ModuleScreenGroup SET Mod_ModuleScreenId = 'EPClassic' WHERE ModuleScreenId IN ('EC_Company','EC_Employee','EC_Pay','EC_Leave','EC_System');

COMMIT WORK;

if (IsEPClassicDB()=1) then
  update SubRegistry
  set RegProperty1 = 'Easy Pay Classic'
  where RegistryId = 'System' and SubRegistryId = 'ProductName';
  update SubRegistry set BooleanAttr = 1 where RegistryId = 'PaySetupDataLv';
  call DeletePayGroupGrp('3 Payment Group');
  call DeletePayGroupGrp('4 Payment Group');
else
  update SubRegistry
  set RegProperty1 = 'Easy Pay Enterprise'
  where RegistryId = 'System' and SubRegistryId = 'ProductName';

end if;

COMMIT WORK;

