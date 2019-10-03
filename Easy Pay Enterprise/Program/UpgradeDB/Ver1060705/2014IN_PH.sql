if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'New Year Day' and HolidayStartDate = '2014-01-01') then
   insert into Holidays values('Indonesia','New Year Day','2014-01-01','2014-01-01','New Year Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Mohammed Birthday' and HolidayStartDate = '2014-01-14') then
   insert into Holidays values('Indonesia','Mohammed Birthday','2014-01-14','2014-01-14','Prophet Muhammad Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Tahun Baru Imlek' and HolidayStartDate = '2014-01-31') then
   insert into Holidays values('Indonesia','Tahun Baru Imlek','2014-01-31','2014-01-31','Tahun Baru Imlek (Chinese New Year)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Nyepi Tahun BaruSaka' and HolidayStartDate = '2014-03-31') then
   insert into Holidays values('Indonesia','Nyepi Tahun BaruSaka','2014-03-31','2014-03-31','Nyepi Tahun Baru Saka (Day of Silence)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Good Friday' and HolidayStartDate = '2014-04-18') then
   insert into Holidays values('Indonesia','Good Friday','2014-04-18','2014-04-18','Wafat Yesus Kristus (Good Friday)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Hari Buruh' and HolidayStartDate = '2014-05-01') then
   insert into Holidays values('Indonesia','Hari Buruh','2014-05-01','2014-05-01','Hari Buruh Internasional (International Workers Day)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Waisak' and HolidayStartDate = '2014-05-15') then
   insert into Holidays values('Indonesia','Waisak','2014-05-15','2014-05-15','Hari Raya Waisak (Vesak Day)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Isra Miraj Muhammad' and HolidayStartDate = '2014-05-27') then
   insert into Holidays values('Indonesia','Isra Miraj Muhammad','2014-05-27','2014-05-27','Isra Mi raj Nabi Muhammad SAW',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Ascension of Christ' and HolidayStartDate = '2014-05-29') then
   insert into Holidays values('Indonesia','Ascension of Christ','2014-05-29','2014-05-29','Ascension of Jesus Christ',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Idul Fitri' and HolidayStartDate = '2014-07-28') then
   insert into Holidays values('Indonesia','Idul Fitri','2014-07-28','2014-07-28','Idul Fitri',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Idul Fitri' and HolidayStartDate = '2014-07-29') then
   insert into Holidays values('Indonesia','Idul Fitri','2014-07-29','2014-07-29','Idul Fitri',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Independence Day' and HolidayStartDate = '2014-08-17') then
   insert into Holidays values('Indonesia','Independence Day','2014-08-17','2014-08-17','Hari Kemerdekaan (National Day)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Independence Day' and HolidayStartDate = '2014-08-18') then
   insert into Holidays values('Indonesia','Independence Day','2014-08-18','2014-08-18','Hari Kemerdekaan (National Day)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Idul Adha' and HolidayStartDate = '2014-10-05') then
   insert into Holidays values('Indonesia','Idul Adha','2014-10-05','2014-10-05','Idul-Adha',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Idul Adha' and HolidayStartDate = '2014-10-06') then
   insert into Holidays values('Indonesia','Idul Adha','2014-10-06','2014-10-06','Idul-Adha',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Tahun Baru Hijrah' and HolidayStartDate = '2014-10-25') then
   insert into Holidays values('Indonesia','Tahun Baru Hijrah','2014-10-25','2014-10-25','Tahun Baru 1436 Hijrah (Islamic New Year)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Christmas Day' and HolidayStartDate = '2014-12-25') then
   insert into Holidays values('Indonesia','Christmas Day','2014-12-25','2014-12-25','Christmas Day',0,1,0);
end if;

commit work;