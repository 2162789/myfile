if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-01-01') then
   insert into Holidays values('Thailand','New Year','2017-01-01','2017-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-01-02') then
   insert into Holidays values('Thailand','New Year','2017-01-02','2017-01-02','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-04-06') then
   insert into Holidays values('Thailand','Chakri Day','2017-04-06','2017-04-06','Chakri Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-04-13') then
   insert into Holidays values('Thailand','Songkran','2017-04-13','2017-04-13','Songkran',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-04-14') then
   insert into Holidays values('Thailand','Songkran','2017-04-14','2017-04-14','Songkran',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-04-15') then
   insert into Holidays values('Thailand','Songkran','2017-04-15','2017-04-15','Songkran',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-05-01') then
  insert into Holidays values('Thailand','Labor Day','2017-05-01','2017-05-01','Labor Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-05-05') then
  insert into Holidays values('Thailand','Coronation Day','2017-05-05','2017-05-05','Coronation Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-08-12') then
  insert into Holidays values('Thailand','Queen Birthday','2017-08-12','2017-08-12','Queen Birthday',0,1,0);;
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-10-23') then
  insert into Holidays values('Thailand','Chulalongkorn Day','2017-10-23','2017-10-23','Chulalongkorn Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-12-05') then
  insert into Holidays values('Thailand','King Birthday','2017-12-05','2017-12-05','King Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-12-10') then
  insert into Holidays values('Thailand','Constitution Day','2017-12-10','2017-12-10','Constitution Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-12-11') then
  insert into Holidays values('Thailand','Constitution Day','2017-12-11','2017-12-11','Constitution Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Thailand'  and HolidayStartDate = '2017-12-31') then
  insert into Holidays values('Thailand','New Year Eve','2017-12-31','2017-12-31','New Year Eve',0,1,0);
end if;


commit work;
