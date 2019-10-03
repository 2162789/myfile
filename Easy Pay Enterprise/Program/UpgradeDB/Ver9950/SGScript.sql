if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'Salary' and FormatName = 'Handelsbanken') then
	insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
	values ('Salary', 'Handelsbanken', 'RSingBankFormatHandelsbanken.dll', 'InvokeSalaryFormatter');
end if;

If not Exists(Select * From SubRegistry Where RegistryId='PayOption' and SubRegistryId = 'MidMonthCPF') then
	Insert into SubRegistry Values('PayOption','MidMonthCPF','','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end If;
