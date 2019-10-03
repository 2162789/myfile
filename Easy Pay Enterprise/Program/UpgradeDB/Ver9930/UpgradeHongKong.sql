READ UpgradeDB\Ver9930\Entity.sql;
READ UpgradeDB\Ver9930\SpecialRequest.sql;

UPDATE MPFSubmitFormat SET SQLTermBackPay = 1;

UPDATE "DBA"."subRegistry" SET IntegerAttr=9930, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;