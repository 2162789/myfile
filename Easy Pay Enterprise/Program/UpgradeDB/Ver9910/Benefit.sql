
create procedure dba.DeleteBenefitDetails(
in In_EmployeeSysId integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from BenefitDetails where EmployeeSysId = In_EmployeeSysId) then
    set Out_ErrorCode=-1; // EmployeeSysId not exist
    return
  else
    //
    //Delete Insurance
    //
    DeleteInsuranceLoop: for InsuranceFor as Insurancecurs dynamic scroll cursor for
      select InsuranceSysId as In_InsuranceSysId from Insurance where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteInsurance(In_InsuranceSysId) end for;
    //
    //Delete InsurGroup
    //
    DeleteInsuranceGroupLoop: for InsuranceGroupFor as InsuranceGroupcurs dynamic scroll cursor for
      select InsurGroupSysId as In_InsurGroupSysId from InsurGroup where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteInsurGroup(In_InsurGroupSysId) end for;
    //
    //Delete Benefit Details
    //
    delete from BenefitDetails where EmployeeSysId = In_EmployeeSysId;
    commit work
  end if;
  if exists(select* from BenefitDetails where EmployeeSysId = In_EmployeeSysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.DeleteInsurAttach(
in In_InsurAttachSysId integer,
in In_InsurPlanProgSysId integer,
in In_InsurPlanId char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from InsurAttach where InsurAttachSysId = In_InsurAttachSysId and InsurPlanProgSysId = In_InsurPlanProgSysId and InsurPlanId = In_InsurPlanId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    delete from InsurAttach where InsurAttachSysId = In_InsurAttachSysId and InsurPlanProgSysId = In_InsurPlanProgSysId and InsurPlanId = In_InsurPlanId;
    commit work
  end if;
  if exists(select* from InsurAttach where InsurAttachSysId = In_InsurAttachSysId and InsurPlanProgSysId = In_InsurPlanProgSysId and InsurPlanId = In_InsurPlanId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;


create procedure dba.DeleteInsurBenefit(
in In_InsurBenefitCode char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from InsurBenefit where InsurBenefit.InsurBenefitCode = In_InsurBenefitCode) then
    if not exists(select* from InsurFamilyBenefit where
        InsurFamilyBenefit.InsurBenefitCode = In_InsurBenefitCode) then
      if not exists(select* from InsurClaim where
          InsurClaim.InsurBenefitCode = In_InsurBenefitCode) then
        if not exists(select* from InsurCoverage where
            InsurCoverage.InsurBenefitCode = In_InsurBenefitCode) then
          delete from InsurBenefit where InsurBenefit.InsurBenefitCode = In_InsurBenefitCode;
          commit work
        end if
      end if
    end if;
    if exists(select* from InsurBenefit where InsurBenefit.InsurBenefitCode = In_InsurBenefitCode) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteInsurPolicy(
in In_InsurPolicyId char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from InsurPolicy where InsurPolicyId = In_InsurPolicyId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  // if not group policy, and policy exists in insurance
  elseif((select InsurPolicyGroup from InsurPolicy where InsurPolicyId = In_InsurPolicyId) = 0 and exists(select* from Insurance where InsurPolicyId = In_InsurPolicyId)) then
    set Out_ErrorCode=-2; // Record in use
    return
  else
    for DeleteInsurProgLoop as Cur_DeleteInsurProg dynamic scroll cursor for
      select InsurPlanProgSysId as Get_InsurPlanProgSysId from InsurProg where InsurPolicyId = In_InsurPolicyId do
      call DeleteInsurProg(Get_InsurPlanProgSysId) end for;
    delete from InsurPolicy where
      InsurPolicyId = In_InsurPolicyId;
    commit work
  end if;
  if exists(select* from InsurPolicy where InsurPolicyId = In_InsurPolicyId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.DeleteInsurProg(
in In_InsurPlanProgSysId integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from InsurProg where InsurPlanProgSysId = In_InsurPlanProgSysId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    for DeleteInsurProgDetailsLoop as Cur_DeleteInsurProgDetails dynamic scroll cursor for
      select InsurPlanId as Get_InsurPlanId from InsurProgDetails where InsurPlanProgSysId = In_InsurPlanProgSysId do
      call DeleteInsurProgDetails(In_InsurPlanProgSysId,Get_InsurPlanId) end for;
    delete from InsurProg where InsurPlanProgSysId = In_InsurPlanProgSysId;
    commit work
  end if;
  if exists(select* from InsurProg where InsurPlanProgSysId = In_InsurPlanProgSysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;


create procedure dba.DeleteInsurProgDetails(
in In_InsurPlanProgSysId integer,
in In_InsurPlanId char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from InsurProgDetails where InsurPlanProgSysId = In_InsurPlanProgSysId and InsurPlanId = In_InsurPlanId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    // delete children
    for DeleteInsurAttachLoop as Cur_DeleteInsurAttach dynamic scroll cursor for
      select InsurAttachSysId as Get_InsurAttachSysId from InsurAttach where InsurPlanProgSysId = In_InsurPlanProgSysId and InsurPlanId = In_InsurPlanId do
      call DeleteInsurAttach(Get_InsurAttachSysId,In_InsurPlanProgSysId,In_InsurPlanId) end for;
    delete from InsurRemarks where InsurPlanProgSysId = In_InsurPlanProgSysId and InsurPlanId = In_InsurPlanId;
    delete from InsurCoverage where InsurPlanProgSysId = In_InsurPlanProgSysId and InsurPlanId = In_InsurPlanId;
    for DeleteInsurGroupLoop as Cur_DeleteInsurGroup dynamic scroll cursor for
      select InsurGroupSysId as Get_InsurGroupSysId from InsurGroup where InsurPlanProgSysId = In_InsurPlanProgSysId and InsurPlanId = In_InsurPlanId do
      for DeleteInsuranceLoop as Cur_DeleteInsurance dynamic scroll cursor for
        select InsuranceSysId as Get_InsuranceSysId from Insurance where InsurGroupSysId = Get_InsurGroupSysId do
        call DeleteInsurance(Get_InsuranceSysId) end for;
      call DeleteInsurGroup(Get_InsurGroupSysId) end for;
    // delete record
    delete from InsurProgDetails where InsurPlanProgSysId = In_InsurPlanProgSysId and InsurPlanId = In_InsurPlanId;
    commit work
  end if;
  if exists(select* from InsurProgDetails where InsurPlanProgSysId = In_InsurPlanProgSysId and InsurPlanId = In_InsurPlanId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;


create procedure dba.InsertNewBenefitDetails(
in In_EmployeeSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from BenefitDetails where EmployeeSysId = In_EmployeeSysId) then
    set Out_ErrorCode=-1; // Record exists
    return
  else
    insert into BenefitDetails(EmployeeSysId) values(In_EmployeeSysId);
    commit work
  end if;
  if not exists(select* from BenefitDetails where EmployeeSysId = In_EmployeeSysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;


create procedure dba.InsertNewInsuranceAttach(
in In_InsuranceSysId integer,
in In_AttachFileType char(20),
in In_AttachDate date,
in In_Remarks char(100),
out Out_InsuranceAttachSysId integer,
out Out_ErrorCode integer)
begin
  select max(InsuranceAttachSysId) into Out_InsuranceAttachSysId from InsuranceAttach where
    InsuranceAttach.InsuranceSysId = In_InsuranceSysId;
  if(Out_InsuranceAttachSysId is null) then
    set Out_InsuranceAttachSysId=1
  else
    set Out_InsuranceAttachSysId=Out_InsuranceAttachSysId+1
  end if;
  if not exists(select* from InsuranceAttach where
      InsuranceAttach.InsuranceSysId = In_InsuranceSysId and
      InsuranceAttach.InsuranceAttachSysId = Out_InsuranceAttachSysId) then
    insert into InsuranceAttach(InsuranceSysId,
      InsuranceAttachSysId,
      AttachFileType,
      AttachDate,
      Remarks) values(In_InsuranceSysId,
      Out_InsuranceAttachSysId,
      In_AttachFileType,
      In_AttachDate,
      In_Remarks);
    commit work;
    if not exists(select* from InsuranceAttach where
        InsuranceAttach.InsuranceSysId = In_InsuranceSysId and
        InsuranceAttach.InsuranceAttachSysId = Out_InsuranceAttachSysId) then
      set Out_InsuranceAttachSysId=null;
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_InsuranceAttachSysId=null;
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewInsurBenefit(
in In_InsurBenefitCode char(20),
in In_InsurBenefitDesc char(200),
out Out_ErrorCode integer)
begin
  if not exists(select* from InsurBenefit where InsurBenefit.InsurBenefitCode = In_InsurBenefitCode) then
    insert into InsurBenefit(InsurBenefitCode,InsurBenefitDesc) values(
      In_InsurBenefitCode,In_InsurBenefitDesc);
    commit work;
    if not exists(select* from InsurBenefit where InsurBenefit.InsurBenefitCode = In_InsurBenefitCode) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewInsurPolicy(
in In_InsurPolicyId char(20),
in In_InsurPolicyGroup smallint,
in In_InsurPolicyDesc char(200),
in In_InsurPolicyOrgCode char(20),
in In_InsurPolicyNo char(30),
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from InsurPolicy where InsurPolicyId = In_InsurPolicyId) then
    set Out_ErrorCode=-1; // Record exists
    return
  else
    insert into InsurPolicy(InsurPolicyId,
      InsurPolicyGroup,InsurPolicyDesc,
      InsurPolicyOrgCode,InsurPolicyNo,Remarks) values(
      In_InsurPolicyId,In_InsurPolicyGroup,
      In_InsurPolicyDesc,In_InsurPolicyOrgCode,
      In_InsurPolicyNo,In_Remarks);
    commit work
  end if;
  if not exists(select* from InsurPolicy where InsurPolicyId = In_InsurPolicyId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;


create procedure dba.InsertNewInsurProg(
in In_InsurPolicyId char(20),
in In_InsurFromDate date,
in In_InsurToDate date,
in In_NoOfEmployee integer,
in In_PaymentFreq char(20),
in In_PayrollStartPeriod integer,
in In_PayrollStartYear integer,
in In_PayrollEndPeriod integer,
in In_PayrollEndYear integer,
in In_PaymentType char(20),
out Out_ErrorCode integer)
begin
  declare Out_InsurPlanProgSysId integer;
  if not exists(select* from InsurPolicy where InsurPolicyId = In_InsurPolicyId) then
    set Out_ErrorCode=-1; // no parent
    return
  else
    insert into InsurProg(InsurPolicyId,
      InsurFromDate,InsurToDate,
      NoOfEmployee,PaymentFreq,
      PayrollStartPeriod,PayrollStartYear,
      PayrollEndPeriod,PayrollEndYear,PaymentType) values(
      In_InsurPolicyId,In_InsurFromDate,In_InsurToDate,
      In_NoOfEmployee,In_PaymentFreq,
      In_PayrollStartPeriod,In_PayrollStartYear,
      In_PayrollEndPeriod,In_PayrollEndYear,In_PaymentType);
    commit work
  end if;
  if not exists(select InsurPlanProgSysId from InsurProg where
      InsurPolicyId = In_InsurPolicyId and
      InsurFromDate = In_InsurFromDate and
      InsurToDate = In_InsurToDate and
      NoOfEmployee = In_NoOfEmployee and
      PaymentFreq = In_PaymentFreq and
      PaymentType = In_PaymentType) then
    set Out_ErrorCode=0; // System error
    return
  else
    select InsurPlanProgSysId into Out_InsurPlanProgSysId from InsurProg where
      InsurPolicyId = In_InsurPolicyId and
      InsurFromDate = In_InsurFromDate and
      InsurToDate = In_InsurToDate and
      NoOfEmployee = In_NoOfEmployee and
      PaymentFreq = In_PaymentFreq;
    set Out_ErrorCode=Out_InsurPlanProgSysId // Successful
  end if
end
;


create procedure dba.InsertNewInsurProgDetails(
in In_InsurPlanProgSysId integer,
in In_InsurPlanId char(20),
in In_PayrollPayElementId char(20),
in In_PayrollSubPeriod integer,
out Out_ErrorCode integer)
begin
  if exists(select* from InsurProgDetails where InsurPlanProgSysId = In_InsurPlanProgSysId and InsurPlanId = In_InsurPlanId) then
    set Out_ErrorCode=-1; // Record exists
    return
  else
    insert into InsurProgDetails(InsurPlanProgSysId,
      InsurPlanId,PayrollPayElementId,PayrollSubPeriod) values(
      In_InsurPlanProgSysId,In_InsurPlanId,
      In_PayrollPayElementId,In_PayrollSubPeriod);
    commit work
  end if;
  if not exists(select* from InsurProgDetails where InsurPlanProgSysId = In_InsurPlanProgSysId and InsurPlanId = In_InsurPlanId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;


create procedure dba.UpdateBenefitDetails(
in In_EmployeeSysId integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from BenefitDetails where EmployeeSysId = In_EmployeeSysId) then
    set Out_ErrorCode=-1; // EmployeeSysId not exist
    return
  else
    /*
    update BenefitDetails set
    ??? where
    EmployeeSysId = In_EmployeeSysId;
    commit work
    */
    select 1
  end if;
  set Out_ErrorCode=1 // Successful
end
;

create procedure dba.UpdateInsurAttach(
in In_InsurAttachSysId integer,
in In_InsurPlanProgSysId integer,
in In_InsurPlanId char(20),
in In_AttachFileType char(20),
in In_Remarks char(100),
in In_AttachDate date,
out Out_ErrorCode integer)
begin
  if not exists(select* from InsurAttach where InsurAttachSysId = In_InsurAttachSysId and InsurPlanProgSysId = In_InsurPlanProgSysId and InsurPlanId = In_InsurPlanId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    update InsurAttach set
      AttachFileType = In_AttachFileType,
      Remarks = In_Remarks,
      AttachDate = In_AttachDate where
      InsurAttachSysId = In_InsurAttachSysId and
      InsurPlanProgSysId = In_InsurPlanProgSysId and
      InsurPlanId = In_InsurPlanId;
    commit work
  end if;
  set Out_ErrorCode=In_InsurAttachSysId // Successful
end
;


create procedure dba.UpdateInsurBenefit(
in In_InsurBenefitCode char(20),
in In_InsurBenefitDesc char(200),
out Out_ErrorCode integer)
begin
  if exists(select* from InsurBenefit where InsurBenefitCode = In_InsurBenefitCode) then
    update InsurBenefit set
      InsurBenefitDesc = In_InsurBenefitDesc where
      InsurBenefitCode = In_InsurBenefitCode;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateInsurPolicy(
in In_InsurPolicyId char(20),
in In_InsurPolicyGroup smallint,
in In_InsurPolicyDesc char(200),
in In_InsurPolicyOrgCode char(20),
in In_InsurPolicyNo char(30),
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from InsurPolicy where InsurPolicyId = In_InsurPolicyId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    update InsurPolicy set
      InsurPolicyGroup = In_InsurPolicyGroup,
      InsurPolicyDesc = In_InsurPolicyDesc,
      InsurPolicyOrgCode = In_InsurPolicyOrgCode,
      InsurPolicyNo = In_InsurPolicyNo,
      Remarks = In_Remarks where
      InsurPolicyId = In_InsurPolicyId;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;

create procedure dba.UpdateInsurProgDetails(
in In_InsurPlanProgSysId integer,
in In_InsurPlanId char(20),
in In_PayrollPayElementId char(20),
in In_PayrollSubPeriod integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from InsurProgDetails where InsurPlanProgSysId = In_InsurPlanProgSysId and InsurPlanId = In_InsurPlanId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    update InsurProgDetails set
      PayrollPayElementId = In_PayrollPayElementId,
      PayrollSubPeriod = In_PayrollSubPeriod where
      InsurPlanProgSysId = In_InsurPlanProgSysId and
      InsurPlanId = In_InsurPlanId;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;

create procedure DBA.ASQLRenewInsurProg(
in In_NewInsurPlanProgSysId integer,
out Out_ErrorCode integer)
begin
  declare Last_InsurPlanProgSysId integer;
  declare New_InsurAttachSysId integer;
  declare New_InsurRemarksSysId integer;
  declare New_InsurCoverageSysId integer;
  declare New_InsurGroupSysId integer;
  declare New_InsuranceSysId integer;
  declare New_InsuranceAttachSysId integer;
  declare New_InsurFamilyAddSysId integer;
  declare New_InsurNomineeSysId integer;
  declare Curr_InsurPolicyId char(20);
  declare New_PayrollStartPeriod integer;
  declare New_PayrollStartYear integer;
  declare New_PayrollEndPeriod integer;
  declare New_PayrollEndYear integer;
  declare New_PaymentFreq char(20);
  declare New_PaymentType char(20);
  declare Temp_EmployeeSysId integer;
  declare Temp_InsurFromDate date;
  declare Temp_CessationDate date;
  declare New_PaymentCount integer;
  //
  // get data of NewInsurPlanProgSysId
  //
  select InsurPolicyId,InsurFromDate,PayrollStartPeriod,PayrollStartYear,PayrollEndPeriod,PayrollEndYear,PaymentFreq,PaymentType into Curr_InsurPolicyId,Temp_InsurFromDate,
    New_PayrollStartPeriod,New_PayrollStartYear,New_PayrollEndPeriod,New_PayrollEndYear,
    New_PaymentFreq,New_PaymentType from InsurProg where InsurPlanProgSysId = In_NewInsurPlanProgSysId;
  if New_PayrollStartPeriod > 0 and New_PayrollStartYear > 0 and New_PayrollEndPeriod > 0 and New_PayrollEndYear > 0 then
    set New_PaymentCount=DATEDIFF(Month,"DATE"(String(New_PayrollStartYear)+'-'+String(New_PayrollStartPeriod)+'-1'),"DATE"(String(New_PayrollEndYear)+'-'+String(New_PayrollEndPeriod)+'-1'))+1
  else
    set New_PaymentCount=0
  end if;
  //
  // get InsurPlanProgSysId which has the latest To Date
  //
  select first InsurPlanProgSysId into Last_InsurPlanProgSysId from InsurProg where InsurPolicyId = Curr_InsurPolicyId and InsurPlanProgSysId <> In_NewInsurPlanProgSysId order by InsurToDate desc;
  //
  // copy InsurProgDetails
  //
  CopyInsurProgDetailsLoop: for CopyInsurProgDetailsFor as cursInsurProgDetails dynamic scroll cursor for
    select InsurPlanId as Old_InsurPlanId from InsurProgDetails where InsurPlanProgSysId = Last_InsurPlanProgSysId do
    insert into InsurProgDetails(InsurPlanProgSysId,InsurPlanId,PayrollPayElementId,PayrollSubPeriod)
      select In_NewInsurPlanProgSysId,InsurPlanId,
        (if New_PaymentType = 'InsurPayByPayroll' then PayrollPayElementId else null endif) as Temp_PayrollPayElementId,
        (if New_PaymentType = 'InsurPayByPayroll' then PayrollSubPeriod else null endif) as Temp_PayrollSubPeriod from InsurProgDetails where
        InsurPlanProgSysId = Last_InsurPlanProgSysId and InsurPlanId = Old_InsurPlanId;
    //
    // copy InsurAttach
    //
    CopyInsurAttachLoop: for CopyInsurAttachFor as cursInsurAttach dynamic scroll cursor for
      select InsurAttachSysId as Old_InsurAttachSysId from InsurAttach where InsurPlanProgSysId = Last_InsurPlanProgSysId and InsurPlanId = Old_InsurPlanId do
      select max(InsurAttachSysId) into New_InsurAttachSysId from InsurAttach;
      if New_InsurAttachSysId is null then set New_InsurAttachSysId=1
      else set New_InsurAttachSysId=New_InsurAttachSysId+1
      end if;
      insert into InsurAttach(InsurAttachSysId,InsurPlanProgSysId,InsurPlanId,Attachment,AttachFileType,Remarks,AttachDate)
        select New_InsurAttachSysId,In_NewInsurPlanProgSysId,Old_InsurPlanId,Attachment,AttachFileType,Remarks,AttachDate from InsurAttach where
          InsurAttachSysId = Old_InsurAttachSysId and InsurPlanProgSysId = Last_InsurPlanProgSysId and InsurPlanId = Old_InsurPlanId end for;
    //
    // copy InsurRemarks
    //
    CopyInsurRemarksLoop: for CopyInsurRemarksFor as cursInsurRemarks dynamic scroll cursor for
      select InsurRemarksSysId as Old_InsurRemarksSysId from InsurRemarks where InsurPlanProgSysId = Last_InsurPlanProgSysId and InsurPlanId = Old_InsurPlanId do
      select max(InsurRemarksSysId) into New_InsurRemarksSysId from InsurRemarks;
      if New_InsurRemarksSysId is null then set New_InsurRemarksSysId=1
      else set New_InsurRemarksSysId=New_InsurRemarksSysId+1
      end if;
      insert into InsurRemarks(InsurRemarksSysId,InsurPlanProgSysId,InsurPlanId,InsurCaption,InsurDesc)
        select New_InsurRemarksSysId,In_NewInsurPlanProgSysId,Old_InsurPlanId,InsurCaption,InsurDesc from InsurRemarks where
          InsurRemarksSysId = Old_InsurRemarksSysId and InsurPlanProgSysId = Last_InsurPlanProgSysId and InsurPlanId = Old_InsurPlanId end for;
    //
    // copy InsurCoverage
    //
    CopyInsurCoverageLoop: for CopyInsurCoverageFor as cursInsurCoverage dynamic scroll cursor for
      select InsurCoverageSysId as Old_InsurCoverageSysId from InsurCoverage where InsurPlanProgSysId = Last_InsurPlanProgSysId and InsurPlanId = Old_InsurPlanId do
      select max(InsurCoverageSysId) into New_InsurCoverageSysId from InsurCoverage;
      if New_InsurCoverageSysId is null then set New_InsurCoverageSysId=1
      else set New_InsurCoverageSysId=New_InsurCoverageSysId+1
      end if;
      insert into InsurCoverage(InsurCoverageSysId,InsurPlanProgSysId,InsurPlanId,InsurBenefitCode,
        TotalYrPremium1,TotalYrPremium2,TotalYrPremium3,TotalYrPremium4,TotalYrPremium5,
        EmpYrPremium1,EmpYrPremium2,EmpYrPremium3,EmpYrPremium4,EmpYrPremium5,
        TotalMthPremium1,TotalMthPremium2,TotalMthPremium3,TotalMthPremium4,TotalMthPremium5,
        EmpMthPremium1,EmpMthPremium2,EmpMthPremium3,EmpMthPremium4,EmpMthPremium5,
        BasisCoverage1,BasisCoverage2,BasisCoverage3,BasisCoverage4,BasisCoverage5)
        select New_InsurCoverageSysId,In_NewInsurPlanProgSysId,Old_InsurPlanId,InsurBenefitCode,
          TotalYrPremium1,TotalYrPremium2,TotalYrPremium3,TotalYrPremium4,TotalYrPremium5,
          EmpYrPremium1,EmpYrPremium2,EmpYrPremium3,EmpYrPremium4,EmpYrPremium5,
          TotalMthPremium1,TotalMthPremium2,TotalMthPremium3,TotalMthPremium4,TotalMthPremium5,
          EmpMthPremium1,EmpMthPremium2,EmpMthPremium3,EmpMthPremium4,EmpMthPremium5,
          BasisCoverage1,BasisCoverage2,BasisCoverage3,BasisCoverage4,BasisCoverage5 from
          InsurCoverage where
          InsurCoverageSysId = Old_InsurCoverageSysId and InsurPlanProgSysId = Last_InsurPlanProgSysId and InsurPlanId = Old_InsurPlanId end for;
    //
    // copy InsurGroup
    //
    CopyInsurGroupLoop: for CopyInsurGroupFor as cursInsurGroup dynamic scroll cursor for
      select InsurGroupSysId as Old_InsurGroupSysId from InsurGroup where InsurPlanProgSysId = Last_InsurPlanProgSysId and InsurPlanId = Old_InsurPlanId do
      select max(InsurGroupSysId) into New_InsurGroupSysId from InsurGroup;
      if New_InsurGroupSysId is null then set New_InsurGroupSysId=1
      else set New_InsurGroupSysId=New_InsurGroupSysId+1
      end if;
      //
      // if employee not terminated
      //
      select EmployeeSysId into Temp_EmployeeSysId from InsurGroup where InsurGroupSysId = Old_InsurGroupSysId;
      select CessationDate into Temp_CessationDate from Employee where EmployeeSysId = Temp_EmployeeSysId;
      if(Temp_CessationDate is null or(Temp_CessationDate is not null and(FGetInvalidDate(Temp_CessationDate) = '' or Temp_CessationDate > Temp_InsurFromDate))) then
        insert into InsurGroup(InsurGroupSysId,EmployeeSysId,InsurPlanProgSysId,InsurPlanId,SelBasis1,SelBasis2,SelBasis3,SelBasis4,SelBasis5)
          select New_InsurGroupSysId,EmployeeSysId,In_NewInsurPlanProgSysId,Old_InsurPlanId,SelBasis1,SelBasis2,SelBasis3,SelBasis4,SelBasis5 from InsurGroup where
            InsurGroupSysId = Old_InsurGroupSysId;
        //
        // copy Insurance
        //
        CopyInsuranceLoop: for CopyInsurance as cursInsurance dynamic scroll cursor for
          select InsuranceSysId as Old_InsuranceSysId from Insurance where InsurGroupSysId = Old_InsurGroupSysId do
          select max(InsuranceSysId) into New_InsuranceSysId from Insurance;
          if New_InsuranceSysId is null then set New_InsuranceSysId=1
          else set New_InsuranceSysId=New_InsuranceSysId+1
          end if;
          insert into Insurance(InsuranceSysId,EmployeeSysId,InsurGroupSysId,InsurPolicyId,PayrollSubPeriod,PayrollStartPeriod,PayrollStartYear,PayrollEndPeriod,PayrollEndYear,PayrollPayElementId,PaymentCount,PaymentFreq,Remarks,PaymentType)
            select New_InsuranceSysId,EmployeeSysId,New_InsurGroupSysId,Curr_InsurPolicyId,
              (if New_PaymentType = 'InsurPayByPayroll' then PayrollSubPeriod else null endif) as Temp_PayrollSubPeriod,
              New_PayrollStartPeriod,New_PayrollStartYear,New_PayrollEndPeriod,New_PayrollEndYear,
              (if New_PaymentType = 'InsurPayByPayroll' then PayrollPayElementId else null endif) as Temp_PayrollPayElementId,
              New_PaymentCount,New_PaymentFreq,Remarks,New_PaymentType from Insurance where
              InsuranceSysId = Old_InsuranceSysId;
          //
          // copy InsuranceAttach
          //
          CopyInsuranceAttachLoop: for CopyInsuranceAttachFor as cursInsuranceAttach dynamic scroll cursor for
            select InsuranceAttachSysId as Old_InsuranceAttachSysId from InsuranceAttach where InsuranceSysId = Old_InsuranceSysId do
            select max(InsuranceAttachSysId) into New_InsuranceAttachSysId from InsuranceAttach;
            if New_InsuranceAttachSysId is null then set New_InsuranceAttachSysId=1
            else set New_InsuranceAttachSysId=New_InsuranceAttachSysId+1
            end if;
            insert into InsuranceAttach(InsuranceAttachSysId,InsuranceSysId,Attachment,AttachFileType,Remarks,AttachDate)
              select New_InsuranceAttachSysId,New_InsuranceSysId,Attachment,AttachFileType,Remarks,AttachDate from InsuranceAttach where
                InsuranceAttachSysId = Old_InsuranceAttachSysId and InsuranceSysId = Old_InsuranceSysId end for;
          //
          // copy InsurFamilyAdd
          //
          CopyInsurFamilyAddLoop: for CopyInsurFamilyAddFor as cursInsurFamilyAdd dynamic scroll cursor for
            select InsurFamilyAddSysId as Old_InsurFamilyAddSysId from InsurFamilyAdd where InsuranceSysId = Old_InsuranceSysId do
            select max(InsurFamilyAddSysId) into New_InsurFamilyAddSysId from InsurFamilyAdd;
            if New_InsurFamilyAddSysId is null then set New_InsurFamilyAddSysId=1
            else set New_InsurFamilyAddSysId=New_InsurFamilyAddSysId+1
            end if;
            insert into InsurFamilyAdd(InsurFamilyAddSysId,InsuranceSysId,FamilySysId,TotalPaidPremium,EmpPaidPremium,CoverageAmt,Remarks)
              select New_InsurFamilyAddSysId,New_InsuranceSysId,FamilySysId,TotalPaidPremium,EmpPaidPremium,CoverageAmt,Remarks from InsurFamilyAdd where
                InsurFamilyAddSysId = Old_InsurFamilyAddSysId and InsuranceSysId = Old_InsuranceSysId;
            //
            // copy InsurFamilyBenefit
            //
            CopyInsurFamilyBenefitLoop: for CopyInsurFamilyBenefitFor as cursInsurFamilyBenefit dynamic scroll cursor for
              select InsurBenefitCode as New_InsurBenefitCode from InsurFamilyBenefit where InsuranceSysId = Old_InsuranceSysId and InsurFamilyAddSysId = Old_InsurFamilyAddSysId do
              insert into InsurFamilyBenefit(InsurFamilyAddSysId,InsuranceSysId,New_InsurBenefitCode) values(
                New_InsurFamilyAddSysId,New_InsuranceSysId,New_InsurBenefitCode) end for;
            //
            // copy InsurNominee
            //
            CopyInsurNomineeLoop: for CopyInsurNomineeFor as cursInsurNominee dynamic scroll cursor for
              select InsurNomineeSysId as Old_InsurNomineeSysId from InsurNominee where InsuranceSysId = Old_InsuranceSysId and InsurFamilyAddSysId = Old_InsurFamilyAddSysId do
              select max(InsurNomineeSysId) into New_InsurNomineeSysId from InsurNominee;
              if New_InsurNomineeSysId is null then set New_InsurNomineeSysId=1
              else set New_InsurNomineeSysId=New_InsurNomineeSysId+1
              end if;
              insert into InsurNominee(InsurNomineeSysId,InsurFamilyAddSysId,InsuranceSysId,FamilySysId,BenefitPercent,Remarks)
                select New_InsurNomineeSysId,New_InsurFamilyAddSysId,New_InsuranceSysId,FamilySysId,BenefitPercent,Remarks from InsurNominee where
                  InsurNomineeSysId = Old_InsurNomineeSysId and InsurFamilyAddSysId = Old_InsurFamilyAddSysId and InsuranceSysId = Old_InsuranceSysId end for end for end for
      end if end for end for;
  commit work;
  set Out_ErrorCode=1
end
;

create procedure dba.DeleteInsurance(
in In_InsuranceSysId integer,
out Out_ErrorCode integer)
begin
  declare Out_AllowanceSGSPGenId char(30);
  if exists(select* from Insurance where Insurance.InsuranceSysId = In_InsuranceSysId) then
    if exists(select* from InsuranceAttach where InsuranceAttach.InsuranceSysId = In_InsuranceSysId) then
      delete from InsuranceAttach where InsuranceAttach.InsuranceSysId = In_InsuranceSysId;
      commit work
    end if;
    if exists(select* from InsurFamilyAdd where InsurFamilyAdd.InsuranceSysId = In_InsuranceSysId) then
      if exists(select* from InsurNominee where InsurNominee.InsuranceSysId = In_InsuranceSysId) then
        delete from InsurNominee where InsurNominee.InsuranceSysId = In_InsuranceSysId;
        commit work
      end if;
      if exists(select* from InsurClaim where InsurClaim.InsuranceSysId = In_InsuranceSysId) then
        delete from InsurClaim where InsurClaim.InsuranceSysId = In_InsuranceSysId;
        commit work
      end if;
      if exists(select* from InsurFamilyBenefit where InsurFamilyBenefit.InsuranceSysId = In_InsuranceSysId) then
        delete from InsurFamilyBenefit where InsurFamilyBenefit.InsuranceSysId = In_InsuranceSysId;
        commit work
      end if;
      delete from InsurFamilyAdd where InsurFamilyAdd.InsuranceSysId = In_InsuranceSysId;
      commit work
    end if;
    delete from Insurance where Insurance.InsuranceSysId = In_InsuranceSysId;
    commit work;
    if exists(select* from Insurance where Insurance.InsuranceSysId = In_InsuranceSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteInsuranceAttach(
in In_InsuranceSysId integer,
in In_InsuranceAttachSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from InsuranceAttach where
      InsuranceAttach.InsuranceSysId = In_InsuranceSysId and
      InsuranceAttach.InsuranceAttachSysId = In_InsuranceAttachSysId) then
    delete from InsuranceAttach where
      InsuranceAttach.InsuranceSysId = In_InsuranceSysId and
      InsuranceAttach.InsuranceAttachSysId = In_InsuranceAttachSysId;
    commit work;
    if exists(select* from InsuranceAttach where
        InsuranceAttach.InsuranceSysId = In_InsuranceSysId and
        InsuranceAttach.InsuranceAttachSysId = In_InsuranceAttachSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteInsurGroup(
in In_InsurGroupSysId integer,
out Out_ErrorCode integer)
begin
  delete from InsurGroup where InsurGroupSysId = In_InsurGroupSysId;
  commit work;
  set Out_ErrorCode=1
end
;

create procedure dba.DeleteInsurPlan(
in In_InsurPlanId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from InsurPlan where InsurPlan.InsurPlanId = In_InsurPlanId) then
    if not exists(select* from InsurProgDetails where
        InsurProgDetails.InsurPlanId = In_InsurPlanId) then
      delete from InsurPlan where InsurPlan.InsurPlanId = In_InsurPlanId;
      commit work
    end if;
    if exists(select* from InsurPlan where InsurPlan.InsurPlanId = In_InsurPlanId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create function dba.FGetBenefitKeyWordUserDefinedName(
in In_BenefitKeyWordId char(20))
returns char(100)
begin
  declare Out_BenefitKeyWordUserDefinedName char(100);
  select BenefitKeyWordUserDefinedName into Out_BenefitKeyWordUserDefinedName from Benefitkeyword where
    BenefitKeyWordId = In_BenefitKeyWordId;
  if(Out_BenefitKeyWordUserDefinedName is null or Out_BenefitKeyWordUserDefinedName = '') then
    return(In_BenefitKeyWordId)
  else return(Out_BenefitKeyWordUserDefinedName)
  end if
end
;

create function DBA.FGetSumPaidPremium(
in In_InsuranceSysId integer,
in In_PremiumType integer)
returns double
begin
  declare Out_SumPaidPremium double;
  if(In_PremiumType = 0) then
    select sum(TotalPaidPremium) into Out_SumPaidPremium from InsurFamilyAdd where
      InsuranceSysId = In_InsuranceSysId
  else
    select sum(EmpPaidPremium) into Out_SumPaidPremium from InsurFamilyAdd where
      InsuranceSysId = In_InsuranceSysId
  end if;
  return Out_SumPaidPremium
end
;

create procedure dba.InsertNewInsurance(
in In_EmployeeSysId integer,
in In_InsurGroupSysId integer,
in In_InsurPolicyId char(20),
in In_PayrollSubPeriod integer,
in In_PayrollStartPeriod integer,
in In_PayrollStartYear integer,
in In_PayrollEndPeriod integer,
in In_PayrollEndYear integer,
in In_PayrollPayElementId char(20),
in In_PaymentCount integer,
in In_PaymentFreq char(20),
in In_PaymentType char(20),
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  declare In_InsuranceSysId integer;
  declare MaxFamilyAddSysId integer;
  if(In_InsurGroupSysId is null and not exists(select* from Insurance where
      Insurance.EmployeeSysId = In_EmployeeSysId and
      Insurance.InsurGroupSysId is null and
      Insurance.InsurPolicyId = In_InsurPolicyId)) or
    (In_InsurGroupSysId is not null and not exists(select* from Insurance where
      Insurance.EmployeeSysId = In_EmployeeSysId and
      Insurance.InsurGroupSysId = In_InsurGroupSysId and
      Insurance.InsurPolicyId = In_InsurPolicyId)) then
    insert into Insurance(EmployeeSysId,
      InsurGroupSysId,
      InsurPolicyId,
      PayrollSubPeriod,
      PayrollStartPeriod,
      PayrollStartYear,
      PayrollEndPeriod,
      PayrollEndYear,
      PayrollPayElementId,
      PaymentCount,
      PaymentFreq,
      PaymentType,
      Remarks) values(
      In_EmployeeSysId,
      In_InsurGroupSysId,
      In_InsurPolicyId,
      In_PayrollSubPeriod,
      In_PayrollStartPeriod,
      In_PayrollStartYear,
      In_PayrollEndPeriod,
      In_PayrollEndYear,
      In_PayrollPayElementId,
      In_PaymentCount,
      In_PaymentFreq,
      In_PaymentType,
      In_Remarks);
    commit work;
    if(In_InsurGroupSysId is null and not exists(select* from Insurance where
        Insurance.EmployeeSysId = In_EmployeeSysId and
        Insurance.InsurGroupSysId is null and
        Insurance.InsurPolicyId = In_InsurPolicyId)) or
      (In_InsurGroupSysId is not null and not exists(select* from Insurance where
        Insurance.EmployeeSysId = In_EmployeeSysId and
        Insurance.InsurGroupSysId = In_InsurGroupSysId and
        Insurance.InsurPolicyId = In_InsurPolicyId)) then
      set Out_ErrorCode=0
    else
      if In_InsurGroupSysId is null then
        select InsuranceSysId into In_InsuranceSysId from Insurance where
          Insurance.EmployeeSysId = In_EmployeeSysId and
          Insurance.InsurGroupSysId is null and
          Insurance.InsurPolicyId = In_InsurPolicyId
      else
        select InsuranceSysId into In_InsuranceSysId from Insurance where
          Insurance.EmployeeSysId = In_EmployeeSysId and
          Insurance.InsurGroupSysId = In_InsurGroupSysId and
          Insurance.InsurPolicyId = In_InsurPolicyId
      end if;
      call InsertNewInsurFamilyAdd(In_InsuranceSysId,null,0.0,0.0,0.0,'');
      if not exists(select* from InsurFamilyAdd where InsurFamilyAdd.InsuranceSysId = In_InsuranceSysId) then
        set Out_ErrorCode=-1
      else
        set Out_ErrorCode=1
      end if
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewInsurGroup(
in In_EmployeeSysId integer,
in In_InsurPlanProgSysId integer,
in In_InsurPlanId char(20),
in In_SelBasis1 integer,
in In_SelBasis2 integer,
in In_SelBasis3 integer,
in In_SelBasis4 integer,
in In_SelBasis5 integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from InsurGroup where
      EmployeeSysId = In_EmployeeSysId and
      InsurPlanProgSysId = In_InsurPlanProgSysId and
      InsurPlanId = In_InsurPlanId) then
    insert into InsurGroup(EmployeeSysId,
      InsurPlanProgSysId,
      InsurPlanId,
      SelBasis1,
      SelBasis2,
      SelBasis3,
      SelBasis4,
      SelBasis5) values(
      In_EmployeeSysId,
      In_InsurPlanProgSysId,
      In_InsurPlanId,
      In_SelBasis1,
      In_SelBasis2,
      In_SelBasis3,
      In_SelBasis4,
      In_SelBasis5);
    commit work;
    if not exists(select* from InsurGroup where
        EmployeeSysId = In_EmployeeSysId and
        InsurPlanProgSysId = In_InsurPlanProgSysId and
        InsurPlanId = In_InsurPlanId) then
      set Out_ErrorCode=-1
    else
      select InsurGroupSysId into Out_ErrorCode from InsurGroup where
        EmployeeSysId = In_EmployeeSysId and
        InsurPlanProgSysId = In_InsurPlanProgSysId and
        InsurPlanId = In_InsurPlanId
    end if
  else
    set Out_ErrorCode=-2
  end if
end
;

create procedure dba.InsertNewInsurPlan(
in In_InsurPlanId char(20),
in In_InsurPlanDesc char(200),
in In_InsurGroupPlan integer,
in In_InsurBasisNo integer,
in In_InsurBasis1 char(20),
in In_InsurBasis2 char(20),
in In_InsurBasis3 char(20),
in In_InsurBasis4 char(20),
in In_InsurBasis5 char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from InsurPlan where InsurPlan.InsurPlanId = In_InsurPlanId) then
    insert into InsurPlan(InsurPlanId,
      InsurPlanDesc,
      InsurGroupPlan,
      InsurBasisNo,
      InsurBasis1,
      InsurBasis2,
      InsurBasis3,
      InsurBasis4,
      InsurBasis5) values(
      In_InsurPlanId,
      In_InsurPlanDesc,
      In_InsurGroupPlan,
      In_InsurBasisNo,
      In_InsurBasis1,
      In_InsurBasis2,
      In_InsurBasis3,
      In_InsurBasis4,
      In_InsurBasis5);
    commit work;
    if not exists(select* from InsurPlan where InsurPlan.InsurPlanId = In_InsurPlanId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateInsurance(
in In_InsuranceSysId integer,
in In_EmployeeSysId integer,
in In_InsurGroupSysId integer,
in In_InsurPolicyId char(20),
in In_PayrollSubPeriod integer,
in In_PayrollStartPeriod integer,
in In_PayrollStartYear integer,
in In_PayrollEndPeriod integer,
in In_PayrollEndYear integer,
in In_PayrollPayElementId char(20),
in In_PaymentCount integer,
in In_PaymentFreq char(20),
in In_PaymentType char(20),
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from Insurance where InsuranceSysId = In_InsuranceSysId) then
    update Insurance set
      EmployeeSysId = In_EmployeeSysId,
      InsurGroupSysId = In_InsurGroupSysId,
      InsurPolicyId = In_InsurPolicyId,
      PayrollSubPeriod = In_PayrollSubPeriod,
      PayrollStartPeriod = In_PayrollStartPeriod,
      PayrollStartYear = In_PayrollStartYear,
      PayrollEndPeriod = In_PayrollEndPeriod,
      PayrollEndYear = In_PayrollEndYear,
      PayrollPayElementId = In_PayrollPayElementId,
      PaymentCount = In_PaymentCount,
      PaymentFreq = In_PaymentFreq,
      PaymentType = In_PaymentType,
      Remarks = In_Remarks where
      InsuranceSysId = In_InsuranceSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateInsuranceAttach(
in In_InsuranceSysId integer,
in In_InsuranceAttachSysId integer,
in In_AttachFileType char(20),
in In_AttachDate date,
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from InsuranceAttach where
      InsuranceAttach.InsuranceSysId = In_InsuranceSysId and
      InsuranceAttach.InsuranceAttachSysId = In_InsuranceAttachSysId) then
    update InsuranceAttach set AttachFileType = In_AttachFileType,
      AttachDate = In_AttachDate,
      Remarks = In_Remarks where
      InsuranceAttach.InsuranceSysId = In_InsuranceSysId and
      InsuranceAttach.InsuranceAttachSysId = In_InsuranceAttachSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateInsurGroup(
in In_InsurGroupSysId integer,
in In_EmployeeSysId integer,
in In_InsurPlanProgSysId integer,
in In_InsurPlanId char(20),
in In_SelBasis1 integer,
in In_SelBasis2 integer,
in In_SelBasis3 integer,
in In_SelBasis4 integer,
in In_SelBasis5 integer,
out Out_ErrorCode integer)
begin
  if exists(select* from InsurGroup where InsurGroupSysId = In_InsurGroupSysId) then
    update InsurGroup set
      EmployeeSysId = In_EmployeeSysId,
      InsurPlanProgSysId = In_InsurPlanProgSysId,
      InsurPlanId = In_InsurPlanId,
      SelBasis1 = In_SelBasis1,
      SelBasis2 = In_SelBasis2,
      SelBasis3 = In_SelBasis3,
      SelBasis4 = In_SelBasis4,
      SelBasis5 = In_SelBasis5 where
      InsurGroupSysId = In_InsurGroupSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.UpdateInsurPlan(
in In_InsurPlanId char(20),
in In_InsurPlanDesc char(200),
in In_InsurGroupPlan integer,
in In_InsurBasisNo integer,
in In_InsurBasis1 char(20),
in In_InsurBasis2 char(20),
in In_InsurBasis3 char(20),
in In_InsurBasis4 char(20),
in In_InsurBasis5 char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from InsurPlan where InsurPlanId = In_InsurPlanId) then
    update InsurPlan set
      InsurPlanDesc = In_InsurPlanDesc,
      InsurGroupPlan = In_InsurGroupPlan,
      InsurBasisNo = In_InsurBasisNo,
      InsurBasis1 = In_InsurBasis1,
      InsurBasis2 = In_InsurBasis2,
      InsurBasis3 = In_InsurBasis3,
      InsurBasis4 = In_InsurBasis4,
      InsurBasis5 = In_InsurBasis5 where
      InsurPlanId = In_InsurPlanId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateInsurProg(
in In_InsurPlanProgSysId integer,
in In_InsurPolicyId char(20),
in In_InsurFromDate date,
in In_InsurToDate date,
in In_NoOfEmployee integer,
in In_PaymentFreq char(20),
in In_PayrollStartPeriod integer,
in In_PayrollStartYear integer,
in In_PayrollEndPeriod integer,
in In_PayrollEndYear integer,
in In_PaymentType char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from InsurProg where InsurPlanProgSysId = In_InsurPlanProgSysId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    update InsurProg set
      InsurPolicyId = In_InsurPolicyId,
      InsurFromDate = In_InsurFromDate,
      InsurToDate = In_InsurToDate,
      NoOfEmployee = In_NoOfEmployee,
      PaymentFreq = In_PaymentFreq,
      PayrollStartPeriod = In_PayrollStartPeriod,
      PayrollStartYear = In_PayrollStartYear,
      PayrollEndPeriod = In_PayrollEndPeriod,
      PayrollEndYear = In_PayrollEndYear,
      PaymentType = In_PaymentType where
      InsurPlanProgSysId = In_InsurPlanProgSysId;
    commit work;
    if In_PaymentType <> 'InsurPayByPayroll' then
      update InsurProgDetails set PayrollPayElementId = null,
        PayrollSubPeriod = null where
        InsurPlanProgSysId = In_InsurPlanProgSysId;
      commit work
    end if
  end if;
  set Out_ErrorCode=In_InsurPlanProgSysId // Successful
end
;

create procedure dba.DeleteInsurFamilyAdd(
in In_InsuranceSysId integer,
in In_InsurFamilyAddSysId integer)
begin
  if exists(select* from InsurNominee where
      InsurNominee.InsuranceSysId = In_InsuranceSysId and
      InsurNominee.InsurFamilyAddSysId = In_InsurFamilyAddSysId) then
    delete from InsurNominee where
      InsurNominee.InsuranceSysId = In_InsuranceSysId and
      InsurNominee.InsurFamilyAddSysId = In_InsurFamilyAddSysId;
    commit work
  end if;
  if exists(select* from InsurClaim where
      InsurClaim.InsuranceSysId = In_InsuranceSysId and
      InsurClaim.InsurFamilyAddSysId = In_InsurFamilyAddSysId) then
    delete from InsurClaim where
      InsurClaim.InsuranceSysId = In_InsuranceSysId and
      InsurClaim.InsurFamilyAddSysId = In_InsurFamilyAddSysId;
    commit work
  end if;
  if exists(select* from InsurFamilyBenefit where
      InsurFamilyBenefit.InsuranceSysId = In_InsuranceSysId and
      InsurFamilyBenefit.InsurFamilyAddSysId = In_InsurFamilyAddSysId) then
    delete from InsurFamilyBenefit where
      InsurFamilyBenefit.InsuranceSysId = In_InsuranceSysId and
      InsurFamilyBenefit.InsurFamilyAddSysId = In_InsurFamilyAddSysId;
    commit work
  end if;
  delete from InsurFamilyAdd where
    InsurFamilyAdd.InsuranceSysId = In_InsuranceSysId and
    InsurFamilyAdd.InsurFamilyAddSysId = In_InsurFamilyAddSysId;
  commit work
end
;

create procedure dba.InsertNewInsurFamilyAdd(
in In_InsuranceSysId integer,
in In_FamilySysId integer,
in In_TotalPaidPremium double,
in In_EmpPaidPremium double,
in In_CoverageAmt double,
in In_Remarks char(100))
begin
  declare MaxFamilyAddSysId integer;
  if exists(select* from InsurFamilyAdd where InsuranceSysId = In_InsuranceSysId) then
    select max(InsurFamilyAddSysId) into MaxFamilyAddSysId from InsurFamilyAdd where
      InsuranceSysId = In_InsuranceSysId
  else
    set MaxFamilyAddSysId=0
  end if;
  insert into InsurFamilyAdd(InsuranceSysId,
    InsurFamilyAddSysId,
    FamilySysId,
    TotalPaidPremium,
    EmpPaidPremium,
    CoverageAmt,
    Remarks) values(
    In_InsuranceSysId,
    MaxFamilyAddSysId+1,
    In_FamilySysId,
    In_TotalPaidPremium,
    In_EmpPaidPremium,
    In_CoverageAmt,
    In_Remarks);
  commit work
end
;

create function DBA.IsGroupInsurance(
in In_InsurGroupSysId integer)
returns smallint
begin
  if(In_InsurGroupSysId is null) then
    return 0
  else
    return 1
  end if
end
;

create procedure DBA.ASQLDeleteInsurance(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
begin
  DeleteAllowanceHistoryLoop: for AllowanceHistoryFor as curs dynamic scroll cursor for
    select AllowanceRecord.AllowanceSGSPGenId as GenId,
      EmployeeSysId,
      PayRecYear,
      PayRecPeriod,
      PayRecSubPeriod,
      PayRecID,
      AllowanceRecurSysId from AllowanceRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID and
      (AllowanceCreatedBy = 'Insurance' and AllowanceCustSysId <> 0) do
    delete from AllowanceHistoryRecord where AllowanceSGSPGenId = GenId;
    delete from AllowanceRecord where AllowanceSGSPGenId = GenId end for;
  commit work
end
;

create procedure DBA.ASQLUpdateEmployeeInsurCoverage(
in In_InsurPlanProgSysId integer)
begin
  declare SumTotalYrPremium1 double;
  declare SumTotalYrPremium2 double;
  declare SumTotalYrPremium3 double;
  declare SumTotalYrPremium4 double;
  declare SumTotalYrPremium5 double;
  declare SumEmpYrPremium1 double;
  declare SumEmpYrPremium2 double;
  declare SumEmpYrPremium3 double;
  declare SumEmpYrPremium4 double;
  declare SumEmpYrPremium5 double;
  declare SumTotalMthPremium1 double;
  declare SumTotalMthPremium2 double;
  declare SumTotalMthPremium3 double;
  declare SumTotalMthPremium4 double;
  declare SumTotalMthPremium5 double;
  declare SumEmpMthPremium1 double;
  declare SumEmpMthPremium2 double;
  declare SumEmpMthPremium3 double;
  declare SumEmpMthPremium4 double;
  declare SumEmpMthPremium5 double;
  declare EmpMthPremium double;
  declare TotalMthPremium double;
  declare EmpYrPremium double;
  declare TotalYrPremium double;
  declare EmpPremium double;
  declare TotalPremium double;
  InsuranceLoop: for InsuranceFor as cursInsurance dynamic scroll cursor for
    select InsuranceSysId as Temp_InsuranceSysId,PaymentFreq as Temp_PaymentFreq,
      InsurPlanId as Temp_InsurPlanId,
      SelBasis1 as Temp_SelBasis1,SelBasis2 as Temp_SelBasis2,
      SelBasis3 as Temp_SelBasis3,SelBasis4 as Temp_SelBasis4,
      SelBasis5 as Temp_SelBasis5 from
      Insurance join InsurGroup where InsurPlanProgSysId = In_InsurPlanProgSysId do
    select SUM(TotalYrPremium1),SUM(TotalYrPremium2),SUM(TotalYrPremium3),SUM(TotalYrPremium4),
      SUM(TotalYrPremium5),
      SUM(EmpYrPremium1),SUM(EmpYrPremium2),SUM(EmpYrPremium3),SUM(EmpYrPremium4),
      SUM(EmpYrPremium5),
      SUM(TotalMthPremium1),SUM(TotalMthPremium2),SUM(TotalMthPremium3),SUM(TotalMthPremium4),
      SUM(TotalMthPremium5),
      SUM(EmpMthPremium1),SUM(EmpMthPremium2),SUM(EmpMthPremium3),SUM(EmpMthPremium4),
      SUM(EmpMthPremium5) into SumTotalYrPremium1,
      SumTotalYrPremium2,SumTotalYrPremium3,SumTotalYrPremium4,
      SumTotalYrPremium5,
      SumEmpYrPremium1,SumEmpYrPremium2,SumEmpYrPremium3,SumEmpYrPremium4,SumEmpYrPremium5,
      SumTotalMthPremium1,SumTotalMthPremium2,SumTotalMthPremium3,SumTotalMthPremium4,
      SumTotalMthPremium5,
      SumEmpMthPremium1,SumEmpMthPremium2,SumEmpMthPremium3,SumEmpMthPremium4,
      SumEmpMthPremium5 from InsurCoverage where InsurPlanProgSysId = In_InsurPlanProgSysId and InsurPlanId = Temp_InsurPlanId;
    set EmpPremium=0;
    set TotalPremium=0;
    if Temp_PaymentFreq = 'Monthly' then
      if Temp_SelBasis1 = 1 then
        set EmpPremium=EmpPremium+SumEmpMthPremium1;
        set TotalPremium=TotalPremium+SumTotalMthPremium1
      end if;
      if Temp_SelBasis2 = 1 then
        set EmpPremium=EmpPremium+SumEmpMthPremium2;
        set TotalPremium=TotalPremium+SumTotalMthPremium2
      end if;
      if Temp_SelBasis3 = 1 then
        set EmpPremium=EmpPremium+SumEmpMthPremium3;
        set TotalPremium=TotalPremium+SumTotalMthPremium3
      end if;
      if Temp_SelBasis4 = 1 then
        set EmpPremium=EmpPremium+SumEmpMthPremium4;
        set TotalPremium=TotalPremium+SumTotalMthPremium4
      end if;
      if Temp_SelBasis5 = 1 then
        set EmpPremium=EmpPremium+SumEmpMthPremium5;
        set TotalPremium=TotalPremium+SumTotalMthPremium5
      end if
    else
      if Temp_PaymentFreq = 'Yearly' then
        if Temp_SelBasis1 = 1 then
          set EmpPremium=EmpPremium+SumEmpYrPremium1;
          set TotalPremium=TotalPremium+SumTotalYrPremium1
        end if;
        if Temp_SelBasis2 = 1 then
          set EmpPremium=EmpPremium+SumEmpYrPremium2;
          set TotalPremium=TotalPremium+SumTotalYrPremium2
        end if;
        if Temp_SelBasis3 = 1 then
          set EmpPremium=EmpPremium+SumEmpYrPremium3;
          set TotalPremium=TotalPremium+SumTotalYrPremium3
        end if;
        if Temp_SelBasis4 = 1 then
          set EmpPremium=EmpPremium+SumEmpYrPremium4;
          set TotalPremium=TotalPremium+SumTotalYrPremium4
        end if;
        if Temp_SelBasis5 = 1 then
          set EmpPremium=EmpPremium+SumEmpYrPremium5;
          set TotalPremium=TotalPremium+SumTotalYrPremium5
        end if
      end if
    end if;
    update InsurFamilyAdd set TotalPaidPremium = TotalPremium,EmpPaidPremium = EmpPremium where
      InsuranceSysId = Temp_InsuranceSysId and FamilySysId is null end for
end
;
Commit work;