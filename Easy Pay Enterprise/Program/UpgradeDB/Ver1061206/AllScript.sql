/* ModuleScreen */
if not exists (select * from ModuleScreenGroup where ModuleScreenId = 'CoreCarBasicProgRpt') then
  insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('CoreCarBasicProgRpt','CoreReports','Career and Basic Rate Progression Report','Core',0,1,0,'');
end if;

UserGroupLoop: FOR UserGroupHis AS DYNAMIC SCROLL CURSOR FOR    
   SELECT UserGroupId AS OUT_UserGroupId  FROM UserGroup 
   WHERE UserGroupHideWage = 1
   DO 
	  IF NOT EXISTS(SELECT * FROM UserModuleNoAccess WHERE ModuleScreenId = 'CoreCarBasicProgRpt' AND UserGroupId = OUT_UserGroupId) THEN
	      INSERT INTO UserModuleNoAccess(ModuleScreenId,UserGroupId)
		  VALUES('CoreCarBasicProgRpt',OUT_UserGroupId);
	  END IF;
   END FOR;

if not exists (select * from ModuleScreenGroup where ModuleScreenId = 'CoreCRCustomMgr') then
  insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('CoreCRCustomMgr','CoreSetup','Manage Customized Crystal Reports','Core',0,0,0,'');
end if;

if not exists (select * from ModuleScreenGroup where ModuleScreenId = 'CoreCRCustom') then
  insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('CoreCRCustom','CoreReports','Customized Crystal Reports','Core',0,0,0,'');
end if;

if not exists (select * from ModuleScreenGroup where ModuleScreenId = 'CostSageOneExport') then
  insert into ModuleScreenGroup(ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('CostSageOneExport','CostReports','Export to Sage One','Costing',0,0,0,'');
end if;

/* Keyword */
if not exists (select * from Keyword where KeyWordId = 'CR_GNCoreCustom') then
  insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                      KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('CR_GNCoreCustom','Core','Custom','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Custom Report',NULL,NULL,0,NULL);
end if;

if not exists (select * from Keyword where KeyWordId = 'CR_GNCoreCarBasicRpt') then
  insert into Keyword(KeyWordId,KeyWordDefaultName,KeyWordUserDefinedName,KeyWordCategory,KeyWordPropertySelection,KeyWordFormulaSelection,KeyWordRangeSelection,
                      KeyWordDesc,KeyWordSubCategory,KeyWordSubProperty,KeyWordStage,KeyWordGroup)
  values('CR_GNCoreCarBasicRpt','Core','Career and Basic Rate Progression Report','CrystalRpt Cus Mgr',NULL,NULL,NULL,'Career and Basic Rate Progression Report',NULL,NULL,1,NULL);
end if;

/* Import Data */
/* Security */
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'CoreImport') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('CoreImport','Core','Import','Core',0,0,0,'');
end if;
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'ImportLeaveApp') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('ImportLeaveApp','CoreImport','Leave Application','Core',0,0,0,'');
end if;
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'ImportMedicalClaim') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('ImportMedicalClaim','CoreImport','Medical Claim','Core',0,0,0,'');
end if;
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'ImportOTRecord') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('ImportOTRecord','CoreImport','OT Record','Core',0,0,0,'');
end if;
if not exists (select 1 from ModuleScreenGroup where ModuleScreenId = 'ImportPayElement') then
  insert into ModuleScreenGroup (ModuleScreenId,Mod_ModuleScreenId,ModuleScreenName,MainModuleName,HideOnlyWage,HideScreenForWage,IsEPClassic,EC_ModuleScreenId)
  values ('ImportPayElement','CoreImport','Pay Element','Core',0,0,0,'');
end if;
/* Leave Application Template */
if not exists (select 1 from ImportProject where ImportProjectId = 'System_LeaveApp') then
  insert into ImportProject (ImportProjectId,InterfaceConnectionId,ImportExtConnection,ImportProjectRemarks,ImportAppearIn)
  values ('System_LeaveApp',NULL,0,NULL,'System');
end if;
if not exists (select 1 from ImportSpreadSheet where ImportSpSheetID = 'System_LeaveApp') then
  insert into ImportSpreadSheet (ImportSpSheetId,ImportSpSheetRemarks,ImportSpSheetPath,ImportSpSheetType,ImportSpSheetPassword)
  values ('System_LeaveApp',NULL,'','Excel',NULL);
