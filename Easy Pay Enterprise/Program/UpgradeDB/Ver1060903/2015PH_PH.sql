if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'New Year' and HolidayStartDate = '2015-01-01') then
   insert into Holidays values('Philippines','New Year','2015-01-01','2015-01-01','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'New Year' and HolidayStartDate = '2015-01-02') then
   insert into Holidays values('Philippines','New Year','2015-01-02','2015-01-02','New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Chinese New Year' and HolidayStartDate = '2015-02-19') then
   insert into Holidays values('Philippines','Chinese New Year','2015-02-19','2015-02-19','Chinese New Year',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'People Power Day' and HolidayStartDate = '2015-02-25') then
   insert into Holidays values('Philippines','People Power Day','2015-02-25','2015-02-25','People Power Day / Araw ng People Power (Lakas ng Bayan)',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Maundy Thursday' and HolidayStartDate = '2015-04-02') then
   insert into Holidays values('Philippines','Maundy Thursday','2015-04-02','2015-04-02','Maundy Thursday',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Good Friday' and HolidayStartDate = '2015-04-03') then
   insert into Holidays values('Philippines','Good Friday','2015-04-03','2015-04-03','Good Friday',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Black Saturday' and HolidayStartDate = '2015-04-04') then
   insert into Holidays values('Philippines','Black Saturday','2015-04-04','2015-04-04','Black Saturday',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Day of Valor' and HolidayStartDate = '2015-04-09') then
   insert into Holidays values('Philippines','Day of Valor','2015-04-09','2015-04-09','Day of Valor',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Labor Day' and HolidayStartDate = '2015-05-01') then
   insert into Holidays values('Philippines','Labor Day','2015-05-01','2015-05-01','Labor Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Independence Day' and HolidayStartDate = '2015-06-12') then
   insert into Holidays values('Philippines','Independence Day','2015-06-12','2015-06-12','Independence Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Ninoy Aquino Day' and HolidayStartDate = '2015-08-21') then
   insert into Holidays values('Philippines','Ninoy Aquino Day','2015-08-21','2015-08-21','Ninoy Aquino Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'National Heroes' and HolidayStartDate = '2015-08-31') then
   insert into Holidays values('Philippines','National Heroes','2015-08-31','2015-08-31','National Heroes Day',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'All Saints Day' and HolidayStartDate = '2015-11-01') then
   insert into Holidays values('Philippines','All Saints Day','2015-11-01','2015-11-01','All Saints Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Bonifacio Day' and HolidayStartDate = '2015-11-30') then
   insert into Holidays values('Philippines','Bonifacio Day','2015-11-30','2015-11-30','Bonifacio Day',0,1,0);
end if;


if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Christmas Eve' and HolidayStartDate = '2015-12-24') then
   insert into Holidays values('Philippines','Christmas Eve','2015-12-24','2015-12-24','Christmas Eve',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Christmas Day' and HolidayStartDate = '2015-12-25') then
   insert into Holidays values('Philippines','Christmas Day','2015-12-25','2015-12-25','Christmas Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'Rizal Day' and HolidayStartDate = '2015-12-30') then
   insert into Holidays values('Philippines','Rizal Day','2015-12-30','2015-12-30','Rizal Day',0,1,0);
end if;

if not exists(select * from Holidays where CountryId='Philippines' and HolidayId = 'New Years Eve' and HolidayStartDate = '2015-12-31') then
   insert into Holidays values('Philippines','New Years Eve','2015-12-31','2015-12-31','New Years Eve',0,1,0);
end if;

commit work;
