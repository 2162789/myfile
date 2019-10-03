READ UpgradeDB\Ver1060401\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060401, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;