if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'Salary' and FormatName = 'JPMorgan Access (G-ACH)')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('Salary', 'JPMorgan Access (G-ACH)', 'RSingBankFormatJPMorganAccessGACH.dll', 'InvokeSalaryFormatter');
end if;
commit work;