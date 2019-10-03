if not exists (select * from UsageItem where UsageItemID= 'NSSubmitCount') then
Insert INTO UsageItem
(UsageItemID,UsageGrpID,ItemDesc,ItemKey1Desc,ItemKey2Desc,ItemKey3Desc,FieldLoc,Query,QueryCond)
VALUES('NSSubmitCount','StatSubmit','NS Report Generation  Count','Caption NS Report','','','IntegerValue','SELECT ItemRefKey1 AS Key1, ItemRefKey2 AS Key2, ItemRefKey3 AS Key3, ModifyDateTime AS ModDateTime, IntegerValue AS RetValue FROM UsageItemRecord ','WHERE UsageItemID=''NSSubmitCount'' AND IntegerValue>0;');
end if;

commit work;