/* MOM Shared Paternity and Adoption with effective July 2017*/
IF NOT EXISTS (select * from SubRegistry WHERE SubRegistryId='SGSharedParental2017') THEN
  insert into SubRegistry 
(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('SGSharedParentPolicy','SGSharedParental2017','0','4','3','','','','','','','',0,0,'',0,'','','2017-07-01','1899-12-30 00:00:00');
end if;

IF NOT EXISTS (select * from SubRegistry WHERE SubRegistryId='SGAdoption2017') THEN
  insert into SubRegistry 
(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('SGAdoptionPolicy','SGAdoption2017','0','12','3','','','','','','','',0,0,'',0,'','','2017-07-01','1899-12-30 00:00:00');
end if;

commit work;