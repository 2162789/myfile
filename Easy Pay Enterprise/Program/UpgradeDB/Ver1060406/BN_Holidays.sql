begin

declare In_Country char(20);
  select FGetDBCountry(*) into In_Country;

if(In_Country = 'Brunei') then

if (not exists(select * from Holidays Where CountryId='Brunei' and Year(HolidayStartDate) = 2013)) then
    insert into Holidays values('Brunei','New Year','2013-01-01','2013-01-01','New Year Day',0,1,0);
    insert into Holidays values('Brunei','Prophet Birthday','2013-01-24','2013-01-24','Birthday of the Prophet Mohammed S.A.W.',0,1,0);  
    insert into Holidays values('Brunei','Chinese NY','2013-02-10','2013-02-10','Chinese New Year',0,1,0);
    insert into Holidays values('Brunei','Chinese NY','2013-02-11','2013-02-11','Chinese New Year',0,1,0);
    insert into Holidays values('Brunei','National Day','2013-02-23','2013-02-23','National Day',0,1,0);
    insert into Holidays values('Brunei','Royal BN Armed Force','2013-05-31','2013-05-31','Royal Brunei Armed Forces Day',0,1,0);
    insert into Holidays values('Brunei','IsrakMijraj','2013-06-05','2013-06-05','Israk Mijraj (Acension of The Prophet Muhammad)',0,1,0);
    insert into Holidays values('Brunei','Ramadan','2013-07-09','2013-07-09','Start of Ramadan',0,1,0);
    insert into Holidays values('Brunei','Sultan Birthday','2013-07-15','2013-07-15','H.M. the Sultan and Yang Di-pertuan Negara Brunei Darussalam Birthday',0,1,0);
    insert into Holidays values('Brunei','Eid Al Fitr','2013-08-08','2013-08-08','Eid Al Fitr',0,1,0);
    insert into Holidays values('Brunei','Eid Al Adha','2013-10-15','2013-10-15','Eid Al Adha',0,1,0);
    insert into Holidays values('Brunei','FirstDayHijrah','2013-11-04','2013-11-04','First Day of Hijrah 1435',0,1,0);
    insert into Holidays values('Brunei','Christmas Day','2013-12-25','2013-12-25','Christmas Day',0,1,0);
end if;

end if;

commit work;

end
