READ UpgradeDB\Ver1060502\AllScript.sql;
READ UpgradeDB\Ver1060502\SGMomLeave.sql;

Update SubRegistry set RegProperty2='2' where SubRegistryId='SGChildCare2000P1';

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060502, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;