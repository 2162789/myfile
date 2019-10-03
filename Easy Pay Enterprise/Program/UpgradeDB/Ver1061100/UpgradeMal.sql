Read UpgradeDB\Ver1061100\AllScript.sql;
Read UpgradeDB\Ver1061100\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061100, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;