READ UpgradeDB\Ver1060003\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060003, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;