end if;
if not exists (select 1 from ImportProjectMember where ImportSpSheetID = 'System_LeaveApp' and ImportProjectId = 'System_LeaveApp') then
  insert into ImportProjectMember (ImportSpSheetId,ImportProjectId,ProcessSequence)
  values ('System_LeaveApp','System_LeaveApp',1);
end if;
if not exists (select 1 from ImportWorkSheet where WorkSheetID = 'System_LeaveApp') then
  insert into ImportWorkSheet (WorkSheetID,WorkSheetName,WorkSheetType,PhysicalTableName,EndingColumn,EndingRow,StartingColumn,StartingRow,LogFileName,LogFilePath)
  values ('System_LeaveApp','Leave Application','Vertical','iLeaveApplication',NULL,99999,NULL,3,'ImportLeaveApplication.log','');
end if;
if not exists (select 1 from ImportSSMember where WorkSheetID = 'System_LeaveApp' and ImportSpSheetId = 'System_LeaveApp') then
  insert into ImportSSMember (WorkSheetID,ImportSpSheetId,ProcessSequence)
  values ('System_LeaveApp','System_LeaveApp',1);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_LeaveApp' and ImportFieldPhysical = 'LveAppEmployeeId') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_LeaveApp','LveAppEmployeeId','A',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_LeaveApp' and ImportFieldPhysical = 'LeaveTypeId') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_LeaveApp','LeaveTypeId','B',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_LeaveApp' and ImportFieldPhysical = 'LveAppFromDate') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_LeaveApp','LveAppFromDate','C',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_LeaveApp' and ImportFieldPhysical = 'LveAppStartTime') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_LeaveApp','LveAppStartTime','D',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_LeaveApp' and ImportFieldPhysical = 'LveAppToDate') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_LeaveApp','LveAppToDate','E',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_LeaveApp' and ImportFieldPhysical = 'LveAppEndTime') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_LeaveApp','LveAppEndTime','F',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_LeaveApp' and ImportFieldPhysical = 'LveAppConvertDays') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_LeaveApp','LveAppConvertDays','G',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_LeaveApp' and ImportFieldPhysical = 'LveAppApproved') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_LeaveApp','LveAppApproved','H',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_LeaveApp' and ImportFieldPhysical = 'Remarks') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_LeaveApp','Remarks','I',0,'1899-12-30','',0,0.0);
end if;
/* Medical Claim Template */
if not exists (select 1 from ImportProject where ImportProjectId = 'System_MedicalClaim') then
  insert into ImportProject (ImportProjectId,InterfaceConnectionId,ImportExtConnection,ImportProjectRemarks,ImportAppearIn)
  values ('System_MedicalClaim',NULL,0,NULL,'System');
end if;
if not exists (select 1 from ImportSpreadSheet where ImportSpSheetID = 'System_MedicalClaim') then
  insert into ImportSpreadSheet (ImportSpSheetId,ImportSpSheetRemarks,ImportSpSheetPath,ImportSpSheetType,ImportSpSheetPassword)
  values ('System_MedicalClaim',NULL,'','Excel',NULL);
end if;
if not exists (select 1 from ImportProjectMember where ImportSpSheetID = 'System_MedicalClaim' and ImportProjectId = 'System_MedicalClaim') then
  insert into ImportProjectMember (ImportSpSheetId,ImportProjectId,ProcessSequence)
  values ('System_MedicalClaim','System_MedicalClaim',1);
end if;
if not exists (select 1 from ImportWorkSheet where WorkSheetID = 'System_MedicalClaim') then
  insert into ImportWorkSheet (WorkSheetID,WorkSheetName,WorkSheetType,PhysicalTableName,EndingColumn,EndingRow,StartingColumn,StartingRow,LogFileName,LogFilePath)
  values ('System_MedicalClaim','Medical Claim','Vertical','iMedClaim',NULL,99999,NULL,3,'ImportMedicalClaim.log','');
