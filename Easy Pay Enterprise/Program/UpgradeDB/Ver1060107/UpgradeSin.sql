READ UpgradeDB\Ver1060107\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060107, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;