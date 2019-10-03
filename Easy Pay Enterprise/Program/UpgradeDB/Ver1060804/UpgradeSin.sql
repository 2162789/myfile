READ UpgradeDB\Ver1060804\AllScript.sql;
READ UpgradeDB\Ver1060804\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060804, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;