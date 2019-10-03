/*==============================================================*/
/* Malaysia 2019 Holidays                                       */
/*==============================================================*/

/* Johor */
If not exists (select * from Holidays where CountryId='MY-Johor' And HolidayStartDate ='2019-10-06') then Insert into Holidays(CountryId,HolidayId,HolidayStartDate,HolidayEndDate,HolidayDesc,HolidayLvePattern,HolidayWorkPattern,HolidayPayPattern) Values('MY-Johor','Almarhum Sultan','2019-10-06','2019-10-06','Hol Day Almarhum Sultan Iskandar','0',1,0); end if;

commit work;