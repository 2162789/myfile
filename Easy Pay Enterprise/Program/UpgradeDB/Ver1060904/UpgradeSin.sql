READ UpgradeDB\Ver1060904\AllScript.sql;
READ UpgradeDB\Ver1060904\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060904, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;