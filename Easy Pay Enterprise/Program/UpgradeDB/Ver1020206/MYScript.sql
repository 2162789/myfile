if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'Salary' and FormatName = 'HSBC (IFile)')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('Salary', 'HSBC (IFile)', 'RMalayBankFormatHSBCIFile.dll', 'InvokeSalaryFormatter');
end if;
commit work;