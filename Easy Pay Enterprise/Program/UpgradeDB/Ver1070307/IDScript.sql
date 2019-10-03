/* Enable customization for PDPA form */
if not exists(Select * from Keyword where KeywordId = 'CR_IDCorePDPAReport') then
	INSERT INTO Keyword VALUES('CR_IDCorePDPAReport', 'Core', 'Personal Information Consent Form', 'CrystalRpt Cus Mgr', NULL,NULL,NULL,'Personal Information Consent Form', NULL,NULL,0, NULL);
end if;

if not exists (select 1 from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'Standard Chartered (WEB)') then
  insert into BankSubmitFormat (BankSubmitSubmitForId, FormatName, DllName, FormatterInvoke, IsCustomised)
  values ('Salary', 'Standard Chartered (WEB)', 'RIndoBankFormatStandardChartered.dll', 'InvokeSalaryFormatter', 0);
end if;

commit work;