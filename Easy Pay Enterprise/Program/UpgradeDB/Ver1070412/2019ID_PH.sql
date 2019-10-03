/*==============================================================*/
/* Indonesia 2019 Holidays                                       */
/*==============================================================*/

/* Remove "Easter Sunday"  */
DELETE from Holidays where HolidayId = 'Easter Sunday' and CountryId='Indonesia' And HolidayStartDate ='2019-04-21';
commit work;

