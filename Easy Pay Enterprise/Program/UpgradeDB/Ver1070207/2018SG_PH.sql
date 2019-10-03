If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2018-01-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Singapore','New Year','2018-01-01','2018-01-01','New Year',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2018-02-16') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Singapore','Chinese New Year','2018-02-16','2018-02-16','Chinese New Year',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2018-02-17') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Singapore','Chinese New Year','2018-02-17','2018-02-17','Chinese New Year',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2018-03-30') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Singapore','Good Friday','2018-03-30','2018-03-30','Good Friday',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2018-05-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Singapore','Labour Day','2018-05-01','2018-05-01','Labour Day',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2018-05-29') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Singapore','Vesak Day','2018-05-29','2018-05-29','Vesak Day',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2018-06-15') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Singapore','Hari Raya Puasa','2018-06-15','2018-06-15','Hari Raya Puasa',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2018-08-09') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Singapore','National Day','2018-08-09','2018-08-09','National Day',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2018-08-22') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Singapore','Hari Raya Haji','2018-08-22','2018-08-22','Hari Raya Haji',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2018-11-06') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Singapore','Deepavali','2018-11-06','2018-11-06','Deepavali',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2018-12-25') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Singapore','Christmas Day','2018-12-25','2018-12-25','Christmas Day',0,1,0); 
end if;

commit work;