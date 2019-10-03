if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2016-01-01') then
   insert into Holidays values('Brunei','New Year','2016-01-01','2016-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2016-02-08') then
   insert into Holidays values('Brunei','Chinese NY','2016-02-08','2016-02-08','Chinese New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2016-02-23') then
   insert into Holidays values('Brunei','National Day','2016-02-23','2016-02-23','National Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2016-05-05') then
   insert into Holidays values('Brunei','IsrakMikraj','2016-05-05','2016-05-05','IsrakMikraj',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2016-05-31') then
   insert into Holidays values('Brunei','Royal BN Armed Force','2016-05-31','2016-05-31','Royal Brunei Armed Forces Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2016-06-06') then
       insert into Holidays values('Brunei','Ramadan','2016-06-06','2016-06-06','Start of Ramadan',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2016-06-22') then
           insert into Holidays values('Brunei','Revelation of Koran','2016-06-22','2016-06-22','Revelation of the Koran',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2016-07-07') then
       insert into Holidays values('Brunei','Eid Al Fitr','2016-07-07','2016-07-07','Eid Al Fitr',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2016-07-09') then
       insert into Holidays values('Brunei','Eid Al Fitr','2016-07-09','2016-07-09','Eid Al Fitr',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2016-07-11') then
       insert into Holidays values('Brunei','Eid Al Fitr','2016-07-11','2016-07-11','Eid Al Fitr',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2016-07-15') then
       insert into Holidays values('Brunei','Sultan Birthday','2016-07-15','2016-07-15','H.M. the Sultan Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2016-09-11') then
       insert into Holidays values('Brunei','Eid Al Adha','2016-09-11','2016-09-11','Eid Al Adha',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2016-09-12') then
       insert into Holidays values('Brunei','Eid Al Adha','2016-09-12','2016-09-12','Eid Al Adha',0,1,0); 
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2016-10-02') then
       insert into Holidays values('Brunei','FirstDayHijra','2016-10-02','2016-10-02','First Day of Hijra 1436',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2016-12-12') then
       insert into Holidays values('Brunei','Prophet Birthday','2016-12-12','2016-12-12','Birthday of the Prophet Mohammed S.A.W.',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2016-12-25') then
           insert into Holidays values('Brunei','Christmas Day','2016-12-25','2016-12-25','Christmas Day',0,1,0);
end if;
commit work;
