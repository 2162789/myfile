/* AM Bank - ZAKAT */
if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'ZAKAT' and FormatName = 'AM Bank') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('ZAKAT', 'AM Bank', 'RMalayBankFormatAMBank.dll', 'InvokeZAKATFormatter', 0);
end if;

/* Enable customization for PDPA form */
if not exists(Select * from Keyword where KeywordId = 'CR_MYCorePDPAReport') then
	INSERT INTO Keyword VALUES('CR_MYCorePDPAReport', 'Core', 'Personal Information Consent Form', 'CrystalRpt Cus Mgr', NULL,NULL,NULL,'Personal Information Consent Form', NULL,NULL,0, NULL);
end if;

commit work;
