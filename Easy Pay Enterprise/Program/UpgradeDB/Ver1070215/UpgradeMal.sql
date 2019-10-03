Read UpgradeDB\Ver1070215\AllScript.sql;
Read UpgradeDB\Ver1070215\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070215, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;