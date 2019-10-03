if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-01-01') then
   insert into Holidays values('Brunei','New Year','2017-01-01','2017-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-01-02') then
   insert into Holidays values('Brunei','New Year','2017-01-02','2017-01-02','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-01-28') then
   insert into Holidays values('Brunei','Chinese NY','2017-01-28','2017-01-28','Chinese New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-02-23') then
   insert into Holidays values('Brunei','National Day','2017-02-23','2017-02-23','National Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-04-24') then
   insert into Holidays values('Brunei','IsrakMikraj','2017-04-24','2017-04-24','IsrakMikraj',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-05-31') then
   insert into Holidays values('Brunei','Royal BN Armed Force','2017-05-31','2017-05-31','Royal Brunei Armed Forces Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-05-27') then
      insert into Holidays values('Brunei','Ramadan','2017-05-27','2017-05-27','Start of Ramadan',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-06-12') then
      insert into Holidays values('Brunei','Revelation of Koran','2017-06-12','2017-06-12','Revelation of the Koran',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-06-25') then
       insert into Holidays values('Brunei','Eid Al Fitr','2017-06-25','2017-06-25','Eid Al Fitr',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-06-26') then
       insert into Holidays values('Brunei','Eid Al Fitr','2017-06-26','2017-06-26','Eid Al Fitr',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-06-27') then
       insert into Holidays values('Brunei','Eid Al Fitr','2017-06-27','2017-06-27','Eid Al Fitr',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-06-28') then
       insert into Holidays values('Brunei','Eid Al Fitr','2017-06-28','2017-06-28','Eid Al Fitr',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-07-15') then
       insert into Holidays values('Brunei','Sultan Birthday','2017-07-15','2017-07-15','H.M. the Sultan Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-09-01') then
       insert into Holidays values('Brunei','Eid Al Adha','2017-09-01','2017-09-01','Eid Al Adha',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-09-02') then
       insert into Holidays values('Brunei','Eid Al Adha','2017-09-02','2017-09-02','Eid Al Adha',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-09-21') then
       insert into Holidays values('Brunei','Islamic New Year','2017-09-21','2017-09-21','Islamic New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-12-01') then
       insert into Holidays values('Brunei','Prophet Birthday','2017-12-01','2017-12-01','Birthday of the Prophet Mohammed S.A.W.',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-12-02') then
       insert into Holidays values('Brunei','Prophet Birthday','2017-12-02','2017-12-02','Birthday of the Prophet Mohammed S.A.W.',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei'  and HolidayStartDate = '2017-12-25') then
       insert into Holidays values('Brunei','Christmas Day','2017-12-25','2017-12-25','Christmas Day',0,1,0);
end if;

commit work;
