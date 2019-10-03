update BankSubmitFormat set DllName = 'RMalayBankFormatAllianceOnline.dll' where FormatName = 'Alliance Online' and BankSubmitSubmitForId = 'SOCSO';
update BankSubmitFormat set DllName = 'RMalayBankFormatAllianceOnline.dll', FormatterInvoke = 'InvokeOnlineCP39Formatter' where FormatName = 'Alliance Online' and BankSubmitSubmitForId = 'CP39';

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'SOCSO' and FormatName = 'Public Bank Berhad (PBB)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('SOCSO', 'Public Bank Berhad (PBB)', 'RMalBankFormatPBB.dll', 'InvokeSOCSOFormatter', 0);
end if;

commit work;