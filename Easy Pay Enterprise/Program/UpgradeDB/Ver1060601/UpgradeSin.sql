READ UpgradeDB\Ver1060601\AllScript.sql;
READ UpgradeDB\Ver1060601\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060601, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;