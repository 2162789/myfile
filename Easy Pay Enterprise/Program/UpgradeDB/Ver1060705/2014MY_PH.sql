If exists (select 1 from sys.sysprocedure where proc_name = 'PatchMalaysiaNationalHoliday') then
   Drop procedure PatchMalaysiaNationalHoliday
end if;

create procedure DBA.PatchMalaysiaNationalHoliday(in In_State char(20))
begin
  /* No 1 */
   insert into Holidays values(In_State,'ProphetMohdBirthday','2014-01-14','2014-01-14','Prophet Muhammad Birthday',0,1,0);
  
 /* No 2 to 3 */
   insert into Holidays values(In_State,'Lunar New Year','2014-01-31','2014-01-31','Chinese New Year',0,1,0);
 
  if(In_State <> 'MY-Kelantan'and In_State <> 'MY-Trengganu') then
     insert into Holidays values(In_State,'Lunar New Year','2014-02-01','2014-02-01','Chinese New Year',0,1,0);
  end if;
  
  if(In_State = 'MY-Kedah' or In_State = 'MY-Kelantan' or In_State = 'MY-Trengganu') then
     insert into Holidays values(In_State,'Lunar New Year','2014-02-02','2014-02-02','Chinese New Year',0,1,0);
  end if;

  /* No 4 to 5*/
  insert into Holidays values(In_State,'Labour Day','2014-05-01','2014-05-01','Labour Day',0,1,0);
  insert into Holidays values(In_State,'Vesak Day','2014-05-13','2014-05-13','Vesak',0,1,0);
  
  /* No 6 */
  if(In_State <> 'MY-Sarawak') then 
    insert into Holidays values(In_State,'AgongBirthday','2014-06-07','2014-06-07','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
  else
    insert into Holidays values(In_State,'AgongBirthday','2014-06-07','2014-06-07','Birthday of SPB Yang Di-pertuan Agong / Dayak Festival',0,1,0);
  end if;
  
  /* No 7*/
   insert into Holidays values(In_State,'Hari Raya Puasa','2014-07-28','2014-07-28','Hari Raya Puasa',0,1,0);
   insert into Holidays values(In_State,'Hari Raya Puasa','2014-07-29','2014-07-29','Hari Raya Puasa',0,1,0);

  /* No 8*/
  insert into Holidays values(In_State,'National Day','2014-08-31','2014-08-31','National Day',0,1,0);
  
  if(In_State <> 'MY-Kedah' and In_State <> 'MY-Kelantan' and In_State <> 'MY-Trengganu') then
     insert into Holidays values(In_State,'National Day','2014-09-01','2014-09-01','National Day',0,1,0);
  end if;
  
  /* No 9 */   
  insert into Holidays values(In_State,'Malaysia Day','2014-09-16','2014-09-16','Malaysia Day',0,1,0);
 
  /* No 10 */
  insert into Holidays values(In_State,'Hari Raya Qurban','2014-10-05','2014-10-05','Hari Raya Qurban',0,1,0);
  if(In_State = 'MY-Trengganu' or In_State = 'MY-Kelantan') then
      insert into Holidays values(In_State,'Hari Raya Qurban','2014-10-06','2014-10-06','Hari Raya Qurban',0,1,0);
  end if;
 
  /* No 11 */
  if(In_State <> 'MY-Sarawak') then
    insert into Holidays values(In_State,'Deepavali','2014-10-23','2014-10-23','Deepavali',0,1,0);
  end if;
  
  /* No 12 */
  insert into Holidays values(In_State,'Awal Muharam','2014-10-25','2014-10-25','Awal Muharam',0,1,0);
  
  /* No 13*/
  insert into Holidays values(In_State,'Christmas Day','2014-12-25','2014-12-25','Christmas Day',0,1,0);

end;

Delete From Holidays where Year(HolidayStartDate) = 2014;

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
  Kedah, Kelantan and Terengganu PH on Fri (Jumaat), Monday is Holiday
*/
  /* No 1 New Year */
  insert into Holidays values('MY','New Year','2014-01-01','2014-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Labuan','New Year','2014-01-01','2014-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Melaka','New Year','2014-01-01','2014-01-01','New Year',0,1,0);
  insert into Holidays values('MY-N.Sembilan','New Year','2014-01-01','2014-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Pahang','New Year','2014-01-01','2014-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Perak','New Year','2014-01-01','2014-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Penang','New Year','2014-01-01','2014-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Sabah','New Year','2014-01-01','2014-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Sarawak','New Year','2014-01-01','2014-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Selangor','New Year','2014-01-01','2014-01-01','New Year',0,1,0);

  /* No 2 Yang di-Pertuan  */
  insert into Holidays values('MY-N.Sembilan','Yang di-Pertuan','2014-01-14','2014-01-14','Birthday of Yang di-Pertuan Besar of Negri Sembilan',0,1,0);

  /* No 3 Thaipusam */
  insert into Holidays values('MY','Thaipusam','2014-01-17','2014-01-17','Thaipusam',0,1,0);
  insert into Holidays values('MY-Johor','Thaipusam','2014-01-17','2014-01-17','Thaipusam',0,1,0);
  insert into Holidays values('MY-N.Sembilan','Thaipusam','2014-01-17','2014-01-17','Thaipusam',0,1,0);
  insert into Holidays values('MY-Perak','Thaipusam','2014-01-17','2014-01-17','Thaipusam',0,1,0);
  insert into Holidays values('MY-Penang','Thaipusam','2014-01-17','2014-01-17','Thaipusam',0,1,0);
  insert into Holidays values('MY-Selangor','Thaipusam','2014-01-17','2014-01-17','Thaipusam',0,1,0);
  
  /* No 4 Sultan Birthday */
  insert into Holidays values('MY-Kedah','Sultan Birthday','2014-01-19','2014-01-19','Birthday of Sultan of Kedah',0,1,0);

  /* No 5 to 13 */
  insert into Holidays values('MY','Federal Territory','2014-02-01','2014-02-01','Federal Territory Day',0,1,0);
  insert into Holidays values('MY-Labuan','Federal Territory','2014-02-01','2014-02-01','Federal Territory Day',0,1,0);
  
  insert into Holidays values('MY-Kelantan','Lunar New Year','2014-02-01','2014-02-01','Chinese New Year',0,1,0);
  insert into Holidays values('MY-Trengganu','Lunar New Year','2014-02-01','2014-02-01','Chinese New Year',0,1,0);
 
  insert into Holidays values('MY-Trengganu','Sultan Birthday','2014-03-04','2014-03-04','Birthday of Sultan of Trengganu',0,1,0);
  
  insert into Holidays values('MY-Melaka','HistoricalCity','2014-04-15','2014-04-15','Declaration of Melaka as Historical City',0,1,0);
  
  insert into Holidays values('MY-Sabah','Good Friday','2014-04-18','2014-04-18','Good Friday',0,1,0);
  insert into Holidays values('MY-Sarawak','Good Friday','2014-04-18','2014-04-18','Good Friday',0,1,0);

  insert into Holidays values('MY-Perak','Sultan Birthday','2014-04-19','2014-04-19','Birthday of Sultan of Perak',0,1,0);
 
  insert into Holidays values('MY-Trengganu','Sultan Birthday','2014-04-26','2014-04-26','Birthday of Sultan of Trengganu',0,1,0);
  
  insert into Holidays values('MY-Pahang','Hol Day Pahang','2014-05-07','2014-05-07','Hol Day Pahang',0,1,0);
  
  insert into Holidays values('MY-Perlis','Sultan Birthday','2014-05-17','2014-05-17','Birthday of Sultan of Perlis',0,1,0);

  /* No 14 Israk & Mikraj */
  insert into Holidays values('MY-Kedah','Israk & Mikraj','2014-05-27','2014-05-27','Israk & Mikraj',0,1,0);
  insert into Holidays values('MY-N.Sembilan','Israk & Mikraj','2014-05-27','2014-05-27','Israk & Mikraj',0,1,0);
  insert into Holidays values('MY-Perlis','Israk & Mikraj','2014-05-27','2014-05-27','Israk & Mikraj',0,1,0);
  
  /* No 15 Harvest Festival */
  insert into Holidays values('MY-Labuan','Harvest Festival','2014-05-30','2014-05-30','Harvest Festival',0,1,0);
  insert into Holidays values('MY-Labuan','Harvest Festival','2014-05-31','2014-05-31','Harvest Festival',0,1,0);
  insert into Holidays values('MY-Sabah','Harvest Festival','2014-05-30','2014-05-30','Harvest Festival',0,1,0);
  insert into Holidays values('MY-Sabah','Harvest Festival','2014-05-31','2014-05-31','Harvest Festival',0,1,0);

  /* No 16 Dayak Festival */
  insert into Holidays values('MY-Sarawak','Dayak Festival','2014-06-01','2014-06-01','Dayak Festival',0,1,0);
  insert into Holidays values('MY-Sarawak','Dayak Festival','2014-06-02','2014-06-02','Dayak Festival',0,1,0);

  /* No 17 Awal Ramadan */
  insert into Holidays values('MY-Johor','Awal Ramadan','2014-06-29','2014-06-29','Awal Ramadan',0,1,0);
  insert into Holidays values('MY-Johor','Awal Ramadan','2014-06-30','2014-06-30','Awal Ramadan',0,1,0);
  insert into Holidays values('MY-Kedah','Awal Ramadan','2014-06-29','2014-06-29','Awal Ramadan',0,1,0);
  insert into Holidays values('MY-Melaka','Awal Ramadan','2014-06-29','2014-06-29','Awal Ramadan',0,1,0);
  insert into Holidays values('MY-Melaka','Awal Ramadan','2014-06-30','2014-06-30','Awal Ramadan',0,1,0);
  
  /* No 18 GeorgeTown Day*/
  insert into Holidays values('MY-Penang','GeorgeTown Day','2014-07-07','2014-07-07','GeorgeTown Heritage Day',0,1,0);
  
  /* No 19 */
  insert into Holidays values('MY-Penang','Yang di-Pertuan','2014-07-12','2014-07-12','Birthday Yang di-Pertuan Penang',0,1,0);

  /* No 20 Hari Nuzul Al-Quran */
  insert into Holidays values('MY-Kelantan','Hari Nuzul Al-Quran','2014-07-15','2014-07-15','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Pahang','Hari Nuzul Al-Quran','2014-07-15','2014-07-15','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Perak','Hari Nuzul Al-Quran','2014-07-15','2014-07-15','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Perlis','Hari Nuzul Al-Quran','2014-07-15','2014-07-15','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Penang','Hari Nuzul Al-Quran','2014-07-15','2014-07-15','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Selangor','Hari Nuzul Al-Quran','2014-07-15','2014-07-15','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Trengganu','Hari Nuzul Al-Quran','2014-07-15','2014-07-15','Hari Nuzul Al-Quran',0,1,0);
  
  /* No 21 to 22 */
  insert into Holidays values('MY-Sarawak','Yang di-Pertuan','2014-09-13','2014-09-13','Birthday Yang di-Pertuan Sarawak',0,1,0);
  
  insert into Holidays values('MY-Sabah','Yang di-Pertuan','2014-10-04','2014-10-04','Birthday Yang di-Pertuan Sabah',0,1,0);
  
  /* No 23 Hari Raya Qurban */
  insert into Holidays values('MY-Kedah','Hari Raya Qurban','2014-10-06','2014-10-06','Hari Raya Qurban',0,1,0);
  insert into Holidays values('MY-Perlis','Hari Raya Qurban','2014-10-06','2014-10-06','Hari Raya Qurban',0,1,0);
  
  /* No 24 Birthday of TYT Yang di-Pertuan of Melaka */
  insert into Holidays values('MY-Melaka','Yang di-Pertuan','2014-10-10','2014-10-10','Birthday of TYT Yang di-Pertuan of Melaka',0,1,0);

  /* No 25 */
  insert into Holidays values('MY-Pahang','Sultan Birthday','2014-10-24','2014-10-24','Birthday of Sultan of Pahang',0,1,0);

  /* No 26 to 29 */
  insert into Holidays values('MY-Kelantan','Sultan Birthday','2014-11-11','2014-11-11','Birthday of Sultan of Kelantan',0,1,0);
  insert into Holidays values('MY-Kelantan','Sultan Birthday','2014-11-12','2014-11-12','Birthday of Sultan of Kelantan',0,1,0);
  
  insert into Holidays values('MY-Johor','Sultan Birthday','2014-11-22','2014-11-22','Birthday of Sultan of Johor',0,1,0);
  
  insert into Holidays values('MY-Johor','Almarhum Sultan','2014-11-29','2014-11-29','Hol Day Almarhum Sultan Johor',0,1,0);
  
  insert into Holidays values('MY-Selangor','Sultan Birthday','2014-12-11','2014-12-11','Birthday of Sultan of Selangor',0,1,0);

commit work;
