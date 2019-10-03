begin

declare In_Country char(20);
  select FGetDBCountry(*) into In_Country;

if(In_Country = 'Indonesia') then

if (not exists(select * from Holidays Where CountryId='Indonesia' and Year(HolidayStartDate) = 2013)) then
    insert into Holidays values('Indonesia','New Year Day','2013-01-01','2013-01-01','New Year Day',0,1,0);
    insert into Holidays values('Indonesia','Tahun Baru Imlek','2013-02-09','2013-02-09','Tahun Baru Imlek (Chinese New Year)',0,1,0);
    insert into Holidays values('Indonesia','Hari Nyepi','2013-03-12','2013-03-12','Hari Nyepi or Bali Day of Absolute Silence',0,1,0);
    insert into Holidays values('Indonesia','Mohammed Birthday','2013-03-24','2013-03-24','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('Indonesia','Mohammed Birthday','2013-03-25','2013-03-25','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('Indonesia','Good Friday','2013-03-29','2013-03-29','Wafat Yesus Kristus (Good Friday)',0,1,0);
    insert into Holidays values('Indonesia','Ascension of Christ','2013-05-09','2013-05-09','Ascension of Jesus Christ',0,1,0);
    insert into Holidays values('Indonesia','Waisak','2013-05-25','2013-05-25','Hari Raya Waisak (Wesak Day)',0,1,0);
    insert into Holidays values('Indonesia','Isra Miraj Muhammad','2013-06-06','2013-06-06','Isra Mi raj Nabi Muhammad SAW',0,1,0);
    insert into Holidays values('Indonesia','Idul Fitri','2013-08-08','2013-08-08','Idul Fitri',0,1,0);
    insert into Holidays values('Indonesia','Idul Fitri','2013-08-09','2013-08-09','Idul Fitri',0,1,0);
    insert into Holidays values('Indonesia','Independence Day','2013-08-17','2013-08-17','Hari Kemerdekaan (National Day)',0,1,0);
    insert into Holidays values('Indonesia','Idul Adha','2013-10-15','2013-10-15','Idul-Adha',0,1,0);
    insert into Holidays values('Indonesia','Tahun Baru Hijrah','2013-11-05','2013-11-05','Tahun Baru 1435 Hijrah (Islamic New Year)',0,1,0);
    insert into Holidays values('Indonesia','Christmas Day','2013-12-25','2013-12-25','Christmas Day',0,1,0);
end if;

end if;

commit work;

end