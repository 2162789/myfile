READ UpgradeDB\Ver1060005\AllScript.sql;
READ UpgradeDB\Ver1060005\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060005, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;