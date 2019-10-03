/*==============================================================*/
/* Thailand 2019 Holidays                                       */
/*==============================================================*/
/* 1. To reuse Late King Bhumibol Adulyadej Memorial as per 2018 */
UPDATE Holidays SET HolidayDesc = 'Late King Bhumibol Adulyadej Memorial' where CountryId='Thailand' And HolidayStartDate ='2019-10-14';

commit work;