Read UpgradeDB\Ver1070543\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070543, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;