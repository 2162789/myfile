
begin

declare In_Country char(20);
  select FGetDBCountry(*) into In_Country;

if (In_Country = 'Malaysia') then

if (not exists(select * from Holidays Where CountryId='MY' and Year(HolidayStartDate) = 2011)) then
		
    insert into Holidays values('MY','Lunar New Year','2011-02-03','2011-02-03','Chinese New Year',0,1,0);
    insert into Holidays values('MY','Lunar New Year','2011-02-04','2011-02-04','Chinese New Year',0,1,0);
    insert into Holidays values('MY','ProphetMohdBirthday','2011-02-15','2011-02-15','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('MY','Labour Day','2011-05-01','2011-05-01','Labour Day',0,0,0);
    insert into Holidays values('MY','Vesak Day','2011-05-17','2011-05-17','Vesak',0,1,0);
    insert into Holidays values('MY','AgongBirthday','2011-06-04','2011-06-04','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
    insert into Holidays values('MY','Hari Raya Puasa','2011-08-30','2011-08-30','Hari Raya Puasa',0,1,0);
    insert into Holidays values('MY','National Day','2011-08-31','2011-08-31','National Day',0,1,0);
    insert into Holidays values('MY','Malaysia Day','2011-09-16','2011-09-16','Malaysia Day',0,1,0);
    insert into Holidays values('MY','Deepavali','2011-10-26','2011-10-26','Deepavali',0,1,0);
    insert into Holidays values('MY','Hari Raya Qurban','2011-11-06','2011-11-06','Hari Raya Qurban',0,0,0);
    insert into Holidays values('MY','Awal Muharam','2011-11-27','2011-11-27','Awal Muharam',0,0,0);
    insert into Holidays values('MY','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);

    insert into Holidays values('MY','New Year','2011-01-01','2011-01-01','New Year',0,1,0);
    insert into Holidays values('MY','Thaipusam','2011-01-20','2011-01-20','Thaipusam',0,1,0);
    insert into Holidays values('MY','Federal Territory','2011-02-01','2011-02-01','Federal Territory Day',0,1,0);

end if;

if (not exists(select * from Holidays Where CountryId='MY-Labuan' and Year(HolidayStartDate) = 2011)) then


    if (not exists(select * from Country Where CountryId='MY-Labuan')) then
        insert into Country values('MY-Labuan','MY - Labuan','','MY - Labuan','');
    end if;

    insert into Holidays values('MY-Labuan','Lunar New Year','2011-02-03','2011-02-03','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Labuan','Lunar New Year','2011-02-04','2011-02-04','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Labuan','ProphetMohdBirthday','2011-02-15','2011-02-15','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('MY-Labuan','Labour Day','2011-05-01','2011-05-01','Labour Day',0,0,0);
    insert into Holidays values('MY-Labuan','Vesak Day','2011-05-17','2011-05-17','Vesak',0,1,0);
    insert into Holidays values('MY-Labuan','AgongBirthday','2011-06-04','2011-06-04','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
    insert into Holidays values('MY-Labuan','Hari Raya Puasa','2011-08-30','2011-08-30','Hari Raya Puasa',0,1,0);
    insert into Holidays values('MY-Labuan','National Day','2011-08-31','2011-08-31','National Day',0,1,0);
    insert into Holidays values('MY-Labuan','Malaysia Day','2011-09-16','2011-09-16','Malaysia Day',0,1,0);
    insert into Holidays values('MY-Labuan','Hari Raya Qurban','2011-11-06','2011-11-06','Hari Raya Qurban',0,0,0);
    insert into Holidays values('MY-Labuan','Awal Muharam','2011-11-27','2011-11-27','Awal Muharam',0,0,0);
    insert into Holidays values('MY-Labuan','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);

    insert into Holidays values('MY-Labuan','New Year','2011-01-01','2011-01-01','New Year',0,1,0);
    insert into Holidays values('MY-Labuan','Federal Territory','2011-02-01','2011-02-01','Federal Territory Day',0,1,0);
    insert into Holidays values('MY-Labuan','Harvest Festival','2011-05-30','2011-05-30','Harvest Festival',0,1,0);
    insert into Holidays values('MY-Labuan','Harvest Festival','2011-05-31','2011-05-31','Harvest Festival',0,1,0);

end if;

if (not exists(select * from Holidays Where CountryId='MY-Johor' and Year(HolidayStartDate) = 2011)) then

    insert into Holidays values('MY-Johor','Lunar New Year','2011-02-03','2011-02-03','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Johor','Lunar New Year','2011-02-04','2011-02-04','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Johor','ProphetMohdBirthday','2011-02-15','2011-02-15','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('MY-Johor','Labour Day','2011-05-01','2011-05-01','Labour Day',0,0,0);
    insert into Holidays values('MY-Johor','Vesak Day','2011-05-17','2011-05-17','Vesak',0,1,0);
    insert into Holidays values('MY-Johor','AgongBirthday','2011-06-04','2011-06-04','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
    insert into Holidays values('MY-Johor','Hari Raya Puasa','2011-08-30','2011-08-30','Hari Raya Puasa',0,1,0);
    insert into Holidays values('MY-Johor','National Day','2011-08-31','2011-08-31','National Day',0,1,0);
    insert into Holidays values('MY-Johor','Malaysia Day','2011-09-16','2011-09-16','Malaysia Day',0,1,0);
    insert into Holidays values('MY-Johor','Deepavali','2011-10-26','2011-10-26','Deepavali',0,1,0);
    insert into Holidays values('MY-Johor','Hari Raya Qurban','2011-11-06','2011-11-06','Hari Raya Qurban',0,0,0);
    insert into Holidays values('MY-Johor','Awal Muharam','2011-11-27','2011-11-27','Awal Muharam',0,0,0);
    insert into Holidays values('MY-Johor','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);

    insert into Holidays values('MY-Johor','Almarhum Sultan','2011-01-11','2011-01-11','Hol Day Almarhum Sultan Johor',0,1,0);
    insert into Holidays values('MY-Johor','Thaipusam','2011-01-20','2011-01-20','Thaipusam',0,1,0);
    insert into Holidays values('MY-Johor','Awal Ramadan','2011-08-01','2011-08-01','Awal Ramadan',0,1,0);
    insert into Holidays values('MY-Johor','Sultan Birthday','2011-11-22','2011-11-22','Birthday of Sultan of Johor',0,1,0);

end if;

if (not exists(select * from Holidays Where CountryId='MY-Kedah' and Year(HolidayStartDate) = 2011)) then

    insert into Holidays values('MY-Kedah','Lunar New Year','2011-02-03','2011-02-03','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Kedah','Lunar New Year','2011-02-04','2011-02-04','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Kedah','ProphetMohdBirthday','2011-02-15','2011-02-15','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('MY-Kedah','Labour Day','2011-05-01','2011-05-01','Labour Day',0,0,0);
    insert into Holidays values('MY-Kedah','Vesak Day','2011-05-17','2011-05-17','Vesak',0,1,0);
    insert into Holidays values('MY-Kedah','AgongBirthday','2011-06-04','2011-06-04','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
    insert into Holidays values('MY-Kedah','Hari Raya Puasa','2011-08-30','2011-08-30','Hari Raya Puasa',0,1,0);
    insert into Holidays values('MY-Kedah','National Day','2011-08-31','2011-08-31','National Day',0,1,0);
    insert into Holidays values('MY-Kedah','Malaysia Day','2011-09-16','2011-09-16','Malaysia Day',0,1,0);
    insert into Holidays values('MY-Kedah','Deepavali','2011-10-26','2011-10-26','Deepavali',0,1,0);
    insert into Holidays values('MY-Kedah','Hari Raya Qurban','2011-11-06','2011-11-06','Hari Raya Qurban',0,0,0);
    insert into Holidays values('MY-Kedah','Awal Muharam','2011-11-27','2011-11-27','Awal Muharam',0,0,0);
    insert into Holidays values('MY-Kedah','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);

    insert into Holidays values('MY-Kedah','Sultan Birthday','2011-01-16','2011-01-16','Birthday of Sultan of Kedah',0,0,0);
    insert into Holidays values('MY-Kedah','Israk & Mikraj','2011-06-29','2011-06-29','Israk & Mikraj',0,1,0);
    insert into Holidays values('MY-Kedah','Awal Ramadan','2011-08-01','2011-08-01','Awal Ramadan',0,1,0);
    insert into Holidays values('MY-Kedah','Hari Raya Qurban','2011-11-07','2011-11-07','Hari Raya Qurban',0,1,0);

end if;

if (not exists(select * from Holidays Where CountryId='MY-Kelantan' and Year(HolidayStartDate) = 2011)) then

    insert into Holidays values('MY-Kelantan','Lunar New Year','2011-02-03','2011-02-03','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Kelantan','Lunar New Year','2011-02-04','2011-02-04','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Kelantan','ProphetMohdBirthday','2011-02-15','2011-02-15','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('MY-Kelantan','Labour Day','2011-05-01','2011-05-01','Labour Day',0,0,0);
    insert into Holidays values('MY-Kelantan','Vesak Day','2011-05-17','2011-05-17','Vesak',0,1,0);
    insert into Holidays values('MY-Kelantan','AgongBirthday','2011-06-04','2011-06-04','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
    insert into Holidays values('MY-Kelantan','Hari Raya Puasa','2011-08-30','2011-08-30','Hari Raya Puasa',0,1,0);
    insert into Holidays values('MY-Kelantan','National Day','2011-08-31','2011-08-31','National Day',0,1,0);
    insert into Holidays values('MY-Kelantan','Malaysia Day','2011-09-16','2011-09-16','Malaysia Day',0,1,0);
    insert into Holidays values('MY-Kelantan','Deepavali','2011-10-26','2011-10-26','Deepavali',0,1,0);
    insert into Holidays values('MY-Kelantan','Hari Raya Qurban','2011-11-06','2011-11-06','Hari Raya Qurban',0,0,0);
    insert into Holidays values('MY-Kelantan','Hari Raya Qurban','2011-11-07','2011-11-07','Hari Raya Qurban',0,1,0);
    insert into Holidays values('MY-Kelantan','Awal Muharam','2011-11-27','2011-11-27','Awal Muharam',0,0,0);
    insert into Holidays values('MY-Kelantan','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);

    insert into Holidays values('MY-Kelantan','Sultan Birthday','2011-03-30','2011-03-30','Birthday of Sultan of Kelantan',0,1,0);
    insert into Holidays values('MY-Kelantan','Sultan Birthday','2011-03-31','2011-03-31','Birthday of Sultan of Kelantan',0,1,0);
    insert into Holidays values('MY-Kelantan','Hari Nuzul Al-Quran','2011-08-17','2011-08-17','Hari Nuzul Al-Quran',0,1,0);

end if;

if (not exists(select * from Holidays Where CountryId='MY-Melaka' and Year(HolidayStartDate) = 2011)) then

    insert into Holidays values('MY-Melaka','Lunar New Year','2011-02-03','2011-02-03','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Melaka','Lunar New Year','2011-02-04','2011-02-04','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Melaka','ProphetMohdBirthday','2011-02-15','2011-02-15','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('MY-Melaka','Labour Day','2011-05-01','2011-05-01','Labour Day',0,0,0);
    insert into Holidays values('MY-Melaka','Vesak Day','2011-05-17','2011-05-17','Vesak',0,1,0);
    insert into Holidays values('MY-Melaka','AgongBirthday','2011-06-04','2011-06-04','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
    insert into Holidays values('MY-Melaka','Hari Raya Puasa','2011-08-30','2011-08-30','Hari Raya Puasa',0,1,0);
    insert into Holidays values('MY-Melaka','National Day','2011-08-31','2011-08-31','National Day',0,1,0);
    insert into Holidays values('MY-Melaka','Malaysia Day','2011-09-16','2011-09-16','Malaysia Day',0,1,0);
    insert into Holidays values('MY-Melaka','Deepavali','2011-10-26','2011-10-26','Deepavali',0,1,0);
    insert into Holidays values('MY-Melaka','Hari Raya Qurban','2011-11-06','2011-11-06','Hari Raya Qurban',0,0,0);
    insert into Holidays values('MY-Melaka','Awal Muharam','2011-11-27','2011-11-27','Awal Muharam',0,0,0);
    insert into Holidays values('MY-Melaka','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);

    insert into Holidays values('MY-Melaka','New Year','2011-01-01','2011-01-01','New Year',0,1,0);
    insert into Holidays values('MY-Melaka','HistoricalCity','2011-04-15','2011-04-15','Declaration of Melaka as Historical City',0,1,0);
    insert into Holidays values('MY-Melaka','Awal Ramadan','2011-08-01','2011-08-01','Awal Ramadan',0,1,0);
    insert into Holidays values('MY-Melaka','Yang di-Pertuan','2011-10-08','2011-10-08','Birthday of TYT Yang di-Pertuan of Melaka',0,1,0);

end if;

if (not exists(select * from Holidays Where CountryId='MY-N.Sembilan' and Year(HolidayStartDate) = 2011)) then

    insert into Holidays values('MY-N.Sembilan','Lunar New Year','2011-02-03','2011-02-03','Chinese New Year',0,1,0);
    insert into Holidays values('MY-N.Sembilan','Lunar New Year','2011-02-04','2011-02-04','Chinese New Year',0,1,0);
    insert into Holidays values('MY-N.Sembilan','ProphetMohdBirthday','2011-02-15','2011-02-15','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('MY-N.Sembilan','Labour Day','2011-05-01','2011-05-01','Labour Day',0,0,0);
    insert into Holidays values('MY-N.Sembilan','Vesak Day','2011-05-17','2011-05-17','Vesak',0,1,0);
    insert into Holidays values('MY-N.Sembilan','AgongBirthday','2011-06-04','2011-06-04','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
    insert into Holidays values('MY-N.Sembilan','Hari Raya Puasa','2011-08-30','2011-08-30','Hari Raya Puasa',0,1,0);
    insert into Holidays values('MY-N.Sembilan','National Day','2011-08-31','2011-08-31','National Day',0,1,0);
    insert into Holidays values('MY-N.Sembilan','Malaysia Day','2011-09-16','2011-09-16','Malaysia Day',0,1,0);
    insert into Holidays values('MY-N.Sembilan','Deepavali','2011-10-26','2011-10-26','Deepavali',0,1,0);
    insert into Holidays values('MY-N.Sembilan','Hari Raya Qurban','2011-11-06','2011-11-06','Hari Raya Qurban',0,0,0);
    insert into Holidays values('MY-N.Sembilan','Awal Muharam','2011-11-27','2011-11-27','Awal Muharam',0,0,0);
    insert into Holidays values('MY-N.Sembilan','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);

    insert into Holidays values('MY-N.Sembilan','New Year','2011-01-01','2011-01-01','New Year',0,1,0);
    insert into Holidays values('MY-N.Sembilan','Yang di-Pertuan','2011-01-14','2011-01-14','Birthday of Yang di-Pertuan Besar of Negri Sembilan',0,1,0);
    insert into Holidays values('MY-N.Sembilan','Thaipusam','2011-01-20','2011-01-20','Thaipusam',0,1,0);
    insert into Holidays values('MY-N.Sembilan','Israk & Mikraj','2011-06-29','2011-06-29','Israk & Mikraj',0,1,0);

end if;

if (not exists(select * from Holidays Where CountryId='MY-Pahang' and Year(HolidayStartDate) = 2011)) then

    insert into Holidays values('MY-Pahang','Lunar New Year','2011-02-03','2011-02-03','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Pahang','Lunar New Year','2011-02-04','2011-02-04','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Pahang','ProphetMohdBirthday','2011-02-15','2011-02-15','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('MY-Pahang','Labour Day','2011-05-01','2011-05-01','Labour Day',0,0,0);
    insert into Holidays values('MY-Pahang','Vesak Day','2011-05-17','2011-05-17','Vesak',0,1,0);
    insert into Holidays values('MY-Pahang','AgongBirthday','2011-06-04','2011-06-04','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
    insert into Holidays values('MY-Pahang','Hari Raya Puasa','2011-08-30','2011-08-30','Hari Raya Puasa',0,1,0);
    insert into Holidays values('MY-Pahang','National Day','2011-08-31','2011-08-31','National Day',0,1,0);
    insert into Holidays values('MY-Pahang','Malaysia Day','2011-09-16','2011-09-16','Malaysia Day',0,1,0);
    insert into Holidays values('MY-Pahang','Deepavali','2011-10-26','2011-10-26','Deepavali',0,1,0);
    insert into Holidays values('MY-Pahang','Hari Raya Qurban','2011-11-06','2011-11-06','Hari Raya Qurban',0,0,0);
    insert into Holidays values('MY-Pahang','Awal Muharam','2011-11-27','2011-11-27','Awal Muharam',0,0,0);
    insert into Holidays values('MY-Pahang','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);

    insert into Holidays values('MY-Pahang','New Year','2011-01-01','2011-01-01','New Year',0,1,0);
    insert into Holidays values('MY-Pahang','Hol Day Pahang','2011-05-07','2011-05-07','Hol Day Pahang',0,1,0);
    insert into Holidays values('MY-Pahang','Hari Nuzul Al-Quran','2011-08-17','2011-08-17','Hari Nuzul Al-Quran',0,1,0);
    insert into Holidays values('MY-Pahang','Sultan Birthday','2011-10-24','2011-10-24','Birthday of Sultan of Pahang',0,1,0);

end if;

if (not exists(select * from Holidays Where CountryId='MY-Perak' and Year(HolidayStartDate) = 2011)) then

    insert into Holidays values('MY-Perak','Lunar New Year','2011-02-03','2011-02-03','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Perak','Lunar New Year','2011-02-04','2011-02-04','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Perak','ProphetMohdBirthday','2011-02-15','2011-02-15','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('MY-Perak','Labour Day','2011-05-01','2011-05-01','Labour Day',0,0,0);
    insert into Holidays values('MY-Perak','Vesak Day','2011-05-17','2011-05-17','Vesak',0,1,0);
    insert into Holidays values('MY-Perak','AgongBirthday','2011-06-04','2011-06-04','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
    insert into Holidays values('MY-Perak','Hari Raya Puasa','2011-08-30','2011-08-30','Hari Raya Puasa',0,1,0);
    insert into Holidays values('MY-Perak','National Day','2011-08-31','2011-08-31','National Day',0,1,0);
    insert into Holidays values('MY-Perak','Malaysia Day','2011-09-16','2011-09-16','Malaysia Day',0,1,0);
    insert into Holidays values('MY-Perak','Deepavali','2011-10-26','2011-10-26','Deepavali',0,1,0);
    insert into Holidays values('MY-Perak','Hari Raya Qurban','2011-11-06','2011-11-06','Hari Raya Qurban',0,0,0);
    insert into Holidays values('MY-Perak','Awal Muharam','2011-11-27','2011-11-27','Awal Muharam',0,0,0);
    insert into Holidays values('MY-Perak','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);

    insert into Holidays values('MY-Perak','New Year','2011-01-01','2011-01-01','New Year',0,1,0);
    insert into Holidays values('MY-Perak','Thaipusam','2011-01-20','2011-01-20','Thaipusam',0,1,0);
    insert into Holidays values('MY-Perak','Sultan Birthday','2011-04-19','2011-04-19','Birthday of Sultan of Perak',0,1,0);
    insert into Holidays values('MY-Perak','Hari Nuzul Al-Quran','2011-08-17','2011-08-17','Hari Nuzul Al-Quran',0,1,0);

end if;

if (not exists(select * from Holidays Where CountryId='MY-Perlis' and Year(HolidayStartDate) = 2011)) then

    insert into Holidays values('MY-Perlis','Lunar New Year','2011-02-03','2011-02-03','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Perlis','Lunar New Year','2011-02-04','2011-02-04','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Perlis','ProphetMohdBirthday','2011-02-15','2011-02-15','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('MY-Perlis','Labour Day','2011-05-01','2011-05-01','Labour Day',0,0,0);
    insert into Holidays values('MY-Perlis','AgongBirthday','2011-06-04','2011-06-04','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
    insert into Holidays values('MY-Perlis','Hari Raya Puasa','2011-08-30','2011-08-30','Hari Raya Puasa',0,1,0);
    insert into Holidays values('MY-Perlis','National Day','2011-08-31','2011-08-31','National Day',0,1,0);
    insert into Holidays values('MY-Perlis','Malaysia Day','2011-09-16','2011-09-16','Malaysia Day',0,1,0);
    insert into Holidays values('MY-Perlis','Deepavali','2011-10-26','2011-10-26','Deepavali',0,1,0);
    insert into Holidays values('MY-Perlis','Hari Raya Qurban','2011-11-06','2011-11-06','Hari Raya Qurban',0,0,0);
    insert into Holidays values('MY-Perlis','Hari Raya Qurban','2011-11-07','2011-11-07','Hari Raya Qurban',0,1,0);
    insert into Holidays values('MY-Perlis','Awal Muharam','2011-11-27','2011-11-27','Awal Muharam',0,0,0);
    insert into Holidays values('MY-Perlis','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);

    insert into Holidays values('MY-Perlis','Sultan Birthday','2011-05-17','2011-05-17','Birthday of Sultan of Perlis',0,1,0);
    insert into Holidays values('MY-Perlis','Vesak Day','2011-05-16','2011-05-16','Vesak',0,1,0);
    insert into Holidays values('MY-Perlis','Israk & Mikraj','2011-06-29','2011-06-29','Israk & Mikraj',0,1,0);
    insert into Holidays values('MY-Perlis','Hari Nuzul Al-Quran','2011-08-17','2011-08-17','Hari Nuzul Al-Quran',0,1,0);

end if;

if (not exists(select * from Holidays Where CountryId='MY-Penang' and Year(HolidayStartDate) = 2011)) then

    insert into Holidays values('MY-Penang','Lunar New Year','2011-02-03','2011-02-03','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Penang','Lunar New Year','2011-02-04','2011-02-04','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Penang','ProphetMohdBirthday','2011-02-15','2011-02-15','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('MY-Penang','Labour Day','2011-05-01','2011-05-01','Labour Day',0,0,0);
    insert into Holidays values('MY-Penang','Vesak Day','2011-05-17','2011-05-17','Vesak',0,1,0);
    insert into Holidays values('MY-Penang','AgongBirthday','2011-06-04','2011-06-04','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
    insert into Holidays values('MY-Penang','Hari Raya Puasa','2011-08-30','2011-08-30','Hari Raya Puasa',0,1,0);
    insert into Holidays values('MY-Penang','National Day','2011-08-31','2011-08-31','National Day',0,1,0);
    insert into Holidays values('MY-Penang','Malaysia Day','2011-09-16','2011-09-16','Malaysia Day',0,1,0);
    insert into Holidays values('MY-Penang','Deepavali','2011-10-26','2011-10-26','Deepavali',0,1,0);
    insert into Holidays values('MY-Penang','Hari Raya Qurban','2011-11-06','2011-11-06','Hari Raya Qurban',0,0,0);
    insert into Holidays values('MY-Penang','Awal Muharam','2011-11-27','2011-11-27','Awal Muharam',0,0,0);
    insert into Holidays values('MY-Penang','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);

    insert into Holidays values('MY-Penang','New Year','2011-01-01','2011-01-01','New Year',0,1,0);
    insert into Holidays values('MY-Penang','Thaipusam','2011-01-20','2011-01-20','Thaipusam',0,1,0);
    insert into Holidays values('MY-Penang','GeorgeTown Day','2011-07-07','2011-07-07','GeorgeTown Heritage Day',0,1,0);
    insert into Holidays values('MY-Penang','Yang di-Pertuan','2011-07-09','2011-07-09','Birthday Yang di-Pertuan Penang',0,1,0);
    insert into Holidays values('MY-Penang','Hari Nuzul Al-Quran','2011-08-17','2011-08-17','Hari Nuzul Al-Quran',0,1,0);

end if;

if (not exists(select * from Holidays Where CountryId='MY-Sabah' and Year(HolidayStartDate) = 2011)) then

    insert into Holidays values('MY-Sabah','Lunar New Year','2011-02-03','2011-02-03','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Sabah','Lunar New Year','2011-02-04','2011-02-04','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Sabah','ProphetMohdBirthday','2011-02-15','2011-02-15','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('MY-Sabah','Labour Day','2011-05-01','2011-05-01','Labour Day',0,0,0);
    insert into Holidays values('MY-Sabah','Vesak Day','2011-05-17','2011-05-17','Vesak',0,1,0);
    insert into Holidays values('MY-Sabah','AgongBirthday','2011-06-04','2011-06-04','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
    insert into Holidays values('MY-Sabah','Hari Raya Puasa','2011-08-30','2011-08-30','Hari Raya Puasa',0,1,0);
    insert into Holidays values('MY-Sabah','National Day','2011-08-31','2011-08-31','National Day',0,1,0);
    insert into Holidays values('MY-Sabah','Malaysia Day','2011-09-16','2011-09-16','Malaysia Day',0,1,0);
    insert into Holidays values('MY-Sabah','Deepavali','2011-10-26','2011-10-26','Deepavali',0,1,0);
    insert into Holidays values('MY-Sabah','Hari Raya Qurban','2011-11-06','2011-11-06','Hari Raya Qurban',0,0,0);
    insert into Holidays values('MY-Sabah','Awal Muharam','2011-11-27','2011-11-27','Awal Muharam',0,0,0);
    insert into Holidays values('MY-Sabah','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);

    insert into Holidays values('MY-Sabah','New Year','2011-01-01','2011-01-01','New Year',0,1,0);
    insert into Holidays values('MY-Sabah','Good Friday','2011-04-22','2011-04-22','Good Friday',0,1,0);
    insert into Holidays values('MY-Sabah','Harvest Festival','2011-05-30','2011-05-30','Harvest Festival',0,1,0);
    insert into Holidays values('MY-Sabah','Harvest Festival','2011-05-31','2011-05-31','Harvest Festival',0,1,0);
    insert into Holidays values('MY-Sabah','Yang di-Pertuan','2011-10-01','2011-10-01','Birthday Yang di-Pertuan Sabah',0,1,0);

end if;

if (not exists(select * from Holidays Where CountryId='MY-Sarawak' and Year(HolidayStartDate) = 2011)) then

    insert into Holidays values('MY-Sarawak','Lunar New Year','2011-02-03','2011-02-03','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Sarawak','Lunar New Year','2011-02-04','2011-02-04','Chinese New Year',0,1,0);
    insert into Holidays values('MY-Sarawak','ProphetMohdBirthday','2011-02-15','2011-02-15','Prophet Muhammad Birthday',0,1,0);
    insert into Holidays values('MY-Sarawak','Labour Day','2011-05-01','2011-05-01','Labour Day',0,0,0);
    insert into Holidays values('MY-Sarawak','Vesak Day','2011-05-17','2011-05-17','Vesak',0,1,0);
    insert into Holidays values('MY-Sarawak','AgongBirthday','2011-06-04','2011-06-04','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
    insert into Holidays values('MY-Sarawak','Hari Raya Puasa','2011-08-30','2011-08-30','Hari Raya Puasa',0,1,0);
    insert into Holidays values('MY-Sarawak','National Day','2011-08-31','2011-08-31','National Day',0,1,0);
    insert into Holidays values('MY-Sarawak','Malaysia Day','2011-09-16','2011-09-16','Malaysia Day',0,1,0);
    insert into Holidays values('MY-Sarawak','Hari Raya Qurban','2011-11-06','2011-11-06','Hari Raya Qurban',0,0,0);
    insert into Holidays values('MY-Sarawak','Awal Muharam','2011-11-27','2011-11-27','Awal Muharam',0,0,0);
    insert into Holidays values('MY-Sarawak','Christmas Day','2011-12-25','2011-12-25','Christmas Day',0,0,0);

    insert into Holidays values('MY-Sarawak','New Year','2011-01-01','2011-01-01','New Year',0,1,0);
    insert into Holidays values('MY-Sarawak','Good Friday','2011-04-22','2011-04-22','Good Friday',0,1,0);
    insert into Holidays values('MY-Sarawak','Dayak Festival','2011-06-01','2011-06-01','Dayak Festival',0,1,0);
    insert into Holidays values('MY-Sarawak','Dayak Festival','2011-06-02','2011-06-02','Dayak Festival',0,1,0);
    insert into Holidays values('MY-Sarawak','Yang di-Pertuan','2011-09-10','2011-09-10','Birthday Yang di-Pertuan Sarawak',0,1,0);

end if;

end if;

commit work;

end