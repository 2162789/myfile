READ UpgradeDB\Ver1060703\AllScript.sql;

IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Kasikorn Bank' and BankSubmitSubmitForId = 'Salary') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Kasikorn Bank', 'RThaiBankFormatKasikornbank.dll', 'InvokeSalaryFormatter', '0');
END IF;

UPDATE "DBA"."subRegistry" SET IntegerAttr=1060703, RegProperty1='1.0' WHERE subregistryid='DBVersion';

COMMIT WORK;