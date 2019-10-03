Read UpgradeDB\Ver1050804\Entity.sql;
Read UpgradeDB\Ver1050804\AllScript.sql;
Read UpgradeDB\Ver1050804\SGScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050804, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;