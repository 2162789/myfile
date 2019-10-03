begin

declare In_Country char(20);
  select FGetDBCountry(*) into In_Country;

if(In_Country = 'Indonesia') then

if (not exists(select * from Holidays Where CountryId='Indonesia' and Year(HolidayStartDate) = 2011)) then
    insert into Holidays values('Indonesia','New Year Day','2011-01-01','2011-01-01','New Year Day',0,1,0);
    insert into Holidays values('Indonesia','New Year Day','2011-01-02','2011-01-02','New Year Day',0,0,0);
    insert into Holidays values('Indonesia','Tahun Baru Imlek','2011-02-03','2011-02-03','Tahun Baru Imlek 2562 (Chinese New Year)',0,1,0);
    insert into Holidays values('Indonesia','Mohammed Birthday','2011-02-15','2011-02-15','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('Indonesia','Hari Nyepi','2011-03-05','2011-03-05','Hari Nyepi or Bali Day of Absolute Silence',0,1,0);
    insert into Holidays values('Indonesia','Good Friday','2011-04-22','2011-04-22','Wafat Yesus Kristus (Good Friday)',0,1,0);
    insert into Holidays values('Indonesia','Easter Sunday','2011-04-24','2011-04-24','Easter Sunday',0,0,0);
    insert into Holidays values('Indonesia','Waisak','2011-05-17','2011-05-17','Hari Raya Waisak (Wesak Day)',0,1,0);
    insert into Holidays values('Indonesia','Ascension of Christ','2011-06-02','2011-06-02','Ascension of Jesus Christ',0,1,0);
    insert into Holidays values('Indonesia','Isra Miraj Muhammad','2011-06-29','2011-06-29','Isra Mi raj Nabi Muhammad SAW',0,1,0);
    insert into Holidays values('Indonesia','Independence Day','2011-08-17','2011-08-17','Hari Kemerdekaan (National Day)',0,1,0);
    insert into Holidays values('Indonesia','Idul Fitri','2011-08-29','2011-08-29','Idul Fitri',0,1,0);
    insert into Holidays values('Indonesia','Idul Fitri','2011-08-30','2011-08-30','Idul Fitri',0,1,0);
    insert into Holidays values('Indonesia','Idul Fitri','2011-08-31','2011-08-31','Idul Fitri',0,1,0);
    insert into Holidays values('Indonesia','Idul Fitri','2011-09-01','2011-09-01','Idul Fitri',0,1,0);
    insert into Holidays values('Indonesia','Idul Fitri','2011-09-02','2011-09-02','Idul Fitri',0,1,0);
    insert into Holidays values('Indonesia','Idul Adha','2011-11-06','2011-11-06','Idul-Adha',0,0,0);
    insert into Holidays values('Indonesia','Tahun Baru Hijrah','2011-11-27','2011-11-27','Tahun Baru 1433 Hijrah (Islamic New Year)',0,0,0);
    insert into Holidays values('Indonesia','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);
    insert into Holidays values('Indonesia','Christmas Day','2011-12-26','2011-12-26','Christmas Day',0,1,0);
end if;

elseif(In_Country = 'Philippines') then

if (not exists(select * from Holidays Where CountryId='Philippines' and Year(HolidayStartDate) = 2011)) then
    insert into Holidays values('Philippines','New Year','2011-01-01','2011-01-01','New Year',0,1,0);
    insert into Holidays values('Philippines','People Power Day','2011-02-25','2011-02-25','People Power Day / Araw ng People Power (Lakas ng Bayan)',0,1,0);
    insert into Holidays values('Philippines','Maundy Thursday','2011-04-21','2011-04-21','Maundy Thursday',0,1,0);
    insert into Holidays values('Philippines','Good Friday','2011-04-22','2011-04-22','Good Friday',0,1,0);
    insert into Holidays values('Philippines','Easter Sunday','2011-04-24','2011-04-24','Easter Sunday',0,0,0);
    insert into Holidays values('Philippines','Araw ng Kagitingan','2011-04-11','2011-04-11','Araw ng Kagitingan (Bataan Day)',0,1,0);
    insert into Holidays values('Philippines','Labor Day','2011-05-02','2011-05-02','Labor Day',0,1,0);
    insert into Holidays values('Philippines','Independence Day','2011-06-13','2011-06-13','Independence Day',0,1,0);
    insert into Holidays values('Philippines','Ninoy Aquino Day','2011-08-22','2011-08-22','Ninoy Aquino Day',0,1,0);
    insert into Holidays values('Philippines','National Heroes','2011-08-29','2011-08-29','National Heroes Day',0,1,0);
    insert into Holidays values('Philippines','All Saints','2011-11-01','2011-11-01','All Saints Day',0,1,0);
    insert into Holidays values('Philippines','Bonifacio Day','2011-11-28','2011-11-28','Bonifacio Day',0,1,0);
    insert into Holidays values('Philippines','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);
    insert into Holidays values('Philippines','Rizal Day','2011-12-26','2011-12-26','Rizal Day',0,1,0);
    insert into Holidays values('Philippines','Last Day of Year','2011-12-31','2011-12-31','Last Day of year',0,1,0);
end if;

elseif(In_Country = 'Thailand') then

if (not exists(select * from Holidays Where CountryId='Thailand' and Year(HolidayStartDate) = 2011)) then
    insert into Holidays values('Thailand','New Year','2011-01-01','2011-01-01','New Year',0,1,0);
    insert into Holidays values('Thailand','Magha Bucha','2011-02-18','2011-02-018','Magha Bucha Day',0,1,0);
    insert into Holidays values('Thailand','Chakri Day','2011-04-06','2011-04-06','Chakri Day',0,1,0);
    insert into Holidays values('Thailand','Songkran','2011-04-13','2011-04-13','Songkran - Thai New Year',0,1,0);
    insert into Holidays values('Thailand','Songkran','2011-04-14','2011-04-14','Songkran - Thai New Year',0,1,0);
    insert into Holidays values('Thailand','Songkran','2011-04-15','2011-04-15','Songkran - Thai New Year',0,1,0);
    insert into Holidays values('Thailand','Labour Day','2011-05-01','2011-05-01','Labour Day',0,0,0);
    insert into Holidays values('Thailand','Coronation Day','2011-05-05','2011-05-05','Coronation Day',0,1,0);
    insert into Holidays values('Thailand','Visakha Bucha Day','2011-05-17','2011-05-17','Visakha Bucha Day',0,1,0);
    insert into Holidays values('Thailand','Buddhist Lent Day','2011-07-15','2011-07-15','Buddhist Lent Day',0,1,0);
    insert into Holidays values('Thailand','Asahna Bucha Day','2011-07-16','2011-07-16','Asahna Bucha Day',0,1,0);
    insert into Holidays values('Thailand','Queen Birthday','2011-08-12','2011-08-12','Queen Birthday',0,1,0);
    insert into Holidays values('Thailand','Chulalongkorn Day','2011-10-23','2011-10-23','King Chulalongkorn Day',0,0,0);
    insert into Holidays values('Thailand','King Birthday','2011-12-05','2011-12-05','King Birthday',0,1,0);
    insert into Holidays values('Thailand','Constitution Day','2011-12-10','2011-12-10','Constitution Day',0,1,0);
    insert into Holidays values('Thailand','New Year Eve','2011-12-31','2011-12-31','New Year Eve',0,1,0);
end if;

elseif(In_Country = 'Brunei') then

if (not exists(select * from Holidays Where CountryId='Brunei' and Year(HolidayStartDate) = 2011)) then
    insert into Holidays values('Brunei','New Year','2011-01-01','2011-01-01','New Year Day',0,1,0);
    insert into Holidays values('Brunei','Chinese NY','2011-02-03','2011-02-03','Chinese New Year',0,1,0);
    insert into Holidays values('Brunei','Prophet Birthday','2011-02-15','2011-02-15','Birthday of the Prophet Mohammed S.A.W.',0,1,0);
    insert into Holidays values('Brunei','National Day','2011-02-23','2011-02-23','National Day',0,1,0);
    insert into Holidays values('Brunei','Anniversary RBReg','2011-05-31','2011-05-31','Anniversary of Royal Brunei Regiment',0,1,0);
    insert into Holidays values('Brunei','IsrakMijraj','2011-06-29','2011-06-29','Israk Mijraj (Acension of The Prophet Muhammad)',0,1,0);
    insert into Holidays values('Brunei','Sultan Birthday','2011-07-16','2011-07-16','H.M. the Sultan and Yang Di-pertuan Negara Brunei Darussalam Birthday',0,1,0);
    insert into Holidays values('Brunei','Ramadan','2011-08-01','2011-08-01','Start of Ramadan',0,1,0);
    insert into Holidays values('Brunei','Revelation of Quran','2011-08-17','2011-08-17','Anniversary Of Revelation of Quran',0,1,0);
    insert into Holidays values('Brunei','Eid Al Fitr','2011-08-30','2011-08-30','Eid Al Fitr',0,1,0);
    insert into Holidays values('Brunei','Eid Al Fitr','2011-08-31','2011-08-31','Eid Al Fitr',0,1,0);
    insert into Holidays values('Brunei','Eid Al Adha','2011-11-07','2011-11-07','Eid Al Adha',0,1,0);
    insert into Holidays values('Brunei','FirstDayHijrah','2011-11-28','2011-11-28','First Day of Hijrah 1432',0,1,0);
    insert into Holidays values('Brunei','Christmas Day','2011-12-26','2011-12-26','Christmas Day',0,1,0);
end if;

elseif(In_Country = 'HongKong') then

if (not exists(select * from Holidays Where CountryId='Hong Kong' and Year(HolidayStartDate) = 2011)) then
    insert into Holidays values('Hong Kong','New Year','2011-01-01','2011-01-01','New Year',0,1,0);
    insert into Holidays values('Hong Kong','Lunar New Year','2011-02-03','2011-02-03','Lunar New Year',0,1,0);
    insert into Holidays values('Hong Kong','Lunar New Year','2011-02-04','2011-02-04','Lunar New Year',0,1,0);
    insert into Holidays values('Hong Kong','Lunar New Year','2011-02-05','2011-02-05','Lunar New Year',0,1,0);
    insert into Holidays values('Hong Kong','Ching Ming','2011-04-05','2011-04-05','Ching Ming Festival',0,1,0);
    insert into Holidays values('Hong Kong','Good Friday','2011-04-22','2011-04-22','Good Friday',0,1,0);
    insert into Holidays values('Hong Kong','Good Friday','2011-04-23','2011-04-23','Good Friday',0,1,0);
    insert into Holidays values('Hong Kong','Easter Monday','2011-04-25','2011-04-25','Easter Monday',0,1,0);
    insert into Holidays values('Hong Kong','Labour Day','2011-05-02','2011-05-02','Labour Day',0,1,0);
    insert into Holidays values('Hong Kong','Buddha Birthday','2011-05-10','2011-05-10','The Buddha Birthday',0,1,0);
    insert into Holidays values('Hong Kong','Tuen Ng','2011-06-06','2011-06-06','Tuen Ng Festival',0,1,0);
    insert into Holidays values('Hong Kong','HK SAR','2011-07-01','2011-07-01','HK SAR Establishment Day',0,1,0);
    insert into Holidays values('Hong Kong','Mid-Autum','2011-09-13','2011-09-13','Mid-Autum',0,1,0);
    insert into Holidays values('Hong Kong','National Day','2011-10-01','2011-10-01','National Day',0,1,0);
    insert into Holidays values('Hong Kong','Chung Yeung','2011-10-05','2011-10-05','Chung Yeung Festival',0,1,0);
    insert into Holidays values('Hong Kong','Christmas Day','2011-12-26','2011-12-26','Christmas Day',0,1,0);
    insert into Holidays values('Hong Kong','Christmas Day','2011-12-27','2011-12-27','Christmas Day',0,1,0);
end if;

end if;

commit work;

end