Read UpgradeDB\Ver1070201\AllScript.sql;
Read UpgradeDB\Ver1070201\PHScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070201, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;