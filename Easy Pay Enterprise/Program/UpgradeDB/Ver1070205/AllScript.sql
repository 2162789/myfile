if not exists (select 1 from sys.syscolumns where cname = 'CountryString1' and tname = 'Country') then
  alter table Country add CountryString1 char(20);
end if;

if exists (select 1 from sys.sysprocedure where proc_name = 'InsertNewCountry') then
  drop Procedure InsertNewCountry;
end if;

CREATE PROCEDURE "DBA"."InsertNewCountry"(
in In_CountryId char(20),
in In_CountryName char(60),
in In_CountryTelCode char(20),
in In_CountryNationality char(100),
in In_CountryCurrency char(20),
in In_CountryString1 char(20))
begin
  if not exists(select* from Country where
      Country.CountryId = In_CountryId) then
    insert into Country(CountryId,CountryName,
      CountryTelCode,CountryNationality,CountryCurrency,CountryString1) values(
      In_CountryId,In_CountryName,In_CountryTelCode,
      In_CountryNationality,In_CountryCurrency,In_CountryString1 );
    commit work
  end if;
end;

if exists (select 1 from sys.sysprocedure where proc_name = 'UpdateCountry') then
  drop Procedure UpdateCountry;
end if;

CREATE PROCEDURE "DBA"."UpdateCountry"(
in In_CountryId char(20),
in In_CountryName char(60),
in In_CountryTelCode char(20),
in In_CountryNationality char(100),
in In_CountryCurrency char(20),
in In_CountryString1 char(20))
begin
  if exists(select* from Country where
      Country.CountryId = In_CountryId) then
    update Country set
      Country.CountryName = In_CountryName,
      Country.CountryTelCode = In_CountryTelCode,
      Country.CountryNationality = In_CountryNationality,
      Country.CountryCurrency = In_CountryCurrency,
      Country.CountryString1 = In_CountryString1 where
      Country.CountryId = In_CountryId;
    commit work;
  end if;
end;

commit work;