end if;
if not exists (select 1 from ImportSSMember where WorkSheetID = 'System_MedicalClaim' and ImportSpSheetId = 'System_MedicalClaim') then
  insert into ImportSSMember (WorkSheetID,ImportSpSheetId,ProcessSequence)
  values ('System_MedicalClaim','System_MedicalClaim',1);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'MedClaimIdentityNo') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','MedClaimIdentityNo','A',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'MedClaimEmployeeId') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','MedClaimEmployeeId','B',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'MedClaimTypeId') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','MedClaimTypeId','C',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'MedClaimReasonId') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','MedClaimReasonId','D',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'IllnessId') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','IllnessId','E',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'TreatmentTypeId') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','TreatmentTypeId','F',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'SubmissionDate') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','SubmissionDate','G',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'MedClaimNo') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','MedClaimNo','H',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'MedReceiptDate') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','MedReceiptDate','I',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'ClaimAmount') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','ClaimAmount','J',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'ReimburseAmt') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','ReimburseAmt','K',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'MedClaimAppr') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','MedClaimAppr','L',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'VendorBilled') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','VendorBilled','M',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'Vendor') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','Vendor','N',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'VendorAmount') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','VendorAmount','O',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'UseMedSaveClaim') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','UseMedSaveClaim','P',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'InsuranceClaim') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','InsuranceClaim','Q',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'InsuranceRefNo') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','InsuranceRefNo','R',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'HospitalClinic') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','HospitalClinic','S',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'TreatmentFrom') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','TreatmentFrom','T',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'TreatmentTo') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','TreatmentTo','U',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'TreatmentLength') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','TreatmentLength','V',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'ePortalStatus') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','ePortalStatus','W',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_MedicalClaim' and ImportFieldPhysical = 'Remarks') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_MedicalClaim','Remarks','X',0,'1899-12-30','',0,0.0);
end if;
/* OT Record Template */
if not exists (select 1 from ImportProject where ImportProjectId = 'System_OTRecord') then
  insert into ImportProject (ImportProjectId,InterfaceConnectionId,ImportExtConnection,ImportProjectRemarks,ImportAppearIn)
  values ('System_OTRecord',NULL,0,NULL,'System');
end if;
if not exists (select 1 from ImportSpreadSheet where ImportSpSheetID = 'System_OTRecord') then
  insert into ImportSpreadSheet (ImportSpSheetId,ImportSpSheetRemarks,ImportSpSheetPath,ImportSpSheetType,ImportSpSheetPassword)
  values ('System_OTRecord',NULL,'','Excel',NULL);
end if;
if not exists (select 1 from ImportProjectMember where ImportSpSheetID = 'System_OTRecord' and ImportProjectId = 'System_OTRecord') then
  insert into ImportProjectMember (ImportSpSheetId,ImportProjectId,ProcessSequence)
  values ('System_OTRecord','System_OTRecord',1);
end if;
if not exists (select 1 from ImportWorkSheet where WorkSheetID = 'System_OTRecord') then
  insert into ImportWorkSheet (WorkSheetID,WorkSheetName,WorkSheetType,PhysicalTableName,EndingColumn,EndingRow,StartingColumn,StartingRow,LogFileName,LogFilePath)
  values ('System_OTRecord','OT Record','Vertical','iOTRecord',NULL,99999,NULL,3,'ImportOTRecord.log','');
end if;
if not exists (select 1 from ImportSSMember where WorkSheetID = 'System_OTRecord' and ImportSpSheetId = 'System_OTRecord') then
  insert into ImportSSMember (WorkSheetID,ImportSpSheetId,ProcessSequence)
  values ('System_OTRecord','System_OTRecord',1);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_OTRecord' and ImportFieldPhysical = 'OTEmployeeID') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_OTRecord','OTEmployeeID','A',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_OTRecord' and ImportFieldPhysical = 'OTID') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_OTRecord','OTID','B',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_OTRecord' and ImportFieldPhysical = 'OTDate') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_OTRecord','OTDate','C',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_OTRecord' and ImportFieldPhysical = 'PayRecID') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_OTRecord','PayRecID','D',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_OTRecord' and ImportFieldPhysical = 'CurrentOTFreq') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_OTRecord','CurrentOTFreq','E',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_OTRecord' and ImportFieldPhysical = 'LastOTFreq') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_OTRecord','LastOTFreq','F',0,'1899-12-30','',0,0.0);
end if;
/* Pay Element Template */
if not exists (select 1 from ImportProject where ImportProjectId = 'System_PayElement') then
  insert into ImportProject (ImportProjectId,InterfaceConnectionId,ImportExtConnection,ImportProjectRemarks,ImportAppearIn)
  values ('System_PayElement',NULL,0,NULL,'System');
end if;
if not exists (select 1 from ImportSpreadSheet where ImportSpSheetID = 'System_PayElement') then
  insert into ImportSpreadSheet (ImportSpSheetId,ImportSpSheetRemarks,ImportSpSheetPath,ImportSpSheetType,ImportSpSheetPassword)
  values ('System_PayElement',NULL,'','Excel',NULL);
