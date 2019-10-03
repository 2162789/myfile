/* EIS for CIMB Bank */
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'EIS' and FormatName = 'CIMB') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('EIS', 'CIMB', 'RMalBankFormatCIMB.dll', 'InvokeEISFormatter', 0);
end if;

commit work;