if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPhDMBProperty') then
   drop procedure FGetPhDMBProperty
end if
;

CREATE FUNCTION "DBA"."FGetPhDMBProperty"(
in In_DMBItemId char(20))
RETURNS char(50)
BEGIN
	DECLARE "Out_DMBProperty" char(50);
	    select RegProperty1 into Out_DMBProperty 
        from SubRegistry where RegistryId = 'phDMBProperty' 
        and SubRegistryId = In_DMBItemId;
      	RETURN "Out_DMBProperty";
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePhTaxRecord') then
   drop procedure UpdatePhTaxRecord
end if
;

CREATE PROCEDURE "DBA"."UpdatePhTaxRecord"(
in In_PersonalSysId integer,
in In_PhTaxYear integer,
in In_PhEmployerId char(20),
in In_PhTaxPolicyId char(20),
in In_PhFromPeriod date,
in In_PhToPeriod date,
in In_PhExemption char(20),
in In_PhDependentNo integer,
in In_PhWifeClaimAddEx smallint,
in In_PhOtherDepName char(150),
in In_PhOtherDepRelation char(20),
in In_PhOtherDepDOB date,
in In_PhPresERMainER smallint,
in In_PhNonTaxBonus double,
in In_PhGovtFundContri double,
in In_PhNonTaxSalary double,
in In_PhTotalNonTaxable double,
in In_PhTaxSalary double,
in In_PhRepresentation double,
in In_PhTransport double,
in In_PhCostLiving double,
in In_PhHousing double,
in In_PhRegOTShift double,
in In_PhRegularOthers double,
in In_PhCommission double,
in In_PhProfitShare double,
in In_PhFees double,
in In_PhTaxBonus double,
in In_PhHazardPay double,
in In_PhSupplementOthers double,
in In_PhPresTaxable double,
in In_PhPrevTaxable double,
in In_PhTotalExemption double,
in In_PhInsurance double,
in In_PhActualTaxable double,
in In_PhTaxDue double,
in In_PhPresentERTax double,
in In_PhPreviousERTax double,
in In_PhTaxWithheld double,
in In_PhCTCNo char(20),
in In_PhCTCPlaceIssue char(50),
in In_PhCTCDateIssue date,
in In_PhCTCPaidAmt double,
in In_PhSMWPerDay double,	
in In_PhSMWPerMonth	double,	
in In_PhMWEOption smallint,	
in In_PhBasicSalaryMWE double,	
in In_PhHolidayPayMWE double,	
in In_PhOvertimePayMWE double,	
in In_PhNightShiftMWE double,	
in In_PhHazardPayMWE double,
in In_PhDeMinimis double,	
out Out_ErrorCode integer)
begin
  if not exists(select* from PhTaxRecord where PersonalSysId = In_PersonalSysId and PhTaxYear = In_PhTaxYear) then
    set Out_ErrorCode=-1; // Record not exist
    return
  elseif not In_PhEmployerId = any(select PhEmployerId from PhTaxEmployer) then
    set Out_ErrorCode=-2; // PhTaxEmployerId not exist
    return
  else
    // if taxexemption == single: wifeclaim set to 0, otherdep set to blank
    // if taxexemption == head: wifeclaim set to 0
    // if taxexemption == married: otherdep set to blank
    if In_PhExemption = 'Single' then
      set In_PhWifeClaimAddEx=0;
      set In_PhOtherDepName=null;
      set In_PhOtherDepRelation=null;
      set In_PhOtherDepDOB=null
    elseif In_PhExemption = 'HeadOfFamily' then
      set In_PhWifeClaimAddEx=0
    elseif In_PhExemption = 'Married' then
      set In_PhOtherDepName=null;
      set In_PhOtherDepRelation=null;
      set In_PhOtherDepDOB=null
    end if;
    update PhTaxRecord set
      PhEmployerId = In_PhEmployerId,
      PhTaxPolicyId = In_PhTaxPolicyId,
      PhFromPeriod = In_PhFromPeriod,
      PhToPeriod = In_PhToPeriod,
      PhExemption = In_PhExemption,
      PhDependentNo = In_PhDependentNo,
      PhWifeClaimAddEx = In_PhWifeClaimAddEx,
      PhOtherDepName = In_PhOtherDepName,
      PhOtherDepRelation = In_PhOtherDepRelation,
      PhOtherDepDOB = In_PhOtherDepDOB,
      PhPresERMainER = In_PhPresERMainER,
      PhNonTaxBonus = In_PhNonTaxBonus,
      PhGovtFundContri = In_PhGovtFundContri,
      PhNonTaxSalary = In_PhNonTaxSalary,
      PhTotalNonTaxable = In_PhTotalNonTaxable,
      PhTaxSalary = In_PhTaxSalary,
      PhRepresentation = In_PhRepresentation,
      PhTransport = In_PhTransport,
      PhCostLiving = In_PhCostLiving,
      PhHousing = In_PhHousing,
      PhRegOTShift = In_PhRegOTShift,
      PhRegularOthers = In_PhRegularOthers,
      PhCommission = In_PhCommission,
      PhProfitShare = In_PhProfitShare,
      PhFees = In_PhFees,
      PhTaxBonus = In_PhTaxBonus,
      PhHazardPay = In_PhHazardPay,
      PhSupplementOthers = In_PhSupplementOthers,
      PhPresTaxable = In_PhPresTaxable,
      PhPrevTaxable = In_PhPrevTaxable,
      PhTotalExemption = In_PhTotalExemption,
      PhInsurance = In_PhInsurance,
      PhActualTaxable = In_PhActualTaxable,
      PhTaxDue = In_PhTaxDue,
      PhPresentERTax = In_PhPresentERTax,
      PhPreviousERTax = In_PhPreviousERTax,
      PhTaxWithheld = In_PhTaxWithheld,
      PhCTCNo = In_PhCTCNo,
      PhCTCPlaceIssue = In_PhCTCPlaceIssue,
      PhCTCDateIssue = In_PhCTCDateIssue,
      PhCTCPaidAmt = In_PhCTCPaidAmt,
      PhSMWPerDay = In_PhSMWPerDay,	
      PhSMWPerMonth = In_PhSMWPerMonth,	
      PhMWEOption = In_PhMWEOption,	
      PhBasicSalaryMWE = In_PhBasicSalaryMWE,	
      PhHolidayPayMWE = In_PhHolidayPayMWE,	
      PhOvertimePayMWE = In_PhOvertimePayMWE,	
      PhNightShiftMWE = In_PhNightShiftMWE,	
      PhHazardPayMWE = In_PhHazardPayMWE,
      PhDeMinimis = In_PhDeMinimis
     where
      PersonalSysId = In_PersonalSysId and
      PhTaxYear = In_PhTaxYear;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;

commit work;