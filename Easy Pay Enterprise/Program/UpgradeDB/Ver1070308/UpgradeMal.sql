Read UpgradeDB\Ver1070308\AllScript.sql;
Read UpgradeDB\Ver1070308\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070308, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;