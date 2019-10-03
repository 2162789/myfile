IF EXISTS(SELECT * FROM LicenseRecord WHERE Functionlist like '%EP Standard%') THEN

   /*----- Create Leave Type -----*/

   IF NOT EXISTS(SELECT* FROM LeaveType WHERE LeaveTypeId = 'ChildCare Enhanced') THEN

      INSERT INTO LeaveType 
      (LeaveTypeId,LeaveCredit,LeaveAbbrev,LeaveColorCode,LeaveTypeActive,LeaveTypeDesc,LeaveUnit,HasSpecialEligible,SpecialEligibleCode,SpecialEligibleMethod,SpecialEligibleValue)
      VALUES('ChildCare Enhanced',0,'CE',16711680,1,'Enhanced ChildCare',0,0,'LSFDateOfBirth','Before',6);

      INSERT INTO LeaveComputation 
      (LeaveTypeId,HasEntitleApp,HasBFApp,HasForfeitApp,HasAdvApp,HasHourApp,HasHalfDayApp,HasDeductSeq,LeaveRoundMethod,EntProrateMethod,EntProrateCutOffDay,EntProrateBeforeCutoff,NoProrateCareerChange,NoProrateHire,NoProrateCess,EntDistributeMethod,BFLeaveTypeId,BFForfeitTime,CanHalfDayApplyHour,LeaveFunctionId,HireSuspendMethod,HireSuspendUntil,CessSuspendMethod,CessSuspendStart,IncludeHolidayOff,EntTakenNoEnt,HasSIWageDeduct,HasSIReimbursement,C04ContriRate,HasLeaveSuspension,LeaveSuspensionMethod,LeaveSuspensionValue,LeaveSuspensionField,TotalEntRoundMethod)
      VALUES('ChildCare Enhanced',1,0,0,0,0,1,0,'Fixed','ProrateByMonth',15,0.5,0,0,0,'FirstFull','ChildCare Enhanced',1,0,'Other','SusHDUseConfirmDate',0,'SusCDLastFor',1,1,0,0,0,0.0,0,'After',0,'LSF7thBirthday',0);

   END IF;

   IF NOT EXISTS(SELECT* FROM LeaveType WHERE LeaveTypeId = 'Maternity Enhanced') THEN

      INSERT INTO LeaveType 
      (LeaveTypeId,LeaveCredit,LeaveAbbrev,LeaveColorCode,LeaveTypeActive,LeaveTypeDesc,LeaveUnit,HasSpecialEligible,SpecialEligibleCode,SpecialEligibleMethod,SpecialEligibleValue)
      VALUES('Maternity Enhanced',0,'ME',16711935,1,'Enhanced Maternity',0,0,'LSFDateOfBirth','Before',6);

      INSERT INTO LeaveComputation 
      (LeaveTypeId,HasEntitleApp,HasBFApp,HasForfeitApp,HasAdvApp,HasHourApp,HasHalfDayApp,HasDeductSeq,LeaveRoundMethod,EntProrateMethod,EntProrateCutOffDay,EntProrateBeforeCutoff,NoProrateCareerChange,NoProrateHire,NoProrateCess,EntDistributeMethod,BFLeaveTypeId,BFForfeitTime,CanHalfDayApplyHour,LeaveFunctionId,HireSuspendMethod,HireSuspendUntil,CessSuspendMethod,CessSuspendStart,IncludeHolidayOff,EntTakenNoEnt,HasSIWageDeduct,HasSIReimbursement,C04ContriRate,HasLeaveSuspension,LeaveSuspensionMethod,LeaveSuspensionValue,LeaveSuspensionField,TotalEntRoundMethod)
      VALUES('Maternity Enhanced',1,0,0,0,0,0,0,'Round','ProrateByMonth',15,0.5,1,1,1,'FirstFull','Maternity Enhanced',1,0,'Other','SusHDUseConfirmDate',0,'SusCDLastFor',1,1,0,0,0,0.0,1,'After',12,'LSFDateOfBirth',0);

      INSERT INTO LeaveEligibleGroup 
      (LeaveTypeId,LeaveEligibleGroup)
      VALUES('Maternity Enhanced','Gender');

      INSERT INTO LeaveEligibleItem 
      (LeaveTypeId,LeaveEligibleGroup,LeaveEligibleItem)
      VALUES('Maternity Enhanced','Gender','Female');

   END IF;

   /*----- Create Leave Allocation -----*/

   IF NOT EXISTS(SELECT* FROM LveAllocation WHERE LveAllocationId = 'ChildCare Enhanced') THEN

      INSERT INTO LveAllocation
      (LveAllocationId,LveAllocationDesc,LveAllocationBasis)
      VALUES('ChildCare Enhanced','Enhanced ChildCare','ChildAge');

      INSERT INTO LveAllocationRec
      (LveAllocationId,LveAllocationSysId,LveAllocStringMatch,LveAllocRangeFrom,LveAllocRangeTo,MaxEntPerCycle,MaxBFPerCycle,MaxForfeitPerCycle,MaxAdvPerCycle,MaxHalfPerCycle,MaxHalfOnHalf,MaxHourPerDay,MaxHourPerCycle)
      VALUES('ChildCare Enhanced',1,'0',0.0,7.0,4.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0);

   END IF;

   IF NOT EXISTS(SELECT* FROM LveAllocation WHERE LveAllocationId = 'Maternity Enhanced') THEN

      INSERT INTO LveAllocation
      (LveAllocationId,LveAllocationDesc,LveAllocationBasis)
      VALUES('Maternity Enhanced','Enhanced Maternity','Gender');

      INSERT INTO LveAllocationRec
      (LveAllocationId,LveAllocationSysId,LveAllocStringMatch,LveAllocRangeFrom,LveAllocRangeTo,MaxEntPerCycle,MaxBFPerCycle,MaxForfeitPerCycle,MaxAdvPerCycle,MaxHalfPerCycle,MaxHalfOnHalf,MaxHourPerDay,MaxHourPerCycle)
      VALUES('Maternity Enhanced',1,'Female',0.0,0.0,56.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0);

   END IF;

   /*----- Create Leave Policy -----*/

   IF NOT EXISTS(SELECT* FROM LeavePolicy WHERE LeavePolicyId = 'Govt Enhanced Policy') THEN

      INSERT INTO LeavePolicy
      (LeavePolicyId,LeavePolicyDesc,LeavePolicyBasis,LeaveCalendarType,LeaveStartMonth)
      VALUES('Govt Enhanced Policy','Govt Enhanced Policy','Category','ByCalendar',1);

      INSERT INTO LeavePolicyRecord
      (LeaveTypeId,LveAllocationId,LeavePolicyId,CostMethodId,PolicyStringMatch,PolicyRangeFrom,PolicyRangeTo)
      VALUES('ChildCare Enhanced','ChildCare Enhanced','Govt Enhanced Policy','Current TW-WDays','???',0.0,0.0);

      INSERT INTO LeavePolicyRecord
      (LeaveTypeId,LveAllocationId,LeavePolicyId,CostMethodId,PolicyStringMatch,PolicyRangeFrom,PolicyRangeTo)
      VALUES('Maternity Enhanced','Maternity Enhanced','Govt Enhanced Policy','Current TW-WDays','???',0.0,0.0);

   END IF;

END IF;