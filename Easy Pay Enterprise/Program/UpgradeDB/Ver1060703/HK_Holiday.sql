if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'New Year' and HolidayStartDate = '2014-01-01') then
   insert into Holidays values('Hong Kong','New Year','2014-01-01','2014-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Lunar New Year' and HolidayStartDate = '2014-01-31') then
   insert into Holidays values('Hong Kong','Lunar New Year','2014-01-31','2014-01-31','Lunar New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Lunar New Year' and HolidayStartDate = '2014-02-01') then
   insert into Holidays values('Hong Kong','Lunar New Year','2014-02-01','2014-02-01','Lunar New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Lunar New Year' and HolidayStartDate = '2014-02-02') then
   insert into Holidays values('Hong Kong','Lunar New Year','2014-02-02','2014-02-02','Lunar New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Lunar New Year' and HolidayStartDate = '2014-02-03') then
   insert into Holidays values('Hong Kong','Lunar New Year','2014-02-03','2014-02-03','Lunar New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Ching Ming' and HolidayStartDate = '2014-04-05') then
   insert into Holidays values('Hong Kong','Ching Ming','2014-04-05','2014-04-05','Ching Ming',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Good Friday' and HolidayStartDate = '2014-04-18') then
   insert into Holidays values('Hong Kong','Good Friday','2014-04-18','2014-04-18','Good Friday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Good Friday' and HolidayStartDate = '2014-04-19') then
   insert into Holidays values('Hong Kong','Good Friday','2014-04-19','2014-04-19','Good Friday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Easter Monday' and HolidayStartDate = '2014-04-21') then
   insert into Holidays values('Hong Kong','Easter Monday','2014-04-21','2014-04-21','Easter Monday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Labour Day' and HolidayStartDate = '2014-05-01') then
   insert into Holidays values('Hong Kong','Labour Day','2014-05-01','2014-05-01','Labour Day',0,1,0);	
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Buddha Birthday' and HolidayStartDate = '2014-05-06') then
   insert into Holidays values('Hong Kong','Buddha Birthday','2014-05-06','2014-05-06','The Buddha Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Tuen Ng' and HolidayStartDate = '2014-06-02') then
   insert into Holidays values('Hong Kong','Tuen Ng','2014-06-02','2014-06-02','Tuen Ng Festival',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'HK SAR' and HolidayStartDate = '2014-07-01') then
   insert into Holidays values('Hong Kong','HK SAR','2014-07-01','2014-07-01','HK SAR Establishment Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Mid-Autum' and HolidayStartDate = '2014-09-09') then
    insert into Holidays values('Hong Kong','Mid-Autum','2014-09-09','2014-09-09','Mid-Autum',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'National Day' and HolidayStartDate = '2014-10-01') then
    insert into Holidays values('Hong Kong','National Day','2014-10-01','2014-10-01','National Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Chung Yeung' and HolidayStartDate = '2014-10-02') then
    insert into Holidays values('Hong Kong','Chung Yeung','2014-10-02','2014-10-02','Chung Yeung Festival',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Christmas Day' and HolidayStartDate = '2014-12-25') then
    insert into Holidays values('Hong Kong','Christmas Day','2014-12-25','2014-12-25','Christmas Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Christmas Day' and HolidayStartDate = '2014-12-26') then
    insert into Holidays values('Hong Kong','Christmas Day','2014-12-26','2014-12-26','Christmas Day',0,1,0);
end if;

commit work;