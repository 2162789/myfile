IF EXISTS(SELECT * FROM SysUsers LEFT OUTER JOIN SystemUser  ON name=UserId WHERE name='TMS' AND UserId IS NULL) THEN
	REVOKE CONNECT FROM TMS;
END IF;

IF EXISTS(SELECT * FROM SysUsers LEFT OUTER JOIN SystemUser  ON name=UserId WHERE name='Admin' AND UserId IS NULL) THEN
	REVOKE CONNECT FROM Admin;
END IF;

IF NOT EXISTS(select 1 from usergroup where usergroupid='admin') THEN
	INSERT INTO usergroup VALUES('Admin','Administrator Group', NULL);
END IF;

IF EXISTS(SELECT * FROM SysUsers LEFT OUTER JOIN SystemUser  ON name=UserId WHERE name='EPELeave' AND UserId IS NULL) THEN
	UPDATE SystemUser SET UserGroupId='Admin' WHERE UserId='EPELeave';
END IF;

IF EXISTS(select 1 from modulescreengroup where ModuleScreenId='CoreContractProgRpt' and ModuleScreenName='Education Report') THEN
	update modulescreengroup set ModuleScreenName='Contract Progression Report' WHERE ModuleScreenId='CoreContractProgRpt'
END IF;

Commit Work;