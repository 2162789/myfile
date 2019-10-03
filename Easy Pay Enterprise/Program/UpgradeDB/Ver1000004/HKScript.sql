if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'Salary' and FormatName = 'BOT Mitsubishi UFJ')
then
   insert into "DBA"."BankSubmitFormat" (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) values ('Salary','BOT Mitsubishi UFJ','RHKBankFormatBoTMitsubishiUFJ.dll','InvokeSalaryFormatter');
end if; 
commit work;