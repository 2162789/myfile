begin

declare In_Country char(20);
  select FGetDBCountry(*) into In_Country;

if(In_Country = 'Thailand') then

if (not exists(select * from Holidays Where CountryId='Thailand' and Year(HolidayStartDate) = 2013)) then
   insert into Holidays values('Thailand','New Year','2013-01-01','2013-01-01','New Year',0,1,0);
   insert into Holidays values('Thailand','Magha Bucha','2013-03-11','2013-03-11','Magha Bucha Day',0,1,0);
   insert into Holidays values('Thailand','Chakri Day','2013-04-06','2013-04-06','Chakri Day',0,1,0);
   insert into Holidays values('Thailand','Chakri Day','2013-04-08','2013-04-08','Chakri Day',0,1,0);
   insert into Holidays values('Thailand','Songkran','2013-04-13','2013-04-13','Songkran - Thai New Year',0,1,0);
   insert into Holidays values('Thailand','Songkran','2013-04-14','2013-04-14','Songkran - Thai New Year',0,1,0);
   insert into Holidays values('Thailand','Songkran','2013-04-15','2013-04-15','Songkran - Thai New Year',0,1,0);
   insert into Holidays values('Thailand','Songkran','2013-04-16','2013-04-16','Songkran - Thai New Year',0,1,0);
   insert into Holidays values('Thailand','Songkran','2013-04-17','2013-04-17','Songkran - Thai New Year',0,1,0);
   insert into Holidays values('Thailand','Labour Day','2013-05-01','2013-05-01','Labour Day',0,1,0);
   insert into Holidays values('Thailand','Coronation Day','2013-05-05','2013-05-05','Coronation Day',0,1,0);
   insert into Holidays values('Thailand','Coronation Day','2013-05-06','2013-05-06','Coronation Day',0,1,0);
   insert into Holidays values('Thailand','Visakha Bucha Day','2013-05-24','2013-05-24','Visakha Bucha Day',0,1,0);
   insert into Holidays values('Thailand','Asahna Bucha Day','2013-07-30','2013-07-30','Asahna Bucha Day',0,1,0);
   insert into Holidays values('Thailand','Queen Birthday','2013-08-12','2013-08-12','Queen Birthday',0,1,0);
   insert into Holidays values('Thailand','Chulalongkorn Day','2013-10-23','2013-10-23','King Chulalongkorn Day',0,1,0);
   insert into Holidays values('Thailand','King Birthday','2013-12-05','2013-12-05','King Birthday',0,1,0);
   insert into Holidays values('Thailand','Constitution Day','2013-12-10','2013-12-10','Constitution Day',0,1,0);
   insert into Holidays values('Thailand','New Year Eve','2013-12-31','2013-12-31','New Year Eve',0,1,0);
end if;

end if;

commit work;

end