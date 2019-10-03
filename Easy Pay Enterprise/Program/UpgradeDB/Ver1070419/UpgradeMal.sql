Read UpgradeDB\Ver1070419\AllScript.sql;
Read UpgradeDB\Ver1070419\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070419, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;