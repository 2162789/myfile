if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'New Year' and HolidayStartDate = '2014-01-01') then
   insert into Holidays values('Singapore','New Year','2014-01-01','2014-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Chinese New Year' and HolidayStartDate = '2014-01-31') then
   insert into Holidays values('Singapore','Chinese New Year','2014-01-31','2014-01-31','Chinese New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Chinese New Year' and HolidayStartDate = '2014-02-01') then
   insert into Holidays values('Singapore','Chinese New Year','2014-02-01','2014-02-01','Chinese New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Good Friday' and HolidayStartDate = '2014-04-18') then
   insert into Holidays values('Singapore','Good Friday','2014-04-18','2014-04-18','Good Friday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Labour Day' and HolidayStartDate = '2014-05-01') then
   insert into Holidays values('Singapore','Labour Day','2014-05-01','2014-05-01','Labour Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Vesak Day' and HolidayStartDate = '2014-05-13') then
   insert into Holidays values('Singapore','Vesak Day','2014-05-13','2014-05-13','Vesak Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Hari Raya Puasa' and HolidayStartDate = '2014-07-28') then
   insert into Holidays values('Singapore','Hari Raya Puasa','2014-07-28','2014-07-28','Hari Raya Puasa',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'National Day' and HolidayStartDate = '2014-08-09') then
   insert into Holidays values('Singapore','National Day','2014-08-09','2014-08-09','National Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Hari Raya Haji' and HolidayStartDate = '2014-10-05') then
   insert into Holidays values('Singapore','Hari Raya Haji','2014-10-05','2014-10-05','Hari Raya Haji',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Hari Raya Haji' and HolidayStartDate = '2014-10-06') then
   insert into Holidays values('Singapore','Hari Raya Haji','2014-10-06','2014-10-06','Hari Raya Haji',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Deepavali' and HolidayStartDate = '2014-10-23') then
   insert into Holidays values('Singapore','Deepavali','2014-10-23','2014-10-23','Deepavali',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'Christmas Day' and HolidayStartDate = '2014-12-25') then
   insert into Holidays values('Singapore','Christmas Day','2014-12-25','2014-12-25','Christmas Day',0,1,0);
end if;

commit work;