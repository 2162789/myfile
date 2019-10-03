If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2018-01-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Philippines','New Year','2018-01-01','2018-01-01','New Year',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2018-03-29') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Philippines','Maundy Thursday','2018-03-29','2018-03-29','Maundy Thursday',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2018-03-30') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Philippines','Good Friday','2018-03-30','2018-03-30','Good Friday',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2018-04-09') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Philippines','Day of Valor','2018-04-09','2018-04-09','Day of Valor',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2018-05-01') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Philippines','Labor Day','2018-05-01','2018-05-01','Labor Day',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2018-06-12') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Philippines','Independence Day','2018-06-12','2018-06-12','Independence Day',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2018-08-27') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Philippines','National Heroes','2018-08-27','2018-08-27','National Heroes Day',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2018-11-30') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Philippines','Bonifacio Day','2018-11-30','2018-11-30','Bonifacio Day',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2018-12-25') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Philippines','Christmas Day','2018-12-25','2018-12-25','Christmas Day',0,1,0); 
end if;

If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2018-12-30') then 
  Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) 
  Values('Philippines','Rizal Day','2018-12-30','2018-12-30','Rizal Day',0,1,0); 
end if;

commit work;