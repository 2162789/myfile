Read UpgradeDB\Ver1061008\AllScript.sql;
Read UpgradeDB\Ver1061008\IDScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061008, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;