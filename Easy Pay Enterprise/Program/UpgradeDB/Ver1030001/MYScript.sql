if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'Salary' and FormatName = 'BOA')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('Salary', 'BOA', 'RMalayBankFormatBOA.dll', 'InvokeSalaryFormatter');
end if;
commit work;