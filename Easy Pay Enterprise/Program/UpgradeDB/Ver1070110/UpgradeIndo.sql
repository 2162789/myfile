Read UpgradeDB\Ver1070110\AllScript.sql;
Read UpgradeDB\Ver1070110\IDScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1070110, RegProperty1='1.0', RegProperty6 = '' WHERE subregistryid='DBVersion';
COMMIT WORK;