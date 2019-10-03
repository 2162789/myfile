
begin

declare In_Country char(20);
select FGetDBCountry(*) into In_Country;

if(In_Country = 'Singapore') then

if (not exists(select * from Holidays Where CountryId='Singapore' and Year(HolidayStartDate) = 2013)) then
    insert into Holidays values('Singapore','New Year','2013-01-01','2013-01-01','New Year',0,1,0);
    insert into Holidays values('Singapore','Chinese New Year','2013-02-10','2013-02-10','Chinese New Year',0,1,0);
    insert into Holidays values('Singapore','Chinese New Year','2013-02-11','2013-02-11','Chinese New Year',0,1,0);
    insert into Holidays values('Singapore','Chinese New Year','2013-02-12','2013-02-12','Chinese New Year',0,1,0);
    insert into Holidays values('Singapore','Good Friday','2013-03-29','2013-03-29','Good Friday',0,1,0);
    insert into Holidays values('Singapore','Labour Day','2013-05-01','2013-05-01','Labour Day',0,1,0);
    insert into Holidays values('Singapore','Vesak Day','2013-05-24','2013-05-24','Vesak Day',0,1,0);
    insert into Holidays values('Singapore','Hari Raya Puasa','2013-08-08','2013-08-08','Hari Raya Puasa',0,1,0);
    insert into Holidays values('Singapore','National Day','2013-08-09','2013-08-09','National Day',0,1,0);
    insert into Holidays values('Singapore','Hari Raya Haji','2013-10-15','2013-10-15','Hari Raya Haji',0,1,0);
    insert into Holidays values('Singapore','Deepavali','2013-11-03','2013-11-03','Deepavali',0,1,0);
    insert into Holidays values('Singapore','Deepavali','2013-11-04','2013-11-04','Deepavali',0,1,0);
    insert into Holidays values('Singapore','Christmas Day','2013-12-25','2013-12-25','Christmas Day',0,1,0);
end if;

end if;

commit work;

end