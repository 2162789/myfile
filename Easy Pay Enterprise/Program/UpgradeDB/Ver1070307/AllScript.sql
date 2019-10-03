/* Add PDPA form into security screen for all countries  */
if not exists(select * from ModuleScreenGroup where moduleScreenId = 'CorePDPARpt') then
	INSERT INTO ModuleScreenGroup VALUES ('CorePDPARpt','CoreReports','Personal Information Consent Form','Core',1,0,0,'');
end if;
commit work;