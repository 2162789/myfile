if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-01-01') then
   insert into Holidays values('Thailand','New Year','2016-01-01','2016-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-02-22') then
   insert into Holidays values('Thailand','Makha Bucha','2016-02-22','2016-02-22','Makha Bucha Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-04-06') then
   insert into Holidays values('Thailand','Chakri Day','2016-04-06','2016-04-06','Chakri Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-04-13') then
   insert into Holidays values('Thailand','Songkran','2016-04-13','2016-04-13','Songkran',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-04-14') then
   insert into Holidays values('Thailand','Songkran','2016-04-14','2016-04-14','Songkran',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-04-15') then
   insert into Holidays values('Thailand','Songkran','2016-04-15','2016-04-15','Songkran',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-05-01') then
   insert into Holidays values('Thailand','Labor Day','2016-05-01','2016-05-01','Labor Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-05-02') then
   insert into Holidays values('Thailand','Labor Day','2016-05-02','2016-05-02','Labor Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-05-05') then
   insert into Holidays values('Thailand','Coronation Day','2016-05-05','2016-05-05','Coronation Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-05-20') then
   insert into Holidays values('Thailand','Vesak Day','2016-05-20','2016-05-20','Vesak Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-07-19') then
   insert into Holidays values('Thailand','Asanha Bucha Day','2016-07-19','2016-07-19','Asanha Bucha Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-08-12') then
   insert into Holidays values('Thailand','Queen Birthday','2016-08-12','2016-08-12','Queen Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-10-23') then
   insert into Holidays values('Thailand','Chulalongkorn Day','2016-10-23','2016-10-23','Chulalongkorn Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-10-24') then
   insert into Holidays values('Thailand','Chulalongkorn Day','2016-10-24','2016-10-24','Chulalongkorn Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-12-05') then
   insert into Holidays values('Thailand','King Birthday','2016-12-05','2016-12-05','King Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-12-10') then
   insert into Holidays values('Thailand','Constitution Day','2016-12-10','2016-12-10','Constitution Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-12-12') then
   insert into Holidays values('Thailand','Constitution Day','2016-12-12','2016-12-12','Constitution Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2016-12-31') then
   insert into Holidays values('Thailand','New Year Eve','2016-12-31','2016-12-31','New Year Eve',0,1,0);
end if;


commit work;
