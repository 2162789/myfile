Read UpgradeDB\Ver1050806\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050806, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;