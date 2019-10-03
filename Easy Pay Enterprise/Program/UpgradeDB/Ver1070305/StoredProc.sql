if exists(select * from sys.sysprocedure where proc_name = 'InsertNewDepartment' ) then
   drop procedure InsertNewDepartment
end if;
Create PROCEDURE "DBA"."InsertNewDepartment"(
in In_DepartmentId char(20),
in In_DepartmentDesc char(60),
in In_DepartmentHist smallint)
begin
  if not exists(select* from Department where Department.DepartmentId = In_DepartmentId) then
    insert into Department(DepartmentId,DepartmentDesc,DepartmentHist) values(In_DepartmentId,In_DepartmentDesc,In_DepartmentHist);
    commit work
  end if
end;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateDepartmentDesc') then
	drop procedure UpdateDepartmentDesc
end if;
Create PROCEDURE "DBA"."UpdateDepartmentDesc"(
in In_DepartmentId char(20),
in In_DepartmentDesc char(60),
in In_DepartmentHist smallint)
begin
  if exists(select* from Department where Department.DepartmentId = In_DepartmentId) then
    update Department set
      Department.DepartmentDesc = IN_DepartmentDesc,
      Department.DepartmentHist = IN_DepartmentHist where
      Department.DepartmentId = IN_DepartmentId;
    commit work
  end if
end;

commit work;