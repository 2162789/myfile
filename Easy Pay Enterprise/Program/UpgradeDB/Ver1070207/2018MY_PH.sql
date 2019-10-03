/* MY-KL */
If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-01-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','New Year','2018-01-01','2018-01-01','New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-01-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','Thaipusam','2018-01-31','2018-01-31','Thaipusam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-02-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','Federal Territory','2018-02-01','2018-02-01','Federal Territory Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-02-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','Lunar New Year','2018-02-16','2018-02-16','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-02-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','Lunar New Year','2018-02-17','2018-02-17','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-05-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','Labour Day','2018-05-01','2018-05-01','Labour Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-05-29') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','Vesak Day','2018-05-29','2018-05-29','Vesak Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-06-02') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','Hari Nuzul Al-Quran','2018-06-02','2018-06-02','Hari Nuzul Al-Quran','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-06-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','Hari Raya Puasa','2018-06-15','2018-06-15','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-06-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','Hari Raya Puasa','2018-06-16','2018-06-16','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-08-22') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','Hari Raya Qurban','2018-08-22','2018-08-22','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-08-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','National Day','2018-08-31','2018-08-31','National Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-09-09') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','AgongBirthday','2018-09-09','2018-09-09','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-09-10') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','AgongBirthday','2018-09-10','2018-09-10','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-09-11') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','Awal Muharam','2018-09-11','2018-09-11','Awal Muharam','0',1,0); 
end if;
 
If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-09-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','Malaysia Day','2018-09-16','2018-09-16','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-09-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','Malaysia Day','2018-09-17','2018-09-17','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-11-06') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','Deepavali','2018-11-06','2018-11-06','Deepavali','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-11-20') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','Hari Keputeraan','2018-11-20','2018-11-20','Hari Keputeraan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY' And HolidayStartDate ='2018-12-25') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY','Christmas Day','2018-12-25','2018-12-25','Christmas Day','0',1,0); 
end if;

/* MY-Labuan */
If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-01-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','New Year','2018-01-01','2018-01-01','New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-02-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','Federal Territory','2018-02-01','2018-02-01','Federal Territory Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-02-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','Lunar New Year','2018-02-16','2018-02-16','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-02-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','Lunar New Year','2018-02-17','2018-02-17','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-05-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','Labour Day','2018-05-01','2018-05-01','Labour Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-05-29') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','Vesak Day','2018-05-29','2018-05-29','Vesak Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-05-30') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','Harvest Festival','2018-05-30','2018-05-30','Harvest Festival','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-05-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','Harvest Festival','2018-05-31','2018-05-31','Harvest Festival','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-06-02') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','Hari Nuzul Al-Quran','2018-06-02','2018-06-02','Hari Nuzul Al-Quran','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-06-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','Hari Raya Puasa','2018-06-15','2018-06-15','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-06-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','Hari Raya Puasa','2018-06-16','2018-06-16','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-08-22') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','Hari Raya Qurban','2018-08-22','2018-08-22','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-08-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','National Day','2018-08-31','2018-08-31','National Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-09-09') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','AgongBirthday','2018-09-09','2018-09-09','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-09-10') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','AgongBirthday','2018-09-10','2018-09-10','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-09-11') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','Awal Muharam','2018-09-11','2018-09-11','Awal Muharam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-09-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','Malaysia Day','2018-09-16','2018-09-16','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-09-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','Malaysia Day','2018-09-17','2018-09-17','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-11-06') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','Deepavali','2018-11-06','2018-11-06','Deepavali','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-11-20') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','Hari Keputeraan','2018-11-20','2018-11-20','Hari Keputeraan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Labuan' And HolidayStartDate ='2018-12-25') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Labuan','Christmas Day','2018-12-25','2018-12-25','Christmas Day','0',1,0); 
end if;

