/* Create new keyword for PDPA Blank Crystal Report */
if not exists(select * from Keyword where keywordId = 'CR_MYCorePDPARptBlk') then
	INSERT INTO Keyword Values ('CR_MYCorePDPARptBlk','Core','Personal Information Consent Form - Blank','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Personal Information Consent Form - Blank',NULL,NULL,0,NULL);
end if;

commit work;