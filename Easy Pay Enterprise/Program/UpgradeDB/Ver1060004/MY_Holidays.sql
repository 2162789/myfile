
If exists (select 1 from sys.sysprocedure where proc_name = 'PatchMalaysiaNationalHoliday') then
   Drop procedure PatchMalaysiaNationalHoliday
end if;

create procedure DBA.PatchMalaysiaNationalHoliday(in In_State char(20))
begin
  insert into Holidays values(In_State,'Lunar New Year','2012-01-23','2012-01-23','Chinese New Year',0,1,0);
  if(In_State <> 'MY-Kelantan' and In_State <> 'MY-Trengganu') then
    insert into Holidays values(In_State,'Lunar New Year','2012-01-24','2012-01-24','Chinese New Year',0,1,0);
  end if;

  insert into Holidays values(In_State,'ProphetMohdBirthday','2012-02-05','2012-02-05','Prophet Muhammad Birthday',0,1,0);
  if (In_State <> 'MY-Kedah' and In_State <> 'MY-Kelantan' and In_State <> 'MY-Trengganu') then
    insert into Holidays values(In_State,'ProphetMohdBirthday','2012-02-06','2012-02-06','Prophet Muhammad Birthday',0,1,0);
  end if;

  insert into Holidays values(In_State,'Labour Day','2012-05-01','2012-05-01','Labour Day',0,1,0);
  insert into Holidays values(In_State,'Vesak Day','2012-05-05','2012-05-05','Vesak',0,1,0);
  if (In_State = 'MY-Kedah' or In_State = 'MY-Kelantan' or In_State = 'MY-Trengganu') then
    insert into Holidays values(In_State,'Vesak Day','2012-05-06','2012-05-06','Vesak',0,1,0);
  end if;

  insert into Holidays values(In_State,'AgongBirthday','2012-06-02','2012-06-02','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
  if (In_State = 'MY-Kedah' or In_State = 'MY-Kelantan' or In_State = 'MY-Trengganu') then
    insert into Holidays values(In_State,'AgongBirthday','2012-06-03','2012-06-03','Birthday of SPB Yang Di-pertuan Agong',0,1,0);
  end if;

  insert into Holidays values(In_State,'Hari Raya Puasa','2012-08-19','2012-08-19','Hari Raya Puasa',0,1,0);
  insert into Holidays values(In_State,'Hari Raya Puasa','2012-08-20','2012-08-20','Hari Raya Puasa',0,1,0);
  insert into Holidays values(In_State,'National Day','2012-08-31','2012-08-31','National Day',0,1,0);

  insert into Holidays values(In_State,'Malaysia Day','2012-09-16','2012-09-16','Malaysia Day',0,1,0);
  if (In_State <> 'MY-Kedah' and In_State <> 'MY-Kelantan' and In_State <> 'MY-Trengganu') then
    insert into Holidays values(In_State,'Malaysia Day','2012-09-17','2012-09-17','Malaysia Day',0,1,0);
  end if;

  insert into Holidays values(In_State,'Hari Raya Qurban','2012-10-26','2012-10-26','Hari Raya Qurban',0,1,0);
  if(In_State = 'MY-Trengganu' or In_State = 'MY-Kelantan') then
    insert into Holidays values(In_State,'Hari Raya Qurban','2012-10-27','2012-10-27','Hari Raya Qurban',0,1,0);
    insert into Holidays values(In_State,'Hari Raya Qurban','2012-10-28','2012-10-28','Hari Raya Qurban',0,1,0);
  end if;

  if(In_State <> 'MY-Labuan' and In_State <> 'MY-Sarawak') then
    insert into Holidays values(In_State,'Deepavali','2012-11-13','2012-11-13','Deepavali',0,1,0);
  end if;

  insert into Holidays values(In_State,'Awal Muharam','2012-11-15','2012-11-15','Awal Muharam',0,1,0);
  insert into Holidays values(In_State,'Christmas Day','2012-12-25','2012-12-25','Christmas Day',0,1,0);

end;

Delete From Holidays where Year(HolidayStartDate) = 2012;

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
  insert into Holidays values('MY','New Year','2012-01-01','2012-01-01','New Year',0,1,0);
  insert into Holidays values('MY','New Year','2012-01-02','2012-01-02','New Year',0,1,0);
  insert into Holidays values('MY-Labuan','New Year','2012-01-01','2012-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Labuan','New Year','2012-01-02','2012-01-02','New Year',0,1,0);
  insert into Holidays values('MY-Melaka','New Year','2012-01-01','2012-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Melaka','New Year','2012-01-02','2012-01-02','New Year',0,1,0);
  insert into Holidays values('MY-N.Sembilan','New Year','2012-01-01','2012-01-01','New Year',0,1,0);
  insert into Holidays values('MY-N.Sembilan','New Year','2012-01-02','2012-01-02','New Year',0,1,0);
  insert into Holidays values('MY-Pahang','New Year','2012-01-01','2012-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Pahang','New Year','2012-01-02','2012-01-02','New Year',0,1,0);
  insert into Holidays values('MY-Perak','New Year','2012-01-01','2012-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Perak','New Year','2012-01-02','2012-01-02','New Year',0,1,0);
  insert into Holidays values('MY-Penang','New Year','2012-01-01','2012-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Penang','New Year','2012-01-02','2012-01-02','New Year',0,1,0);
  insert into Holidays values('MY-Sabah','New Year','2012-01-01','2012-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Sabah','New Year','2012-01-02','2012-01-02','New Year',0,1,0);
  insert into Holidays values('MY-Sarawak','New Year','2012-01-01','2012-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Sarawak','New Year','2012-01-02','2012-01-02','New Year',0,1,0);
  insert into Holidays values('MY-Selangor','New Year','2012-01-01','2012-01-01','New Year',0,1,0);
  insert into Holidays values('MY-Selangor','New Year','2012-01-02','2012-01-02','New Year',0,1,0);
  /* No 2 to 5  */
  insert into Holidays values('MY-N.Sembilan','Yang di-Pertuan','2012-01-14','2012-01-14','Birthday of Yang di-Pertuan Besar of Negri Sembilan',0,1,0);
  insert into Holidays values('MY-Kedah','Sultan Birthday','2012-01-15','2012-01-15','Birthday of Sultan of Kedah',0,1,0);
  insert into Holidays values('MY-Kelantan','Lunar New Year','2012-01-24','2012-01-24','Chinese New Year',0,1,0);
  insert into Holidays values('MY-Trengganu','Lunar New Year','2012-01-24','2012-01-24','Chinese New Year',0,1,0);
  insert into Holidays values('MY','Federal Territory','2012-02-01','2012-02-01','Federal Territory Day',0,1,0);
  insert into Holidays values('MY-Labuan','Federal Territory','2012-02-01','2012-02-01','Federal Territory Day',0,1,0);
  /* No 6 Thaipusam */
  insert into Holidays values('MY','Thaipusam','2012-02-07','2012-02-07','Thaipusam',0,1,0);
  insert into Holidays values('MY-Johor','Thaipusam','2012-02-07','2012-02-07','Thaipusam',0,1,0);
  insert into Holidays values('MY-N.Sembilan','Thaipusam','2012-02-07','2012-02-07','Thaipusam',0,1,0);
  insert into Holidays values('MY-Perak','Thaipusam','2012-02-07','2012-02-07','Thaipusam',0,1,0);
  insert into Holidays values('MY-Penang','Thaipusam','2012-02-07','2012-02-07','Thaipusam',0,1,0);
  insert into Holidays values('MY-Selangor','Thaipusam','2012-02-07','2012-02-07','Thaipusam',0,1,0);
  /* No 7 to 12 */
  insert into Holidays values('MY-Trengganu','Sultan Birthday','2012-03-04','2012-03-04','Birthday of Sultan of Trengganu',0,1,0);
  insert into Holidays values('MY-Sabah','Good Friday','2012-04-06','2012-04-06','Good Friday',0,1,0);
  insert into Holidays values('MY-Sarawak','Good Friday','2012-04-06','2012-04-06','Good Friday',0,1,0);
  insert into Holidays values('MY-Melaka','HistoricalCity','2012-04-15','2012-04-15','Declaration of Melaka as Historical City',0,1,0);
  insert into Holidays values('MY-Melaka','HistoricalCity','2012-04-16','2012-04-16','Declaration of Melaka as Historical City',0,1,0);
  insert into Holidays values('MY-Perak','Sultan Birthday','2012-04-19','2012-04-19','Birthday of Sultan of Perak',0,1,0);
  insert into Holidays values('MY-Pahang','Hol Day Pahang','2012-05-07','2012-05-07','Hol Day Pahang',0,1,0);
  insert into Holidays values('MY-Perlis','Sultan Birthday','2012-05-17','2012-05-17','Birthday of Sultan of Perlis',0,1,0);
  /* No 13 Harvest Festival */
  insert into Holidays values('MY-Labuan','Harvest Festival','2012-05-30','2012-05-30','Harvest Festival',0,1,0);
  insert into Holidays values('MY-Labuan','Harvest Festival','2012-05-31','2012-05-31','Harvest Festival',0,1,0);
  insert into Holidays values('MY-Sabah','Harvest Festival','2012-05-30','2012-05-30','Harvest Festival',0,1,0);
  insert into Holidays values('MY-Sabah','Harvest Festival','2012-05-31','2012-05-31','Harvest Festival',0,1,0);
  /* No 14 Dayak Festival */
  insert into Holidays values('MY-Sarawak','Dayak Festival','2012-06-01','2012-06-01','Dayak Festival',0,1,0);
  insert into Holidays values('MY-Sarawak','Dayak Festival','2012-06-02','2012-06-02','Dayak Festival',0,1,0);
  /* No 15 Israk & Mikraj */
  insert into Holidays values('MY-Kedah','Israk & Mikraj','2012-06-17','2012-06-17','Israk & Mikraj',0,1,0);
  insert into Holidays values('MY-N.Sembilan','Israk & Mikraj','2012-06-17','2012-06-17','Israk & Mikraj',0,1,0);
  insert into Holidays values('MY-N.Sembilan','Israk & Mikraj','2012-06-18','2012-06-18','Israk & Mikraj',0,1,0);
  insert into Holidays values('MY-Perlis','Israk & Mikraj','2012-06-17','2012-06-17','Israk & Mikraj',0,1,0);
  insert into Holidays values('MY-Perlis','Israk & Mikraj','2012-06-18','2012-06-18','Israk & Mikraj',0,1,0);
  /* No 16 */
  insert into Holidays values('MY-Penang','GeorgeTown Day','2012-07-07','2012-07-07','GeorgeTown Heritage Day',0,1,0);
  insert into Holidays values('MY-Penang','Yang di-Pertuan','2012-07-14','2012-07-14','Birthday Yang di-Pertuan Penang',0,1,0);
  insert into Holidays values('MY-Trengganu','Sultan Birthday','2012-07-20','2012-07-20','Birthday of Sultan of Trengganu',0,1,0);
  /* No 19 Awal Ramadan */
  insert into Holidays values('MY-Johor','Awal Ramadan','2012-07-21','2012-07-21','Awal Ramadan',0,1,0);
  insert into Holidays values('MY-Kedah','Awal Ramadan','2012-07-21','2012-07-21','Awal Ramadan',0,1,0);
  insert into Holidays values('MY-Kedah','Awal Ramadan','2012-07-22','2012-07-22','Awal Ramadan',0,1,0);
  insert into Holidays values('MY-Melaka','Awal Ramadan','2012-07-21','2012-07-21','Awal Ramadan',0,1,0);
  /* No 20 Hari Nuzul Al-Quran */
  insert into Holidays values('MY-Kelantan','Hari Nuzul Al-Quran','2012-08-06','2012-08-06','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Pahang','Hari Nuzul Al-Quran','2012-08-06','2012-08-06','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Perak','Hari Nuzul Al-Quran','2012-08-06','2012-08-06','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Perlis','Hari Nuzul Al-Quran','2012-08-06','2012-08-06','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Penang','Hari Nuzul Al-Quran','2012-08-06','2012-08-06','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Selangor','Hari Nuzul Al-Quran','2012-08-06','2012-08-06','Hari Nuzul Al-Quran',0,1,0);
  insert into Holidays values('MY-Trengganu','Hari Nuzul Al-Quran','2012-08-06','2012-08-06','Hari Nuzul Al-Quran',0,1,0);
  /* No 21 to 24 */
  insert into Holidays values('MY-Sarawak','Yang di-Pertuan','2012-09-08','2012-09-08','Birthday Yang di-Pertuan Sarawak',0,1,0);
  insert into Holidays values('MY-Sabah','Yang di-Pertuan','2012-10-06','2012-10-06','Birthday Yang di-Pertuan Sabah',0,1,0);
  insert into Holidays values('MY-Melaka','Yang di-Pertuan','2012-10-13','2012-10-13','Birthday of TYT Yang di-Pertuan of Melaka',0,1,0);
  insert into Holidays values('MY-Pahang','Sultan Birthday','2012-10-24','2012-10-24','Birthday of Sultan of Pahang',0,1,0);
  /* No 25 Hari Raya Qurban */
  insert into Holidays values('MY-Kedah','Hari Raya Qurban','2012-10-27','2012-10-27','Hari Raya Qurban',0,1,0);
  insert into Holidays values('MY-Kedah','Hari Raya Qurban','2012-10-28','2012-10-28','Hari Raya Qurban',0,1,0);
  insert into Holidays values('MY-Perlis','Hari Raya Qurban','2012-10-27','2012-10-27','Hari Raya Qurban',0,1,0);
  /* No 26 to 29 */
  insert into Holidays values('MY-Kelantan','Sultan Birthday','2012-11-11','2012-11-11','Birthday of Sultan of Kelantan',0,1,0);
  insert into Holidays values('MY-Kelantan','Sultan Birthday','2012-11-12','2012-11-12','Birthday of Sultan of Kelantan',0,1,0);
  insert into Holidays values('MY-Johor','Sultan Birthday','2012-11-22','2012-11-22','Birthday of Sultan of Johor',0,1,0);
  insert into Holidays values('MY-Selangor','Sultan Birthday','2012-12-11','2012-12-11','Birthday of Sultan of Selangor',0,1,0);
  insert into Holidays values('MY-Johor','Almarhum Sultan','2012-12-20','2012-12-20','Hol Day Almarhum Sultan Johor',0,1,0);

commit work;
