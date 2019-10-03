Read UpgradeDB\Ver1070307\AllScript.sql;
Read UpgradeDB\Ver1070307\HKScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070307, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;
