/* InterfaceProject for ePortal HRIS */
if not exists(select * from InterfaceProject where InterfaceProjectID = 'ePortalHRIS') then
	insert into InterfaceProject(InterfaceProjectID,InterfaceProjRemarks)
	values ('ePortalHRIS','Add new employment from ePortal. It''s for ePortal use only');

	/* Interface Process */
	insert into InterfaceProcess(InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks) values('ePortalHRIS','OT Process',NULL,0,0,'');
	insert into InterfaceProcess(InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks) values('ePortalHRIS','Shift Process',NULL,0,0,'');
	insert into InterfaceProcess(InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks) values('ePortalHRIS','Employment Process',NULL,0,1,'');
	insert into InterfaceProcess(InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks) values('ePortalHRIS','Pay Element Process',NULL,0,1,'');
	insert into InterfaceProcess(InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks) values('ePortalHRIS','Leave Process',NULL,0,0,'');
	insert into InterfaceProcess(InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks) values('ePortalHRIS','Lve Summary Process',NULL,0,0,'');
	insert into InterfaceProcess(InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks) values('ePortalHRIS','HR Process',NULL,0,0,'');
	insert into InterfaceProcess(InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks) values('ePortalHRIS','Daily Hourly Process',NULL,0,0,'');
	insert into InterfaceProcess(InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks) values('ePortalHRIS','Income Tax Process',NULL,0,0,'');
	insert into InterfaceProcess(InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks) values('ePortalHRIS','Casual Pay Process',NULL,0,0,'');
	insert into InterfaceProcess(InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks) values('ePortalHRIS','YTD Process',NULL,0,0,'');
	insert into InterfaceProcess(InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks) values('ePortalHRIS','Time Sheet Detail',NULL,0,0,'');
	insert into InterfaceProcess(InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks) values('ePortalHRIS','Setup Process',NULL,0,0,'');  

    /* Interface Code Table */
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Casual Pay Process','CasBranch','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Casual Pay Process','CasCategory','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Casual Pay Process','CasClassification','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Casual Pay Process','CasCustomCode1','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Casual Pay Process','CasCustomCode2','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Casual Pay Process','CasCustomCode3','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Casual Pay Process','CasCustomCode4','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Casual Pay Process','CasCustomCode5','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Casual Pay Process','CasCustomLocation','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Casual Pay Process','CasDepartment','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Casual Pay Process','CasPayment','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Casual Pay Process','CasPosition','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Casual Pay Process','CasSalaryGrade','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Casual Pay Process','CasSection','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','BankAccTypeId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','BankAllocGroup','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','BankBranchId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','BankId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','BasicRateType','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','BloodGroup','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','Branch','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','CalendarId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','CareerId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','Category','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','CessationCode','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','City','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','Classification','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','ContactLocationId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','CostCentreId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','Country','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','CountryOfBirth','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','Department','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','EducationId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','EmpCode1','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','EmpCode2','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','EmpCode3','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','EmpCode4','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','EmpCode5','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','EmpeeOtherInfoId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','EmpLocation1','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','ExchangeRateId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','FieldMajorId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','FWLClass','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','Gender','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','IdentityTypeId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','LeaveGroupId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','MaritalStatus','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','Nationality','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','NewBankBranchId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','NewBankId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','OccupationId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','PassportIssue','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','PaymentMode','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','PaymentType','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','PersonalTypeId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','Position','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','Race','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','Relationship','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','Religion','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','ResidenceTypeId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','SalaryGrade','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','Section','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','State','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','TitleCode','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','WTCalendarId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Employment Process','WTProfileId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','ActionTaken','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','AwardDiscCode','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','EmploymentTypeId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','GradeCode','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','HRMaritalStatus','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','HRPassportIssue','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','HRPayElementCode','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','IllnessId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','JobGrade','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','MedClaimReasonId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','MedClaimTypeId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','MediaId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','MembershipCode','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','OffenceType','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','OrganisationCode','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','OrganisationIndustry','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','OrganisationType','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','RecruitCode','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','ResponsibilityId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','SalaryType','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','SkillCode','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','HR Process','TreatmentTypeId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Income Tax Process','CompanyIDType','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Leave Process','LeaveCode','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Lve Summary Process','LeaveReasonId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Lve Summary Process','LeaveTypeId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','OT Process','OTCode','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Pay Element Process','PayElementCode','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Shift Process','ShiftCode','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Time Sheet Detail','TMSExchangeRateId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','Time Sheet Detail','TMSPaymentType','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','YTD Process','YTDAllowanceId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','YTD Process','YTDAllowanceRecurFor','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','YTD Process','YTDBasicRateType','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','YTD Process','YTDCPFClass','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','YTD Process','YTDCPFStatus','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','YTD Process','YTDLveTypeFunctCode','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','YTD Process','YTDOTId','',1,0,'');
	insert into InterfaceCodeTable(InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL) values('ePortalHRIS','YTD Process','YTDShiftId','',1,0,'');
	   
	/* Interface Attribute */
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','Alias','Personal',0,'Alias');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','ANNLveBroughtForward','PayEmployee',0,'ANNLveBroughtForward');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','ANNLveEntitlement','PayEmployee',0,'ANNLveEntitlement');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','BasicRateExchangeId','Employee',0,'BasicRateExchangeId');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','BloodGroupId','Personal',0,'BloodGroupId');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','BonusFactor','PayEmployee',0,'BonusFactor');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','BranchId','Employee',1,'BranchId');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CalendarId','Employee',1,'CalendarId');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CategoryId','Employee',1,'CategoryId');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CessationCode','Employee',1,'CessationCode');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CessationDate','Employee',1,'CessationDate');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','ClassificationCode','Employee',1,'ClassificationCode');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','ConfirmationDate','Employee',1,'ConfirmationDate');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','ContractEndDate','Employee',0,'ContractEndDate');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','ContractNo','Employee',0,'ContractNo');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','ContractStartDate','Employee',0,'ContractStartDate');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CostCentreId','Employee',0,'CostCentreId');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CountryOfBirth','Personal',1,'CountryOfBirth');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CurrentBasicRate','Employee',1,'CurrentBasicRate');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CurrentBasicRateType','Employee',0,'CurrentBasicRateType');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CurrentMVC','Employee',0,'CurrentMVC');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CurrentNWC','Employee',0,'CurrentNWC');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','DefaultHourRate','PayEmployee',0,'DefaultHourRate');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','DateOfBirth','Personal',1,'DateOfBirth');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','DepartmentId','Employee',1,'DepartmentId');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','EEHoursperDay','PayEmployee',0,'EEHoursperDay');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','FullDayWorkTimeProfi','LeaveEmployee',0,'FullDayWorkTimeProfile');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','Gender','Personal',1,'Gender');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','HalfDayWorkTimeProfi','LeaveEmployee',0,'HalfDayWorkTimeProfile');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','HasShiftRotation','LeaveEmployee',0,'HasShiftRotation');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','Height','Personal',0,'Height');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','HireDate','Employee',1,'HireDate');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','IdentityTypeId','Personal',1,'IdentityTypeId');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','IsSupervisor','Employee',0,'IsSupervisor');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','LastPayDate','PayEmployee',0,'LastPayDate');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','LeaveGroupId','LeaveEmployee',0,'LeaveGroupId');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','Mal_OldIdentity','Personal',1,'Mal_OldIdentity');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','MaritalStatusCode','Personal',1,'MaritalStatusCode');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','MVCCapping','PayEmployee',0,'MVCCapping');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','MVCPercentage','Employee',0,'MVCPercentage');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','Nationality','Personal',1,'Nationality');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','PassportIssue','Personal',1,'PassportIssue');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','PaySlipMessage','PayEmployee',0,'PaySlipMessage');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','PaySuspense','PayEmployee',0,'PaySuspense');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','PersonalName','Personal',1,'PersonalName');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','PersonalTypeId','Personal',0,'PersonalTypeId');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','PositionId','Employee',1,'PositionId');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','PreviousSvcYear','Employee',1,'PreviousSvcYear');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','ProbationPeriod','Employee',1,'ProbationPeriod');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','ProbationUnit','Employee',1,'ProbationUnit');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','QuarterDayWorkTimePr','LeaveEmployee',0,'QuarterDayWorkTimeProfile');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','RaceId','Personal',1,'RaceId');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','ReligionID','Personal',1,'ReligionID');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','RetirementAge','Employee',1,'RetirementAge');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','RetirementDate','Employee',1,'RetirementDate');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','SalaryGradeId','Employee',0,'SalaryGradeId');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','SectionId','Employee',1,'SectionId');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','SickLveEntitlement','PayEmployee',0,'SickLveEntitlement');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','Supervisor','Employee',1,'Supervisor');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','SuspendLeave','LeaveEmployee',0,'SuspendLeave');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','TitleId','Personal',1,'TitleId');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','Weight','Personal',0,'Weight');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','WTCalendarId','LeaveEmployee',0,'WTCalendarId');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','OTTableId','PayEmployee',1,'OTTableId');

	 /* Custom Fields */ 
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CustBoolean1','Employee',0,'CustBoolean1');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CustBoolean2','Employee',0,'CustBoolean2');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CustBoolean3','Employee',0,'CustBoolean3');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CustDate1','Employee',0,'CustDate1');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CustDate2','Employee',0,'CustDate2');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CustDate3','Employee',0,'CustDate3');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CustInteger1','Employee',0,'CustInteger1');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CustInteger2','Employee',0,'CustInteger2');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CustInteger3','Employee',0,'CustInteger3');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CustNumeric1','Employee',0,'CustNumeric1');	
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CustNumeric2','Employee',0,'CustNumeric2');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CustNumeric3','Employee',0,'CustNumeric3');	
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CustString1','Employee',0,'CustString1');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CustString2','Employee',0,'CustString2');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CustString3','Employee',0,'CustString3');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CustString4','Employee',0,'CustString4');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','CustString5','Employee',0,'CustString5');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','EmpCode1Id','Employee',0,'EmpCode1Id');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','EmpCode2Id','Employee',0,'EmpCode2Id');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','EmpCode3Id','Employee',0,'EmpCode3Id');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','EmpCode4Id','Employee',0,'EmpCode4Id');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','EmpCode5Id','Employee',0,'EmpCode5Id');
	insert into InterfaceAttribute(InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr) values('ePortalHRIS','EmpLocation1Id','Employee',0,'EmpLocation1Id');
