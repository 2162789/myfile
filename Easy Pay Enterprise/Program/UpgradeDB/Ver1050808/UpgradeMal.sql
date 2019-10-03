Read UpgradeDB\Ver1050808\AllScript.sql;
Read UpgradeDB\Ver1050808\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050808, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;