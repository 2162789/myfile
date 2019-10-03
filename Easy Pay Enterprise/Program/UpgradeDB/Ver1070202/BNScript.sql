if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'Standard Chartered (WEB)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'Standard Chartered (WEB)', 'RBankFormatStandardChartered.dll', 'InvokeSalaryFormatter', 0);
end if;

commit work;