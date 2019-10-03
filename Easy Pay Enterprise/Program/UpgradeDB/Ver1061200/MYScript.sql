if exists(select * from Holidays where CountryId='MY-Penang'  and HolidayStartDate = '2016-07-07') then
   delete from Holidays where CountryId='MY-Penang' and HolidayStartDate = '2016-07-07';
   insert into Holidays values('MY-Penang','Hari Raya Puasa','2016-07-07','2016-07-07','Hari Raya Puasa/GeorgeTown Heritage Day','0',1,0);
end if;


if exists(select * from Holidays where CountryId='MY-Selangor'  and HolidayStartDate = '2016-12-12') then
   Delete From Holidays where CountryId='MY-Selangor'  and HolidayStartDate = '2016-12-12' ;
   insert into Holidays values('MY-Selangor','Hari Keputeraan','2016-12-12','2016-12-12','Hari Keputeraan/Birthday of Sultan of Selangor','0',1,0);
end if;

commit work;