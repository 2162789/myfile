if not exists(select * from Holidays where CountryId='Singapore' and  HolidayStartDate = '2017-01-01') then
   insert into Holidays values('Singapore','New Year','2017-01-01','2017-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore'  and HolidayStartDate = '2017-01-02') then
   insert into Holidays values('Singapore','New Year','2017-01-02','2017-01-02','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore'  and HolidayStartDate = '2017-01-28') then
   insert into Holidays values('Singapore','Chinese New Year','2017-01-28','2017-01-28','Chinese New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayStartDate = '2017-01-29') then
   insert into Holidays values('Singapore','Chinese New Year','2017-01-29','2017-01-29','Chinese New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore'  and HolidayStartDate = '2017-01-30') then
   insert into Holidays values('Singapore','Chinese New Year','2017-01-30','2017-01-30','Chinese New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayStartDate = '2017-04-14') then
   insert into Holidays values('Singapore','Good Friday','2017-04-14','2017-04-14','Good Friday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and  HolidayStartDate = '2017-05-01') then
   insert into Holidays values('Singapore','Labour Day','2017-05-01','2017-05-01','Labour Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore' and HolidayStartDate = '2017-05-10') then
   insert into Holidays values('Singapore','Vesak Day','2017-05-10','2017-05-10','Vesak Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore'  and HolidayStartDate = '2017-06-25') then
   insert into Holidays values('Singapore','Hari Raya Puasa','2017-06-25','2017-06-25','Hari Raya Puasa',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore'  and HolidayStartDate = '2017-06-26') then
   insert into Holidays values('Singapore','Hari Raya Puasa','2017-06-26','2017-06-26','Hari Raya Puasa',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Singapore'  and HolidayStartDate = '2017-08-09') then
   insert into Holidays values('Singapore','National Day','2017-08-09','2017-08-09','National Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore'  and HolidayStartDate = '2017-09-01') then
   insert into Holidays values('Singapore','Hari Raya Haji','2017-09-01','2017-09-01','Hari Raya Haji',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore'  and HolidayStartDate = '2017-10-18') then
   insert into Holidays values('Singapore','Deepavali','2017-10-18','2017-10-18','Deepavali',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Singapore'  and HolidayStartDate = '2017-12-25') then
   insert into Holidays values('Singapore','Christmas Day','2017-12-25','2017-12-25','Christmas Day',0,1,0);
end if;

commit work;