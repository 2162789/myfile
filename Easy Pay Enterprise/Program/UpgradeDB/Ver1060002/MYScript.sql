if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLGetMalFamilyInfo' and user_name(creator) = 'DBA') then
   drop function DBA.ASQLGetMalFamilyInfo
end if;

create PROCEDURE DBA.ASQLGetMalFamilyInfo(in In_PersonalSysId integer,out Out_ChildReliefPoint double,out Out_NoOfReliefChild integer,out Out_NoOfChildBelow18 integer)
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
      FamilyEduRec.EduLocal from
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
        end if;
        //
        // Handicapped Student
        //
        if(OccupationId = 'Full-time Student') then
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
      end if
    end if end for // check Handicapped
// check Relationship          
end
;

Update MalTaxPolicyProg set MalChildOutside = 4 where MalTaxPolicyId='DefaultPolicy' and MalTaxPolicyEffDate = '2011-01-01';

Commit work;