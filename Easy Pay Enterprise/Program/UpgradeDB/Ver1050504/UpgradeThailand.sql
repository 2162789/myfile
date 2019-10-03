READ UpgradeDB\Ver1050504\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050504, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;