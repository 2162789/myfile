READ UpgradeDB\Ver1060501\AllScript.sql;
READ UpgradeDB\Ver1060501\PHIC2013Jan.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060501, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;