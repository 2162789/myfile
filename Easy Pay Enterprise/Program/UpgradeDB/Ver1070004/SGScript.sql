IF NOT EXISTS (select * from SubRegistry WHERE SubRegistryId='SGPaternity2017') THEN
  insert into SubRegistry 
(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('SGPaternityPolicy','SGPaternity2017','0','2','3','0','','','','','','',0.0,0,'',0,'','','2017-01-01','1899-12-30 00:00:00.000');
end if;

commit work;