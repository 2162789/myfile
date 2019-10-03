if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'New Year' and HolidayStartDate = '2014-01-01') then
   insert into Holidays values('Thailand','New Year','2014-01-01','2014-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Makha Bucha' and HolidayStartDate = '2014-02-14') then
   insert into Holidays values('Thailand','Makha Bucha','2014-02-14','2014-02-14','Makha Bucha Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Chakri Day' and HolidayStartDate = '2014-04-06') then
   insert into Holidays values('Thailand','Chakri Day','2014-04-06','2014-04-06','Chakri Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Chakri Day' and HolidayStartDate = '2014-04-07') then
   insert into Holidays values('Thailand','Chakri Day','2014-04-07','2014-04-07','Chakri Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Songkran' and HolidayStartDate = '2014-04-13') then
   insert into Holidays values('Thailand','Songkran','2014-04-13','2014-04-13','Songkran - Thai New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Songkran' and HolidayStartDate = '2014-04-14') then
   insert into Holidays values('Thailand','Songkran','2014-04-14','2014-04-14','Songkran - Thai New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Songkran' and HolidayStartDate = '2014-04-15') then
   insert into Holidays values('Thailand','Songkran','2014-04-15','2014-04-15','Songkran - Thai New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Songkran' and HolidayStartDate = '2014-04-16') then
   insert into Holidays values('Thailand','Songkran','2014-04-16','2014-04-16','Songkran - Thai New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Labour Day' and HolidayStartDate = '2014-05-01') then
   insert into Holidays values('Thailand','Labour Day','2014-05-01','2014-05-01','Labour Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Coronation Day' and HolidayStartDate = '2014-05-05') then
   insert into Holidays values('Thailand','Coronation Day','2014-05-05','2014-05-05','Coronation Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Visakha Bucha Day' and HolidayStartDate = '2014-05-13') then
   insert into Holidays values('Thailand','Visakha Bucha Day','2014-05-13','2014-05-13','Visakha Bucha Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Asanha Bucha Day' and HolidayStartDate = '2014-07-11') then
   insert into Holidays values('Thailand','Asanha Bucha Day','2014-07-11','2014-07-11','Asanha Bucha Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Queen Birthday' and HolidayStartDate = '2014-08-12') then
   insert into Holidays values('Thailand','Queen Birthday','2014-08-12','2014-08-12','Queen Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Chulalongkorn Day' and HolidayStartDate = '2014-10-23') then
   insert into Holidays values('Thailand','Chulalongkorn Day','2014-10-23','2014-10-23','King Chulalongkorn Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'King Birthday' and HolidayStartDate = '2014-12-05') then
   insert into Holidays values('Thailand','King Birthday','2014-12-05','2014-12-05','King Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Constitution Day' and HolidayStartDate = '2014-12-10') then
   insert into Holidays values('Thailand','Constitution Day','2014-12-10','2014-12-10','Constitution Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'New Year Eve' and HolidayStartDate = '2014-12-31') then
   insert into Holidays values('Thailand','New Year Eve','2014-12-31','2014-12-31','New Year Eve',0,1,0);
end if;

commit work;
