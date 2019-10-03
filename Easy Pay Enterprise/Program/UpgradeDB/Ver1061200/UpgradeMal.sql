Read UpgradeDB\Ver1061200\MYScript.sql;
UPDATE "DBA"."subRegistry" SET IntegerAttr=1061200, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;