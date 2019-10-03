IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='AM Bank (AutoPay)' and BankSubmitSubmitForId = 'Salary') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'AM Bank (AutoPay)', 'RMalayBankFormatAMBankAutoPay.dll', 'InvokeSalaryFormatter', '0');
END IF;

IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Alliance BizSmart' and BankSubmitSubmitForId = 'Salary') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'Alliance BizSmart', 'RMalayBankFormatAllianceBizSmart.dll', 'InvokeSalaryFormatter', '0');
END IF;

IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='BOA(GPS)' and BankSubmitSubmitForId = 'Salary') THEN
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'BOA(GPS)', 'RMalayBankFormatBOAGPS.dll', 'InvokeSalaryFormatter', '0');
END IF;

commit work;