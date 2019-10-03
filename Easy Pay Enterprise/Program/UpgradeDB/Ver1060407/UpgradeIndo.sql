READ UpgradeDB\Ver1060407\AllScript.sql;
READ UpgradeDB\Ver1060407\IDScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060407, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;