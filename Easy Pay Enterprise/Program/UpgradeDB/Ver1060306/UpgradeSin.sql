READ UpgradeDB\Ver1060306\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060306, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;