READ \UpgradeDB\Ver1060601\2013JulyFWL.sql;
READ \UpgradeDB\Ver1060601\keywordSG.sql;

IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='CIMBGiro' and BankSubmitSubmitForId = 'Salary') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'CIMBGiro', 'RSingBankFormatCIMBGiro.dll', 'InvokeSalaryFormatter', '0');
END IF;

IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Deutsche (GIRO Payment)' and BankSubmitSubmitForId = 'Salary') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Deutsche (GIRO Payment)', 'RSingBankFormatDeutscheGiroPayment.dll', 'InvokeSalaryFormatter', '0');
END IF;

commit work;