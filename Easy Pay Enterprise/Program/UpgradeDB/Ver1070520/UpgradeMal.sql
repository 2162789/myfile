Read UpgradeDB\Ver1070520\AllScript.sql;
Read UpgradeDB\Ver1070520\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070520, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;