if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'DBS (IDEAL)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'DBS (IDEAL)', 'RHKBankFormatDBSIdeal.dll', 'InvokeSalaryFormatter', 0)
end if;

commit work;