/*==============================================================*/
/* Singapore 2019 Holiday                                       */
/*==============================================================*/
If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2019-01-01') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Singapore','New Year','2019-01-01','2019-01-01','New Year',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2019-02-05') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Singapore','Chinese New Year','2019-02-05','2019-02-05','Chinese New Year',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2019-02-06') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Singapore','Chinese New Year','2019-02-06','2019-02-06','Chinese New Year',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2019-04-19') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Singapore','Good Friday','2019-04-19','2019-04-19','Good Friday',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2019-05-01') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Singapore','Labour Day','2019-05-01','2019-05-01','Labour Day',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2019-05-19') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Singapore','Vesak Day','2019-05-19','2019-05-19','Vesak Day',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2019-05-20') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Singapore','Vesak Day','2019-05-20','2019-05-20','Vesak Day',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2019-06-05') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Singapore','Hari Raya Puasa','2019-06-05','2019-06-05','Hari Raya Puasa',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2019-08-09') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Singapore','National Day','2019-08-09','2019-08-09','National Day',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2019-08-11') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Singapore','Hari Raya Haji','2019-08-11','2019-08-11','Hari Raya Haji',0,1,0); 
end if;
	If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2019-08-12') then 
Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Singapore','Hari Raya Haji','2019-08-12','2019-08-12','Hari Raya Haji',0,1,0); 
end if;
	If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2019-10-27') then 
Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Singapore','Deepavali','2019-10-27','2019-10-27','Deepavali',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2019-10-28') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Singapore','Deepavali','2019-10-28','2019-10-28','Deepavali',0,1,0); 
end if;
If not exists (select * from Holidays where CountryId='Singapore' And HolidayStartDate ='2019-12-25') then 
	Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('Singapore','Christmas Day','2019-12-25','2019-12-25','Christmas Day',0,1,0); 
end if;

commit work;