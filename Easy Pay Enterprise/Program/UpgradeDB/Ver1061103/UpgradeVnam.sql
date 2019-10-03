Read UpgradeDB\Ver1061103\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061103, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;