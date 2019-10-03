if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'Salary' and FormatName = 'ANZ')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('Salary', 'ANZ', 'RSingBankFormatANZ.dll', 'InvokeSalaryFormatter');
end if;
commit work;