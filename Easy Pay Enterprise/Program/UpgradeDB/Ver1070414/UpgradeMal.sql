Read UpgradeDB\Ver1070414\AllScript.sql;
Read UpgradeDB\Ver1070414\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070414, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;