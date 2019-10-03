if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPayRecAllStatutoryDeduction') then
   drop function FGetPayRecAllStatutoryDeduction
end if
;
CREATE FUNCTION DBA.FGetPayRecAllStatutoryDeduction(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20))
returns double
begin
  declare TotalAmount double;
  if FGetDBCountry(*) = 'Singapore' then
    select ContriOrdEECPF+
      ContriAddEECPF into TotalAmount
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  elseif FGetDBCountry(*) = 'Brunei' then
    select TotalContriEECPF+
      ContriOrdEECPF+
      ContriAddEECPF+
      CurrEEManContri
      into TotalAmount
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  elseif FGetDBCountry(*) = 'Indonesia' then
    select ContriOrdEECPF into TotalAmount
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  elseif FGetDBCountry(*) = 'Malaysia' then
    select PrevEEManContri+
      CurrEEManContri+
      PrevEEVolContri+
      CurrEEVolContri+
      ContriOrdEECPF+ 
      PaidCurrentTaxAmt+
      PaidPreviousTaxAmt
      into TotalAmount
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  elseif FGetDBCountry(*) = 'Philippines' then
    select ContriOrdEECPF+
      CurrEEManContri+
      ContriAddEECPF into TotalAmount
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  elseif FGetDBCountry(*) = 'Vietnam' then
    select CurrEEVolContri+
      PrevEEVolContri+
      CurrEEVolWage+
      PrevEEVolWage+
      ContriAddEECPF into TotalAmount
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  elseif FGetDBCountry(*) = 'HongKong' then
    select CurrEEManContri+
      CurrEEVolContri into TotalAmount
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  elseif FGetDBCountry(*) = 'Thailand' then
    select ContriOrdEECPF+TotalContriEECPF+CurrEEManContri+PrevEEManContri+
      CurrEEManWage+PrevEEManWage into TotalAmount
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  else
    select 0 into TotalAmount
  end if;
  if TotalAmount is null then set TotalAmount=0
  end if;
  return TotalAmount
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateFamilyEduRec') then
   drop procedure UpdateFamilyEduRec
end if
;
create procedure dba.UpdateFamilyEduRec(
in In_FamilyEduRecId integer,
in In_FamilySysId integer,
in In_EducationId char(20),
in In_EduStartDate date,
in In_EduEndDate date,
in In_EduInstitution char(100),
in In_EduHighest smallint,
in In_EduResult double,
in In_EduLocal smallint,
out Out_ErrorCode integer)
begin
  if In_EducationId is null then set Out_ErrorCode=-1;
    return
  end if;
  if FGetInvalidDate(In_EduStartDate) = '' then set Out_ErrorCode=-2;
    return
  end if;
  if FGetInvalidDate(In_EduEndDate) = '' then set Out_ErrorCode=-3;
    return
  end if;
  if(In_EduEndDate < In_EduStartDate) then set Out_ErrorCode=-4;
    return
  end if;
  if exists(select* from FamilyEduRec where
      FamilyEduRec.FamilyEduRecId = In_FamilyEduRecId) then
    if(In_EduHighest = 1) then
      update FamilyEduRec set FamilyEduRec.EduHighest = 0 where
        FamilyEduRec.EduHighest = 1 and
        FamilyEduRec.FamilySysId = In_FamilySysId
    end if;
    update FamilyEduRec set
      FamilyEduRec.FamilySysId = In_FamilySysId,
      FamilyEduRec.EducationId = In_EducationId,
      FamilyEduRec.EduStartDate = In_EduStartDate,
      FamilyEduRec.EduEndDate = In_EduEndDate,
      FamilyEduRec.EduInsitution = In_EduInstitution,
      FamilyEduRec.EduHighest = In_EduHighest,
      FamilyEduRec.EduResult = In_EduResult,
      FamilyEduRec.EduLocal = In_EduLocal where
      FamilyEduRec.FamilyEduRecId = In_FamilyEduRecId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePersonalRecord') then
   drop procedure DeletePersonalRecord
end if
;
create procedure dba.DeletePersonalRecord(
in In_PersonalSysId integer)
begin
  if exists(select* from Personal where Personal.PersonalSysId = In_PersonalSysId) then
    EmployeeLoop: for EmployeeFor as Employeecurs dynamic scroll cursor for
      select Employee.EmployeeSysId as Out_EmployeeSysId from Employee where
        Employee.PersonalSysID = In_PersonalSysId do
      call ASQLDeleteEmployment(Out_EmployeeSysId);
      commit work end for;
    /*Standard deletion for all countries*/
    call DeleteRptConfigEmail(In_PersonalSysId);
    call DeletePersonalEmailAll(In_PersonalSysId);
    call DeletePersonalContactAll(In_PersonalSysId);
    call DeletePersonalAddressAll(In_PersonalSysId);
    call DeleteResStatusRecordBySysId(In_PersonalSysId);
    call DeleteHRDetails(In_PersonalSysId);
    delete from ProjContractWorker where
      ProjContractWorker.PersonalSysId = In_PersonalSysId;
    delete from InterfaceDetails where
      InterfaceDetails.PersonalSysId = In_PersonalSysId;
    delete from Attachment where
      Attachment.PersonalSysId = In_PersonalSysId;
    /*Income Tax Deletion*/
    if FGetDBCountry(*) = 'Singapore' then
      call DeleteYEEmployeeByPersonalSysID(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Indonesia' then
      call DeleteIndoTaxDetails(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Malaysia' then
      call DeleteMalTaxDetails(In_PersonalSysId);
      call DeleteMalRebateGrantedByPersonalSysId(In_PersonalSysId);
      call DeleteMalRebateClaimByPersonalSysId(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Philippines' then
      call DeletePhTaxDetails(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Vietnam' then
      call DeleteVnTaxDetails(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Thailand' then
      call DeleteThTaxDetails(In_PersonalSysId)
    end if;
    /*Delete Personal*/
    delete from Personal where
      Personal.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

Commit Work;