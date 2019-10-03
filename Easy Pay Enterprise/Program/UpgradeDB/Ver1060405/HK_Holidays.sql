begin

declare In_Country char(20);
  select FGetDBCountry(*) into In_Country;

if(In_Country = 'HongKong') then

if (not exists(select * from Holidays Where CountryId='Hong Kong' and Year(HolidayStartDate) = 2013)) then
    insert into Holidays values('Hong Kong','New Year','2013-01-01','2013-01-01','New Year',0,1,0);
    insert into Holidays values('Hong Kong','Lunar New Year','2013-02-10','2013-02-10','Lunar New Year',0,1,0);
    insert into Holidays values('Hong Kong','Lunar New Year','2013-02-11','2013-02-11','Lunar New Year',0,1,0);
    insert into Holidays values('Hong Kong','Lunar New Year','2013-02-12','2013-02-12','Lunar New Year',0,1,0);
    insert into Holidays values('Hong Kong','Lunar New Year','2013-02-13','2013-02-13','Lunar New Year',0,1,0);
    insert into Holidays values('Hong Kong','Good Friday','2013-03-29','2013-03-29','Good Friday',0,1,0);
    insert into Holidays values('Hong Kong','Good Friday','2013-03-30','2013-03-30','Good Friday',0,1,0);
    insert into Holidays values('Hong Kong','Easter Monday','2013-04-01','2013-04-01','Easter Monday',0,1,0);
    insert into Holidays values('Hong Kong','Ching Ming','2013-04-04','2013-04-04','Ching Ming Festival',0,1,0);
    insert into Holidays values('Hong Kong','Labour Day','2013-05-01','2013-05-01','Labour Day',0,1,0);	
    insert into Holidays values('Hong Kong','Buddha Birthday','2013-05-17','2013-05-17','The Buddha Birthday',0,1,0);
    insert into Holidays values('Hong Kong','Tuen Ng','2013-06-12','2013-06-12','Tuen Ng Festival',0,1,0);
    insert into Holidays values('Hong Kong','HK SAR','2013-07-01','2013-07-01','HK SAR Establishment Day',0,1,0);
    insert into Holidays values('Hong Kong','Mid-Autum','2013-09-20','2013-09-20','Mid-Autum',0,1,0);
    insert into Holidays values('Hong Kong','National Day','2013-10-01','2013-10-01','National Day',0,1,0);
    insert into Holidays values('Hong Kong','Chung Yeung','2013-10-13','2013-10-13','Chung Yeung Festival',0,1,0);
    insert into Holidays values('Hong Kong','Chung Yeung','2013-10-14','2013-10-14','Chung Yeung Festival',0,1,0);
    insert into Holidays values('Hong Kong','Christmas Day','2013-12-25','2013-12-25','Christmas Day',0,1,0);
    insert into Holidays values('Hong Kong','Christmas Day','2013-12-26','2013-12-26','Christmas Day',0,1,0);
end if;

end if;

commit work;

end