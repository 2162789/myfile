Read UpgradeDB\Ver1061007\AllScript.sql;
Read UpgradeDB\Ver1061007\IDScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061007, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;