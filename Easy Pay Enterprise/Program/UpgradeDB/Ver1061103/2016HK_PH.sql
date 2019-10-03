if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-01-01') then
   insert into Holidays values('Hong Kong','New Year','2016-01-01','2016-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-02-08') then
   insert into Holidays values('Hong Kong','Lunar New Year','2016-02-08','2016-02-08','Lunar New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-02-09') then
   insert into Holidays values('Hong Kong','Lunar New Year','2016-02-09','2016-02-09','Lunar New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-02-10') then
   insert into Holidays values('Hong Kong','Lunar New Year','2016-02-10','2016-02-10','Lunar New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-03-25') then
   insert into Holidays values('Hong Kong','Good Friday','2016-03-25','2016-03-25','Good Friday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-03-26') then
   insert into Holidays values('Hong Kong','Good Friday','2016-03-26','2016-03-26','Good Friday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-03-28') then
   insert into Holidays values('Hong Kong','Easter Monday','2016-03-28','2016-03-28','Easter Monday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-04-04') then
   insert into Holidays values('Hong Kong','Ching Ming','2016-04-04','2016-04-04','Ching Ming',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-05-01') then
   insert into Holidays values('Hong Kong','Labour Day','2016-05-01','2016-05-01','Labour Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-05-02') then
   insert into Holidays values('Hong Kong','Labour Day','2016-05-02','2016-05-02','Labour Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-05-14') then
   insert into Holidays values('Hong Kong','Buddha Birthday','2016-05-14','2016-05-14','The Buddha Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-06-09') then
   insert into Holidays values('Hong Kong','Tuen Ng','2016-06-09','2016-06-09','Tuen Ng',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-07-01') then
   insert into Holidays values('Hong Kong','HK SAR','2016-07-01','2016-07-01','HK SAR Establishment Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-09-16') then
   insert into Holidays values('Hong Kong','Mid-Autum','2016-09-16','2016-09-16','Mid-Autum',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-10-01') then
   insert into Holidays values('Hong Kong','National Day','2016-10-01','2016-10-01','National Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-10-09') then
   insert into Holidays values('Hong Kong','Chung Yeung','2016-10-09','2016-10-09','Chung Yeung',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-10-10') then
   insert into Holidays values('Hong Kong','Chung Yeung','2016-10-10','2016-10-10','Chung Yeung',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-12-25') then
   insert into Holidays values('Hong Kong','Christmas Day','2016-12-25','2016-12-25','Christmas Day',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-12-26') then
   insert into Holidays values('Hong Kong','Christmas Day','2016-12-26','2016-12-26','Christmas Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-12-27') then
   insert into Holidays values('Hong Kong','Christmas Day','2016-12-27','2016-12-27','Christmas Day',0,1,0);
end if;

commit work;