Read UpgradeDB\Ver1061208\AllScript.sql;
Read UpgradeDB\Ver1061208\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061208, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;