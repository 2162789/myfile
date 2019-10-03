If exists(select * from sys.sysprocedure where proc_name = 'InsertNewESSEmployee') then 
  drop procedure InsertNewESSEmployee
end if;
CREATE PROCEDURE "DBA"."InsertNewESSEmployee"(
in In_EmployeeSysId integer,
in In_ESSEEmpModifiedDate timestamp,
in In_ESSEEmpESSBatchSysId integer,
in In_ESSELveModifiedDate timestamp,
in In_ESSELveESSBatchSysId integer,
out Out_ErrorCode integer
)
BEGIN
	if not exists(select * from ESSEmployee where EmployeeSysId = In_EmployeeSysId) then
        insert into ESSEmployee(
        EmployeeSysId,
        ESSEEmpModifiedDate,
        ESSEEmpESSBatchSysId,
        ESSELveModifiedDate,
        ESSELveESSBatchSysId)
        values(
        In_EmployeeSysId,
        In_ESSEEmpModifiedDate,
        In_ESSEEmpESSBatchSysId,
        In_ESSELveModifiedDate,
        In_ESSELveESSBatchSysId);
        Set Out_ErrorCode = 1;
    else
        Set Out_ErrorCode = 0;
    end if;
END;

If exists(select * from sys.sysprocedure where proc_name = 'UpdateESSEmployee') then 
  drop procedure UpdateESSEmployee
end if;
CREATE PROCEDURE "DBA"."UpdateESSEmployee"( 
in In_EmployeeSysId integer,
in In_ESSEEmpModifiedDate timestamp,
in In_ESSEEmpESSBatchSysId integer,
in In_ESSELveModifiedDate timestamp,
in In_ESSELveESSBatchSysId integer,
out Out_ErrorCode integer
)
BEGIN
    if exists(select * from ESSEmployee where EmployeeSysId = In_EmployeeSysId) then
	  Update ESSEmployee
      Set ESSEEmpModifiedDate = In_ESSEEmpModifiedDate,
          ESSEEmpESSBatchSysId = In_ESSEEmpESSBatchSysId,
          ESSELveModifiedDate = In_ESSELveModifiedDate,
          ESSELveESSBatchSysId = In_ESSELveESSBatchSysId
      Where EmployeeSysId = In_EmployeeSysId;
      Set Out_ErrorCode = 1;
    else
      Set Out_ErrorCode = 0;
    end if;
END;

If exists(select * from sys.sysprocedure where proc_name = 'DeleteESSEmployee') then 
  drop procedure DeleteESSEmployee
end if;
CREATE PROCEDURE "DBA"."DeleteESSEmployee"(
in In_EmployeeSysId integer,
Out Out_ErrorCode integer )
BEGIN
	Delete from ESSEmployee where EmployeeSysId = In_EmployeeSysId;
    If exists(select * from ESSEmployee where EmployeeSysId = In_EmployeeSysId) then
       Set Out_ErrorCode = 0;
    else
       Set Out_ErrorCode = 1;
    end if;
END;

If exists(select * from sys.sysprocedure where proc_name = 'DeleteEmployeeRecord') then 
  drop procedure DeleteEmployeeRecord
end if;
CREATE PROCEDURE "DBA"."DeleteEmployeeRecord"(
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
    call DeleteESSEmployee(In_EmployeeSysId);
    delete from Employee where
      Employee.EmployeeSysId = In_EmployeeSysId;  
    commit work
  end if
end;

If exists(select * from sys.sysprocedure where proc_name = 'ASQLPrepareESSData') then 
  drop procedure ASQLPrepareESSData
end if;
CREATE PROCEDURE DBA.ASQLPrepareESSData(
In In_HasESSLicense smallint
)
BEGIN     
    if In_HasESSLicense = 1 then
      /* First time to sync the data */
	  Insert Into ESSEmployee (EmployeeSysId, 
      ESSEEmpModifiedDate,
      ESSEEmpESSBatchSysId,
      ESSELveModifiedDate,
      ESSELveESSBatchSysId)
      Select e.EmployeeSysId,
      '1899-12-30 00:00:00',
      0,
      '1899-12-30 00:00:00',
      0
      From Employee e
      Left Join ESSEmployee ee On e.EmployeeSysId = ee.EmployeeSysid
      Where (CessationDate = '1899-12-30' or CessationDate >= Today())
       And ee.EmployeeSysId is null;
    else
       /* Delete all the data */
       Delete from ESSEmployee;
    end if;
    
	/* Update BooleanAttr to 0 or 1 based on the ESS Licenese */
    Update SubRegistry Set BooleanAttr = In_HasESSLicense Where RegistryId = 'ESS' And SubRegistryId = 'ESSTrigger';
    
	/* Reset Last Sync Datetime */
    Update SubRegistry Set DateTimeAttr = '1899-12-30 00:00:00' Where RegistryId = 'ESS' and RegProperty1 = 'ESSSyncOption';
END;

commit work;