READ UpgradeDB\Ver1060603\AllScript.sql;
READ UpgradeDB\Ver1060603\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060603, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;