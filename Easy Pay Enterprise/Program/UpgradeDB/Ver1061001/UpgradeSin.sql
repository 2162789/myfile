Read UpgradeDB\Ver1061001\AllScript.sql;
Read UpgradeDB\Ver1061001\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061001, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;