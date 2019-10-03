READ UpgradeDB\Ver1060600\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060600, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;