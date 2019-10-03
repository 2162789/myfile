READ UpgradeDB\Ver1020207\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1020207, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;