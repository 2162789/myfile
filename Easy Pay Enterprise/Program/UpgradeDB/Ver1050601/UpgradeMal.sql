READ UpgradeDB\Ver1050601\Entity.sql;
READ UpgradeDB\Ver1050601\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050601, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;