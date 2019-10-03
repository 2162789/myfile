Read UpgradeDB\Ver1070517\AllScript.sql;
Read UpgradeDB\Ver1070517\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070517, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;