if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'DBS (IDEAL UFF)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'DBS (IDEAL UFF)', 'RHKBankFormatDBSIdealUFF.dll', 'InvokeSalaryFormatter', 0);
end if;

commit work;