/*==============================================================*/
/* Philippines 2019 Holidays                                    */
/*==============================================================*/
If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2019-01-01') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Philippines','New Year','2019-01-01','2019-01-01','New Year',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2019-04-09') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Philippines','Day of Valor','2019-04-09','2019-04-09','Day of Valor',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2019-04-18') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Philippines','Maundy Thursday','2019-04-18','2019-04-18','Maundy Thursday',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2019-04-19') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Philippines','Good Friday','2019-04-19','2019-04-19','Good Friday',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2019-05-01') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Philippines','Labor Day','2019-05-01','2019-05-01','Labor Day',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2019-06-12') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Philippines','Independence Day','2019-06-12','2019-06-12','Independence Day',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2019-08-26') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Philippines','National Heroes','2019-08-26','2019-08-26','National Heroes Day',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2019-11-30') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Philippines','Bonifacio Day','2019-11-30','2019-11-30','Bonifacio Day',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2019-12-25') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Philippines','Christmas Day','2019-12-25','2019-12-25','Christmas Day',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Philippines' And HolidayStartDate ='2019-12-30') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Philippines','Rizal Day','2019-12-30','2019-12-30','Rizal Day',0,1,0); 
end if;


commit work;