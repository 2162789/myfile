
/*PH 2015 Indonesia  */

if exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Tahun Baru Imlek' and HolidayStartDate = '2015-02-18') then
   delete from Holidays where CountryId='Indonesia' and HolidayId = 'Tahun Baru Imlek' and HolidayStartDate = '2015-02-18';
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Tahun Baru Imlek' and HolidayStartDate = '2015-02-19') then
    insert into Holidays values('Indonesia','Tahun Baru Imlek','2015-02-19','2015-02-19','Tahun Baru Imlek (Chinese New Year)',0,1,0);
end if;

if exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Waisak' and HolidayStartDate = '2015-05-03') then
   delete from Holidays where CountryId='Indonesia' and HolidayId = 'Waisak' and HolidayStartDate = '2015-05-03';
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Waisak' and HolidayStartDate = '2015-06-02') then
   insert into Holidays values('Indonesia','Waisak','2015-06-02','2015-06-02','Hari Raya Waisak (Vesak Day)',0,1,0);
end if;

if exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Isra Miraj Muhammad' and HolidayStartDate = '2015-05-15') then
   delete from Holidays where CountryId='Indonesia' and HolidayId = 'Isra Miraj Muhammad' and HolidayStartDate = '2015-05-15';
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Isra Miraj Muhammad' and HolidayStartDate = '2015-05-16') then
   insert into Holidays values('Indonesia','Isra Miraj Muhammad','2015-05-16','2015-05-16','Isra Mi raj Nabi Muhammad SAW',0,1,0);
end if;

if exists(select * from Holidays where CountryId='Indonesia'  and HolidayStartDate = '2015-09-23') then
   delete from Holidays where CountryId='Indonesia'  and HolidayStartDate = '2015-09-23';
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Idul-Adha' and HolidayStartDate = '2015-09-24') then
   insert into Holidays values('Indonesia','Idul-Adha','2015-09-24','2015-09-24','Idul-Adha',0,1,0);
end if;

if exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Tahun Baru Hijrah' and HolidayStartDate = '2015-10-13') then
   delete from Holidays where CountryId='Indonesia' and HolidayId = 'Tahun Baru Hijrah' and HolidayStartDate = '2015-10-13';
end if;

if not exists(select * from Holidays where CountryId='Indonesia' and HolidayId = 'Tahun Baru Hijrah' and HolidayStartDate = '2015-10-14') then
   insert into Holidays values('Indonesia','Tahun Baru Hijrah','2015-10-14','2015-10-14','Tahun Baru 1436 Hijrah (Islamic New Year)',0,1,0);
end if;

if exists(select * from Holidays where CountryId='Indonesia'  and HolidayStartDate = '2015-09-23') then
   delete from Holidays  where CountryId='Indonesia' and HolidayStartDate = '2015-09-23';
end if;


commit work;