IF NOT EXISTS (select * from SubRegistry WHERE SubRegistryId='SGMaternity2017') THEN
  insert into SubRegistry 
(RegistryId,SubRegistryId,RegProperty1,RegProperty2,RegProperty3,RegProperty4,RegProperty5,RegProperty6,RegProperty7,RegProperty8,RegProperty9,RegProperty10,DoubleAttr,IntegerAttr,CharAttr,BooleanAttr,ShortStringAttr,StringAttr,DateAttr,DateTimeAttr)
   values('SGMaternityPolicy','SGMaternity2017','16','12','90','','','','','','','',0,0,'',1,'','','2017-01-01','1899-12-30 00:00:00');
end if;

UPDATE SubRegistry SET BooleanAttr=0 WHERE  SubRegistryId='SGMaternity2000';

if not exists(SELECT * FROM YEKeyWord WHERE YEKeywordCategory = 'SubmitUserIDType' and YEKeywordID='NRIC') then
insert into YEKeyWord (YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1)
Values('NRIC','NRIC','NRIC','SubmitUserIDType','NRIC','1');
end if;

if not exists(SELECT * FROM YEKeyWord WHERE YEKeywordCategory = 'SubmitUserIDType' and YEKeywordID='FIN') then
insert into YEKeyWord (YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1)
Values('FIN','FIN','FIN','SubmitUserIDType','FIN','2');
end if;

if not exists(SELECT * FROM YEKeyWord WHERE YEKeywordCategory = 'SubmitUserIDType' and YEKeywordID='WP') then
insert into YEKeyWord (YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1)
Values('WP','WP','WP','SubmitUserIDType','WP','4');
end if;

if not exists(SELECT * FROM YEKeyWord WHERE YEKeywordCategory = 'SubmitUserIDType' and YEKeywordID='ASGD1') then
insert into YEKeyWord (YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1)
Values('ASGD1','ASGD','ASGD','SubmitUserIDType','ASGD','A');
end if;

if not exists(SELECT * FROM YEKeyWord WHERE YEKeywordCategory = 'SubmitUserIDType' and YEKeywordID='MIC') then
insert into YEKeyWord (YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1)
Values('MIC','MIC','MIC','SubmitUserIDType','MIC','11');
end if;

commit work;