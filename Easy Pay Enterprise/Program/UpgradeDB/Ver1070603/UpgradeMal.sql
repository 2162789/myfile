Read UpgradeDB\Ver1070603\AllScript.sql;
Read UpgradeDB\Ver1070603\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070603, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;