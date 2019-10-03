if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'EPF' and FormatName = 'RHB Bank Reflex System')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('EPF','RHB Bank Reflex System','RMalayBankFormatRHBReflexSystem.dll','InvokeEPFFormatter');
end if;
commit work;

if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'SOCSO' and FormatName = 'RHB Bank Reflex System')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('SOCSO','RHB Bank Reflex System','RMalayBankFormatRHBReflexSystem.dll','InvokeSOCSOFormatter');
end if;
commit work;

if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'EPF' and FormatName = 'Maybank (Net) v6.4')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('EPF','Maybank (Net) v6.4','RMalayBankFormatMaybankNet.dll','InvokeEPFFormatter');
end if;
commit work;

if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'Salary' and FormatName = 'Maybank (Net) v6.4')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('Salary','Maybank (Net) v6.4','RMalayBankFormatMaybankNet.dll','InvokeSalaryFormatter');
end if;
commit work;

if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'SOCSO' and FormatName = 'Maybank (Net) v6.4')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('SOCSO','Maybank (Net) v6.4','RMalayBankFormatMaybankNet.dll','InvokeSOCSOFormatter');
end if;
commit work;

if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'CP39' and FormatName = 'Maybank (Net) v6.4')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('CP39','Maybank (Net) v6.4','RMalayBankFormatMaybankNet.dll','InvokeCP39Formatter');
end if;
commit work;

if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'ZAKAT' and FormatName = 'Maybank (Net) v6.4')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('ZAKAT','Maybank (Net) v6.4','RMalayBankFormatMaybankNet.dll','InvokeZAKATFormatter');
end if;
commit work;

if exists(select 1 from sys.systable where table_name='AnlysItemRecord') then
	Delete from AnlysItemRecord;
end if;


if exists(select 1 from sys.systable where table_name='AnlysDispSection') then
	Delete from AnlysDispSection where AnlysDisplaySysId like 'SysDStat_%' or 
	AnlysDisplaySysId like 'SysDVar_%';
end if;

commit work;