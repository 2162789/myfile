Read UpgradeDB\Ver1061204\AllScript.sql;
Read UpgradeDB\Ver1061204\IDScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061204, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;