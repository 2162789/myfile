READ UpgradeDB\Ver1060902\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060902, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;