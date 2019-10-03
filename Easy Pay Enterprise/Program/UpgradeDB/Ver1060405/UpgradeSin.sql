READ UpgradeDB\Ver1060405\SG_Holidays.sql;
UPDATE SubRegistry SET RegProperty1=14 Where RegistryId='SGSickHospProrate' and SubRegistryID= 'SGSickHosp2000P12';

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060405, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;