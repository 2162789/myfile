Update CustViewObjTbl set CustViewCond1='LEFT OUTER JOIN PersonalAddress ON(Employee.PersonalSysId=PersonalAddress.PersonalSysId AND PersonalAddMailing=1)' where CustViewObjId='PersonDet_MailAdd';
Update CustViewObjTbl set CustViewCond1='LEFT OUTER JOIN PersonalContact ON(Employee.PersonalSysId=PersonalContact.PersonalSysId AND PersonalContact.ContactLocationId=''ePortal'')' where CustViewObjId='PersonDet_eContact';
Update CustViewObjTbl set CustViewCond1='LEFT OUTER JOIN PersonalEmail ON(Employee.PersonalSysId=PersonalEmail.PersonalSysId AND PersonalEmail.ContactLocationId=''ePortal'')' where CustViewObjId='PersonDet_eEmail';

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertDefaultSDFOption') then
   drop procedure InsertDefaultSDFOption
end if
;
create procedure
DBA.InsertDefaultSDFOption()
begin
    EmpLoop: for EmpForLoop as Cur_Emp dynamic scroll cursor for
      select EmployeeSysId as In_EmployeeSysId from Employee where CessationDate='1899-12-30' do
	  call InsertNewEmpeeOtherInfo(In_EmployeeSysId,'SDFOption','Boolean','SDF Option',null,'',1,0)
	end for;
  
  commit work;
end;

call InsertDefaultSDFOption();

drop procedure InsertDefaultSDFOption;


commit work;