/* Enable customization for PDPA form */
if not exists(Select * from Keyword where KeywordId = 'CR_THCorePDPAReport') then
	INSERT INTO Keyword VALUES('CR_THCorePDPAReport', 'Core', 'Personal Information Consent Form', 'CrystalRpt Cus Mgr', NULL,NULL,NULL,'Personal Information Consent Form', NULL,NULL,0, NULL);
end if;
commit work;