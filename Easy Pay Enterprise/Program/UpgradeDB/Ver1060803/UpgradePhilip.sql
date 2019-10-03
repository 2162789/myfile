READ UpgradeDB\Ver1060803\AllScript.sql;
Update SubRegistry Set ShortStringAttr='SSSYr2014Jan'
Where RegistryId='PaySetupData' And SubRegistryId='SSSProgPolicyId';

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060803, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;