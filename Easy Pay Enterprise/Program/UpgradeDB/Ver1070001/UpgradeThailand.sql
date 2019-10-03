Read UpgradeDB\Ver1070001\AllScript.sql;
Read UpgradeDB\Ver1070001\THScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070001, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;