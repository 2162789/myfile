
begin

declare In_Country char(20);
  select FGetDBCountry(*) into In_Country;

if (In_Country = 'Malaysia') then

if (not exists(select * from Holidays Where CountryId='MY-Selangor' and Year(HolidayStartDate) = 2011)) then

    insert into Holidays values('MY-Selangor','Lunar New Year','2011-02-03','2011-02-03','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Selangor','Lunar New Year','2011-02-04','2011-02-04','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Selangor','ProphetMohdBirthday','2011-02-15','2011-02-15','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('MY-Selangor','Labour Day','2011-05-01','2011-05-01','Labour Day',0,0,0);
    insert into Holidays values('MY-Selangor','Vesak Day','2011-05-17','2011-05-17','Vesak',0,1,0);
    insert into Holidays values('MY-Selangor','AgongBirthday','2011-06-04','2011-06-04','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
    insert into Holidays values('MY-Selangor','Hari Raya Puasa','2011-08-30','2011-08-30','Hari Raya Puasa',0,1,0);
    insert into Holidays values('MY-Selangor','National Day','2011-08-31','2011-08-31','National Day',0,1,0);
    insert into Holidays values('MY-Selangor','Malaysia Day','2011-09-16','2011-09-16','Malaysia Day',0,1,0);
    insert into Holidays values('MY-Selangor','Deepavali','2011-10-26','2011-10-26','Deepavali',0,1,0);
    insert into Holidays values('MY-Selangor','Hari Raya Qurban','2011-11-06','2011-11-06','Hari Raya Qurban',0,0,0);
    insert into Holidays values('MY-Selangor','Awal Muharam','2011-11-27','2011-11-27','Awal Muharam',0,0,0);
    insert into Holidays values('MY-Selangor','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);
    
    insert into Holidays values('MY-Selangor','New Year','2011-01-01','2011-01-01','New Year',0,1,0);
    insert into Holidays values('MY-Selangor','Thaipusam','2011-01-20','2011-01-20','Thaipusam',0,1,0);
    insert into Holidays values('MY-Selangor','Hari Nuzul Al-Quran','2011-08-17','2011-08-17','Hari Nuzul Al-Quran',0,1,0);
    insert into Holidays values('MY-Selangor','Sultan Birthday','2011-12-11','2011-12-11','Birthday of Sultan of Selangor',0,0,0);

end if;

if (not exists(select * from Holidays Where CountryId='MY-Trengganu' and Year(HolidayStartDate) = 2011)) then

    insert into Holidays values('MY-Trengganu','Lunar New Year','2011-02-03','2011-02-03','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Trengganu','Lunar New Year','2011-02-04','2011-02-04','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Trengganu','ProphetMohdBirthday','2011-02-15','2011-02-15','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('MY-Trengganu','Labour Day','2011-05-01','2011-05-01','Labour Day',0,0,0);
    insert into Holidays values('MY-Trengganu','Vesak Day','2011-05-17','2011-05-17','Vesak',0,1,0);
    insert into Holidays values('MY-Trengganu','AgongBirthday','2011-06-04','2011-06-04','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
    insert into Holidays values('MY-Trengganu','Hari Raya Puasa','2011-08-30','2011-08-30','Hari Raya Puasa',0,1,0);
    insert into Holidays values('MY-Trengganu','National Day','2011-08-31','2011-08-31','National Day',0,1,0);
    insert into Holidays values('MY-Trengganu','Malaysia Day','2011-09-16','2011-09-16','Malaysia Day',0,1,0);
    insert into Holidays values('MY-Trengganu','Deepavali','2011-10-26','2011-10-26','Deepavali',0,1,0);
    insert into Holidays values('MY-Trengganu','Hari Raya Qurban','2011-11-06','2011-11-06','Hari Raya Qurban',0,0,0);
    insert into Holidays values('MY-Trengganu','Hari Raya Qurban','2011-11-07','2011-11-07','Hari Raya Qurban',0,1,0);
    insert into Holidays values('MY-Trengganu','Awal Muharam','2011-11-27','2011-11-27','Awal Muharam',0,0,0);
    insert into Holidays values('MY-Trengganu','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);

    insert into Holidays values('MY-Trengganu','Anni Sultan Install','2011-03-04','2011-03-04','Anniversary Installation of Sultan of Trengganu',0,1,0);
    insert into Holidays values('MY-Trengganu','Sultan Birthday','2011-07-20','2011-07-20','Birthday of Sultan of Trengganu',0,1,0);
    insert into Holidays values('MY-Trengganu','Hari Nuzul Al-Quran','2011-08-17','2011-08-17','Hari Nuzul Al-Quran',0,1,0);

end if;

  elseif(In_Country = 'Singapore') then

if (not exists(select * from Holidays Where CountryId='Singapore' and Year(HolidayStartDate) = 2011)) then

    insert into Holidays values('Singapore','New Year','2011-01-01','2011-01-01','New Year',0,1,0);
    insert into Holidays values('Singapore','Chinese New Year','2011-02-03','2011-02-03','Chinese New Year',0,1,0);
    insert into Holidays values('Singapore','Chinese New Year','2011-02-04','2011-02-04','Chinese New Year',0,1,0);
    insert into Holidays values('Singapore','Good Friday','2011-04-22','2011-04-22','Good Friday',0,1,0);
    insert into Holidays values('Singapore','Labour Day','2011-05-01','2011-05-01','Labour Day',0,0,0);
    insert into Holidays values('Singapore','Vesak Day','2011-05-17','2011-05-17','Vesak Day',0,1,0);
    insert into Holidays values('Singapore','National Day','2011-08-09','2011-08-09','National Day',0,1,0);
    insert into Holidays values('Singapore','Hari Raya Puasa','2011-08-30','2011-08-30','Hari Raya Puasa',0,1,0);
    insert into Holidays values('Singapore','Deepavali','2011-10-26','2011-10-26','Deepavali',0,1,0);
    insert into Holidays values('Singapore','Hari Raya Haji','2011-11-06','2011-11-06','Hari Raya Haji',0,0,0);
    insert into Holidays values('Singapore','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);

end if;

end if;

commit work;

end