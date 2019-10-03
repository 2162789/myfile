Read UpgradeDB\Ver1070517\AllScript.sql;
Read UpgradeDB\Ver1070517\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070517, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;