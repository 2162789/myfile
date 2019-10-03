READ UpgradeDB\Ver1060502\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060502, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;