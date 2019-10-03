if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalAddCity') then
   drop procedure FGetPersonalAddCity
end if
;

create function
DBA.FGetPersonalAddCity(
in In_PersonalSysId integer,
in In_ContactLocId char(20),
in In_MailingAdd integer)
returns char(150)
begin
  declare Out_AddCity char(20);
  if(In_MailingAdd = 0) then
    select first PersonalAddress.PersonalAddCity into Out_AddCity
      from PersonalAddress where ContactLocationId = In_ContactLocId and
      PersonalAddress.PersonalSysId = In_PersonalSysId
  else
    select first PersonalAddress.PersonalAddCity into Out_AddCity
      from PersonalAddress where PersonalAddMailing = 1 and
      PersonalAddress.PersonalSysId = In_PersonalSysId
  end if;
  return(Out_AddCity)
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalAddCountry') then
   drop procedure FGetPersonalAddCountry
end if
;


create function
DBA.FGetPersonalAddCountry(
in In_PersonalSysId integer,
in In_ContactLocId char(20),
in In_MailingAdd integer)
returns char(150)
begin
  declare Out_AddCountry char(20);
  if(In_MailingAdd = 0) then
    select first PersonalAddress.PersonalAddCountry into Out_AddCountry
      from PersonalAddress where ContactLocationId = In_ContactLocId and
      PersonalAddress.PersonalSysId = In_PersonalSysId
  else
    select first PersonalAddress.PersonalAddCountry into Out_AddCountry
      from PersonalAddress where PersonalAddMailing = 1 and
      PersonalAddress.PersonalSysId = In_PersonalSysId
  end if;
  return(Out_AddCountry)
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalAddState') then
   drop procedure FGetPersonalAddState
end if
;

create function
DBA.FGetPersonalAddState(
in In_PersonalSysId integer,
in In_ContactLocId char(20),
in In_MailingAdd integer)
returns char(150)
begin
  declare Out_AddState char(20);
  if(In_MailingAdd = 0) then
    select first PersonalAddress.PersonalAddState into Out_AddState
      from PersonalAddress where ContactLocationId = In_ContactLocId and
      PersonalAddress.PersonalSysId = In_PersonalSysId
  else
    select first PersonalAddress.PersonalAddState into Out_AddState
      from PersonalAddress where PersonalAddMailing = 1 and
      PersonalAddress.PersonalSysId = In_PersonalSysId
  end if;
  return(Out_AddState)
end
;

