create procedure dba.DeleteHiProgression(
in In_HiProgSysId integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from HiProgression where HiProgSysId = In_HiProgSysId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  end if;
  if(exists(select* from VnC47Record where HiProgSysId = In_HiProgSysId) or
    exists(select* from VnC47aRecord where HIProgSysId = In_HIProgSysId)) then
    set Out_ErrorCode=-2; // Record in Use
    return
  else
    delete from HiProgression where HiProgSysId = In_HiProgSysId;
    commit work
  end if;
  if exists(select* from HiProgression where HiProgSysId = In_HiProgSysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;


create procedure dba.DeleteSIProgression(
in In_SIProgSysId integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from SIProgression where SIProgSysId = In_SIProgSysId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  end if;
  if(exists(select* from VnC47Record where SIProgSysId = In_SIProgSysId) or
    exists(select* from VnC47aRecord where SIProgSysId = In_SIProgSysId)) then
    set Out_ErrorCode=-2; // Record in Use
    return
  else
    delete from SIProgression where SIProgSysId = In_SIProgSysId;
    commit work
  end if;
  if exists(select* from SIProgression where SIProgSysId = In_SIProgSysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.DeleteVnC04Record(
in In_VnC04SGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from VnC04Record where
      VnC04SGSPGenId = In_VnC04SGSPGenId) then
    delete from VnC04Record where
      VnC04SGSPGenId = In_VnC04SGSPGenId;
    commit work;
    set Out_ErrorCode=1
  end if
end
;

create procedure dba.DeleteVnC45Record(
in In_VnC45SGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from VnC45Record where
      VnC45SGSPGenId = In_VnC45SGSPGenId) then
    delete from VnC45Record where
      VnC45SGSPGenId = In_VnC45SGSPGenId;
    commit work;
    set Out_ErrorCode=1
  end if
end
;

create procedure dba.DeleteVnC47aRecord(
in In_VnC47aSGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from VnC47aRecord where
      VnC47aSGSPGenId = In_VnC47aSGSPGenId) then
    delete from VnC47aRecord where
      VnC47aSGSPGenId = In_VnC47aSGSPGenId;
    commit work;
    set Out_ErrorCode=1
  end if
end
;

create procedure dba.DeleteVnC47Record(
in In_VnC47SGSPGenId char(30),
out Out_ErrorCode integer)
begin
  if exists(select* from VnC47Record where
      VnC47SGSPGenId = In_VnC47SGSPGenId) then
    delete from VnC47Record where
      VnC47SGSPGenId = In_VnC47SGSPGenId;
    commit work;
    set Out_ErrorCode=1
  end if
end
;

create procedure dba.InsertNewHIProgression(
in In_EmployeeSysId integer,
in In_HIProgCurrent smallint,
in In_HIEffectiveDate date,
in In_HICareerId char(20),
in In_HIProgPolicyId char(20),
in In_HICardNo char(30),
in In_HIPlaceCheck char(50),
in In_HIProgRemarks char(100),
in In_HIRegExpDate date,
in In_HICardReturnedDate date,
in In_HIProvince char(50),
out Out_ErrorCode integer)
begin
  declare Out_HIProgSysId integer;
  if not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-1; // EmployeeSysId not exist
    return
  elseif not In_HICareerId = any(select CareerId from Career) then
    set Out_ErrorCode=-2; // In_HICareerId not exist
    return
  elseif not In_HIProgPolicyId = any(select CPFPolicyId from CPFPolicy) and In_HIProgPolicyId <> '' then
    set Out_ErrorCode=-3; // In_HIProgPolicyId not exist
    return
  elseif In_HICareerId = 'FirstRecord' and exists(select* from HIProgression where
    EmployeeSysID = In_EmployeeSysId and HICareerId = 'FirstRecord') then
    set Out_ErrorCode=-4; // In_HICareerId Already has First Record
    return
  else
    select max(HIProgSysId) into Out_HIProgSysId from HIProgression;
    if(Out_HIProgSysId is null) then
      set Out_HIProgSysId=0
    end if;
    if not exists(select* from HIProgression where
        HIProgSysId = Out_HIProgSysId+1) then
      insert into HIProgression(HIProgSysId,EmployeeSysId,
        HIProgCurrent,
        HIEffectiveDate,
        HICareerId,
        HIProgPolicyId,HICardNo,
        HIPlaceCheck,
        HIProgRemarks,
        HIRegExpDate,
        HICardReturnedDate,
        HIProvince) values(Out_HIProgSysId+1,
        In_EmployeeSysId,
        In_HIProgCurrent,
        In_HIEffectiveDate,
        In_HICareerId,
        In_HIProgPolicyId,In_HICardNo,
        In_HIPlaceCheck,
        In_HIProgRemarks,
        In_HIRegExpDate,
        In_HICardReturnedDate,
        In_HIProvince);
      commit work;
      if not exists(select* from HIProgression where
          HIProgSysId = Out_HIProgSysId+1) then
        set Out_ItemAssignItemSysId=null;
        set Out_ErrorCode=0
      else
        // mark current if this is the first record for that particular scheme
        if(select count(*) from HIProgression where EmployeeSysId = In_EmployeeSysId) = 1 or
          (select count(*) from HIProgression where EmployeeSysId = In_EmployeeSysId and HIProgCurrent = 1) = 0 then
          update HIProgression set
            HIProgCurrent = 1 where
            HIProgSysId = Out_HIProgSysId+1
        else
          if In_HIProgCurrent = 1 then
            update HIProgression set
              HIProgCurrent = 0 where
              HIProgSysId <> Out_HIProgSysId+1 and
              EmployeeSysId = In_EmployeeSysId
          end if
        end if; // Successful
        set Out_ErrorCode=Out_HIProgSysId+1
      end if
    end if
  end if
end
; 

create procedure dba.InsertNewSIProgression(
in In_EmployeeSysId integer,
in In_SIProgCurrent smallint,
in In_SIProgressionDate date,
in In_SIEffectiveDate date,
in In_SICareerId char(20),
in In_SIProgPolicyId char(20),
in In_PreviousSIWage double,
in In_CurrentSIWage double,
in In_SIRegistrationDate date,
in In_SIBookNo char(30),
in In_SIProgRemarks char(100),
out Out_ErrorCode integer)
begin
  declare Out_SIProgSysId integer;
  if not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-1; // EmployeeSysId not exist
    return
  elseif not In_SICareerId = any(select CareerId from Career) then
    set Out_ErrorCode=-2; // In_SICareerId not exist
    return
  elseif not In_SIProgPolicyId = any(select CPFPolicyId from CPFPolicy) and In_SIProgPolicyId <> '' then
    set Out_ErrorCode=-3; // In_SIProgPolicyId not exist
    return
  elseif In_SICareerId = 'FirstRecord' and exists(select* from SIProgression where
    EmployeeSysID = In_EmployeeSysId and SICareerId = 'FirstRecord') then
    set Out_ErrorCode=-4; // In_SICareerId Already has First Record
    return
  else
    select max(SIProgSysId) into Out_SIProgSysId from SIProgression;
    if(Out_SIProgSysId is null) then
      set Out_SIProgSysId=0
    end if;
    if not exists(select* from SIProgression where
        SIProgSysId = Out_SIProgSysId+1) then
      insert into SIProgression(SIProgSysId,EmployeeSysId,
        SIProgCurrent,
        SIProgressionDate,
        SIEffectiveDate,
        SICareerId,
        SIProgPolicyId,
        PreviousSIWage,
        CurrentSIWage,
        SIRegistrationDate,
        SIBookNo,
        SIProgRemarks) values(Out_SIProgSysId+1,
        In_EmployeeSysId,
        In_SIProgCurrent,
        In_SIProgressionDate,
        In_SIEffectiveDate,
        In_SICareerId,
        In_SIProgPolicyId,
        In_PreviousSIWage,
        In_CurrentSIWage,
        In_SIRegistrationDate,
        In_SIBookNo,
        In_SIProgRemarks);
      commit work;
      if not exists(select* from SIProgression where
          SIProgSysId = Out_SIProgSysId+1) then
        set Out_ItemAssignItemSysId=null;
        set Out_ErrorCode=0
      else
        // mark current if this is the first record for that particular scheme
        if(select count(*) from SIProgression where EmployeeSysId = In_EmployeeSysId) = 1 or
          (select count(*) from SIProgression where EmployeeSysId = In_EmployeeSysId and SIProgCurrent = 1) = 0 then
          update SIProgression set
            SIProgCurrent = 1 where
            SIProgSysId = Out_SIProgSysId+1
        else
          if In_SIProgCurrent = 1 then
            update SIProgression set
              SIProgCurrent = 0 where
              SIProgSysId <> Out_SIProgSysId+1 and
              EmployeeSysId = In_EmployeeSysId
          end if
        end if; // Successful
        set Out_ErrorCode=Out_SIProgSysId+1
      end if
    end if
  end if
end
;

create procedure dba.InsertNewVnC04Record(
in In_VnC04Year integer,
in In_VnC04Quarter integer,
in In_EmployeeSysId integer,
in In_SIProgSysId integer,
in In_HIProgSysId integer,
in In_VnC04InYear integer,
in In_VnC04InPeriod integer,
in In_SILeaveTypeId char(20),
in In_RateOfContribution double,
in In_SIWage double,
in In_VnAllowancePerDay double,
in In_VnC04LeaveDays double,
in In_VnC04AccuDays double,
in In_VnC04Allowance double,
out Out_ErrorCode integer)
begin
  declare GenID char(30);
  select FGetNewSGSPGeneratedIndex('VnC04Record') into GenID;
  insert into VnC04Record(VnC04SGSPGenId,
    VnC04Year,
    VnC04Quarter,
    EmployeeSysId,
    SIProgSysId,
    HIProgSysId,
    VnC04InYear,
    VnC04InPeriod,
    SILeaveTypeId,
    RateOfContribution,
    SIWage,
    VnAllowancePerDay,
    VnC04LeaveDays,
    VnC04AccuDays,
    VnC04Allowance) values(
    GenId,
    In_VnC04Year,
    In_VnC04Quarter,
    In_EmployeeSysId,
    In_SIProgSysId,
    In_HIProgSysId,
    In_VnC04InYear,
    In_VnC04InPeriod,
    In_SILeaveTypeId,
    In_RateOfContribution,
    In_SIWage,
    In_VnAllowancePerDay,
    In_VnC04LeaveDays,
    In_VnC04AccuDays,
    In_VnC04Allowance);
  commit work;
  set Out_ErrorCode=1
end
;

create procedure dba.InsertNewVnC45Record(
in In_VnC45Year integer,
in In_EmployeeSysId integer,
in In_SIProgSysId integer,
in In_HIProgSysId integer,
in In_SIWage double,
in In_EESIContribution double,
in In_ERSIContribution double,
in In_CapSIWage double,
in In_SIWageF double,
out Out_ErrorCode integer)
begin
  declare GenID char(30);
  select FGetNewSGSPGeneratedIndex('VnC45Record') into GenID;
  if not exists(select* from VnC45Record where
      EmployeeSysId = In_EmployeeSysId and VnC45Year = In_VnC45Year) then
    insert into VnC45Record(VnC45SGSPGenId,
      VnC45Year,
      EmployeeSysId,
      SIProgSysId,
      HIProgSysId,
      SIWage,
      EE_SIContribution,
      ER_SIContribution,
      CapSIWage,
      SIWageF) values(
      GenID,
      In_VnC45Year,
      In_EmployeeSysId,
      In_SIProgSysId,
      In_HIProgSysId,
      In_SIWage,
      In_EESIContribution,
      In_ERSIContribution,
      In_CapSIWage,
      In_SIWageF);
    commit work;
    set Out_ErrorCode=1
  end if
end
;

create procedure dba.InsertNewVnC47aRecord(
in In_VnC47aYear integer,
in In_VnC47aMonth integer,
in In_EmployeeSysId integer,
in In_SIProgSysId integer,
in In_HIProgSysId integer,
in In_VnC47aSection char(20),
in In_VnC47aSubmitDate date,
in In_PreviousSIWage double,
in In_CurrentSIWage double,
in In_C47aFromYear integer,
in In_C47aFromMonth integer,
in In_C47aToYear integer,
in In_C47aToMonth integer,
in In_C47aTime double,
in In_SIDeductionRate double,
in In_HIDeductionRate double,
in In_EESIContribution double,
in In_ERSIContribution double,
in In_EEHIContribution double,
in In_ERHIContribution double,
in In_VnC47aIncrement integer,
in In_C47aReason char(100),
in In_CapPrevSIWage double,
in In_CapCurSIWage double,
in In_PreviousSIWageF double,
in In_CurrentSIWageF double,
out Out_ErrorCode integer,
out Out_VnC47aSGSPGenId char(30))
begin
  select FGetNewSGSPGeneratedIndex('VnC47aRecord') into Out_VnC47aSGSPGenId;
  if not exists(select* from VietnamC47a where VnC47aYear = In_VnC47aYear and
      VnC47aMonth = In_VnC47aMonth) then
    insert into VietnamC47a(VnC47aYear,VnC47aMonth) values(In_VnC47aYear,In_VnC47aMonth)
  end if;
  if not exists(select* from VnC47aRecord where VnC47aSGSPGenId = Out_VnC47aSGSPGenId) then
    insert into VnC47aRecord(VnC47aSGSPGenId,
      VnC47aYear,
      VnC47aMonth,
      EmployeeSysId,
      SIProgSysId,
      HIProgSysId,
      VnC47aSection,
      VnC47aSubmitDate,
      PreviousSIWage,
      CurrentSIWage,
      C47aFromYear,
      C47aFromMonth,
      C47aToYear,
      C47aToMonth,
      C47aTime,
      SIDeductionRate,
      HIDeductionRate,
      EE_SIContribution,
      ER_SIContribution,
      EE_HIContribution,
      ER_HIContribution,
      VnC47aIncrement,
      C47aReason,
      CapPrevSIWage,
      CapCurSIWage,
      PreviousSIWageF,
      CurrentSIWageF) values(
      Out_VnC47aSGSPGenId,
      In_VnC47aYear,
      In_VnC47aMonth,
      In_EmployeeSysId,
      In_SIProgSysId,
      In_HIProgSysId,
      In_VnC47aSection,
      In_VnC47aSubmitDate,
      In_PreviousSIWage,
      In_CurrentSIWage,
      In_C47aFromYear,
      In_C47aFromMonth,
      In_C47aToYear,
      In_C47aToMonth,
      In_C47aTime,
      In_SIDeductionRate,
      In_HIDeductionRate,
      In_EESIContribution,
      In_ERSIContribution,
      In_EEHIContribution,
      In_ERHIContribution,
      In_VnC47aIncrement,
      In_C47aReason,
      In_CapPrevSIWage,
      In_CapCurSIWage,
      In_PreviousSIWageF,
      In_CurrentSIWageF);
    commit work;
    if not exists(select* from VnC47aRecord where VnC47aSGSPGenId = Out_VnC47aSGSPGenId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;



create procedure dba.InsertNewVnC47Record(
in In_VnC47Year integer,
in In_VnC47Month integer,
in In_EmployeeSysId integer,
in In_SIProgSysId integer,
in In_HIProgSysId integer,
in In_VnC47Section char(20),
in In_VnC47SubSection char(20),
in In_VnC47SubmitDate date,
in In_PreviousSIWage double,
in In_CurrentSIWage double,
in In_C47Remarks char(100),
in In_CapPrevSIWage double,
in In_CapCurSIWage double,
in In_PreviousSIWageF double,
in In_CurrentSIWageF double,
out Out_ErrorCode integer)
begin
  declare GenID char(30);
  if not exists(select* from VietnamC47 where VnC47Year = In_VnC47Year and
      VnC47Month = In_VnC47Month) then
    insert into VietnamC47(VnC47Year,VnC47Month) values(In_VnC47Year,In_VnC47Month)
  end if;
  select FGetNewSGSPGeneratedIndex('VnC47Record') into GenID;
  if not exists(select* from VnC47Record where VnC47SGSPGenId = GenID) then
    insert into VnC47Record(VnC47SGSPGenId,
      VnC47Year,
      VnC47Month,
      EmployeeSysId,
      SIProgSysId,
      HIProgSysId,
      VnC47Section,
      VnC47SubSection,
      VnC47SubmitDate,
      PreviousSIWage,
      CurrentSIWage,
      C47Remarks,
      CapPrevSIWage,
      CapCurSIWage,
      PreviousSIWageF,
      CurrentSIWageF) values(
      GenID,
      In_VnC47Year,
      In_VnC47Month,
      In_EmployeeSysId,
      In_SIProgSysId,
      In_HIProgSysId,
      In_VnC47Section,
      In_VnC47SubSection,
      In_VnC47SubmitDate,
      In_PreviousSIWage,
      In_CurrentSIWage,
      In_C47Remarks,
      In_CapPrevSIWage,
      In_CapCurSIWage,
      In_PreviousSIWageF,
      In_CurrentSIWageF);
    commit work;
    if not exists(select* from VnC47Record where VnC47SGSPGenId = GenID) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;


create procedure dba.DeleteVnERSubmission(
in In_VnERSubmitYear integer,
in In_VnERSubmitBranchId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from VnERSubmission where
      VnERSubmitYear = In_VnERSubmitYear and
      VnERSubmitBranchId = In_VnERSubmitBranchId) then
    delete from VnERSubmitRecord where VnERSubmitYear = In_VnERSubmitYear and
      VnERSubmitBranchId = In_VnERSubmitBranchId;
    delete from VnERSubmitPeriod where VnERSubmitYear = In_VnERSubmitYear and
      VnERSubmitBranchId = In_VnERSubmitBranchId;
    delete from VnERSubmission where VnERSubmitYear = In_VnERSubmitYear and
      VnERSubmitBranchId = In_VnERSubmitBranchId;
    commit work;
    if exists(select* from VnERSubmission where
        VnERSubmitYear = In_VnERSubmitYear and
        VnERSubmitBranchId = In_VnERSubmitBranchId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteVnERTaxPayment(
in In_VnTaxEmployerId char(20),
in In_VnERTaxYear integer,
out Out_ErrorCode integer)
begin
  if exists(select* from VnERTaxPayment where VnTaxEmployerId = In_VnTaxEmployerId and
      VnERTaxYear = In_VnERTaxYear) then
    if exists(select* from VnERTaxPayMonth where VnTaxEmployerId = In_VnTaxEmployerId and
        VnERTaxYear = In_VnERTaxYear) then
      delete from VnERTaxPayMonth where
        VnTaxEmployerId = In_VnTaxEmployerId and
        VnERTaxYear = In_VnERTaxYear;
      commit work
    end if;
    delete from VnERTaxPayment where
      VnTaxEmployerId = In_VnTaxEmployerId and
      VnERTaxYear = In_VnERTaxYear;
    commit work;
    if exists(select* from VnERTaxPayment where VnTaxEmployerId = In_VnTaxEmployerId and
        VnERTaxYear = In_VnERTaxYear) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteVnTaxDetails(
in In_PersonalSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from VnTaxDetails where VnTaxDetails.PersonalSysId = In_PersonalSysId) then
    if exists(select* from VnTaxRecord where VnTaxRecord.PersonalSysId = In_PersonalSysId) then
      delete from VnEETaxReceipt where PersonalSysId = In_PersonalSysId;
      delete from VnTaxEmployee where PersonalSysId = In_PersonalSysId;
      delete from VnTaxRecord where PersonalSysId = In_PersonalSysId;
      commit work
    end if;
    delete from VnTaxDetails where VnTaxDetails.PersonalSysId = In_PersonalSysId;
    commit work;
    if exists(select* from VnTaxDetails where VnTaxDetails.PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteVnTaxEmployee(
in In_PersonalSysId integer,
in In_VnTaxRecYear integer,
in In_VnTaxEESysId integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from VnTaxEmployee where PersonalSysId = In_PersonalSysId and VnTaxRecYear = In_VnTaxRecYear and VnTaxEESysId = In_VnTaxEESysId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    delete from VnTaxEmployee where
      PersonalSysId = In_PersonalSysId and
      VnTaxRecYear = In_VnTaxRecYear and
      VnTaxEESysId = In_VnTaxEESysId
  end if;
  if exists(select* from VnTaxEmployee where PersonalSysId = In_PersonalSysId and VnTaxRecYear = In_VnTaxRecYear and VnTaxEESysId = In_VnTaxEESysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.DeleteVnTaxEmployer(
in In_VnTaxEmployerId char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from VnTaxDetails where VnTaxEmployerId = In_VnTaxEmployerId) then
    if not exists(select* from VnTaxRecord where VnTaxEmployerId = In_VnTaxEmployerId) then
      if exists(select* from VnTaxEmployer where VnTaxEmployerId = In_VnTaxEmployerId) then
        if exists(select* from VnERTaxPayment where VnTaxEmployerId = In_VnTaxEmployerId) then
          DeleteVnERTaxPayment: for DeleteVnERTaxPaymentFor as DeleteVnERTaxPaymentCurs dynamic scroll cursor for
            select VnTaxEmployerId as Out_VnTaxERId,VnERTaxYear as Out_VnERTaxYear,VnResidenceStatus as Out_VnResidenceStatus from
              VnERTaxPayment where
              VnTaxEmployerId = In_VnTaxEmployerId do
            call DeleteVnERTaxPayment(Out_VnTaxERId,Out_VnERTaxYear,Out_VnResidenceStatus,ErrorCode) end for
        end if;
        delete from VnTaxEmployer where VnTaxEmployerId = In_VnTaxEmployerId;
        commit work;
        if exists(select* from VnTaxEmployer where VnTaxEmployerId = In_VnTaxEmployerId) then
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
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteVnTaxPolicy(
in In_VnTaxPolicyId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from VnTaxDetails where VnTaxPolicyId = In_VnTaxPolicyId) then
    set Out_ErrorCode=-2;
    return
  end if;
  if exists(select* from VnTaxRecord where VnTaxPolicyId = In_VnTaxPolicyId) then
    set Out_ErrorCode=-2;
    return
  end if;
  if exists(select* from VnTaxProgression where VnTaxPolicyId = In_VnTaxPolicyId) then
    delete from VnTaxRate where
      VnTaxProgSysId = any(select VnTaxProgSysId from VnTaxProgression where VnTaxPolicyId = In_VnTaxPolicyId);
    delete from VnTaxProgression where VnTaxPolicyId = In_VnTaxPolicyId
  end if;
  if exists(select* from VnTaxPolicy where
      VnTaxPolicyId = In_VnTaxPolicyId) then
    delete from VnTaxPolicy where
      VnTaxPolicyId = In_VnTaxPolicyId;
    set Out_ErrorCode=1;
    commit work
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.DeleteVnTaxProgression(
in In_VnTaxProgSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from VnTaxRate where VnTaxProgSysId = In_VnTaxProgSysId) then
    delete from VnTaxRate where VnTaxProgSysId = In_VnTaxProgSysId
  end if;
  if exists(select* from VnTaxProgression where VnTaxProgSysId = In_VnTaxProgSysId) then
    delete from VnTaxProgression where VnTaxProgSysId = In_VnTaxProgSysId;
    set Out_ErrorCode=1;
    commit work
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.DeleteVnTaxRecord(
in In_PersonalSysId integer,
in In_VnTaxRecYear integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from VnTaxRecord where PersonalSysId = In_PersonalSysId and VnTaxRecYear = In_VnTaxRecYear) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    delete from VnEETaxReceipt where
      PersonalSysId = In_PersonalSysId and
      VnTaxRecYear = In_VnTaxRecYear;
    delete from VnTaxEmployee where
      PersonalSysId = In_PersonalSysId and
      VnTaxRecYear = In_VnTaxRecYear;
    delete from VnTaxRecord where
      PersonalSysId = In_PersonalSysId and
      VnTaxRecYear = In_VnTaxRecYear;
    commit work
  end if;
  if exists(select* from VnTaxRecord where PersonalSysId = In_PersonalSysId and VnTaxRecYear = In_VnTaxRecYear) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create function dba.FGetVnERSubmitPeriodPayment(
in In_Year integer,
in In_BranchId char(20),
in In_Period integer)
returns double
begin
  declare Out_VnERSubmitPeriodPayment double;
  select Sum(VnERSubmitPaidAmt) into Out_VnERSubmitPeriodPayment
    from VnERSubmitRecord where
    VnERSubmitYear = In_Year and
    VnERSubmitPeriod <= In_Period and
    VnERSubmitBranchId = In_BranchId;
  if Out_VnERSubmitPeriodPayment is null then set Out_VnERSubmitPeriodPayment=FGetVnERSubmitPrevPaid(In_Year,In_BranchId)
  else set Out_VnERSubmitPeriodPayment=Out_VnERSubmitPeriodPayment+FGetVnERSubmitPrevPaid(In_Year,In_BranchId)
  end if;
  return(Out_VnERSubmitPeriodPayment)
end
;

create function dba.FGetVnERSubmitPeriodTotalDue(
in In_Year integer,
in In_BranchId char(20),
in In_Period integer)
returns double
begin
  declare Out_VnERSubmitPeriodTotalDue double;
  select Sum(ContriAddEECPF+ /* HI EE Mid Q (L)*/
    ContriAddERCPF+ /* HI ER Mid Q (L) */
    ActualAddEECPF+ /* SI EE (L) */
    ActualAddERCPF+ /* SI ER (L)*/
    VolAddEECPF+ /* HI EE (L)*/
    VolAddERCPF+ /* HI ER (L)*/
    SupIR8AAddEECPF+ /* SI EE Back Pay (L)*/
    SupIR8AAddERCPF+ /* SI ER Back Pay (L)*/
    SupIR8AActAddEECPF+ /* HI EE Back Pay (L)*/
    SupIR8AActAddERCPF) into Out_VnERSubmitPeriodTotalDue /* HI ER Back Pay (L)*/
    from PayPeriodRecord join PeriodPolicySummary where
    PayPeriodRecord.PayRecYear = In_Year and
    PayPeriodRecord.PayRecPeriod <= In_Period and
    PayPeriodRecord.PayBranchId = In_BranchId;
  if Out_VnERSubmitPeriodTotalDue is null then set Out_VnERSubmitPeriodTotalDue=FGetVnERSubmitPrevDue(In_Year,In_BranchId)
  else set Out_VnERSubmitPeriodTotalDue=Out_VnERSubmitPeriodTotalDue+FGetVnERSubmitPrevDue(In_Year,In_BranchId)
  end if;
  return(Out_VnERSubmitPeriodTotalDue)
end
;

create function dba.FGetVnERSubmitPrevDue(
in In_Year integer,
in In_BranchId char(20))
returns double
begin
  declare Out_VnERSubmitPrevDue double;
  select VnERSubmitPrevDue into Out_VnERSubmitPrevDue
    from VnERSubmission where
    VnERSubmitYear = In_Year and
    VnERSubmitBranchId = In_BranchId;
  if Out_VnERSubmitPrevDue is null then set Out_VnERSubmitPrevDue=0
  end if;
  return(Out_VnERSubmitPrevDue)
end
;

create function dba.FGetVnERSubmitPrevPaid(
in In_Year integer,
in In_BranchId char(20))
returns double
begin
  declare Out_VnERSubmitPrevPaid double;
  select VnERSubmitPrevPaid into Out_VnERSubmitPrevPaid
    from VnERSubmission where
    VnERSubmitYear = In_Year and
    VnERSubmitBranchId = In_BranchId;
  if Out_VnERSubmitPrevPaid is null then set Out_VnERSubmitPrevPaid=0
  end if;
  return(Out_VnERSubmitPrevPaid)
end
;

create procedure dba.InsertNewVnERSubmission(
in In_VnERSubmitYear integer,
in In_VnERSubmitBranchId char(20),
in In_VnERSubmitPrevDue double,
in In_VnERSubmitPrevPaid double,
in In_VnERSubmitPrevPenalty double,
in In_VnERSubmitPrevAdj double,
in In_VnERSubmitPrevKeptByCompany double,
in In_VnERSubmitPrevRemainingAmt double,
out Out_ErrorCode integer)
begin
  if not exists(select* from VnERSubmission where
      VnERSubmitYear = In_VnERSubmitYear and
      VnERSubmitBranchId = In_VnERSubmitBranchId) then
    insert into VnERSubmission(VnERSubmitYear,
      VnERSubmitBranchId,
      VnERSubmitPrevDue,
      VnERSubmitPrevPaid,
      VnERSubmitPrevPenalty,
      VnERSubmitPrevAdj,
      VnERSubmitPrevKeptByCompany,
      VnERSubmitPrevRemainingAmt) values(In_VnERSubmitYear,
      In_VnERSubmitBranchId,
      In_VnERSubmitPrevDue,
      In_VnERSubmitPrevPaid,
      In_VnERSubmitPrevPenalty,
      In_VnERSubmitPrevAdj,
      In_VnERSubmitPrevKeptByCompany,
      In_VnERSubmitPrevRemainingAmt);
    commit work;
    if not exists(select* from VnERSubmission where VnERSubmitYear = In_VnERSubmitYear and
        VnERSubmitBranchId = In_VnERSubmitBranchId) then
      set Out_ErrorCode=0
    else
      insert into VnERSubmitPeriod values(In_VnERSubmitYear,In_VnERSubmitBranchId,1);
      insert into VnERSubmitPeriod values(In_VnERSubmitYear,In_VnERSubmitBranchId,2);
      insert into VnERSubmitPeriod values(In_VnERSubmitYear,In_VnERSubmitBranchId,3);
      insert into VnERSubmitPeriod values(In_VnERSubmitYear,In_VnERSubmitBranchId,4);
      insert into VnERSubmitPeriod values(In_VnERSubmitYear,In_VnERSubmitBranchId,5);
      insert into VnERSubmitPeriod values(In_VnERSubmitYear,In_VnERSubmitBranchId,6);
      insert into VnERSubmitPeriod values(In_VnERSubmitYear,In_VnERSubmitBranchId,7);
      insert into VnERSubmitPeriod values(In_VnERSubmitYear,In_VnERSubmitBranchId,8);
      insert into VnERSubmitPeriod values(In_VnERSubmitYear,In_VnERSubmitBranchId,9);
      insert into VnERSubmitPeriod values(In_VnERSubmitYear,In_VnERSubmitBranchId,10);
      insert into VnERSubmitPeriod values(In_VnERSubmitYear,In_VnERSubmitBranchId,11);
      insert into VnERSubmitPeriod values(In_VnERSubmitYear,In_VnERSubmitBranchId,12);
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure DBA.InsertNewVnERTaxPayment(
in In_VnTaxEmployerId char(20),
in In_VnERTaxYear integer,
in In_VnResidenceStatus char(20),
in In_VnERTaxPrevDue double,
in In_VnERTaxPrevPaid double,
in In_VnERTaxPrevPenalty double,
in In_VnERTaxPrevCompen double,
in In_VnBalancePrevYear double,
out Out_ErrorCode integer)
begin
  if(In_VnTaxEmployerId is null) then
    set Out_ErrorCode=-1
  else
    if not exists(select* from VnERTaxPayment where VnTaxEmployerId = In_VnTaxEmployerId and
        VnERTaxYear = In_VnERTaxYear and VnResidenceStatus = In_VnResidenceStatus) then
      insert into VnERTaxPayment(VnTaxEmployerId,
        VnERTaxYear,
        VnResidenceStatus,
        VnERTaxPrevDue,
        VnERTaxPrevPaid,
        VnERTaxPrevPenalty,
        VnERTaxPrevCompen,
        VnBalancePrevYear) values(
        In_VnTaxEmployerId,
        In_VnERTaxYear,
        In_VnResidenceStatus,
        In_VnERTaxPrevDue,
        In_VnERTaxPrevPaid,
        In_VnERTaxPrevPenalty,
        In_VnERTaxPrevCompen,
        In_VnBalancePrevYear);
      commit work;
      if not exists(select* from VnERTaxPayment where VnTaxEmployerId = In_VnTaxEmployerId and
          VnERTaxYear = In_VnERTaxYear and VnResidenceStatus = In_VnResidenceStatus) then
        set Out_ErrorCode=0
      else
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=0
    end if
  end if
end
;

create procedure dba.InsertNewVnTaxDetails(
in In_PersonalSysId integer,
in In_VnTaxPolicyId char(20),
in In_VnTaxEmployerId char(20),
in In_VnPITID char(30),
in In_VnTaxMethod char(20),
in In_VnReqFinalizeTax smallint,
out Out_ErrorCode integer)
begin
  if not exists(select* from VnTaxDetails where VnTaxDetails.PersonalSysId = In_PersonalSysId) then
    insert into VnTaxDetails(PersonalSysId,
      VnTaxPolicyId,
      VnTaxEmployerId,
      VnPITID,
      VnTaxMethod,
      VnReqFinalizeTax) values(
      In_PersonalSysId,
      In_VnTaxPolicyId,
      In_VnTaxEmployerId,
      In_VnPITID,
      In_VnTaxMethod,
      In_VnReqFinalizeTax);
    commit work;
    if not exists(select* from VnTaxDetails where VnTaxDetails.PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewVnTaxEmployee(
in In_PersonalSysId integer,
in In_VnTaxRecYear integer,
in In_VnTaxEESysId integer,
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
  if exists(select* from VnTaxEmployee where PersonalSysId = In_PersonalSysId and VnTaxRecYear = In_VnTaxRecYear and VnTaxEESysId = In_VnTaxEESysId) then
    set Out_ErrorCode=-1; // Record exists
    return
  elseif not In_PersonalSysId = any(select PersonalSysId from Personal) then
    set Out_ErrorCode=-2; // PersonalSysId not exist
    return
  else
    insert into VnTaxEmployee(PersonalSysId,
      VnTaxRecYear,VnTaxEESysId,FromPayRecYear,
      FromPayRecPeriod,FromPayRecSubPeriod,ToPayRecYear,
      ToPayRecPeriod,ToPayRecSubPeriod,PayRecID,
      TaxLastProcessed) values(
      In_PersonalSysId,In_VnTaxRecYear,In_VnTaxEESysId,In_FromPayRecYear,
      In_FromPayRecPeriod,In_FromPayRecSubPeriod,In_ToPayRecYear,
      In_ToPayRecPeriod,In_ToPayRecSubPeriod,In_PayRecID,
      In_TaxLastProcessed);
    commit work
  end if;
  if not exists(select* from VnTaxEmployee where PersonalSysId = In_PersonalSysId and VnTaxRecYear = In_VnTaxRecYear and VnTaxEESysId = In_VnTaxEESysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure DBA.InsertNewVnTaxEmployer(
in In_VnTaxEmployerId char(20),
in In_VnCompanyRefCode char(20),
in In_VnVATCode char(20),
in In_VnBankId char(20),
in In_VnBankBrId char(20),
in In_VnAccNoBank char(30),
in In_VnCompanyName char(100),
in In_VnCoAddress char(150),
in In_VnCoContactNo char(20),
in In_VnCoFaxNo char(20),
in In_VnAuthorised char(60),
in In_VnAuthorisedPosition char(20),
in In_VnPreparedBy char(60),
in In_VnCompensation double,
in In_VnCompanyForeignName char(100),
out Out_ErrorCode integer)
begin
  if(In_VnTaxEmployerId is null) then
    set Out_ErrorCode=-1
  else
    if not exists(select* from VnTaxEmployer where VnTaxEmployerId = In_VnTaxEmployerId) then
      insert into VnTaxEmployer(VnTaxEmployerId,
        VnCompanyRefCode,
        VnVATCode,
        VnBankId,
        VnBankBrId,
        VnAccNoBank,
        VnCompanyName,
        VnCoAddress,
        VnCoContactNo,
        VnCoFaxNo,
        VnAuthorised,
        VnAuthorisedPosition,
        VnPreparedBy,
        VnCompensation,
        VnCompanyForeignName) values(
        In_VnTaxEmployerId,
        In_VnCompanyRefCode,
        In_VnVATCode,
        In_VnBankId,
        In_VnBankBrId,
        In_VnAccNoBank,
        In_VnCompanyName,
        In_VnCoAddress,
        In_VnCoContactNo,
        In_VnCoFaxNo,
        In_VnAuthorised,
        In_VnAuthorisedPosition,
        In_VnPreparedBy,
        In_VnCompensation,
        In_VnCompanyForeignName);
      commit work;
      if not exists(select* from VnTaxEmployer where VnTaxEmployerId = In_VnTaxEmployerId) then
        set Out_ErrorCode=0
      else
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=0
    end if
  end if
end
;

create procedure dba.InsertNewVnTaxPolicy(
in In_VnTaxPolicyId char(20),
in In_VnTaxPolicyDesc char(100),
out Out_ErrorCode integer)
begin
  if In_VnTaxPolicyId is null then
    set Out_ErrorCode=-1;
    return
  end if;
  if exists(select* from VnTaxPolicy where VnTaxPolicyId = In_VnTaxPolicyId) then
    set Out_ErrorCode=-2;
    return
  end if;
  insert into VnTaxPolicy(VnTaxPolicyId,VnTaxPolicyDesc) values(In_VnTaxPolicyId,In_VnTaxPolicyDesc);
  commit work;
  set Out_ErrorCode=1
end
;

create procedure dba.InsertNewVnTaxProgression(
in In_VnTaxPolicyId char(20),
in In_VnTaxProgDate date,
out Out_ErrorCode integer)
begin
  if In_VnTaxPolicyId is null then
    set Out_ErrorCode=-1;
    return
  end if;
  if exists(select* from VnTaxProgression where VnTaxPolicyId = In_VnTaxPolicyId and VnTaxProgDate = In_VnTaxProgDate) then
    set Out_ErrorCode=-2;
    return
  end if;
  insert into VnTaxProgression(VnTaxPolicyId,VnTaxProgDate) values(In_VnTaxPolicyId,In_VnTaxProgDate);
  commit work;
  select VnTaxProgSysId into Out_ErrorCode from VnTaxProgression where
    VnTaxPolicyId = In_VnTaxPolicyId and VnTaxProgDate = In_VnTaxProgDate
end
;

create procedure dba.InsertNewVnTaxRecord(
in In_PersonalSysId integer,
in In_VnTaxRecYear integer,
in In_VnTaxPolicyId char(20),
in In_VnTaxEmployerId char(20),
in In_VnTaxNoOfMonth integer,
in In_VnTaxTaxable double,
in In_VnTaxSalary double,
in In_VnTaxContribution double,
in In_VnTaxBonus double,
in In_VnTaxOthers double,
in In_VnTaxWithheld double,
in In_VnTaxFinalisedTaxAmt double,
in In_VnTaxAnnualEstTaxAmt double,
in In_VnTaxGrossUpAmount double,
in In_VnTaxLatestResidence char(20),
in In_VnReqFinalizeTax smallint,
out Out_ErrorCode integer)
begin
  if exists(select* from VnTaxRecord where PersonalSysId = In_PersonalSysId and VnTaxRecYear = In_VnTaxRecYear) then
    set Out_ErrorCode=-1; // Record exists
    return
  elseif not In_PersonalSysId = any(select PersonalSysId from Personal) then
    set Out_ErrorCode=-2; // PersonalSysId not exist
    return
  elseif not In_VnTaxPolicyId = any(select VnTaxPolicyId from VnTaxPolicy) then
    set Out_ErrorCode=-3; // VnTaxPolicyId not exist
    return
  elseif not In_VnTaxEmployerId = any(select VnTaxEmployerId from VnTaxEmployer) then
    set Out_ErrorCode=-4; // VnTaxEmployerId not exist
    return
  else
    insert into VnTaxRecord(PersonalSysId,
      VnTaxRecYear,
      VnTaxPolicyId,
      VnTaxEmployerId,
      VnTaxNoOfMonth,
      VnTaxTaxable,
      VnTaxSalary,
      VnTaxContribution,
      VnTaxBonus,
      VnTaxOthers,
      VnTaxWithheld,
      VnTaxFinalisedTaxAmt,
      VnTaxAnnualEstTaxAmt,
      VnTaxGrossUpAmount,
      VnTaxLatestResidence,
      VnReqFinalizeTax) values(
      In_PersonalSysId,
      In_VnTaxRecYear,
      In_VnTaxPolicyId,
      In_VnTaxEmployerId,
      In_VnTaxNoOfMonth,
      In_VnTaxTaxable,
      In_VnTaxSalary,
      In_VnTaxContribution,
      In_VnTaxBonus,
      In_VnTaxOthers,
      In_VnTaxWithheld,
      In_VnTaxFinalisedTaxAmt,
      In_VnTaxAnnualEstTaxAmt,
      In_VnTaxGrossUpAmount,
      In_VnTaxLatestResidence,
      In_VnReqFinalizeTax);
    commit work
  end if;
  if not exists(select* from VnTaxRecord where PersonalSysId = In_PersonalSysId and VnTaxRecYear = In_VnTaxRecYear) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.UpdateHIProgression(
in In_HIProgSysId integer,
in In_EmployeeSysId integer,
in In_HIProgCurrent smallint,
in In_HIEffectiveDate date,
in In_HICareerId char(20),
in In_HIProgPolicyId char(20),
in In_HICardNo char(30),
in In_HIPlaceCheck char(50),
in In_HIProgRemarks char(100),
in In_HIRegExpDate date,
in In_HICardReturnedDate date,
in In_HIProvince char(50),
out Out_ErrorCode integer)
begin
  if not exists(select* from HIProgression where HIProgSysId = In_HIProgSysId) then
    set Out_ErrorCode=-1; // Record not exists
    return
  elseif not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-2; // EmployeeSysId not exist
    return
  elseif not In_HICareerId = any(select CareerId from Career) then
    set Out_ErrorCode=-3; // In_HICareerId not exist
    return
  elseif not In_HIProgPolicyId = any(select CPFPolicyId from CPFPolicy) and In_HIProgPolicyId <> '' then
    set Out_ErrorCode=-4; // In_HIProgPolicyId not exist
    return
  elseif In_HICareerId = 'FirstRecord' and exists(select* from HIProgression where
    EmployeeSysID = In_EmployeeSysId and HICareerId = 'FirstRecord' and HIProgSysId <> In_HIProgSysId) then
    set Out_ErrorCode=-5; // In_HICareerId Already has First Record
    return
  else
    // if this is current, set other record for this scheme to not current
    if In_HIProgCurrent = 1 then
      update HIProgression set
        HIProgCurrent = 0 where
        EmployeeSysId = In_EmployeeSysId
    end if;
    update HIProgression set
      EmployeeSysId = In_EmployeeSysId,
      HIProgCurrent = In_HIProgCurrent,
      HIEffectiveDate = In_HIEffectiveDate,
      HICareerId = In_HICareerId,
      HIProgPolicyId = In_HIProgPolicyId,
      HICardNo = In_HICardNo,
      HIPlaceCheck = In_HIPlaceCheck,
      HIProgRemarks = In_HIProgRemarks,
      HIRegExpDate = In_HIRegExpDate,
      HICardReturnedDate = In_HICardReturnedDate,
      HIProvince = In_HIProvince where
      HIProgSysId = In_HIProgSysId;
    commit work
  end if;
  set Out_ErrorCode=In_HIProgSysId // Successful
end
;


create procedure dba.UpdateSIProgression(
in In_SIProgSysId integer,
in In_EmployeeSysId integer,
in In_SIProgCurrent smallint,
in In_SIProgressionDate date,
in In_SIEffectiveDate date,
in In_SICareerId char(20),
in In_SIProgPolicyId char(20),
in In_PreviousSIWage double,
in In_CurrentSIWage double,
in In_SIRegistrationDate date,
in In_SIBookNo char(30),
in In_SIProgRemarks char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from SIProgression where SIProgSysId = In_SIProgSysId) then
    set Out_ErrorCode=-1; // Record not exists
    return
  elseif not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-2; // EmployeeSysId not exist
    return
  elseif not In_SICareerId = any(select CareerId from Career) then
    set Out_ErrorCode=-3; // In_SICareerId not exist
    return
  elseif not In_SIProgPolicyId = any(select CPFPolicyId from CPFPolicy) and In_SIProgPolicyId <> '' then
    set Out_ErrorCode=-4; // In_SIProgPolicyId not exist
    return
  elseif In_SICareerId = 'FirstRecord' and exists(select* from SIProgression where
    EmployeeSysID = In_EmployeeSysId and SICareerId = 'FirstRecord' and SIProgSysId <> In_SIProgSysId) then
    set Out_ErrorCode=-5; // In_SICareerId Already has First Record
    return
  else
    // if this is current, set other record for this scheme to not current
    if In_SIProgCurrent = 1 then
      update SIProgression set
        SIProgCurrent = 0 where
        EmployeeSysId = In_EmployeeSysId
    end if;
    update SIProgression set
      EmployeeSysId = In_EmployeeSysId,
      SIProgCurrent = In_SIProgCurrent,
      SIProgressionDate = In_SIProgressionDate,
      SIEffectiveDate = In_SIEffectiveDate,
      SICareerId = In_SICareerId,
      SIProgPolicyId = In_SIProgPolicyId,
      PreviousSIWage = In_PreviousSIWage,
      CurrentSIWage = In_CurrentSIWage,
      SIRegistrationDate = In_SIRegistrationDate,
      SIBookNo = In_SIBookNo,
      SIProgRemarks = In_SIProgRemarks where
      SIProgSysId = In_SIProgSysId;
    commit work
  end if;
  set Out_ErrorCode=In_SIProgSysId // Successful
end
;



create procedure dba.UpdateVnC04Record(
in In_VnC04SGSPGenId char(30),
in In_VnC04Year integer,
in In_VnC04Quarter integer,
in In_EmployeeSysId integer,
in In_SIProgSysId integer,
in In_HIProgSysId integer,
in In_VnC04InYear integer,
in In_VnC04InPeriod integer,
in In_SILeaveTypeId char(20),
in In_RateOfContribution double,
in In_SIWage double,
in In_VnAllowancePerDay double,
in In_VnC04LeaveDays double,
in In_VnC04AccuDays double,
in In_VnC04Allowance double,
out Out_ErrorCode integer)
begin
  if exists(select* from VnC04Record where
      VnC04SGSPGenId = In_VnC04SGSPGenId) then
    update VnC04Record set
      VnC04Year = In_VnC04Year,
      VnC04Quarter = In_VnC04Quarter,
      EmployeeSysId = In_EmployeeSysId,
      SIProgSysId = In_SIProgSysId,
      HIProgSysId = In_HIProgSysId,
      VnC04InYear = In_VnC04InYear,
      VnC04InPeriod = In_VnC04InPeriod,
      SILeaveTypeId = In_SILeaveTypeId,
      RateOfContribution = In_RateOfContribution,
      SIWage = In_SIWage,
      VnAllowancePerDay = In_VnAllowancePerDay,
      VnC04LeaveDays = In_VnC04LeaveDays,
      VnC04AccuDays = In_VnC04AccuDays,
      VnC04Allowance = In_VnC04Allowance where VnC04SGSPGenId = In_VnC04SGSPGenId;
    commit work;
    set Out_ErrorCode=1
  end if
end
;

create procedure dba.UpdateVnC45Record(
in In_VnC45SGSPGenId char(30),
in In_VnC45Year integer,
in In_EmployeeSysId integer,
in In_SIProgSysId integer,
in In_HIProgSysId integer,
in In_SIWage double,
in In_EESIContribution double,
in In_ERSIContribution double,
in In_CapSIWage double,
in In_SIWageF double,
out Out_ErrorCode integer)
begin
  if exists(select* from VnC45Record where
      VnC45SGSPGenId = In_VnC45SGSPGenId) then
    update VnC45Record set
      VnC45Year = In_VnC45Year,
      EmployeeSysId = In_EmployeeSysId,
      SIProgSysId = In_SIProgSysId,
      HIProgSysId = In_HIProgSysId,
      SIWage = In_SIWage,
      EE_SIContribution = In_EESIContribution,
      ER_SIContribution = In_ERSIContribution,
      CapSIWage = In_CapSIWage,
      SIWageF = In_SIWageF where
      VnC45SGSPGenId = In_VnC45SGSPGenId;
    commit work;
    set Out_ErrorCode=1
  end if
end
;

create procedure dba.UpdateVnC47aRecord(
in In_VnC47aSGSPGenId char(30),
in In_VnC47aYear integer,
in In_VnC47aMonth integer,
in In_EmployeeSysId integer,
in In_SIProgSysId integer,
in In_HIProgSysId integer,
in In_VnC47aSection char(20),
in In_VnC47aSubmitDate date,
in In_PreviousSIWage double,
in In_CurrentSIWage double,
in In_C47aFromYear integer,
in In_C47aFromMonth integer,
in In_C47aToYear integer,
in In_C47aToMonth integer,
in In_C47aTime integer,
in In_SIDeductionRate double,
in In_HIDeductionRate double,
in In_EESIContribution double,
in In_ERSIContribution double,
in In_EEHIContribution double,
in In_ERHIContribution double,
in In_VnC47aIncrement integer,
in In_C47aReason char(100),
in In_CapPrevSIWage double,
in In_CapCurSIWage double,
in In_PreviousSIWageF double,
in In_CurrentSIWageF double,
out Out_ErrorCode integer)
begin
  if exists(select* from VnC47aRecord where VnC47aSGSPGenId = In_VnC47aSGSPGenId) then
    update VnC47aRecord set
      VnC47aYear = In_VnC47aYear,
      VnC47aMonth = In_VnC47aMonth,
      EmployeeSysId = In_EmployeeSysId,
      SIProgSysId = In_SIProgSysId,
      HIProgSysId = In_HIProgSysId,
      VnC47aSection = In_VnC47aSection,
      VnC47aSubmitDate = In_VnC47aSubmitDate,
      PreviousSIWage = In_PreviousSIWage,
      CurrentSIWage = In_CurrentSIWage,
      C47aFromYear = In_C47aFromYear,
      C47aFromMonth = In_C47aFromMonth,
      C47aToYear = In_C47aToYear,
      C47aToMonth = In_C47aToMonth,
      C47aTime = In_C47aTime,
      SIDeductionRate = In_SIDeductionRate,
      HIDeductionRate = In_HIDeductionRate,
      EE_SIContribution = In_EESIContribution,
      ER_SIContribution = In_ERSIContribution,
      EE_HIContribution = In_EEHIContribution,
      ER_HIContribution = In_ERHIContribution,
      VnC47aIncrement = In_VnC47aIncrement,
      C47aReason = In_C47aReason,
      CapPrevSIWage = In_CapPrevSIWage,
      CapCurSIWage = In_CapCurSIWage,
      PreviousSIWageF = In_PreviousSIWageF,
      CurrentSIWageF = In_CurrentSIWageF where
      VnC47aSGSPGenId = In_VnC47aSGSPGenId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateVnC47Record(
in In_VnC47SGSPGenId char(30),
in In_VnC47Year integer,
in In_VnC47Month integer,
in In_EmployeeSysId integer,
in In_SIProgSysId integer,
in In_HIProgSysId integer,
in In_VnC47Section char(20),
in In_VnC47SubSection char(20),
in In_VnC47SubmitDate date,
in In_PreviousSIWage double,
in In_CurrentSIWage double,
in In_C47Remarks char(100),
in In_CapPrevSIWage double,
in In_CapCurSIWage double,
in In_PreviousSIWageF double,
in In_CurrentSIWageF double,
out Out_ErrorCode integer)
begin
  if exists(select* from VnC47Record where VnC47SGSPGenId = In_VnC47SGSPGenId) then
    update VnC47Record set
      VnC47Year = In_VnC47Year,
      VnC47Month = In_VnC47Month,
      EmployeeSysId = In_EmployeeSysId,
      SIProgSysId = In_SIProgSysId,
      HIProgSysId = In_HIProgSysId,
      VnC47Section = In_VnC47Section,
      VnC47SubSection = In_VnC47SubSection,
      VnC47SubmitDate = In_VnC47SubmitDate,
      PreviousSIWage = In_PreviousSIWage,
      CurrentSIWage = In_CurrentSIWage,
      C47Remarks = In_C47Remarks,
      CapPrevSIWage = In_CapPrevSIWage,
      CapCurSIWage = In_CapCurSIWage,
      PreviousSIWageF = In_PreviousSIWageF,
      CurrentSIWageF = In_CurrentSIWageF where
      VnC47SGSPGenId = In_VnC47SGSPGenId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateVnERSubmission(
in In_VnERSubmitYear integer,
in In_VnERSubmitBranchId char(20),
in In_VnERSubmitPrevDue double,
in In_VnERSubmitPrevPaid double,
in In_VnERSubmitPrevPenalty double,
in In_VnERSubmitPrevAdj double,
in In_VnERSubmitPrevKeptByCompany double,
in In_VnERSubmitPrevRemainingAmt double,
out Out_ErrorCode integer)
begin
  if exists(select* from VnERSubmission where VnERSubmitYear = In_VnERSubmitYear and
      VnERSubmitBranchId = In_VnERSubmitBranchId) then
    update VnERSubmission set VnERSubmitPrevDue = In_VnERSubmitPrevDue,
      VnERSubmitPrevPaid = In_VnERSubmitPrevPaid,
      VnERSubmitPrevPenalty = In_VnERSubmitPrevPenalty,
      VnERSubmitPrevAdj = In_VnERSubmitPrevAdj,
      VnERSubmitPrevKeptByCompany = In_VnERSubmitPrevKeptByCompany,
      VnERSubmitPrevRemainingAmt = In_VnERSubmitPrevRemainingAmt where
      VnERSubmitYear = In_VnERSubmitYear and
      VnERSubmitBranchId = In_VnERSubmitBranchId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;


create procedure dba.UpdateVnERTaxPayment(
in In_VnTaxEmployerId char(20),
in In_VnERTaxYear integer,
in In_VnResidenceStatus char(20),
in In_VnERTaxPrevDue double,
in In_VnERTaxPrevPaid double,
in In_VnERTaxPrevPenalty double,
in In_VnERTaxPrevCompen double,
in In_VnBalancePrevYear double,
out Out_ErrorCode integer)
begin
  if exists(select* from VnERTaxPayment where VnTaxEmployerId = In_VnTaxEmployerId and
      VnERTaxYear = In_VnERTaxYear and VnResidenceStatus = In_VnResidenceStatus) then
    update VnERTaxPayment set
      VnERTaxPrevDue = In_VnERTaxPrevDue,
      VnERTaxPrevPaid = In_VnERTaxPrevPaid,
      VnERTaxPrevPenalty = In_VnERTaxPrevPenalty,
      VnERTaxPrevCompen = In_VnERTaxPrevCompen,
      VnBalancePrevYear = In_VnBalancePrevYear where
      VnTaxEmployerId = In_VnTaxEmployerId and
      VnERTaxYear = In_VnERTaxYear and
      VnResidenceStatus = In_VnResidenceStatus;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateVnTaxDetails(
in In_PersonalSysId integer,
in In_VnTaxPolicyId char(20),
in In_VnTaxEmployerId char(20),
in In_VnPITID char(30),
in In_VnTaxMethod char(20),
in In_VnReqFinalizeTax smallint,
out Out_ErrorCode integer)
begin
  if exists(select* from VnTaxDetails where VnTaxDetails.PersonalSysId = In_PersonalSysId) then
    update VnTaxDetails set
      VnTaxPolicyId = In_VnTaxPolicyId,
      VnTaxEmployerId = In_VnTaxEmployerId,
      VnPITID = In_VnPITID,
      VnTaxMethod = In_VnTaxMethod,
      VnReqFinalizeTax = In_VnReqFinalizeTax where
      PersonalSysId = In_PersonalSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateVnTaxEmployee(
in In_PersonalSysId integer,
in In_VnTaxRecYear integer,
in In_VnTaxEESysId integer,
in In_FromPayRecYear integer,in In_FromPayRecPeriod integer,in In_FromPayRecSubPeriod integer,in In_ToPayRecYear integer,in In_ToPayRecPeriod integer,in In_ToPayRecSubPeriod integer,in In_PayRecID char(20),in In_TaxLastProcessed smallint,out Out_ErrorCode integer)
begin
  if not exists(select* from VnTaxEmployee where PersonalSysId = In_PersonalSysId and VnTaxRecYear = In_VnTaxRecYear and VnTaxEESysId = In_VnTaxEESysId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    update VnTaxEmployee set
      FromPayRecYear = In_FromPayRecYear,
      FromPayRecPeriod = In_FromPayRecPeriod,FromPayRecSubPeriod = In_FromPayRecSubPeriod,
      ToPayRecYear = In_ToPayRecYear,
      ToPayRecPeriod = In_ToPayRecPeriod,ToPayRecSubPeriod = In_ToPayRecSubPeriod,
      PayRecID = In_PayRecID,
      TaxLastProcessed = In_TaxLastProcessed where
      PersonalSysId = In_PersonalSysId and
      VnTaxRecYear = In_VnTaxRecYear and
      VnTaxEESysId = In_VnTaxEESysId;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;

create procedure dba.UpdateVnTaxEmployer(
in In_VnTaxEmployerId char(20),
in In_VnCompanyRefCode char(20),
in In_VnVATCode char(20),
in In_VnBankId char(20),
in In_VnBankBrId char(20),
in In_VnAccNoBank char(30),
in In_VnCompanyName char(100),
in In_VnCoAddress char(50),
in In_VnCoContactNo char(20),
in In_VnCoFaxNo char(20),
in In_VnAuthorised char(60),
in In_VnAuthorisedPosition char(20),
in In_VnPreparedBy char(60),
in In_VnCompensation double,
in In_VnCompanyForeignName char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from VnTaxEmployer where VnTaxEmployerId = In_VnTaxEmployerId) then
    update VnTaxEmployer set
      VnCompanyRefCode = In_VnCompanyRefCode,
      VnVATCode = In_VnVATCode,
      VnBankId = In_VnBankId,
      VnBankBrId = In_VnBankBrId,
      VnAccNoBank = In_VnAccNoBank,
      VnCompanyName = In_VnCompanyName,
      VnCoAddress = In_VnCoAddress,
      VnCoContactNo = In_VnCoContactNo,
      VnCoFaxNo = In_VnCoFaxNo,
      VnAuthorised = In_VnAuthorised,
      VnAuthorisedPosition = In_VnAuthorisedPosition,
      VnPreparedBy = In_VnPreparedBy,
      VnCompensation = In_VnCompensation,
      VnCompanyForeignName = In_VnCompanyForeignName where
      VnTaxEmployerId = In_VnTaxEmployerId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateVnTaxPolicy(
in In_VnTaxPolicyId char(20),
in In_VnTaxPolicyDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from VnTaxPolicy where
      VnTaxPolicyId = In_VnTaxPolicyId) then
    update VnTaxPolicy set
      VnTaxPolicyDesc = In_VnTaxPolicyDesc where
      VnTaxPolicyId = In_VnTaxPolicyId;
    commit work;
    set Out_ErrorCode=1
  end if
end
;

create procedure dba.UpdateVnTaxProgression(
in In_VnTaxProgSysId integer,
in In_VnTaxPolicyId char(20),
in In_VnTaxProgDate date,
out Out_ErrorCode integer)
begin
  if exists(select* from VnTaxProgression where
      VnTaxProgSysId = In_VnTaxProgSysId) then
    update VnTaxProgression set
      VnTaxPolicyId = In_VnTaxPolicyId where
      VnTaxProgDate = In_VnTaxProgDate;
    commit work;
    set Out_ErrorCode=1
  end if
end
;

create procedure dba.UpdateVnTaxRecord(
in In_PersonalSysId integer,
in In_VnTaxRecYear integer,
in In_VnTaxPolicyId char(20),
in In_VnTaxEmployerId char(20),
in In_VnTaxNoOfMonth integer,
in In_VnTaxTaxable double,
in In_VnTaxSalary double,
in In_VnTaxContribution double,
in In_VnTaxBonus double,
in In_VnTaxOthers double,
in In_VnTaxWithheld double,
in In_VnTaxFinalisedTaxAmt double,
in In_VnTaxAnnualEstTaxAmt double,
in In_VnTaxGrossUpAmount double,
in In_VnTaxLatestResidence char(20),
in In_VnReqFinalizeTax smallint,
out Out_ErrorCode integer)
begin
  if not exists(select* from VnTaxRecord where PersonalSysId = In_PersonalSysId and VnTaxRecYear = In_VnTaxRecYear) then
    set Out_ErrorCode=-1; // Record not exist
    return
  elseif not In_VnTaxEmployerId = any(select VnTaxEmployerId from VnTaxEmployer) then
    set Out_ErrorCode=-2; // VnTaxEmployerId not exist
    return
  elseif not In_VnTaxPolicyId = any(select VnTaxPolicyId from VnTaxPolicy) then
    set Out_ErrorCode=-3; // VnTaxEmployerId not exist
    return
  else
    update VnTaxRecord set
      VnTaxPolicyId = In_VnTaxPolicyId,
      VnTaxEmployerId = In_VnTaxEmployerId,
      VnTaxNoOfMonth = In_VnTaxNoOfMonth,
      VnTaxTaxable = In_VnTaxTaxable,
      VnTaxSalary = In_VnTaxSalary,
      VnTaxContribution = In_VnTaxContribution,
      VnTaxBonus = In_VnTaxBonus,
      VnTaxOthers = In_VnTaxOthers,
      VnTaxWithheld = In_VnTaxWithheld,
      VnTaxFinalisedTaxAmt = In_VnTaxFinalisedTaxAmt,
      VnTaxAnnualEstTaxAmt = In_VnTaxAnnualEstTaxAmt,
      VnTaxGrossUpAmount = In_VnTaxGrossUpAmount,
      VnTaxLatestResidence = In_VnTaxLatestResidence,
      VnReqFinalizeTax = In_VnReqFinalizeTax where
      PersonalSysId = In_PersonalSysId and
      VnTaxRecYear = In_VnTaxRecYear;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;

create function dba.FGetVnERSubmitPeriodPenalty(
in In_Year integer,
in In_BranchId char(20),
in In_Period integer)
returns double
begin
  declare Out_VnERSubmitPeriodPenalty double;
  select Sum(VnERSubmitPenalty) into Out_VnERSubmitPeriodPenalty
    from VnERSubmitRecord where
    VnERSubmitYear = In_Year and
    VnERSubmitPeriod <= In_Period and
    VnERSubmitBranchId = In_BranchId;
  if Out_VnERSubmitPeriodPenalty is null then set Out_VnERSubmitPeriodPenalty=FGetVnERSubmitPrevPenalty(In_Year,In_BranchId)
  else set Out_VnERSubmitPeriodPenalty=Out_VnERSubmitPeriodPenalty+FGetVnERSubmitPrevPenalty(In_Year,In_BranchId)
  end if;
  return(Out_VnERSubmitPeriodPenalty)
end
;

create function dba.FGetVnERSubmitPrevPenalty(
in In_Year integer,
in In_BranchId char(20))
returns double
begin
  declare Out_VnERSubmitPrevPenalty double;
  select VnERSubmitPrevPenalty into Out_VnERSubmitPrevPenalty
    from VnERSubmission where
    VnERSubmitYear = In_Year and
    VnERSubmitBranchId = In_BranchId;
  if Out_VnERSubmitPrevPenalty is null then set Out_VnERSubmitPrevPenalty=0
  end if;
  return(Out_VnERSubmitPrevPenalty)
end
;

create function dba.FGetVnTaxReport10Column4(
in In_PersonalSysId integer,
in In_VnTaxRecYear integer,
in In_SectionCode integer)
returns double
begin
  // this function tries to get the amount of tax of a person that has to be put in
  // tax report 10/tntx section c.
  //
  // the complication is: when a person changes his residence status, his pay records
  //   has to be split to be put into different section.
  //
  // assumption:
  // 1. change of residencestatus can only happen once in a year
  // 2. VnReqFinalizeTax has to be 0 before change
  // 3. VnReqFinalizeTax has to be 1 after change, except when changing from non-staff to non-staff
  // WIP: check for eligible residence status
  declare VnReqFinalizeTax smallint;
  declare HasResidenceStatusChange smallint;
  declare Temp_StartPeriod integer;
  declare Temp_EndPeriod integer;
  declare Out_Amount double;
  set Out_Amount=0;
  select VnReqFinalizeTax into VnReqFinalizeTax from VnTaxRecord where
    PersonalSysId = In_PersonalSysId and VnTaxRecYear = In_VnTaxRecYear;
  set HasResidenceStatusChange=IsVnResidenceStatusChange(In_PersonalSysId,In_VnTaxRecYear);
  //
  // Main algorithm
  //
  if In_SectionCode = 1 then
    // if person is not required to finalize tax
    if VnReqFinalizeTax = 0 then
      // EPE finalize the tax amount for them. return the annual finalized tax amount
      select VnTaxAnnualEstTaxAmt into Out_Amount from VnTaxRecord where
        VnTaxLatestResidence in('Res Citizen','Res Citizen (IT)','Res Expatriate') and
        PersonalSysId = In_PersonalSysId and VnTaxRecYear = In_VnTaxRecYear;
      return Out_Amount
    else
      return 0
    end if
  elseif In_SectionCode = 2 then
    // if person is not required to finalize tax, he is not eligible in section 2
    if VnReqFinalizeTax = 0 then
      return 0
    else
      select VnTaxAnnualEstTaxAmt into Out_Amount from VnTaxRecord where
        PersonalSysId = In_PersonalSysId and VnTaxRecYear = In_VnTaxRecYear;
      return Out_Amount
    end if
  elseif In_SectionCode = 3 then
    if VnReqFinalizeTax = 0 then
      select VnTaxAnnualEstTaxAmt into Out_Amount from VnTaxRecord where
        VnTaxLatestResidence in('Non Staff Citizen','Non Staff Expatriate') and
        PersonalSysId = In_PersonalSysId and VnTaxRecYear = In_VnTaxRecYear;
      return Out_Amount
    else
      return Out_Amount
    end if
  elseif In_SectionCode = 4 then
    // if person is not required to finalize tax
    if VnReqFinalizeTax = 0 then
      // EPE finalize the tax amount for them. return the annual finalized tax amount
      select VnTaxAnnualEstTaxAmt into Out_Amount from VnTaxRecord where
        VnTaxLatestResidence in('Non Res Citizen','Non Res Expatriate') and
        PersonalSysId = In_PersonalSysId and VnTaxRecYear = In_VnTaxRecYear;
      return Out_Amount
    else
      return 0
    end if
  elseif In_SectionCode = 6 then
    return 0
  end if;
  return 0
end
;

create function dba.IsVnResidenceStatusChange(
in In_PersonalSysId integer,
in In_VnTaxRecYear integer)
returns smallint
begin
  declare Temp_Count integer;
  select count(distinct TaxCategory) into Temp_Count from PeriodPolicySummary where
    EmployeeSysId = 
    any(select EmployeeSysId from VnTaxEmployee where
      PersonalSysId = In_PersonalSysId and VnTaxRecYear = In_VnTaxRecYear) and
    PayRecYear = In_VnTaxRecYear;
  if Temp_Count > 1 then
    return 1
  end if;
  return 0
end
;

create function dba.FGetVnTaxProgSysIdAtDate(
in In_VnTaxPolicyId char(20),
in In_CutOffDate date)
returns integer
begin
  declare Out_VnTaxProgSysId double;
  select first VnTaxProgSysId into Out_VnTaxProgSysId from
    VnTaxProgression where
    VnTaxPolicyId = In_VnTaxPolicyId and
    VnTaxProgDate <= In_CutOffDate order by
    VnTaxProgDate desc;
  return Out_VnTaxProgSysId
end
;

create function dba.FGetDecodeLocalStr(
in In_RefStr char(255))
returns char(255) begin
  declare RefStr char(255);
  declare NewRefStr char(255);
  declare DecodeStr char(255);
  declare RefStrLength integer;
  declare StartStr integer;
  declare EndStr integer;
  set RefStr=In_RefStr;
  set DecodeStr='';
  set RefStrLength=LENGTH(RefStr);
  if RefStrLength is null or RefStrLength = 0 then return ''
  end if;
  set StartStr=LOCATE(RefStr,'[',1);
  if StartStr = 0 then return In_RefStr
  end if;
  set EndStr=LOCATE(RefStr,']',StartStr);
  if EndStr = 0 then return In_RefStr
  end if;
  set DecodeStr=SUBSTRING(RefStr,1,StartStr-1);
  return DecodeStr
end
;

create function dba.FGetDecodeForeignStr(
in In_RefStr char(255),
in In_StrIndex integer)
returns char(255) begin
  declare Cnt integer;
  declare RefStr char(255);
  declare NewRefStr char(255);
  declare DecodeStr char(255);
  declare RefStrLength integer;
  declare StartStr integer;
  declare EndStr integer;
  set RefStr=In_RefStr;
  set Cnt=In_StrIndex;
  set DecodeStr='';
  while Cnt > 0 loop
    set RefStrLength=LENGTH(RefStr);
    if RefStrLength is null or RefStrLength = 0 then return ''
    end if;
    set StartStr=LOCATE(RefStr,'[',1);
    if StartStr = 0 then return In_RefStr
    end if;
    set EndStr=LOCATE(RefStr,']',StartStr);
    if EndStr = 0 then return In_RefStr
    end if;
    set DecodeStr=SUBSTRING(RefStr,StartStr+1,EndStr-StartStr-1);
    set NewRefStr=STUFF(RefStr,1,EndStr,' ');
    set RefStr=NewRefStr;
    set Cnt=Cnt-1
  end loop;
  if DecodeStr = '' then
    set DecodeStr=FGetDecodeLocalStr(In_RefStr)
  end if;
  return DecodeStr
end
;

create function dba.FGetVnERSubmitPrevAdj(
in In_Year integer,
in In_BranchId char(20))
returns double
begin
  declare Out_VnERSubmitPrevAdj double;
  select VnERSubmitPrevAdj into Out_VnERSubmitPrevAdj
    from VnERSubmission where
    VnERSubmitYear = In_Year and
    VnERSubmitBranchId = In_BranchId;
  if Out_VnERSubmitPrevAdj is null then set Out_VnERSubmitPrevAdj=0
  end if;
  return(Out_VnERSubmitPrevAdj)
end
;

create function dba.FGetVnERSubmitPeriodAdj(
in In_Year integer,
in In_BranchId char(20),
in In_Period integer)
returns double
begin
  declare Out_VnERSubmitPeriodAdj double;
  select Sum(VnERSubmitAdj) into Out_VnERSubmitPeriodAdj
    from VnERSubmitRecord where
    VnERSubmitYear = In_Year and
    VnERSubmitPeriod <= In_Period and
    VnERSubmitBranchId = In_BranchId;
  if Out_VnERSubmitPeriodAdj is null then set Out_VnERSubmitPeriodAdj=FGetVnERSubmitPrevAdj(In_Year,In_BranchId)
  else set Out_VnERSubmitPeriodAdj=Out_VnERSubmitPeriodAdj+FGetVnERSubmitPrevAdj(In_Year,In_BranchId)
  end if;
  return(Out_VnERSubmitPeriodAdj)
end
;

create procedure DBA.DeleteSIHIGovtProgression(
in In_SIHIGovtProgDate date)
begin
  if exists(select* from SIHIGovtProgression where
      SIHIGovtProgDate = In_SIHIGovtProgDate) then
    delete from SIHIGovtProgression where
      SIHIGovtProgDate = In_SIHIGovtProgDate;
    commit work
  end if
end
;

create procedure DBA.InsertNewSIHIGovtProgression(
in In_SIHIGovtProgDate date,
in In_SIKeptByCompany double,
in In_SIHIProgRemarks char(100))
begin
  if not exists(select* from SIHIGovtProgression where
      SIHIGovtProgDate = In_SIHIGovtProgDate) then
    insert into SIHIGovtProgression(SIHIGovtProgDate,SIKeptByCompany,SIHIProgRemarks) values(
      In_SIHIGovtProgDate,In_SIKeptByCompany,In_SIHIProgRemarks);
    commit work
  end if
end
;

create procedure DBA.UpdateSIHIGovtProgression(
in In_SIHIGovtProgDate date,
in In_SIKeptByCompany double,
in In_SIHIProgRemarks char(100))
begin
  if exists(select* from SIHIGovtProgression where
      SIHIGovtProgDate = In_SIHIGovtProgDate) then
    update SIHIGovtProgression set
      SIHIGovtProgression.SIKeptByCompany = In_SIKeptByCompany,
      SIHIGovtProgression.SIHIProgRemarks = In_SIHIProgRemarks where
      SIHIGovtProgression.SIHIGovtProgDate = In_SIHIGovtProgDate;
    commit work
  end if
end
;


create function dba.FGetVnERSubmitPeriodKeptByCompany(
in In_Year integer,
in In_BranchId char(20),
in In_Period integer)
returns double
begin
  declare Out_CappedSIWage double;
  declare Out_SIKeptByCompany double;
  declare Out_VnERSubmitPeriodKeptByCompany double;
  select FConvertNull(sum(SDFWage)) into Out_CappedSIWage
    from PeriodPolicySummary where
    PayRecYear = In_Year and
    PayRecPeriod <= In_Period and
    SDFWage > 0 and
    (select PayBranchId from PayPeriodRecord where
      PayPeriodRecord.EmployeeSysId = PeriodPolicySummary.EmployeeSysId and
      PayPeriodRecord.PayRecYear = PeriodPolicySummary.PayRecYear and
      PayPeriodRecord.PayRecPeriod = PeriodPolicySummary.PayRecPeriod) = In_BranchId;
  select first SIKeptByCompany into Out_SIKeptByCompany
    from SIHIGovtProgression where
    SIHIGovtProgDate <= dateadd(day,-1,dateadd(month,1,str(In_Year) || '-' || str(In_Period) || '-01')) order by
    SIHIGovtProgDate desc;
  set Out_VnERSubmitPeriodKeptByCompany=(Out_CappedSIWage*Out_SIKeptByCompany/100)+FGetVnERSubmitPrevKeptByCompany(In_Year,In_BranchId);
  return(Out_VnERSubmitPeriodKeptByCompany)
end
;

create function dba.FGetVnERSubmitPeriodRemainingAmt(
in In_Year integer,
in In_BranchId char(20),
in In_Period integer)
returns double
begin
  declare Out_VnERSubmitPeriodRemainingAmt double;
  select FConvertNull(sum(VnERSubmitRemainingAmt)) into Out_VnERSubmitPeriodRemainingAmt
    from VnERSubmitRecord where
    VnERSubmitYear = In_Year and
    VnERSubmitPeriod <= In_Period and
    VnERSubmitBranchId = In_BranchId;
  set Out_VnERSubmitPeriodRemainingAmt=Out_VnERSubmitPeriodRemainingAmt+FGetVnERSubmitPrevRemainingAmt(In_Year,In_BranchId);
  return(Out_VnERSubmitPeriodRemainingAmt)
end
;


create function dba.FGetVnERSubmitPrevKeptByCompany(
in In_Year integer,
in In_BranchId char(20))
returns double
begin
  declare Out_VnERSubmitPrevKeptByCompany double;
  select VnERSubmitPrevKeptByCompany into Out_VnERSubmitPrevKeptByCompany
    from VnERSubmission where
    VnERSubmitYear = In_Year and
    VnERSubmitBranchId = In_BranchId;
  if Out_VnERSubmitPrevKeptByCompany is null then set Out_VnERSubmitPrevKeptByCompany=0
  end if;
  return(Out_VnERSubmitPrevKeptByCompany)
end
;

create function dba.FGetVnERSubmitPrevRemainingAmt(
in In_Year integer,
in In_BranchId char(20))
returns double
begin
  declare Out_VnERSubmitPrevRemainingAmt double;
  select FConvertNull(VnERSubmitPrevRemainingAmt) into Out_VnERSubmitPrevRemainingAmt
    from VnERSubmission where
    VnERSubmitYear = In_Year and
    VnERSubmitBranchId = In_BranchId;
  return(Out_VnERSubmitPrevRemainingAmt)
end
;

Commit work;

