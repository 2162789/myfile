Read UpgradeDB\Ver1050801\Entity.sql;
Read UpgradeDB\Ver1050801\AllScript.sql;
Read UpgradeDB\Ver1050801\HKScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050801, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;