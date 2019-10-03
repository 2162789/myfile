READ UpgradeDB\Ver1060200\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060200, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;