/* AM bank AutoPay */

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'EPF' and FormatName = 'AM Bank (AutoPay)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('EPF', 'AM Bank (AutoPay)', 'RMalayBankFormatAMBankAutoPay.dll', 'InvokeEPFFormatter', 0);
end if;
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'SOCSO' and FormatName = 'AM Bank (AutoPay)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('SOCSO', 'AM Bank (AutoPay)', 'RMalayBankFormatAMBankAutoPay.dll', 'InvokeSOCSOFormatter', 0);
end if;
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'CP39' and FormatName = 'AM Bank (AutoPay)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('CP39', 'AM Bank (AutoPay)', 'RMalayBankFormatAMBankAutoPay.dll', 'InvokeCP39Formatter', 0);
end if;

commit work;