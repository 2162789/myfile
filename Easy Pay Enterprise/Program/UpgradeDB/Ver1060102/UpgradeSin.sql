Update SubRegistry Set ShortStringAttr='Year2012Jan' Where RegistryId='PaySetupData' and SubRegistryId='CPFProgPolicyId';
READ UpgradeDB\Ver1060102\AllScript.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060102, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;