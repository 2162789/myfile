IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='HSBC(Net)') THEN
	insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, BooleanField1) values
	('Salary', 'HSBC(Net)', 'RPhilipBankFormatHSBC.dll', 'InvokeSalaryFormatter', 0); 
END IF;