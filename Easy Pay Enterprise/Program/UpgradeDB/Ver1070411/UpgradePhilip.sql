Read UpgradeDB\Ver1070411\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070411, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;