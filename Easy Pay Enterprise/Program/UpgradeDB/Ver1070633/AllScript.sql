If not exists(Select * from ePortalVersion where EPE = '1070700') then
	Insert into ePortalVersion (EPE, ePortal) VALUES ('1070700', '1030000');
end if;
commit work;