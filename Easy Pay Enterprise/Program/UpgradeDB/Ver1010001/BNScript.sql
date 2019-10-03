if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'Salary' and FormatName = 'Citibank Direct')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('Salary', 'Citibank Direct', 'RBankFormatCitibankDirect.dll', 'InvokeSalaryFormatter');
end if;
commit work;