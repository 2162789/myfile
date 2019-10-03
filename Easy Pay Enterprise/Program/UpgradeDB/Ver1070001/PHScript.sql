/* Loan Report */
if not exists (select * from ModuleScreenGroup where ModuleScreenId = 'LoanPhilipGeneric') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('LoanPhilipGeneric','PayAnalysisRpts','Loan Report','Pay',0,1,0,'');
else
  Update ModuleScreenGroup Set Mod_ModuleScreenId = 'PayAnalysisRpts', ModuleScreenName = 'Loan Report' where ModuleScreenId = 'LoanPhilipGeneric'; 
end if;

/* HDMF Monthly Loan Payments */
if not exists (select * from ModuleScreenGroup where ModuleScreenId = 'LoanPhilipHDMF') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('LoanPhilipHDMF','PayPhilStatutory','HDMF Monthly Loan Payments','Pay',0,1,0,'');
  
  Update UserModuleNoAccess Set ModuleScreenId = 'LoanPhilipHDMF' Where ModuleScreenId = 'LoanPhilipGeneric';
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