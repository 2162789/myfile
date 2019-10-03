if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'EPF' and FormatName = 'Public Bank Berhad (PBB)')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('EPF', 'Public Bank Berhad (PBB)', 'RMalBankFormatPBB.dll', 'InvokeEPFFormatter');
end if;
commit work;

if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'Salary' and FormatName = 'Citibank (PLGIRO 7.0)')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('Salary', 'Citibank (PLGIRO 7.0)', 'RMalayBankFormatCitibankPlGiro.dll', 'InvokeSalaryFormatter');
end if;
commit work;