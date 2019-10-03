Read UpgradeDB\Ver1070614\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070614, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;