Read UpgradeDB\Ver1070302\AllScript.sql;
Read UpgradeDB\Ver1070302\PH_Tax2018Jan.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070302, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;