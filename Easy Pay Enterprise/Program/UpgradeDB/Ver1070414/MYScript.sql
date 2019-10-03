if not exists (select 1 from BankSubmit where BankSubmitSubmitForId = 'EIS') then
  insert into BankSubmit SELECT 'EIS', 'EIS';
end if;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'EIS' and FormatName = 'Alliance Online') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('EIS', 'Alliance Online', 'RMalayBankFormatAllianceOnline.dll', 'InvokeOnlineEISFormatter', 0);
end if;

commit work;