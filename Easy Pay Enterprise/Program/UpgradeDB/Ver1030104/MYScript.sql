if not exists (select * from modulescreengroup where modulescreenid = 'PayECForm') then 
insert into modulescreengroup values ('PayECForm','PayMalGovForm','EC Form','Pay',0,1,0,'');
end if;
commit work;