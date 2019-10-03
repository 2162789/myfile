update ImportFieldName set FieldNameUserDefined = 'No Of Children Not Studying Or Studying Abroad' where TableNamePhysical = 'iThTaxDetails' and FieldNamePhysical = 'ThChildNoStudy';
update ImportFieldName set FieldNameUserDefined = 'No Of Children Studying in Thailand' where TableNamePhysical = 'iThTaxDetails' and FieldNamePhysical = 'ThChildStudy';
update ImportFieldName set FieldNameUserDefined = 'Disabled Person' where TableNamePhysical = 'iThTaxDetails' and FieldNamePhysical = 'ThDisabledPerson';

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLGetThFamilyInfo') then
   drop PROCEDURE ASQLGetThFamilyInfo;
end if;

CREATE PROCEDURE "DBA"."ASQLGetThFamilyInfo"(
in In_PersonalSysId integer,
out Out_ThChildNoStudy double,
out Out_ThChildStudy double)
begin
  declare Out_TotalChildren double;
  declare Out_ChildStudyAgeLimit double;
  declare Out_ChildUnmarriedAgeLimit double;
  set Out_ThChildNoStudy=0;
  set Out_ThChildStudy=0;
  select first ThChildStudyAgeLimit, ThChildUnmarriedAgeLimit into Out_ChildStudyAgeLimit, Out_ChildUnmarriedAgeLimit from ThTaxProgression order by ThTaxProgDate desc;
  select count(distinct Family.FamilySysId) into Out_TotalChildren from Family
    left join FamilyEduRec on Family.FamilySysId = FamilyEduRec.FamilySysId where
    PersonalSysId = In_PersonalSysId and
    RelationshipId in('Son','Step Son','Daughter','Step Daughter') and
    (Year(Now(*)) - Year(Family.DOB) < Out_ChildUnmarriedAgeLimit and Family.FamilyMaritalStatusCode = 'Single'
    or Year(Now(*)) - Year(Family.DOB) < Out_ChildStudyAgeLimit and Year(FamilyEduRec.EduStartDate) <= Year(Now(*)) and
    (FGetInvalidDate(FamilyEduRec.EduEndDate) = '' or FGetInvalidDate(FamilyEduRec.EduEndDate) is null or Year(FamilyEduRec.EduEndDate) >= Year(Now(*))));
  select count(distinct Family.FamilySysId) into Out_ThChildStudy from Family join FamilyEduRec where
    Family.PersonalSysId = In_PersonalSysId and
    RelationshipId in('Son','Step Son','Daughter','Step Daughter') and
    Year(Now(*)) - Year(Family.DOB) < Out_ChildStudyAgeLimit and EduLocal = 1 and Year(FamilyEduRec.EduStartDate) <= Year(Now(*)) and
    (FGetInvalidDate(FamilyEduRec.EduEndDate) = '' or FGetInvalidDate(FamilyEduRec.EduEndDate) is null or Year(FamilyEduRec.EduEndDate) >= Year(Now(*)));
  set Out_ThChildNoStudy = Out_TotalChildren - Out_ThChildStudy
end;

commit work;