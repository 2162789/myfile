Read UpgradeDB\Ver1061206\AllScript.sql;
Read UpgradeDB\Ver1061206\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061206, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;