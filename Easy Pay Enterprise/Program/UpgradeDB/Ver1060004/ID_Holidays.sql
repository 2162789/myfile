begin

declare In_Country char(20);
  select FGetDBCountry(*) into In_Country;

if(In_Country = 'Indonesia') then

if (not exists(select * from Holidays Where CountryId='Indonesia' and Year(HolidayStartDate) = 2012)) then
    insert into Holidays values('Indonesia','New Year Day','2012-01-01','2012-01-01','New Year Day',0,1,0);
    insert into Holidays values('Indonesia','New Year Day','2012-01-02','2012-01-02','New Year Day',0,1,0);
    insert into Holidays values('Indonesia','Tahun Baru Imlek','2012-01-23','2012-01-23','Tahun Baru Imlek (Chinese New Year)',0,1,0);
    insert into Holidays values('Indonesia','Mohammed Birthday','2012-02-04','2012-02-04','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('Indonesia','Hari Nyepi','2012-03-23','2012-03-23','Hari Nyepi or Bali Day of Absolute Silence',0,1,0);
    insert into Holidays values('Indonesia','Good Friday','2012-04-06','2012-04-06','Wafat Yesus Kristus (Good Friday)',0,1,0);
    insert into Holidays values('Indonesia','Waisak','2012-05-05','2012-05-05','Hari Raya Waisak (Wesak Day)',0,1,0);
    insert into Holidays values('Indonesia','Ascension of Christ','2012-05-17','2012-05-17','Ascension of Jesus Christ',0,1,0);
    insert into Holidays values('Indonesia','Isra Miraj Muhammad','2012-06-16','2012-06-16','Isra Mi raj Nabi Muhammad SAW',0,1,0);
    insert into Holidays values('Indonesia','Independence Day','2012-08-17','2012-08-17','Hari Kemerdekaan (National Day)',0,1,0);
    insert into Holidays values('Indonesia','Idul Fitri','2012-08-19','2012-08-19','Idul Fitri',0,1,0);
    insert into Holidays values('Indonesia','Idul Fitri','2012-08-20','2012-08-20','Idul Fitri',0,1,0);
    insert into Holidays values('Indonesia','Idul Adha','2012-10-26','2012-10-26','Idul-Adha',0,0,0);
    insert into Holidays values('Indonesia','Tahun Baru Hijrah','2012-11-15','2012-11-15','Tahun Baru 1433 Hijrah (Islamic New Year)',0,0,0);
    insert into Holidays values('Indonesia','Christmas Day','2012-12-25','2012-12-25','Christmas Day',0,0,0);
end if;

end if;

commit work;

end