Read UpgradeDB\Ver1070531\AllScript.sql;
Read UpgradeDB\Ver1070531\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070531, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;