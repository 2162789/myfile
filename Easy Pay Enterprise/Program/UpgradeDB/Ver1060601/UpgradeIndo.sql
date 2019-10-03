READ UpgradeDB\Ver1060601\AllScript.sql;

IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Maybank' and BankSubmitSubmitForId = 'Salary') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Maybank', 'RIndoBankFormatMayBank.dll', 'InvokeSalaryFormatter', '0');
END IF;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060601, RegProperty1='1.0' WHERE subregistryid='DBVersion';
COMMIT WORK;