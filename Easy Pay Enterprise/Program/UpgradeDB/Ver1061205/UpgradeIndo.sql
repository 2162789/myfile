Read UpgradeDB\Ver1061205\AllScript.sql;
Read UpgradeDB\Ver1061205\IDScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061205, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;