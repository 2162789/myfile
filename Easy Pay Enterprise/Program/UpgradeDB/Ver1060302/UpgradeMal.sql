READ UpgradeDB\Ver1060302\AllScript.sql;
READ UpgradeDB\Ver1060302\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060302, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;