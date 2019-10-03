READ UpgradeDB\Ver1060805\AllScript.sql;
READ UpgradeDB\Ver1060805\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060805, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;