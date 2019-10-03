if not exists(select 1 from BankSubmit where BankSubmitSubmitForId='SSS Loan') then
Insert into BankSubmit(BankSubmitSubmitForId,BankSubmitSubmitForDesc) Values('SSS Loan','SSS Loan');
end if;

if not exists(select 1 from BankSubmitFormat where BankSubmitSubmitForId='SSS Loan' and FormatName='Security Bank') then
Insert into BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,IsCustomised) Values('SSS Loan','Security Bank','RPhilipBankFormatSecurityBank.dll','InvokeSSSLoanFormatter',0);
end if;

if not exists(select 1 from BankSubmit where BankSubmitSubmitForId='HDMF MCL') then
Insert into BankSubmit(BankSubmitSubmitForId,BankSubmitSubmitForDesc) Values('HDMF MCL','HDMF MCL');
end if;

if not exists(select 1 from BankSubmitFormat where BankSubmitSubmitForId='HDMF MCL' and FormatName='Security Bank') then
Insert into BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,IsCustomised) Values('HDMF MCL','Security Bank','RPhilipBankFormatSecurityBank.dll','InvokeHDMFMCLFormatter',0);
end if;

if not exists(select 1 from BankSubmit where BankSubmitSubmitForId='SSS MCL / EPF') then
Insert into BankSubmit(BankSubmitSubmitForId,BankSubmitSubmitForDesc) Values('SSS MCL / EPF','SSS MCL / EPF');
end if;

if not exists(select 1 from BankSubmitFormat where BankSubmitSubmitForId='SSS MCL / EPF' and FormatName='Security Bank') then
Insert into BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,IsCustomised) Values('SSS MCL / EPF','Security Bank','RPhilipBankFormatSecurityBank.dll','InvokeSSSMCLFormatter',0);
end if;

// PH Tax Incentives for Benefactors
update PhTaxPolicyProg set PhTaxIncentivesEx = 25000 where PhTaxPolicyId = 'Default' and PhTaxPolicyEffDate = '2015-01-01';
update PhTaxPolicyProg set PhTaxIncentivesEx = 0 where PhTaxIncentivesEx is null;
update PhTaxDetails set PhTaxIncentivesEx = 0 where PhTaxIncentivesEx is null;
update PhTaxRecord set PhTaxIncentivesEx = 0 where PhTaxIncentivesEx is null;

if exists (select 1 from sys.sysprocedure where proc_name = 'InsertNewPhTaxPolicyProg') then
  drop procedure InsertNewPhTaxPolicyProg
end if;
create procedure "DBA"."InsertNewPhTaxPolicyProg"(
in In_PhTaxPolicyId char(20),
in In_PhTaxPolicyEffDate date,
in In_PhTaxBonusExceed double,
in In_PhSingleEx double,
in In_PhHeadEx double,
in In_PhMarriedEx double,
in In_PhDependentEx double,
in In_PhDependentMax double,
in In_PhInsuranceEx double,
in In_PhTaxIncentivesEx double,
out Out_ErrorCode integer)
begin
  declare max_progsysid integer;
  if In_PhTaxPolicyId is null then
    set Out_ErrorCode=-1;
    return
  end if;
  if In_PhTaxPolicyEffDate is null then
    set Out_ErrorCode=-2;
    return
  end if;
  if not exists(select* from PhTaxPolicyProg where PhTaxPolicyId = In_PhTaxPolicyId and PhTaxPolicyEffDate = In_PhTaxPolicyEffDate) then
    if exists(select* from PhTaxPolicyProg) then
      select max(PhTaxPolicySysId) into max_progsysid from PhTaxPolicyProg;
      set Out_ErrorCode=max_progsysid+1
    else
      set Out_ErrorCode=1
    end if;
    insert into PhTaxPolicyProg(PhTaxPolicySysId,
      PhTaxPolicyId,
      PhTaxPolicyEffDate,
      PhTaxBonusExceed,
      PhSingleEx,
      PhHeadEx,
      PhMarriedEx,
      PhDependentEx,
      PhDependentMax,
      PhInsuranceEx,
      PhTaxIncentivesEx) values(
      Out_ErrorCode,
      In_PhTaxPolicyId,
      In_PhTaxPolicyEffDate,
      In_PhTaxBonusExceed,
      In_PhSingleEx,
      In_PhHeadEx,
      In_PhMarriedEx,
      In_PhDependentEx,
      In_PhDependentMax,
      In_PhInsuranceEx,
      In_PhTaxIncentivesEx);
    commit work
  else
    set Out_ErrorCode=-3
  end if
end;

if exists (select 1 from sys.sysprocedure where proc_name = 'UpdatePhTaxPolicyProg') then
  drop procedure UpdatePhTaxPolicyProg
