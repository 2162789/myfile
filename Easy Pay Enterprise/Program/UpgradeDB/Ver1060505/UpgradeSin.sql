Update subregistry set RegProperty2 = 5
where registryid = 'SGChildCareProrate' and Subregistryid = 'SGChildCare2000P10';

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060505, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;