begin

declare In_Country char(20);
  select FGetDBCountry(*) into In_Country;

if(In_Country = 'Philippines') then

if (not exists(select * from Holidays Where CountryId='Philippines' and Year(HolidayStartDate) = 2013)) then
    insert into Holidays values('Philippines','New Year','2013-01-01','2013-01-01','New Year',0,1,0);
    insert into Holidays values('Philippines','People Power Day','2013-02-25','2013-02-25','People Power Day / Araw ng People Power (Lakas ng Bayan)',0,1,0);
    insert into Holidays values('Philippines','Maundy Thursday','2013-03-28','2013-03-28','Maundy Thursday',0,1,0);
    insert into Holidays values('Philippines','Good Friday','2013-03-29','2013-03-29','Good Friday',0,1,0);
    insert into Holidays values('Philippines','Araw ng Kagitingan','2013-04-08','2013-04-08','Araw ng Kagitingan (Bataan Day)',0,1,0);
    insert into Holidays values('Philippines','Labor Day','2013-05-01','2013-05-01','Labor Day',0,1,0);
    insert into Holidays values('Philippines','Independence Day','2013-06-10','2013-06-10','Independence Day',0,1,0);
    insert into Holidays values('Philippines','Eidul Fitr','2013-08-09','2013-08-09','Eidul Fitr',0,1,0);
    insert into Holidays values('Philippines','Ninoy Aquino Day','2013-08-10','2013-08-10','Ninoy Aquino Day',0,1,0);
    insert into Holidays values('Philippines','National Heroes','2013-08-26','2013-08-26','National Heroes Day',0,1,0);
    insert into Holidays values('Philippines','Eidul Adha','2013-10-15','2013-10-15','Eidul Adha',0,1,0);
    insert into Holidays values('Philippines','All Saints','2013-11-01','2013-11-01','All Saints Day',0,1,0);
    insert into Holidays values('Philippines','Bonifacio Day','2013-12-02','2013-12-02','Bonifacio Day',0,1,0);
    insert into Holidays values('Philippines','Christmas Day','2013-12-25','2013-12-25','Christmas Day',0,1,0);
    insert into Holidays values('Philippines','Last Day of Year','2013-12-31','2013-12-31','Last Day of year',0,1,0); 
end if;

end if;

commit work;

end