READ UpgradeDB\Ver1060004\AllScript.sql;
READ UpgradeDB\Ver1060004\BR_Holidays.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060004, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;