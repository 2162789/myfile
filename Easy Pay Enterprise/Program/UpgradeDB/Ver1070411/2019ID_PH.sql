/*==============================================================*/
/* Indonesia 2019 Holidays                                       */
/*==============================================================*/
/* 1. Reuse "Ascension of the Prophet" as per 2018 instead of creating a new "Isra Miraj" record */
UPDATE Holidays SET HolidayID = 'Ascension of Prophet', HolidayDesc = 'Ascension of the Prophet' WHERE CountryId='Indonesia' And HolidayStartDate ='2019-04-03'

/* 2. Use "Election" and "Pemilu" respectively without the year value so that this ID and Description can be reused in future if required */
UPDATE Holidays SET HolidayID = 'Election', HolidayDesc = 'Pemilu (Election)' WHERE CountryId='Indonesia' And HolidayStartDate ='2019-04-17'

/* 3. Reuse "Easter Sunday" which is existing up to 2011 instead of creating a new "Easter Day" record */
UPDATE Holidays SET HolidayId = 'Easter Sunday', HolidayDesc = 'Easter Sunday' WHERE CountryId='Indonesia' And HolidayStartDate ='2019-04-21'

/* 4. Reuse "Tahun Baru Hijrah (Islamic New Year)" as per 2018 instead of creating a new "Tahun Baru Islam (Islamic New Year)" record */
UPDATE Holidays SET HolidayId = 'Tahun Baru Hijrah', HolidayDesc = 'Tahun Baru Hijrah (Islamic New Year)' WHERE CountryId='Indonesia' And HolidayStartDate ='2019-09-01';

commit work;

