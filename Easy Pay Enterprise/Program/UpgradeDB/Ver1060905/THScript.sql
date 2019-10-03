/*PH 2015 Thailand  */

if exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Makha Bucha' and HolidayStartDate = '2015-03-02') then
   delete from Holidays where CountryId='Thailand' and HolidayId = 'Makha Bucha' and HolidayStartDate = '2015-03-02';
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Makha Bucha' and HolidayStartDate = '2015-03-04') then
   insert into Holidays values('Thailand','Makha Bucha','2015-03-04','2015-03-04','Makha Bucha Day',0,1,0);
end if;

if exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Visakha Bucha Day' and HolidayStartDate = '2015-05-03') then
   delete from Holidays where CountryId='Thailand' and HolidayId = 'Visakha Bucha Day' and HolidayStartDate = '2015-05-03';
end if;

if exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Visakha Bucha Day' and HolidayStartDate = '2015-05-04') then
   delete from Holidays where CountryId='Thailand' and HolidayId = 'Visakha Bucha Day' and HolidayStartDate = '2015-05-04';
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Vesak Day' and HolidayStartDate = '2015-06-01') then
   insert into Holidays values('Thailand','Vesak Day','2015-06-01','2015-06-01','Vesak Day',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Asanha Bucha Day' and HolidayStartDate = '2015-07-30') then
   insert into Holidays values('Thailand','Asanha Bucha Day','2015-07-30','2015-07-30','Asanha Bucha Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'King Birthday' and HolidayStartDate = '2015-12-05') then
   insert into Holidays values('Thailand','King Birthday','2015-12-05','2015-12-05','King Birthday',0,1,0);
end if;

if exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'Asanha Bucha Day' and HolidayStartDate = '2015-07-01') then
   delete from Holidays where CountryId='Thailand' and HolidayId = 'Asanha Bucha Day' and HolidayStartDate = '2015-07-01';
end if;

if not exists(select * from Holidays where CountryId='Thailand' and HolidayId = 'King Birthday' and HolidayStartDate = '2015-12-07') then
   insert into Holidays values('Thailand','King Birthday','2015-12-07','2015-12-07','King Birthday',0,1,0);
end if;


commit work;