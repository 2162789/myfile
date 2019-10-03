If not exists(Select * from ePortalVersion where EPE = '1070600') then
	Insert into ePortalVersion (EPE, ePortal) VALUES ('1070600', '1030000');
end if;
commit work;