Read UpgradeDB\Ver1070418\AllScript.sql;
Read UpgradeDB\Ver1070418\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070418, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;