/* ANZ Transactive Cash Asia */
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'ANZ Transactive Cash Asia') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'ANZ Transactive Cash Asia', 'RHKBankFormatANZTransactiveCashAsia.dll', 'InvokeSalaryFormatter', 0);
end if;

commit work;