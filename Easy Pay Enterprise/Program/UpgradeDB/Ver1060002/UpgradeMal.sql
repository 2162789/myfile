READ UpgradeDB\Ver1060002\AllScript.sql;
READ UpgradeDB\Ver1060002\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060002, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;