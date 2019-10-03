if not exists(select * from modulescreengroup where modulescreenid = 'PayCP22B') then 
	insert into modulescreengroup values ('PayCP22B','PayMalGovForm','CP22B (Cessation Public Sector Staff)','Pay',0,1,0,'');
end if;
commit work;

update RebateGranted Set RebatePaymentCount=0;

if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'CP39' and FormatName = 'CIMB') then
	insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
	values ('CP39', 'CIMB', 'RMalBankFormatCIMB.dll', 'InvokeCP39Formatter');
end if;
if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'EPF' and FormatName = 'CIMB') then
	insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
	values ('EPF', 'CIMB', 'RMalBankFormatCIMB.dll', 'InvokeEPFFormatter');
end if;
if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'SOCSO' and FormatName = 'CIMB') then
	insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
	values ('SOCSO', 'CIMB', 'RMalBankFormatCIMB.dll', 'InvokeSOCSOFormatter');
end if;
if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'ZAKAT' and FormatName = 'CIMB') then
	insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
	values ('ZAKAT', 'CIMB', 'RMalBankFormatCIMB.dll', 'InvokeZAKATFormatter');
end if;
if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'Salary' and FormatName = 'CIMB') then
	insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
	values ('Salary', 'CIMB', 'RMalBankFormatCIMB.dll', 'InvokeSalaryFormatter');
end if;

commit work;