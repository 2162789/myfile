
begin

declare In_Country char(20);
select FGetDBCountry(*) into In_Country;

if(In_Country = 'Singapore') then

if (not exists(select * from Holidays Where CountryId='Singapore' and Year(HolidayStartDate) = 2012)) then
    insert into Holidays values('Singapore','New Year','2012-01-01','2012-01-01','New Year',0,1,0);
    insert into Holidays values('Singapore','New Year','2012-01-02','2012-01-02','New Year',0,1,0);
    insert into Holidays values('Singapore','Chinese New Year','2012-01-23','2012-01-23','Chinese New Year',0,1,0);
    insert into Holidays values('Singapore','Chinese New Year','2012-01-24','2012-01-24','Chinese New Year',0,1,0);
    insert into Holidays values('Singapore','Good Friday','2012-04-06','2012-04-06','Good Friday',0,1,0);
    insert into Holidays values('Singapore','Labour Day','2012-05-01','2012-05-01','Labour Day',0,1,0);
    insert into Holidays values('Singapore','Vesak Day','2012-05-05','2012-05-05','Vesak Day',0,1,0);
    insert into Holidays values('Singapore','National Day','2012-08-09','2012-08-09','National Day',0,1,0);
    insert into Holidays values('Singapore','Hari Raya Puasa','2012-08-19','2012-08-19','Hari Raya Puasa',0,1,0);
    insert into Holidays values('Singapore','Hari Raya Puasa','2012-08-20','2012-08-20','Hari Raya Puasa',0,1,0);
    insert into Holidays values('Singapore','Hari Raya Haji','2012-10-26','2012-10-26','Hari Raya Haji',0,1,0);
    insert into Holidays values('Singapore','Deepavali','2012-11-13','2012-11-13','Deepavali',0,1,0);
    insert into Holidays values('Singapore','Christmas Day','2012-12-25','2012-12-25','Christmas Day',0,1,0);
end if;

end if;

commit work;

end