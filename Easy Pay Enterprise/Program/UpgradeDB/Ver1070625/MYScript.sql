/* EIS for PBB */
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'EIS' and FormatName = 'Public Bank Berhad (PBB)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('EIS','Public Bank Berhad (PBB)','RMalBankFormatPBB.dll','InvokeEISFormatter',0);
end if;

/* EIS for AMBank(AMPayDay) */
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'EIS' and FormatName = 'AM Bank (E-AM Pay Day)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('EIS', 'AM Bank (E-AM Pay Day)', 'RMalayBankFormatAMBankEAMPayDay.dll', 'InvokeEISFormatter', 0);
end if;

/* ZAKAT for Maybank 2E-RC */
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'ZAKAT' and FormatName = 'Maybank 2E-RC') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('ZAKAT', 'Maybank 2E-RC', 'RMalayBankFormatMaybank2ERC.dll', 'InvokeZAKATFormatter', 0);
end if;

commit work;