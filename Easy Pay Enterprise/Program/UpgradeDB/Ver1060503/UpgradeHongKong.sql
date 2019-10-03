READ UpgradeDB\Ver1060503\HKScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060503, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;