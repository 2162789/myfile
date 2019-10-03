//Tax Record
update ThTaxProgression set ThChildStudyAgeLimit = 25 where ThTaxPolicyId = 'Default' and ThTaxProgDate = '2017-01-01';
update ThTaxProgression set ThDisabledAmt = 190000 where ThDisabledAmt is NULL;
update ThTaxProgression set ThChildUnmarriedAgeLimit = 20 where ThChildUnmarriedAgeLimit is NULL;

update ThTaxDetails set ThDisabledPerson = 0 where ThDisabledPerson is NULL;
update ThTaxRecord set ThB_DisabledOldAgeAmt = ISNULL(ThC_OldAgeAmt, 0) where ThB_DisabledOldAgeAmt is NULL;
update ThTaxRecord set ThC_DisabledSupport = 0 where ThC_DisabledSupport is NULL;
update ThTaxRecord set ThC_AnnuityInsurance = 0 where ThC_AnnuityInsurance is NULL;
update ThTaxRecord set ThC_NationalSavings = 0 where ThC_NationalSavings is NULL;
update ThTaxRecord set ThC_FirstHomeBuyer = 0 where ThC_FirstHomeBuyer is NULL;
update ThTaxRecord set ThC_FoodDomestic = 0 where ThC_FoodDomestic is NULL;
update ThTaxRecord set ThC_Domestic = 0 where ThC_Domestic is NULL;
update ThTaxRecord set ThC_OTOPGoods = 0 where ThC_OTOPGoods is NULL;
update ThTaxRecord set ThC_YearEndDomestic = 0 where ThC_YearEndDomestic is NULL;
update ThTaxRecord set ThC_GoodsService = 0 where ThC_GoodsService is NULL;

if not exists (select 1 from ImportFieldName where TableNamePhysical = 'iThTaxDetails' and FieldNamePhysical = 'ThDisabledPerson') then
  insert into ImportFieldName (TableNamePhysical,FieldNamePhysical,FieldNameUserDefined,FieldType,IsKey)
  values ('iThTaxDetails','ThDisabledPerson','Disable Person','Integer',0);
end if;

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
    (Year(Now(*)) - Year(Family.DOB) < Out_ChildUnmarriedAgeLimit and Family.FamilyMaritalStatusCode != 'Married'
    or Year(Now(*)) - Year(Family.DOB) < Out_ChildStudyAgeLimit and Year(FamilyEduRec.EduStartDate) <= Year(Now(*)) and
    (FGetInvalidDate(FamilyEduRec.EduEndDate) = '' or FGetInvalidDate(FamilyEduRec.EduEndDate) is null));
  select count(distinct Family.FamilySysId) into Out_ThChildStudy from Family join FamilyEduRec where
    Family.PersonalSysId = In_PersonalSysId and
    RelationshipId in('Son','Step Son','Daughter','Step Daughter') and
    Year(Now(*)) - Year(Family.DOB) < Out_ChildStudyAgeLimit and EduLocal = 1 and Year(FamilyEduRec.EduStartDate) <= Year(Now(*)) and
    (FGetInvalidDate(FamilyEduRec.EduEndDate) = '' or FGetInvalidDate(FamilyEduRec.EduEndDate) is null);
  set Out_ThChildNoStudy = Out_TotalChildren - Out_ThChildStudy
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewThTaxDetails') then
   drop PROCEDURE InsertNewThTaxDetails;
end if;

