if not exists (select * from UsageItem where UsageItemID= 'PartnerName') then
Insert INTO UsageItem
(UsageItemID,UsageGrpID,ItemDesc,ItemKey1Desc,ItemKey2Desc,ItemKey3Desc,FieldLoc,Query,QueryCond)
VALUES('PartnerName','License','Partner Name','','','','StringValue','SELECT '''' AS Key1, '''' AS Key2, '''' AS Key3, NULL AS ModDateTime, CompanyName AS RetValue FROM LicenseRecord;','');
end if;

if not exists (select * from UsageItem where UsageItemID= 'LicenseGenerateDate') then
Insert INTO UsageItem
(UsageItemID,UsageGrpID,ItemDesc,ItemKey1Desc,ItemKey2Desc,ItemKey3Desc,FieldLoc,Query,QueryCond)
VALUES('LicenseGenerateDate','License','License Generated Date','','','','DateValue','SELECT '''' AS Key1, '''' AS Key2, '''' AS Key3, NULL AS ModDateTime, GenerateDate AS RetValue FROM LicenseRecord;','');
end if;

commit work;