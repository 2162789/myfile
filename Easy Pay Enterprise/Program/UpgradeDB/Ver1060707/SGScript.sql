if exists(select * from sys.sysprocedure where proc_name = 'ASQLUpdateIRASNationality') then
   drop procedure ASQLUpdateIRASNationality;
end if;

create procedure DBA.ASQLUpdateIRASNationality()
begin
  declare Ins_IRASNationalityCode char(20);
  CountryLoop: for CountryFor as curs dynamic scroll cursor for
    select CountryID as CountryFor from Country do
    if not exists(select EPECountryID from IRASNAtionality where EPECountryID = CountryFor) then
      if not exists(select YEProperty3 from YEKeyword where YEKeywordId = CountryFor and YEKeywordCategory = 'IRASNationality') then
        set Ins_IRASNationalityCode=999
      else select YEProperty3 into Ins_IRASNationalityCode from YEKeyword where YEKeywordId = CountryFor and YEKeywordCategory = 'IRASNationality'
      end if;
      insert into IRASNationality(EPECountryID,IRASNationalityCode) values(CountryFor,Ins_IRASNationalityCode);
      commit work;
   else
      if exists(select YEProperty3 from YEKeyword where YEKeywordId = CountryFor and YEKeywordCategory = 'IRASNationality') then 
          select YEProperty3 into Ins_IRASNationalityCode from YEKeyword where YEKeywordId = CountryFor and YEKeywordCategory = 'IRASNationality';
          update IRASNationality set IRASNationalityCode = Ins_IRASNationalityCode where EPECountryID = CountryFor;
      end if;
    end if;
 end for;
 
  IRASNationalityLoop: for IRASNationalityFor as IRASNationalitycurs dynamic scroll cursor for
  select EPECountryID as EPECountryFor from IRASNationality do
    if not exists(select * from Country where CountryID = EPECountryFor) then
	   delete from IRASNationality where EPECountryID = EPECountryFor;
	end if;
  end for;
end
;

if exists(select * from YEKeyword where YEKeyWordId = ' China') then 
   delete from YEKeyword where YEKeyWordId = ' China';
end if;

if not exists(select * from YEKeyword where YEKeyWordId = 'China') then 
  insert into YEKeyWord(YEKeyWordId,YEKeyWordDefaultName,YEKeyWordUserDefinedName,YEKeyWordCategory,YEKeyWordDesc,YEProperty1,YEProperty2,YEProperty3,YEProperty4,YEProperty5,YEProperty6,YEProperty7,YEProperty8,YEProperty9) 
  Values('China','','Chinese(China) ','IRASNationality','','','','336','','','','','','1899-12-30 00:00:00'); 
End if;

if exists(select * from YEKeyword where YEKeyWordId = 'PR') then 
   delete from YEKeyword where YEKeyWordId = 'PR';
end if;

commit work;