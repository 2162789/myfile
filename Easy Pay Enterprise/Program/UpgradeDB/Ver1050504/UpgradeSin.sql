READ UpgradeDB\Ver1050504\AllScript.sql;
READ UpgradeDB\Ver1050504\SGScript.sql;
READ UpgradeDB\Ver1050504\CPFScript1.sql;
READ UpgradeDB\Ver1050504\CPFScript2.sql;
READ UpgradeDB\Ver1050504\CPFScript3.sql;
READ UpgradeDB\Ver1050504\CPFScript4.sql;
READ UpgradeDB\Ver1050504\CPFScript5.sql;
READ UpgradeDB\Ver1050504\CPFScript6.sql;
READ UpgradeDB\Ver1050504\CPFScript7.sql;
READ UpgradeDB\Ver1050504\CPFScript8.sql;
READ UpgradeDB\Ver1050504\CPFScript9.sql;
READ UpgradeDB\Ver1050504\CPFScript10.sql;
READ UpgradeDB\Ver1050504\CPFScript11.sql;
READ UpgradeDB\Ver1050504\CPFScript12.sql;
READ UpgradeDB\Ver1050504\CPFScript13.sql;
READ UpgradeDB\Ver1050504\CPFScript14.sql;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1050504, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;