
/*PH 2015 Malaysia  */

if not exists(select * from Holidays where CountryId='MY-Kedah' and HolidayId = 'ProphetMohdBirthday' and HolidayStartDate = '2015-01-04') then
    insert into Holidays values('MY-Kedah','ProphetMohdBirthday','2015-01-04','2015-01-04','Prophet Muhammad Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='MY-Kelantan' and HolidayId = 'ProphetMohdBirthday' and HolidayStartDate = '2015-01-04') then
    insert into Holidays values('MY-Kelantan','ProphetMohdBirthday','2015-01-04','2015-01-04','Prophet Muhammad Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='MY-Trengganu' and HolidayId = 'ProphetMohdBirthday' and HolidayStartDate = '2015-01-04') then
    insert into Holidays values('MY-Trengganu','ProphetMohdBirthday','2015-01-04','2015-01-04','Prophet Muhammad Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='MY-Johor' and HolidayId = 'ProphetMohdBirthday' and HolidayStartDate = '2015-01-04') then
    insert into Holidays values('MY-Johor','ProphetMohdBirthday','2015-01-04','2015-01-04','Prophet Muhammad Birthday',0,1,0);
end if;


if  exists(select * from Holidays where CountryId='MY-Kedah' and HolidayId = 'Lunar New Year' and HolidayStartDate = '2015-02-22') then
    delete from Holidays where CountryId='MY-Kedah' and HolidayId = 'Lunar New Year' and HolidayStartDate = '2015-02-22';
end if;

if  exists(select * from Holidays where CountryId='MY-Trengganu' and HolidayId = 'Lunar New Year' and HolidayStartDate = '2015-02-22') then
    delete from Holidays where CountryId='MY-Trengganu' and HolidayId = 'Lunar New Year' and HolidayStartDate = '2015-02-22';
end if;

if  exists(select * from Holidays where CountryId='MY-Kelantan' and HolidayId = 'Lunar New Year' and HolidayStartDate = '2015-02-22') then
    delete from Holidays where CountryId='MY-Kelantan' and HolidayId = 'Lunar New Year' and HolidayStartDate = '2015-02-22';
end if;

if  exists(select * from Holidays where CountryId='MY-Johor' and HolidayId = 'Lunar New Year' and HolidayStartDate = '2015-02-22') then
    delete from Holidays where CountryId='MY-Johor' and HolidayId = 'Lunar New Year' and HolidayStartDate = '2015-02-22';
end if;


if not exists(select * from Holidays where CountryId='MY-Kedah' and HolidayId = 'AgongBirthday' and HolidayStartDate = '2015-06-07') then
    insert into Holidays values('MY-Kedah','AgongBirthday','2015-06-07','2015-06-07','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='MY-Trengganu' and HolidayId = 'AgongBirthday' and HolidayStartDate = '2015-06-07') then
    insert into Holidays values('MY-Trengganu','AgongBirthday','2015-06-07','2015-06-07','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='MY-Kelantan' and HolidayId = 'AgongBirthday' and HolidayStartDate = '2015-06-07') then
    insert into Holidays values('MY-Kelantan','AgongBirthday','2015-06-07','2015-06-07','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='MY-Johor' and HolidayId = 'AgongBirthday' and HolidayStartDate = '2015-06-07') then
    insert into Holidays values('MY-Johor','AgongBirthday','2015-06-07','2015-06-07','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='MY-Kedah' and HolidayId = 'Israk & Mikraj' and HolidayStartDate = '2015-05-17') then
    insert into Holidays values('MY-Kedah','Israk & Mikraj','2015-05-17','2015-05-17','Israk & Mikraj',0,1,0);
end if;

if  exists(select * from Holidays where  HolidayId = 'Hari Raya Puasa' and HolidayStartDate = '2015-07-19') then
    Update Holidays set HOLIDAYDESC='Hari Raya Puasa' where  HolidayId = 'Hari Raya Puasa' and HolidayStartDate = '2015-07-19';
end if;


if  exists(select * from Holidays where CountryId='MY-Kedah' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-27') then
    delete from Holidays where CountryId='MY-Kedah' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-27';
end if;

if  exists(select * from Holidays where CountryId='MY-Trengganu' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-27') then
    delete from Holidays where CountryId='MY-Trengganu' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-27';
end if;

if  exists(select * from Holidays where CountryId='MY-Kelantan' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-27') then
    delete from Holidays where CountryId='MY-Kelantan' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-27';
end if;

if  exists(select * from Holidays where CountryId='MY-Johor' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-27') then
    delete from Holidays where CountryId='MY-Johor' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-27';
end if;


if  exists(select * from Holidays where CountryId='MY-Kedah' and HolidayId = 'Hari Raya Qurban' and HolidayStartDate = '2015-09-27') then
    delete from Holidays where CountryId='MY-Kedah' and HolidayId = 'Hari Raya Qurban' and HolidayStartDate = '2015-09-27';
end if;

if  exists(select * from Holidays where CountryId='MY-Trengganu' and HolidayId = 'Hari Raya Qurban' and HolidayStartDate = '2015-09-27') then
    delete from Holidays where CountryId='MY-Trengganu' and HolidayId = 'Hari Raya Qurban' and HolidayStartDate = '2015-09-27';
end if;

if  exists(select * from Holidays where CountryId='MY-Kelantan' and HolidayId = 'Hari Raya Qurban' and HolidayStartDate = '2015-09-27') then
    delete from Holidays where CountryId='MY-Kelantan' and HolidayId = 'Hari Raya Qurban' and HolidayStartDate = '2015-09-27';
end if;

if not exists(select * from Holidays where CountryId='MY-Kelantan' and HolidayId = 'Hari Nuzul Al-Quran' and HolidayStartDate = '2015-07-05') then
    insert into Holidays values('MY-Kelantan','Hari Nuzul Al-Quran','2015-07-05','2015-07-05','Hari Nuzul Al-Quran',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='MY-Trengganu' and HolidayId = 'Hari Nuzul Al-Quran' and HolidayStartDate = '2015-07-05') then
    insert into Holidays values('MY-Trengganu','Hari Nuzul Al-Quran','2015-07-05','2015-07-05','Hari Nuzul Al-Quran',0,1,0);
end if;

commit work;