end if;
if not exists (select 1 from ImportProjectMember where ImportSpSheetID = 'System_PayElement' and ImportProjectId = 'System_PayElement') then
  insert into ImportProjectMember (ImportSpSheetId,ImportProjectId,ProcessSequence)
  values ('System_PayElement','System_PayElement',1);
end if;
if not exists (select 1 from ImportWorkSheet where WorkSheetID = 'System_PayElement') then
  insert into ImportWorkSheet (WorkSheetID,WorkSheetName,WorkSheetType,PhysicalTableName,EndingColumn,EndingRow,StartingColumn,StartingRow,LogFileName,LogFilePath)
  values ('System_PayElement','Pay Element','Vertical','iAllowanceRecord',NULL,99999,NULL,3,'ImportPayElement.log','');
end if;
if not exists (select 1 from ImportSSMember where WorkSheetID = 'System_PayElement' and ImportSpSheetId = 'System_PayElement') then
  insert into ImportSSMember (WorkSheetID,ImportSpSheetId,ProcessSequence)
  values ('System_PayElement','System_PayElement',1);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_PayElement' and ImportFieldPhysical = 'AllowanceEmployeeID') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_PayElement','AllowanceEmployeeID','A',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_PayElement' and ImportFieldPhysical = 'PayRecID') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_PayElement','PayRecID','B',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_PayElement' and ImportFieldPhysical = 'AllowanceID') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_PayElement','AllowanceID','C',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_PayElement' and ImportFieldPhysical = 'AllowanceAmount') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_PayElement','AllowanceAmount','D',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_PayElement' and ImportFieldPhysical = 'AllowanceDate') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_PayElement','AllowanceDate','E',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_PayElement' and ImportFieldPhysical = 'AllowanceDeclaredDate') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_PayElement','AllowanceDeclaredDate','F',0,'1899-12-30','',0,0.0);
end if;
if not exists (select 1 from ImportField where WorkSheetID = 'System_PayElement' and ImportFieldPhysical = 'AllowanceRemarks') then
  insert into ImportField (WorkSheetID,ImportFieldPhysical,Column,Row,DateValue,StringValue,IntegerValue,NumericValue)
  values ('System_PayElement','AllowanceRemarks','G',0,'1899-12-30','',0,0.0);
end if;
/* InterfaceProject */
if not exists (select 1 from InterfaceProject where InterfaceProjectID = 'System_Import') then
  insert into InterfaceProject (InterfaceProjectID,InterfaceProjRemarks)
  values ('System_Import','');
