Read UpgradeDB\Ver1050807\AllScript.sql;
Read UpgradeDB\Ver1050807\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050807, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;