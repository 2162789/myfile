READ UpgradeDB\Ver1060806\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060806, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;