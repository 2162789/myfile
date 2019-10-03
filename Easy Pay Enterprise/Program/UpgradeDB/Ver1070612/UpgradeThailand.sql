Read UpgradeDB\Ver1070612\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070612, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;