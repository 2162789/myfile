
 If exists (select 1 from sys.sysprocedure where proc_name = 'PatchMalaysiaNationalHoliday') then
   Drop procedure PatchMalaysiaNationalHoliday
end if;

create procedure DBA.PatchMalaysiaNationalHoliday(in In_State char(20))
begin
  /* No 1 */
  insert into Holidays values(In_State,'ProphetMohdBirthday','2013-01-24','2013-01-24','Prophet Muhammad Birthday',0,1,0);
  
 /* No 2 */
  insert into Holidays values(In_State,'Lunar New Year','2013-02-10','2013-02-10','Chinese New Year',0,1,0);
  if(In_State <> 'MY-Kelantan' and In_State <> 'MY-Trengganu') then
    insert into Holidays values(In_State,'Lunar New Year','2013-02-11','2013-02-11','Chinese New Year',0,1,0);
  end if;

  /* No 3 to 4*/
  insert into Holidays values(In_State,'Labour Day','2013-05-01','2013-05-01','Labour Day',0,1,0);
  insert into Holidays values(In_State,'Vesak Day','2013-05-24','2013-05-24','Vesak',0,1,0);
  if(In_State = 'MY-Kelantan' OR In_State = 'MY-Trengganu' OR In_State = 'MY-Kedah') then
     insert into Holidays values(In_State,'Vesak Day','2013-05-26','2013-05-26','Vesak',0,1,0);
  end if;
  
  /* No 5 */
  if(In_State <> 'MY-Sarawak') then 
    insert into Holidays values(In_State,'AgongBirthday','2013-06-01','2013-06-01','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
  else
    insert into Holidays values(In_State,'AgongBirthday','2013-06-01','2013-06-01','Birthday of SPB Yang Di-pertuan Agong / Dayak Festival',0,1,0);
  end if;
  
  /* No 6 to 8 */
  insert into Holidays values(In_State,'Hari Raya Puasa','2013-08-08','2013-08-08','Hari Raya Puasa',0,1,0);
  insert into Holidays values(In_State,'Hari Raya Puasa','2013-08-09','2013-08-09','Hari Raya Puasa',0,1,0);
  if(In_State = 'MY-Kelantan' OR In_State = 'MY-Trengganu' OR In_State = 'MY-Kedah') then
     insert into Holidays values(In_State,'Hari Raya Puasa','2013-08-11','2013-08-11','Hari Raya Puasa',0,1,0);
  end if;
  
  insert into Holidays values(In_State,'National Day','2013-08-31','2013-08-31','National Day',0,1,0);
  insert into Holidays values(In_State,'Malaysia Day','2013-09-16','2013-09-16','Malaysia Day',0,1,0);
 
  /* No 9 */
  insert into Holidays values(In_State,'Hari Raya Qurban','2013-10-15','2013-10-15','Hari Raya Qurban',0,1,0);
  if(In_State = 'MY-Trengganu' or In_State = 'MY-Kelantan') then
    insert into Holidays values(In_State,'Hari Raya Qurban','2013-10-16','2013-10-16','Hari Raya Qurban',0,1,0);
  end if;
 
  /* No 10 */
  if(In_State <> 'MY-Labuan' and In_State <> 'MY-Sarawak') then
    insert into Holidays values(In_State,'Deepavali','2013-11-02','2013-11-02','Deepavali',0,1,0);
  end if;
  
  /* No 11 to 12 */
  insert into Holidays values(In_State,'Awal Muharam','2013-11-05','2013-11-05','Awal Muharam',0,1,0);
  insert into Holidays values(In_State,'Christmas Day','2013-12-25','2013-12-25','Christmas Day',0,1,0);

end;

Delete From Holidays where Year(HolidayStartDate) = 2013;

call PatchMalaysiaNationalHoliday('MY');
call PatchMalaysiaNationalHoliday('MY-Labuan');
call PatchMalaysiaNationalHoliday('MY-Johor');
call PatchMalaysiaNationalHoliday('MY-Kedah');
call PatchMalaysiaNationalHoliday('MY-Kelantan');
call PatchMalaysiaNationalHoliday('MY-Melaka');
call PatchMalaysiaNationalHoliday('MY-N.Sembilan');
call PatchMalaysiaNationalHoliday('MY-Pahang');
call PatchMalaysiaNationalHoliday('MY-Perak');
call PatchMalaysiaNationalHoliday('MY-Perlis');
call PatchMalaysiaNationalHoliday('MY-Penang');
call PatchMalaysiaNationalHoliday('MY-Sabah');
call PatchMalaysiaNationalHoliday('MY-Sarawak');
call PatchMalaysiaNationalHoliday('MY-Selangor');
call PatchMalaysiaNationalHoliday('MY-Trengganu');
Drop procedure PatchMalaysiaNationalHoliday;

/*
  Kedah, Kelantan and Terengganu PH on Sat (Sabtu), Sun is Holiday
*/
  /* No 1 New Year */
  insert into Holidays values('MY','New Year','2013-01-01','2013-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Labuan','New Year','2013-01-01','2013-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Melaka','New Year','2013-01-01','2013-01-01','New Year',0,1,0);
  insert into Holidays values('MY-N.Sembilan','New Year','2013-01-01','2013-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Pahang','New Year','2013-01-01','2013-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Perak','New Year','2013-01-01','2013-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Penang','New Year','2013-01-01','2013-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Sabah','New Year','2013-01-01','2013-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Sarawak','New Year','2013-01-01','2013-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Selangor','New Year','2013-01-01','2013-01-01','New Year',0,1,0);

  /* No 2 to 3  */
  insert into Holidays values('MY-N.Sembilan','Yang di-Pertuan','2013-01-14','2013-01-14','Birthday of Yang di-Pertuan Besar of Negri Sembilan',0,1,0);
  insert into Holidays values('MY-Kedah','Sultan Birthday','2013-01-20','2013-01-20','Birthday of Sultan of Kedah',0,1,0);

  /* No 4 Thaipusam */
  insert into Holidays values('MY','Thaipusam','2013-01-27','2013-01-27','Thaipusam',0,1,0);
  insert into Holidays values('MY','Thaipusam','2013-01-28','2013-01-28','Thaipusam',0,1,0);
  insert into Holidays values('MY-Johor','Thaipusam','2013-01-27','2013-01-27','Thaipusam',0,1,0);
  insert into Holidays values('MY-Johor','Thaipusam','2013-01-28','2013-01-28','Thaipusam',0,1,0);
  insert into Holidays values('MY-N.Sembilan','Thaipusam','2013-01-27','2013-01-27','Thaipusam',0,1,0);
  insert into Holidays values('MY-N.Sembilan','Thaipusam','2013-01-28','2013-01-28','Thaipusam',0,1,0);
  insert into Holidays values('MY-Perak','Thaipusam','2013-01-27','2013-01-27','Thaipusam',0,1,0);
  insert into Holidays values('MY-Perak','Thaipusam','2013-01-28','2013-01-28','Thaipusam',0,1,0);
  insert into Holidays values('MY-Penang','Thaipusam','2013-01-27','2013-01-27','Thaipusam',0,1,0);
  insert into Holidays values('MY-Penang','Thaipusam','2013-01-28','2013-01-28','Thaipusam',0,1,0);
  insert into Holidays values('MY-Selangor','Thaipusam','2013-01-27','2013-01-27','Thaipusam',0,1,0);
  insert into Holidays values('MY-Selangor','Thaipusam','2013-01-28','2013-01-28','Thaipusam',0,1,0);

  /* No 5 to 13 */
  insert into Holidays values('MY','Federal Territory','2013-02-01','2013-02-01','Federal Territory Day',0,1,0);
  insert into Holidays values('MY-Labuan','Federal Territory','2013-02-01','2013-02-01','Federal Territory Day',0,1,0);
  insert into Holidays values('MY-Kelantan','Lunar New Year','2013-02-11','2013-02-11','Chinese New Year',0,1,0);
  insert into Holidays values('MY-Trengganu','Lunar New Year','2013-02-11','2013-02-11','Chinese New Year',0,1,0);
  insert into Holidays values('MY-Trengganu','Sultan Birthday','2013-03-04','2013-03-04','Birthday of Sultan of Trengganu',0,1,0);
  insert into Holidays values('MY-Sabah','Good Friday','2013-03-29','2013-03-29','Good Friday',0,1,0);
  insert into Holidays values('MY-Sarawak','Good Friday','2013-03-29','2013-03-29','Good Friday',0,1,0);
  insert into Holidays values('MY-Melaka','HistoricalCity','2013-04-15','2013-04-15','Declaration of Melaka as Historical City',0,1,0);
  insert into Holidays values('MY-Perak','Sultan Birthday','2013-04-19','2013-04-19','Birthday of Sultan of Perak',0,1,0);
  insert into Holidays values('MY-Trengganu','Sultan Birthday','2013-04-26','2013-04-26','Birthday of Sultan of Trengganu',0,1,0);
  insert into Holidays values('MY-Trengganu','Sultan Birthday','2013-04-28','2013-04-28','Birthday of Sultan of Trengganu',0,1,0);
  insert into Holidays values('MY-Pahang','Hol Day Pahang','2013-05-07','2013-05-07','Hol Day Pahang',0,1,0);
  insert into Holidays values('MY-Perlis','Sultan Birthday','2013-05-17','2013-05-17','Birthday of Sultan of Perlis',0,1,0);

  /* No 14 Harvest Festival */
  insert into Holidays values('MY-Labuan','Harvest Festival','2013-05-30','2013-05-30','Harvest Festival',0,1,0);
  insert into Holidays values('MY-Labuan','Harvest Festival','2013-05-31','2013-05-31','Harvest Festival',0,1,0);
  insert into Holidays values('MY-Sabah','Harvest Festival','2013-05-30','2013-05-30','Harvest Festival',0,1,0);
  insert into Holidays values('MY-Sabah','Harvest Festival','2013-05-31','2013-05-31','Harvest Festival',0,1,0);

  /* No 15 Dayak Festival */
  insert into Holidays values('MY-Sarawak','Dayak Festival','2013-06-02','2013-06-02','Dayak Festival',0,1,0);
  insert into Holidays values('MY-Sarawak','Dayak Festival','2013-06-03','2013-06-03','Dayak Festival',0,1,0);
  /* No 16 Israk & Mikraj */
  insert into Holidays values('MY-Kedah','Israk & Mikraj','2013-06-06','2013-06-06','Israk & Mikraj',0,1,0);
  insert into Holidays values('MY-N.Sembilan','Israk & Mikraj','2013-06-06','2013-06-06','Israk & Mikraj',0,1,0);
  insert into Holidays values('MY-Perlis','Israk & Mikraj','2013-06-06','2013-06-06','Israk & Mikraj',0,1,0);

  /* No 17 */
  insert into Holidays values('MY-Penang','GeorgeTown Day','2013-07-07','2013-07-07','GeorgeTown Heritage Day',0,1,0);
  insert into Holidays values('MY-Penang','GeorgeTown Day','2013-07-08','2013-07-08','GeorgeTown Heritage Day',0,1,0);

  /* No 18 Awal Ramadan */
  insert into Holidays values('MY-Johor','Awal Ramadan','2013-07-10','2013-07-10','Awal Ramadan',0,1,0);
  insert into Holidays values('MY-Kedah','Awal Ramadan','2013-07-10','2013-07-10','Awal Ramadan',0,1,0);
  insert into Holidays values('MY-Melaka','Awal Ramadan','2013-07-10','2013-07-10','Awal Ramadan',0,1,0);

  /* No 19 */
  insert into Holidays values('MY-Penang','Yang di-Pertuan','2013-07-13','2013-07-13','Birthday Yang di-Pertuan Penang',0,1,0);

  /* No 20 Hari Nuzul Al-Quran */
  insert into Holidays values('MY-Kelantan','Hari Nuzul Al-Quran','2013-07-26','2013-07-26','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Kelantan','Hari Nuzul Al-Quran','2013-07-28','2013-07-28','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Pahang','Hari Nuzul Al-Quran','2013-07-26','2013-07-26','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Perak','Hari Nuzul Al-Quran','2013-07-26','2013-07-26','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Perlis','Hari Nuzul Al-Quran','2013-07-26','2013-07-26','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Penang','Hari Nuzul Al-Quran','2013-07-26','2013-07-26','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Selangor','Hari Nuzul Al-Quran','2013-07-26','2013-07-26','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Trengganu','Hari Nuzul Al-Quran','2013-07-26','2013-07-26','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Trengganu','Hari Nuzul Al-Quran','2013-07-28','2013-07-28','Hari Nuzul Al-Quran',0,1,0);
  
  /* No 21 to 23 */
  insert into Holidays values('MY-Sarawak','Yang di-Pertuan','2013-09-07','2013-09-07','Birthday Yang di-Pertuan Sarawak',0,1,0);
  insert into Holidays values('MY-Sabah','Yang di-Pertuan','2013-10-05','2013-10-05','Birthday Yang di-Pertuan Sabah',0,1,0);
  insert into Holidays values('MY-Melaka','Yang di-Pertuan','2013-10-12','2013-10-12','Birthday of TYT Yang di-Pertuan of Melaka',0,1,0);

 /* No 24 Hari Raya Qurban */
  insert into Holidays values('MY-Kedah','Hari Raya Qurban','2013-10-16','2013-10-16','Hari Raya Qurban',0,1,0);
  insert into Holidays values('MY-Perlis','Hari Raya Qurban','2013-10-16','2013-10-16','Hari Raya Qurban',0,1,0);

 /* No 25 */
  insert into Holidays values('MY-Pahang','Sultan Birthday','2013-10-24','2013-10-24','Birthday of Sultan of Pahang',0,1,0);

  /* No 26 to 29 */
  insert into Holidays values('MY-Kelantan','Sultan Birthday','2013-11-11','2013-11-11','Birthday of Sultan of Kelantan',0,1,0);
  insert into Holidays values('MY-Kelantan','Sultan Birthday','2013-11-12','2013-11-12','Birthday of Sultan of Kelantan',0,1,0);
  insert into Holidays values('MY-Johor','Sultan Birthday','2013-11-22','2013-11-22','Birthday of Sultan of Johor',0,1,0);
  insert into Holidays values('MY-Johor','Almarhum Sultan','2013-12-09','2013-12-09','Hol Day Almarhum Sultan Johor',0,1,0);
  insert into Holidays values('MY-Selangor','Sultan Birthday','2013-12-11','2013-12-11','Birthday of Sultan of Selangor',0,1,0);

commit work;
