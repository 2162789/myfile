READ UpgradeDB\Ver1060204\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr= 1060204, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;