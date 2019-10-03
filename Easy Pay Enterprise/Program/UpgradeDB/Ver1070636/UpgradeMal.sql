Read UpgradeDB\Ver1070636\AllScript.sql;
Read UpgradeDB\Ver1070636\MYScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070636, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;