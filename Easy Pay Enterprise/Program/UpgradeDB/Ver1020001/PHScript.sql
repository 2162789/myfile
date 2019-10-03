if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'Salary' and FormatName = 'Standard Chartered (Disk)')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('Salary', 'Standard Chartered (Disk)', 'RPhilipBankFormatStdCharteredDisk.dll', 'InvokeSalaryFormatter');
end if;
commit work;