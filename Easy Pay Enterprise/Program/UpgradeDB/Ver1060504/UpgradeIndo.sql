READ UpgradeDB\Ver1060504\AllScript.sql;
READ UpgradeDB\Ver1060504\IDScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060504, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;