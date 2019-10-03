Read UpgradeDB\Ver1061006\AllScript.sql;
Read UpgradeDB\Ver1061006\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061006, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;