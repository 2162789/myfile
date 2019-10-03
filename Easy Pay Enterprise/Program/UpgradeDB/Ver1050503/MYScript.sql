if not exists (select * from "DBA"."SubRegistry" where RegistryId = 'EmpeeOtherInfo' and SubRegistryId = 'HRDFOption')
then
  insert into SubRegistry
  values ('EmpeeOtherInfo','HRDFOption','HRDF Option','Boolean','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;
commit work;

EmployeeLoop: for EmployeeFor as EmployeeCurs dynamic scroll cursor for
    select EmployeeSysId as In_EmployeeSysId from Employee do
    call ASQLRefreshEmpeeOtherInfo(In_EmployeeSysId,'') end for;
commit work;
