create procedure dba.DeleteThTaxDetails(
in In_PersonalSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from ThTaxDetails where PersonalSysId = In_PersonalSysId) then
    if exists(select* from ThTaxRecord where PersonalSysId = In_PersonalSysId) then
      if exists(select* from ThTaxEmployee where PersonalSysId = In_PersonalSysId) then
        delete from ThTaxEmployee where PersonalSysId = In_PersonalSysId;
        commit work
      end if;
      delete from ThTaxRecord where PersonalSysId = In_PersonalSysId;
      commit work
    end if;
    delete from ThTaxDetails where PersonalSysId = In_PersonalSysId;
    commit work;
    if exists(select* from ThTaxDetails where PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteThTaxPolicy(
in In_ThTaxPolicyId char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from ThTaxDetails where ThTaxPolicyId = In_ThTaxPolicyId) then
    if exists(select* from ThTaxPolicy where ThTaxPolicyId = In_ThTaxPolicyId) then
      if exists(select* from ThTaxProgression where ThTaxPolicyId = In_ThTaxPolicyId) then
        DeleteThTaxProgression: for DeleteThTaxProgressionFor as DeleteThTaxProgressionCurs dynamic scroll cursor for
          select ThTaxProgSysId as Out_TaxProgSysId from ThTaxProgression where
            ThTaxPolicyId = In_ThTaxPolicyId do
          call DeleteThTaxProgression(Out_TaxProgSysId,ErrorCode) end for
      end if;
      delete from ThTaxPolicy where ThTaxPolicyId = In_ThTaxPolicyId;
      commit work;
      if exists(select* from ThTaxPolicy where ThTaxPolicyId = In_ThTaxPolicyId) then
        set Out_ErrorCode=0
      else
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=0
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteThTaxProgression(
in In_ThTaxProgSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from ThTaxProgression where ThTaxProgSysId = In_ThTaxProgSysId) then
    if exists(select* from ThTaxRate where ThTaxProgSysId = In_ThTaxProgSysId) then
      delete from ThTaxRate where ThTaxProgSysId = In_ThTaxProgSysId;
      commit work
    end if;
    delete from ThTaxProgression where ThTaxProgSysId = In_ThTaxProgSysId;
    commit work;
    if exists(select* from ThTaxProgression where ThTaxProgSysId = In_ThTaxProgSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewThTaxDetails(
in In_PersonalSysId integer,
in In_ThTaxPolicyId char(20),
in In_ThTaxEmployerId char(20),
in In_ThEETIN char(20),
in In_ThTaxMethod char(20),
in In_ThChildNoStudy double,
in In_ThChildStudy double,
in In_ThIncSpouseRelief smallint,
in In_ThParentFather smallint,
in In_ThParentMother smallint,
in In_ThParentFatherSpouse smallint,
in In_ThParentMotherSpouse smallint,
in In_ThHealthFather smallint,
in In_ThHealthMother smallint,
in In_ThHealthFatherSpouse smallint,
in In_ThHealthMotherSpouse 
smallint,out Out_ErrorCode integer)
begin
  if not exists(select* from ThTaxDetails where PersonalSysId = In_PersonalSysId) then
    insert into ThTaxDetails(PersonalSysId,
      ThTaxPolicyId,
      ThTaxEmployerId,
      ThEETIN,
      ThTaxMethod,
      ThChildNoStudy,
      ThChildStudy,
      ThIncSpouseRelief,
      ThParentFather,
      ThParentMother,
      ThParentFatherSpouse,
      ThParentMotherSpouse,
      ThHealthFather,
      ThHealthMother,
      ThHealthFatherSpouse,
      ThHealthMotherSpouse) values(
      In_PersonalSysId,
      In_ThTaxPolicyId,
      In_ThTaxEmployerId,
      In_ThEETIN,
      In_ThTaxMethod,
      In_ThChildNoStudy,
      In_ThChildStudy,
      In_ThIncSpouseRelief,
      In_ThParentFather,
      In_ThParentMother,
      In_ThParentFatherSpouse,
      In_ThParentMotherSpouse,
      In_ThHealthFather,
      In_ThHealthMother,
      In_ThHealthFatherSpouse,
      In_ThHealthMotherSpouse);
    commit work;
    if not exists(select* from ThTaxDetails where PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewThTaxPolicy(
in In_ThTaxPolicyId char(20),
in In_ThTaxPolicyDesc char(100),
out Out_ErrorCode integer)
begin
  if In_ThTaxPolicyId is not null then
    if not exists(select* from ThTaxPolicy where ThTaxPolicyId = In_ThTaxPolicyId) then
      insert into ThTaxPolicy(ThTaxPolicyId,
        ThTaxPolicyDesc) values(
        In_ThTaxPolicyId,
        In_ThTaxPolicyDesc);
      commit work;
      if not exists(select* from ThTaxPolicy where ThTaxPolicyId = In_ThTaxPolicyId) then
        set Out_ErrorCode=0
      else
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=0
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.InsertNewThTaxProgression(
in In_ThTaxPolicyId char(20),
in In_ThTaxProgDate date,
in In_ThExpensePercent double,
in In_ThExpenseMax double,
in In_ThPFExcess double,
in In_ThPFMax double,
in In_ThPFPercent double,
in In_ThTaxpayerAmt double,
in In_ThSpouseAmt double,
in In_ThMaxNoOfChild double,
in In_ThChildAgeLimit double,
in In_ThChildNoStudyAmt double,
in In_ThChildStudyAmt double,
in In_ThParentAmt double,
in In_ThParentMinAge double,
in In_ThOldAgeAmt double,
in In_ThOldAgeMinAge double,
in In_ThInsuranceMax double,
in In_ThResidenceMax double,
in In_ThCharityMaxPercent double,
out Out_ThTaxProgSysId integer,
out Out_ErrorCode integer)
begin
  declare TaxProgSysId integer;
  select MAX(ThTaxProgSysId) into TaxProgSysId from ThTaxProgression where ThTaxPolicyId = In_ThTaxPolicyId;
  if TaxProgSysId is null then set TaxProgSysId=0
  end if;
  if In_ThTaxPolicyId is not null then
    if In_ThExpensePercent between 0 and 100 then
      if In_ThPFPercent between 0 and 100 then
        if In_ThCharityMaxPercent between 0 and 100 then
          if not exists(select* from ThTaxProgression where ThTaxPolicyId = In_ThTaxPolicyId and ThTaxProgDate = In_ThTaxProgDate) then
            insert into ThTaxProgression(ThTaxPolicyId,
              ThTaxProgDate,
              ThExpensePercent,
              ThExpenseMax,
              ThPFExcess,
              ThPFMax,
              ThPFPercent,
              ThTaxpayerAmt,
              ThSpouseAmt,
              ThMaxNoOfChild,
              ThChildAgeLimit,
              ThChildNoStudyAmt,
              ThChildStudyAmt,
              ThParentAmt,
              ThParentMinAge,
              ThOldAgeAmt,
              ThOldAgeMinAge,
              ThInsuranceMax,
              ThResidenceMax,
              ThCharityMaxPercent) values(
              In_ThTaxPolicyId,
              In_ThTaxProgDate,
              In_ThExpensePercent,
              In_ThExpenseMax,
              In_ThPFExcess,
              In_ThPFMax,
              In_ThPFPercent,
              In_ThTaxpayerAmt,
              In_ThSpouseAmt,
              In_ThMaxNoOfChild,
              In_ThChildAgeLimit,
              In_ThChildNoStudyAmt,
              In_ThChildStudyAmt,
              In_ThParentAmt,
              In_ThParentMinAge,
              In_ThOldAgeAmt,
              In_ThOldAgeMinAge,
              In_ThInsuranceMax,
              In_ThResidenceMax,
              In_ThCharityMaxPercent);
            commit work;
            select MAX(ThTaxProgSysId) into Out_ThTaxProgSysId from ThTaxProgression where ThTaxPolicyId = In_ThTaxPolicyId;
            if Out_ThTaxProgSysId is null then set Out_ThTaxProgSysId=0
            end if;
            if TaxProgSysId = Out_ThTaxProgSysId then
              set Out_ErrorCode=0
            else
              set Out_ErrorCode=1
            end if
          else
            set Out_ErrorCode=-5
          end if
        else
          set Out_ErrorCode=-4
        end if
      else
        set Out_ErrorCode=-3
      end if
    else
      set Out_ErrorCode=-2
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.UpdateThTaxDetails(
in In_PersonalSysId integer,
in In_ThTaxPolicyId char(20),
in In_ThTaxEmployerId char(20),
in In_ThEETIN char(20),
in In_ThTaxMethod char(20),
in In_ThChildNoStudy double,
in In_ThChildStudy double,
in In_ThIncSpouseRelief smallint,
in In_ThParentFather smallint,
in In_ThParentMother smallint,
in In_ThParentFatherSpouse smallint,
in In_ThParentMotherSpouse smallint,
in In_ThHealthFather smallint,
in In_ThHealthMother smallint,
in In_ThHealthFatherSpouse smallint,
in In_ThHealthMotherSpouse 
smallint,out Out_ErrorCode integer)
begin
  if exists(select* from ThTaxDetails where PersonalSysId = In_PersonalSysId) then
    update ThTaxDetails set
      ThTaxPolicyId = In_ThTaxPolicyId,
      ThTaxEmployerId = In_ThTaxEmployerId,
      ThEETIN = In_ThEETIN,
      ThTaxMethod = In_ThTaxMethod,
      ThChildNoStudy = In_ThChildNoStudy,
      ThChildStudy = In_ThChildStudy,
      ThIncSpouseRelief = In_ThIncSpouseRelief,
      ThParentFather = In_ThParentFather,
      ThParentMother = In_ThParentMother,
      ThParentFatherSpouse = In_ThParentFatherSpouse,
      ThParentMotherSpouse = In_ThParentMotherSpouse,
      ThHealthFather = In_ThHealthFather,
      ThHealthMother = In_ThHealthMother,
      ThHealthFatherSpouse = In_ThHealthFatherSpouse,
      ThHealthMotherSpouse = In_ThHealthMotherSpouse where
      PersonalSysId = In_PersonalSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateThTaxPolicy(
in In_ThTaxPolicyId char(20),
in In_ThTaxPolicyDesc char(100),
out Out_ErrorCode integer)
begin
  if In_ThTaxPolicyId is not null then
    if exists(select* from ThTaxPolicy where ThTaxPolicyId = In_ThTaxPolicyId) then
      update ThTaxPolicy set
        ThTaxPolicyDesc = In_ThTaxPolicyDesc where
        ThTaxPolicyId = In_ThTaxPolicyId;
      commit work;
      set Out_ErrorCode=1
    else
      set Out_ErrorCode=0
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.UpdateThTaxProgression(
in In_ThTaxProgSysId integer,
in In_ThTaxPolicyId char(20),
in In_ThTaxProgDate date,
in In_ThExpensePercent double,
in In_ThExpenseMax double,
in In_ThPFExcess double,
in In_ThPFMax double,
in In_ThPFPercent double,
in In_ThTaxpayerAmt double,
in In_ThSpouseAmt double,
in In_ThMaxNoOfChild double,
in In_ThChildAgeLimit double,
in In_ThChildNoStudyAmt double,
in In_ThChildStudyAmt double,
in In_ThParentAmt double,
in In_ThParentMinAge double,
in In_ThOldAgeAmt double,
in In_ThOldAgeMinAge double,
in In_ThInsuranceMax double,
in In_ThResidenceMax double,
in In_ThCharityMaxPercent double,
out Out_ErrorCode integer)
begin
  if In_ThTaxPolicyId is not null then
    if In_ThExpensePercent between 0 and 100 then
      if In_ThPFPercent between 0 and 100 then
        if In_ThCharityMaxPercent between 0 and 100 then
          if exists(select* from ThTaxProgression where ThTaxProgSysId = In_ThTaxProgSysId) then
            update ThTaxProgression set ThTaxPolicyId = In_ThTaxPolicyId,
              ThTaxProgDate = In_ThTaxProgDate,
              ThExpensePercent = In_ThExpensePercent,
              ThExpenseMax = In_ThExpenseMax,
              ThPFExcess = In_ThPFExcess,
              ThPFMax = In_ThPFMax,
              ThPFPercent = In_ThPFPercent,
              ThTaxpayerAmt = In_ThTaxpayerAmt,
              ThSpouseAmt = In_ThSpouseAmt,
              ThMaxNoOfChild = In_ThMaxNoOfChild,
              ThChildAgeLimit = In_ThChildAgeLimit,
              ThChildNoStudyAmt = In_ThChildNoStudyAmt,
              ThChildStudyAmt = In_ThChildStudyAmt,
              ThParentAmt = In_ThParentAmt,
              ThParentMinAge = In_ThParentMinAge,
              ThOldAgeAmt = In_ThOldAgeAmt,
              ThOldAgeMinAge = In_ThOldAgeMinAge,
              ThInsuranceMax = In_ThInsuranceMax,
              ThResidenceMax = In_ThResidenceMax,
              ThCharityMaxPercent = In_ThCharityMaxPercent where
              ThTaxProgSysId = In_ThTaxProgSysId;
            commit work;
            set Out_ErrorCode=1
          else
            set Out_ErrorCode=0
          end if
        else
          set Out_ErrorCode=-4
        end if
      else
        set Out_ErrorCode=-3
      end if
    else
      set Out_ErrorCode=-2
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure DBA.ASQLGetThFamilyInfo(
in In_PersonalSysId integer,
out Out_ThChildNoStudy double,
out Out_ThChildStudy double)
begin
  declare Out_TotalChildren double;
  set Out_ThChildNoStudy=0;
  set Out_ThChildStudy=0;
  select count(*) into Out_TotalChildren from Family where
    PersonalSysId = In_PersonalSysId and
    RelationshipId in('Son','Step Son','Daughter','Step Daughter') and
    FGetFamilyAge(FamilySysId) < 25;
  select count(*) into Out_ThChildStudy from Family join FamilyEduRec where
    Family.PersonalSysId = In_PersonalSysId and
    RelationshipId in('Son','Step Son','Daughter','Step Daughter') and
    FGetFamilyAge(Family.FamilySysId) < 25 and
    (FGetInvalidDate(FamilyEduRec.EduEndDate) = '' or FGetInvalidDate(FamilyEduRec.EduEndDate) is null);
  set Out_ThChildNoStudy=Out_TotalChildren-Out_ThChildStudy
end
;

create procedure dba.InsertNewThTaxEmployer(
in In_ThTaxEmployerId char(20),
in In_ThRegisteredName char(100),
in In_ThERTaxNo char(20),
in In_ThTaxBranchNo char(20),
in In_ThBuildingName char(50),
in In_ThRoomNo char(20),
in In_ThFloorNo char(20),
in In_ThNo char(20),
in In_ThMoo char(20),
in In_ThLaneSoi char(20),
in In_ThRoad char(20),
in In_ThSubDistrict char(20),
in In_ThDistrict char(20),
in In_ThProvince char(20),
in In_ThCode char(20),
in In_ThPostalCode char(20),
in In_ThTelNo char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from ThTaxEmployer where ThTaxEmployerId = In_ThTaxEmployerId) then
    insert into ThTaxEmployer(ThTaxEmployerId,
      ThRegisteredName,
      ThERTaxNo,
      ThTaxBranchNo,
      ThBuildingName,
      ThRoomNo,
      ThFloorNo,
      ThNo,
      ThMoo,
      ThLaneSoi,
      ThRoad,
      ThSubDistrict,
      ThDistrict,
      ThProvince,
      ThCode,
      ThPostalCode,
      ThTelNo) values(
      In_ThTaxEmployerId,
      In_ThRegisteredName,
      In_ThERTaxNo,
      In_ThTaxBranchNo,
      In_ThBuildingName,
      In_ThRoomNo,
      In_ThFloorNo,
      In_ThNo,
      In_ThMoo,
      In_ThLaneSoi,
      In_ThRoad,
      In_ThSubDistrict,
      In_ThDistrict,
      In_ThProvince,
      In_ThCode,
      In_ThPostalCode,
      In_ThTelNo);
    commit work;
    if not exists(select* from ThTaxEmployer where ThTaxEmployerId = In_ThTaxEmployerId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateThTaxEmployer(
in In_ThTaxEmployerId char(20),
in In_ThRegisteredName char(100),
in In_ThERTaxNo char(20),
in In_ThTaxBranchNo char(20),
in In_ThBuildingName char(50),
in In_ThRoomNo char(20),
in In_ThFloorNo char(20),
in In_ThNo char(20),
in In_ThMoo char(20),
in In_ThLaneSoi char(20),
in In_ThRoad char(20),
in In_ThSubDistrict char(20),
in In_ThDistrict char(20),
in In_ThProvince char(20),
in In_ThCode char(20),
in In_ThPostalCode char(20),
in In_ThTelNo char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from ThTaxEmployer where ThTaxEmployerId = In_ThTaxEmployerId) then
    update ThTaxEmployer set
      ThRegisteredName = In_ThRegisteredName,
      ThERTaxNo = In_ThERTaxNo,
      ThTaxBranchNo = In_ThTaxBranchNo,
      ThBuildingName = In_ThBuildingName,
      ThRoomNo = In_ThRoomNo,
      ThFloorNo = In_ThFloorNo,
      ThNo = In_ThNo,
      ThMoo = In_ThMoo,
      ThLaneSoi = In_ThLaneSoi,
      ThRoad = In_ThRoad,
      ThSubDistrict = In_ThSubDistrict,
      ThDistrict = In_ThDistrict,
      ThProvince = In_ThProvince,
      ThCode = In_ThCode,
      ThPostalCode = In_ThPostalCode,
      ThTelNo = In_ThTelNo where
      ThTaxEmployerId = In_ThTaxEmployerId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteThTaxEmployer(
in In_ThTaxEmployerId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from ThTaxEmployer where ThTaxEmployer.ThTaxEmployerId = In_ThTaxEmployerId) then
    if not exists(select* from ThTaxDetails where ThTaxDetails.ThTaxEmployerId = In_ThTaxEmployerId) then
      if exists(select* from ThSurcharge where ThSurcharge.ThTaxEmployerId = In_ThTaxEmployerId) then
        delete from ThSurcharge where ThSurcharge.ThTaxEmployerId = In_ThTaxEmployerId;
        commit work
      end if;
      delete from ThTaxEmployer where ThTaxEmployer.ThTaxEmployerId = In_ThTaxEmployerId;
      commit work
    end if;
    if exists(select* from ThTaxEmployer where ThTaxEmployer.ThTaxEmployerId = In_ThTaxEmployerId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewThTaxRecord(
in In_PersonalSysId integer,
in In_ThTaxationYear integer,
in In_ThPeriodFrom date,
in In_ThPeriodTo date,
in In_ThTaxPolicyId char(20),
in In_ThTaxEmployerId char(20),
in In_ThB_PFExceed double,
in In_ThB_GovtPension double,
in In_ThB_SchoolFund double,
in In_ThC_OldAgeAmt double,
in In_ThB_OldAgeAmtSpouse double,
in In_ThB_SeverancePay double,
in In_ThC_Taxpayer double,
in In_ThC_Spouse double,
in In_ThC_NoChildNoStudy double,
in In_ThC_NoChildStudy double,
in In_ThC_ChildNoStudyAmt double,
in In_ThC_ChildStudyAmt double,
in In_ThC_FatherAmt double,
in In_ThC_MotherAmt double,
in In_ThC_FatherSpouseAmt double,
in In_ThC_MotherSpouseAmt double,
in In_ThC_HealthInsurance double,
in In_ThC_Insurance double,
in In_ThC_ProvidentFund double,
in In_ThC_RetirementShare double,
in In_ThC_EquityFund double,
in In_ThC_Residence double,
in In_ThC_SocialSecurity double,
in In_ThA_Salary double,
in In_ThA_TotalExempted double,
in In_ThA_Expense double,
in In_ThA_TotalAllowances double,
in In_ThA_Education double,
in In_ThA_Sport double,
in In_ThA_Donation double,
in In_Th_Taxable double,
in In_Th_TaxAmt double,
in In_Th_TaxWithheld double,
in In_Th_TaxExcess double,
out Out_ErrorCode integer)
begin
  if not exists(select* from ThTaxRecord where PersonalSysId = In_PersonalSysId and ThTaxationYear = In_ThTaxationYear) then
    insert into ThTaxRecord(PersonalSysId,
      ThTaxationYear,
      ThPeriodFrom,
      ThPeriodTo,
      ThTaxPolicyId,
      ThTaxEmployerId,
      ThB_PFExceed,
      ThB_GovtPension,
      ThB_SchoolFund,
      ThC_OldAgeAmt,
      ThB_OldAgeAmtSpouse,
      ThB_SeverancePay,
      ThC_Taxpayer,
      ThC_Spouse,
      ThC_NoChildNoStudy,
      ThC_NoChildStudy,
      ThC_ChildNoStudyAmt,
      ThC_ChildStudyAmt,
      ThC_FatherAmt,
      ThC_MotherAmt,
      ThC_FatherSpouseAmt,
      ThC_MotherSpouseAmt,
      ThC_HealthInsurance,
      ThC_Insurance,
      ThC_ProvidentFund,
      ThC_RetirementShare,
      ThC_EquityFund,
      ThC_Residence,
      ThC_SocialSecurity,
      ThA_Salary,
      ThA_TotalExempted,
      ThA_Expense,
      ThA_TotalAllowances,
      ThA_Education,
      ThA_Sport,
      ThA_Donation,
      Th_Taxable,
      Th_TaxAmt,
      Th_TaxWithheld,
      Th_TaxExcess) values(In_PersonalSysId,
      In_ThTaxationYear,
      In_ThPeriodFrom,
      In_ThPeriodTo,
      In_ThTaxPolicyId,
      In_ThTaxEmployerId,
      In_ThB_PFExceed,
      In_ThB_GovtPension,
      In_ThB_SchoolFund,
      In_ThC_OldAgeAmt,
      In_ThB_OldAgeAmtSpouse,
      In_ThB_SeverancePay,
      In_ThC_Taxpayer,
      In_ThC_Spouse,
      In_ThC_NoChildNoStudy,
      In_ThC_NoChildStudy,
      In_ThC_ChildNoStudyAmt,
      In_ThC_ChildStudyAmt,
      In_ThC_FatherAmt,
      In_ThC_MotherAmt,
      In_ThC_FatherSpouseAmt,
      In_ThC_MotherSpouseAmt,
      In_ThC_HealthInsurance,
      In_ThC_Insurance,
      In_ThC_ProvidentFund,
      In_ThC_RetirementShare,
      In_ThC_EquityFund,
      In_ThC_Residence,
      In_ThC_SocialSecurity,
      In_ThA_Salary,
      In_ThA_TotalExempted,
      In_ThA_Expense,
      In_ThA_TotalAllowances,
      In_ThA_Education,
      In_ThA_Sport,
      In_ThA_Donation,
      In_Th_Taxable,
      In_Th_TaxAmt,
      In_Th_TaxWithheld,
      In_Th_TaxExcess);
    commit work;
    if not exists(select* from ThTaxRecord where PersonalSysId = In_PersonalSysId and ThTaxationYear = In_ThTaxationYear) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateThTaxRecord(
in In_PersonalSysId integer,
in In_ThTaxationYear integer,
in In_ThPeriodFrom date,
in In_ThPeriodTo date,
in In_ThTaxPolicyId char(20),
in In_ThTaxEmployerId char(20),
in In_ThB_PFExceed double,
in In_ThB_GovtPension double,
in In_ThB_SchoolFund double,
in In_ThC_OldAgeAmt double,
in In_ThB_OldAgeAmtSpouse double,
in In_ThB_SeverancePay double,
in In_ThC_Taxpayer double,
in In_ThC_Spouse double,
in In_ThC_NoChildNoStudy double,
in In_ThC_NoChildStudy double,
in In_ThC_ChildNoStudyAmt double,
in In_ThC_ChildStudyAmt double,
in In_ThC_FatherAmt double,
in In_ThC_MotherAmt double,
in In_ThC_FatherSpouseAmt double,
in In_ThC_MotherSpouseAmt double,
in In_ThC_HealthInsurance double,
in In_ThC_Insurance double,
in In_ThC_ProvidentFund double,
in In_ThC_RetirementShare double,
in In_ThC_EquityFund double,
in In_ThC_Residence double,
in In_ThC_SocialSecurity double,
in In_ThA_Salary double,
in In_ThA_TotalExempted double,
in In_ThA_Expense double,
in In_ThA_TotalAllowances double,
in In_ThA_Education double,
in In_ThA_Sport double,
in In_ThA_Donation double,
in In_Th_Taxable double,
in In_Th_TaxAmt double,
in In_Th_TaxWithheld double,
in In_Th_TaxExcess double,
out Out_ErrorCode integer)
begin
  if exists(select* from ThTaxRecord where PersonalSysId = In_PersonalSysId and ThTaxationYear = In_ThTaxationYear) then
    update ThTaxRecord set
      ThPeriodFrom = In_ThPeriodFrom,
      ThPeriodTo = In_ThPeriodTo,
      ThTaxPolicyId = In_ThTaxPolicyId,
      ThTaxEmployerId = In_ThTaxEmployerId,
      ThB_PFExceed = In_ThB_PFExceed,
      ThB_GovtPension = In_ThB_GovtPension,
      ThB_SchoolFund = In_ThB_SchoolFund,
      ThC_OldAgeAmt = In_ThC_OldAgeAmt,
      ThB_OldAgeAmtSpouse = In_ThB_OldAgeAmtSpouse,
      ThB_SeverancePay = In_ThB_SeverancePay,
      ThC_Taxpayer = In_ThC_Taxpayer,
      ThC_Spouse = In_ThC_Spouse,
      ThC_NoChildNoStudy = In_ThC_NoChildNoStudy,
      ThC_NoChildStudy = In_ThC_NoChildStudy,
      ThC_ChildNoStudyAmt = In_ThC_ChildNoStudyAmt,
      ThC_ChildStudyAmt = In_ThC_ChildStudyAmt,
      ThC_FatherAmt = In_ThC_FatherAmt,
      ThC_MotherAmt = In_ThC_MotherAmt,
      ThC_FatherSpouseAmt = In_ThC_FatherSpouseAmt,
      ThC_MotherSpouseAmt = In_ThC_MotherSpouseAmt,
      ThC_HealthInsurance = In_ThC_HealthInsurance,
      ThC_Insurance = In_ThC_Insurance,
      ThC_ProvidentFund = In_ThC_ProvidentFund,
      ThC_RetirementShare = In_ThC_RetirementShare,
      ThC_EquityFund = In_ThC_EquityFund,
      ThC_Residence = In_ThC_Residence,
      ThC_SocialSecurity = In_ThC_SocialSecurity,
      ThA_Salary = In_ThA_Salary,
      ThA_TotalExempted = In_ThA_TotalExempted,
      ThA_Expense = In_ThA_Expense,
      ThA_TotalAllowances = In_ThA_TotalAllowances,
      ThA_Education = In_ThA_Education,
      ThA_Sport = In_ThA_Sport,
      ThA_Donation = In_ThA_Donation,
      Th_Taxable = In_Th_Taxable,
      Th_TaxAmt = In_Th_TaxAmt,
      Th_TaxWithheld = In_Th_TaxWithheld,
      Th_TaxExcess = In_Th_TaxExcess where
      PersonalSysId = In_PersonalSysId and
      ThTaxationYear = In_ThTaxationYear;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteThTaxRecord(
in In_PersonalSysId integer,
in In_ThTaxationYear integer,
out Out_ErrorCode integer)
begin
  if exists(select* from ThTaxRecord where PersonalSysId = In_PersonalSysId and ThTaxationYear = In_ThTaxationYear) then
    if exists(select* from ThTaxEmployee where PersonalSysId = In_PersonalSysId and ThTaxationYear = In_ThTaxationYear) then
      delete from ThTaxEmployee where PersonalSysId = In_PersonalSysId and ThTaxationYear = In_ThTaxationYear;
      commit work
    end if;
    delete from ThTaxRecord where PersonalSysId = In_PersonalSysId and ThTaxationYear = In_ThTaxationYear;
    commit work;
    if exists(select* from ThTaxRecord where PersonalSysId = In_PersonalSysId and ThTaxationYear = In_ThTaxationYear) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewThTaxEmployee(
in In_PersonalSysId integer,
in In_ThTaxationYear integer,
in In_ThTaxEESysId integer,
in In_FromPayRecYear integer,
in In_FromPayRecPeriod integer,
in In_FromPayRecSubPeriod integer,
in In_ToPayRecYear integer,
in In_ToPayRecPeriod integer,
in In_ToPayRecSubPeriod integer,
in In_PayRecID char(20),
in In_TaxLastProcessed smallint,
out Out_ErrorCode integer)
begin
  if not exists(select* from ThTaxEmployee where PersonalSysId = In_PersonalSysId and
      ThTaxationYear = In_ThTaxationYear and ThTaxEESysId = In_ThTaxEESysId) then
    insert into ThTaxEmployee(PersonalSysId,
      ThTaxationYear,
      ThTaxEESysId,
      FromPayRecYear,
      FromPayRecPeriod,
      FromPayRecSubPeriod,
      ToPayRecYear,
      ToPayRecPeriod,
      ToPayRecSubPeriod,
      PayRecID,
      TaxLastProcessed) values(
      In_PersonalSysId,
      In_ThTaxationYear,
      In_ThTaxEESysId,
      In_FromPayRecYear,
      In_FromPayRecPeriod,
      In_FromPayRecSubPeriod,
      In_ToPayRecYear,
      In_ToPayRecPeriod,
      In_ToPayRecSubPeriod,
      In_PayRecID,
      In_TaxLastProcessed);
    commit work;
    if not exists(select* from ThTaxEmployee where PersonalSysId = In_PersonalSysId and
        ThTaxationYear = In_ThTaxationYear and ThTaxEESysId = In_ThTaxEESysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateThTaxEmployee(
in In_PersonalSysId integer,
in In_ThTaxationYear integer,
in In_ThTaxEESysId integer,
in In_FromPayRecYear integer,
in In_FromPayRecPeriod integer,
in In_FromPayRecSubPeriod integer,
in In_ToPayRecYear integer,
in In_ToPayRecPeriod integer,
in In_ToPayRecSubPeriod integer,
in In_PayRecID char(20),
in In_TaxLastProcessed smallint,
out Out_ErrorCode integer)
begin
  if exists(select* from ThTaxEmployee where PersonalSysId = In_PersonalSysId and
      ThTaxationYear = In_ThTaxationYear and ThTaxEESysId = In_ThTaxEESysId) then
    update ThTaxEmployee set
      FromPayRecYear = In_FromPayRecYear,
      FromPayRecPeriod = In_FromPayRecPeriod,
      FromPayRecSubPeriod = In_FromPayRecSubPeriod,
      ToPayRecYear = In_ToPayRecYear,
      ToPayRecPeriod = In_ToPayRecPeriod,
      ToPayRecSubPeriod = In_ToPayRecSubPeriod,
      PayRecID = In_PayRecID,
      TaxLastProcessed = In_TaxLastProcessed where
      PersonalSysId = In_PersonalSysId and
      ThTaxationYear = In_ThTaxationYear and
      ThTaxEESysId = In_ThTaxEESysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteThTaxEmployee(
in In_PersonalSysId integer,
in In_ThTaxationYear integer,
in In_ThTaxEESysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from ThTaxEmployee where PersonalSysId = In_PersonalSysId and
      ThTaxationYear = In_ThTaxationYear and ThTaxEESysId = In_ThTaxEESysId) then
    delete from ThTaxEmployere where PersonalSysId = In_PersonalSysId and
      ThTaxationYear = In_ThTaxationYear and ThTaxEESysId = In_ThTaxEESysId;
    commit work;
    if exists(select* from ThTaxEmployee where PersonalSysId = In_PersonalSysId and
        ThTaxationYear = In_ThTaxationYear and ThTaxEESysId = In_ThTaxEESysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure DBA.ASQLCalPayRecPFSSWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_WageType char(20),
out Out_WageAmount double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  declare SubjectProperty char(20);
  declare WageProperty char(20);
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_WageAmount=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if In_WageType = 'PFNormalWage' then
    set SubjectProperty='SubjNormalPF';
    set WageProperty='PFNormalWage'
  else if In_WageType = 'PFSpecialWage' then
      set SubjectProperty='SubjSpecialPF';
      set WageProperty='PFSpecialWage'
    else
      set SubjectProperty='SubjSS';
      set WageProperty='SSWage'
    end if
  end if;
  if(IsWageElementInUsed(SubjectProperty,WageProperty) = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Amount
    */
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    OT Back Pay Amount
    */
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    Shift Amount
    */
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
    end if;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    set Out_WageAmount=Out_WageAmount+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt',WageProperty) = 1) then
    select CalLveDeductAmt into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  end if;
  if Out_LveDeductAmt is null then set Out_LveDeductAmt=0
  end if;
  set Out_WageAmount=Out_WageAmount+Out_LveDeductAmt;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay',WageProperty) = 1) then
    select CalBackPay into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  end if;
  if Out_BackPayAmt is null then set Out_BackPayAmt=0
  end if;
  set Out_WageAmount=Out_WageAmount+Out_BackPayAmt;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage',WageProperty) = 1) then
    select CalTotalWage into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  end if;
  if Out_TotalWageAmt is null then set Out_TotalWageAmt=0
  end if;
  set Out_WageAmount=Out_WageAmount+Out_TotalWageAmt
end
;

create function dba.FGetProvidentFundFormula(
in In_OrdFormulaId char(20),
in In_AddFormulaId char(20))
returns char(255)
begin
  declare Out_OrdDesc char(255);
  declare Out_AddDesc char(255);
  declare OrdFormulaType char(20);
  declare AddFormulaType char(20);
  declare OrdC1 double;
  declare OrdC2 double;
  declare OrdC3 double;
  declare OrdC4 double;
  declare OrdC5 double;
  declare OrdUserDef1 char(20);
  declare OrdUserDef2 char(20);
  declare AddC1 double;
  declare AddC2 double;
  declare AddC3 double;
  declare AddC4 double;
  declare AddC5 double;
  declare AddUserDef1 char(20);
  declare AddUserDef2 char(20);
  /*
  To Get Ordinary Formula  
  */
  select FormulaType,
    Constant1,
    Constant2,
    Constant3,
    Constant4,
    Constant5,
    UserDef1,
    UserDef2 into OrdFormulaType,
    OrdC1,
    OrdC2,
    OrdC3,
    OrdC4,
    OrdC5,
    OrdUserDef1,
    OrdUserDef2 from Formula join FormulaRange where Formula.FormulaId = In_OrdFormulaId;
  select FormulaType,
    Constant1,
    Constant2,
    Constant3,
    Constant4,
    Constant5,
    UserDef1,
    UserDef2 into AddFormulaType,
    AddC1,
    AddC2,
    AddC3,
    AddC4,
    AddC5,
    AddUserDef1,
    AddUserDef2 from Formula join FormulaRange where Formula.FormulaId = In_AddFormulaId;
  set Out_OrdDesc=null;
  set Out_AddDesc=null;
  /*
  To check the formula type
  */
  if(OrdFormulaType = 'T1') then
    set Out_OrdDesc=OrdUserDef1+'['+LTrim(Str(OrdC1,8,2))+'% of '+FGetKeyWordUserDefinedName(OrdUserDef2)+' ]'
  elseif(OrdFormulaType = 'T2') then
    set Out_OrdDesc=OrdUserDef1+'['+LTrim(Str(OrdC1,8,2))+'% of '+FGetKeyWordUserDefinedName(OrdUserDef2)+' capped at '+LTrim(Str(OrdC2,8,2))+']'
  elseif(OrdFormulaType = 'T3') then
    set Out_OrdDesc=' Fixed amount $'+LTrim(Str(OrdC1,8,1))
  end if;
  if(OrdFormulaType = 'Adv') then
    select FDecodeFormula(In_OrdFormulaId) into Out_OrdDesc;
    set Out_OrdDesc=Out_OrdDesc
  end if;
  if(AddFormulaType = 'T1') then
    set Out_AddDesc=AddUserDef1+'['+LTrim(Str(AddC1,8,2))+'% of '+FGetKeyWordUserDefinedName(AddUserDef2)+' ]'
  end if;
  return Out_OrdDesc+Out_AddDesc
end
;

create function dba.FGetThTaxEmployerAddr(
in In_ThTaxEmployerId char(20))
returns char(255)
begin
  declare Out_ThTaxEmployerAddr char(255);
  if exists(select* from ThTaxEmployer where ThTaxEmployerId = In_ThTaxEmployerId) then
    select(ThBuildingName || ', ' || ThRoomNo || ', ' || ThFloorNo || ', ' || ThNo || ', ' || ThLaneSoi || ', ' || ThMoo || ', ' || ThRoad || ', ' || ThSubDistrict || ', ' || ThDistrict || ', ' || ThProvince) as ThAddress into Out_ThTaxEmployerAddr
      from ThTaxEmployer where ThTaxEmployerId = In_ThTaxEmployerId
  else
    set Out_ThTaxEmployerAddr=''
  end if;
  return(Out_ThTaxEmployerAddr)
end
;

create procedure DBA.ASQLCalPayPeriodPFSSWage(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_WageType char(20),
out Out_WageAmount double,
out Out_AllowanceTotal double,
out Out_OTTotal double,
out Out_ShiftTotal double,
out Out_LveDeductAmt double,
out Out_BackPayAmt double,
out Out_TotalWageAmt double,
out Out_OTBackPayAmt double)
begin
  declare SubjectProperty char(20);
  declare WageProperty char(20);
  set Out_AllowanceTotal=0;
  set Out_OTTotal=0;
  set Out_OTBackPayAmt=0;
  set Out_ShiftTotal=0;
  set Out_WageAmount=0;
  set Out_LveDeductAmt=0;
  set Out_BackPayAmt=0;
  set Out_TotalWageAmt=0;
  if In_WageType = 'PFNormalWage' then
    set SubjectProperty='SubjNormalPF';
    set WageProperty='PFNormalWage'
  else if In_WageType = 'PFSpecialWage' then
      set SubjectProperty='SubjSpecialPF';
      set WageProperty='PFSpecialWage'
    else
      set SubjectProperty='SubjSS';
      set WageProperty='SSWage'
    end if
  end if;
  if(IsWageElementInUsed(SubjectProperty,WageProperty) = 1) then
    /*
    Pay Element
    */
    select Sum(AllowanceAmount) into Out_AllowanceTotal from AllowanceRecord where
      IsFormulaIdHasProperty(AllowanceFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    OT Amount
    */
    select Sum(CurrentOTAmount)+Sum(LastOTAmount) into Out_OTTotal from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    OT Back Pay Amount
    */
    select Sum(BackPayOTAmount) into Out_OTBackPayAmt from
      OTRecord where
      IsFormulaIdHasProperty(OTFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    /*
    Shift Amount
    */
    select Sum(ShiftAmount) into Out_ShiftTotal from
      ShiftRecord where
      IsFormulaIdHasProperty(ShiftFormulaId,SubjectProperty) = 1 and
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if Out_AllowanceTotal is null then set Out_AllowanceTotal=0
    end if;
    if Out_OTTotal is null then set Out_OTTotal=0
    end if;
    if Out_OTBackPayAmt is null then set Out_OTBackPayAmt=0
    end if;
    if Out_ShiftTotal is null then set Out_ShiftTotal=0
    end if;
    set Out_WageAmount=Out_WageAmount+Out_AllowanceTotal+Out_OTTotal+Out_OTBackPayAmt+Out_ShiftTotal
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt',WageProperty) = 1) then
    select Sum(CalLveDeductAmt) into Out_LveDeductAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if Out_LveDeductAmt is null then set Out_LveDeductAmt=0
  end if;
  set Out_WageAmount=Out_WageAmount+Out_LveDeductAmt;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay',WageProperty) = 1) then
    select Sum(CalBackPay) into Out_BackPayAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if Out_BackPayAmt is null then set Out_BackPayAmt=0
  end if;
  set Out_WageAmount=Out_WageAmount+Out_BackPayAmt;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage',WageProperty) = 1) then
    select Sum(CalTotalWage) into Out_TotalWageAmt from detailrecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod
  end if;
  if Out_TotalWageAmt is null then set Out_TotalWageAmt=0
  end if;
  set Out_WageAmount=Out_WageAmount+Out_TotalWageAmt
end
;

create function DBA.IsPreviousPeriodDiff(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PFIndicator integer)
returns smallint
begin
  declare Prev_PayRecYear integer;
  declare Prev_PayRecPeriod integer;
  declare Curr_PFEEContri double;
  declare Curr_PFERNormalContri double;
  declare Curr_PFERSpecialContri double;
  declare Prev_PFEEContri double;
  declare Prev_PFERNormalContri double;
  declare Prev_PFERSpecialContri double;
  declare Out_HasDifference smallint;
  if(In_PayRecPeriod = 1) then
    set Prev_PayRecYear=In_PayRecYear-1;
    set Prev_PayRecPeriod=12
  else
    set Prev_PayRecYear=In_PayRecYear;
    set Prev_PayRecPeriod=In_PayRecPeriod-1
  end if;
  case In_PFIndicator
  when 1 then
    select ContriOrdEECPF,ContriOrdERCPF,ContriAddERCPF into Curr_PFEEContri,Curr_PFERNormalContri,
      Curr_PFERSpecialContri from PeriodPolicySummary where
      EmployeeSysId = In_EmployeeSysId and PayRecYear = In_PayRecYear and PayRecPeriod = In_PayRecPeriod;
    select ContriOrdEECPF,ContriOrdERCPF,ContriAddERCPF into Prev_PFEEContri,Prev_PFERNormalContri,
      Prev_PFERSpecialContri from PeriodPolicySummary where
      EmployeeSysId = In_EmployeeSysId and PayRecYear = Prev_PayRecYear and PayRecPeriod = Prev_PayRecPeriod
  when 2 then
    select ActualOrdEECPF,ActualOrdERCPF,ActualAddERCPF into Curr_PFEEContri,Curr_PFERNormalContri,
      Curr_PFERSpecialContri from PeriodPolicySummary where
      EmployeeSysId = In_EmployeeSysId and PayRecYear = In_PayRecYear and PayRecPeriod = In_PayRecPeriod;
    select ActualOrdEECPF,ActualOrdERCPF,ActualAddERCPF into Prev_PFEEContri,Prev_PFERNormalContri,
      Prev_PFERSpecialContri from PeriodPolicySummary where
      EmployeeSysId = In_EmployeeSysId and PayRecYear = Prev_PayRecYear and PayRecPeriod = Prev_PayRecPeriod
  when 3 then
    select VolOrdEECPF,VolOrdERCPF,VolAddERCPF into Curr_PFEEContri,Curr_PFERNormalContri,
      Curr_PFERSpecialContri from PeriodPolicySummary where
      EmployeeSysId = In_EmployeeSysId and PayRecYear = In_PayRecYear and PayRecPeriod = In_PayRecPeriod;
    select VolOrdEECPF,VolOrdERCPF,VolAddERCPF into Prev_PFEEContri,Prev_PFERNormalContri,
      Prev_PFERSpecialContri from PeriodPolicySummary where
      EmployeeSysId = In_EmployeeSysId and PayRecYear = Prev_PayRecYear and PayRecPeriod = Prev_PayRecPeriod
  when 4 then
    select SupIR8AActOrdEECPF,SupIR8AActOrdERCPF,SupIR8AActAddERCPF into Curr_PFEEContri,Curr_PFERNormalContri,
      Curr_PFERSpecialContri from PeriodPolicySummary where
      EmployeeSysId = In_EmployeeSysId and PayRecYear = In_PayRecYear and PayRecPeriod = In_PayRecPeriod;
    select SupIR8AActOrdEECPF,SupIR8AActOrdERCPF,SupIR8AActAddERCPF into Prev_PFEEContri,Prev_PFERNormalContri,
      Prev_PFERSpecialContri from PeriodPolicySummary where
      EmployeeSysId = In_EmployeeSysId and PayRecYear = Prev_PayRecYear and PayRecPeriod = Prev_PayRecPeriod
  when 5 then
    select SupIR8AERCPF,SupIR8AOrdERCPF,SupIR8AAddERCPF into Curr_PFEEContri,Curr_PFERNormalContri,
      Curr_PFERSpecialContri from PeriodPolicySummary where
      EmployeeSysId = In_EmployeeSysId and PayRecYear = In_PayRecYear and PayRecPeriod = In_PayRecPeriod;
    select SupIR8AERCPF,SupIR8AOrdERCPF,SupIR8AAddERCPF into Prev_PFEEContri,Prev_PFERNormalContri,
      Prev_PFERSpecialContri from PeriodPolicySummary where
      EmployeeSysId = In_EmployeeSysId and PayRecYear = Prev_PayRecYear and PayRecPeriod = Prev_PayRecPeriod
  end case
  ;
  if(Prev_PFEEContri is null or
    Prev_PFERNormalContri is null or
    Prev_PFERSpecialContri is null or
    Curr_PFEEContri <> Prev_PFEEContri or
    Curr_PFERNormalContri <> Prev_PFERNormalContri or
    Curr_PFERSpecialContri <> Prev_PFERSpecialContri) then
    set Out_HasDifference=1
  else
    set Out_HasDifference=0
  end if;
  return Out_HasDifference
end
;

create function DBA.FGetEmployeeStatus(
in In_EmployeeSysId integer,
in In_Year integer,
in In_Month integer,
in in_PFIndicator integer)
returns char(1)
begin
  declare Out_Status char(1);
  declare HireMonth integer;
  declare HireYear integer;
  declare CessationMonth integer;
  declare CessationYear integer;
  set HireMonth=0;
  set HireYear=0;
  set CessationMonth=0;
  set CessationYear=0;
  select Month(HireDate) into HireMonth from Employee where EmployeeSysId = In_EmployeeSysId;
  select Year(HireDate) into HireYear from Employee where EmployeeSysId = In_EmployeeSysId;
  select Month(CessationDate) into CessationMonth from Employee where EmployeeSysId = In_EmployeeSysId;
  select Year(CessationDate) into CessationYear from Employee where EmployeeSysId = In_EmployeeSysId;
  if CessationYear = 1899 then
    if HireYear = In_Year and HireMonth = In_Month then //New Joiner
      set Out_Status='N'
    else
      set Out_Status='A';
      if IsPreviousPeriodDiff(In_EmployeeSysId,In_Year,In_Month,In_PFIndicator) = 1 then
        set Out_Status='C'
      end if
    end if
  else
    if CessationYear = In_Year and CessationMonth = In_Month then //resign staff
      set Out_Status='C'
    else
      set Out_Status='A'
    end if
  end if;
  return(Out_Status)
end
;