/* MY-Johor */
If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-01-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Thaipusam','2018-01-31','2018-01-31','Thaipusam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-02-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Lunar New Year','2018-02-16','2018-02-16','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-02-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Lunar New Year','2018-02-17','2018-02-17','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-02-18') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Lunar New Year','2018-02-18','2018-02-18','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-03-23') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Sultan Birthday','2018-03-23','2018-03-23','Birthday of Sultan of Johor','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-05-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Labour Day','2018-05-01','2018-05-01','Labour Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-05-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Awal Ramadan','2018-05-17','2018-05-17','Awal Ramadan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-05-29') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Vesak Day','2018-05-29','2018-05-29','Vesak Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-06-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Hari Raya Puasa','2018-06-15','2018-06-15','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-06-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Hari Raya Puasa','2018-06-16','2018-06-16','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-06-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Hari Raya Puasa','2018-06-17','2018-06-17','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-08-22') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Hari Raya Qurban','2018-08-22','2018-08-22','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-08-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','National Day','2018-08-31','2018-08-31','National Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-09-09') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','AgongBirthday','2018-09-09','2018-09-09','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-09-11') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Awal Muharam','2018-09-11','2018-09-11','Awal Muharam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-09-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Malaysia Day','2018-09-16','2018-09-16','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-10-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Almarhum Sultan','2018-10-15','2018-10-15','Hol Day Almarhum Sultan Johor','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-11-06') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Deepavali','2018-11-06','2018-11-06','Deepavali','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-11-20') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Hari Keputeraan','2018-11-20','2018-11-20','Hari Keputeraan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2018-12-25') then
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Johor','Christmas Day','2018-12-25','2018-12-25','Christmas Day','0',1,0); 
end if;

/* MY-Kedah */
If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-01-21') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Sultan Birthday','2018-01-21','2018-01-21','Birthday of Sultan of Kedah','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-02-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Lunar New Year','2018-02-16','2018-02-16','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-02-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Lunar New Year','2018-02-17','2018-02-17','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-02-18') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Lunar New Year','2018-02-18','2018-02-18','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-04-14') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Israk & Mikraj','2018-04-14','2018-04-14','Israk & Mikraj','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-04-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Israk & Mikraj','2018-04-15','2018-04-15','Israk & Mikraj','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-05-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Labour Day','2018-05-01','2018-05-01','Labour Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-05-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Awal Ramadan','2018-05-17','2018-05-17','Awal Ramadan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-05-29') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Vesak Day','2018-05-29','2018-05-29','Vesak Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-06-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Hari Raya Puasa','2018-06-15','2018-06-15','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-06-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Hari Raya Puasa','2018-06-16','2018-06-16','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-06-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Hari Raya Puasa','2018-06-17','2018-06-17','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-08-22') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Hari Raya Qurban','2018-08-22','2018-08-22','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-08-23') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Hari Raya Qurban','2018-08-23','2018-08-23','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-08-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','National Day','2018-08-31','2018-08-31','National Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-09-09') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','AgongBirthday','2018-09-09','2018-09-09','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-09-11') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Awal Muharam','2018-09-11','2018-09-11','Awal Muharam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-09-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Malaysia Day','2018-09-16','2018-09-16','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-11-06') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Deepavali','2018-11-06','2018-11-06','Deepavali','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-11-20') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Hari Keputeraan','2018-11-20','2018-11-20','Hari Keputeraan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kedah' And HolidayStartDate ='2018-12-25') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kedah','Christmas Day','2018-12-25','2018-12-25','Christmas Day','0',1,0); 
end if;

