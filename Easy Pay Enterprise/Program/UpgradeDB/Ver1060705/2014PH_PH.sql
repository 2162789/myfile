if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'New Year' and HolidayStartDate = '2014-01-01') then
   insert into Holidays values('Philippines','New Year','2014-01-01','2014-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'People Power Day' and HolidayStartDate = '2014-02-25') then
   insert into Holidays values('Philippines','People Power Day','2014-02-25','2014-02-25','People Power Day / Araw ng People Power (Lakas ng Bayan)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Day of Valor' and HolidayStartDate = '2014-04-09') then
   insert into Holidays values('Philippines','Day of Valor','2014-04-09','2014-04-09','Day of Valor',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Maundy Thursday' and HolidayStartDate = '2014-04-17') then
   insert into Holidays values('Philippines','Maundy Thursday','2014-04-17','2014-04-17','Maundy Thursday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Good Friday' and HolidayStartDate = '2014-04-18') then
   insert into Holidays values('Philippines','Good Friday','2014-04-18','2014-04-18','Good Friday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Labor Day' and HolidayStartDate = '2014-05-01') then
   insert into Holidays values('Philippines','Labor Day','2014-05-01','2014-05-01','Labor Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Independence Day' and HolidayStartDate = '2014-06-12') then
   insert into Holidays values('Philippines','Independence Day','2014-06-12','2014-06-12','Independence Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Eidul Fitr' and HolidayStartDate = '2014-07-30') then
   insert into Holidays values('Philippines','Eidul Fitr','2014-07-30','2014-07-30','Eidul Fitr',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'National Heroes' and HolidayStartDate = '2014-08-25') then
   insert into Holidays values('Philippines','National Heroes','2014-08-25','2014-08-25','National Heroes Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Eidul Adha' and HolidayStartDate = '2014-10-05') then
   insert into Holidays values('Philippines','Eidul Adha','2014-10-05','2014-10-05','Eidul Adha',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Bonifacio Day' and HolidayStartDate = '2014-11-30') then
   insert into Holidays values('Philippines','Bonifacio Day','2014-11-30','2014-11-30','Bonifacio Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Christmas Day' and HolidayStartDate = '2014-12-25') then
   insert into Holidays values('Philippines','Christmas Day','2014-12-25','2014-12-25','Christmas Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Rizal Day' and HolidayStartDate = '2014-12-30') then
   insert into Holidays values('Philippines','Rizal Day','2014-12-30','2014-12-30','Rizal Day',0,1,0);
end if;

commit work;
