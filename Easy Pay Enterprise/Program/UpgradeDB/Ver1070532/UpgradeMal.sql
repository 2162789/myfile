Read UpgradeDB\Ver1070532\AllScript.sql;
Read UpgradeDB\Ver1070532\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070532, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;