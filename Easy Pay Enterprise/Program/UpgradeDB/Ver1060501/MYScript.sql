READ UpgradeDB\Ver1060501\MY_Tax2013.sql;
READ UpgradeDB\Ver1060501\MY_SOCSO2013Jan.sql;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLGetMalFamilyInfo') then
  drop procedure ASQLGetMalFamilyInfo
end if;

create procedure DBA.ASQLGetMalFamilyInfo(
in In_PersonalSysId integer,
out Out_ChildReliefPoint double,
out Out_NoOfReliefChild integer,
out Out_NoOfChildBelow18 integer)
begin
  declare InsidePoint integer;
  declare OutsidePoint integer;
  declare DisablePoint integer;
  declare EducationLevel char(20);
  set Out_ChildReliefPoint=0;
  set Out_NoOfReliefChild=0;
  set Out_NoOfChildBelow18=0;
  //
  // Loop Family Member
  //
  FamilyLoop: for FamilyFor as curs dynamic scroll cursor for
    select Family.OccupationId,
      Family.DOB,
      FamilyEduRec.EducationId as F_EducationId,
      Family.RelationshipId,
      Family.IsHandicapped,
      FamilyEduRec.EduLocal,
      Family.FamilyMaritalStatusCode    
        from
      Family left outer join FamilyEduRec on(Family.FamilySysId = FamilyEduRec.FamilySysId) where
      Family.PersonalSysId = In_PersonalSysId do
    //
    // Get Tax Policy Child Relief    
    //
    select first MalChildInside,MalChildOutside,MalChildDisabled into InsidePoint,OutsidePoint,DisablePoint from MalTaxPolicyProg where
      MalTaxPolicyId = (select MalTaxPolicyId from MalTaxDetails where MalTaxDetails.PersonalSysId = In_PersonalSysId) and
      MalTaxPolicyEffDate <= Today(*) order by MalTaxPolicyEffDate desc;
    //    
    // Get Family Education Level    
    //
    select EduLevel.EduLevelId into EducationLevel from EduLevel join Education where Education.EducationId = F_EducationId;

    if RelationshipId in('Son','Step Son','Daughter','Step Daughter') then

      //
      // Handicapped
      //
      if IsHandicapped = 1 then
        set Out_NoOfReliefChild=Out_NoOfReliefChild+1;
        set Out_ChildReliefPoint=Out_ChildReliefPoint+DisablePoint;
        //
        // Handicapped below 18
        //
        if(Years(DOB,Today(*)) <= 18) then
          set Out_NoOfChildBelow18=Out_NoOfChildBelow18+1
        //
        // Handicapped Student
        //
        elseif (OccupationId = 'Full-time Student') then
          if(EduLocal = 1 and(EducationLevel = 'Diploma' or EducationLevel = 'Degree' or EducationLevel = 'Masters' or EducationLevel = 'PhD' or EducationLevel = 'Tertiary')) then
            set Out_ChildReliefPoint=Out_ChildReliefPoint+InsidePoint
          elseif(EduLocal = 0 and(EducationLevel = 'Degree' or EducationLevel = 'Masters' or EducationLevel = 'PhD' or EducationLevel = 'Tertiary')) then
            set Out_ChildReliefPoint=Out_ChildReliefPoint+OutsidePoint
          end if
        end if

      //
      // Non Handicapped Full Time Student above 18
      //
      elseif(Years(DOB,Today(*)) > 18 and OccupationId = 'Full-time Student') then
        //
        // Local Education
        //
        if(EduLocal = 1 and(EducationLevel = 'Degree' or EducationLevel = 'Diploma' or EducationLevel = 'Masters' or EducationLevel = 'PhD' or EducationLevel = 'Tertiary')) then
          set Out_NoOfReliefChild=Out_NoOfReliefChild+1;
          set Out_ChildReliefPoint=Out_ChildReliefPoint+InsidePoint
        //
        // Overseas Education  
        //
        elseif(EduLocal = 0 and(EducationLevel = 'Degree' or EducationLevel = 'Masters' or EducationLevel = 'PhD' or EducationLevel = 'Tertiary')) then
          set Out_NoOfReliefChild=Out_NoOfReliefChild+1;
          set Out_ChildReliefPoint=Out_ChildReliefPoint+OutsidePoint
        // Studying and Single
        elseif (FamilyMaritalStatusCode = 'Single') then
          set Out_NoOfReliefChild=Out_NoOfReliefChild+1;
          set Out_ChildReliefPoint=Out_ChildReliefPoint+1
        end if
      //
      // Non Handicapped Full Time Student or No Occupation under 18
      //        
      elseif(Years(DOB,Today(*)) <= 18) then
        if(OccupationId = 'Full-time Student' or OccupationId = '' or OccupationId is null) then
          set Out_NoOfReliefChild=Out_NoOfReliefChild+1;
          set Out_ChildReliefPoint=Out_ChildReliefPoint+1
        end if;
        set Out_NoOfChildBelow18=Out_NoOfChildBelow18+1
      end if // check Handicapped
    end if end for 
// check Relationship          
end
;

if exists(select * from sys.sysprocedure where proc_name = 'FGetMalTaxRecordYear') then
  drop function FGetMalTaxRecordYear
end if;

create function dba.FGetMalTaxRecordYear(
in In_MalTaxYear integer)
returns integer
begin
  declare Out_MalTaxYear integer;
  set Out_MalTaxYear=cast(right((cast(In_MalTaxYear as char(6))),4) as integer);
  return(Out_MalTaxYear)  
end
;


commit work;

