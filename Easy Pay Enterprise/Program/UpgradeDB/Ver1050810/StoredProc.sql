if exists(select 1 from sys.sysprocedure where proc_name = 'FGetPersonalContactExtension' and user_name(creator) = 'DBA') then
   drop function DBA.FGetPersonalContactExtension
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetLatestBasicRateByPeriod' and user_name(creator) = 'DBA') then
   drop function DBA.FGetLatestBasicRateByPeriod
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCareerProEffectiveDateDuringPeriod' and user_name(creator) = 'DBA') then
   drop function DBA.FGetCareerProEffectiveDateDuringPeriod
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetBREffectiveDateDuringPeriod' and user_name(creator) = 'DBA') then
   drop function DBA.FGetBREffectiveDateDuringPeriod
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetAllowanceUserDefInfo' and user_name(creator) = 'DBA') then
   drop function DBA.FGetAllowanceUserDefInfo
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDatabaseSetup' and user_name(creator) = 'DBA') then
   drop procedure DBA.ASQLDatabaseSetup
end if;

create procedure DBA.ASQLDatabaseSetup()
begin
  set option public.max_cursor_count = 0;
  set option public.max_statement_count = 0;
  /* Interface */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iCareerProgression') then
    create index Key_Index on iCareerProgression(CareerEmployeeID asc,CareerEffectiveDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iBasicRateProgression') then
    create index Key_Index on iBasicRateProgression(BREmployeeID asc,BRProgDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iLveSummary') then
    create index Key_Index on iLveSummary(LveEmployeeID asc,LeaveTypeId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iLeaveRecord') then
    create index Key_Index on iLeaveRecord(LveEmployeeID asc,LveID asc,LeaveDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iShiftRecord') then
    create index Key_Index on iShiftRecord(ShiftEmployeeID asc,ShiftID asc,ShiftDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iOTRecord') then
    create index Key_Index on iOTRecord(OTEmployeeID asc,OTID asc,OTDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iAllowanceRecord') then
    create index Key_Index on iAllowanceRecord(AllowanceEmployeeID asc,AllowanceID asc,AllowanceDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iResidenceStatusRecord') then
    create index Key_Index on iResidenceStatusRecord(ResIdentityNo asc,ResStatusEffectiveDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iFamily') then
    create index Key_Index on iFamily(FamilyIdentityNo asc,PersonName asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iPersonalAddress') then
    create index Key_Index on iPersonalAddress(PerAddIdentityNo asc,PerAddConLocId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iPersonalEmail') then
    create index Key_Index on iPersonalEmail(PerEmailIdentityNo asc,PerEmailConLocId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iPersonalContact') then
    create index Key_Index on iPersonalContact(PerConIdentityNo asc,PerContactConLocId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iEducationRec') then
    create index Key_Index on iEducationRec(EduIdentityNo asc,EducationId asc,EduInstitution asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iEduMajor') then
    create index Key_Index on iEduMajor(EduIdentityNo asc,EducationId asc,EduInstitution asc,FieldMajorId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iMemship') then
    create index Key_Index on iMemship(MemIdentityNo asc,MemId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iSkillLevel') then
    create index Key_Index on iSkillLevel(SkillIdentityNo asc,SkillEffectiveDate asc,SkillCode asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iMediHistory') then
    create index Key_Index on iMediHistory(MediHxIdentityNo asc,IllnessId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iAwardDisc') then
    create index Key_Index on iAwardDisc(AwardDiscIdentityNo asc,AwardDiscDate asc,AwardDiscCode asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iJobHistory') then
    create index Key_Index on iJobHistory(JobHisIdentityNo asc,EmployedDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iJobHisRespon') then
    create index Key_Index on iJobHisRespon(JobHisIdentityNo asc,EmployedDate asc,ResponsibilityId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'iApplicant') then
    create index Key_Index on iApplicant(ApplicantIdentityNo asc,AppDateSubmitted asc,RecruitCode asc)
  end if;
  /* Core */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'Personal') then
    create index Key_Index on Personal(IdentityNo asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'Employee') then
    create index Key_Index on Employee(EmployeeId asc)
  end if;
  /* Pay */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'PayRecord') then
    create index Key_Index on PayRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSI' and T.table_name = 'PayRecord') then
    create index General_Index_YPSI on PayRecord(PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPS' and T.table_name = 'PayRecord') then
    create index General_Index_YPS on PayRecord(PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYPS' and T.table_name = 'PayRecord') then
    create index General_Index_EYPS on PayRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'DetailRecord') then
    create index Key_Index on DetailRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSI' and T.table_name = 'DetailRecord') then
    create index General_Index_YPSI on DetailRecord(PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPS' and T.table_name = 'DetailRecord') then
    create index General_Index_YPS on DetailRecord(PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYPS' and T.table_name = 'DetailRecord') then
    create index General_Index_EYPS on DetailRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'PolicyRecord') then
    create index Key_Index on PolicyRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSI' and T.table_name = 'PolicyRecord') then
    create index General_Index_YPSI on PolicyRecord(PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPS' and T.table_name = 'PolicyRecord') then
    create index General_Index_YPS on PolicyRecord(PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYPS' and T.table_name = 'PolicyRecord') then
    create index General_Index_EYPS on PolicyRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'BankRecord') then
    create index Key_Index on BankRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSI' and T.table_name = 'BankRecord') then
    create index General_Index_YPSI on BankRecord(PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPS' and T.table_name = 'BankRecord') then
    create index General_Index_YPS on BankRecord(PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYPS' and T.table_name = 'BankRecord') then
    create index General_Index_EYPS on BankRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'ShiftRecord') then
    create index Key_Index on ShiftRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc,ShiftFormulaId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYPSI' and T.table_name = 'ShiftRecord') then
    create index General_Index_EYPSI on ShiftRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSI' and T.table_name = 'ShiftRecord') then
    create index General_Index_YPSI on ShiftRecord(PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSIF' and T.table_name = 'ShiftRecord') then
    create index General_Index_YPSIF on ShiftRecord(PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc,ShiftFormulaId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYPS' and T.table_name = 'ShiftRecord') then
    create index General_Index_EYPS on ShiftRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'OTRecord') then
    create index Key_Index on OTRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc,OTFormulaId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYPSI' and T.table_name = 'OTRecord') then
    create index General_Index_EYPSI on OTRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSI' and T.table_name = 'OTRecord') then
    create index General_Index_YPSI on OTRecord(PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSIF' and T.table_name = 'OTRecord') then
    create index General_Index_YPSIF on OTRecord(PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc,OTFormulaId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYPS' and T.table_name = 'OTRecord') then
    create index General_Index_EYPS on OTRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'AllowanceRecord') then
    create index Key_Index on AllowanceRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc,AllowanceFormulaId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYPSI' and T.table_name = 'AllowanceRecord') then
    create index General_Index_EYPSI on AllowanceRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSI' and T.table_name = 'AllowanceRecord') then
    create index General_Index_YPSI on AllowanceRecord(PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSIF' and T.table_name = 'AllowanceRecord') then
    create index General_Index_YPSIF on AllowanceRecord(PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,PayRecId asc,AllowanceFormulaId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYPS' and T.table_name = 'AllowanceRecord') then
    create index General_Index_EYPS on AllowanceRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'AllowanceRecur_Index' and T.table_name = 'AllowanceRecord') then
    create index AllowanceRecur_Index on AllowanceRecord(AllowanceRecurSysId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'SubPeriodRecord') then
    create index Key_Index on SubPeriodRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPS' and T.table_name = 'SubPeriodRecord') then
    create index General_Index_YPS on SubPeriodRecord(PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'SubPeriodSetting') then
    create index Key_Index on SubPeriodSetting(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'LeaveInfoRecord') then
    create index Key_Index on LeaveInfoRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,LeaveTypeFunctCode asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSL' and T.table_name = 'LeaveInfoRecord') then
    create index General_Index_YPSL on LeaveInfoRecord(PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,LeaveTypeFunctCode asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYPL' and T.table_name = 'LeaveInfoRecord') then
    create index General_Index_EYPL on LeaveInfoRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,LeaveTypeFunctCode asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'LeaveDeductionRecord') then
    create index Key_Index on LeaveDeductionRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,LeaveTypeFunctCode asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YPSL' and T.table_name = 'LeaveDeductionRecord') then
    create index General_Index_YPSL on LeaveDeductionRecord(PayRecYear asc,PayRecPeriod asc,PayRecSubPeriod asc,LeaveTypeFunctCode asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYPL' and T.table_name = 'LeaveDeductionRecord') then
    create index General_Index_EYPL on LeaveDeductionRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc,LeaveTypeFunctCode asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'PayPeriodRecord') then
    create index Key_Index on PayPeriodRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YP' and T.table_name = 'PayPeriodRecord') then
    create index General_Index_YP on PayPeriodRecord(PayRecYear asc,PayRecPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYP' and T.table_name = 'PayPeriodRecord') then
    create index General_Index_EYP on PayPeriodRecord(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'PeriodPolicySummary') then
    create index Key_Index on PeriodPolicySummary(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_YP' and T.table_name = 'PeriodPolicySummary') then
    create index General_Index_YP on PeriodPolicySummary(PayRecYear asc,PayRecPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_EYP' and T.table_name = 'PeriodPolicySummary') then
    create index General_Index_EYP on PeriodPolicySummary(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'FormulaCategory_Index' and T.table_name = 'Formula') then
    create index FormulaCategory_Index on Formula(FormulaCategory asc)
  end if;
  /* Leave */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'LeaveApplication_Index' and T.table_name = 'LeaveApplication') then
    create index LeaveApplication_Index on LeaveApplication(EmployeeSysId asc,LeaveTypeId asc,LveRecApproved asc,LveAppFromDate asc,LveAppToDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'LeaveRecord_Index' and T.table_name = 'LeaveRecord') then
    create index LeaveRecord_Index on LeaveRecord(LveRecDate asc,LveRecStartTime asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'LveAllocationRecString_Index' and T.table_name = 'LveAllocationRec') then
    create index LveAllocationRecString_Index on LveAllocationRec(LveAllocationId asc,LveAllocStringMatch asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'LveAllocationRecRange_Index' and T.table_name = 'LveAllocationRec') then
    create index LveAllocationRecRange_Index on LveAllocationRec(LveAllocationId asc,LveAllocRangeFrom asc,LveAllocRangeTo asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'LeavePolicyRecordString_Index' and T.table_name = 'LeavePolicyRecord') then
    create index LeavePolicyRecordString_Index on LeavePolicyRecord(LeavePolicyId asc,PolicyStringMatch asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'LeavePolicyRecordRange_Index' and T.table_name = 'LeavePolicyRecord') then
    create index LeavePolicyRecordRange_Index on LeavePolicyRecord(LeavePolicyId asc,PolicyRangeFrom asc,PolicyRangeTo asc)
  end if;
  /* HR Medical Claim */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'MedClaimSubmission_Index' and T.table_name = 'MedClaim') then
    create index MedClaimSubmission_Index on MedClaim(PersonalSysId asc,SubmissionDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'MedClaimReceipt_Index' and T.table_name = 'MedClaim') then
    create index MedClaimReceipt_Index on MedClaim(PersonalSysId asc,MedReceiptDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'MedClaimPayroll_Index' and T.table_name = 'MedClaim') then
    create index MedClaimPayroll_Index on MedClaim(PersonalSysId asc,PayrollDate asc)
  end if;
  /* HR Appraisal */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Appraisal_Index_Date' and T.table_name = 'Appraisal') then
    create index Appraisal_Index_Date on Appraisal(AppraisalDate asc)
  end if;
  /* HR Training */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'CourseSchedule_Index_Date' and T.table_name = 'CourseSchedule') then
    create index CourseSchedule_Index_Date on CourseSchedule(CourseStartDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Training_Index_Status' and T.table_name = 'Training') then
    create index Training_Index_Status on Training(ePortalStatus asc)
  end if;
  /* HR Bond */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Bond_Index_Date' and T.table_name = 'Bond') then
    create index Bond_Index_Date on Bond(EffectiveDate asc)
  end if;
  /* HR Membership */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Memship_Index' and T.table_name = 'Memship') then
    create index Memship_Index on Memship(PersonalSysId asc,MemExpiryDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Memship_Index_Date' and T.table_name = 'Memship') then
    create index Memship_Index_Date on Memship(MemExpiryDate asc)
  end if;
  /* HR Competency */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Competency_Index_POS' and T.table_name = 'Competency') then
    create index Competency_Index_POS on Competency(PositionId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Competency_Index' and T.table_name = 'Competency') then
    create index Competency_Index on Competency(PositionId asc,CompetencyDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Competency_Index_Empee' and T.table_name = 'Competency') then
    create index Competency_Index_Empee on Competency(EmployeeSysId asc,CompetencyDate asc)
  end if;
  /* HR Test */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'HRTest_Index' and T.table_name = 'HRTest') then
    create index HRTest_Index on HRTest(PersonalSysId asc)
  end if;
  /* HR Item Issued */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'ItemAssignItem_Index' and T.table_name = 'ItemAssignItem') then
    create index ItemAssignItem_Index on ItemAssignItem(PersonalSysId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'ItemAssignItem_Index_ExpDate' and T.table_name = 'ItemAssignItem') then
    create index ItemAssignItem_Index_ExpDate on ItemAssignItem(PersonalSysId asc,ExpiryDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'ItemAssignItem_Index_EffDate' and T.table_name = 'ItemAssignItem') then
    create index ItemAssignItem_Index_EffDate on ItemAssignItem(PersonalSysId asc,EffectiveDate asc)
  end if;
  /* HR Family */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Family_Index' and T.table_name = 'Family') then
    create index Family_Index on Family(PersonalSysId asc)
  end if;
  /* HR Medical Examination */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'MedExRec_Index_RecDate' and T.table_name = 'MedExRec') then
    create index MedExRec_Index_RecDate on MedExRec(PersonalSysId asc,ReceiptDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'MedExRec_Index_RevDate' and T.table_name = 'MedExRec') then
    create index MedExRec_Index_RevDate on MedExRec(PersonalSysId asc,ReviewDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'MedExRec_Index_FolDate' and T.table_name = 'MedExRec') then
    create index MedExRec_Index_FolDate on MedExRec(PersonalSysId asc,FollowUpDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'MedExRec_Index' and T.table_name = 'MedExRec') then
    create index MedExRec_Index on MedExRec(PersonalSysId asc,ReceiptDate asc,ReviewDate asc,FollowUpDate asc)
  end if;
  /* HR Recruitment */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Applicant_Index' and T.table_name = 'Applicant') then
    create index Applicant_Index on Applicant(PersonalSysId asc,RecruitCode asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Applicant_Index_SubDate' and T.table_name = 'Applicant') then
    create index Applicant_Index_SubDate on Applicant(PersonalSysId asc,AppDateSubmitted asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Applicant_Index_AvailDate' and T.table_name = 'Applicant') then
    create index Applicant_Index_AvailDate on Applicant(PersonalSysId asc,AppAvailability asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'IntSch_Index_Date' and T.table_name = 'InterviewSchedule') then
    create index IntSch_Index_Date on InterviewSchedule(InterviewDate asc)
  end if;
  /* HR Eduaction */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'EducationRec_Index' and T.table_name = 'EducationRec') then
    create index EducationRec_Index on EducationRec(PersonalSysId asc,EducationId asc)
  end if;
  /* Costing */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'CostPeriod') then
    create index Key_Index on CostPeriod(CostYear asc,CostPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'Key_Index' and T.table_name = 'CostRecord') then
    create index Key_Index on CostRecord(GLCode asc,CostItemId asc,CostItemType asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index' and T.table_name = 'CostRecord') then
    create index General_Index on CostRecord(CostPeriodSysId asc,CostSubPeriod asc,CostCentreId asc,GLCode asc,CostComponentId asc,CostItemId asc,CostItemType asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'General_Index_PS' and T.table_name = 'CostRecord') then
    create index General_Index_PS on CostRecord(CostPeriodSysId asc,CostSubPeriod asc)
  end if;
  /* Analysis Report */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'AnlysRec_Index' and T.table_name = 'AnlysItemRecord') then
    create index AnlysRec_Index on AnlysItemRecord(AnlysProjectId asc,AnlysIPAddress asc,Basis1Id asc,Basis2Id asc,Basis3Id asc,AnlysItem1Id asc,AnlysItem2Id asc,AnlysItem3Id asc,AnlysItem4Id asc,AnlysItem5Id asc,AnlysItemRecYear asc,AnlysItemRecPeriodMonth asc,AnlysItemRecSubPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'AnlysRec_Index1' and T.table_name = 'AnlysItemRecord') then
    create index AnlysRec_Index1 on AnlysItemRecord(AnlysProjectId asc,AnlysIPAddress asc,Basis1Id asc,Basis2Id asc,Basis3Id asc,AnlysItem1Id asc,AnlysItem2Id asc,AnlysItem3Id asc,AnlysItem4Id asc,AnlysItem5Id asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'AnlysRec_Index2' and T.table_name = 'AnlysItemRecord') then
    create index AnlysRec_Index2 on AnlysItemRecord(AnlysProjectId asc,AnlysIPAddress asc,Basis1Id asc,Basis2Id asc,Basis3Id asc)
  end if;
  /* AuditTrailTable */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'AuditTrailKey_Index1' and T.table_name = 'AuditTrailTable') then
    create index AuditTrailKey_Index1 on AuditTrailTable(AuditUserID asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'AuditTrailKey_Index2' and T.table_name = 'AuditTrailTable') then
    create index AuditTrailKey_Index2 on AuditTrailTable(AuditTimeStamp asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'AuditTrailKey_Index3' and T.table_name = 'AuditTrailTable') then
    create index AuditTrailKey_Index3 on AuditTrailTable(AuditEventType asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'AuditTrailKey_Index4' and T.table_name = 'AuditTrailTable') then
    create index AuditTrailKey_Index4 on AuditTrailTable(AuditTableName asc)
  end if;
  /* Time Sheet */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'TimeSheet_Index' and T.table_name = 'TimeSheet') then
    create index TimeSheet_Index on TimeSheet(EmployeeSysId asc,TMSYear asc,TMSPeriod asc,TMSSubPeriod asc,TMSPayRecId asc,JobCode asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'TimeSheet_Index1' and T.table_name = 'TimeSheet') then
    create index TimeSheet_Index1 on TimeSheet(EmployeeSysId asc,TMSDate asc,TMSPayRecId asc,JobCode asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'TimeSheet_Index2' and T.table_name = 'TimeSheet') then
    create index TimeSheet_Index2 on TimeSheet(EmployeeSysId asc,TMSYear asc,TMSPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'TimeSheet_Index3' and T.table_name = 'TimeSheet') then
    create index TimeSheet_Index3 on TimeSheet(EmployeeSysId asc,TMSYear asc,TMSPeriod asc,TMSSubPeriod asc,TMSPayRecId asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'TimeSheet_Index4' and T.table_name = 'TimeSheet') then
    create index TimeSheet_Index4 on TimeSheet(EmployeeSysId asc,TMSYear asc,TMSPeriod asc,TMSSubPeriod asc,TMSPayRecId asc,TMSType asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'TimeSheet_Index5' and T.table_name = 'TimeSheet') then
    create index TimeSheet_Index5 on TimeSheet(EmployeeSysId asc,TMSPayRecId asc,TMSType asc,TMSDate asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'TimeSheet_Index6' and T.table_name = 'TimeSheet') then
    create index TimeSheet_Index6 on TimeSheet(TMSYear asc,TMSPeriod asc,JobCode asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'TimeSheet_Index7' and T.table_name = 'TimeSheet') then
    create index TimeSheet_Index7 on TimeSheet(TMSYear asc,TMSPeriod asc,TMSPayRecId asc,JobCode asc)
  end if;
  /* Hong Kong Ordinance */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'HKPeriodOrdinance_Index1' and T.table_name = 'HKPeriodOrdinance') then
    create index HKPeriodOrdinance_Index1 on HKPeriodOrdinance(EmployeeSysId asc,PayRecYear asc,PayRecPeriod asc)
  end if;
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'HKPeriodOrdinance_Index2' and T.table_name = 'HKPeriodOrdinance') then
    create index HKPeriodOrdinance_Index2 on HKPeriodOrdinance(EmployeeSysId asc,OrdinCalYear asc,OrdinCalMth asc)
  end if;
  /* Philippines Certification Setup */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'EmpCertification_Index1' and T.table_name = 'EmpCertification') then
    create index EmpCertification_Index1 on EmpCertification(EmployeeSysId asc,CertificationType asc,Year asc,Month asc)
  end if;
  /* Report Export */
  if not exists(select 1 from sys.sysindex as I join sys.systable as T where
      I.index_name = 'RptGridSettings_Index1' and T.table_name = 'RptGridSettings') then
    create index RptGridSettings_Index1 on RptGridSettings(RptGridModule asc,RptGridCreatedBy asc)
  end if  
end;


create function DBA.FGetAllowanceUserDefInfo(
in In_AllowanceSGSPGenId char(30),
in In_AllowanceCategory char(20))
RETURNS CHAR(255)
BEGIN
    DECLARE Out_UserDefInfo CHAR(255);
    DECLARE In_AllowanceFormulaId CHAR(20);
    DECLARE In_UserDef1 CHAR(20);
    DECLARE In_UserDef2 CHAR(20);
    DECLARE In_UserDef3 CHAR(20);
    DECLARE In_UserDef4 CHAR(20);
    DECLARE In_UserDef5 CHAR(20);
    DECLARE In_UserDef1Value CHAR(20);
    DECLARE In_UserDef2Value CHAR(20);
    DECLARE In_UserDef3Value CHAR(20);
    DECLARE In_UserDef4Value CHAR(20);
    DECLARE In_UserDef5Value CHAR(20);

    IF EXISTS(SELECT * FROM AllowanceHistoryRecord WHERE AllowanceSGSPGenId = In_AllowanceSGSPGenId) THEN
        SELECT AllowanceFormulaId INTO In_AllowanceFormulaId FROM AllowanceRecord WHERE AllowanceSGSPGenId = In_AllowanceSGSPGenId;
        IF EXISTS(SELECT * FROM Formula WHERE FormulaId = In_AllowanceFormulaId AND FormulaCategory = 'PayElement' AND 
                  FormulaSubCategory = In_AllowanceCategory AND FormulaType = 'Formula') THEN
            SELECT UserDef1, UserDef2, UserDef3, UserDef4, UserDef5, CAST(UserDef1Value AS CHAR), CAST(UserDef2Value AS CHAR), 
            CAST(UserDef3Value AS CHAR), CAST(UserDef4Value AS CHAR), CAST(UserDef5Value AS CHAR) INTO In_UserDef1, In_UserDef2, 
            In_UserDef3, In_UserDef4, In_UserDef5, In_UserDef1Value, In_UserDef2Value, In_UserDef3Value, In_UserDef4Value, In_UserDef5Value 
            FROM AllowanceHistoryRecord WHERE AllowanceSGSPGenId = In_AllowanceSGSPGenId;

            IF In_UserDef1 <> '' THEN
                SET Out_UserDefInfo = In_UserDef1 || ' = ' || In_UserDef1Value;
            END IF;

            IF In_UserDef2 <> '' THEN
                IF Out_UserDefInfo <> '' THEN
                    SET Out_UserDefInfo = Out_UserDefInfo || ' ' || In_UserDef2 || ' = ' || In_UserDef2Value;
                ELSE
                    SET Out_UserDefInfo = In_UserDef2 || ' = ' || In_UserDef2Value;
                END IF;
            END IF;

            IF In_UserDef3 <> '' THEN
                IF Out_UserDefInfo <> '' THEN
                    SET Out_UserDefInfo = Out_UserDefInfo || ' ' || In_UserDef3 || ' = ' || In_UserDef3Value;
                ELSE
                    SET Out_UserDefInfo = In_UserDef3 || ' = ' || In_UserDef3Value;
                END IF;
            END IF;
            
            IF In_UserDef4 <> '' THEN
                IF Out_UserDefInfo <> '' THEN
                    SET Out_UserDefInfo = Out_UserDefInfo || ' ' || In_UserDef4 || ' = ' || In_UserDef4Value;
                ELSE
                    SET Out_UserDefInfo = In_UserDef4 || ' = ' || In_UserDef4Value;
                END IF;
            END IF;

            IF In_UserDef5 <> '' THEN
                IF Out_UserDefInfo <> '' THEN
                    SET Out_UserDefInfo = Out_UserDefInfo || ' ' || In_UserDef5 || ' = ' || In_UserDef5Value;
                ELSE
                    SET Out_UserDefInfo = In_UserDef5 || ' = ' || In_UserDef5Value;
                END IF;
            END IF;
        ELSE
            SET Out_UserDefInfo = ''
        END IF
    ELSE
        SET Out_UserDefInfo = ''
    END IF;
    
	RETURN Out_UserDefInfo;
END;


CREATE FUNCTION DBA.FGetBREffectiveDateDuringPeriod(
in in_EmployeeSysId integer,
in in_EffDateFrom date,
in in_EffDateTo date,
in in_ProLetter integer)/*0 for Increment Letter; 1 for Letter of Promotion in Report Design */
RETURNS date
BEGIN
	DECLARE out_EffectiveDate date; 
    if (in_ProLetter = 0) then
	  select first BRProgEffectiveDate into out_EffectiveDate  from BasicRateProgression 
      where employeesysid = in_EmployeeSysId And (BRProgEffectiveDate between in_EffDateFrom and in_EffDateTo) And BRProgressionCode = 'Increment'    
      order by BRProgEffectiveDate desc;
    elseif (in_ProLetter = 1) then
      select first BRProgEffectiveDate into out_EffectiveDate  from BasicRateProgression 
      where employeesysid = in_EmployeeSysId And BRProgEffectiveDate <= in_EffDateTo And BRProgressionCode = 'Increment'
      order by BRProgEffectiveDate desc;
    end if;
	RETURN out_EffectiveDate;
END;


CREATE FUNCTION DBA.FGetCareerProEffectiveDateDuringPeriod( 
in in_EmployeeSysId integer,
in in_EffDateFrom date,
in in_EffDateTo date)
RETURNS date
BEGIN
	DECLARE out_EffectiveDate date; 
	select first CareerEffectiveDate into out_EffectiveDate  from CareerProgression 
    where employeesysid = in_EmployeeSysId And (CareerEffectiveDate between in_EffDateFrom and in_EffDateTo)
    order by CareerEffectiveDate desc ;
	RETURN out_EffectiveDate;
END;


CREATE FUNCTION DBA.FGetLatestBasicRateByPeriod( 
in in_EmployeeSysId integer,
in in_effDateTo date)
RETURNS double

BEGIN
	DECLARE out_basicRate double;
	Select First BRProgNewBasicRate into out_basicRate from basicrateprogression 
    where Employeesysid = in_EmployeeSysId And BRProgEffectiveDate <= in_effDateTo And BRProgressionCode = 'Increment'
    Order by BRProgEffectiveDate desc ;
	RETURN out_basicRate;
END;


create function DBA.FGetPersonalContactExtension(
in In_PersonalSysId integer,
in In_ContactLocationId char(20))
returns char(10)
begin
  declare Out_ContactExtension char(10);
  if exists(select* from PersonalContact where ContactLocationId = In_ContactLocationId) then
    select first Extension into Out_ContactExtension from PersonalContact where
      PersonalSysId = In_PersonalSysId and ContactLocationId = In_ContactLocationId order by
      PersonalContactId asc
  else
    set Out_ContactExtension=''
  end if;
  return Out_ContactExtension
end;