end if;
create procedure "DBA"."UpdatePhTaxPolicyProg"(
in In_PhTaxPolicySysId integer,
in In_PhTaxPolicyId char(20),
in In_PhTaxPolicyEffDate date,
in In_PhTaxBonusExceed double,
in In_PhSingleEx double,
in In_PhHeadEx double,
in In_PhMarriedEx double,
in In_PhDependentEx double,
in In_PhDependentMax double,
in In_PhInsuranceEx double,
in In_PhTaxIncentivesEx double,
out Out_ErrorCode integer)
begin
  if exists(select* from PhTaxPolicyProg where PhTaxPolicySysId = In_PhTaxPolicySysId) then
    update PhTaxPolicyProg set
      PhTaxPolicyId = In_PhTaxPolicyId,
      PhTaxPolicyEffDate = In_PhTaxPolicyEffDate,
      PhTaxBonusExceed = In_PhTaxBonusExceed,
      PhSingleEx = In_PhSingleEx,
      PhHeadEx = In_PhHeadEx,
      PhMarriedEx = In_PhMarriedEx,
      PhDependentEx = In_PhDependentEx,
      PhDependentMax = In_PhDependentMax,
      PhInsuranceEx = In_PhInsuranceEx,
      PhTaxIncentivesEx = In_PhTaxIncentivesEx where
      PhTaxPolicySysId = In_PhTaxPolicySysId;
    set Out_ErrorCode=1;
    commit work
  else
    set Out_ErrorCode=-1
  end if
end;

if exists (select 1 from sys.sysprocedure where proc_name = 'InsertNewPhTaxDetails') then
  drop procedure InsertNewPhTaxDetails
