Read UpgradeDB\Ver1070107\AllScript.sql;
Read UpgradeDB\Ver1070107\THScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070107, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;