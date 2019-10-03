READ UpgradeDB\Ver1030106\SG_Script.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1030106, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;