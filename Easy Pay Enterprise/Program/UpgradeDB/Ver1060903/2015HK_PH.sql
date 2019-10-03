if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'New Year' and HolidayStartDate = '2015-01-01') then
   insert into Holidays values('Hong Kong','New Year','2015-01-01','2015-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Lunar New Year' and HolidayStartDate = '2015-02-19') then
   insert into Holidays values('Hong Kong','Lunar New Year','2015-02-19','2015-02-19','Lunar New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Lunar New Year' and HolidayStartDate = '2015-02-20') then
   insert into Holidays values('Hong Kong','Lunar New Year','2015-02-20','2015-02-20','Lunar New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Lunar New Year' and HolidayStartDate = '2015-02-21') then
   insert into Holidays values('Hong Kong','Lunar New Year','2015-02-21','2015-02-21','Lunar New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Good Friday' and HolidayStartDate = '2015-04-03') then
   insert into Holidays values('Hong Kong','Good Friday','2015-04-03','2015-04-03','Good Friday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Ching Ming' and HolidayStartDate = '2015-04-04') then
   insert into Holidays values('Hong Kong','Ching Ming','2015-04-04','2015-04-04','Ching Ming',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Easter Monday' and HolidayStartDate = '2015-04-06') then
   insert into Holidays values('Hong Kong','Easter Monday','2015-04-06','2015-04-06','Easter Monday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Easter Monday' and HolidayStartDate = '2015-04-07') then
   insert into Holidays values('Hong Kong','Easter Monday','2015-04-07','2015-04-07','Easter Monday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Labour Day' and HolidayStartDate = '2015-05-01') then
   insert into Holidays values('Hong Kong','Labour Day','2015-05-01','2015-05-01','Labour Day',0,1,0);	
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Buddha Birthday' and HolidayStartDate = '2015-05-25') then
   insert into Holidays values('Hong Kong','Buddha Birthday','2015-05-25','2015-05-25','The Buddha Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Tuen Ng' and HolidayStartDate = '2015-06-20') then
   insert into Holidays values('Hong Kong','Tuen Ng','2015-06-20','2015-06-20','Tuen Ng Festival',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'HK SAR' and HolidayStartDate = '2015-07-01') then
   insert into Holidays values('Hong Kong','HK SAR','2015-07-01','2015-07-01','HK SAR Establishment Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Mid-Autum' and HolidayStartDate = '2015-09-28') then
    insert into Holidays values('Hong Kong','Mid-Autum','2015-09-28','2015-09-28','Mid-Autum',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'National Day' and HolidayStartDate = '2015-10-01') then
    insert into Holidays values('Hong Kong','National Day','2015-10-01','2015-10-01','National Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Chung Yeung' and HolidayStartDate = '2015-10-21') then
    insert into Holidays values('Hong Kong','Chung Yeung','2015-10-21','2015-10-21','Chung Yeung Festival',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-25') then
    insert into Holidays values('Hong Kong','Christmas Day','2015-12-25','2015-12-25','Christmas Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-26') then
    insert into Holidays values('Hong Kong','Christmas Day','2015-12-26','2015-12-26','Christmas Day',0,1,0);
end if;

commit work;