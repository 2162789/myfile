if not exists(select * from  modulescreengroup WHERE modulescreenid = 'PayPhilMCRF') THEN
	insert into modulescreengroup values ('PayPhilMCRF', 'PayPhilStatutory', 'MCRF', 'Pay', 0, 1);
END IF;

update usermodulenoaccess set modulescreenid = 'PayPhilMCRF' where modulescreenid = 'PayPhilHDMF';

if exists (select * from modulescreengroup where modulescreenid = 'PayPhilHDMF') then 
	delete from modulescreengroup where modulescreenid = 'PayPhilHDMF';
end if;
