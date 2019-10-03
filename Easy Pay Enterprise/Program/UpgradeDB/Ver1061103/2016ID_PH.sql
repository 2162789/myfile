if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2016-01-01') then
   insert into Holidays values('Indonesia','New Year','2016-01-01','2016-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2016-02-08') then
   insert into Holidays values('Indonesia','Tahun Baru Imlek','2016-02-08','2016-02-08','Tahun Baru Imlek (Chinese New Year)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2016-03-09') then
   insert into Holidays values('Indonesia','Hari Raya Nyepi','2016-03-09','2016-03-09','Hari Raya Nyepi (Day of Silence)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2016-03-25') then
   insert into Holidays values('Indonesia','Good Friday','2016-03-25','2016-03-25','Jumat Agung (Good Friday)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2016-05-01') then
   insert into Holidays values('Indonesia','Hari Buruh','2016-05-01','2016-05-01','Hari Buruh Internasional (International Workers Day)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2016-05-05') then
   insert into Holidays values('Indonesia','Ascension of Christ','2016-05-05','2016-05-05','Ascension of Jesus Christ',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2016-05-06') then
   insert into Holidays values('Indonesia','Ascension of the Prophet','2016-05-06','2016-05-06','Ascension of the Prophet',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2016-05-22') then
   insert into Holidays values('Indonesia','Waisak','2016-05-22','2016-05-22','Hari Raya Waisak (Vesak Day)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2016-07-06') then
   insert into Holidays values('Indonesia','Idul Fitri','2016-07-06','2016-07-06','Idul Fitri',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2016-07-07') then
   insert into Holidays values('Indonesia','Idul Fitri','2016-07-07','2016-07-07','Idul Fitri',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2016-08-17') then
   insert into Holidays values('Indonesia','Independence Day','2016-08-17','2016-08-17','Hari Kemerdekaan (National Day)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2016-09-12') then
   insert into Holidays values('Indonesia','Idul Adha','2016-09-12','2016-09-12','Idul-Adha',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2016-10-02') then
   insert into Holidays values('Indonesia','Tahun Baru Hijrah','2016-10-02','2016-10-02','Tahun Baru  Hijrah (Islamic New Year)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2016-12-12') then
   insert into Holidays values('Indonesia','The Prophet Muhammad Birthday','2016-12-12','2016-12-12','The Prophet Muhammad Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2016-12-25') then
   insert into Holidays values('Indonesia','Christmas Day','2016-12-25','2016-12-25','Christmas Day',0,1,0);
end if;
commit work;