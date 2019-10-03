/* Enable customization for PDPA form */
if not exists(Select * from Keyword where KeywordId = 'CR_SGPDPAReport') then
	INSERT INTO Keyword VALUES('CR_SGPDPAReport', 'Core', 'Personal Information Consent Form', 'CrystalRpt Cus Mgr', NULL,NULL,NULL,'Personal Information Consent Form', NULL,NULL,0, NULL);
end if;

delete from ImportField where ImportFieldPhysical in ('PassagesSelf', 'PassagesWife', 'PassagesChildren', 'OHQStatus', 'OHQDetails', 'OtherBenefits', 'OtherBenefitsDetails');

commit work;