/* MY-Kelantan */
If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-02-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Lunar New Year','2018-02-16','2018-02-16','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-02-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Lunar New Year','2018-02-17','2018-02-17','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-02-18') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Lunar New Year','2018-02-18','2018-02-18','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-05-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Labour Day','2018-05-01','2018-05-01','Labour Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-05-29') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Vesak Day','2018-05-29','2018-05-29','Vesak Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-06-02') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Hari Nuzul Al-Quran','2018-06-02','2018-06-02','Hari Nuzul Al-Quran','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-06-03') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Hari Nuzul Al-Quran','2018-06-03','2018-06-03','Hari Nuzul Al-Quran','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-06-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Hari Raya Puasa','2018-06-15','2018-06-15','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-06-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Hari Raya Puasa','2018-06-16','2018-06-16','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-06-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Hari Raya Puasa','2018-06-17','2018-06-17','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-08-22') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Hari Raya Qurban','2018-08-22','2018-08-22','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-08-23') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Hari Raya Qurban','2018-08-23','2018-08-23','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-08-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','National Day','2018-08-31','2018-08-31','National Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-09-09') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','AgongBirthday','2018-09-09','2018-09-09','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-09-11') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Awal Muharam','2018-09-11','2018-09-11','Awal Muharam','0',1,0);
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-09-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Malaysia Day','2018-09-16','2018-09-16','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-11-06') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Deepavali','2018-11-06','2018-11-06','Deepavali','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-11-11') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Sultan Birthday','2018-11-11','2018-11-11','Birthday of Sultan of Kelantan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-11-12') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Sultan Birthday','2018-11-12','2018-11-12','Birthday of Sultan of Kelantan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-11-20') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Hari Keputeraan','2018-11-20','2018-11-20','Hari Keputeraan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Kelantan' And HolidayStartDate ='2018-12-25') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Kelantan','Christmas Day','2018-12-25','2018-12-25','Christmas Day','0',1,0); 
end if;

/* MY-Melaka */
If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-01-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','New Year','2018-01-01','2018-01-01','New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-02-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','Lunar New Year','2018-02-16','2018-02-16','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-02-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','Lunar New Year','2018-02-17','2018-02-17','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-04-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','HistoricalCity','2018-04-15','2018-04-15','HistoricalCity','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-04-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','HistoricalCity','2018-04-16','2018-04-16','HistoricalCity','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-05-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','Labour Day','2018-05-01','2018-05-01','Labour Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-05-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','Awal Ramadan','2018-05-17','2018-05-17','Awal Ramadan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-05-29') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','Vesak Day','2018-05-29','2018-05-29','Vesak Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-06-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','Hari Raya Puasa','2018-06-15','2018-06-15','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-06-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','Hari Raya Puasa','2018-06-16','2018-06-16','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-08-22') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','Hari Raya Qurban','2018-08-22','2018-08-22','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-08-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','National Day','2018-08-31','2018-08-31','National Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-09-09') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','AgongBirthday','2018-09-09','2018-09-09','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-09-10') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','AgongBirthday','2018-09-10','2018-09-10','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-09-11') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','Awal Muharam','2018-09-11','2018-09-11','Awal Muharam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-09-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','Malaysia Day','2018-09-16','2018-09-16','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-09-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','Malaysia Day','2018-09-17','2018-09-17','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-10-12') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','Yang di-Pertuan','2018-10-12','2018-10-12','Birthday of TYT Yang di-Pertuan of Melaka','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-11-06') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','Deepavali','2018-11-06','2018-11-06','Deepavali','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-11-20') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','Hari Keputeraan','2018-11-20','2018-11-20','Hari Keputeraan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Melaka' And HolidayStartDate ='2018-12-25') then
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Melaka','Christmas Day','2018-12-25','2018-12-25','Christmas Day','0',1,0); 
end if;

