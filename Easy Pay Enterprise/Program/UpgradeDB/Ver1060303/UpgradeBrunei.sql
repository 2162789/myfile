READ UpgradeDB\Ver1060303\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060303, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;