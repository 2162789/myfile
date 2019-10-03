if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'EastWest Bank') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'EastWest Bank', 'RPhilipBankFormatEastWestBank.dll', 'InvokeSalaryFormatter', 0);
end if;

commit work;