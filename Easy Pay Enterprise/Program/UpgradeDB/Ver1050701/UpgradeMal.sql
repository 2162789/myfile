Read UpgradeDB\Ver1050701\AllScript.sql;
Read UpgradeDB\Ver1050701\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050701, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;