READ UpgradeDB\Ver1050811\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050811, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;