/* MY-N.Sembilan */
If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-01-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','New Year','2018-01-01','2018-01-01','New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-01-14') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','Yang di-Pertuan','2018-01-14','2018-01-14','Yang di-Pertuan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-01-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','Yang di-Pertuan','2018-01-15','2018-01-15','Yang di-Pertuan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-01-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','Thaipusam','2018-01-31','2018-01-31','Thaipusam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-02-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','Lunar New Year','2018-02-16','2018-02-16','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-02-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','Lunar New Year','2018-02-17','2018-02-17','Chinese New Year','0',1,0);
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-04-14') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','Israk & Mikraj','2018-04-14','2018-04-14','Israk & Mikraj','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-05-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','Labour Day','2018-05-01','2018-05-01','Labour Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-05-29') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','Vesak Day','2018-05-29','2018-05-29','Vesak Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-06-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','Hari Raya Puasa','2018-06-15','2018-06-15','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-06-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','Hari Raya Puasa','2018-06-16','2018-06-16','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-08-22') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','Hari Raya Qurban','2018-08-22','2018-08-22','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-08-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','National Day','2018-08-31','2018-08-31','National Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-09-09') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','AgongBirthday','2018-09-09','2018-09-09','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-09-10') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','AgongBirthday','2018-09-10','2018-09-10','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-09-11') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','Awal Muharam','2018-09-11','2018-09-11','Awal Muharam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-09-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','Malaysia Day','2018-09-16','2018-09-16','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-09-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','Malaysia Day','2018-09-17','2018-09-17','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-11-06') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','Deepavali','2018-11-06','2018-11-06','Deepavali','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-11-20') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','Hari Keputeraan','2018-11-20','2018-11-20','Hari Keputeraan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-N.Sembilan' And HolidayStartDate ='2018-12-25') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-N.Sembilan','Christmas Day','2018-12-25','2018-12-25','Christmas Day','0',1,0); 
end if;

/* MY-Pahang */
If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-01-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','New Year','2018-01-01','2018-01-01','New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-02-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','Lunar New Year','2018-02-16','2018-02-16','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-02-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','Lunar New Year','2018-02-17','2018-02-17','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-05-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','Labour Day','2018-05-01','2018-05-01','Labour Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-05-07') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','Hol Day Pahang','2018-05-07','2018-05-07','Hol Day Pahang','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-05-29') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','Vesak Day','2018-05-29','2018-05-29','Vesak Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-06-02') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','Hari Nuzul Al-Quran','2018-06-02','2018-06-02','Hari Nuzul Al-Quran','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-06-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','Hari Raya Puasa','2018-06-15','2018-06-15','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-06-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','Hari Raya Puasa','2018-06-16','2018-06-16','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-08-22') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','Hari Raya Qurban','2018-08-22','2018-08-22','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-08-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','National Day','2018-08-31','2018-08-31','National Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-09-09') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','AgongBirthday','2018-09-09','2018-09-09','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-09-10') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','AgongBirthday','2018-09-10','2018-09-10','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-09-11') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','Awal Muharam','2018-09-11','2018-09-11','Awal Muharam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-09-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','Malaysia Day','2018-09-16','2018-09-16','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-09-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','Malaysia Day','2018-09-17','2018-09-17','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-10-24') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','Sultan Birthday','2018-10-24','2018-10-24','Birthday of Sultan of Pahang','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-11-06') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','Deepavali','2018-11-06','2018-11-06','Deepavali','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-11-20') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','Hari Keputeraan','2018-11-20','2018-11-20','Hari Keputeraan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Pahang' And HolidayStartDate ='2018-12-25') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Pahang','Christmas Day','2018-12-25','2018-12-25','Christmas Day','0',1,0); 
end if;

/* MY-Perak */
If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-01-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','New Year','2018-01-01','2018-01-01','New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-01-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','Thaipusam','2018-01-31','2018-01-31','Thaipusam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-02-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','Lunar New Year','2018-02-16','2018-02-16','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-02-17') then
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','Lunar New Year','2018-02-17','2018-02-17','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-05-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','Labour Day','2018-05-01','2018-05-01','Labour Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-05-29') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','Vesak Day','2018-05-29','2018-05-29','Vesak Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-06-02') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','Hari Nuzul Al-Quran','2018-06-02','2018-06-02','Hari Nuzul Al-Quran','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-06-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','Hari Raya Puasa','2018-06-15','2018-06-15','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-06-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','Hari Raya Puasa','2018-06-16','2018-06-16','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-08-22') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','Hari Raya Qurban','2018-08-22','2018-08-22','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-08-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','National Day','2018-08-31','2018-08-31','National Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-09-09') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','AgongBirthday','2018-09-09','2018-09-09','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-09-10') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','AgongBirthday','2018-09-10','2018-09-10','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-09-11') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','Awal Muharam','2018-09-11','2018-09-11','Awal Muharam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-09-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','Malaysia Day','2018-09-16','2018-09-16','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-09-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','Malaysia Day','2018-09-17','2018-09-17','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-11-02') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','Sultan Birthday','2018-11-02','2018-11-02','Birthday of Sultan of Perak','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-11-06') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','Deepavali','2018-11-06','2018-11-06','Deepavali','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-11-20') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','Hari Keputeraan','2018-11-20','2018-11-20','Hari Keputeraan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perak' And HolidayStartDate ='2018-12-25') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perak','Christmas Day','2018-12-25','2018-12-25','Christmas Day','0',1,0); 
end if;

