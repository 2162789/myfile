if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'New Year Day' and HolidayStartDate = '2015-01-01') then
   insert into Holidays values('Indonesia','New Year Day','2015-01-01','2015-01-01','New Year Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Mohammed Birthday' and HolidayStartDate = '2015-01-03') then
   insert into Holidays values('Indonesia','Mohammed Birthday','2015-01-03','2015-01-03','Prophet Muhammad Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Tahun Baru Imlek' and HolidayStartDate = '2015-02-18') then
   insert into Holidays values('Indonesia','Tahun Baru Imlek','2015-02-18','2015-02-18','Tahun Baru Imlek (Chinese New Year)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Nyepi Tahun BaruSaka' and HolidayStartDate = '2015-03-21') then
   insert into Holidays values('Indonesia','Nyepi Tahun BaruSaka','2015-03-21','2015-03-21','Nyepi Tahun Baru Saka (Day of Silence)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Good Friday' and HolidayStartDate = '2015-04-03') then
   insert into Holidays values('Indonesia','Good Friday','2015-04-03','2015-04-03','Wafat Yesus Kristus (Good Friday)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Hari Buruh' and HolidayStartDate = '2015-05-01') then
   insert into Holidays values('Indonesia','Hari Buruh','2015-05-01','2015-05-01','Hari Buruh Internasional (International Workers Day)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Waisak' and HolidayStartDate = '2015-05-03') then
   insert into Holidays values('Indonesia','Waisak','2015-05-03','2015-05-03','Hari Raya Waisak (Vesak Day)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Ascension of Christ' and HolidayStartDate = '2015-05-14') then
   insert into Holidays values('Indonesia','Ascension of Christ','2015-05-14','2015-05-14','Ascension of Jesus Christ',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Isra Miraj Muhammad' and HolidayStartDate = '2015-05-15') then
   insert into Holidays values('Indonesia','Isra Miraj Muhammad','2015-05-15','2015-05-15','Isra Mi raj Nabi Muhammad SAW',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Idul Fitri' and HolidayStartDate = '2015-07-17') then
   insert into Holidays values('Indonesia','Idul Fitri','2015-07-17','2015-07-17','Idul Fitri',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Idul Fitri' and HolidayStartDate = '2015-07-18') then
   insert into Holidays values('Indonesia','Idul Fitri','2015-07-18','2015-07-18','Idul Fitri',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Independence Day' and HolidayStartDate = '2015-08-17') then
   insert into Holidays values('Indonesia','Independence Day','2015-08-17','2015-08-17','Hari Kemerdekaan (National Day)',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Idul Adha' and HolidayStartDate = '2015-09-23') then
   insert into Holidays values('Indonesia','Idul Adha','2015-09-23','2015-09-23','Idul-Adha',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Tahun Baru Hijrah' and HolidayStartDate = '2015-10-13') then
   insert into Holidays values('Indonesia','Tahun Baru Hijrah','2015-10-13','2015-10-13','Tahun Baru 1436 Hijrah (Islamic New Year)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-25') then
   insert into Holidays values('Indonesia','Christmas Day','2015-12-25','2015-12-25','Christmas Day',0,1,0);
end if;

commit work;