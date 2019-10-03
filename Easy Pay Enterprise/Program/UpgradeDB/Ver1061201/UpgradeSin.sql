Read UpgradeDB\Ver1061201\AllScript.sql;
Read UpgradeDB\Ver1061201\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061201, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;