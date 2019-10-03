/* PH 2015 Brunei */

if exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Nuzul Al-Quran' and HolidayStartDate = '2015-08-27') then
    delete from Holidays where CountryId='Brunei' and HolidayId = 'Nuzul Al-Quran' and HolidayStartDate = '2015-08-27'; 
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Royal BN Armed Force' and HolidayStartDate = '2015-05-31') then
    insert into Holidays values('Brunei','Royal BN Armed Force','2015-05-31','2015-05-31','Royal Brunei Armed Forces Day',0,1,0);
end if;

if exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-26') then
   delete from Holidays where CountryId='Brunei' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-26';
end if;

if not exists(select * from Holidays where CountryId='Brunei' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-25') then
    insert into Holidays values('Brunei','Christmas Day','2015-12-25','2015-12-25','Christmas Day',0,1,0);
end if;

commit work;