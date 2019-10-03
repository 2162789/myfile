READ UpgradeDB\Ver1060101\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060101, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;