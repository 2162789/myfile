Read UpgradeDB\Ver1070303\AllScript.sql;
Read UpgradeDB\Ver1070303\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070303, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;