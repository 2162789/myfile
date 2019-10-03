if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2017-01-01') then
   insert into Holidays values('Philippines','New Year','2017-01-01','2017-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2017-04-13') then
   insert into Holidays values('Philippines','Maundy Thursday','2017-04-13','2017-04-13','Maundy Thursday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2017-04-14') then
   insert into Holidays values('Philippines','Good Friday','2017-04-14','2017-04-14','Good Friday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2017-04-09') then
   insert into Holidays values('Philippines','Day of Valor','2017-04-09','2017-04-09','Day of Valor',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2017-05-01') then
   insert into Holidays values('Philippines','Labor Day','2017-05-01','2017-05-01','Labor Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2017-06-12') then
   insert into Holidays values('Philippines','Independence Day','2017-06-12','2017-06-12','Independence Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2017-08-28') then
   insert into Holidays values('Philippines','National Heroes','2017-08-28','2017-08-28','National Heroes Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2017-11-30') then
   insert into Holidays values('Philippines','Bonifacio Day','2017-11-30','2017-11-30','Bonifacio Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2017-12-25') then
   insert into Holidays values('Philippines','Christmas Day','2017-12-25','2017-12-25','Christmas Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines'  and HolidayStartDate = '2017-12-30') then
   insert into Holidays values('Philippines','Rizal Day','2017-12-30','2017-12-30','Rizal Day',0,1,0);
end if;

commit work;
