if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'CP39' and FormatName = 'RHB Bank Reflex System')
then
insert into banksubmitformat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
values ('CP39','RHB Bank Reflex System','RMalayBankFormatRHBReflexSystem.dll','InvokeCP39Formatter');
end if;
commit work;