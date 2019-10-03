if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'JPMorgan Access (G-ACH)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'JPMorgan Access (G-ACH)', 'RPhilipBankFormatJPMorganAccessGACH.dll', 'InvokeSalaryFormatter', 0);
end if;

commit work;