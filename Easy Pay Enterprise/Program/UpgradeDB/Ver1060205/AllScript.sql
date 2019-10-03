READ UpgradeDB\Ver1060205\AnalysisSystemAttribute.sql;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFamilyName') then
   drop FUNCTION FGetFamilyName
end if;

CREATE FUNCTION DBA.FGetFamilyName(
in In_PersonalSysId integer,
in In_RelationShipId char(20))
returns char(150)
begin
  declare Out_Name char(150);
  select First Family.PersonName into Out_Name
    from Family where RelationShipId = In_RelationShipId and
    Family.PersonalSysId = In_PersonalSysId
  order by EmergencyContactOrder;
  return(Out_Name)
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFamilyAddress') then
   drop FUNCTION FGetFamilyAddress
end if;

create function dba.FGetFamilyAddress(
in In_PersonalSysId integer,
in In_RelationshipId char(20))
returns char(140)
begin
  declare Out_ContactAddress char(140);
  declare replacePos integer;
  select first ContactAddress into Out_ContactAddress from Family where
    PersonalSysId = In_PersonalSysId and RelationshipId = In_RelationshipId
  order by EmergencyContactOrder;
  replaceLineBreaks:
  while((charindex("char"(10),Out_ContactAddress)) > 0) or(charindex("char"(13),Out_ContactAddress) > 0) loop
    set replacePos=charindex("char"(10),Out_ContactAddress);
    set Out_ContactAddress=stuff(Out_ContactAddress,replacePos,1,' ');
    set replacePos=charindex("char"(13),Out_ContactAddress);
    set Out_ContactAddress=stuff(Out_ContactAddress,replacePos,1,' ')
  end loop replaceLineBreaks;
  return(Out_ContactAddress)
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetFamilyIdentityNo') then
   drop FUNCTION FGetFamilyIdentityNo
end if;

create function DBA.FGetFamilyIdentityNo(
in In_PersonalSysId integer,
in In_RelationShipId char(20))
returns char(30)
begin
  declare Out_IdentityNo char(30);
  select first Family.IdentityNo into Out_IdentityNo
    from Family where RelationShipId = In_RelationShipId and
    Family.PersonalSysId = In_PersonalSysId
  order by EmergencyContactOrder;
  return(Out_IdentityNo)
end
;

COMMIT WORK;