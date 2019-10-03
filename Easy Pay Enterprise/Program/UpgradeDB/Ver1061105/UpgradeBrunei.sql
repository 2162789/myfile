Read UpgradeDB\Ver1061105\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061105, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;