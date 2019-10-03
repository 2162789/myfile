Read UpgradeDB\Ver1061003\AllScript.sql;
Read UpgradeDB\Ver1061003\HKScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1061003, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;