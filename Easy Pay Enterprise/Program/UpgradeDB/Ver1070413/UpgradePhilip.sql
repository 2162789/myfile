Read UpgradeDB\Ver1070413\AllScript.sql;
Read UpgradeDB\Ver1070413\PHScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070413, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;