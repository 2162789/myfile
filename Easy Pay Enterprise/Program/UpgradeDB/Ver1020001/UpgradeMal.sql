READ UpgradeDB\Ver1020001\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1020001, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;