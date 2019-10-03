begin

declare In_Country char(20);
  select FGetDBCountry(*) into In_Country;

if(In_Country = 'HongKong') then

if (not exists(select * from Holidays Where CountryId='Hong Kong' and Year(HolidayStartDate) = 2012)) then
    insert into Holidays values('Hong Kong','New Year','2012-01-01','2012-01-01','New Year',0,1,0);
    insert into Holidays values('Hong Kong','New Year','2012-01-02','2012-01-02','New Year',0,1,0);
    insert into Holidays values('Hong Kong','Lunar New Year','2012-01-23','2012-01-23','Lunar New Year',0,1,0);
    insert into Holidays values('Hong Kong','Lunar New Year','2012-01-24','2012-01-24','Lunar New Year',0,1,0);
    insert into Holidays values('Hong Kong','Lunar New Year','2012-01-25','2012-01-25','Lunar New Year',0,1,0);
    insert into Holidays values('Hong Kong','Ching Ming','2012-04-04','2012-04-04','Ching Ming Festival',0,1,0);
    insert into Holidays values('Hong Kong','Good Friday','2012-04-06','2012-04-06','Good Friday',0,1,0);
    insert into Holidays values('Hong Kong','Good Friday','2012-04-07','2012-04-07','Good Friday',0,1,0);
    insert into Holidays values('Hong Kong','Easter Monday','2012-04-09','2012-04-09','Easter Monday',0,1,0);
    insert into Holidays values('Hong Kong','Buddha Birthday','2012-04-28','2012-04-28','The Buddha Birthday',0,1,0);
    insert into Holidays values('Hong Kong','Labour Day','2012-05-01','2012-05-01','Labour Day',0,1,0);
    insert into Holidays values('Hong Kong','Tuen Ng','2012-06-23','2012-06-23','Tuen Ng Festival',0,1,0);
    insert into Holidays values('Hong Kong','HK SAR','2012-07-01','2012-07-01','HK SAR Establishment Day',0,1,0);
    insert into Holidays values('Hong Kong','HK SAR','2012-07-02','2012-07-02','HK SAR Establishment Day',0,1,0);
    insert into Holidays values('Hong Kong','Mid-Autum','2012-10-01','2012-10-01','Mid-Autum',0,1,0);
    insert into Holidays values('Hong Kong','National Day','2012-10-02','2012-10-02','National Day',0,1,0);
    insert into Holidays values('Hong Kong','Chung Yeung','2012-10-23','2012-10-23','Chung Yeung Festival',0,1,0);
    insert into Holidays values('Hong Kong','Christmas Day','2012-12-25','2012-12-25','Christmas Day',0,1,0);
    insert into Holidays values('Hong Kong','Christmas Day','2012-12-26','2012-12-26','Christmas Day',0,1,0);
end if;

end if;

commit work;

end