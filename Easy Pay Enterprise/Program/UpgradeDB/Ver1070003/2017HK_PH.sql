if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-01-01') then
   insert into Holidays values('Hong Kong','New Year','2017-01-01','2017-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-01-02') then
   insert into Holidays values('Hong Kong','New Year','2017-01-02','2017-01-02','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-01-28') then
   insert into Holidays values('Hong Kong','Lunar New Year','2017-01-28','2017-01-28','Lunar New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-01-29') then
   insert into Holidays values('Hong Kong','Lunar New Year','2017-01-29','2017-01-29','Lunar New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-01-30') then
   insert into Holidays values('Hong Kong','Lunar New Year','2017-01-30','2017-01-30','Lunar New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-01-31') then
   insert into Holidays values('Hong Kong','Lunar New Year','2017-01-31','2017-01-31','Lunar New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-04-04') then
   insert into Holidays values('Hong Kong','Ching Ming','2017-04-04','2017-04-04','Ching Ming',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-04-14') then
   insert into Holidays values('Hong Kong','Good Friday','2017-04-14','2017-04-14','Good Friday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-04-15') then
   insert into Holidays values('Hong Kong','Good Friday','2017-04-15','2017-04-15','Good Friday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-04-17') then
   insert into Holidays values('Hong Kong','Easter Monday','2017-04-17','2017-04-17','Easter Monday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-05-01') then
   insert into Holidays values('Hong Kong','Labour Day','2017-05-01','2017-05-01','Labour Day',0,1,0);	
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-05-03') then
   insert into Holidays values('Hong Kong','Buddha Birthday','2017-05-03','2017-05-03','The Buddha Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-05-30') then
   insert into Holidays values('Hong Kong','Tuen Ng','2017-05-30','2017-05-30','Tuen Ng',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-07-01') then
   insert into Holidays values('Hong Kong','HK SAR','2017-07-01','2017-07-01','HK SAR Establishment Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-10-05') then
   insert into Holidays values('Hong Kong','Mid-Autum','2017-10-05','2017-10-05','Mid-Autum',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-10-01') then
   insert into Holidays values('Hong Kong','National Day','2017-10-01','2017-10-01','National Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-10-02') then
   insert into Holidays values('Hong Kong','National Day','2017-10-02','2017-10-02','National Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-10-28') then
   insert into Holidays values('Hong Kong','Chung Yeung','2017-10-28','2017-10-28','Chung Yeung',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-12-25') then
   insert into Holidays values('Hong Kong','Christmas Day','2017-12-25','2017-12-25','Christmas Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2017-12-26') then
   insert into Holidays values('Hong Kong','Christmas Day','2017-12-26','2017-12-26','Christmas Day',0,1,0);
end if;

commit work;
