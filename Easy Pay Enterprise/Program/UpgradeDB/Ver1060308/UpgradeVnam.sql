READ UpgradeDB\Ver1060308\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060308, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;