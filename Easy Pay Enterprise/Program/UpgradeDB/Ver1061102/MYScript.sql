if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'JPMorgan Access G-ACH (GDFF)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised) 
  values ('Salary', 'JPMorgan Access G-ACH (GDFF)', 'RMalBankFormatJPMorganAccessGACHGDFF.dll', 'InvokeSalaryFormatter', 0)
end if;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'SOCSO' and FormatName = 'CIMB 2014') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised) 
  values ('SOCSO', 'CIMB 2014', 'RMalBankFormatCIMB2014.dll', 'InvokeSOCSOFormatter', 0)
end if;

commit work;