end if;
/* InterfaceAttribute */
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'BasicRateExchangeId' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','BasicRateExchangeId','Employee',1,'BasicRateExchangeId');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'BranchId' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','BranchId','Employee',1,'BranchId');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'CalendarId' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','CalendarId','Employee',1,'CalendarId');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'CategoryId' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','CategoryId','Employee',1,'CategoryId');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'CessationCode' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','CessationCode','Employee',1,'CessationCode');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'CessationDate' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','CessationDate','Employee',1,'CessationDate');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'ClassificationCode' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','ClassificationCode','Employee',1,'ClassificationCode');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'ConfirmationDate' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','ConfirmationDate','Employee',1,'ConfirmationDate');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'ContractEndDate' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','ContractEndDate','Employee',1,'ContractEndDate');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'ContractNo' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','ContractNo','Employee',1,'ContractNo');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'ContractStartDate' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','ContractStartDate','Employee',1,'ContractStartDate');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'CostCentreId' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','CostCentreId','Employee',1,'CostCentreId');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'CurrentBasicRate' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','CurrentBasicRate','Employee',1,'CurrentBasicRate');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'CurrentBasicRateType' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','CurrentBasicRateType','Employee',1,'CurrentBasicRateType');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'CurrentMVC' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','CurrentMVC','Employee',1,'CurrentMVC');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'CurrentNWC' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','CurrentNWC','Employee',1,'CurrentNWC');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'DepartmentId' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','DepartmentId','Employee',1,'DepartmentId');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'HireDate' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','HireDate','Employee',1,'HireDate');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'IsSupervisor' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','IsSupervisor','Employee',1,'IsSupervisor');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'MVCPercentage' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','MVCPercentage','Employee',1,'MVCPercentage');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'PositionId' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','PositionId','Employee',1,'PositionId');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'PreviousSvcYear' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','PreviousSvcYear','Employee',1,'PreviousSvcYear');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'ProbationPeriod' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','ProbationPeriod','Employee',1,'ProbationPeriod');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'ProbationUnit' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','ProbationUnit','Employee',1,'ProbationUnit');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'RetirementAge' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','RetirementAge','Employee',1,'RetirementAge');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'RetirementDate' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','RetirementDate','Employee',1,'RetirementDate');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'SalaryGradeId' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','SalaryGradeId','Employee',1,'SalaryGradeId');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'SectionId' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','SectionId','Employee',1,'SectionId');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'Supervisor' and InterfaceAttrTableID = 'Employee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','Supervisor','Employee',1,'Supervisor');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'FullDayWorkTimeProfi' and InterfaceAttrTableID = 'LeaveEmployee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','FullDayWorkTimeProfi','LeaveEmployee',1,'FullDayWorkTimeProfile');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'HalfDayWorkTimeProfi' and InterfaceAttrTableID = 'LeaveEmployee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','HalfDayWorkTimeProfi','LeaveEmployee',1,'HalfDayWorkTimeProfile');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'HasShiftRotation' and InterfaceAttrTableID = 'LeaveEmployee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','HasShiftRotation','LeaveEmployee',1,'HasShiftRotation');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'LeaveGroupId' and InterfaceAttrTableID = 'LeaveEmployee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','LeaveGroupId','LeaveEmployee',1,'LeaveGroupId');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'QuarterDayWorkTimePr' and InterfaceAttrTableID = 'LeaveEmployee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','QuarterDayWorkTimePr','LeaveEmployee',1,'QuarterDayWorkTimeProfile');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'SuspendLeave' and InterfaceAttrTableID = 'LeaveEmployee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','SuspendLeave','LeaveEmployee',1,'SuspendLeave');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'WTCalendarId' and InterfaceAttrTableID = 'LeaveEmployee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','WTCalendarId','LeaveEmployee',1,'WTCalendarId');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'ANNLveBroughtForward' and InterfaceAttrTableID = 'PayEmployee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','ANNLveBroughtForward','PayEmployee',1,'ANNLveBroughtForward');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'ANNLveEntitlement' and InterfaceAttrTableID = 'PayEmployee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','ANNLveEntitlement','PayEmployee',1,'ANNLveEntitlement');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'BonusFactor' and InterfaceAttrTableID = 'PayEmployee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','BonusFactor','PayEmployee',1,'BonusFactor');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'DefaultHourRate' and InterfaceAttrTableID = 'PayEmployee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','DefaultHourRate','PayEmployee',1,'DefaultHourRate');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'EEHoursperDay' and InterfaceAttrTableID = 'PayEmployee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','EEHoursperDay','PayEmployee',1,'EEHoursperDay');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'LastPayDate' and InterfaceAttrTableID = 'PayEmployee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','LastPayDate','PayEmployee',1,'LastPayDate');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'MVCCapping' and InterfaceAttrTableID = 'PayEmployee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','MVCCapping','PayEmployee',1,'MVCCapping');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'PaySlipMessage' and InterfaceAttrTableID = 'PayEmployee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','PaySlipMessage','PayEmployee',1,'PaySlipMessage');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'PaySuspense' and InterfaceAttrTableID = 'PayEmployee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','PaySuspense','PayEmployee',1,'PaySuspense');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'SickLveEntitlement' and InterfaceAttrTableID = 'PayEmployee') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','SickLveEntitlement','PayEmployee',1,'SickLveEntitlement');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'Alias' and InterfaceAttrTableID = 'Personal') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','Alias','Personal',1,'Alias');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'BloodGroupId' and InterfaceAttrTableID = 'Personal') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','BloodGroupId','Personal',1,'BloodGroupId');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'CountryOfBirth' and InterfaceAttrTableID = 'Personal') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','CountryOfBirth','Personal',1,'CountryOfBirth');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'DateOfBirth' and InterfaceAttrTableID = 'Personal') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','DateOfBirth','Personal',1,'DateOfBirth');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'Gender' and InterfaceAttrTableID = 'Personal') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','Gender','Personal',1,'Gender');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'Height' and InterfaceAttrTableID = 'Personal') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','Height','Personal',1,'Height');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'IdentityTypeId' and InterfaceAttrTableID = 'Personal') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','IdentityTypeId','Personal',1,'IdentityTypeId');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'Mal_OldIdentity' and InterfaceAttrTableID = 'Personal') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','Mal_OldIdentity','Personal',1,'Mal_OldIdentity');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'MaritalStatusCode' and InterfaceAttrTableID = 'Personal') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','MaritalStatusCode','Personal',1,'MaritalStatusCode');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'Nationality' and InterfaceAttrTableID = 'Personal') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','Nationality','Personal',1,'Nationality');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'PassportIssue' and InterfaceAttrTableID = 'Personal') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','PassportIssue','Personal',1,'PassportIssue');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'PersonalName' and InterfaceAttrTableID = 'Personal') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','PersonalName','Personal',1,'PersonalName');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'PersonalTypeId' and InterfaceAttrTableID = 'Personal') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','PersonalTypeId','Personal',1,'PersonalTypeId');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'RaceId' and InterfaceAttrTableID = 'Personal') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','RaceId','Personal',1,'RaceId');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'ReligionID' and InterfaceAttrTableID = 'Personal') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','ReligionID','Personal',1,'ReligionID');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'TitleId' and InterfaceAttrTableID = 'Personal') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','TitleId','Personal',1,'TitleId');
end if;
if not exists (select 1 from InterfaceAttribute where InterfaceProjectID = 'System_Import' and InterfaceAttributeID = 'Weight' and InterfaceAttrTableID = 'Personal') then
  insert into InterfaceAttribute (InterfaceProjectID,InterfaceAttributeID,InterfaceAttrTableID,InterfaceAttrUse,InterfacePhysicalAttr)
  values ('System_Import','Weight','Personal',1,'Weight');
