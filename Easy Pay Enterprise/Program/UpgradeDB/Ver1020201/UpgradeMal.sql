READ UpgradeDB\Ver1020201\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1020201, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;