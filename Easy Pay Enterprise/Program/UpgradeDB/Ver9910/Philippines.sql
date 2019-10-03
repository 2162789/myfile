create procedure dba.DeletePhTaxDetails(
in In_PersonalSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from PhTaxDetails where PhTaxDetails.PersonalSysId = In_PersonalSysId) then
    if exists(select* from PhTaxRecord where PhTaxRecord.PersonalSysId = In_PersonalSysId) then
      call DeletePhTaxRecordByPersonalSysId(In_PersonalSysId);
      commit work
    end if;
    delete from PhTaxDetails where PhTaxDetails.PersonalSysId = In_PersonalSysId;
    commit work;
    if exists(select* from PhTaxDetails where PhTaxDetails.PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeletePhTaxEmployer(
in In_PhEmployerId char(20),
out Out_ErrorCode integer)
begin
  delete from PhRemitMonth where PhEmployerId = In_PhEmployerId;
  delete from PhTaxEmployer where PhEmployerId = In_PhEmployerId;
  set Out_ErrorCode=1;
  commit work
end
;

Create procedure dba.DeletePhTaxPolicy(
in In_PhTaxPolicyId char(20),
out Out_ErrorCode integer)
begin
  delete from PhTaxComputation where
    PhTaxPolicySysId = any(select PhTaxPolicySysId from PhTaxPolicyProg where PhTaxPolicyId = In_PhTaxPolicyId);
  delete from PhTaxPolicyProg where PhTaxPolicyId = In_PhTaxPolicyId;
  delete from PhTaxPolicy where PhTaxPolicyId = In_PhTaxPolicyId;
  set Out_ErrorCode=1;
  commit work
end
;

create procedure dba.DeletePhTaxPolicyProg(
in In_PhTaxPolicySysId integer,
out Out_ErrorCode integer)
begin
  delete from PhTaxComputation where PhTaxPolicySysId = In_PhTaxPolicySysId;
  delete from PhTaxPolicyProg where PhTaxPolicySysId = In_PhTaxPolicySysId;
  set Out_ErrorCode=1;
  commit work
end
;

create procedure dba.InsertNewPhTaxDetails(
in In_PersonalSysId integer,
in In_PhTaxPolicyId char(20),
in In_PhEmployerId char(20),
in In_PhEETIN char(30),
in In_PhExemption char(20),
in In_PhWifeClaimAddEx smallint,
in In_PhRDOCode char(20),
in In_PhTaxMethod char(20),
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
      PhTaxMethod) values(
      In_PersonalSysId,
      In_PhTaxPolicyId,
      In_PhEmployerId,
      In_PhEETIN,
      In_PhExemption,
      In_PhWifeClaimAddEx,
      In_PhRDOCode,
      In_PhTaxMethod);
    commit work;
    if not exists(select* from PhTaxDetails where PhTaxDetails.PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewPhTaxEmployer(
in In_PhEmployerId char(20),
in In_PhRegisteredName char(100),
in In_PhERTIN char(30),
in In_PhRDOCode char(20),
in In_PhLineOfBusiness char(30),
in In_PhERCategory char(20),
in In_PhERAddress char(50),
in In_PostalCode char(6),
in In_TelephoneNo char(20),
out Out_ErrorCode integer)
begin
  if In_PhEmployerId is null then
    set Out_ErrorCode=-1;
    return
  end if;
  if not exists(select* from PhTaxEmployer where PhEmployerId = In_PhEmployerId) then
    insert into PhTaxEmployer(PhEmployerId,
      PhRegisteredName,
      PhERTIN,
      PhRDOCode,
      PhLineOfBusiness,
      PhERCategory,
      PhERAddress,
      PostalCode,
      TelephoneNo) values(
      In_PhEmployerId,
      In_PhRegisteredName,
      In_PhERTIN,
      In_PhRDOCode,
      In_PhLineOfBusiness,
      In_PhERCategory,
      In_PhERAddress,
      In_PostalCode,
      In_TelephoneNo);
    set Out_ErrorCode=1;
    commit work
  else
    set Out_ErrorCode=-2
  end if
end
;

create procedure dba.InsertNewPhTaxPolicy(
in In_PhTaxPolicyId char(20),
in In_PhTaxPolicyDesc char(100),
out Out_ErrorCode integer)
begin
  if In_PhTaxPolicyId is null then
    set Out_ErrorCode=-1;
    return
  end if;
  if not exists(select* from PhTaxPolicy where PhTaxPolicyId = In_PhTaxPolicyId) then
    insert into PhTaxPolicy(PhTaxPolicyId,
      PhTaxPolicyDesc) values(
      In_PhTaxPolicyId,
      In_PhTaxPolicyDesc);
    set Out_ErrorCode=1;
    commit work
  else
    set Out_ErrorCode=-2
  end if
end
;

create procedure dba.InsertNewPhTaxPolicyProg(
in In_PhTaxPolicyId char(20),
in In_PhTaxPolicyEffDate date,
in In_PhTaxBonusExceed double,
in In_PhSingleEx double,
in In_PhHeadEx double,
in In_PhMarriedEx double,
in In_PhDependentEx double,
in In_PhDependentMax double,
in In_PhInsuranceEx double,
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
      PhInsuranceEx) values(
      Out_ErrorCode,
      In_PhTaxPolicyId,
      In_PhTaxPolicyEffDate,
      In_PhTaxBonusExceed,
      In_PhSingleEx,
      In_PhHeadEx,
      In_PhMarriedEx,
      In_PhDependentEx,
      In_PhDependentMax,
      In_PhInsuranceEx);
    commit work
  else
    set Out_ErrorCode=-3
  end if
end
;

create procedure dba.UpdatePhTaxDetails(
in In_PersonalSysId integer,
in In_PhTaxPolicyId char(20),
in In_PhEmployerId char(20),
in In_PhEETIN char(30),
in In_PhExemption char(20),
in In_PhWifeClaimAddEx smallint,
in In_PhRDOCode char(20),
in In_PhTaxMethod char(20),
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
      PhTaxMethod = In_PhTaxMethod where
      PersonalSysId = In_PersonalSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdatePhTaxEmployer(
in In_PhEmployerId char(20),
in In_PhRegisteredName char(100),
in In_PhERTIN char(30),
in In_PhRDOCode char(20),
in In_PhLineOfBusiness char(30),
in In_ERCategory char(20),
in In_PhERAddress char(50),
in In_PostalCode char(6),
in In_TelephoneNo char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from PhTaxEmployer where PhEmployerId = In_PhEmployerId) then
    update PhTaxEmployer set
      PhRegisteredName = In_PhRegisteredName,
      PhERTIN = In_PhERTIN,
      PhRDOCode = In_PhRDOCode,
      PhLineOfBusiness = In_PhLineOfBusiness,
      PhERCategory = In_ERCategory,
      PhERAddress = In_PhERAddress,
      PostalCode = In_PostalCode,
      TelephoneNo = In_TelephoneNo where
      PhEmployerId = In_PhEmployerId;
    set Out_ErrorCode=1;
    commit work
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.UpdatePhTaxPolicy(
in In_PhTaxPolicyId char(20),
in In_PhTaxPolicyDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from PhTaxPolicy where PhTaxPolicyId = In_PhTaxPolicyId) then
    update PhTaxPolicy set
      PhTaxPolicyDesc = In_PhTaxPolicyDesc where
      PhTaxPolicyId = In_PhTaxPolicyId;
    set Out_ErrorCode=1;
    commit work
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.UpdatePhTaxPolicyProg(
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
      PhInsuranceEx = In_PhInsuranceEx where
      PhTaxPolicySysId = In_PhTaxPolicySysId;
    set Out_ErrorCode=1;
    commit work
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.ASQLPhDependentFromFamily(
in In_PersonalSysId integer,
in In_PhTaxYear integer)
begin
  delete from PhDependent where PersonalSysId = In_PersonalSysId and PhTaxYear = In_PhTaxYear;
  insert into PhDependent(PersonalSysId,PhTaxYear,PhDependName,PhDependDOB)
    select In_PersonalSysId,In_PhTaxYear,PersonName,DOB from
      Family where
      PersonalSysId = In_PersonalSysId and
      ((In_PhTaxYear-Year(DOB) <= 21 and
      (RelationshipId = 'Son' or RelationshipId = 'Step Son' or
      RelationshipId = 'Daughter' or RelationshipId = 'Step Daughter')) or
      IsHandicapped = 1);
  commit work
end
;

create procedure dba.DeletePhTaxEmployee(
in In_PersonalSysId integer,
in In_PhTaxYear integer,
in In_PhTaxEESysId integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from PhTaxEmployee where PersonalSysId = In_PersonalSysId and PhTaxYear = In_PhTaxYear and PhTaxEESysId = In_PhTaxEESysId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    delete from PhTaxEmployee where
      PersonalSysId = In_PersonalSysId and
      PhTaxYear = In_PhTaxYear and
      PhTaxEESysId = In_PhTaxEESysId
  end if;
  if exists(select* from PhTaxEmployee where PersonalSysId = In_PersonalSysId and PhTaxYear = In_PhTaxYear and PhTaxEESysId = In_PhTaxEESysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.DeletePhTaxRecord(
in In_PersonalSysId integer,
in In_PhTaxYear integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from PhTaxRecord where PersonalSysId = In_PersonalSysId and PhTaxYear = In_PhTaxYear) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    delete from PhDependent where
      PersonalSysId = In_PersonalSysId and
      PhTaxYear = In_PhTaxYear;
    delete from PhPrevEmployer where
      PersonalSysId = In_PersonalSysId and
      PhTaxYear = In_PhTaxYear;
    delete from PhTaxEmployee where
      PersonalSysId = In_PersonalSysId and
      PhTaxYear = In_PhTaxYear;
    delete from PhTaxATC where
      PersonalSysId = In_PersonalSysId and
      PhTaxYear = In_PhTaxYear;
    delete from PhTaxRecord where
      PersonalSysId = In_PersonalSysId and
      PhTaxYear = In_PhTaxYear;
    commit work
  end if;
  if exists(select* from PhTaxRecord where PersonalSysId = In_PersonalSysId and PhTaxYear = In_PhTaxYear) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.DeletePhTaxRecordByPersonalSysId(
in In_PersonalSysId integer)
begin
  if exists(select* from PhTaxRecord where PersonalSysId = In_PersonalSysId) then
    delete from PhDependent where PersonalSysId = In_PersonalSysId;
    delete from PhPrevEmployer where PersonalSysId = In_PersonalSysId;
    delete from PhTaxEmployee where PersonalSysId = In_PersonalSysId;
    delete from PhTaxATC where PersonalSysId = In_PersonalSysId;
    delete from PhTaxRecord where PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create function DBA.FGetPhExemptionStatusFormat(
in In_PersonalSysId integer,
in In_PhTaxYear integer)
returns char(10)
begin
  declare Out_ExemptionStatusFormatted char(10);
  declare PhExemption char(20);
  declare PhDependentNo integer;
  declare ExemptionStatusShortForm char(10);
  select PhExemption,PhDependentNo into PhExemption,
    PhDependentNo from PhTaxRecord where
    PersonalSysId = In_PersonalSysId and PhTaxYear = In_PhTaxYear;
  case PhExemption when 'Single' then
    set ExemptionStatusShortForm='S' when 'HeadOfFamily' then
    set ExemptionStatusShortForm='HF' when 'Married' then
    set ExemptionStatusShortForm='ME'
  else
    set ExemptionStatusShortForm=''
  end case
  ;
  if PhDependentNo > 0 and ExemptionStatusShortForm <> 'S' then
    set Out_ExemptionStatusFormatted=ExemptionStatusShortForm || PhDependentNo
  else
    set Out_ExemptionStatusFormatted=ExemptionStatusShortForm
  end if;
  return Out_ExemptionStatusFormatted
end
;


create procedure dba.InsertNewPhTaxEmployee(
in In_PersonalSysId integer,
in In_PhTaxYear integer,
in In_PhTaxEESysId integer,
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
  if exists(select* from PhTaxEmployee where PersonalSysId = In_PersonalSysId and PhTaxYear = In_PhTaxYear and PhTaxEESysId = In_PhTaxEESysId) then
    set Out_ErrorCode=-1; // Record exists
    return
  elseif not In_PersonalSysId = any(select PersonalSysId from Personal) then
    set Out_ErrorCode=-2; // PersonalSysId not exist
    return
  else
    insert into PhTaxEmployee(PersonalSysId,
      PhTaxYear,PhTaxEESysId,FromPayRecYear,
      FromPayRecPeriod,FromPayRecSubPeriod,ToPayRecYear,
      ToPayRecPeriod,ToPayRecSubPeriod,PayRecID,
      TaxLastProcessed) values(
      In_PersonalSysId,In_PhTaxYear,In_PhTaxEESysId,In_FromPayRecYear,
      In_FromPayRecPeriod,In_FromPayRecSubPeriod,In_ToPayRecYear,
      In_ToPayRecPeriod,In_ToPayRecSubPeriod,In_PayRecID,
      In_TaxLastProcessed);
    commit work
  end if;
  if not exists(select* from PhTaxEmployee where PersonalSysId = In_PersonalSysId and PhTaxYear = In_PhTaxYear and PhTaxEESysId = In_PhTaxEESysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.InsertNewPhTaxRecord(
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
      PhCTCPaidAmt) values(
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
      In_PhCTCPaidAmt);
    commit work
  end if;
  if not exists(select* from PhTaxRecord where PersonalSysId = In_PersonalSysId and PhTaxYear = In_PhTaxYear) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.UpdatePhTaxEmployee(
in In_PersonalSysId integer,
in In_PhTaxYear integer,
in In_PhTaxEESysId integer,
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
  if not exists(select* from PhTaxEmployee where PersonalSysId = In_PersonalSysId and PhTaxYear = In_PhTaxYear and PhTaxEESysId = In_PhTaxEESysId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    update PhTaxEmployee set
      FromPayRecYear = In_FromPayRecYear,
      FromPayRecPeriod = In_FromPayRecPeriod,FromPayRecSubPeriod = In_FromPayRecSubPeriod,
      ToPayRecYear = In_ToPayRecYear,
      ToPayRecPeriod = In_ToPayRecPeriod,ToPayRecSubPeriod = In_ToPayRecSubPeriod,
      PayRecID = In_PayRecID,
      TaxLastProcessed = In_TaxLastProcessed where
      PersonalSysId = In_PersonalSysId and
      PhTaxYear = In_PhTaxYear and
      PhTaxEESysId = In_PhTaxEESysId;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;

create procedure dba.UpdatePhTaxRecord(
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
      PhCTCPaidAmt = In_PhCTCPaidAmt where
      PersonalSysId = In_PersonalSysId and
      PhTaxYear = In_PhTaxYear;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;

create procedure dba.ASQLCreatePhTaxATC(
in In_PersonalSysId integer,
in In_PhTaxYear integer,
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  PhATCCodeLoop: for PhATCCodeFor as PhATCCodeCurs dynamic scroll cursor for
    select PhATCCode as In_PhATCCode from PhATCCode where PhATCIsHistory = 0 do
    FormulaIdLoop: for FormulaIdFor as FormulaIdCurs dynamic scroll cursor for
      select Formula.FormulaId as In_FormulaId from Formula join
        FormulaProperty on FormulaProperty.FormulaId = Formula.FormulaId join
        PhATCFormula on PhATCFormula.PhATCFormulaId = Formula.FormulaId where
        PhATCCode = In_PhATCCode and
        KeyWordId = 'ATCCode' do
      CreatePhTaxATCLoop: for CreatePhTaxATCFor as CreatePhTaxATCCurs dynamic scroll cursor for
        select AllowanceSGSPGenId as In_AllowanceSGSPGenId from AllowanceRecord where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_PayRecYear and
          PayRecPeriod = In_PayRecPeriod and
          PayRecSubPeriod = In_PayRecSubPeriod and
          PayRecID = In_PayRecID and
          AllowanceFormulaId = In_FormulaId do
        call InsertNewPhTaxATC(
        In_PersonalSysId,
        In_PhTaxYear,
        In_EmployeeSysId,
        In_AllowanceSGSPGenId,
        In_PhATCCode) end for end for end for
end
;

create procedure dba.ASQLUpdatePhTaxATC(
in In_PersonalSysId integer,
in In_PhTaxYear integer,
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  declare In_PhTaxPolicySysId integer;
  declare In_PhATCRate double;
  declare In_PhATCFactor double;
  select first PhTaxPolicySysId into In_PhTaxPolicySysId from PhTaxDetails join PhTaxPolicyProg on PhTaxPolicyProg.PhTaxPolicyId = PhTaxDetails.PhTaxPolicyId where
    PhTaxDetails.PersonalSysId = In_PersonalSysId and
    PhTaxPolicyProg.PhTaxPolicyEffDate <= Str(In_PhTaxYear)+'-12-31' order by
    PhTaxPolicyProg.PhTaxPolicyEffDate desc;
  PhATCCodeLoop: for PhATCCodeFor as PhATCCodeCurs dynamic scroll cursor for
    select PhATCCode as In_PhATCCode from PhATCCode where PhATCIsHistory = 0 do
    select PhATCRate,PhATCFactor into In_PhATCRate,In_PhATCFactor from PhATCProg where
      PhTaxPolicySysId = In_PhTaxPolicySysId and
      PhATCCode = In_PhATCCode;
    UpdatePhTaxATCLoop: for UpdatePhTaxATCFor as UpdatePhTaxATCCurs dynamic scroll cursor for
      select PhTaxATCSysId as In_PhTaxATCSysId from
        PhTaxATC join AllowanceRecord on AllowanceRecord.AllowanceSGSPGenId = PhTaxATC.PhTaxATCSGSPGenId where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID and
        PhATCCode = In_PhATCCode do
      update PhTaxATC set
        PhATCHistRate = In_PhATCRate,
        PhATCHistFactor = In_PhATCFactor where current of UpdatePhTaxATCCurs end for end for;
  commit work
end
;

create procedure dba.ASQLRecalPhTaxATC(
in In_PersonalSysId integer,
in In_PhTaxYear integer,
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  declare In_PhATCTaxAmt double;
  RecalPhTaxATCLoop: for RecalPhTaxATCFor as curs dynamic scroll cursor for
    select AllowanceAmount as In_AllowanceAmt,
      PhTaxATCSysId as In_PhTaxATCSysId,
      PhATCHistRate as In_PhATCHistRate,
      PhATCHistFactor as In_PhATCHistFactor from
      PhTaxATC join AllowanceRecord on AllowanceRecord.AllowanceSGSPGenId = PhTaxATC.PhTaxATCSGSPGenId where
      EmployeeSysid = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID do
    set In_PhATCTaxAmt=Round(In_AllowanceAmt*In_PhATCHistFactor*(In_PhATCHistRate/100),FGetDBPayDecimal(*));
    update PhTaxATC set
      PhATCTaxAmt = In_PhATCTaxAmt where
      PhTaxATCSysId = In_PhTaxATCSysId end for;
  commit work
end
;

create procedure dba.InsertNewPhTaxATC(
in In_PersonalSysId integer,
in In_PhTaxYear integer,
in In_PhTaxATCEESysId integer,
in In_PhTaxATCSGSPGenId char(30),
in In_PhATCCode char(20),
out Out_ErrorCode integer)
begin
  declare In_PhTaxPolicySysId integer;
  declare In_PhATCRate double;
  declare In_PhATCFactor double;
  if exists(select* from PhTaxATC where PersonalSysId = In_PersonalSysId and
      PhTaxYear = In_PhTaxYear and
      PhTaxATCEESysId = In_PhTaxATCEESysId and
      PhTaxATCSGSPGenId = In_PhTaxATCSGSPGenId) then
    set Out_ErrorCode=-1; // Record exists
    return
  elseif not In_PersonalSysId = any(select PersonalSysId from Personal) then
    set Out_ErrorCode=-2; // PersonalSysId not exist
    return
  else
    select first PhTaxPolicySysId into In_PhTaxPolicySysId from PhTaxDetails join PhTaxPolicyProg on PhTaxPolicyProg.PhTaxPolicyId = PhTaxDetails.PhTaxPolicyId where
      PhTaxDetails.PersonalSysId = In_PersonalSysId and
      PhTaxPolicyProg.PhTaxPolicyEffDate <= Str(In_PhTaxYear)+'-12-31' order by
      PhTaxPolicyProg.PhTaxPolicyEffDate desc;
    select PhATCRate,PhATCFactor into In_PhATCRate,In_PhATCFactor from PhATCProg where
      PhTaxPolicySysId = In_PhTaxPolicySysId and
      PhATCCode = In_PhATCCode;
    if(In_PhATCRate is null) then
      set In_PhATCRate=0
    end if;
    if(In_PhATCFactor is null) then
      set In_PhATCFactor=0
    end if;
    insert into PhTaxATC(PersonalSysId,
      PhTaxYear,
      PhTaxATCEESysId,
      PhTaxATCSGSPGenId,
      PhATCCode,
      PhATCTaxAmt,
      PhATCHistRate,
      PhATCHistFactor) values(
      In_PersonalSysId,
      In_PhTaxYear,
      In_PhTaxATCEESysId,
      In_PhTaxATCSGSPGenId,
      In_PhATCCode,0,
      In_PhATCRate,
      In_PhATCFactor);
    commit work
  end if;
  if not exists(select* from PhTaxATC where PersonalSysId = In_PersonalSysId and
      PhTaxYear = In_PhTaxYear and
      PhTaxATCEESysId = In_PhTaxATCEESysId and
      PhTaxATCSGSPGenId = In_PhTaxATCSGSPGenId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.UpdatePhATCCode(
in In_PhATCCode char(20),
in In_PhATCDesc char(100),
in In_PhATCIsCorporate smallint,
in In_PhATCIsHistory smallint,
out Out_ErrorCode integer)
begin
  if exists(select* from PhATCCode where PhATCCode.PhATCCode = In_PhATCCode) then
    update PhATCCode set
      PhATCDesc = In_PhATCDesc,
      PhATCIsCorporate = In_PhATCIsCorporate,
      PhATCIsHistory = In_PhATCIsHistory where
      PhATCCode = In_PhATCCode;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeletePhATCCode(
in In_PhATCCode char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from PhATCCode where PhATCCode.PhATCCode = In_PhATCCode) then
    if not exists(select* from PhTaxATC where PhTaxATC.PhATCCode = In_PhATCCode) then
      if not exists(select* from PhATCProg where PhATCProg.PhATCCode = In_PhATCCode) then
        if exists(select* from PhATCFormula where PhATCFormula.PhATCCode = In_PhATCCode) then
          delete from PhATCFormula where PhATCFormula.PhATCCode = In_PhATCCode;
          commit work
        end if;
        delete from PhATCCode where PhATCCode.PhATCCode = In_PhATCCode;
        commit work;
        if exists(select* from PhATCCode where PhATCCode.PhATCCode = In_PhATCCode) then
          set Out_ErrorCode=0
        else
          set Out_ErrorCode=1
        end if
      else
        set Out_ErrorCode=0 //Progression exists with same PhATCCode
      end if
    else
      set Out_ErrorCode=0 //Tax Record exists with same PhATCCode
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewPhATCCode(
in In_PhATCCode char(20),
in In_PhATCDesc char(100),
in In_PhATCIsCorporate smallint,
in In_PhATCIsHistory smallint,
out Out_ErrorCode integer)
begin
  if not exists(select* from PhATCCode where PhATCCode.PhATCCode = In_PhATCCode) then
    insert into PhATCCode(PhATCCode,
      PhATCDesc,
      PhATCIsCorporate,
      PhATCIsHistory) values(
      In_PhATCCode,
      In_PhATCDesc,
      In_PhATCIsCorporate,
      In_PhATCIsHistory);
    commit work;
    if not exists(select* from PhATCCode where PhATCCode.PhATCCode = In_PhATCCode) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create function DBA.FGetPh1601CAdjustments(
in In_Ph1601CYear integer,
in In_Ph1601CMth char(20))
returns double
begin
  declare Out_Adjustments double;
  select sum(PhCurrYrAdj+PhYrEndAdj) into Out_Adjustments from Ph1601CSectionA where Ph1601CYear = In_Ph1601CYear and Ph1601CMth = In_Ph1601CMth;
  if(Out_Adjustments is null) then set Out_Adjustments=0
  end if;
  return Out_Adjustments
end
;

create function dba.FGetHDMFP24UseCode(
in In_CessationCode char(20))
returns char(20)
begin
  declare Out_HDMFP24UseCode char(20);
  if exists(select* from HDMFP2_4UseCodeMapping where EPECessationCode = In_CessationCode) then
    select HDMFP24UseCode into Out_HDMFP24UseCode from HDMFP2_4UseCodeMapping where
      EPECessationCode = In_CessationCode
  else
    set Out_HDMFP24UseCode=''
  end if;
  return Out_HDMFP24UseCode
end
;

create function DBA.FGETPhEmploymentStatusByPeriod(
in In_EmployeeSysId integer,
in In_Year integer,
in In_Period integer) 
returns char(10)
begin
  declare Out_EmploymentStatus char(10);
  declare Hire_Date date;
  declare Cessation_Date date;
  select HireDate,CessationDate into Hire_Date,
    Cessation_Date from Employee where EmployeeSysId = In_EmployeeSysId;
  if YEAR(Cessation_Date) = In_Year and MONTH(Cessation_Date) = In_Period then
    set Out_EmploymentStatus='SP'
  elseif YEAR(Hire_Date) = In_Year and MONTH(Hire_Date) = In_Period then
    set Out_EmploymentStatus='NH'
  else
    set Out_EmploymentStatus='NE'
  end if;
  return Out_EmploymentStatus
end
;

create function dba.FGetPhME5SumDatePaid(
in In_Year integer,
in In_Period integer)
returns date
begin
  declare Out_ME5SumDatePaid date;
  select ME5SumDatePaid into Out_ME5SumDatePaid from PHICRF1ME5Summary where
    PHICRF1ME5Summary.ME5SumYear = In_Year and
    SUBSTRING(PHICRF1ME5Summary.ME5SumMonthKeyWord,Length(PHICRF1ME5Summary.ME5SumMonthKeyWord)-1,2) = In_Period;
  return(Out_ME5SumDatePaid)
end
;

create function dba.FGetPhME5SumME5ReconNo(
in In_Year integer,
in In_Period integer)
returns char(20)
begin
  declare Out_ME5SumME5ReconNo char(20);
  select ME5SumME5ReconNo into Out_ME5SumME5ReconNo from PHICRF1ME5Summary where
    PHICRF1ME5Summary.ME5SumYear = In_Year and
    SUBSTRING(PHICRF1ME5Summary.ME5SumMonthKeyWord,Length(PHICRF1ME5Summary.ME5SumMonthKeyWord)-1,2) = In_Period;
  return(Out_ME5SumME5ReconNo)
end
;

create function DBA.FGetPhTaxYearResidenceType(
in In_PersonalSysId integer,
in In_TaxYear integer) 
returns char(100)
begin
  declare Out_ResidenceTypeId char(100);
  select first ResidenceTypeId into Out_ResidenceTypeId from ResidenceStatusRecord where
    PersonalSysId = In_PersonalSysId and
    Year(ResStatusEffectiveDate) <= In_TaxYear order by
    ResStatusEffectiveDate desc;
  if(Out_ResidenceTypeId is null) then
    return ''
  end if;
  return(Out_ResidenceTypeId)
end
;