end if;
/* InterfaceProcess */
if not exists (select 1 from InterfaceProcess where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Casual Pay Process') then
  insert into InterfaceProcess (InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks)
  values ('System_Import','Casual Pay Process',NULL,0,0,'');
end if;
if not exists (select 1 from InterfaceProcess where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Daily Hourly Process') then
  insert into InterfaceProcess (InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks)
  values ('System_Import','Daily Hourly Process',NULL,0,0,'');
end if;
if not exists (select 1 from InterfaceProcess where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process') then
  insert into InterfaceProcess (InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks)
  values ('System_Import','Employment Process',NULL,0,0,'');
end if;
if not exists (select 1 from InterfaceProcess where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process') then
  insert into InterfaceProcess (InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks)
  values ('System_Import','HR Process',NULL,0,0,'');
end if;
if not exists (select 1 from InterfaceProcess where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Income Tax Process') then
  insert into InterfaceProcess (InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks)
  values ('System_Import','Income Tax Process',NULL,0,0,'');
end if;
if not exists (select 1 from InterfaceProcess where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Leave Process') then
  insert into InterfaceProcess (InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks)
  values ('System_Import','Leave Process',NULL,0,0,'');
end if;
if not exists (select 1 from InterfaceProcess where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Lve Summary Process') then
  insert into InterfaceProcess (InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks)
  values ('System_Import','Lve Summary Process',NULL,0,0,'');
end if;
if not exists (select 1 from InterfaceProcess where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'OT Process') then
  insert into InterfaceProcess (InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks)
  values ('System_Import','OT Process',NULL,0,1,'');
end if;
if not exists (select 1 from InterfaceProcess where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Pay Element Process') then
  insert into InterfaceProcess (InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks)
  values ('System_Import','Pay Element Process',NULL,0,1,'');
end if;
if not exists (select 1 from InterfaceProcess where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Setup Process') then
  insert into InterfaceProcess (InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks)
  values ('System_Import','Setup Process',NULL,0,0,'');
end if;
if not exists (select 1 from InterfaceProcess where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Shift Process') then
  insert into InterfaceProcess (InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks)
  values ('System_Import','Shift Process',NULL,0,0,'');
end if;
if not exists (select 1 from InterfaceProcess where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Time Sheet Detail') then
  insert into InterfaceProcess (InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks)
  values ('System_Import','Time Sheet Detail',NULL,0,0,'');
end if;
if not exists (select 1 from InterfaceProcess where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'YTD Process') then
  insert into InterfaceProcess (InterfaceProjectID,InterfaceProcessID,InterfaceConnectionId,IntProcExtConnection,IntProcActivate,IntProcRemarks)
  values ('System_Import','YTD Process',NULL,0,0,'');
end if;
/* InterfaceCodeTable */
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Casual Pay Process' and CodeTableID = 'CasBranch') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Casual Pay Process','CasBranch','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Casual Pay Process' and CodeTableID = 'CasCategory') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Casual Pay Process','CasCategory','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Casual Pay Process' and CodeTableID = 'CasClassification') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Casual Pay Process','CasClassification','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Casual Pay Process' and CodeTableID = 'CasCustomCode1') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Casual Pay Process','CasCustomCode1','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Casual Pay Process' and CodeTableID = 'CasCustomCode2') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Casual Pay Process','CasCustomCode2','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Casual Pay Process' and CodeTableID = 'CasCustomCode3') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Casual Pay Process','CasCustomCode3','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Casual Pay Process' and CodeTableID = 'CasCustomCode4') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Casual Pay Process','CasCustomCode4','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Casual Pay Process' and CodeTableID = 'CasCustomCode5') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Casual Pay Process','CasCustomCode5','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Casual Pay Process' and CodeTableID = 'CasCustomLocation') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Casual Pay Process','CasCustomLocation','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Casual Pay Process' and CodeTableID = 'CasDepartment') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Casual Pay Process','CasDepartment','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Casual Pay Process' and CodeTableID = 'CasPayment') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Casual Pay Process','CasPayment','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Casual Pay Process' and CodeTableID = 'CasPosition') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Casual Pay Process','CasPosition','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Casual Pay Process' and CodeTableID = 'CasSalaryGrade') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Casual Pay Process','CasSalaryGrade','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Casual Pay Process' and CodeTableID = 'CasSection') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Casual Pay Process','CasSection','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'BankAccTypeId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','BankAccTypeId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'BankAllocGroup') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','BankAllocGroup','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'BankBranchId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','BankBranchId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'BankId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','BankId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'BasicRateType') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','BasicRateType','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'BloodGroup') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','BloodGroup','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'Branch') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','Branch','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'CalendarId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','CalendarId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'CareerId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','CareerId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'Category') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','Category','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'CessationCode') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','CessationCode','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'City') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','City','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'Classification') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','Classification','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'ContactLocationId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','ContactLocationId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'CostCentreId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','CostCentreId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'Country') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','Country','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'CountryOfBirth') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','CountryOfBirth','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'Department') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','Department','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'EducationId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','EducationId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'EmpCode1') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','EmpCode1','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'EmpCode2') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','EmpCode2','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'EmpCode3') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','EmpCode3','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'EmpCode4') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','EmpCode4','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'EmpCode5') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','EmpCode5','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'EmpeeOtherInfoId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','EmpeeOtherInfoId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'EmpLocation1') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','EmpLocation1','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'ExchangeRateId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','ExchangeRateId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'FieldMajorId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','FieldMajorId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'FWLClass') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','FWLClass','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'Gender') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','Gender','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'IdentityTypeId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','IdentityTypeId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'LeaveGroupId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','LeaveGroupId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'MaritalStatus') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','MaritalStatus','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'Nationality') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','Nationality','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'NewBankBranchId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','NewBankBranchId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'NewBankId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','NewBankId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'OccupationId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','OccupationId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'PassportIssue') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','PassportIssue','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'PaymentMode') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','PaymentMode','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'PaymentType') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','PaymentType','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'PersonalTypeId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','PersonalTypeId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'Position') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','Position','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'Race') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','Race','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'Relationship') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','Relationship','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'Religion') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','Religion','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'ResidenceTypeId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','ResidenceTypeId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'SalaryGrade') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','SalaryGrade','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'Section') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','Section','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'State') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','State','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'TitleCode') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','TitleCode','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'WTCalendarId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','WTCalendarId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Employment Process' and CodeTableID = 'WTProfileId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Employment Process','WTProfileId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'ActionTaken') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','ActionTaken','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'AwardDiscCode') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','AwardDiscCode','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'EmploymentTypeId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','EmploymentTypeId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'GradeCode') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','GradeCode','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'HRMaritalStatus') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','HRMaritalStatus','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'HRPassportIssue') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','HRPassportIssue','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'HRPayElementCode') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','HRPayElementCode','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'IllnessId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','IllnessId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'JobGrade') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','JobGrade','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'MedClaimReasonId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','MedClaimReasonId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'MedClaimTypeId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','MedClaimTypeId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'MediaId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','MediaId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'MembershipCode') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','MembershipCode','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'OffenceType') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','OffenceType','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'OrganisationCode') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','OrganisationCode','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'OrganisationIndustry') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','OrganisationIndustry','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'OrganisationType') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','OrganisationType','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'RecruitCode') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','RecruitCode','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'ResponsibilityId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','ResponsibilityId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'SalaryType') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','SalaryType','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'SkillCode') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','SkillCode','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'HR Process' and CodeTableID = 'TreatmentTypeId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','HR Process','TreatmentTypeId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Income Tax Process' and CodeTableID = 'CompanyIDType') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Income Tax Process','CompanyIDType','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Leave Process' and CodeTableID = 'LeaveCode') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Leave Process','LeaveCode','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Lve Summary Process' and CodeTableID = 'LeaveReasonId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Lve Summary Process','LeaveReasonId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Lve Summary Process' and CodeTableID = 'LeaveTypeId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Lve Summary Process','LeaveTypeId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'OT Process' and CodeTableID = 'OTCode') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','OT Process','OTCode','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Pay Element Process' and CodeTableID = 'PayElementCode') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Pay Element Process','PayElementCode','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Shift Process' and CodeTableID = 'ShiftCode') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Shift Process','ShiftCode','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Time Sheet Detail' and CodeTableID = 'TMSExchangeRateId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Time Sheet Detail','TMSExchangeRateId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'Time Sheet Detail' and CodeTableID = 'TMSPaymentType') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','Time Sheet Detail','TMSPaymentType','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'YTD Process' and CodeTableID = 'YTDAllowanceId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','YTD Process','YTDAllowanceId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'YTD Process' and CodeTableID = 'YTDAllowanceRecurFor') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','YTD Process','YTDAllowanceRecurFor','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'YTD Process' and CodeTableID = 'YTDBasicRateType') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','YTD Process','YTDBasicRateType','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'YTD Process' and CodeTableID = 'YTDCPFClass') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','YTD Process','YTDCPFClass','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'YTD Process' and CodeTableID = 'YTDCPFStatus') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','YTD Process','YTDCPFStatus','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'YTD Process' and CodeTableID = 'YTDLveTypeFunctCode') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','YTD Process','YTDLveTypeFunctCode','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'YTD Process' and CodeTableID = 'YTDOTId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','YTD Process','YTDOTId','',1,0,'');
end if;
if not exists (select 1 from InterfaceCodeTable where InterfaceProjectID = 'System_Import' and InterfaceProcessID = 'YTD Process' and CodeTableID = 'YTDShiftId') then
  insert into InterfaceCodeTable (InterfaceProjectID,InterfaceProcessID,CodeTableID,CodeSQLStatement,CodeSkipMapping,CodeUseExternal,CodeExternalSQL)
  values ('System_Import','YTD Process','YTDShiftId','',1,0,'');
