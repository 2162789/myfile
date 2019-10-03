Read UpgradeDB\Ver1070620\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070620, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;