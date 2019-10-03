if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'Handelsbanken (SWIFT MT101)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'Handelsbanken (SWIFT MT101)', 'RSingBankFormatHandelsbankenSwiftMT101.dll', 'InvokeSalaryFormatter', 0);
end if;

commit work;