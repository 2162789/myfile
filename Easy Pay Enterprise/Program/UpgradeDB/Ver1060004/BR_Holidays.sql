begin

declare In_Country char(20);
  select FGetDBCountry(*) into In_Country;

if(In_Country = 'Brunei') then

if (not exists(select * from Holidays Where CountryId='Brunei' and Year(HolidayStartDate) = 2012)) then
    insert into Holidays values('Brunei','New Year','2012-01-01','2012-01-01','New Year Day',0,1,0);
    insert into Holidays values('Brunei','New Year','2012-01-02','2012-01-02','New Year Day',0,1,0);
    insert into Holidays values('Brunei','Chinese NY','2012-01-23','2012-01-23','Chinese New Year',0,1,0);
    insert into Holidays values('Brunei','Prophet Birthday','2012-02-05','2012-02-05','Birthday of the Prophet Mohammed S.A.W.',0,1,0);
    insert into Holidays values('Brunei','Prophet Birthday','2012-02-06','2012-02-06','Birthday of the Prophet Mohammed S.A.W.',0,1,0);
    insert into Holidays values('Brunei','National Day','2012-02-23','2012-02-23','National Day',0,1,0);
    insert into Holidays values('Brunei','Anniversary RBReg','2012-05-31','2012-05-31','Anniversary of Royal Brunei Regiment',0,1,0);
    insert into Holidays values('Brunei','IsrakMijraj','2012-06-17','2012-06-17','Israk Mijraj (Acension of The Prophet Muhammad)',0,1,0);
    insert into Holidays values('Brunei','IsrakMijraj','2012-06-18','2012-06-18','Israk Mijraj (Acension of The Prophet Muhammad)',0,1,0);
    insert into Holidays values('Brunei','Sultan Birthday','2012-07-15','2012-07-15','H.M. the Sultan and Yang Di-pertuan Negara Brunei Darussalam Birthday',0,1,0);
    insert into Holidays values('Brunei','Sultan Birthday','2012-07-16','2012-07-16','H.M. the Sultan and Yang Di-pertuan Negara Brunei Darussalam Birthday',0,1,0);
    insert into Holidays values('Brunei','Ramadan','2012-07-21','2012-07-21','Start of Ramadan',0,1,0);
    insert into Holidays values('Brunei','Revelation of Quran','2012-08-06','2012-08-06','Anniversary Of Revelation of Quran',0,1,0);
    insert into Holidays values('Brunei','Eid Al Fitr','2012-08-19','2012-08-19','Eid Al Fitr',0,1,0);
    insert into Holidays values('Brunei','Eid Al Fitr','2012-08-20','2012-08-20','Eid Al Fitr',0,1,0);
    insert into Holidays values('Brunei','Eid Al Fitr','2012-08-21','2012-08-21','Eid Al Fitr',0,1,0);
    insert into Holidays values('Brunei','Eid Al Adha','2012-10-26','2012-10-26','Eid Al Adha',0,1,0);
    insert into Holidays values('Brunei','Eid Al Adha','2012-10-27','2012-10-27','Eid Al Adha',0,1,0);
    insert into Holidays values('Brunei','FirstDayHijrah','2012-11-15','2012-11-15','First Day of Hijrah 1434',0,1,0);
    insert into Holidays values('Brunei','Christmas Day','2012-12-25','2012-12-25','Christmas Day',0,1,0);
end if;

end if;

commit work;

end