end if;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLUpdateInterfaceAttributeList') then
   drop procedure ASQLUpdateInterfaceAttributeList;
end if;
create PROCEDURE DBA.ASQLUpdateInterfaceAttributeList(
in In_InterfaceProjectID char(20))
begin
  if exists(select* from InterfaceProject where
      InterfaceProject.InterfaceProjectID = In_InterfaceProjectID) then
    // Inserts the Attribute one by one
    InterfaceAttributeLoop: for InterfaceAttributeForLoop as Cur_InterfaceAttribute dynamic scroll cursor for
      select SubRegistryID as New_InterfaceAttributeID,
        RegProperty7 as New_InterfacePhysicalAttr,
        RegProperty1 as New_InterfaceAttrTableID,
        RegProperty8 as InterfaceAttrLabel from
        Subregistry where
        RegistryID = 'InterfaceAttribute' do
      if(InterfaceAttrLabel <> '') then
        // ePortal has feature to add new employment record via HRIS. We have predefine the project id called "ePortalHRIS".
        // Currently they do not support custom fields.
        // So if custom filed is created, the "In Use" should not be checked.
        // When ePortal support custom fileds, we shall remove this checking.
        if(In_InterfaceProjectID = 'ePortalHRIS') then
          call InsertNewInterfaceAttribute(
          In_InterfaceProjectID,
          New_InterfaceAttributeID,
          New_InterfaceAttrTableID,0,
          New_InterfacePhysicalAttr)
       else 
        call InsertNewInterfaceAttribute(
        In_InterfaceProjectID,
        New_InterfaceAttributeID,
        New_InterfaceAttrTableID,1,
        New_InterfacePhysicalAttr)
       end if
      else
        call DeleteInterfaceAttribute(In_InterfaceProjectID,
        New_InterfaceAttributeID,
        New_InterfaceAttrTableID)
      end if end for;
    commit work
  end if
end;

commit work;