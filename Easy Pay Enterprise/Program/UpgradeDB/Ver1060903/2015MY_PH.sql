If exists (select 1 from sys.sysprocedure where proc_name = 'PatchMalaysiaNationalHoliday') then
   Drop procedure PatchMalaysiaNationalHoliday
end if;

create procedure DBA.PatchMalaysiaNationalHoliday(in In_State char(20))
begin
  /* No 1 */
   insert into Holidays values(In_State,'ProphetMohdBirthday','2015-01-03','2015-01-03','Prophet Muhammad Birthday',0,1,0);
  
 /* No 2*/
   insert into Holidays values(In_State,'Lunar New Year','2015-02-19','2015-02-19','Chinese New Year',0,1,0);
 
  if(In_State <> 'MY-Kelantan'and In_State <> 'MY-Trengganu') then
     insert into Holidays values(In_State,'Lunar New Year','2015-02-20','2015-02-20','Chinese New Year',0,1,0);
  end if;
  
  if(In_State = 'MY-Kedah' or In_State = 'MY-Johor') then
     insert into Holidays values(In_State,'Lunar New Year','2015-02-22','2015-02-22','Chinese New Year',0,1,0);
  end if;

  /* No 3*/
  insert into Holidays values(In_State,'Labour Day','2015-05-01','2015-05-01','Labour Day',0,1,0);

  /* No 4*/

  insert into Holidays values(In_State,'Vesak Day','2015-05-03','2015-05-03','Vesak',0,1,0);

  if(In_State <> 'MY-Kedah' and In_State <> 'MY-Kelantan' and In_State <> 'MY-Trengganu' and In_State <> 'MY-Johor') then
    insert into Holidays values(In_State,'Vesak Day','2015-05-04','2015-05-04','Vesak Day',0,1,0);
   end if;
     
  /* No 5 */
  if(In_State <> 'MY-Sarawak') then 
    insert into Holidays values(In_State,'AgongBirthday','2015-06-06','2015-06-06','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
  else
    insert into Holidays values(In_State,'AgongBirthday','2015-06-06','2015-06-06','Birthday of SPB Yang Di-pertuan Agong / Dayak Festival',0,1,0);
  end if;
  
  /* No 6*/
   insert into Holidays values(In_State,'Hari Raya Puasa','2015-07-17','2015-07-17','Hari Raya Puasa',0,1,0);
   insert into Holidays values(In_State,'Hari Raya Puasa','2015-07-18','2015-07-18','Hari Raya Puasa',0,1,0);

  if(In_State = 'MY-Kedah' or In_State = 'MY-Kelantan' or In_State = 'MY-Trengganu' or In_State = 'MY-Johor') then
     insert into Holidays values(In_State,'Hari Raya Puasa','2015-07-19','2015-07-19','Labour Day',0,1,0);
  end if;


  /* No 7*/
  insert into Holidays values(In_State,'National Day','2015-08-31','2015-08-31','National Day',0,1,0);
  
  
  /* No 8 */   
  insert into Holidays values(In_State,'Malaysia Day','2015-09-16','2015-09-16','Malaysia Day',0,1,0);
 
  /* No 9 */
  insert into Holidays values(In_State,'Hari Raya Qurban','2015-09-24','2015-09-24','Hari Raya Qurban',0,1,0);
  if(In_State = 'MY-Trengganu' or In_State = 'MY-Kelantan') then
      insert into Holidays values(In_State,'Hari Raya Qurban','2015-09-25','2015-09-25','Hari Raya Qurban',0,1,0);
      insert into Holidays values(In_State,'Hari Raya Qurban','2015-09-27','2015-09-27','Hari Raya Qurban',0,1,0);
  end if;
 
  /* No 10 */

  insert into Holidays values(In_State,'Awal Muharam','2015-10-14','2015-10-14','Awal Muharam',0,1,0);

  /* No 11 */

  if(In_State <> 'MY-Sarawak') then
    insert into Holidays values(In_State,'Deepavali','2015-11-10','2015-11-10','Deepavali',0,1,0);
  end if;
  
  /* No 12 */
  insert into Holidays values(In_State,'Hari Keputeraan','2015-12-24','2015-12-24','Hari Keputeraan',0,1,0);
  
  /* No 13*/
  insert into Holidays values(In_State,'Christmas Day','2015-12-25','2015-12-25','Christmas Day',0,1,0);

 if(In_State = 'MY-Kedah' or In_State = 'MY-Kelantan' or In_State = 'MY-Trengganu' or In_State = 'MY-Johor') then
     insert into Holidays values(In_State,'Christmas Day','2015-12-27','2015-12-27','Christmas Day',0,1,0);
  end if;

end;

Delete From Holidays where Year(HolidayStartDate) = 2015;

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
  insert into Holidays values('MY','New Year','2015-01-01','2015-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Labuan','New Year','2015-01-01','2015-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Melaka','New Year','2015-01-01','2015-01-01','New Year',0,1,0);
  insert into Holidays values('MY-N.Sembilan','New Year','2015-01-01','2015-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Pahang','New Year','2015-01-01','2015-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Perak','New Year','2015-01-01','2015-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Penang','New Year','2015-01-01','2015-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Sabah','New Year','2015-01-01','2015-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Sarawak','New Year','2015-01-01','2015-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Selangor','New Year','2015-01-01','2015-01-01','New Year',0,1,0);

  /* No 2 Yang di-Pertuan  */
  insert into Holidays values('MY-N.Sembilan','Yang di-Pertuan','2015-01-14','2015-01-14','Birthday of Yang di-Pertuan Besar of Negri Sembilan',0,1,0);

  /* No 3 Sultan Birthday */
  insert into Holidays values('MY-Kedah','Sultan Birthday','2015-01-18','2015-01-18','Birthday of Sultan of Kedah',0,1,0);

  /* No 4 Federal Territory Day */
  insert into Holidays values('MY','Federal Territory','2015-02-01','2015-02-01','Federal Territory Day',0,1,0);
  insert into Holidays values('MY-Labuan','Federal Territory','2015-02-01','2015-02-01','Federal Territory Day',0,1,0);
  insert into Holidays values('MY','Federal Territory','2015-02-02','2015-02-02','Federal Territory Day',0,1,0);
  insert into Holidays values('MY-Labuan','Federal Territory','2015-02-02','2015-02-02','Federal Territory Day',0,1,0);


  /* No 5 Thaipusam */
  insert into Holidays values('MY','Thaipusam','2015-02-03','2015-02-03','Thaipusam',0,1,0);
  insert into Holidays values('MY-Johor','Thaipusam','2015-02-03','2015-02-03','Thaipusam',0,1,0);
  insert into Holidays values('MY-N.Sembilan','Thaipusam','2015-02-03','2015-02-03','Thaipusam',0,1,0);
  insert into Holidays values('MY-Perak','Thaipusam','2015-02-03','2015-02-03','Thaipusam',0,1,0);
  insert into Holidays values('MY-Penang','Thaipusam','2015-02-03','2015-02-03','Thaipusam',0,1,0);
  insert into Holidays values('MY-Selangor','Thaipusam','2015-02-03','2015-02-03','Thaipusam',0,1,0);

  /* No 6 Lunar new Year */
  insert into Holidays values('MY-Kelantan','Lunar New Year','2015-02-20','2015-02-20','Chinese New Year',0,1,0);
  insert into Holidays values('MY-Trengganu','Lunar New Year','2015-02-20','2015-02-20','Chinese New Year',0,1,0);
  insert into Holidays values('MY-Kelantan','Lunar New Year','2015-02-22','2015-02-22','Chinese New Year',0,1,0);
  insert into Holidays values('MY-Trengganu','Lunar New Year','2015-02-22','2015-02-22','Chinese New Year',0,1,0);

  /* No 7 Sultan Birthday */
  insert into Holidays values('MY-Trengganu','Sultan Birthday','2015-03-04','2015-03-04','Birthday of Sultan of Trengganu',0,1,0);

  /* No 8 Good Friday */
  insert into Holidays values('MY-Sabah','Good Friday','2015-04-03','2015-04-03','Good Friday',0,1,0);
  insert into Holidays values('MY-Sarawak','Good Friday','2015-04-03','2015-04-03','Good Friday',0,1,0);
  
  /* No 9 HistoricalCity */
  insert into Holidays values('MY-Melaka','HistoricalCity','2015-04-15','2015-04-15','Declaration of Melaka as Historical City',0,1,0);

  /* No 10 Sultan Birthday */
  insert into Holidays values('MY-Trengganu','Sultan Birthday','2015-04-26','2015-04-26','Birthday of Sultan of Trengganu',0,1,0);

  /* No 11 Hol Day Pahang */
  insert into Holidays values('MY-Pahang','Hol Day Pahang','2015-05-07','2015-05-07','Hol Day Pahang',0,1,0);

  /* No 12 Israk & Mikraj */
  insert into Holidays values('MY-Kedah','Israk & Mikraj','2015-05-16','2015-05-16','Israk & Mikraj',0,1,0);
  insert into Holidays values('MY-N.Sembilan','Israk & Mikraj','2015-05-16','2015-05-16','Israk & Mikraj',0,1,0);
  insert into Holidays values('MY-Perlis','Israk & Mikraj','2015-05-16','2015-05-16','Israk & Mikraj',0,1,0);

  /* No 13 Sultan Birthday */
  insert into Holidays values('MY-Perlis','Sultan Birthday','2015-05-17','2015-05-17','Birthday of Sultan of Perlis',0,1,0);
  insert into Holidays values('MY-Perlis','Sultan Birthday','2015-05-18','2015-05-18','Birthday of Sultan of Perlis',0,1,0);

  /* No 14 Harvest Festival */
  insert into Holidays values('MY-Labuan','Harvest Festival','2015-05-30','2015-05-30','Harvest Festival',0,1,0);
  insert into Holidays values('MY-Labuan','Harvest Festival','2015-05-31','2015-05-31','Harvest Festival',0,1,0);
  insert into Holidays values('MY-Sabah','Harvest Festival','2015-05-30','2015-05-30','Harvest Festival',0,1,0);
  insert into Holidays values('MY-Sabah','Harvest Festival','2015-05-31','2015-05-31','Harvest Festival',0,1,0);
  insert into Holidays values('MY-Labuan','Harvest Festival','2015-06-01','2015-06-01','Harvest Festival',0,1,0);
  insert into Holidays values('MY-Sabah','Harvest Festival','2015-06-01','2015-06-01','Harvest Festival',0,1,0);

  /* No 15 Gawai Festival */
  insert into Holidays values('MY-Sarawak','Gawai Festival','2015-06-01','2015-06-01','Gawai Festival',0,1,0);
  insert into Holidays values('MY-Sarawak','Gawai Festival','2015-06-02','2015-06-02','Gawai Festival',0,1,0);

  /* No 16 Awal Ramadan */
  insert into Holidays values('MY-Johor','Awal Ramadan','2015-06-18','2015-06-18','Awal Ramadan',0,1,0);
  insert into Holidays values('MY-Kedah','Awal Ramadan','2015-06-18','2015-06-18','Awal Ramadan',0,1,0);
  insert into Holidays values('MY-Melaka','Awal Ramadan','2015-06-18','2015-06-18','Awal Ramadan',0,1,0);

  /* No 17 Hari Nuzul Al-Quran */
  insert into Holidays values('MY','Hari Nuzul Al-Quran','2015-07-04','2015-07-04','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Labuan','Hari Nuzul Al-Quran','2015-07-04','2015-07-04','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Kelantan','Hari Nuzul Al-Quran','2015-07-04','2015-07-04','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Pahang','Hari Nuzul Al-Quran','2015-07-04','2015-07-04','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Perak','Hari Nuzul Al-Quran','2015-07-04','2015-07-04','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Perlis','Hari Nuzul Al-Quran','2015-07-04','2015-07-04','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Penang','Hari Nuzul Al-Quran','2015-07-04','2015-07-04','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Selangor','Hari Nuzul Al-Quran','2015-07-04','2015-07-04','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Trengganu','Hari Nuzul Al-Quran','2015-07-04','2015-07-04','Hari Nuzul Al-Quran',0,1,0);

  /* No 18 GeorgeTown Day*/
  insert into Holidays values('MY-Penang','GeorgeTown Day','2015-07-07','2015-07-07','GeorgeTown Heritage Day',0,1,0);

  /* No 19 */
  insert into Holidays values('MY-Penang','Yang di-Pertuan','2015-07-11','2015-07-11','Birthday Yang di-Pertuan Penang',0,1,0);

  /* No 20 */
  insert into Holidays values('MY-Sarawak','Yang di-Pertuan','2015-09-12','2015-09-12','Birthday Yang di-Pertuan Sarawak',0,1,0);

  /* No 21 Hari Raya Qurban */
  insert into Holidays values('MY-Kedah','Hari Raya Qurban','2015-09-25','2015-09-25','Hari Raya Qurban',0,1,0);
  insert into Holidays values('MY-Perlis','Hari Raya Qurban','2015-09-25','2015-09-25','Hari Raya Qurban',0,1,0);
  insert into Holidays values('MY-Kedah','Hari Raya Qurban','2015-09-27','2015-09-27','Hari Raya Qurban',0,1,0);

  /* No 22 */
  insert into Holidays values('MY-Sabah','Yang di-Pertuan','2015-10-03','2015-10-03','Birthday Yang di-Pertuan Sabah',0,1,0);

  /* No 23 Birthday of TYT Yang di-Pertuan of Melaka */
  insert into Holidays values('MY-Melaka','Yang di-Pertuan','2015-10-09','2015-10-09','Birthday of TYT Yang di-Pertuan of Melaka',0,1,0);

  /* No 24 */
  insert into Holidays values('MY-Pahang','Sultan Birthday','2015-10-24','2015-10-24','Birthday of Sultan of Pahang',0,1,0);

  /* No 25 */
  insert into Holidays values('MY-Kelantan','Sultan Birthday','2015-11-11','2015-11-11','Birthday of Sultan of Kelantan',0,1,0);
  insert into Holidays values('MY-Kelantan','Sultan Birthday','2015-11-12','2015-11-12','Birthday of Sultan of Kelantan',0,1,0);

  /* No 26,27 */
  insert into Holidays values('MY-Johor','Almarhum Sultan','2015-11-18','2015-11-18','Hol Day Almarhum Sultan Johor',0,1,0);
  insert into Holidays values('MY-Johor','Sultan Birthday','2015-11-22','2015-11-22','Birthday of Sultan of Johor',0,1,0);


  /* No 28 */
  insert into Holidays values('MY-Perak','Sultan Birthday','2015-11-27','2015-11-27','Birthday of Sultan of Perak',0,1,0);

  /* No 29 */
  insert into Holidays values('MY-Selangor','Sultan Birthday','2015-12-11','2015-12-11','Birthday of Sultan of Selangor',0,1,0);

  

  commit work;
  
  
  
  
