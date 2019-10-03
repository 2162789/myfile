READ UpgradeDB\Ver1060301\AllScript.sql;
READ UpgradeDB\Ver1060301\HK_MPF.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060301, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;