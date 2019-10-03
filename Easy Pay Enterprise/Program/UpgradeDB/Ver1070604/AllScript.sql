Read UpgradeDB\Ver1070604\StoredProc.sql;

if not exists(select * from SubRegistry where RegistryId = 'ESS' and SubRegistryId = 'ESSTrigger') then
   insert into SubRegistry(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,
                                  RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('ESS','ESSTrigger','','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;


commit work;