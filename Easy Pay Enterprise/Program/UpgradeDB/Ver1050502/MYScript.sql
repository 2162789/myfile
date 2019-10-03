if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'SOCSO' and FormatName = 'AM Bank')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('SOCSO','AM Bank','RMalayBankFormatAMBank.dll','InvokeSOCSOFormatter');
end if;
commit work;

if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'CP39' and FormatName = 'AM Bank')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('CP39','AM Bank','RMalayBankFormatAMBank.dll','InvokeCP39Formatter');
end if;
commit work;

if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'EPF' and FormatName = 'AM Bank')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('EPF','AM Bank','RMalayBankFormatAMBank.dll','InvokeEPFFormatter');
end if;
commit work;

if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'Salary' and FormatName = 'AM Bank')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('Salary','AM Bank','RMalayBankFormatAMBank.dll','InvokeSalaryFormatter');
end if;
commit work;
