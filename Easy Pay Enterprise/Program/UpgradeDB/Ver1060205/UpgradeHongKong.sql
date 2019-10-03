READ UpgradeDB\Ver1060205\AllScript.sql;

Update SubRegistry set RegProperty4='N' where SubRegistryId='MPFVoluntaryPolicyId';

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060205, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;