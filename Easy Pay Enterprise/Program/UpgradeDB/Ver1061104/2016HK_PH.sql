
if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-10-09') then
   insert into Holidays values('Hong Kong','Chung Yeung','2016-10-09','2016-10-09','Chung Yeung',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Hong Kong' and HolidayStartDate = '2016-12-25') then
   insert into Holidays values('Hong Kong','Christmas Day','2016-12-25','2016-12-25','Christmas Day',0,1,0);
end if;



commit work;