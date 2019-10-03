Read UpgradeDB\Ver1070306\AllScript.sql;
Read UpgradeDB\Ver1070306\ID_BPJSPens2018Mar.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070306, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;