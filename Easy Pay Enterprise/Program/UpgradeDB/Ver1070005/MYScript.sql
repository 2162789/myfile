if exists(select * from Holidays where CountryId='MY-Sabah'  and HolidayStartDate = '2017-09-09') then
   Delete From Holidays where CountryId='MY-Sabah'  and HolidayStartDate = '2017-09-09';
end if;

if not exists(select * from Holidays where CountryId='MY-Sabah'  and HolidayStartDate = '2017-10-07') then
   insert into Holidays values('MY-Sabah','Yang di-Pertuan','2017-10-07','2017-10-07','Birthday Yang di-Pertuan Sabah','0',1,0);
end if;

commit work;