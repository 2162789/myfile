Read UpgradeDB\Ver1070404\AllScript.sql;
Read UpgradeDB\Ver1070404\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070404, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;