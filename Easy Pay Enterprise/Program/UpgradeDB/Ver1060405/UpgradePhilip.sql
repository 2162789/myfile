READ UpgradeDB\Ver1060405\PH_Holidays.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060405, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;