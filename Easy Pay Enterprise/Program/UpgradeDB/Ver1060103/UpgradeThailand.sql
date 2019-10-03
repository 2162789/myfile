READ UpgradeDB\Ver1060103\AllScript.sql;
READ UpgradeDB\Ver1060103\THScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060103, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;