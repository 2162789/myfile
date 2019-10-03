Read UpgradeDB\Ver1070206\AllScript.sql;
Read UpgradeDB\Ver1070206\PHScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070206, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;