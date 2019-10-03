IF NOT EXISTS (SELECT * FROM BankSubmitFormat WHERE FormatName='Security Bank') THEN
insert into banksubmitformat(banksubmitsubmitforid, formatname, dllname, formatterinvoke, iscustomised) values 
('Salary','Security Bank','RPhilipBankFormatSecurityBank.dll','InvokeSalaryFormatter',0);
END IF;
commit work;