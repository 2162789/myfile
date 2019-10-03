if not exists (select * from "DBA"."BankSubmitFormat" where BankSubmitSubmitForId = 'Salary' and FormatName = 'Deutsche Internet(Direct-DB)')
then
   insert into "DBA"."BankSubmitFormat" (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke) 
    values ('Salary', 'Deutsche Internet(Direct-DB)', 'RSingBankFormatDeutscheDirectDBInternet.dll', 'InvokeSalaryFormatter');
end if; 
