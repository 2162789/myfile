READ UpgradeDB\Ver9940\Entity.sql;
READ UpgradeDB\Ver9940\CommonStoredProc.sql;
READ UpgradeDB\Ver9940\MyStoredProc.sql;
READ UpgradeDB\Ver9940\MySpecialRequest.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=9940, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;