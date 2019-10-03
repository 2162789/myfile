if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2016-01-01') then
   insert into Holidays values('Philippines','New Year','2016-01-01','2016-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2016-03-24') then
   insert into Holidays values('Philippines','Maundy Thursday','2016-03-24','2016-03-24','Maundy Thursday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2016-03-25') then
   insert into Holidays values('Philippines','Good Friday','2016-03-25','2016-03-25','Good Friday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2016-04-09') then
   insert into Holidays values('Philippines','Day of Valor','2016-04-09','2016-04-09','Day of Valor',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2016-05-01') then
   insert into Holidays values('Philippines','Labor Day','2016-05-01','2016-05-01','Labor Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2016-06-12') then
   insert into Holidays values('Philippines','Independence Day','2016-06-12','2016-06-12','Independence Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2016-08-29') then
   insert into Holidays values('Philippines','National Heroes','2016-08-29','2016-08-29','National Heroes Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2016-11-30') then
   insert into Holidays values('Philippines','Bonifacio Day','2016-11-30','2016-11-30','Bonifacio Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2016-12-25') then
   insert into Holidays values('Philippines','Christmas Day','2016-12-25','2016-12-25','Christmas Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2016-12-30') then
   insert into Holidays values('Philippines','Rizal Day','2016-12-30','2016-12-30','Rizal Day',0,1,0);
end if;

commit work;