CREATE PROCEDURE "DBA"."InsertNewThTaxDetails"(
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
in In_ThHealthMotherSpouse smallint,
in In_ThDisabledPerson smallint,
out Out_ErrorCode integer)
begin
  if not exists(select * from ThTaxDetails where PersonalSysId = In_PersonalSysId) then
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
      ThHealthMotherSpouse,
      ThDisabledPerson) values(
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
      In_ThHealthMotherSpouse,
      In_ThDisabledPerson);
    commit work;
    if not exists(select * from ThTaxDetails where PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateThTaxDetails') then
   drop PROCEDURE UpdateThTaxDetails;
end if;

CREATE PROCEDURE "DBA"."UpdateThTaxDetails"(
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
in In_ThHealthMotherSpouse smallint,
in In_ThDisabledPerson smallint,
out Out_ErrorCode integer)
begin
  if exists(select * from ThTaxDetails where PersonalSysId = In_PersonalSysId) then
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
      ThHealthMotherSpouse = In_ThHealthMotherSpouse,
      ThDisabledPerson = In_ThDisabledPerson where
      PersonalSysId = In_PersonalSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewThTaxRecord') then
   drop PROCEDURE InsertNewThTaxRecord;
end if;

CREATE PROCEDURE "DBA"."InsertNewThTaxRecord"(
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
in In_ThB_DisabledOldAgeAmt double,
in In_ThC_DisabledSupport double,
in In_ThC_AnnuityInsurance double,
in In_ThC_NationalSavings double,
in In_ThC_FirstHomeBuyer double,
in In_ThC_FoodDomestic double,
in In_ThC_Domestic double,
in In_ThC_OTOPGoods double,
in In_ThC_YearEndDomestic double,
in In_ThC_GoodsService double,
out Out_ErrorCode integer)
begin
  if not exists(select * from ThTaxRecord where PersonalSysId = In_PersonalSysId and ThTaxationYear = In_ThTaxationYear) then
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
      Th_TaxExcess,
      ThB_DisabledOldAgeAmt,
      ThC_DisabledSupport,
      ThC_AnnuityInsurance,
      ThC_NationalSavings,
      ThC_FirstHomeBuyer,
      ThC_FoodDomestic,
      ThC_Domestic,
      ThC_OTOPGoods,
      ThC_YearEndDomestic,
      ThC_GoodsService) values(In_PersonalSysId,
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
      In_Th_TaxExcess,
      In_ThB_DisabledOldAgeAmt,
      In_ThC_DisabledSupport,
      In_ThC_AnnuityInsurance,
      In_ThC_NationalSavings,
      In_ThC_FirstHomeBuyer,
      In_ThC_FoodDomestic,
      In_ThC_Domestic,
      In_ThC_OTOPGoods,
      In_ThC_YearEndDomestic,
      In_ThC_GoodsService);
    commit work;
    if not exists(select * from ThTaxRecord where PersonalSysId = In_PersonalSysId and ThTaxationYear = In_ThTaxationYear) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateThTaxRecord') then
   drop PROCEDURE UpdateThTaxRecord;
end if;

CREATE PROCEDURE "DBA"."UpdateThTaxRecord"(
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
in In_ThB_DisabledOldAgeAmt double,
in In_ThC_DisabledSupport double,
in In_ThC_AnnuityInsurance double,
in In_ThC_NationalSavings double,
in In_ThC_FirstHomeBuyer double,
in In_ThC_FoodDomestic double,
in In_ThC_Domestic double,
in In_ThC_OTOPGoods double,
in In_ThC_YearEndDomestic double,
in In_ThC_GoodsService double,
out Out_ErrorCode integer)
begin
  if exists(select * from ThTaxRecord where PersonalSysId = In_PersonalSysId and ThTaxationYear = In_ThTaxationYear) then
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
      Th_TaxExcess = In_Th_TaxExcess,
      ThB_DisabledOldAgeAmt = In_ThB_DisabledOldAgeAmt,
      ThC_DisabledSupport = In_ThC_DisabledSupport,
      ThC_AnnuityInsurance = In_ThC_AnnuityInsurance,
      ThC_NationalSavings = In_ThC_NationalSavings,
      ThC_FirstHomeBuyer = In_ThC_FirstHomeBuyer,
      ThC_FoodDomestic = In_ThC_FoodDomestic,
      ThC_Domestic = In_ThC_Domestic,
      ThC_OTOPGoods = In_ThC_OTOPGoods,
      ThC_YearEndDomestic = In_ThC_YearEndDomestic,
      ThC_GoodsService = In_ThC_GoodsService where
      PersonalSysId = In_PersonalSysId and
      ThTaxationYear = In_ThTaxationYear;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewThTaxProgression') then
   drop PROCEDURE InsertNewThTaxProgression;
end if;

