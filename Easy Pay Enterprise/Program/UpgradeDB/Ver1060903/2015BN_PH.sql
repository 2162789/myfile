if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'New Year' and HolidayStartDate = '2015-01-01') then
   insert into Holidays values('Brunei','New Year','2015-01-01','2015-01-01','New Year Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Prophet Birthday' and HolidayStartDate = '2015-01-03') then
    insert into Holidays values('Brunei','Prophet Birthday','2015-01-03','2015-01-03','Birthday of the Prophet Mohammed S.A.W.',0,1,0);  
 end if;
 
if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Chinese NY' and HolidayStartDate = '2015-02-19') then
   insert into Holidays values('Brunei','Chinese NY','2015-02-19','2015-02-19','Chinese New Year',0,1,0);
 end if;
 
if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'National Day' and HolidayStartDate = '2015-02-23') then
    insert into Holidays values('Brunei','National Day','2015-02-23','2015-02-23','National Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'IsrakMikraj' and HolidayStartDate = '2015-05-16') then
    insert into Holidays values('Brunei','IsrakMikraj','2015-05-16','2015-05-16','Israk Mikraj (Acension of The Prophet Muhammad)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Royal BN Armed Force' and HolidayStartDate = '2015-06-01') then
    insert into Holidays values('Brunei','Royal BN Armed Force','2015-06-01','2015-06-01','Royal Brunei Armed Forces Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Ramadan' and HolidayStartDate = '2015-06-18') then
    insert into Holidays values('Brunei','Ramadan','2015-06-18','2015-06-18','Start of Ramadan',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Sultan Birthday' and HolidayStartDate = '2015-07-15') then
    insert into Holidays values('Brunei','Sultan Birthday','2015-07-15','2015-07-15','H.M. the Sultan and Yang Di-pertuan Negara Brunei Darussalam Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Eid Al Fitr' and HolidayStartDate = '2015-07-17') then
    insert into Holidays values('Brunei','Eid Al Fitr','2015-07-17','2015-07-17','Eid Al Fitr',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Eid Al Adha' and HolidayStartDate = '2015-07-18') then
    insert into Holidays values('Brunei','Eid Al Fitr','2015-07-18','2015-07-18','Eid Al Fitr',0,1,0); 
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Eid Al Adha' and HolidayStartDate = '2015-07-19') then
    insert into Holidays values('Brunei','Eid Al Fitr','2015-07-19','2015-07-19','Eid Al Fitr',0,1,0); 
end if;


if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'FirstDayHijra' and HolidayStartDate = '2015-10-13') then
    insert into Holidays values('Brunei','FirstDayHijra','2015-10-13','2015-10-13','First Day of Hijra 1436',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-26') then
    insert into Holidays values('Brunei','Christmas Day','2015-12-26','2015-12-26','Christmas Day',0,1,0);
end if;

commit work;
