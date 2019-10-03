begin

declare In_Country char(20);
  select FGetDBCountry(*) into In_Country;

if(In_Country = 'Thailand') then

if (not exists(select * from Holidays Where CountryId='Thailand' and Year(HolidayStartDate) = 2012)) then
    insert into Holidays values('Thailand','New Year','2012-01-01','2012-01-01','New Year',0,1,0);
    insert into Holidays values('Thailand','New Year','2012-01-02','2012-01-02','New Year',0,1,0);
    insert into Holidays values('Thailand','Chinese New Year','2012-01-23','2012-01-23','Chinese New Year',0,1,0);
    insert into Holidays values('Thailand','Magha Bucha','2012-03-07','2012-03-07','Magha Bucha Day',0,1,0);
    insert into Holidays values('Thailand','Chakri Day','2012-04-06','2012-04-06','Chakri Day',0,1,0);
    insert into Holidays values('Thailand','Songkran','2012-04-13','2012-04-13','Songkran - Thai New Year',0,1,0);
    insert into Holidays values('Thailand','Songkran','2012-04-14','2012-04-14','Songkran - Thai New Year',0,1,0);
    insert into Holidays values('Thailand','Songkran','2012-04-15','2012-04-15','Songkran - Thai New Year',0,1,0);
    insert into Holidays values('Thailand','Songkran','2012-04-16','2012-04-16','Songkran - Thai New Year',0,1,0);
    insert into Holidays values('Thailand','Songkran','2012-04-17','2012-04-17','Songkran - Thai New Year',0,1,0);
    insert into Holidays values('Thailand','Labour Day','2012-05-01','2012-05-01','Labour Day',0,1,0);
    insert into Holidays values('Thailand','Coronation Day','2012-05-05','2012-05-05','Coronation Day',0,1,0);
    insert into Holidays values('Thailand','Royal Ploughing','2012-05-10','2012-05-10','Royal Ploughing Ceremony',0,1,0);
    insert into Holidays values('Thailand','Visakha Bucha Day','2012-06-04','2012-06-04','Visakha Bucha Day',0,1,0);
    insert into Holidays values('Thailand','Asahna Bucha Day','2012-08-02','2012-08-02','Asahna Bucha Day',0,1,0);
    insert into Holidays values('Thailand','Buddhist Lent Day','2012-08-03','2012-08-03','Buddhist Lent Day',0,1,0);
    insert into Holidays values('Thailand','Queen Birthday','2012-08-12','2012-08-12','Queen Birthday',0,1,0);
    insert into Holidays values('Thailand','Queen Birthday','2012-08-13','2012-08-13','Queen Birthday',0,1,0);
    insert into Holidays values('Thailand','Chulalongkorn Day','2012-10-23','2012-10-23','King Chulalongkorn Day',0,1,0);
    insert into Holidays values('Thailand','End Buddhist Lent','2012-10-30','2012-10-30','End of Buddhist Lent Day',0,1,0);
    insert into Holidays values('Thailand','Thod Kathin','2012-10-31','2012-10-31','Thod Kathin',0,1,0);
    insert into Holidays values('Thailand','Loy Kratong','2012-11-28','2012-11-28','Loy Kratong',0,1,0);
    insert into Holidays values('Thailand','King Birthday','2012-12-05','2012-12-05','King Birthday',0,1,0);
    insert into Holidays values('Thailand','Constitution Day','2012-12-10','2012-12-10','Constitution Day',0,1,0);
    insert into Holidays values('Thailand','New Year Eve','2012-12-31','2012-12-31','New Year Eve',0,1,0);
end if;

end if;

commit work;

end