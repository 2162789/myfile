if not exists (select * from UsageItem where UsageItemID= 'SerialNo') then
Insert INTO UsageItem
(UsageItemID,UsageGrpID,ItemDesc,ItemKey1Desc,ItemKey2Desc,ItemKey3Desc,FieldLoc,Query,QueryCond)
VALUES('SerialNo','License','Serial No.','','','','StringValue','SELECT '''' AS Key1, '''' AS Key2, '''' AS Key3, NULL AS ModDateTime, SubSerialNo AS RetValue FROM LicenseRecord;','');
end if;

if not exists (select * from UsageItem where UsageItemID= 'CompanyName') then
Insert INTO UsageItem
(UsageItemID,UsageGrpID,ItemDesc,ItemKey1Desc,ItemKey2Desc,ItemKey3Desc,FieldLoc,Query,QueryCond)
VALUES('CompanyName','License','Company Name','','','','StringValue','SELECT '''' AS Key1, '''' AS Key2, '''' AS Key3, NULL AS ModDateTime, SubCompanyName AS RetValue FROM LicenseRecord;','');
end if;

commit work;