if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'Union Bank') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'Union Bank', 'RPhilipBankFormatUnion.dll', 'InvokeSalaryFormatter', 0);
end if;

commit work;