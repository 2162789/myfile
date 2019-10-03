if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPhTaxDetails') then
   drop procedure InsertNewPhTaxDetails
end if
;

CREATE PROCEDURE "DBA"."InsertNewPhTaxDetails"(
in In_PersonalSysId integer,
in In_PhTaxPolicyId char(20),
in In_PhEmployerId char(20),
in In_PhEETIN char(30),
in In_PhExemption char(20),
in In_PhWifeClaimAddEx smallint,
in In_PhRDOCode char(20),
in In_PhTaxMethod char(20),
in In_PhMWEOption smallint,
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
      PhMWEOption) values(
      In_PersonalSysId,
      In_PhTaxPolicyId,
      In_PhEmployerId,
      In_PhEETIN,
      In_PhExemption,
      In_PhWifeClaimAddEx,
      In_PhRDOCode,
      In_PhTaxMethod,
      In_PhMWEOption);
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

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePhTaxDetails') then
   drop procedure UpdatePhTaxDetails
end if
;

CREATE PROCEDURE "DBA"."UpdatePhTaxDetails"(
in In_PersonalSysId integer,
in In_PhTaxPolicyId char(20),
in In_PhEmployerId char(20),
in In_PhEETIN char(30),
in In_PhExemption char(20),
in In_PhWifeClaimAddEx smallint,
in In_PhRDOCode char(20),
in In_PhTaxMethod char(20),
in In_PhMWEOption smallint,
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
      PhMWEOption = In_PhMWEOption where
      PersonalSysId = In_PersonalSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePhTaxDetails') then
   drop procedure DeletePhTaxDetails
end if
;

CREATE PROCEDURE "DBA"."DeletePhTaxDetails"(
in In_PersonalSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from PhTaxDetails where PhTaxDetails.PersonalSysId = In_PersonalSysId) then
    if exists(select* from PhTaxRecord where PhTaxRecord.PersonalSysId = In_PersonalSysId) then
      call DeletePhTaxRecordByPersonalSysId(In_PersonalSysId);
      commit work
    end if;
    if exists(select* from DeMinimisGranted where DeMinimisGranted.PersonalSysId = In_PersonalSysId) then
      call DeleteDeMinimisGrantedByPersonalSysId(In_PersonalSysId);
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

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePhTaxPolicyProg') then
   drop procedure DeletePhTaxPolicyProg
end if
;

CREATE PROCEDURE "DBA"."DeletePhTaxPolicyProg"(
in In_PhTaxPolicySysId integer,
out Out_ErrorCode integer)
begin
  delete from PhTaxComputation where PhTaxPolicySysId = In_PhTaxPolicySysId;
  delete from DeMinimisSetup where PhTaxPolicySysId = In_PhTaxPolicySysId;
  delete from PhTaxPolicyProg where PhTaxPolicySysId = In_PhTaxPolicySysId;
  set Out_ErrorCode=1;
  commit work
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPhDeMinimisItem') then
   drop procedure InsertNewPhDeMinimisItem
end if
;

CREATE PROCEDURE "DBA"."InsertNewPhDeMinimisItem"(
in In_DMBItemId char(20),
in In_DMBProperty char(20),
in In_DMBDesc char(100),
out Out_ErrorCode integer)

BEGIN
  if not exists(select* from DeMinimisItem where DMBItemId = In_DMBItemID) then
    insert into DeMinimisItem(
      DMBItemId,
      DMBProperty,
      DMBDesc) values(
      In_DMBItemID,
      In_DMBProperty,
      In_DMBDesc);
    commit work;
    if not exists(select* from DeMinimisItem where DMBItemId = In_DMBItemID) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePhDeMinimisItem') then
   drop procedure UpdatePhDeMinimisItem
end if
;

CREATE PROCEDURE "DBA"."UpdatePhDeMinimisItem"(
in In_DMBItemId char(20),
in In_DMBProperty char(20),
in In_DMBDesc char(100),
out Out_ErrorCode integer)
BEGIN
    if exists(select* from DeMinimisItem where DMBItemId = In_DMBItemID) then
    update DeMinimisItem set DMBProperty = In_DMBProperty,
      DMBDesc = In_DMBDesc where
      DMBItemId = In_DMBItemID;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePhDeMinimisItem') then
   drop procedure DeletePhDeMinimisItem
end if
;

CREATE PROCEDURE "DBA"."DeletePhDeMinimisItem"(
in In_DMBItemId char(20), 
out Out_ErrorCode integer)
BEGIN
	 if exists(select* from DeMinimisItem where DMBItemId = In_DMBItemId) then
    delete from DeMinimisItem where DMBItemId = In_DMBItemId;
    commit work;
    if exists(select* from DeMinimisItem where DMBItemId = In_DMBItemId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewDeMinimisGranted') then
   drop procedure InsertNewDeMinimisGranted
end if
;

CREATE PROCEDURE "DBA"."InsertNewDeMinimisGranted"(
in In_PersonalSysId integer,
in In_DMBProperty char(20),
in In_DMBPayrollYear integer,
in In_DMBPayrollPeriod integer,
in In_DMBGrantedAmt double,
in In_DMBExceedingAmt double,
in In_CreatedBy char(1),
out Out_ErrorCode integer)
begin
  if not exists(select* from DeMinimisGranted where
    PersonalSysId = In_PersonalSysId and
    DMBProperty = In_DMBProperty and
    DMBPayrollYear = In_DMBPayrollYear and
    DMBPayrollPeriod = In_DMBPayrollPeriod and
    DMBGrantedAmt = In_DMBGrantedAmt and
    DMBExceedingAmt = In_DMBExceedingAmt and
    CreatedBy = In_CreatedBy)
  then
    insert into DeMinimisGranted(
        PersonalSysId,
        DMBProperty,
        DMBPayrollYear,
        DMBPayrollPeriod,
        DMBGrantedAmt,
        DMBExceedingAmt,
        CreatedBy
      ) values(
        In_PersonalSysId,
        In_DMBProperty,
        In_DMBPayrollYear,
        In_DMBPayrollPeriod,
        In_DMBGrantedAmt,
        In_DMBExceedingAmt,
        In_CreatedBy
        );
    commit work;
    if not exists(select* from DeMinimisGranted where
        PersonalSysId = In_PersonalSysId and
        DMBProperty = In_DMBProperty and
        DMBPayrollYear = In_DMBPayrollYear and
        DMBPayrollPeriod = In_DMBPayrollPeriod and
        DMBGrantedAmt = In_DMBGrantedAmt and
        DMBExceedingAmt = In_DMBExceedingAmt and
        CreatedBy = In_CreatedBy) then
      set Out_ErrorCode=0
    else
      select DMBGrantSysId into Out_ErrorCode from DeMinimisGranted where
        PersonalSysId = In_PersonalSysId and
        DMBProperty = In_DMBProperty and
        DMBPayrollYear = In_DMBPayrollYear and
        DMBPayrollPeriod = In_DMBPayrollPeriod and
        DMBGrantedAmt = In_DMBGrantedAmt and
        DMBExceedingAmt = In_DMBExceedingAmt and
        CreatedBy = In_CreatedBy
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateDeMinimisGranted') then
   drop procedure UpdateDeMinimisGranted
end if
;

CREATE PROCEDURE "DBA"."UpdateDeMinimisGranted"(
in In_DMBGrantSysId integer,
in In_PersonalSysId integer,
in In_DMBProperty char(20),
in In_DMBPayrollYear integer,
in In_DMBPayrollPeriod integer,
in In_DMBGrantedAmt double,
in In_DMBExceedingAmt double,
in In_CreatedBy char(1),
out Out_ErrorCode integer)
begin
  if exists(select* from DeMinimisGranted where
      DeMinimisGranted.DMBGrantSysId = In_DMBGrantSysId) then
    update DeMinimisGranted set
        PersonalSysId = In_PersonalSysId,
        DMBProperty = In_DMBProperty,
        DMBPayrollYear = In_DMBPayrollYear,
        DMBPayrollPeriod = In_DMBPayrollPeriod,
        DMBGrantedAmt = In_DMBGrantedAmt,
        DMBExceedingAmt = In_DMBExceedingAmt,
        CreatedBy = In_CreatedBy
    where
      DeMinimisGranted.DMBGrantSysId = In_DMBGrantSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteDeMinimisGranted') then
   drop procedure DeleteDeMinimisGranted
end if
;

CREATE PROCEDURE "DBA"."DeleteDeMinimisGranted"(
in In_DMBGrantSysId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from DeMinimisGranted where
      DeMinimisGranted.DMBGrantSysId = In_DMBGrantSysId) then
    delete from DeMinimisGranted where
      DeMinimisGranted.DMBGrantSysId = In_DMBGrantSysId;
    commit work
  end if;
  if exists(select* from DeMinimisGranted where
      DeMinimisGranted.DMBGrantSysId = In_DMBGrantSysId) then
    set Out_ErrorCode=0
  else
    set Out_ErrorCode=1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateDeMinimisRecurring') then
   drop procedure UpdateDeMinimisRecurring
end if
;

CREATE PROCEDURE "DBA"."UpdateDeMinimisRecurring"(
in In_DMBRecurSysId integer,
in In_DMBItemId	char(20),
in In_EmployeeSysId	integer,
in In_DMBStartYear double,
in In_DMBStartPeriod double,	
in In_DMBEndPeriod double,
in In_DMBAnnualAmount double,	
in In_DMBNoOfPayment double,	
in In_DMBPaymentPerSubPeriod double,	
in In_DMBPreviousPayment double,	
in In_Remarks char(100),	
out Out_ErrorCode integer)
begin
  if exists(select* from DMBRecurring where DMBRecurSysId = In_DMBRecurSysId) then
    update DMBRecurring set
        DMBItemId = In_DMBItemId,
        EmployeeSysId = In_EmployeeSysId,
        DMBStartYear = In_DMBStartYear,
        DMBStartPeriod = In_DMBStartPeriod,
        DMBEndPeriod = In_DMBEndPeriod,
        DMBAnnualAmount = In_DMBAnnualAmount,
        DMBNoOfPayment = In_DMBNoOfPayment,
        DMBPaymentPerSubPeriod = In_DMBPaymentPerSubPeriod,
        DMBPreviousPayment = In_DMBPreviousPayment,
        Remarks = In_Remarks
    where
      DMBRecurSysId = In_DMBRecurSysId;
    commit work;
    select DMBRecurSysId into Out_ErrorCode from DMBRecurring where DMBRecurSysId = In_DMBRecurSysId
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewDeMinimisRecurring') then
   drop procedure InsertNewDeMinimisRecurring
end if
;

CREATE PROCEDURE "DBA"."InsertNewDeMinimisRecurring"(
in In_DMBItemId	char(20),
in In_EmployeeSysId	integer,
in In_DMBStartYear double,
in In_DMBStartPeriod double,	
in In_DMBEndPeriod double,
in In_DMBAnnualAmount double,	
in In_DMBNoOfPayment double,	
in In_DMBPaymentPerSubPeriod double,	
in In_DMBPreviousPayment double,	
in In_Remarks char(100),	
out Out_ErrorCode integer
)
begin
  if not exists(select* from DMBRecurring where
    DMBItemId = In_DMBItemId and
    EmployeeSysId = In_EmployeeSysId and
    DMBStartYear = In_DMBStartYear and
    DMBStartPeriod = In_DMBStartPeriod and
    DMBEndPeriod = In_DMBEndPeriod and
    DMBAnnualAmount = In_DMBAnnualAmount and
    DMBNoOfPayment = In_DMBNoOfPayment and
    DMBPaymentPerSubPeriod = In_DMBPaymentPerSubPeriod and
    DMBPreviousPayment = In_DMBPreviousPayment and
    Remarks = In_Remarks
    ) then
        insert into DMBRecurring(
        DMBItemId,
        EmployeeSysId,
        DMBStartYear,
        DMBStartPeriod,
        DMBEndPeriod,
        DMBAnnualAmount,
        DMBNoOfPayment,
        DMBPaymentPerSubPeriod,
        DMBPreviousPayment,
        Remarks
        ) values(
        In_DMBItemId,
        In_EmployeeSysId,
        In_DMBStartYear,
        In_DMBStartPeriod,
        In_DMBEndPeriod,
        In_DMBAnnualAmount,
        In_DMBNoOfPayment,
        In_DMBPaymentPerSubPeriod,
        In_DMBPreviousPayment,
        In_Remarks
        );
    commit work;

    if not exists(select* from DMBRecurring where
        DMBItemId = In_DMBItemId and
        EmployeeSysId = In_EmployeeSysId and
        DMBStartYear = In_DMBStartYear and
        DMBStartPeriod = In_DMBStartPeriod and
        DMBEndPeriod = In_DMBEndPeriod and
        DMBAnnualAmount = In_DMBAnnualAmount and
        DMBNoOfPayment = In_DMBNoOfPayment and
        DMBPaymentPerSubPeriod = In_DMBPaymentPerSubPeriod and
        DMBPreviousPayment = In_DMBPreviousPayment and
        Remarks = In_Remarks) then
        set Out_ErrorCode=0
    else
        
        select DMBRecurSysId into Out_ErrorCode  from DMBRecurring where
        DMBItemId = In_DMBItemId and
        EmployeeSysId = In_EmployeeSysId and
        DMBStartYear = In_DMBStartYear and
        DMBStartPeriod = In_DMBStartPeriod and
        DMBEndPeriod = In_DMBEndPeriod and
        DMBAnnualAmount = In_DMBAnnualAmount and
        DMBNoOfPayment = In_DMBNoOfPayment and
        DMBPaymentPerSubPeriod = In_DMBPaymentPerSubPeriod and
        DMBPreviousPayment = In_DMBPreviousPayment and
        Remarks = In_Remarks
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteDeMinimisRecurring') then
   drop procedure DeleteDeMinimisRecurring
end if
;

CREATE PROCEDURE "DBA"."DeleteDeMinimisRecurring"(
in In_DMBRecurSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from DMBRecord where DMBRecurSysId = In_DMBRecurSysId) then
    set Out_ErrorCode=-2
  else  
      if exists(select* from DMBRecurring where DMBRecurSysId = In_DMBRecurSysId) then
        delete from DMBRecurring where DMBRecurSysId = In_DMBRecurSysId;
        commit work;
        if exists(select* from DMBRecurring where DMBRecurSysId = In_DMBRecurSysId) then
          set Out_ErrorCode=0
        else
          set Out_ErrorCode=1
        end if
      else
        set Out_ErrorCode=-1
      end if
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewDeMinimisRecord') then
   drop procedure InsertNewDeMinimisRecord
end if
;

CREATE PROCEDURE "DBA"."InsertNewDeMinimisRecord"
(
in In_DMBRecurSysId	integer,	
in In_DMBItemId	char(20),	
in In_EmployeeSysId	integer,	
in In_PayRecYear	integer,	
in In_PayRecPeriod	integer,	
in In_PayRecSubPeriod	integer,	
in In_PayRecID	char(20),	
in In_DMBAmount	double,
out Out_DMBRecSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  select FGetNewSGSPGeneratedIndex('DMBRecord') into Out_DMBRecSGSPGenId;
  insert into DMBRecord(
        DMBRecSGSPGenId,
        DMBRecurSysId,
        DMBItemId,
        EmployeeSysId,
        PayRecYear,
        PayRecPeriod,
        PayRecSubPeriod,
        PayRecID,
        DMBAmount
        ) values(
        Out_DMBRecSGSPGenId,
        In_DMBRecurSysId,
        In_DMBItemId,
        In_EmployeeSysId,
        In_PayRecYear,
        In_PayRecPeriod,
        In_PayRecSubPeriod,
        In_PayRecID,
        In_DMBAmount
        );
  commit work;
  if not exists(select* from DMBRecord where
      DMBRecSGSPGenId = Out_DMBRecSGSPGenId) then
    set Out_ErrorCode=0
  else
    set Out_ErrorCode=1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateDeMinimisRecord') then
   drop procedure UpdateDeMinimisRecord
end if
;

CREATE PROCEDURE "DBA"."UpdateDeMinimisRecord"(
in In_DMBRecSGSPGenId char(30),
in In_DMBRecurSysId	integer,	
in In_DMBItemId	char(20),	
in In_EmployeeSysId	integer,	
in In_PayRecYear	integer,	
in In_PayRecPeriod	integer,	
in In_PayRecSubPeriod	integer,	
in In_PayRecID	char(20),	
in In_DMBAmount	double, 
out Out_ErrorCode integer)
begin
  if exists(select* from DMBRecord where
      DMBRecord.DMBRecSGSPGenId = In_DMBRecSGSPGenId) then
    update DMBRecord set
        DMBRecurSysId = In_DMBRecurSysId,	
        DMBItemId = In_DMBItemId,	
        EmployeeSysId = In_EmployeeSysId,
        PayRecYear = In_PayRecYear,	
        PayRecPeriod = In_PayRecPeriod,	
        PayRecSubPeriod = In_PayRecSubPeriod,	
        PayRecID =  In_PayRecID,	
        DMBAmount =  In_DMBAmount
    where
      DMBRecord.DMBRecSGSPGenId = In_DMBRecSGSPGenId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteDeMinimisRecord') then
   drop procedure DeleteDeMinimisRecord
end if
;

CREATE PROCEDURE "DBA"."DeleteDeMinimisRecord"(
in In_DMBRecSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from DMBRecord where
      DMBRecord.DMBRecSGSPGenId = In_DMBRecSGSPGenId) then
    delete from DMBRecord where
      DMBRecord.DMBRecSGSPGenId = In_DMBRecSGSPGenId;
    commit work
  end if;
  if exists(select* from DMBRecord where
      DMBRecord.DMBRecSGSPGenId = In_DMBRecSGSPGenId) then
    set Out_ErrorCode=0
  else
    set Out_ErrorCode=1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteDeMinimisGrantedByPersonalSysId') then
   drop procedure DeleteDeMinimisGrantedByPersonalSysId
end if
;

CREATE PROCEDURE "DBA"."DeleteDeMinimisGrantedByPersonalSysId"(
in In_PersonalSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from DeMinimisGranted where
      DeMinimisGranted.PersonalSysId = In_PersonalSysId) then
    delete from DeMinimisGranted where
      DeMinimisGranted.PersonalSysId = In_PersonalSysId;
    commit work
  end if;
  if exists(select* from DeMinimisGranted where
      DeMinimisGranted.PersonalSysId = In_PersonalSysId) then
    set Out_ErrorCode=0
  else
    set Out_ErrorCode=1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteDeMinimisRecordByEmployeeSysId') then
   drop procedure DeleteDeMinimisRecordByEmployeeSysId
end if
;

CREATE PROCEDURE "DBA"."DeleteDeMinimisRecordByEmployeeSysId"(
in In_EmployeeSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from DMBRecord where
      DMBRecord.EmployeeSysId = In_EmployeeSysId) then
    delete from DMBRecord where
      DMBRecord.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if;
  if exists(select* from DMBRecord where
      DMBRecord.EmployeeSysId = In_EmployeeSysId) then
    set Out_ErrorCode=0
  else
    set Out_ErrorCode=1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteDeMinimisRecurringByEmployeeSysId') then
   drop procedure DeleteDeMinimisRecurringByEmployeeSysId
end if
;

CREATE PROCEDURE "DBA"."DeleteDeMinimisRecurringByEmployeeSysId"(
in In_EmployeeSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from DMBRecurring where EmployeeSysId = In_EmployeeSysId) then
    delete from DMBRecurring where EmployeeSysId = In_EmployeeSysId;
    commit work;
    if exists(select* from DMBRecurring where EmployeeSysId = In_EmployeeSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPhTaxEmployer') then
   drop procedure InsertNewPhTaxEmployer
end if
;


CREATE PROCEDURE "DBA"."InsertNewPhTaxEmployer"(
in In_PhEmployerId char(20),
in In_PhRegisteredName char(100),
in In_PhERTIN char(30),
in In_PhRDOCode char(20),
in In_PhLineOfBusiness char(30),
in In_PhERCategory char(20),
in In_PhERAddress char(50),
in In_PostalCode char(6),
in In_TelephoneNo char(20),
in In_PhTaxBranch char(4),
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
      TelephoneNo,
      PhTaxBranch) values(
      In_PhEmployerId,
      In_PhRegisteredName,
      In_PhERTIN,
      In_PhRDOCode,
      In_PhLineOfBusiness,
      In_PhERCategory,
      In_PhERAddress,
      In_PostalCode,
      In_TelephoneNo,
      In_PhTaxBranch);
    set Out_ErrorCode=1;
    commit work
  else
    set Out_ErrorCode=-2
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'UpdatePhTaxEmployer') then
   drop procedure UpdatePhTaxEmployer
end if
;


CREATE PROCEDURE "DBA"."UpdatePhTaxEmployer"(
in In_PhEmployerId char(20),
in In_PhRegisteredName char(100),
in In_PhERTIN char(30),
in In_PhRDOCode char(20),
in In_PhLineOfBusiness char(30),
in In_ERCategory char(20),
in In_PhERAddress char(50),
in In_PostalCode char(6),
in In_TelephoneNo char(20),
in In_PhTaxBranch char(4),
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
      TelephoneNo = In_TelephoneNo,
      PhTaxBranch = In_PhTaxBranch where
      PhEmployerId = In_PhEmployerId;
    set Out_ErrorCode=1;
    commit work
  else
    set Out_ErrorCode=-1
  end if
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewPhTaxRecord') then
   drop procedure InsertNewPhTaxRecord
end if
;

CREATE PROCEDURE "DBA"."InsertNewPhTaxRecord"(
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
      PhDeMinimis
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
      In_PhDeMinimis
    );
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
      PhHolidayPayMWE = PhHolidayPayMWE,	
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

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPhExemptionStatusFormat') then
   drop procedure FGetPhExemptionStatusFormat
end if
;


CREATE FUNCTION "DBA"."FGetPhExemptionStatusFormat"(
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
  case PhExemption 
    when 'Single' then set ExemptionStatusShortForm='S' 
    when 'HeadOfFamily' then set ExemptionStatusShortForm='HF' 
    when 'Married' then set ExemptionStatusShortForm='ME'
    when 'Zero' then set ExemptionStatusShortForm='Z'
  else
    set ExemptionStatusShortForm=''
  end case
  ;
  if PhDependentNo > 0 and ExemptionStatusShortForm <> 'Z' then
    set Out_ExemptionStatusFormatted=ExemptionStatusShortForm || PhDependentNo
  else
    set Out_ExemptionStatusFormatted=ExemptionStatusShortForm
  end if;
  return Out_ExemptionStatusFormatted
end
;