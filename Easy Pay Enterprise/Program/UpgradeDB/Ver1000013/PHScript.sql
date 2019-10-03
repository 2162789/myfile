if not exists (select * from banksubmitformat where formatname = 'BDO Bank') then 
INSERT INTO banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
VALUES ('Salary', 'BDO Bank', 'RPhilipBankFormatBDOBank.dll', 'InvokeSalaryFormatter', '0');
end if;
commit work;