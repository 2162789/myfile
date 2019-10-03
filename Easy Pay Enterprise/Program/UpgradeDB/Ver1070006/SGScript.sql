/* Deutsche (GIRO Payment G3) */
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'Deutsche (GIRO Payment G3)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'Deutsche (GIRO Payment G3)', 'RSingBankFormatDeutscheGiroPaymentG3.dll', 'InvokeSalaryFormatter', 0);
end if;

commit work;