CREATE PROCEDURE "DBA"."InsertNewThTaxProgression"(
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
in In_ThChildStudyAgeLimit double,
in In_ThChildNoStudyAmt double,
in In_ThChildStudyAmt double,
in In_ThParentAmt double,
in In_ThParentMinAge double,
in In_ThOldAgeAmt double,
in In_ThOldAgeMinAge double,
in In_ThInsuranceMax double,
in In_ThResidenceMax double,
in In_ThCharityMaxPercent double,
in In_ThDisabledAmt double,
in In_ThChildUnmarriedAgeLimit double,
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
          if not exists(select * from ThTaxProgression where ThTaxPolicyId = In_ThTaxPolicyId and ThTaxProgDate = In_ThTaxProgDate) then
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
              ThChildStudyAgeLimit,
              ThChildNoStudyAmt,
              ThChildStudyAmt,
              ThParentAmt,
              ThParentMinAge,
              ThOldAgeAmt,
              ThOldAgeMinAge,
              ThInsuranceMax,
              ThResidenceMax,
              ThCharityMaxPercent,
              ThDisabledAmt,
              ThChildUnmarriedAgeLimit) values(
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
              In_ThChildStudyAgeLimit,
              In_ThChildNoStudyAmt,
              In_ThChildStudyAmt,
              In_ThParentAmt,
              In_ThParentMinAge,
              In_ThOldAgeAmt,
              In_ThOldAgeMinAge,
              In_ThInsuranceMax,
              In_ThResidenceMax,
              In_ThCharityMaxPercent,
              In_ThDisabledAmt,
              In_ThChildUnmarriedAgeLimit);
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
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateThTaxProgression') then
   drop PROCEDURE UpdateThTaxProgression;
end if;

CREATE PROCEDURE "DBA"."UpdateThTaxProgression"(
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
in In_ThChildStudyAgeLimit double,
in In_ThChildNoStudyAmt double,
in In_ThChildStudyAmt double,
in In_ThParentAmt double,
in In_ThParentMinAge double,
in In_ThOldAgeAmt double,
in In_ThOldAgeMinAge double,
in In_ThInsuranceMax double,
in In_ThResidenceMax double,
in In_ThCharityMaxPercent double,
in In_ThDisabledAmt double,
in In_ThChildUnmarriedAgeLimit double,
out Out_ErrorCode integer)
begin
  if In_ThTaxPolicyId is not null then
    if In_ThExpensePercent between 0 and 100 then
      if In_ThPFPercent between 0 and 100 then
        if In_ThCharityMaxPercent between 0 and 100 then
          if exists(select * from ThTaxProgression where ThTaxProgSysId = In_ThTaxProgSysId) then
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
              ThChildStudyAgeLimit = In_ThChildStudyAgeLimit,
              ThChildNoStudyAmt = In_ThChildNoStudyAmt,
              ThChildStudyAmt = In_ThChildStudyAmt,
              ThParentAmt = In_ThParentAmt,
              ThParentMinAge = In_ThParentMinAge,
              ThOldAgeAmt = In_ThOldAgeAmt,
              ThOldAgeMinAge = In_ThOldAgeMinAge,
              ThInsuranceMax = In_ThInsuranceMax,
              ThResidenceMax = In_ThResidenceMax,
              ThCharityMaxPercent = In_ThCharityMaxPercent,
              ThDisabledAmt = In_ThDisabledAmt,
              ThChildUnmarriedAgeLimit = In_ThChildUnmarriedAgeLimit where
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
end;

//Employee Listing Report

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetTHManContriPolicy') then
   drop PROCEDURE FGetTHManContriPolicy;
end if;

CREATE FUNCTION "DBA"."FGetTHManContriPolicy"(
in In_EmployeeSysId integer)
returns char(100)
begin
  
  declare Out_PFPolicy char(30);
  select MandContriPolicyId into Out_PFPolicy
  from mandatorycontributeprog  where
  mandatorycontributeprog.EmployeeSysId = In_EmployeeSysId and
  MandContriSchemeId='Provident Fund 1' and MandContriCurrent = 1 ;

  if Out_PFPolicy is null then set Out_PFPolicy='N/A'
  end if;

  return(Out_PFPolicy);
end;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetTHManContriScheme') then
   drop PROCEDURE FGetTHManContriScheme;
end if;

CREATE FUNCTION "DBA"."FGetTHManContriScheme"(
in In_EmployeeSysId integer)
returns char(100)
begin
  
  declare Out_PFScheme char(30);
 
  select MandContriSchemeId into Out_PFScheme
  from mandatorycontributeprog  where
  mandatorycontributeprog.EmployeeSysId = In_EmployeeSysId and
  MandContriSchemeId='Provident Fund 1' and MandContriCurrent = 1 ;

  if Out_PFScheme is null then set Out_PFScheme='N/A'
  end if;

  return(Out_PFScheme);
end;

commit work;