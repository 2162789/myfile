READ UpgradeDB\Ver1060706\AllScript.sql;
READ UpgradeDB\Ver1060706\THSSL_2013Jan.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060706, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;