/* MY-Perlis */
If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-02-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','Lunar New Year','2018-02-16','2018-02-16','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-02-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','Lunar New Year','2018-02-17','2018-02-17','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-04-14') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','Israk & Mikraj','2018-04-14','2018-04-14','Israk & Mikraj','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-05-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','Labour Day','2018-05-01','2018-05-01','Labour Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-05-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','Sultan Birthday','2018-05-17','2018-05-17','Birthday of Sultan of Perlis','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-05-29') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','Vesak Day','2018-05-29','2018-05-29','Vesak Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-06-02') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','Hari Nuzul Al-Quran','2018-06-02','2018-06-02','Hari Nuzul Al-Quran','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-06-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','Hari Raya Puasa','2018-06-15','2018-06-15','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-06-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','Hari Raya Puasa','2018-06-16','2018-06-16','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-08-22') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','Hari Raya Qurban','2018-08-22','2018-08-22','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-08-23') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','Hari Raya Qurban','2018-08-23','2018-08-23','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-08-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','National Day','2018-08-31','2018-08-31','National Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-09-09') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','AgongBirthday','2018-09-09','2018-09-09','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-09-10') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','AgongBirthday','2018-09-10','2018-09-10','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-09-11') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','Awal Muharam','2018-09-11','2018-09-11','Awal Muharam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-09-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','Malaysia Day','2018-09-16','2018-09-16','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-09-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','Malaysia Day','2018-09-17','2018-09-17','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-11-06') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','Deepavali','2018-11-06','2018-11-06','Deepavali','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-11-20') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','Hari Keputeraan','2018-11-20','2018-11-20','Hari Keputeraan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Perlis' And HolidayStartDate ='2018-12-25') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Perlis','Christmas Day','2018-12-25','2018-12-25','Christmas Day','0',1,0); 
end if;

/* MY-Penang */
If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-01-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','New Year','2018-01-01','2018-01-01','New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-01-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','Thaipusam','2018-01-31','2018-01-31','Thaipusam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-02-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','Lunar New Year','2018-02-16','2018-02-16','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-02-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','Lunar New Year','2018-02-17','2018-02-17','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-05-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','Labour Day','2018-05-01','2018-05-01','Labour Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-05-29') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','Vesak Day','2018-05-29','2018-05-29','Vesak Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-06-02') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','Hari Nuzul Al-Quran','2018-06-02','2018-06-02','Hari Nuzul Al-Quran','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-06-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','Hari Raya Puasa','2018-06-15','2018-06-15','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-06-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','Hari Raya Puasa','2018-06-16','2018-06-16','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-07-07') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','GeorgeTown Day','2018-07-07','2018-07-07','GeorgeTown Heritage Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-07-14') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','Yang di-Pertuan','2018-07-14','2018-07-14','Birthday Yang di-Pertuan Penang','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-08-22') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','Hari Raya Qurban','2018-08-22','2018-08-22','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-08-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','National Day','2018-08-31','2018-08-31','National Day','0',1,0);
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-09-09') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','AgongBirthday','2018-09-09','2018-09-09','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-09-10') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','AgongBirthday','2018-09-10','2018-09-10','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-09-11') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','Awal Muharam','2018-09-11','2018-09-11','Awal Muharam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-09-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','Malaysia Day','2018-09-16','2018-09-16','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-09-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','Malaysia Day','2018-09-17','2018-09-17','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-11-06') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','Deepavali','2018-11-06','2018-11-06','Deepavali','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-11-20') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','Hari Keputeraan','2018-11-20','2018-11-20','Hari Keputeraan','0',1,0);
end if;

