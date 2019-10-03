if not exists(select * from Holidays where CountryId='Singapore' and  HolidayStartDate = '2016-01-01') then
   insert into Holidays values('Singapore','New Year','2016-01-01','2016-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore'  and HolidayStartDate = '2016-02-08') then
   insert into Holidays values('Singapore','Chinese New Year','2016-02-08','2016-02-08','Chinese New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore'  and HolidayStartDate = '2016-02-09') then
   insert into Holidays values('Singapore','Chinese New Year','2016-02-09','2016-02-09','Chinese New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayStartDate = '2016-03-25') then
   insert into Holidays values('Singapore','Good Friday','2016-03-25','2016-03-25','Good Friday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore'  and HolidayStartDate = '2016-05-01') then
   insert into Holidays values('Singapore','Labour Day','2016-05-01','2016-05-01','Labour Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayStartDate = '2016-05-02') then
   insert into Holidays values('Singapore','Labour Day','2016-05-02','2016-05-02','Labour Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and  HolidayStartDate = '2016-05-21') then
   insert into Holidays values('Singapore','Vesak Day','2016-05-21','2016-05-21','Vesak Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayStartDate = '2016-07-06') then
   insert into Holidays values('Singapore','Hari Raya Puasa','2016-07-06','2016-07-06','Hari Raya Puasa',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore'  and HolidayStartDate = '2016-08-09') then
   insert into Holidays values('Singapore','National Day','2016-08-09','2016-08-09','National Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore'  and HolidayStartDate = '2016-09-12') then
   insert into Holidays values('Singapore','Hari Raya Haji','2016-09-12','2016-09-12','Hari Raya Haji',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Singapore'  and HolidayStartDate = '2016-10-29') then
   insert into Holidays values('Singapore','Deepavali','2016-10-29','2016-10-29','Deepavali',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore'  and HolidayStartDate = '2016-12-25') then
   insert into Holidays values('Singapore','Christmas Day','2016-12-25','2016-12-25','Christmas Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore'  and HolidayStartDate = '2016-12-26') then
   insert into Holidays values('Singapore','Christmas Day','2016-12-26','2016-12-26','Christmas Day',0,1,0);
end if;

commit work;