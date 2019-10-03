

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-05-01') then
   insert into Holidays values('Thailand','Labor Day','2016-05-01','2016-05-01','Labor Day',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-10-23') then
   insert into Holidays values('Thailand','Chulalongkorn Day','2016-10-23','2016-10-23','Chulalongkorn Day',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-12-10') then
   insert into Holidays values('Thailand','Constitution Day','2016-12-10','2016-12-10','Constitution Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-12-12') then
   insert into Holidays values('Thailand','Constitution Day','2016-12-12','2016-12-12','Constitution Day',0,1,0);
end if;

if exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-12-11') then
   delete from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-12-11' ;
end if;


commit work;
