READ UpgradeDB\Ver1050501\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050501, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;