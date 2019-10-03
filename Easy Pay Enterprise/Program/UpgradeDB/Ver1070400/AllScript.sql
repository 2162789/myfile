if not exists(select * from EPORTALVERSION where EPE = '1070400') then
	Insert into EPORTALVERSION (EPE, EPORTAL) VALUES ('1070400', '1030000');
end if;

commit work;