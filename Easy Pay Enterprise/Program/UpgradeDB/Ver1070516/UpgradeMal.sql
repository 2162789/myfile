Read UpgradeDB\Ver1070516\AllScript.sql;
Read UpgradeDB\Ver1070516\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070516, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;