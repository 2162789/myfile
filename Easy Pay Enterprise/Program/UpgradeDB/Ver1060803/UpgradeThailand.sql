READ UpgradeDB\Ver1060803\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060803, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;