end if;

/* Cost Record - Sage One Export*/
if exists(select * from sys.sysprocedure where proc_name = 'FGetCostRecordAffectedGLCode') then
   drop function FGetCostRecordAffectedGLCode;
end if;

CREATE FUNCTION DBA.FGetCostRecordAffectedGLCode(
in In_EmployeeSysId integer,
in In_CostYear integer,
in In_CostPeriod integer,
in In_CostSubPeriod integer,
in In_CostCentreId char(20),
in In_CostItemId char(20),
in In_CostItemType char(20),
in In_CostComponentId char(20)
)
returns char(20)
begin
    declare Out_GLCode char(20);
    declare Out_DebitAmt double;
    declare Out_CreditAmt double;
    declare Out_TranAmt double;

    SELECT GLCode AS GLCode
    ,FGetNetAmt((CostDebitAmt+CostDebitAdj),(CostCreditAmt+CostCreditAdj),1) AS  DebitAmt           
    ,FGetNetAmt((CostDebitAmt+CostDebitAdj),(CostCreditAmt+CostCreditAdj),0) AS CreditAmt 
    ,(Case when IsCreditItem=1 then CreditAmt else DebitAmt end) AS TranAmt
    INTO Out_GLCode, Out_DebitAmt, Out_CreditAmt, Out_TranAmt
    FROM 
        CostPeriod JOIN CostSubPeriod JOIN CostRecord
    JOIN CostItem On CostRecord.CostItemId = CostItem.CostItemId and CostRecord.CostItemType=CostItem.CostItemType
    WHERE  
    EmployeeSysId = In_EmployeeSysId 
    AND CostYear = In_CostYear
    AND costPeriod = In_CostPeriod 
    AND CostRecord.CostSubPeriod = In_CostSubPeriod 
    AND CostRecord.CostCentreId = In_CostCentreId 
    AND CostRecord.CostItemId = In_CostItemId 
    AND CostRecord.CostItemType = In_CostItemType 
    AND CostRecord.CostComponentId = In_CostComponentId
    AND TranAmt = 0; 

    return(Out_GLCode);
end;

commit work;