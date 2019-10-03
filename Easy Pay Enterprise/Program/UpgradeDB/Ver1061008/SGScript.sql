if not exists(select * from Holidays where CountryId='Singapore' and HolidayId = 'SG50 Public Holiday' and HolidayStartDate = '2015-08-07') then
   insert into Holidays values('Singapore','SG50 Public Holiday','2015-08-07','2015-08-07','SG50 Public Holiday',0,1,0);
end if;
commit work;