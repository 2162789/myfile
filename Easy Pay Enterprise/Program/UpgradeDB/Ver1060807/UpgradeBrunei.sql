READ UpgradeDB\Ver1060807\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060807, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;