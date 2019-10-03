/*---------------- Insert Policy in to "Registry" ---------------*/
if not exists(select * from Registry where RegistryId = 'SGChildCarePolicy') then
	Insert into Registry Values('SGChildCarePolicy','Singapore Child Care Leave Policy');
	Insert into SubRegistry Values('SGChildCarePolicy','SGChildCare2000','6','2','7','3','12','','','','','',0,0,'',0,'','','2000-01-01','1899-12-30 00:00:00');
else
	Update SubRegistry SET RegProperty5='12' where SubRegistryId='SGChildCare2000';
end if;

if not exists(select * from Registry where RegistryId = 'SGChildCareProrate') then
	Insert into Registry Values('SGChildCareProrate','Singapore Child Care Leave Prorate Table');
	Insert into SubRegistry Values('SGChildCareProrate','SGChildCare2000P1','0','0','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGChildCareProrate','SGChildCare2000P2','0','2','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGChildCareProrate','SGChildCare2000P3','2','2','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGChildCareProrate','SGChildCare2000P4','2','2','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGChildCareProrate','SGChildCare2000P5','3','3','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGChildCareProrate','SGChildCare2000P6','3','3','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGChildCareProrate','SGChildCare2000P7','4','4','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGChildCareProrate','SGChildCare2000P8','4','4','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGChildCareProrate','SGChildCare2000P9','5','5','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGChildCareProrate','SGChildCare2000P10','5','6','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGChildCareProrate','SGChildCare2000P11','6','6','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGChildCareProrate','SGChildCare2000P12','6','6','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from Registry where RegistryId = 'SGSickHospPolicy') then
	Insert into Registry Values('SGSickHospPolicy','Singapore Sick & Hospitalization Leave Policy');
	Insert into SubRegistry Values('SGSickHospPolicy','SGSickHosp2000','14','60','3','','','','','','','',0,0,'',0,'','','2000-01-01','1899-12-30 00:00:00');
end if;

if not exists(select * from Registry where RegistryId = 'SGSickHospProrate') then
	Insert into Registry Values('SGSickHospProrate','Singapore Sick & Hospitalization Leave Prorate Table');
	Insert into SubRegistry Values('SGSickHospProrate','SGSickHosp2000P1','0','0','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGSickHospProrate','SGSickHosp2000P2','0','0','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGSickHospProrate','SGSickHosp2000P3','5','15','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGSickHospProrate','SGSickHosp2000P4','8','30','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGSickHospProrate','SGSickHosp2000P5','11','45','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGSickHospProrate','SGSickHosp2000P6','14','60','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGSickHospProrate','SGSickHosp2000P7','14','60','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGSickHospProrate','SGSickHosp2000P8','14','60','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGSickHospProrate','SGSickHosp2000P9','14','60','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGSickHospProrate','SGSickHosp2000P10','14','60','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGSickHospProrate','SGSickHosp2000P11','14','60','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
	Insert into SubRegistry Values('SGSickHospProrate','SGSickHosp2000P12','14','60','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if not exists(select * from Registry where RegistryId = 'SGMaternityPolicy') then
	Insert into Registry Values('SGMaternityPolicy','Singapore Maternity Leave Policy');
	Insert into SubRegistry Values('SGMaternityPolicy','SGMaternity2000','112','84','90','','','','','','','',0,0,'',0,'','','2000-01-01','1899-12-30 00:00:00');
end if;

if not exists(select * from Registry where RegistryId = 'SGPaternityPolicy') then
	Insert into Registry Values('SGPaternityPolicy','Singapore Paternity Leave Policy');
	Insert into SubRegistry Values('SGPaternityPolicy','SGPaternity2013','0','7','3','','','','','','','',0,0,'',0,'','','2013-01-01','1899-12-30 00:00:00');
end if;

if not exists(select * from Registry where RegistryId = 'SGSharedParentPolicy') then
	Insert into Registry Values('SGSharedParentPolicy','Singapore Shared Parental Leave Policy');
	Insert into SubRegistry Values('SGSharedParentPolicy','SGSharedParental2013','0','7','3','','','','','','','',0,0,'',0,'','','2013-01-01','1899-12-30 00:00:00');
end if;

if not exists(select * from Registry where RegistryId = 'SGAdoptionPolicy') then
	Insert into Registry Values('SGAdoptionPolicy','Singapore Adoption Leave Policy');
	Insert into SubRegistry Values('SGAdoptionPolicy','SGAdoption2013','0','28','3','','','','','','','',0,0,'',0,'','','2013-01-01','1899-12-30 00:00:00');
end if;

/*---------------- Insert Keyword ---------------*/
if not exists(select * from LeaveKeyword where LveKeywordId = 'MOM ChildCare') then
	Insert into LeaveKeyword Values('MOM ChildCare','MOM ChildCare','ChildCare Leave from MOM','LeaveFunctionAs');
end if;

if not exists(select * from LeaveKeyword where LveKeywordId = 'MOM Sick') then
	Insert into LeaveKeyword Values('MOM Sick','MOM Sick','Sick Leave from MOM','LeaveFunctionAs');
end if;

if not exists(select * from LeaveKeyword where LveKeywordId = 'MOM Hospital') then
	Insert into LeaveKeyword Values('MOM Hospital','MOM Hospital','Hospitalization Leave from MOM','LeaveFunctionAs');
end if;

if not exists(select * from LeaveKeyword where LveKeywordId = 'MOM Maternity') then
	Insert into LeaveKeyword Values('MOM Maternity','MOM Maternity','Maternity Leave from MOM','LeaveFunctionAs');
end if;

if not exists(select * from LeaveKeyword where LveKeywordId = 'MOM Paternity') then
	Insert into LeaveKeyword Values('MOM Paternity','MOM Paternity','Paternity Leave from MOM','LeaveFunctionAs');
end if;

if not exists(select * from LeaveKeyword where LveKeywordId = 'MOM Shared Parental') then
	Insert into LeaveKeyword Values('MOM Shared Parental','MOM Shared Parental','Shared Parental Leave from MOM','LeaveFunctionAs');
end if;

if not exists(select * from LeaveKeyword where LveKeywordId = 'MOM Adoption') then
	Insert into LeaveKeyword Values('MOM Adoption','MOM Adoption','Adoption Leave from MOM','LeaveFunctionAs');
end if;


/*---------------- Insert Relationship---------------*/
if not exists(select * from Relationship where RelationshipId = 'Adopted Son') then
	Insert into Relationship Values('Adopted Son','Adopted Son');
end if;

if not exists(select * from Relationship where RelationshipId = 'Adopted Daughter') then
	Insert into Relationship Values('Adopted Daughter','Adopted Daughter');
end if;

/*---------------- Insert Allocation for MOM---------------*/
if not exists(select * from LveAllocation where LveAllocationId = 'System MOM') then
	Insert into LveAllocation Values('System MOM','System Defined MOM Allocation','ServiceYear');
	Insert into LveAllocationRec Values('System MOM',1,'0',0,99,0,999,0,0,0,0,0,0);
end if;

/*---------------- Insert Leave Type---------------*/
if not exists(select * from LeaveType where LeaveTypeId = 'ChildCare') then
	Insert into LeaveType
		(LeaveTypeId,LeaveCredit,LeaveAbbrev,LeaveColorCode
		,LeaveTypeActive,LeaveTypeDesc,LeaveUnit,HasSpecialEligible)
	Values('ChildCare',0,'CC',16711680,1,'ChildCare',NULL,0);

	Insert into LeaveComputation 
		(LeaveTypeId,HasEntitleApp,HasBFApp,HasForfeitApp
		,HasAdvApp,HasHourApp,HasHalfDayApp,HasDeductSeq
		,LeaveRoundMethod,EntProrateMethod,EntProrateCutOffDay,EntProrateBeforeCutoff
		,NoProrateCareerChange,NoProrateHire,NoProrateCess,EntDistributeMethod
		,BFLeaveTypeId,BFForfeitTime,CanHalfDayApplyHour,LeaveFunctionId
		,HireSuspendMethod,HireSuspendUntil,CessSuspendMethod,CessSuspendStart
		,IncludeHolidayOff,EntTakenNoEnt,HasSIWageDeduct,HasSIReimbursement
		,C04ContriRate,HasLeaveSuspension,LeaveSuspensionMethod,LeaveSuspensionValue
		,LeaveSuspensionField,TotalEntRoundMethod) 
	Values('ChildCare',1,0,0,0,0,1,0,'Half','ProrateByMonth',0,0,0,0,0,'FirstFull','ChildCare',0,0,'MOM ChildCare','SusHDUseConfirmDate',0,'SusCDLastFor',0,1,0,1,1,0,0,'After',0,'LSFDateOfBirth',0);
end if;

if not exists(select * from LeaveType where LeaveTypeId = 'Paternity') then
	Insert into LeaveType
		(LeaveTypeId,LeaveCredit,LeaveAbbrev,LeaveColorCode
		,LeaveTypeActive,LeaveTypeDesc,LeaveUnit,HasSpecialEligible)
	Values('Paternity',0,'PA',8421376,1,'Paternity',NULL,0);
                 
	Insert into LeaveComputation 
		(LeaveTypeId,HasEntitleApp,HasBFApp,HasForfeitApp
		,HasAdvApp,HasHourApp,HasHalfDayApp,HasDeductSeq
		,LeaveRoundMethod,EntProrateMethod,EntProrateCutOffDay,EntProrateBeforeCutoff
		,NoProrateCareerChange,NoProrateHire,NoProrateCess,EntDistributeMethod
		,BFLeaveTypeId,BFForfeitTime,CanHalfDayApplyHour,LeaveFunctionId
		,HireSuspendMethod,HireSuspendUntil,CessSuspendMethod,CessSuspendStart
		,IncludeHolidayOff,EntTakenNoEnt,HasSIWageDeduct,HasSIReimbursement
		,C04ContriRate,HasLeaveSuspension,LeaveSuspensionMethod,LeaveSuspensionValue
		,LeaveSuspensionField,TotalEntRoundMethod) 
	Values('Paternity',1,1,0,0,0,1,0,'Half','ProrateByMonth',0,0,0,0,0,'FirstFull','Paternity',1,0,'MOM Paternity','SusHDUserDefined',3,'SusCDLastFor',0,1,0,0,0,0,0,'After',0,'LSFDateOfBirth',0);
end if;

if not exists(select * from LeaveType where LeaveTypeId = 'Shared Parental') then
	Insert into LeaveType
		(LeaveTypeId,LeaveCredit,LeaveAbbrev,LeaveColorCode
		,LeaveTypeActive,LeaveTypeDesc,LeaveUnit,HasSpecialEligible)
	Values('Shared Parental',0,'SP',8421504,1,'Shared Parental',NULL,0);

	Insert into LeaveComputation 
		(LeaveTypeId,HasEntitleApp,HasBFApp,HasForfeitApp
		,HasAdvApp,HasHourApp,HasHalfDayApp,HasDeductSeq
		,LeaveRoundMethod,EntProrateMethod,EntProrateCutOffDay,EntProrateBeforeCutoff
		,NoProrateCareerChange,NoProrateHire,NoProrateCess,EntDistributeMethod
		,BFLeaveTypeId,BFForfeitTime,CanHalfDayApplyHour,LeaveFunctionId
		,HireSuspendMethod,HireSuspendUntil,CessSuspendMethod,CessSuspendStart
		,IncludeHolidayOff,EntTakenNoEnt,HasSIWageDeduct,HasSIReimbursement
		,C04ContriRate,HasLeaveSuspension,LeaveSuspensionMethod,LeaveSuspensionValue
		,LeaveSuspensionField,TotalEntRoundMethod) 
	Values('Shared Parental',1,1,0,0,0,1,0,'Half','ProrateByMonth',0,0,0,0,0,'FirstFull','Shared Parental',1,0,'MOM Shared Parental','SusHDUserDefined',3,'SusCDLastFor',0,1,0,0,0,0,0,'After',0,'LSFDateOfBirth',0);
end if;

if not exists(select * from LeaveType where LeaveTypeId = 'Adoption') then
	Insert into LeaveType
		(LeaveTypeId,LeaveCredit,LeaveAbbrev,LeaveColorCode
		,LeaveTypeActive,LeaveTypeDesc,LeaveUnit,HasSpecialEligible)
	Values('Adoption',0,'AD',128,1,'Adoption',NULL,0);

	Insert into LeaveComputation 
		(LeaveTypeId,HasEntitleApp,HasBFApp,HasForfeitApp
		,HasAdvApp,HasHourApp,HasHalfDayApp,HasDeductSeq
		,LeaveRoundMethod,EntProrateMethod,EntProrateCutOffDay,EntProrateBeforeCutoff
		,NoProrateCareerChange,NoProrateHire,NoProrateCess,EntDistributeMethod
		,BFLeaveTypeId,BFForfeitTime,CanHalfDayApplyHour,LeaveFunctionId
		,HireSuspendMethod,HireSuspendUntil,CessSuspendMethod,CessSuspendStart
		,IncludeHolidayOff,EntTakenNoEnt,HasSIWageDeduct,HasSIReimbursement
		,C04ContriRate,HasLeaveSuspension,LeaveSuspensionMethod,LeaveSuspensionValue
		,LeaveSuspensionField,TotalEntRoundMethod) 
	Values('Adoption',1,1,0,0,0,1,0,'Half','ProrateByMonth',0,0,0,0,0,'FirstFull','Adoption',1,0,'MOM Adoption','SusHDUserDefined',3,'SusCDLastFor',0,1,0,0,0,0,0,'After',0,'LSFDateOfBirth',0);
end if;

if not exists(select * from LeaveType where LeaveTypeId = 'Sick') then
	Insert into LeaveType
		(LeaveTypeId,LeaveCredit,LeaveAbbrev,LeaveColorCode
		,LeaveTypeActive,LeaveTypeDesc,LeaveUnit,HasSpecialEligible)
	Values('Sick',0,'SL',65280,1,'Sick',NULL,0);

	Insert into LeaveComputation 
		(LeaveTypeId,HasEntitleApp,HasBFApp,HasForfeitApp
		,HasAdvApp,HasHourApp,HasHalfDayApp,HasDeductSeq
		,LeaveRoundMethod,EntProrateMethod,EntProrateCutOffDay,EntProrateBeforeCutoff
		,NoProrateCareerChange,NoProrateHire,NoProrateCess,EntDistributeMethod
		,BFLeaveTypeId,BFForfeitTime,CanHalfDayApplyHour,LeaveFunctionId
		,HireSuspendMethod,HireSuspendUntil,CessSuspendMethod,CessSuspendStart
		,IncludeHolidayOff,EntTakenNoEnt,HasSIWageDeduct,HasSIReimbursement
		,C04ContriRate,HasLeaveSuspension,LeaveSuspensionMethod,LeaveSuspensionValue
		,LeaveSuspensionField,TotalEntRoundMethod) 
	Values('Sick',1,0,0,0,0,1,0,'Round','ProrateByMonth',0,0,0,0,0,'FirstFull','Sick',1,0,'MOM Sick','SusHDUseConfirmDate',0,'SusCDLastFor',0,1,0,1,1,75,0,'',0,'',0);
end if;

if not exists(select * from LeaveType where LeaveTypeId = 'Maternity') then
	Insert into LeaveType
		(LeaveTypeId,LeaveCredit,LeaveAbbrev,LeaveColorCode
		,LeaveTypeActive,LeaveTypeDesc,LeaveUnit,HasSpecialEligible)
	Values('Maternity',0,'MA',16711935,1,'Maternity',NULL,0);

	Insert into LeaveComputation 
		(LeaveTypeId,HasEntitleApp,HasBFApp,HasForfeitApp
		,HasAdvApp,HasHourApp,HasHalfDayApp,HasDeductSeq
		,LeaveRoundMethod,EntProrateMethod,EntProrateCutOffDay,EntProrateBeforeCutoff
		,NoProrateCareerChange,NoProrateHire,NoProrateCess,EntDistributeMethod
		,BFLeaveTypeId,BFForfeitTime,CanHalfDayApplyHour,LeaveFunctionId
		,HireSuspendMethod,HireSuspendUntil,CessSuspendMethod,CessSuspendStart
		,IncludeHolidayOff,EntTakenNoEnt,HasSIWageDeduct,HasSIReimbursement
		,C04ContriRate,HasLeaveSuspension,LeaveSuspensionMethod,LeaveSuspensionValue
		,LeaveSuspensionField,TotalEntRoundMethod) 
	Values('Maternity',1,0,0,0,0,0,0,'Round','ProrateByMonth',0,0,1,1,1,'FirstFull','Maternity',1,0,'MOM Maternity','SusHDUserDefined',3,'SusCDLastFor',0,1,0,0,0,0.0,0,'',0,'LSFDateOfBirth',0);
end if;

if not exists(select * from LeaveType where LeaveTypeId = 'Hospitalisation') then
	Insert into LeaveType
		(LeaveTypeId,LeaveCredit,LeaveAbbrev,LeaveColorCode
		,LeaveTypeActive,LeaveTypeDesc,LeaveUnit,HasSpecialEligible)
	Values('Hospitalisation',0,'HO',12632256,1,'Hospitalisation',NULL,0);

	Insert into LeaveComputation 
		(LeaveTypeId,HasEntitleApp,HasBFApp,HasForfeitApp
		,HasAdvApp,HasHourApp,HasHalfDayApp,HasDeductSeq
		,LeaveRoundMethod,EntProrateMethod,EntProrateCutOffDay,EntProrateBeforeCutoff
		,NoProrateCareerChange,NoProrateHire,NoProrateCess,EntDistributeMethod
		,BFLeaveTypeId,BFForfeitTime,CanHalfDayApplyHour,LeaveFunctionId
		,HireSuspendMethod,HireSuspendUntil,CessSuspendMethod,CessSuspendStart
		,IncludeHolidayOff,EntTakenNoEnt,HasSIWageDeduct,HasSIReimbursement
		,C04ContriRate,HasLeaveSuspension,LeaveSuspensionMethod,LeaveSuspensionValue
		,LeaveSuspensionField,TotalEntRoundMethod) 
	Values('Hospitalisation',1,0,0,0,0,1,0,'Round','ProrateByMonth',0,0,0,0,0,'FirstFull','Hospitalisation',1,0,'MOM Hospital','SusHDUseConfirmDate',0,'SusCDLastFor',0,1,0,1,1,100,0,'',0,'',0);
end if;

/*---------------- Update Leave Policy and Period Balance for MOM Leaves ---------------*/

Update LeavePolicyRecord set LveAllocationId = 'System MOM' where LeaveTypeID in (select LeaveTypeId from LeaveComputation where LeaveFunctionId Like 'MOM%');
Update LvePeriodBalance set AllocRangeBasis='ServiceYear', PerBalLveAllocationID='System MOM', AllocCareerValue='0' where AllocRangeBasis='' AND PerBalLveAllocationID='' AND LeaveTypeID in (select LeaveTypeId from LeaveComputation where LeaveFunctionId Like 'MOM%');

commit work;