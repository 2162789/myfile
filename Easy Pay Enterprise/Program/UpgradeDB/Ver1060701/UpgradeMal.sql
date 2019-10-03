READ UpgradeDB\Ver1060701\AllScript.sql;
READ UpgradeDB\Ver1060701\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060701, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;