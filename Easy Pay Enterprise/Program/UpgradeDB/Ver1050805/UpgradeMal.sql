Read UpgradeDB\Ver1050805\AllScript.sql;
Read UpgradeDB\Ver1050805\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050805, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;