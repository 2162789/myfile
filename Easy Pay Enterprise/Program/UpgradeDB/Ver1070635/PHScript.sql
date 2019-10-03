/*
*   New Bankdisk, HSBC (iFile), Salary format
*/
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'HSBC (iFile)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'HSBC (iFile)', 'RPhilipBankFormatHSBCiFile.dll', 'InvokeSalaryFormatter', 0);
end if;

commit work;