if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'New Year' and HolidayStartDate = '2014-01-01') then
   insert into Holidays values('Brunei','New Year','2014-01-01','2014-01-01','New Year Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Prophet Birthday' and HolidayStartDate = '2014-01-13') then
    insert into Holidays values('Brunei','Prophet Birthday','2014-01-13','2014-01-13','Birthday of the Prophet Mohammed S.A.W.',0,1,0);  
 end if;
 
if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Chinese NY' and HolidayStartDate = '2014-01-31') then
   insert into Holidays values('Brunei','Chinese NY','2014-01-31','2014-01-31','Chinese New Year',0,1,0);
 end if;
 
if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'National Day' and HolidayStartDate = '2014-02-23') then
    insert into Holidays values('Brunei','National Day','2014-02-23','2014-02-23','National Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'National Day' and HolidayStartDate = '2014-02-24') then
     insert into Holidays values('Brunei','National Day','2014-02-24','2014-02-24','National Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'IsrakMikraj' and HolidayStartDate = '2014-05-27') then
    insert into Holidays values('Brunei','IsrakMikraj','2014-05-27','2014-05-27','Israk Mikraj (Acension of The Prophet Muhammad)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Royal BN Armed Force' and HolidayStartDate = '2014-05-31') then
    insert into Holidays values('Brunei','Royal BN Armed Force','2014-05-31','2014-05-31','Royal Brunei Armed Forces Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Ramadan' and HolidayStartDate = '2014-06-28') then
    insert into Holidays values('Brunei','Ramadan','2014-06-28','2014-06-28','Start of Ramadan',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Sultan Birthday' and HolidayStartDate = '2014-07-15') then
    insert into Holidays values('Brunei','Sultan Birthday','2014-07-15','2014-07-15','H.M. the Sultan and Yang Di-pertuan Negara Brunei Darussalam Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Eid Al Fitr' and HolidayStartDate = '2014-07-28') then
    insert into Holidays values('Brunei','Eid Al Fitr','2014-07-28','2014-07-28','Eid Al Fitr',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Eid Al Adha' and HolidayStartDate = '2014-10-04') then
    insert into Holidays values('Brunei','Eid Al Adha','2014-10-04','2014-10-04','Eid Al Adha',0,1,0); 
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'FirstDayHijra' and HolidayStartDate = '2014-10-25') then
    insert into Holidays values('Brunei','FirstDayHijra','2014-10-25','2014-10-25','First Day of Hijra 1436',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Christmas Day' and HolidayStartDate = '2014-12-25') then
    insert into Holidays values('Brunei','Christmas Day','2014-12-25','2014-12-25','Christmas Day',0,1,0);
end if;

commit work;
