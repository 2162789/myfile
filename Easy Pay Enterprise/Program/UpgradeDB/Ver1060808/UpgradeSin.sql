READ UpgradeDB\Ver1060808\AllScript.sql;
READ UpgradeDB\Ver1060808\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060808, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;