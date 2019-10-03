
/*PH 2015 Philippines  */

if  exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'New Year' and HolidayStartDate = '2015-01-02') then
    delete from Holidays where CountryId='Philippines' and HolidayId = 'New Year' and HolidayStartDate = '2015-01-02';
end if;

if  exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Chinese New Year' and HolidayStartDate = '2015-02-19') then
    delete from Holidays where CountryId='Philippines' and HolidayId = 'Chinese New Year' and HolidayStartDate = '2015-02-19';
end if;

if  exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Black Saturday' and HolidayStartDate = '2015-04-04') then
    delete from Holidays where CountryId='Philippines' and HolidayId = 'Black Saturday' and HolidayStartDate = '2015-04-04';
end if;

if  exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Ninoy Aquino Day' and HolidayStartDate = '2015-08-21') then
    delete from Holidays where CountryId='Philippines' and HolidayId = 'Ninoy Aquino Day' and HolidayStartDate = '2015-08-21';
end if;

if  exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'All Saints Day' and HolidayStartDate = '2015-11-01') then
    delete from Holidays where CountryId='Philippines' and HolidayId = 'All Saints Day' and HolidayStartDate = '2015-11-01';
end if;

if  exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Christmas Eve' and HolidayStartDate = '2015-12-24') then
    delete from Holidays where CountryId='Philippines' and HolidayId = 'Christmas Eve' and HolidayStartDate = '2015-12-24';
end if;

if  exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'New Years Eve' and HolidayStartDate = '2015-12-31') then
    delete from Holidays where CountryId='Philippines' and HolidayId = 'New Years Eve' and HolidayStartDate = '2015-12-31';
end if;

commit work;