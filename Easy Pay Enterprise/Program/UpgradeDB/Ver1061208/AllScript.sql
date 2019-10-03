if not exists (select 1 from ePortalVersion where EPE = '1070000') then
  insert into ePortalVersion (EPE, ePortal)
  values ('1070000', '1030000')
end if;

/* Not allow to access Loan Report for Users Whose Rights is Hide Wage */
UserGroupLoop: FOR UserGroupHis AS DYNAMIC SCROLL CURSOR FOR    
   SELECT UserGroupId AS OUT_UserGroupId FROM UserGroup 
   WHERE UserGroupHideWage = 1
   DO 
	  IF NOT EXISTS(SELECT * FROM UserModuleNoAccess WHERE ModuleScreenId = 'LoanPhilipGeneric' AND UserGroupId = OUT_UserGroupId) THEN
	      INSERT INTO UserModuleNoAccess(ModuleScreenId,UserGroupId)
		  VALUES('LoanPhilipGeneric',OUT_UserGroupId);
	  END IF;
   END FOR;

commit work;