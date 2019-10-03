/* EIS for RHB Reflex System */
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'EIS' and FormatName = 'RHB Bank Reflex System') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('EIS', 'RHB Bank Reflex System', 'RMalayBankFormatRHBReflexSystem.dll', 'InvokeEISFormatter', 0);
end if;

commit work;