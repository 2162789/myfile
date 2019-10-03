if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'ZAKAT' and FormatName = 'Alliance Bank') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('ZAKAT', 'Alliance Bank', 'RMalayBankFormatAlliance.dll', 'InvokeZAKATFormatter', 0);
end if;

commit work;