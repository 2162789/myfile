READ UpgradeDB\Ver1060601\Entity.sql;
READ UpgradeDB\Ver1060601\keywordAll.sql;
READ UpgradeDB\Ver1060601\ExpDesignJobCodeInfo.sql;

if not exists(select * from USAGEITEM where USAGEITEMID = 'ProductFeaturesSysID') then 
INSERT INTO USAGEITEM(USAGEITEMID,USAGEGRPID,ITEMDESC,ITEMKEY1DESC,ITEMKEY2DESC,ITEMKEY3DESC,FIELDLOC,QUERY,QUERYCOND)
            VALUES('ProductFeaturesSysID','System','ProductFeaturesSysID','ProductFeaturesSysID','','','IntegerValue','SELECT  TOP 1 '''' AS Key1,'''' AS Key2,''''AS key3,NULL AS ModDateTime,ProductFeaturesSysID AS RetValue FROM PRODUCTFEATURES ORDER BY ProductFeaturesSysID DESC','');
end if;

Update SubRegistry set RegProperty1 = 'Sage EasyPay Enterprise'
Where RegistryId = 'System' And SubRegistryId = 'ProductName';

commit work;