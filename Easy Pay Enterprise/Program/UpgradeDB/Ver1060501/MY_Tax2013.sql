if exists(select 1 from sys.sysprocedure where proc_name = 'PatchMalaysiaTaxPolicy') then
   drop PROCEDURE PatchMalaysiaTaxPolicy
end if
;

CREATE PROCEDURE "DBA"."PatchMalaysiaTaxPolicy"()
begin
  declare MaxID integer;
  declare In_MalTaxPolicyProgSysId integer;
  declare Out_ErrorCode integer;
 
 /* Check for Malaysia DB */
  if FGetDBCountry(*) <> 'Malaysia' then return
  end if;

 /* Check for Tax Policy Progression*/
  if exists(select * from MalTaxPolicyProg where MalTaxPolicyEffDate = '2013-01-01' and MalTaxPolicyId = 'DefaultPolicy') then return;
  end if;
 
  /* Check for STD Policy */
  if not exists(select* from MalSTDPolicy where MalSTDPolicyId = 'ResYear2013') then
    insert into MalSTDPolicy values('ResYear2013','Year 2013 MTD Formula for Resident',0,'Resident');
    select Max(MalSTDPolicySysId) into MaxID  from MalSTDPolicyTable;
    insert into MalSTDPolicyTable values(MaxID+1,'ResYear2013',2500,5000,2500,0,-400,-800);
    insert into MalSTDPolicyTable values(MaxID+2,'ResYear2013',5001,20000,5000,2,-400,-800);
    insert into MalSTDPolicyTable values(MaxID+3,'ResYear2013',20001,35000,20000,6,-100,-500);
    insert into MalSTDPolicyTable values(MaxID+4,'ResYear2013',35001,50000,35000,11,1200,1200);
    insert into MalSTDPolicyTable values(MaxID+5,'ResYear2013',50001,70000,50000,19,2850,2850);
    insert into MalSTDPolicyTable values(MaxID+6,'ResYear2013',70001,100000,70000,24,6650,6650);
    insert into MalSTDPolicyTable values(MaxID+7,'ResYear2013',100001,999999999,100000,26,13850,13850);
  end if;

  if not exists(select* from MalSTDPolicy where MalSTDPolicyId = 'REPYear2013') then
    insert into MalSTDPolicy values('REPYear2013','Year 2013 MTD Formula for Returning Expert Program',0,'REP');
    select Max(MalSTDPolicySysId) into MaxID  from MalSTDPolicyTable;
    insert into MalSTDPolicyTable values(MaxID+1,'REPYear2013',0,35000,0,15,400,800);
    insert into MalSTDPolicyTable values(MaxID+2,'REPYear2013',35001,999999999,0,15,0,0);
  end if;

  if not exists(select* from MalSTDPolicy where MalSTDPolicyId = 'ISKANDARYear2013') then
    insert into MalSTDPolicy values('ISKANDARYear2013','Year 2013 MTD Formula for Knowledge Worker in ISKANDAR',0,'ISKANDAR');
    select Max(MalSTDPolicySysId) into MaxID  from MalSTDPolicyTable;
    insert into MalSTDPolicyTable values(MaxID+1,'ISKANDARYear2013',0,999999999,0,15,0,0);
  end if;

  /* Create Tax Policy Progression */
  select Max(MalTaxPolicyProgSysId) into In_MalTaxPolicyProgSysId from MalTaxPolicyProg;

  insert into MalTaxPolicyProg(
	MalTaxPolicyProgSysId, 
	MalTaxPolicyId, 
	MalSTDPolicyId, 
	MalTaxPolicyEffDate, 
	MalChildOutside, 
	MalChildInside,
	MalChildDisabled, 
	MalCat1Relief, 
	MalCat2ChildRelief, 
	MalCat2Relief, 
	MalCat3ChildRelief, 
	MalCat3Relief, 
	EPFCappingOption, 
	EPFCappingYearly, 
	EPFCappingMOnthly, 
	MalTaxCompenPerYr, 
	MalTaxMinTaxAmt)  
    values(In_MalTaxPolicyProgSysId+1,'DefaultPolicy','ResYear2013','2013-01-01',6,6,5,0,0,0,0,0,0,0,0,0,10);

  /* Create Rebate Setup */
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Individual',9000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Child',1000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Life Ins PF',6000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Parent Medical',5000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Supporting Equip',5000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Disabled Person',6000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Self Education',5000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Serious Medical',5000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Books',1000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Computer',3000,3,1);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'SSPN',6000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Spouse',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Educ Med Insurance',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Disabled Spouse',3500,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Sports Equip',300,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Petrol Official',6000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Parking',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Meal',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Childcare',2400,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Communication',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Employer Goods',1000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Employer Service',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Loan Interest',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Other Medical',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Innovation',2000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Compensation',10000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Lve Passage',0,1,2);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Lve Passage Overseas',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Foreign Insurance',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Group Insurance',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'House Loan Interest',10000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Alimony',3000,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Zakat Claim',0,1,0);
  insert into RebateSetup values(In_MalTaxPolicyProgSysId+1,'Annuity',1000,1,0);

  insert into MalTaxFormula values(In_MalTaxPolicyProgSysId+1,'REP','REPYear2013');
  insert into MalTaxFormula values(In_MalTaxPolicyProgSysId+1,'ISKANDAR','ISKANDARYear2013');

  commit work;

end;

call dba.PatchMalaysiaTaxPolicy();

drop procedure dba.PatchMalaysiaTaxPolicy;

Update RebateSetup set RebateCapAmt=6000 WHERE RebateID='SSPN' AND MalTaxPolicyProgSysId IN (select MalTaxPolicyProgSysId from MalTaxPolicyProg where MalTaxPolicyId='DefaultPolicy' AND MalSTDPolicyId = 'ResYear2012');

If exists (select * from sys.sysprocedure where proc_name = 'ASQLGetMalFamilyInfo') then
   drop procedure ASQLGetMalFamilyInfo;
end if;
Create PROCEDURE "DBA"."ASQLGetMalFamilyInfo"(
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
end;

commit work;
