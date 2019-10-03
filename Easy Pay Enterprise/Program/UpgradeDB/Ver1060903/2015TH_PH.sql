if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'New Year' and HolidayStartDate = '2015-01-01') then
   insert into Holidays values('Thailand','New Year','2015-01-01','2015-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Makha Bucha' and HolidayStartDate = '2015-03-02') then
   insert into Holidays values('Thailand','Makha Bucha','2015-03-02','2015-03-02','Makha Bucha Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Chakri Day' and HolidayStartDate = '2015-04-06') then
   insert into Holidays values('Thailand','Chakri Day','2015-04-06','2015-04-06','Chakri Day',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Songkran' and HolidayStartDate = '2015-04-13') then
   insert into Holidays values('Thailand','Songkran','2015-04-13','2015-04-13','Songkran - Thai New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Songkran' and HolidayStartDate = '2015-04-14') then
   insert into Holidays values('Thailand','Songkran','2015-04-14','2015-04-14','Songkran - Thai New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Songkran' and HolidayStartDate = '2015-04-15') then
   insert into Holidays values('Thailand','Songkran','2015-04-15','2015-04-15','Songkran - Thai New Year',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Labour Day' and HolidayStartDate = '2015-05-01') then
   insert into Holidays values('Thailand','Labour Day','2015-05-01','2015-05-01','Labour Day',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Visakha Bucha Day' and HolidayStartDate = '2015-05-03') then
   insert into Holidays values('Thailand','Visakha Bucha Day','2015-05-03','2015-05-03','Visakha Bucha Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Visakha Bucha Day' and HolidayStartDate = '2015-05-04') then
   insert into Holidays values('Thailand','Visakha Bucha Day','2015-05-04','2015-05-04','Visakha Bucha Day',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Coronation Day' and HolidayStartDate = '2015-05-05') then
   insert into Holidays values('Thailand','Coronation Day','2015-05-05','2015-05-05','Coronation Day',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Asanha Bucha Day' and HolidayStartDate = '2015-07-01') then
   insert into Holidays values('Thailand','Asanha Bucha Day','2015-07-01','2015-07-01','Asanha Bucha Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Queen Birthday' and HolidayStartDate = '2015-08-12') then
   insert into Holidays values('Thailand','Queen Birthday','2015-08-12','2015-08-12','Queen Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Chulalongkorn Day' and HolidayStartDate = '2015-10-23') then
   insert into Holidays values('Thailand','Chulalongkorn Day','2015-10-23','2015-10-23','King Chulalongkorn Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'King Birthday' and HolidayStartDate = '2015-12-07') then
   insert into Holidays values('Thailand','King Birthday','2015-12-07','2015-12-07','King Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Constitution Day' and HolidayStartDate = '2015-12-10') then
   insert into Holidays values('Thailand','Constitution Day','2015-12-10','2015-12-10','Constitution Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'New Year Eve' and HolidayStartDate = '2015-12-31') then
   insert into Holidays values('Thailand','New Year Eve','2015-12-31','2015-12-31','New Year Eve',0,1,0);
end if;

commit work;
