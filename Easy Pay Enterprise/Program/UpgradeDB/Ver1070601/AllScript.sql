READ UpgradeDB\Ver1070601\Entity.sql;

-- ModuleScreen --
if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'LeaveESS') then
  insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values('LeaveESS','Leave','ESS','ESS',0,0,0,'');
end if;

if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'LvESSConnection') then
  insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values('LvESSConnection','LeaveESS','ESS Connection','Leave',0,0,0,'');
end if;

if not exists(select * from ModuleScreenGroup where ModuleScreenId = 'LvESSDashboard') then
  insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values('LvESSDashboard','LeaveESS','ESS Dashboard','Leave',0,0,0,'');
end if;

-- Registry --
if not exists(select * from Registry where RegistryId = 'ESS') then
   insert into Registry(RegistryId,RegistryDesc) Values('ESS', 'ESS');
end if;

-- SubRegisty --
if not exists(select * from SubRegistry where RegistryId = 'ESS' and SubRegistryId = 'ESSConnection') then
   insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                                  RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('ESS','ESSConnection','','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'ESS' and SubRegistryId = 'SendEmployee') then
   insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                                  RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('ESS','SendEmployee','ESSSyncOption','Send Employee Changes','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'ESS' and SubRegistryId = 'SendLveBalance') then
   insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                                  RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('ESS','SendLveBalance','ESSSyncOption','Send Leave Balance','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'ESS' and SubRegistryId = 'SendPayslip') then
   insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                                  RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('ESS','SendPayslip','ESSSyncOption','Send Payslips','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'ESS' and SubRegistryId = 'SendMaint') then
   insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                                  RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('ESS','SendMaint','ESSSyncOption','Send Maintenance','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from SubRegistry where RegistryId = 'ESS' and SubRegistryId = 'ImportLveApp') then
   insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                                  RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('ESS','ImportLveApp','ESSSyncOption','Import Leave Application','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

commit work;