If not exists (select * from Holidays where CountryId='MY-Penang' And HolidayStartDate ='2018-12-25') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Penang','Christmas Day','2018-12-25','2018-12-25','Christmas Day','0',1,0); 
end if;

/* MY-Sabah */
If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-01-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','New Year','2018-01-01','2018-01-01','New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-02-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','Lunar New Year','2018-02-16','2018-02-16','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-02-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','Lunar New Year','2018-02-17','2018-02-17','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-03-30') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','Good Friday','2018-03-30','2018-03-30','Good Friday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-05-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','Labour Day','2018-05-01','2018-05-01','Labour Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-05-29') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','Vesak Day','2018-05-29','2018-05-29','Vesak Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-06-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','Hari Raya Puasa','2018-06-15','2018-06-15','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-06-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','Hari Raya Puasa','2018-06-16','2018-06-16','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-08-22') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','Hari Raya Qurban','2018-08-22','2018-08-22','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-08-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','National Day','2018-08-31','2018-08-31','National Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-09-09') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','AgongBirthday','2018-09-09','2018-09-09','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-09-10') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','AgongBirthday','2018-09-10','2018-09-10','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-09-11') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','Awal Muharam','2018-09-11','2018-09-11','Awal Muharam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-09-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','Malaysia Day','2018-09-16','2018-09-16','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-09-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','Malaysia Day','2018-09-17','2018-09-17','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-10-06') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','Yang di-Pertuan','2018-10-06','2018-10-06','Birthday Yang di-Pertuan Sabah','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-11-06') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','Deepavali','2018-11-06','2018-11-06','Deepavali','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-11-20') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','Hari Keputeraan','2018-11-20','2018-11-20','Hari Keputeraan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sabah' And HolidayStartDate ='2018-12-25') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sabah','Christmas Day','2018-12-25','2018-12-25','Christmas Day','0',1,0); 
end if;

/* MY-Sarawak */
If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-01-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','New Year','2018-01-01','2018-01-01','New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-02-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','Lunar New Year','2018-02-16','2018-02-16','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-02-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','Lunar New Year','2018-02-17','2018-02-17','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-03-30') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','Good Friday','2018-03-30','2018-03-30','Good Friday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-05-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','Labour Day','2018-05-01','2018-05-01','Labour Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-05-29') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','Vesak Day','2018-05-29','2018-05-29','Vesak Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-06-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','Dayak Festival','2018-06-01','2018-06-01','Dayak Festival','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-06-02') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','Dayak Festival','2018-06-02','2018-06-02','Dayak Festival','0',1,0);
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-06-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','Hari Raya Puasa','2018-06-15','2018-06-15','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-06-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','Hari Raya Puasa','2018-06-16','2018-06-16','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-07-22') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','Independence Day','2018-07-22','2018-07-22','Sarawak''s Independence Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-07-23') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','Independence Day','2018-07-23','2018-07-23','Sarawak''s Independence Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-08-22') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','Hari Raya Qurban','2018-08-22','2018-08-22','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-08-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','National Day','2018-08-31','2018-08-31','National Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-09-09') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','AgongBirthday','2018-09-09','2018-09-09','AgongBirthday / Birthday Yang di-Pertuan Sarawak','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-09-10') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','AgongBirthday','2018-09-10','2018-09-10','AgongBirthday / Birthday Yang di-Pertuan Sarawak','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-09-11') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','Awal Muharam','2018-09-11','2018-09-11','Awal Muharam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-09-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','Malaysia Day','2018-09-16','2018-09-16','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-09-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','Malaysia Day','2018-09-17','2018-09-17','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-11-20') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','Hari Keputeraan','2018-11-20','2018-11-20','Hari Keputeraan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Sarawak' And HolidayStartDate ='2018-12-25') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Sarawak','Christmas Day','2018-12-25','2018-12-25','Christmas Day','0',1,0); 
end if;