end if;
create procedure "DBA"."InsertNewPhTaxDetails"(
in In_PersonalSysId integer,
in In_PhTaxPolicyId char(20),
in In_PhEmployerId char(20),
in In_PhEETIN char(30),
in In_PhExemption char(20),
in In_PhWifeClaimAddEx smallint,
in In_PhRDOCode char(20),
in In_PhTaxMethod char(20),
in In_PhMWEOption smallint,
in In_PhTaxIncentivesEx smallint,
out Out_ErrorCode integer)
begin
  if not exists(select* from PhTaxDetails where PhTaxDetails.PersonalSysId = In_PersonalSysId) then
    insert into PhTaxDetails(PersonalSysId,
      PhTaxPolicyId,
      PhEmployerId,
      PhEETIN,
      PhExemption,
      PhWifeClaimAddEx,
      PhRDOCode,
      PhTaxMethod,
      PhMWEOption,
      PhTaxIncentivesEx) values(
      In_PersonalSysId,
      In_PhTaxPolicyId,
      In_PhEmployerId,
      In_PhEETIN,
      In_PhExemption,
      In_PhWifeClaimAddEx,
      In_PhRDOCode,
      In_PhTaxMethod,
      In_PhMWEOption,
      In_PhTaxIncentivesEx);
    commit work;
    if not exists(select* from PhTaxDetails where PhTaxDetails.PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end;

if exists (select 1 from sys.sysprocedure where proc_name = 'UpdatePhTaxDetails') then
  drop procedure UpdatePhTaxDetails
end if;
create procedure "DBA"."UpdatePhTaxDetails"(
in In_PersonalSysId integer,
in In_PhTaxPolicyId char(20),
in In_PhEmployerId char(20),
in In_PhEETIN char(30),
in In_PhExemption char(20),
in In_PhWifeClaimAddEx smallint,
in In_PhRDOCode char(20),
in In_PhTaxMethod char(20),
in In_PhMWEOption smallint,
in In_PhTaxIncentivesEx smallint,
out Out_ErrorCode integer)
begin
  if exists(select* from PhTaxDetails where PhTaxDetails.PersonalSysId = In_PersonalSysId) then
    update PhTaxDetails set
      PhTaxPolicyId = In_PhTaxPolicyId,
      PhEmployerId = In_PhEmployerId,
      PhEETIN = In_PhEETIN,
      PhExemption = In_PhExemption,
      PhWifeClaimAddEx = In_PhWifeClaimAddEx,
      PhRDOCode = In_PhRDOCode,
      PhTaxMethod = In_PhTaxMethod,
      PhMWEOption = In_PhMWEOption,
      PhTaxIncentivesEx = In_PhTaxIncentivesEx where
      PersonalSysId = In_PersonalSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end;

if exists (select 1 from sys.sysprocedure where proc_name = 'InsertNewPhTaxRecord') then
  drop procedure InsertNewPhTaxRecord
end if;
create procedure "DBA"."InsertNewPhTaxRecord"(
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
in In_PhTaxIncentivesEx smallint,
out Out_ErrorCode integer)
begin
  if exists(select* from PhTaxRecord where PersonalSysId = In_PersonalSysId and PhTaxYear = In_PhTaxYear) then
    set Out_ErrorCode=-1; // Record exists
    return
  elseif not In_PersonalSysId = any(select PersonalSysId from Personal) then
    set Out_ErrorCode=-2; // PersonalSysId not exist
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
    insert into PhTaxRecord(PersonalSysId,
      PhTaxYear,
      PhEmployerId,
      PhTaxPolicyId,
      PhFromPeriod,
      PhToPeriod,
      PhExemption,
      PhDependentNo,
      PhWifeClaimAddEx,
      PhOtherDepName,
      PhOtherDepRelation,
      PhOtherDepDOB,
      PhPresERMainER,
      PhNonTaxBonus,
      PhGovtFundContri,
      PhNonTaxSalary,
      PhTotalNonTaxable,
      PhTaxSalary,
      PhRepresentation,
      PhTransport,
      PhCostLiving,
      PhHousing,
      PhRegOTShift,
      PhRegularOthers,
      PhCommission,
      PhProfitShare,
      PhFees,
      PhTaxBonus,
      PhHazardPay,
      PhSupplementOthers,
      PhPresTaxable,
      PhPrevTaxable,
      PhTotalExemption,
      PhInsurance,
      PhActualTaxable,
      PhTaxDue,
      PhPresentERTax,
      PhPreviousERTax,
      PhTaxWithheld,
      PhCTCNo,
      PhCTCPlaceIssue,
      PhCTCDateIssue,
      PhCTCPaidAmt,
      PhSMWPerDay,	
      PhSMWPerMonth,	
      PhMWEOption,	
      PhBasicSalaryMWE,	
      PhHolidayPayMWE,	
      PhOvertimePayMWE,	
      PhNightShiftMWE,	
      PhHazardPayMWE,
      PhDeMinimis,
      PhTaxIncentivesEx
) values(
      In_PersonalSysId,
      In_PhTaxYear,
      In_PhEmployerId,
      In_PhTaxPolicyId,
      In_PhFromPeriod,
      In_PhToPeriod,
      In_PhExemption,
      In_PhDependentNo,
      In_PhWifeClaimAddEx,
      In_PhOtherDepName,
      In_PhOtherDepRelation,
      In_PhOtherDepDOB,
      In_PhPresERMainER,
      In_PhNonTaxBonus,
      In_PhGovtFundContri,
      In_PhNonTaxSalary,
      In_PhTotalNonTaxable,
      In_PhTaxSalary,
      In_PhRepresentation,
      In_PhTransport,
      In_PhCostLiving,
      In_PhHousing,
      In_PhRegOTShift,
      In_PhRegularOthers,
      In_PhCommission,
      In_PhProfitShare,
      In_PhFees,
      In_PhTaxBonus,
      In_PhHazardPay,
      In_PhSupplementOthers,
      In_PhPresTaxable,
      In_PhPrevTaxable,
      In_PhTotalExemption,
      In_PhInsurance,
      In_PhActualTaxable,
      In_PhTaxDue,
      In_PhPresentERTax,
      In_PhPreviousERTax,
      In_PhTaxWithheld,
      In_PhCTCNo,
      In_PhCTCPlaceIssue,
      In_PhCTCDateIssue,
      In_PhCTCPaidAmt,
      In_PhSMWPerDay,	
      In_PhSMWPerMonth,	
      In_PhMWEOption,	
      In_PhBasicSalaryMWE,	
      In_PhHolidayPayMWE,	
      In_PhOvertimePayMWE,	
      In_PhNightShiftMWE,	
      In_PhHazardPayMWE,
      In_PhDeMinimis,
      In_PhTaxIncentivesEx
    );
    commit work
  end if;
  if not exists(select* from PhTaxRecord where PersonalSysId = In_PersonalSysId and PhTaxYear = In_PhTaxYear) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end;

if exists (select 1 from sys.sysprocedure where proc_name = 'UpdatePhTaxRecord') then
  drop procedure UpdatePhTaxRecord
end if;
create procedure "DBA"."UpdatePhTaxRecord"(
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
in In_PhTaxIncentivesEx smallint,
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
    // if taxexemption == zero: wifeclaim set to 0
    // if taxexemption == married: otherdep set to blank
    if In_PhExemption = 'Zero' then
      set In_PhWifeClaimAddEx=0;
      set In_PhOtherDepName=null;
      set In_PhOtherDepRelation=null;
      set In_PhOtherDepDOB=null
    elseif In_PhExemption = 'HeadOfFamily' then
      set In_PhWifeClaimAddEx=0
    elseif In_PhExemption = 'Single' then
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
      PhDeMinimis = In_PhDeMinimis,
      PhTaxIncentivesEx = In_PhTaxIncentivesEx
     where
      PersonalSysId = In_PersonalSysId and
      PhTaxYear = In_PhTaxYear;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end;

commit work;