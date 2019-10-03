Read UpgradeDB\Ver1070407\AllScript.sql;
Read UpgradeDB\Ver1070407\IDScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070407, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;