/* MY-Selangor */
If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-01-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','New Year','2018-01-01','2018-01-01','New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-01-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','Thaipusam','2018-01-31','2018-01-31','Thaipusam','0',1,0);
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-02-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','Lunar New Year','2018-02-16','2018-02-16','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-02-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','Lunar New Year','2018-02-17','2018-02-17','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-05-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','Labour Day','2018-05-01','2018-05-01','Labour Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-05-29') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','Vesak Day','2018-05-29','2018-05-29','Vesak Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-06-02') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','Hari Nuzul Al-Quran','2018-06-02','2018-06-02','Hari Nuzul Al-Quran','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-06-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','Hari Raya Puasa','2018-06-15','2018-06-15','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-06-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','Hari Raya Puasa','2018-06-16','2018-06-16','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-08-22') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','Hari Raya Qurban','2018-08-22','2018-08-22','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-08-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','National Day','2018-08-31','2018-08-31','National Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-09-09') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','AgongBirthday','2018-09-09','2018-09-09','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-09-10') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','AgongBirthday','2018-09-10','2018-09-10','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-09-11') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','Awal Muharam','2018-09-11','2018-09-11','Awal Muharam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-09-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','Malaysia Day','2018-09-16','2018-09-16','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-09-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','Malaysia Day','2018-09-17','2018-09-17','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-11-06') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','Deepavali','2018-11-06','2018-11-06','Deepavali','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-11-20') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','Hari Keputeraan','2018-11-20','2018-11-20','Hari Keputeraan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-12-11') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','Sultan Birthday','2018-12-11','2018-12-11','Birthday of Sultan of Selangor','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Selangor'And HolidayStartDate ='2018-12-25') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Selangor','Christmas Day','2018-12-25','2018-12-25','Christmas Day','0',1,0); 
end if;

/* MY-Trengganu */
If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-02-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Lunar New Year','2018-02-16','2018-02-16','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-02-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Lunar New Year','2018-02-17','2018-02-17','Chinese New Year','0',1,0);
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-02-18') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Lunar New Year','2018-02-18','2018-02-18','Chinese New Year','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-03-04') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Anni Sultan Install','2018-03-04','2018-03-04','Anniversary Installation of Sultan of Trengganu','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-04-26') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Sultan Birthday','2018-04-26','2018-04-26','Birthday of Sultan of Trengganu','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-05-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Labour Day','2018-05-01','2018-05-01','Labour Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-05-29') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Vesak Day','2018-05-29','2018-05-29','Vesak Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-06-02') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Hari Nuzul Al-Quran','2018-06-02','2018-06-02','Hari Nuzul Al-Quran','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-06-03') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Hari Nuzul Al-Quran','2018-06-03','2018-06-03','Hari Nuzul Al-Quran','0',1,0); 
end if;
 
If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-06-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Hari Raya Puasa','2018-06-15','2018-06-15','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-06-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Hari Raya Puasa','2018-06-16','2018-06-16','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-06-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Hari Raya Puasa','2018-06-17','2018-06-17','Hari Raya Puasa','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-08-22') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Hari Raya Qurban','2018-08-22','2018-08-22','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-08-23') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Hari Raya Qurban','2018-08-23','2018-08-23','Hari Raya Qurban','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-08-31') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','National Day','2018-08-31','2018-08-31','National Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-09-09') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','AgongBirthday','2018-09-09','2018-09-09','AgongBirthday','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-09-11') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Awal Muharam','2018-09-11','2018-09-11','Awal Muharam','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-09-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Malaysia Day','2018-09-16','2018-09-16','Malaysia Day','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-11-06') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Deepavali','2018-11-06','2018-11-06','Deepavali','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-11-20') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Hari Keputeraan','2018-11-20','2018-11-20','Hari Keputeraan','0',1,0); 
end if;

If not exists (select * from Holidays where CountryId='MY-Trengganu' And HolidayStartDate ='2018-12-25') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('MY-Trengganu','Christmas Day','2018-12-25','2018-12-25','Christmas Day','0',1,0); 
end if;

commit work;