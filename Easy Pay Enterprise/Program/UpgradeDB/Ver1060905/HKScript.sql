
/*PH 2015 Hongkong  */

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Lunar New Year' and HolidayStartDate = '2015-02-21') then
   insert into Holidays values('Hong Kong','Lunar New Year','2015-02-21','2015-02-21','Lunar New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Easter Monday' and HolidayStartDate = '2015-04-07') then
   insert into Holidays values('Hong Kong','Easter Monday','2015-04-07','2015-04-07','Easter Monday',0,1,0);
end if;

if  exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Boxing Day' and HolidayStartDate = '2015-12-28') then
    delete from Holidays where CountryId='Hong Kong' and HolidayId = 'Boxing Day' and HolidayStartDate = '2015-12-28';
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-25') then
    insert into Holidays values('Hong Kong','Christmas Day','2015-12-25','2015-12-25','Christmas Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-26') then
    insert into Holidays values('Hong Kong','Christmas Day','2015-12-26','2015-12-26','Christmas Day',0,1,0);
end if;

commit work;