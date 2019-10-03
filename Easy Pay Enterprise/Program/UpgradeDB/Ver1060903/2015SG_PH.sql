if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'New Year' and HolidayStartDate = '2015-01-01') then
   insert into Holidays values('Singapore','New Year','2015-01-01','2015-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Chinese New Year' and HolidayStartDate = '2015-02-19') then
   insert into Holidays values('Singapore','Chinese New Year','2015-02-19','2015-02-19','Chinese New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Chinese New Year' and HolidayStartDate = '2015-02-20') then
   insert into Holidays values('Singapore','Chinese New Year','2015-02-20','2015-02-20','Chinese New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Good Friday' and HolidayStartDate = '2015-04-03') then
   insert into Holidays values('Singapore','Good Friday','2015-04-03','2015-04-03','Good Friday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Labour Day' and HolidayStartDate = '2015-05-01') then
   insert into Holidays values('Singapore','Labour Day','2015-05-01','2015-05-01','Labour Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Vesak Day' and HolidayStartDate = '2015-06-01') then
   insert into Holidays values('Singapore','Vesak Day','2015-06-01','2015-06-01','Vesak Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Hari Raya Puasa' and HolidayStartDate = '2015-07-17') then
   insert into Holidays values('Singapore','Hari Raya Puasa','2015-07-17','2015-07-17','Hari Raya Puasa',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'National Day' and HolidayStartDate = '2015-08-09') then
   insert into Holidays values('Singapore','National Day','2015-08-09','2015-08-09','National Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'National Day' and HolidayStartDate = '2015-08-10') then
   insert into Holidays values('Singapore','National Day','2015-08-10','2015-08-10','National Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Hari Raya Haji' and HolidayStartDate = '2015-09-24') then
   insert into Holidays values('Singapore','Hari Raya Haji','2015-09-24','2015-09-24','Hari Raya Haji',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Deepavali' and HolidayStartDate = '2015-11-10') then
   insert into Holidays values('Singapore','Deepavali','2015-11-10','2015-11-10','Deepavali',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-25') then
   insert into Holidays values('Singapore','Christmas Day','2015-12-25','2015-12-25','Christmas Day',0,1,0);
end if;

commit work;