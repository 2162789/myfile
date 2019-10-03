
if not exists(select * from modulescreengroup where modulescreenid = 'payphilssstrans') then 
	insert into modulescreengroup values ('PayPhilSSSTrans','PayPhilStatutory','SSS R-3 Transmittal','Pay',0,0);
end if;

commit work;
