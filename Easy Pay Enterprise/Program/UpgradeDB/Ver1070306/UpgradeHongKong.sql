Read UpgradeDB\Ver1070306\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070306, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;