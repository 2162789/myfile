Read UpgradeDB\Ver1061202\AllScript.sql;
Read UpgradeDB\Ver1061202\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061202, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;