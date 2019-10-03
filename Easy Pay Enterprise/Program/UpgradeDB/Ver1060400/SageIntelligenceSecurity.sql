CREATE PROCEDURE Tmp_ASQLUpdateModuleScreenNoAccess()
BEGIN
    UserGroupLoop: for UserGroupFor as UserGroupCurs dynamic scroll cursor for
    SELECT UserGroupId AS In_UserGroupID FROM UserGroup WHERE UserGroupHideWage=1 do
	Call InsertNewUserModuleNoAccess('CoreAlchemexReports',In_UserGroupID);
	Call InsertNewUserModuleNoAccess('CoreAlchemexViewer',In_UserGroupID);
    end for;    
END;

Call Tmp_ASQLUpdateModuleScreenNoAccess();
drop PROCEDURE Tmp_ASQLUpdateModuleScreenNoAccess;

Update ModuleScreenGroup Set ModuleScreenName='Sage Intelligence' where ModuleScreenId='CoreAlchemexReports';
Delete UserModuleNoAccess WHERE ModuleScreenId IN ('CoreAlchemexAdmin','CoreAlchemexRptMgr');
Delete ModuleScreenGroup WHERE ModuleScreenId IN ('CoreAlchemexAdmin','CoreAlchemexRptMgr');
Commit work;