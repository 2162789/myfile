if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'Salary' and FormatName = 'Citibank Direct V4.5.1') then

insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('Salary', 'Citibank Direct V4.5.1', 'RIndoBankFormatCitiDirect451.dll', 'InvokeSalaryFormatter');
commit work;

end if;