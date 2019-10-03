If not exists(select 1 from sys.sysprocedure where proc_name = 'DeleteEmployeeCustomRecord') then
  create PROCEDURE DBA.DeleteEmployeeCustomRecord(
  in In_EmployeeSysId integer)
  BEGIN
	/* Type the procedure statements here */
  END
  ;
end if;


If not exists(select 1 from sys.sysprocedure where proc_name = 'DeletePersonalCustomRecord') then
  create PROCEDURE DBA.DeletePersonalCustomRecord(
  in In_PersonalSysId integer)
  BEGIN
	/* Type the procedure statements here */
  END
  ;
end if;


commit work;