IF EXISTS(SELECT 1 FROM sys.sysprocedure WHERE proc_name ='DeleteEmployeeCustomRecord') THEN
    DROP Procedure DeleteEmployeeCustomRecord
END IF;

create PROCEDURE DBA.DeleteEmployeeCustomRecord(
in In_EmployeeSysId integer)
BEGIN
	/* Type the procedure statements here */
END
;

IF EXISTS(SELECT 1 FROM sys.sysprocedure WHERE proc_name ='DeleteEmployeeRecord') THEN
    DROP Procedure DeleteEmployeeRecord
END IF;

create PROCEDURE DBA.DeleteEmployeeRecord(
in In_EmployeeSysId integer,
in In_EmployeeId char(30))
begin
  declare Int_PersonalSysId integer;
  declare Char_EmployeeId char(30);
  if exists(select* from Employee where Employee.EmployeeSysId = In_EmployeesysId) then
    select Employee.PersonalSysId into Int_PersonalSysId from Employee where Employee.EmployeeSysId = In_EmployeeSysId;
    select first EmployeeId into Char_EmployeeId from Employee where
      PersonalSysId = Int_PersonalSysId and
      EmployeesysId <> In_EmployeeSysId order by HireDate desc;
    update Personal set
      Personal.EmployeeId = Char_EmployeeId where
      Personal.PersonalSysId = Int_PersonalSysId;
    call DeleteEmpeeWkCalenEmp(In_EmployeeSysId);
    call DeletePaymentBankInfoEmp(In_EmployeeSysId);
    call DeleteLoanEmployeeEmp(In_EmployeeSysId);
    call DeleteCETmsExportEmpEmp(In_EmployeeSysId);
    call DeleteIntercorpTmsExportEmpEmp(In_EmployeeSysId);
    if FGetDBCountry(*) = 'HongKong' then
      call DeleteHKTaxDetails(In_EmployeeSysId)
    end if;
    if FGetDBCountry(*) = 'Malaysia' then
      call DeleteMalPrevEmployerByEmployeeSysId(In_EmployeeSysId)
    end if;
    /*Custom Tables*/
    call DeleteEmployeeCustomRecord(In_EmployeeSysId);
    delete from Employee where
      Employee.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

IF EXISTS(SELECT 1 FROM sys.sysprocedure WHERE proc_name ='DeletePersonalCustomRecord') THEN
    DROP Procedure DeletePersonalCustomRecord
END IF;

create PROCEDURE DBA.DeletePersonalCustomRecord(
in In_PersonalSysId integer)
BEGIN
	/* Type the procedure statements here */
END
;

IF EXISTS(SELECT 1 FROM sys.sysprocedure WHERE proc_name ='DeletePersonalRecord') THEN
    DROP Procedure DeletePersonalRecord
END IF;

create PROCEDURE DBA.DeletePersonalRecord(
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
    /*Custom Tables*/
    call DeletePersonalCustomRecord(In_PersonalSysId);
    /*Delete Personal*/
    delete from Personal where
      Personal.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;


Commit work;