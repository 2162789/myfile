if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdatePhTaxATC') then
   drop procedure ASQLUpdatePhTaxATC
end if
;


CREATE PROCEDURE "DBA"."ASQLUpdatePhTaxATC"(
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
        PhATCHistFactor = In_PhATCFactor where PhTaxATC.PhTaxATCSysId = In_PhTaxATCSysId;

    end for 
  
  end for;
  commit work;
end
;