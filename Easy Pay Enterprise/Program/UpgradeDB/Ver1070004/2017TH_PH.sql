if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-04-17') then
   insert into Holidays values('Thailand','Songkran','2017-04-17','2017-04-17','Songkran',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-05-10') then
  insert into Holidays values('Thailand','Visakha Bucha','2017-05-10','2017-05-10','Visakha Bucha',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-07-08') then
  insert into Holidays values('Thailand','Asalha Bucha','2017-07-08','2017-07-08','Asalha Bucha',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-08-11') then
  insert into Holidays values('Thailand','Queen Birthday','2017-08-11','2017-08-11','Queen Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-10-23') then
  insert into Holidays values('Thailand','Chulalongkorn Day','2017-10-23','2017-10-23','Chulalongkorn Day',0,1,0);
end if;

commit work;
