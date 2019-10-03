if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2017-01-01') then
   insert into Holidays values('Indonesia','New Year','2017-01-01','2017-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2017-01-28') then
   insert into Holidays values('Indonesia','Tahun Baru Imlek','2017-01-28','2017-01-28','Tahun Baru Imlek (Chinese New Year)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2017-03-28') then
   insert into Holidays values('Indonesia','Hari Raya Nyepi','2017-03-28','2017-03-28','Hari Raya Nyepi (Day of Silence)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2017-04-14') then
   insert into Holidays values('Indonesia','Good Friday','2017-04-14','2017-04-14','Jumat Agung (Good Friday)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2017-04-24') then
   insert into Holidays values('Indonesia','Ascension of the Prophet','2017-04-24','2017-04-24','Ascension of the Prophet',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2017-05-01') then
   insert into Holidays values('Indonesia','Hari Buruh','2017-05-01','2017-05-01','Hari Buruh Internasional (International Workers Day)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2017-05-11') then
   insert into Holidays values('Indonesia','Waisak','2017-05-11','2017-05-11','Hari Raya Waisak (Vesak Day)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2017-05-25') then
   insert into Holidays values('Indonesia','Ascension of Jesus Christ','2017-05-25','2017-05-25','Ascension of Jesus Christ',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2017-06-01') then
   insert into Holidays values('Indonesia','Hari Lahir Pancasila','2017-06-01','2017-06-01','Hari Lahir Pancasila',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2017-06-25') then
   insert into Holidays values('Indonesia','Idul Fitri','2017-06-25','2017-06-25','Idul Fitri',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2017-06-26') then
   insert into Holidays values('Indonesia','Idul Fitri','2017-06-26','2017-06-26','Idul Fitri',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2017-08-17') then
   insert into Holidays values('Indonesia','Independence Day','2017-08-17','2017-08-17','Hari Kemerdekaan (National Day)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2017-09-01') then
  insert into Holidays values('Indonesia','Idul Adha','2017-09-01','2017-09-01','Idul-Adha',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2017-09-21') then
   insert into Holidays values('Indonesia','Tahun Baru Hijrah','2017-09-21','2017-09-21','Tahun Baru  Hijrah (Islamic New Year)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2017-12-01') then
   insert into Holidays values('Indonesia','The Prophet Muhammad''s Birthday','2017-12-01','2017-12-01','The Prophet Muhammad''s Birthday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayStartDate = '2017-12-25') then
   insert into Holidays values('Indonesia','Christmas Day','2017-12-25','2017-12-25','Christmas Day',0,1,0);
end if;

commit work;
