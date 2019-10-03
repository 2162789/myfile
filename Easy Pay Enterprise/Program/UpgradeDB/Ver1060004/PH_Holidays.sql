begin

declare In_Country char(20);
  select FGetDBCountry(*) into In_Country;

if(In_Country = 'Philippines') then

if (not exists(select * from Holidays Where CountryId='Philippines' and Year(HolidayStartDate) = 2012)) then
    insert into Holidays values('Philippines','New Year','2012-01-01','2012-01-01','New Year',0,1,0);
    insert into Holidays values('Philippines','Rizal Day','2012-01-02','2012-01-02','Rizal Day',0,1,0);
    insert into Holidays values('Philippines','Chinese New Year','2012-01-23','2012-01-23','Chinese New Year',0,1,0);
    insert into Holidays values('Philippines','People Power Day','2012-02-27','2012-02-27','People Power Day / Araw ng People Power (Lakas ng Bayan)',0,1,0);
    insert into Holidays values('Philippines','Maundy Thursday','2012-04-05','2012-04-05','Maundy Thursday',0,1,0);
    insert into Holidays values('Philippines','Good Friday','2012-04-06','2012-04-06','Good Friday',0,1,0);
    insert into Holidays values('Philippines','Easter Sunday','2012-04-08','2012-04-08','Easter Sunday',0,1,0);
    insert into Holidays values('Philippines','Araw ng Kagitingan','2012-04-09','2012-04-09','Araw ng Kagitingan (Bataan Day)',0,1,0);
    insert into Holidays values('Philippines','Labor Day','2012-05-01','2012-05-01','Labor Day',0,1,0);
    insert into Holidays values('Philippines','Independence Day','2012-06-11','2012-06-11','Independence Day',0,1,0);
    insert into Holidays values('Philippines','Ninoy Aquino Day','2012-08-20','2012-08-20','Ninoy Aquino Day',0,1,0);
    insert into Holidays values('Philippines','National Heroes','2012-08-27','2012-08-27','National Heroes Day',0,1,0);
    insert into Holidays values('Philippines','All Saints','2012-11-01','2012-11-01','All Saints Day',0,1,0);
    insert into Holidays values('Philippines','Bonifacio Day','2012-12-03','2012-12-03','Bonifacio Day',0,1,0);
    insert into Holidays values('Philippines','Christmas Eve','2012-12-24','2012-12-24','Christmas Eve',0,1,0);
    insert into Holidays values('Philippines','Christmas Day','2012-12-25','2012-12-25','Christmas Day',0,1,0);
    insert into Holidays values('Philippines','Last Day of Year','2012-12-31','2012-12-31','Last Day of year',0,1,0);   
end if;

end if;

commit work;

end