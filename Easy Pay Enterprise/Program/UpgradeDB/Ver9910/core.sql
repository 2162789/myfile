create procedure dba.ASQLCalendarDayUpdateLvePatternWeek(
in In_UpdateStartDate date,
in In_WeekLeavePatternCode char(20))
begin
  declare N84_NewLeavePattern numeric(8,4);
  declare Char_DateType char(20);
  CalendarDateLoop: for CalendarDateFor as Cur_CalendarDate dynamic scroll cursor for
    select CalendarDay.CalendarDate as Change_LeavePatternDate from
      CalendarDay where
      CalendarDay.WeekLeavePatternCode = In_WeekLeavePatternCode and
      CalendarDay.CalendarDate >= In_UpdateStartDate do
    select CalendarDay.DateType into Char_DateType
      from CalendarDay where
      CalendarDay.CalendarDate = Change_LeavePatternDate and
      CalendarDay.WeekLeavePatternCode = In_WeekLeavePatternCode;
    set N84_NewLeavePattern=FGetNewLeavePattern(Char_DateType,In_WeekLeavePatternCode);
    update CalendarDay set
      CalendarDay.WkCalenDayLvePattern = N84_NewLeavePattern where
      CalendarDay.CalendarDate = Change_LeavePatternDate and
      CalendarDay.WeekLeavePatternCode = In_WeekLeavePatternCode;
    commit work end for
end
;

create procedure dba.ASQLCalendarDayUpdatePHolidayWeek(
in In_HolidayId char(20),
in In_PublicHolidayDate date,
in In_CountryCode char(20))
begin
  declare Get_HolidayLvePattern double;
  declare Get_HolidayPayPattern double;
  declare Get_HolidayWorkPattern double;
  select HolidayLvePattern,HolidayPayPattern,HolidayWorkPattern into Get_HolidayLvePattern,
    Get_HolidayPayPattern,
    Get_HolidayWorkPattern from Holidays where
    HolidayId = In_HolidayId and
    CountryId = In_CountryCode and
    HolidayStartDate = In_PublicHolidayDate;
  CalendarIdLoop: for CalendarIdFor as Cur_CalendarId dynamic scroll cursor for
    select Calendar.CalendarId as Get_CalendarId from
      Calendar where
      Calendar.CountryCode = In_CountryCode do
    update CalendarDay set
      CalendarDay.PublicHoliday = 1,
      CalendarDay.WkCalenDayLvePattern = Get_HolidayLvePattern,
      CalendarDay.WkCalenDayPayPattern = Get_HolidayPayPattern,
      CalendarDay.WkCalenDayWkPattern = Get_HolidayWorkPattern where
      CalendarDay.CalendarDate = In_PublicHolidayDate and
      CalendarDay.CalendarIdCode = Get_CalendarId;
    commit work end for
end
;

create procedure dba.ASQLChgKeyCareerProgression(
in In_EmployeeSysId integer,
in In_HireDate date,
in Old_HireDate date)
begin
  declare Out_CareerRemarks char(100);
  declare Out_CareerAttachmentID char(100);
  declare Out_CareerCareerId char(20);
  declare Out_CareerCurrent integer;
  declare Out_CareerAttachment long binary;
  if(In_HireDate = Old_HireDate) then return
  end if;
  select CareerRemarks,
    CareerAttachmentID,
    CareerAttachment,
    CareerCareerId,
    CareerCurrent into Out_CareerRemarks,
    Out_CareerAttachmentID,
    Out_CareerAttachment,
    Out_CareerCareerId,
    Out_CareerCurrent from CareerProgression where
    CareerProgression.EmployeeSysId = In_EmployeeSysId and
    CareerProgression.CareerEffectiveDate = Old_HireDate;
  if not exists(select* from CareerProgression where
      CareerProgression.EmployeeSysId = In_EmployeeSysId and
      CareerProgression.CareerEffectiveDate = In_HireDate) then
    insert into CareerProgression(EmployeeSysId,
      CareerEffectiveDate,
      CareerRemarks,
      CareerAttachmentID,
      CareerAttachment,
      CareerCareerId,
      CareerCurrent) values(
      In_EmployeeSysId,
      In_HireDate,
      Out_CareerRemarks,
      Out_CareerAttachmentID,
      Out_CareerAttachment,
      Out_CareerCareerId,
      Out_CareerCurrent);
    update CareerAttribute set
      CareerAttribute.CareerEffectiveDate = In_HireDate where
      CareerAttribute.EmployeeSysId = In_EmployeeSysId and
      CareerAttribute.CareerEffectiveDate = Old_HireDate;
    delete from CareerProgression where
      CareerProgression.EmployeeSysId = In_EmployeeSysId and
      CareerProgression.CareerEffectiveDate = Old_HireDate
  end if;
  commit work
end
;

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
  end if
end
;

create procedure DBA.ASQLDeleteAllPersonal()
begin
  while(exists(select* from Personal) or exists(select* from Employee)) loop
    PersonalRecLoop: for PersonalRecFor as PersonalCur dynamic scroll cursor for
      select PersonalSysId as In_PersonalSysId from Personal do
      EmployeeRecLoop: for EmployeeRecFor as EmpeeCur dynamic scroll cursor for
        select EmployeeSysId as In_EmployeeSysId from Employee where PersonalSysId = In_PersonalSysId do
        call ASQLDeleteEmployment(In_EmployeeSysId) end for;
      call DeletePersonalRecord(In_PersonalSysId) end for
  end loop
end
;

create procedure dba.ASQLGenNewCalendarYear(
in In_CalendarId char(20),
in In_CalendarYear integer)
begin
  declare Count_GroupWorkPattern integer;
  declare Count_GroupLeavePattern integer;
  declare Int_NewFollowingYearDays integer;
  declare @DaysCounter integer;
  declare Date_ActualDate date;
  declare Flag_PublicHoliday smallint;
  declare Int_WeekNo integer;
  declare N84_WorkPattern numeric(8,4);
  declare N84_LeavePattern numeric(8,4);
  declare Char_CountryCode char(20);
  declare Char_WeekWorkPattern char(20);
  declare Char_WeekLeavePattern char(20);
  select Calendar.CountryCode into Char_CountryCode
    from Calendar where
    Calendar.CalendarId = In_CalendarId;
  select COUNT(GroupWorkPattern.CalendarId) into Count_GroupWorkPattern
    from GroupWorkPattern where
    GroupWorkPattern.CalendarId = In_CalendarId;
  select COUNT(GroupLeavePattern.CalendarId) into Count_GroupLeavePattern
    from GroupLeavePattern where
    GroupLeavePattern.CalendarId = In_CalendarId;
  set Int_NewFollowingYearDays=DATEDIFF(day,YMD(In_CalendarYear-1,12,31),YMD(In_CalendarYear,12,31));
  set @DaysCounter=0;
  set Int_WeekNo=0;
  GenNewFollowingYearDaysLoop:
  while @DaysCounter < Int_NewFollowingYearDays loop
    set @DaysCounter=@DaysCounter+1;
    set Date_ActualDate=DATEADD(Day,@DaysCounter,YMD(In_CalendarYear-1,12,31));
    set Int_WeekNo=WEEKS(Date_ActualDate)-(WEEKS(YMD(In_CalendarYear,1,1))-1);
    if exists(select* from Holidays where
        Holidays.CountryId = Char_CountryCode and
        (Holidays.HolidayStartDate >= Date_ActualDate and
        Holidays.HolidayEndDate <= Date_ActualDate)) then
      set Flag_PublicHoliday=1;

      select first HolidayWorkPattern,HolidayLvePattern into N84_WorkPattern,
        N84_LeavePattern from Holidays where
        Holidays.CountryId = Char_CountryCode and
        Holidays.HolidayStartDate = Date_ActualDate Order by HolidayId;

      set Char_WeekWorkPattern='';
      set Char_WeekLeavePattern=''
    else
      set Flag_PublicHoliday=0;
      set Char_WeekWorkPattern=FGetWeekWorkPattern(In_CalendarId,
        Int_WeekNo,Count_GroupWorkPattern);
      set Char_WeekLeavePattern=FGetWeekLeavePattern(In_CalendarId,
        Int_WeekNo,Count_GroupLeavePattern);
      set N84_WorkPattern=FGetWorkPattern(In_CalendarId,Date_ActualDate,
        Int_WeekNo,Count_GroupWorkPattern);
      set N84_LeavePattern=FGetLeavePattern(In_CalendarId,Date_ActualDate,
        Int_WeekNo,Count_GroupLeavePattern)
    end if;
    insert into CalendarDay(CalendarDate,
      CalendarIdCode,DateType,
      PublicHoliday,WeekNo,
      WkCalenDayWkPattern,WkCalenDayLvePattern,
      WeekWorkPatternCode,WeekLeavePatternCode) values(
      Date_ActualDate,
      In_CalendarId,DAYNAME(Date_ActualDate),
      Flag_PublicHoliday,Int_WeekNo,
      N84_WorkPattern,N84_LeavePattern,
      Char_WeekWorkPattern,Char_WeekLeavePattern)
  end loop GenNewFollowingYearDaysLoop;
  commit work
end
;

create procedure dba.ASQLGrpLvePatternUpdateCalenDay(
in In_NewWeekLeavePatternId char(20),
in In_OldWeekLeavePatternId char(20),
in In_StartDate date)
begin
  declare N84_NewLeavePattern numeric(8,4);
  CalendarDayLoop: for CalendarDayForLoop as Cur_CalendarDay dynamic scroll cursor for
    select CalendarDay.CalendarDate as Change_CalendarDate,
      CalendarDay.DateType as Change_DateType from
      CalendarDay where
      CalendarDay.WeekLeavePatternCode = In_OldWeekLeavePatternId and
      CalendarDay.CalendarDate >= In_StartDate do
    set N84_NewLeavePattern=FGetNewLeavePattern(Change_DateType,In_NewWeekLeavePatternId);
    update CalendarDay set
      CalendarDay.WeekLeavePatternCode = In_NewWeekLeavePatternId,
      CalendarDay.WkCalenDayLvePattern = N84_NewLeavePattern where
      CalendarDay.CalendarDate = Change_CalendarDate;
    commit work end for
end
;

create procedure dba.ASQLGrpWkPatternUpdateCalenDay(
in In_NewWeekPatternId char(20),
in In_OldWeekPatternId char(20),
in In_StartDate date)
begin
  declare N84_NewWorkPattern numeric(8,4);
  CalendarDayLoop: for CalendarDayForLoop as Cur_CalendarDay dynamic scroll cursor for
    select CalendarDay.CalendarDate as Change_CalendarDate,
      CalendarDay.DateType as Change_DateType from
      CalendarDay where
      CalendarDay.WeekWorkPatternCode = In_OldWeekPatternId and
      CalendarDay.CalendarDate >= In_StartDate do
    set N84_NewWorkPattern=FGetNewWorkPattern(Change_DateType,In_NewWeekPatternId);
    update CalendarDay set
      CalendarDay.WeekWorkPatternCode = In_NewWeekPatternId,
      CalendarDay.WkCalenDayWkPattern = N84_NewWorkPattern where
      CalendarDay.CalendarDate = Change_CalendarDate;
    commit work end for
end
;

create procedure dba.ASQLMarkEContact(
in In_EmergencyContactId integer,
in In_PersonalSysId integer)
begin
  update EmergencyContact set
    EmergencyContact.EContactMain = 1 where
    EducationRecord.PersonalSysId = In_PersonalSysId and
    EmergencyContact.EmergencyContactId = In_EmergencyContactId;
  commit work
end
;

create procedure dba.ASQLMarkHighestEdu(
in In_EduRecId integer,
in In_PersonalSysId integer)
begin
  update EducationRecord set
    EducationRecord.EduHighest = 1 where
    EducationRecord.PersonalSysId = In_PersonalSysId and
    EducationRecord.EducationRecordId = In_EduRecId;
  commit work
end
;

create procedure dba.ASQLMarkLatestResStatus(
in In_ResStatusRecordId integer)
begin
  update ResidenceStatusRecord set
    ResidenceStatusRecord.LatestResidenceStatus = 0 where
    ResidenceStatusRecord.ResStatusRecordId = In_ResStatusRecordId
end
;

create procedure dba.ASQLMarkMailingAddress(
in In_PersonalSysId integer,
in In_PersonalAddressId integer)
begin
  update PersonalAddress set
    PersonalAddress.PersonalAddMailing = 1 where
    PersonalAddress.PersonalSysId = In_PersonalSysId and
    PersonalAddress.PersonalAddressId = In_PersonalAddressId;
  commit work
end
;

create procedure DBA.ASQLMoveEmployment(
in In_PersonalSysId integer,
in In_EmployeeSysId integer,
in In_OldPersonalSysId integer)
begin
  declare In_IdentityNo char(30);
  declare In_IdentityTypeCode char(20);
  declare In_MaritalStatusCode char(10);
  declare In_CountryOfBirth char(60);
  declare In_DateOfBirth date;
  declare In_PersonalName char(150);
  declare In_Gender char(1);
  declare In_Nationality char(60);
  declare In_ResidenceStatus char(20);
  declare In_EmployeeId char(30);
  select MaritalStatusCode,IdentityNo,IdentityTypeId,
    CountryOfBirth,DateOfBirth,PersonalName,Gender,
    Nationality into In_MaritalStatusCode,In_IdentityNo,In_IdentityTypeCode,
    In_CountryOfBirth,In_DateOfBirth,In_PersonalName,In_Gender,
    In_Nationality from Personal where PersonalSysId = In_PersonalSysId;
  select ResidenceTypeId into In_ResidenceStatus from ResidenceStatusRecord where
    ResStatusCurrent = 1 and PersonalSysId = In_PersonalSysId;
  update Employee set
    PersonalSysId = In_PersonalSysId,
    MaritalStatusCode = In_MaritalStatusCode,
    IdentityNo = In_IdentityNo,
    IdentityTypeCode = In_IdentityTypeCode,
    CountryOfBirth = In_CountryOfBirth,
    DateOfBirth = In_DateOfBirth,
    EmployeeName = In_PersonalName,
    Gender = In_Gender,
    Nationality = In_Nationality,
    ResidenceStatus = In_ResidenceStatus where
    EmployeeSysId = In_EmployeeSysId;
  select EmployeeId into In_EmployeeId from Employee where
    EmployeeSysId = In_EmployeeSysId;
  update Personal set
    EmployeeId = In_EmployeeId where
    PersonalSysId = In_PersonalSysId;
  if exists(select* from Employee where PersonalSysId = In_OldPersonalSysId) then
    select first EmployeeId into In_EmployeeId from Employee where
      PersonalSysId = In_OldPersonalSysId order by HireDate desc
  else
    set In_EmployeeId=''
  end if;
  update Personal set
    EmployeeId = In_EmployeeId where
    PersonalSysId = In_OldPersonalSysId;
  commit work
end
;

create procedure dba.ASQLProcessUpdateLabelName()
begin
  call ASQLUpdateCareerSubregistry();
  call ASQLUpdateImportFieldNameLabel();
  call ASQLUpdateInterfaceAttributeMappingLabel();
  call ASQLUpdateInterfaceCodeMappingLabel();
  call ASQLUpdateCostBasisSubregistry();
  call ASQLUpdateRPayElementBasisSubregistry();
  call ASQLUpdateItemBasisSubregistry();
  call ASQLUpdateOTBasisSubregistry();
  call ASQLUpdateShiftBasisSubregistry();
  call ASQLUpdateGovtProgBasisSubregistry();
  call ASQLUpdateMClaimBasisSubregistry();
  call ASQLUpdateLeaveBasisSubregistry();
  call ASQLUpdateHRBasisSubregistry();
  call ASQLUpdateEmployeeSystemAttribute();
  call ASQLUpdatePayBasisAnlysKeyword();
  call ASQLUpdateAccrualBasisKeyword();
  call ASQLUpdatePayKeyword();
  call ASQLUpdateCEBasisSubregistry();
  call ASQLUpdateLeaveKeyword();
  call ASQLUpdateInterCorpBasisSubregistry();
  call ASQLUpdateAuditTrialBasisSubregistry();
  call ASQLUpdateAnlysSystemAttribute();
  commit work
end
;

create procedure dba.ASQLRegisterMain(
in In_ProductName char(100),
in In_SubProductName char(100))
begin
  declare var_CompanyName char(100);
  select SubCompanyName into var_CompanyName from LicenseRecord where
    ProductName = In_ProductName and SubProductName = In_SubProductName;
  update Company set
    CompanyName = var_CompanyName where
    CompanyId = '001';
  commit work
end
;

create procedure dba.ASQLSetDefaultEContact(
in In_PersonalSysId integer)
begin
  update EmergencyContact set
    EmergencyContact.EContactMain = 0 where
    EmergencyContact.PersonalSysId = In_PersonalSysId;
  commit work
end
;

create procedure dba.ASQLSetDefaultHighestEdu(
in In_PersonalSysId integer)
begin
  update EducationRecord set
    EducationRecord.EduHighest = 0 where
    EducationRecord.PersonalSysId = In_PersonalSysId;
  commit work
end
;

create procedure dba.ASQLSetDefaultResStatus(
in In_PersonalSysId integer)
begin
  update ResidenceStatusRecord set
    ResidenceStatusRecord.LatestResidenceStatus = 0 where
    ResidenceStatusRecord.PersonalSysId = In_PersonalSysId;
  commit work
end
;

create procedure dba.ASQLSetPersonalAddressDefault(
in In_PersonalSysId integer)
begin
  update PersonalAddress set
    PersonalAddress.PersonalAddMailing = 0 where
    PersonalAddress.PersonalSysId = In_PersonalSysId;
  commit work
end
;

create procedure dba.ASQLSetUpCalendarDay(
in In_CalendarIdCode char(20))
begin
  declare CurrentYearDays integer;
  declare PreviousYearDays integer;
  declare FollowingYearDays integer;
  declare Total3YearsDay integer;
  declare DaysCounter integer;
  declare Flag_PublicHoliday smallint;
  declare Date_ActualDate date;
  declare Int_CurrentWeekNo integer;
  declare Int_PreviousWeekNo integer;
  declare Int_TotalCurrentWeekNo integer;
  declare Int_TotalPreviousWeekNo integer;
  declare Int_TotalFollowingWeekNo integer;
  declare Int_WeekNo integer;
  declare Char_CountryCode char(20);
  declare Count_GroupWorkPattern integer;
  declare Count_GroupLeavePattern integer;
  declare N84_WorkPattern numeric(8,4);
  declare Char_WeekWorkPattern char(20);
  declare N84_LeavePattern numeric(8,4);
  declare Char_WeekLeavePattern char(20);
  set PreviousYearDays=DateDiff(day,YMD(Years(Today(*))-2,12,31),YMD(Years(Today(*))-1,12,31));
  set CurrentYearDays=DateDiff(day,YMD(Years(Today(*))-1,12,31),YMD(Years(Today(*)),12,31));
  set Total3YearsDay=PreviousYearDays+CurrentYearDays;
  select Calendar.CountryCode into Char_CountryCode
    from Calendar where
    Calendar.CalendarId = In_CalendarIdCode;
  select COUNT(GroupWorkPattern.CalendarId) into Count_GroupWorkPattern
    from GroupWorkPattern where
    GroupWorkPattern.CalendarId = In_CalendarIdCode;
  select COUNT(GroupLeavePattern.CalendarId) into Count_GroupLeavePattern
    from GroupLeavePattern where
    GroupLeavePattern.CalendarId = In_CalendarIdCode;
  set Int_PreviousWeekNo=WEEKS(YMD(Years(Today(*))-2,12,31))-1;
  set DaysCounter=0;
  GenTotal3YearsDayLoop:
  while DaysCounter < Total3YearsDay loop
    set DaysCounter=DaysCounter+1;
    set Date_ActualDate=DATEADD(Day,DaysCounter,YMD(Years(Today(*))-2,12,31));
    if exists(select* from Holidays where
        Holidays.CountryId = Char_CountryCode and
        (Holidays.HolidayStartDate >= Date_ActualDate and
        Holidays.HolidayEndDate <= Date_ActualDate)) then
      set Flag_PublicHoliday=1
    else
      set Flag_PublicHoliday=0
    end if;
    set Int_CurrentWeekNo=WEEKS(Date_ActualDate);
    set Int_WeekNo=Int_CurrentWeekNo-Int_PreviousWeekNo;
    if(DaysCounter = PreviousYearDays) then
      set Int_PreviousWeekNo=Int_CurrentWeekNo-1;
      set Int_TotalPreviousWeekNo=Int_WeekNo
    else
      if(DaysCounter = (CurrentYearDays+PreviousYearDays)) then
        set Int_PreviousWeekNo=Int_CurrentWeekNo-1;
        set Int_TotalCurrentWeekNo=Int_WeekNo
      end if
    end if;
    if Flag_PublicHoliday = 0 then
      set N84_WorkPattern=FGetWorkPattern(In_CalendarIdCode,Date_ActualDate,
        Int_WeekNo,Count_GroupWorkPattern);
      set Char_WeekWorkPattern=FGetWeekWorkPattern(In_CalendarIdCode,
        Int_WeekNo,Count_GroupWorkPattern);
      set N84_LeavePattern=FGetLeavePattern(In_CalendarIdCode,Date_ActualDate,
        Int_WeekNo,Count_GroupLeavePattern);
      set Char_WeekLeavePattern=FGetWeekLeavePattern(In_CalendarIdCode,
        Int_WeekNo,Count_GroupLeavePattern)
    else
      select first HolidayWorkPattern,HolidayLvePattern into N84_WorkPattern,
        N84_LeavePattern from Holidays where
        Holidays.CountryId = Char_CountryCode and
        Holidays.HolidayStartDate = Date_ActualDate order by HolidayId;
      set Char_WeekWorkPattern='';
      set Char_WeekLeavePattern=''
    end if;
    insert into CalendarDay(CalendarDate,
      CalendarIdCode,DateType,
      PublicHoliday,WeekNo,
      WkCalenDayWkPattern,WkCalenDayLvePattern,
      WeekWorkPatternCode,WeekLeavePatternCode) values(
      Date_ActualDate,In_CalendarIdCode,
      DAYNAME(Date_ActualDate),Flag_PublicHoliday,
      Int_WeekNo,N84_WorkPattern,N84_LeavePattern,
      Char_WeekWorkPattern,Char_WeekLeavePattern)
  end loop GenTotal3YearsDayLoop;
  set Int_TotalFollowingWeekNo=Int_WeekNo;
  commit work
end
;

create procedure dba.ASQLUpdateCareerSubregistry()
begin
  declare EmpCode1_Id char(20);
  declare EmpCode2_Id char(20);
  declare EmpCode3_Id char(20);
  declare EmpCode4_Id char(20);
  declare EmpCode5_Id char(20);
  declare EmpLocation1_Id char(20);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  select NewLName into EmpLocation1_Id from LabelName where TableName = 'EmpLocation1' and AttributeName = 'EmpLocation1Id';
  if exists(select* from Subregistry where
      RegistryId = 'CareerAttribute' and SubRegistryId = 'EmpCode1Id') then
    update Subregistry set ShortStringAttr = EmpCode1_Id where
      RegistryId = 'CareerAttribute' and SubRegistryId = 'EmpCode1Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CareerAttribute' and SubRegistryId = 'EmpCode2Id') then
    update Subregistry set
      ShortStringAttr = EmpCode2_Id where
      RegistryId = 'CareerAttribute' and SubRegistryId = 'EmpCode2Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CareerAttribute' and SubRegistryId = 'EmpCode3Id') then
    update Subregistry set
      ShortStringAttr = EmpCode3_Id where
      RegistryId = 'CareerAttribute' and SubRegistryId = 'EmpCode3Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CareerAttribute' and SubRegistryId = 'EmpCode4Id') then
    update Subregistry set
      ShortStringAttr = EmpCode4_Id where
      RegistryId = 'CareerAttribute' and SubRegistryId = 'EmpCode4Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CareerAttribute' and SubRegistryId = 'EmpCode5Id') then
    update Subregistry set
      ShortStringAttr = EmpCode5_Id where
      RegistryId = 'CareerAttribute' and SubRegistryId = 'EmpCode5Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CareerAttribute' and SubRegistryId = 'EmpLocation1Id') then
    update Subregistry set
      ShortStringAttr = EmpLocation1_Id where
      RegistryId = 'CareerAttribute' and SubRegistryId = 'EmpLocation1Id'
  end if;
  commit work
end
;

create procedure dba.ASQLUpdateInterfaceCodeTable(
in In_InterfaceProjectID char(20))
begin
  if exists(select* from InterfaceProject where
      InterfaceProject.InterfaceProjectID = In_InterfaceProjectID) then
    InterfaceTableCodeLoop: for InterfaceTableCodeForLoop as Cur_InterfaceTableCode dynamic scroll cursor for
      select SubRegistryID as In_CodeTableID,
        RegProperty1 as In_InterfaceProcessID from
        Subregistry where
        RegistryID = 'InterfaceCodeTable' do
      if not exists(select* from InterfaceCodeTable where InterfaceProjectID = In_InterfaceProjectID and
          InterfaceProcessID = In_InterfaceProcessID and
          CodeTableID = In_CodeTableID) then
        call InsertNewInterfaceCodeTable(
        In_InterfaceProjectID,
        In_InterfaceProcessID,
        In_CodeTableID,'',
        1,
        0,'')
      end if end for;
    commit work
  end if
end
;

create procedure DBA.ASQLWordWarp(
in In_OrgStatement char(200),
in In_size integer,
out Out_WrapStatement char(200),
out Out_RestStatement char(200))
begin
  declare i integer;
  if(Length(In_OrgStatement) > In_size) then
    set Out_WrapStatement=SubString(In_OrgStatement,1,In_size);
    set i=Length(Out_WrapStatement);
    FindSpace:
    while i != 0 loop
      message SubString(Out_WrapStatement,i,1) type info to client;
      if(SubString(Out_WrapStatement,i,1) = ' ') then leave FindSpace
      end if;
      set i=i-1;
    end loop FindSpace;
    set Out_WrapStatement=SubString(In_OrgStatement,1,i-1);
    set Out_RestStatement=SubString(In_OrgStatement,i+1,length(In_OrgStatement)-i)
  else
    set Out_WrapStatement=In_OrgStatement;
    set Out_RestStatement=''
  end if
end
;

create function dba.CanDeleteDefaultShortStrAttr(
in In_RegistryID char(20),
in In_SubRegistryID char(20),
in In_Data char(20))
returns integer
begin
  declare fResult integer;
  declare fData char(20);
  if
    exists(select ShortStringAttr from
      SubRegistry where
      RegistryID = In_RegistryID and
      SubRegistryID = In_SubRegistryID) then
    select ShortStringAttr into fData
      from SubRegistry where
      RegistryID = In_RegistryID and
      SubRegistryID = In_SubRegistryID;
    if fData = In_Data then set fResult=0
    else set fResult=1
    end if
  else
    set fResult=0
  end if;
  return(fResult)
end
;

create procedure dba.DBPatchCreateAttachment()
begin
  PersonalLoop: for PersonalFor as Cur_PersonalSysId dynamic scroll cursor for
    select PersonalSysId as Get_PersonalSysId from Personal do
    if not exists(select* from Attachment where PersonalSysId = Get_PersonalSysId) then
      insert into Attachment(PersonalSysId,AttachmentType) values(
        Get_PersonalSysId,'Notes');
      insert into Attachment(PersonalSysId,AttachmentType) values(
        Get_PersonalSysId,'Photo');
      commit work
    end if end for
end
;

create procedure dba.DeleteAdHocQueryFields(
in In_QueryRecId char(60),
in In_FieldsName char(100),
in In_EntityName char(100))
begin
  if exists(select* from AdHocQueryFields where
      AdHocQueryFields.QueryRecId = In_QueryRecId and
      AdHocQueryFields.FieldsName = In_FieldsName and
      AdHocQueryFields.EntityName = In_EntityName) then
    delete from AdHocQueryFields where
      AdHocQueryFields.QueryRecId = In_QueryRecId and
      AdHocQueryFields.FieldsName = In_FieldsName and
      AdHocQueryFields.EntityName = In_EntityName;
    commit work
  end if
end
;

create procedure dba.DeleteAdHocQueryFieldsRecord(
in In_QueryRecId char(60))
begin
  if exists(select* from AdHocQueryFields where
      AdHocQueryFields.QueryRecId = In_QueryRecId) then
    delete from AdHocQueryFields where
      AdHocQueryFields.QueryRecId = In_QueryRecId;
    commit work
  end if
end
;

create procedure dba.DeleteAdHocQueryRecord(
in In_QueryRecId char(60))
begin
  if exists(select* from AdHocQueryRec where
      AdHocQueryRec.QueryRecId = In_QueryRecId) then
    delete from AdHocQueryRec where
      AdHocQueryRec.QueryRecId = In_QueryRecId;
    commit work
  end if
end
;

create procedure dba.DeleteAllCountryState(
in In_CountryId char(10))
begin
  if exists(select* from State where State.CountryId = In_CountryId) then
    delete from State where
      State.StateId = In_StateId;
    commit work
  end if
end
;

create procedure dba.DeleteBank(
in In_BankId char(20))
begin
  if exists(select* from Bank where Bank.BankId = In_BankId) then
    if not exists(select* from BankBranch where BankId = In_BankId) then
      delete from Bank where
        Bank.BankId = In_BankId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteBankAccountType(
in In_BankAccountTypeId char(20))
begin
  if exists(select* from BankAccountType where
      BankAccountType.BankAccountTypeId = In_BankAccountTypeId) then
    delete from BankAccountType where
      BankAccountType.BankAccountTypeId = In_BankAccountTypeId;
    commit work
  end if
end
;

create procedure dba.DeleteBankAccType(
in In_BankAccTypeId char(20))
begin
  if exists(select* from BankAccType where BankAccType.BankAccTypeId = In_BankAccTypeId) then
    delete from BankAccType where
      BankAccType.BankAccTypeId = In_BankAccTypeId;
    commit work
  end if
end
;

create procedure dba.DeleteBankBranch(
in In_BankId char(20),
in In_BankBranchId char(20))
begin
  if exists(select* from BankBranch where BankBranch.BankId = In_BankId and
      BankBranch.BankBranchId = In_BankBranchId) then
    delete from BankBranch where
      BankBranch.BankId = In_BankId and
      BankBranch.BankBranchId = In_BankBranchId;
    commit work
  end if
end
;

create procedure dba.DeleteBankBranches(
in In_BankId char(20))
begin
  if exists(select* from BankBranch where BankBranch.BankId = In_BankId) then
    delete from BankBranch where
      BankBranch.BankId = In_BankId;
    commit work
  end if
end
;

create procedure dba.DeleteBloodGroup(
in In_BloodGroupId char(10))
begin
  if exists(select* from BloodGroup where
      BloodGroup.BloodGroupId = In_BloodGroupId) and DeleteDefault('BloodGroup',In_BloodGroupId) = 1 then
    if not exists(select* from personal where BloodGroupId = In_BloodGroupId) then
      delete from BloodGroup where
        BloodGroup.BloodGroupId = In_BloodGroupId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteCalendar(
in In_CalendarId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from Calendar where Calendar.CalendarId = In_CalendarId) and
    DeleteDefault('Calendar',In_CalendarId) = 1 then
    delete from FixedCalendar where
      FixedCalendar.CalendarId = In_CalendarId;
    delete from Calendar where
      Calendar.CalendarId = In_CalendarId;
    commit work;
    if exists(select* from Calendar where Calendar.CalendarId = In_CalendarId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteCalendarDay(
in In_CalendarIdCode char(20))
begin
  if exists(select* from Calendar where
      Calendar.CalendarId = In_CalendarIdCode) then
    delete from CalendarDay where
      CalendarDay.CalendarIdCode = In_CalendarIdCode;
    commit work
  end if
end
;

create procedure dba.DeleteCalendarDayYear(
in In_Year integer)
begin
  delete from CalendarDay where
    YEAR(CalendarDay.CalendarDate) = In_Year;
  commit work
end
;

create procedure dba.DeleteCareerAttribute(
in In_EmployeeSysId integer,
in In_CareerEffectiveDate date,
in In_CareerAttributeID char(20))
begin
  if exists(select* from CareerAttribute where
      CareerAttribute.EmployeeSysId = In_EmployeeSysId and
      CareerAttribute.CareerEffectiveDate = In_CareerEffectiveDate and
      CareerAttribute.CareerAttributeID = In_CareerAttributeID) then
    delete from CareerAttribute where
      CareerAttribute.EmployeeSysId = In_EmployeeSysId and
      CareerAttribute.CareerEffectiveDate = In_CareerEffectiveDate and
      CareerAttribute.CareerAttributeID = In_CareerAttributeID;
    commit work
  end if
end
;

create procedure dba.DeleteCareerAttributeTwoId(
in In_EmployeeSysId integer,
in In_CareerEffectiveDate date)
begin
  if exists(select* from CareerAttribute where
      CareerAttribute.EmployeeSysId = In_EmployeeSysId and
      CareerAttribute.CareerEffectiveDate = In_CareerEffectiveDate) then
    delete from CareerAttribute where
      CareerAttribute.EmployeeSysId = In_EmployeeSysId and
      CareerAttribute.CareerEffectiveDate = In_CareerEffectiveDate;
    commit work
  end if
end
;

create procedure dba.DeleteCareerProgression(
in In_EmployeeSysId integer,
in In_CareerEffectiveDate date)
begin
  if exists(select* from CareerProgression where
      CareerProgression.EmployeeSysId = In_EmployeeSysId and
      CareerProgression.CareerEffectiveDate = In_CareerEffectiveDate) then
    delete from CareerAttribute where
      CareerAttribute.EmployeeSysId = In_EmployeeSysId and
      CareerAttribute.CareerEffectiveDate = In_CareerEffectiveDate;
    delete from CareerProgression where
      CareerProgression.EmployeeSysId = In_EmployeeSysId and
      CareerProgression.CareerEffectiveDate = In_CareerEffectiveDate;
    commit work
  end if
end
;

create procedure dba.DeleteCategory(
in In_CategoryId char(20))
begin
  if exists(select* from Category where Category.CategoryId = In_CategoryId) and DeleteDefault('Category',In_CategoryId) = 1 then
    if not exists(select* from Employee where CategoryID = In_CategoryId) then
      delete from Category where
        Category.CategoryId = In_CategoryId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteCessation(
in In_CessationCode char(20))
begin
  if exists(select* from Cessation where
      Cessation.CessationCode = In_CessationCode) then
    if not exists(select* from Employee where CessationCode = In_CessationCode) then
      delete from Cessation where
        Cessation.CessationCode = In_CessationCode;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteCity(
in In_CountryId char(20),
in In_StateId char(20),
in In_CityId char(20))
begin
  if exists(select* from City where City.CountryId = In_CountryId and
      City.StateId = In_StateId and City.CityId = In_CityId) then
    if(not exists(select* from PersonalAddress where PersonalAddress.PersonalAddCountry = In_CountryId and
        PersonalAddress.PersonalAddState = In_StateId and PersonalAddress.PersonalAddCity = In_CityId) and
      not exists(select* from Company where Company.CompanyCountry = In_CountryId and
        Company.CompanyState = In_StateId and Company.CompanyCity = In_CityId) and
      not exists(select* from Branch where Branch.BranchCountry = In_CountryId and
        Branch.BranchState = In_StateId and Branch.BranchCity = In_CityId)) then
      delete from City where
        City.CountryId = In_CountryId and
        City.StateId = In_StateId and City.CityId = In_CityId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteCityCountry(
in In_CountryId char(20))
begin
  if exists(select* from City where City.CountryId = In_CountryId) then
    delete from City where
      City.CountryId = In_CountryId;
    commit work
  end if
end
;

create procedure dba.DeleteCityState(
in In_CountryId char(20),
in In_StateId char(20))
begin
  if exists(select* from City where City.CountryId = In_CountryId and
      City.StateId = In_StateId) then
    delete from City where
      City.CountryId = In_CountryId and
      City.StateId = In_StateId;
    commit work
  end if
end
;

create procedure DBA.DeleteClassification(
in In_ClassificationCode char(20))
begin
  if exists(select* from Classification where Classification.ClassificationCode = In_ClassificationCode) and
    DeleteDefault('ClassificationCode',In_ClassificationCode) = 1 then
    if not exists(select* from Employee where ClassificationCode = In_ClassificationCode) then
      delete from Classification where
        Classification.ClassificationCode = In_ClassificationCode;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteComBank(
in In_ComBankCode char(20),
in In_CompanyId char(20),
in In_ComBankBranchCode char(20),
in In_ComAccountNo char(20))
begin
  if exists(select* from CompanyBank where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComAccountNo) then
    delete from CompanyBank where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComAccountNo;
    commit work
  end if
end
;

create procedure dba.DeleteCompanyBranch(
in In_CompanyId char(20),
in In_BranchId char(20))
begin
  if exists(select* from Branch where Branch.CompanyId = In_CompanyId and
      Branch.BranchId = In_BranchId) and DeleteDefault('Branch',In_BranchId) = 1 then
    if not exists(select* from Employee where Employee.CompanyId = In_CompanyId and
        Employee.BranchId = In_BranchId) then
      delete from BranchGov where
        BranchGov.CompanyId = In_CompanyId and
        BranchGov.BranchId = In_BranchId;
      delete from Branch where
        Branch.CompanyId = In_CompanyId and
        Branch.BranchId = In_BranchId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteCompanyBranches(
in In_CompanyId char(20))
begin
  if exists(select* from Branch where
      Branch.CompanyId = In_CompanyId) then
    delete from Branch where
      Branch.CompanyId = In_CompanyId;
    commit work
  end if
end
;

create procedure dba.DeleteCompanyGovt(
in In_CompanyGovTypeSysId integer,
in In_CompanyId char(20))
begin
  if exists(select* from CompanyGov where
      CompanyGov.CompanyGovTypeSysId = In_CompanyGovTypeSysId and
      CompanyGov.CompanyId = In_CompanyId) then
    delete from CompanyGov where
      CompanyGov.CompanyGovTypeSysId = In_CompanyGovTypeSysId and
      CompanyGov.CompanyId = In_CompanyId;
    commit work
  end if
end
;

create procedure dba.DeleteCompanyGovtCompany(
in In_CompanyId char(20))
begin
  if exists(select* from CompanyGov where
      CompanyGov.CompanyId = In_CompanyId) then
    delete from CompanyGov where
      CompanyGov.CompanyId = In_CompanyId;
    commit work
  end if
end
;

create procedure dba.DeleteCompanyGovType(
in In_ComGovTypeId char(20),
in In_CountryId char(20))
begin
  if exists(select* from CompanyGovType where
      CompanyGovType.ComGovTypeId = In_ComGovTypeId and
      CompanyGovType.CountryId = In_CountryId) then
    delete from CompanyGovType where
      CompanyGovType.ComGovTypeId = In_ComGovTypeId and
      CompanyGovType.CountryId = In_CountryId;
    commit work
  end if
end
;

create procedure dba.DeleteCompanyGovTypeCountry(
in In_CountryId char(20))
begin
  if exists(select* from CompanyGovType where
      CompanyGovType.CountryId = In_CountryId) then
    delete from CompanyGovType where
      CompanyGovType.CountryId = In_CountryId;
    commit work
  end if
end
;

create procedure dba.DeleteCompanyRecord(
in In_CompanyId char(20))
begin
  if exists(select* from Company where Company.CompanyId = In_CompanyId) then
    delete from Company where
      Company.CompanyId = In_CompanyId;
    commit work
  end if
end
;

create procedure dba.DeleteCompanyType(
in In_ComTypeId char(20))
begin
  if exists(select* from CompanyType where
      CompanyType.CompanyTypeId = In_ComTypeId) then
    delete from CompanyType where
      CompanyType.CompanyTypeId = In_ComTypeId;
    commit work
  end if
end
;

create procedure dba.DeleteContactLoc(
in In_ContactLocId char(20))
begin
  if exists(select* from ContactLocation where
      ContactLocation.ContactLocationId = In_ContactLocId) then
    if((not exists(select* from PersonalAddress where ContactLocationId = In_ContactLocId)) and
      (not exists(select* from PersonalContact where ContactLocationId = In_ContactLocId)) and
      (not exists(select* from PersonalEmail where ContactLocationId = In_ContactLocId))) then
      delete from ContactLocation where
        ContactLocation.ContactLocationId = In_ContactLocId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteContractProgression(
in In_EmployeeSysId integer,
in In_ContractStartDate date)
begin
  declare CtrCurrent integer;
  declare EmpSysId integer;
  declare CtrStartDate date;
  if exists(select* from ContractProgression where
      ContractProgression.EmployeeSysId = In_EmployeeSysId and
      ContractProgression.ContractStartDate = In_ContractStartDate) then
    select ContractCurrent into CtrCurrent from ContractProgression where
      ContractProgression.EmployeeSysId = In_EmployeeSysId and
      ContractProgression.ContractStartDate = In_ContractStartDate;
    if(CtrCurrent = 1) then
      select first EmployeeSysId,ContractStartDate into EmpSysId,CtrStartDate from ContractProgression where
        ContractProgression.EmployeeSysId = In_EmployeeSysId and
        ContractProgression.ContractStartDate < In_ContractStartDate order by
        ContractStartDate desc;
      update ContractProgression set
        ContractCurrent = 1 where
        ContractProgression.EmployeeSysId = EmpSysId and
        ContractProgression.ContractStartDate = CtrStartDate
    end if;
    delete from ContractProgression where
      ContractProgression.EmployeeSysId = In_EmployeeSysId and
      ContractProgression.ContractStartDate = In_ContractStartDate;
    commit work
  end if
end
;

create procedure dba.DeleteCountry(
in In_CountryId char(20))
begin
  if exists(select* from Country where
      Country.CountryId = In_CountryId) and DeleteDefault('Country',In_CountryId) = 1 then
    if not exists(select* from State where CountryID = In_CountryId) then
      delete from Country where
        Country.CountryId = In_CountryId;
      commit work
    end if
  end if
end
;

create function dba.DeleteDefault(
in In_CodeTableName char(50),
in In_Data char(20))
returns integer
begin
  declare fResult integer;
  declare fCondition1 integer;
  declare fCondition2 integer;
  if In_CodeTableName = 'TitleCode' then
    select CanDeleteDefaultShortStrAttr('PersonalSetupData','Title',In_Data) into fResult
  elseif In_CodeTableName = 'Country' then
    select CanDeleteDefaultShortStrAttr('PersonalSetupData','Nationality',In_Data) into fCondition1;
    select CanDeleteDefaultShortStrAttr('PersonalSetupData','CountryofBirth',In_Data) into fCondition2;
    if fCondition1+fCondition2 < 2 then set fResult=0
    else set fResult=1
    end if
  elseif In_CodeTableName = 'MaritalStatus' then
    select CanDeleteDefaultShortStrAttr('PersonalSetupData','MaritalStatus',In_Data) into fResult
  elseif In_CodeTableName = 'Race' then
    select CanDeleteDefaultShortStrAttr('PersonalSetupData','Race',In_Data) into fResult
  elseif In_CodeTableName = 'Religion' then
    select CanDeleteDefaultShortStrAttr('PersonalSetupData','Religion',In_Data) into fResult
  elseif In_CodeTableName = 'BloodGroup' then
    select CanDeleteDefaultShortStrAttr('PersonalSetupData','BloodGroup',In_Data) into fResult
  elseif In_CodeTableName = 'InterfaceProject' then
    select CanDeleteDefaultShortStrAttr('PersonalSetupData','InterfaceProject',In_Data) into fResult
  elseif In_CodeTableName = 'Department' then
    select CanDeleteDefaultShortStrAttr('EmployeeSetupData','Department',In_Data) into fResult
  elseif In_CodeTableName = 'Section' then
    select CanDeleteDefaultShortStrAttr('EmployeeSetupData','Section',In_Data) into fResult
  elseif In_CodeTableName = 'Position' then
    select CanDeleteDefaultShortStrAttr('EmployeeSetupData','Position',In_Data) into fResult
  elseif In_CodeTableName = 'Category' then
    select CanDeleteDefaultShortStrAttr('EmployeeSetupData','Category',In_Data) into fResult
  elseif In_CodeTableName = 'Branch' then
    select CanDeleteDefaultShortStrAttr('EmployeeSetupData','Branch',In_Data) into fResult
  elseif In_CodeTableName = 'Calendar' then
    select CanDeleteDefaultShortStrAttr('EmployeeSetupData','Calendar',In_Data) into fResult
  elseif In_CodeTableName = 'ClassificationCode' then
    select CanDeleteDefaultShortStrAttr('EmployeeSetupData','ClassificationCode',In_Data) into fResult
  elseif In_CodeTableName = 'SalaryGradeId' then
    select CanDeleteDefaultShortStrAttr('EmployeeSetupData','SalaryGradeId',In_Data) into fResult
  elseif In_CodeTableName = 'EmpCode1Id' then
    select CanDeleteDefaultShortStrAttr('EmployeeSetupData','EmpCode1Id',In_Data) into fResult
  elseif In_CodeTableName = 'EmpCode2Id' then
    select CanDeleteDefaultShortStrAttr('EmployeeSetupData','EmpCode2Id',In_Data) into fResult
  elseif In_CodeTableName = 'EmpCode3Id' then
    select CanDeleteDefaultShortStrAttr('EmployeeSetupData','EmpCode3Id',In_Data) into fResult
  elseif In_CodeTableName = 'EmpCode4Id' then
    select CanDeleteDefaultShortStrAttr('EmployeeSetupData','EmpCode4Id',In_Data) into fResult
  elseif In_CodeTableName = 'EmpCode5Id' then
    select CanDeleteDefaultShortStrAttr('EmployeeSetupData','EmpCode5Id',In_Data) into fResult
  elseif In_CodeTableName = 'EmpLocation1Id' then
    select CanDeleteDefaultShortStrAttr('EmployeeSetupData','EmpLocation1Id',In_Data) into fResult
  elseif In_CodeTableName = 'WorkTimeCalendarID' then
    select CanDeleteDefaultShortStrAttr('EmployeeSetupData','WorkTimeCalendarID',In_Data) into fResult
  elseif In_CodeTableName = 'CostCentreId' then
    select CanDeleteDefaultShortStrAttr('EmployeeSetupData','CostCentreId',In_Data) into fResult
  elseif In_CodeTableName = 'ExchangeRateId' then
    select CanDeleteDefaultShortStrAttr('EmployeeSetupData','ExchangeRateId',In_Data) into fResult
  end if;
  return(fResult)
end
;

create procedure dba.DeleteDepartment(
in In_DepartmentId char(20))
begin
  if exists(select* from Department where Department.DepartmentId = In_DepartmentId) and DeleteDefault('Department',In_DepartmentId) = 1 then
    if not exists(select* from Employee where DepartmentId = In_DepartmentId) then
      delete from Department where
        Department.DepartmentId = In_DepartmentId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteEducation(
in In_EducationId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from Education where EducationId = In_EducationId) then
    delete from Education where EducationId = In_EducationId;
    commit work;
    if exists(select* from Education where EducationId = In_EducationId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteEmpCode1(
in In_EmpCode1Id char(20))
begin
  if exists(select* from EmpCode1 where EmpCode1.EmpCode1Id = In_EmpCode1Id) and DeleteDefault('EmpCode1Id',In_EmpCode1Id) = 1 then
    delete from EmpCode1 where
      EmpCode1.EmpCode1Id = In_EmpCode1Id;
    commit work
  end if
end
;

create procedure dba.DeleteEmpCode2(
in In_EmpCode2Id char(20))
begin
  if exists(select* from EmpCode2 where EmpCode2.EmpCode2Id = In_EmpCode2Id) and DeleteDefault('EmpCode2Id',In_EmpCode2Id) = 1 then
    delete from EmpCode2 where
      EmpCode2.EmpCode2Id = In_EmpCode2Id;
    commit work
  end if
end
;

create procedure dba.DeleteEmpCode3(
in In_EmpCode3Id char(20))
begin
  if exists(select* from EmpCode3 where EmpCode3.EmpCode3Id = In_EmpCode3Id) and DeleteDefault('EmpCode3Id',In_EmpCode3Id) = 1 then
    delete from EmpCode3 where
      EmpCode3.EmpCode3Id = In_EmpCode3Id;
    commit work
  end if
end
;

create procedure dba.DeleteEmpCode4(
in In_EmpCode4Id char(20))
begin
  if exists(select* from EmpCode4 where EmpCode4.EmpCode4Id = In_EmpCode4Id) and DeleteDefault('EmpCode4Id',In_EmpCode4Id) = 1 then
    delete from EmpCode4 where
      EmpCode4.EmpCode4Id = In_EmpCode4Id;
    commit work
  end if
end
;

create procedure dba.DeleteEmpCode5(
in In_EmpCode5Id char(20))
begin
  if exists(select* from EmpCode5 where EmpCode5.EmpCode5Id = In_EmpCode5Id) and DeleteDefault('EmpCode5Id',In_EmpCode5Id) = 1 then
    delete from EmpCode5 where
      EmpCode5.EmpCode5Id = In_EmpCode5Id;
    commit work
  end if
end
;

create procedure dba.DeleteEmpeeWkCalen(
in EmpeeWkCalenId integer)
begin
  delete from EmpeeWkCalen where
    EmpeeWkCalen.EmpeeWkCalenId = In_EmpeeWkCalenId;
  commit work
end
;

create procedure dba.DeleteEmpeeWkCalenCal(
in In_CalendarId char(20))
begin
  delete from EmpeeWkCalen where
    EmpeeWkCalen.CalendarId = In_CalendarId;
  commit work
end
;

create procedure dba.DeleteEmpeeWkCalenEmp(
in In_EmployeeSysId integer)
begin
  delete from EmpeeWkCalen where
    EmpeeWkCalen.EmployeeSysId = In_EmployeeSysId;
  commit work
end
;

create procedure dba.DeleteEmpLocation1(
in In_EmpLocation1Id char(20))
begin
  if exists(select* from EmpLocation1 where EmpLocation1.EmpLocation1Id = In_EmpLocation1Id) and DeleteDefault('EmpLocation1Id',In_EmpLocation1Id) = 1 then
    delete from EmpLocation1 where
      EmpLocation1.EmpLocation1Id = In_EmpLocation1Id;
    commit work
  end if
end
;

create procedure dba.DeleteEmployeeRecord(
in In_EmployeeSysId integer,
in In_EmployeeId char(30))
begin
  declare Int_PersonalSysId integer;
  declare Char_EmployeeId char(30);
  if exists(select* from Employee where Employee.EmployeeSysId = In_EmployeesysId) then
    select Employee.PersonalSysId into Int_PersonalSysId from Employee where Employee.EmployeeSysId = In_EmployeeSysId;
    select first EmployeeId into Char_EmployeeId from Employee where
      PersonalSysId = Int_PersonalSysId and
      EmployeesysId <> In_EmployeeSysId order by HireDate desc;
    update Personal set
      Personal.EmployeeId = Char_EmployeeId where
      Personal.PersonalSysId = Int_PersonalSysId;
    call DeleteEmpeeWkCalenEmp(In_EmployeeSysId);
    call DeletePaymentBankInfoEmp(In_EmployeeSysId);
    call DeleteLoanEmployeeEmp(In_EmployeeSysId);
    call DeleteCETmsExportEmpEmp(In_EmployeeSysId);
    call DeleteIntercorpTmsExportEmpEmp(In_EmployeeSysId);
    if FGetDBCountry(*) = 'HongKong' then
      call DeleteHKTaxDetails(In_EmployeeSysId)
    end if;
    delete from Employee where
      Employee.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.DeleteEmploymentStatus(
in In_EmpStatusId char(20))
begin
  if exists(select* from EmploymentStatus where
      EmploymentStatus.EmpStatusId = In_EmpStatusId) then
    delete from EmploymentStatus where
      EmploymentStatus.EmpStatusId = In_EmpStatusId;
    commit work
  end if
end
;

create procedure dba.DeleteEmploymentType(
in In_EmploymentTypeId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from EmploymentType where EmploymentTypeId = In_EmploymentTypeId) then
    if not exists(select* from JobHistory where EmploymentTypeId = In_EmploymentTypeId) then
      delete from EmploymentType where EmploymentTypeId = In_EmploymentTypeId;
      commit work
    end if;
    if exists(select* from EmploymentType where EmploymentTypeId = In_EmploymentTypeId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteFieldMajor(
in In_FieldMajorId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from FieldMajor where FieldMajorId = In_FieldMajorId) then
    delete from FieldMajor where FieldMajorId = In_FieldMajorId;
    commit work;
    if exists(select* from FieldMajor where FieldMajorId = In_FieldMajorId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteFieldSecuirtyNoAccessFld(
in In_FieldSecurityId integer)
begin
  if exists(select* from FieldSecurityNoAccess where
      FieldSecurityNoAccess.FieldSecurityId = In_FieldSecurityId) then
    delete from FieldSecurityNoAccess where
      FieldSecurityNoAccess.FieldSecruityId = In_FieldSecruityId;
    commit work
  end if
end
;

create procedure dba.DeleteFieldSecurityNoAccessGrp(
in In_UserGroupId char(20))
begin
  if exists(select* from FieldSecurityNoAccess where
      FieldSecurityNoAccess.UserGroupId = In_UserGroupId) then
    delete from FieldSecurityNoAccess where
      FieldSecurityNoAccess.UserGroupId = In_UserGroupId;
    commit work
  end if
end
;

create procedure dba.DeleteFieldSecurityNoAccessRec(
in In_FieldSecurityId integer,
in In_UserGroupId char(20))
begin
  if exists(select* from FieldSecurityNoAccess where
      FieldSecurityNoAccess.FieldSecurityId = In_FieldSecurityId and
      FieldSecurityNoAccess.UserGroupId = In_UserGroupId) then
    delete from FieldSecurityNoAccess where
      FieldSecurityNoAccess.FieldSecurityId = In_FieldSecurityId and
      FieldSecurityNoAccess.UserGroupId = In_UserGroupId;
    commit work
  end if
end
;

create procedure dba.DeleteForeignWorkerRecord(
in In_EmployeeSysId integer,
in In_FWRecordId integer)
begin
  if exists(select* from ForeignWorkRec where
      ForeignWorkRec.FWRecordId = In_FWRecordId and
      ForeignWorkRec.EmployeeSysId = In_EmployeeSysId) then
    delete from ForeignWorkRec where
      ForeignWorkRec.FWRecordId = In_FWRecordId and
      ForeignWorkRec.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.DeleteForeignWorkerRecordEmp(
in In_EmployeeSysId integer)
begin
  if exists(select* from ForeignWorkRec where
      ForeignWorkRec.EmployeeSysId = In_EmployeeSysId) then
    delete from ForeignWorkRec where
      ForeignWorkRec.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.DeleteForeignWorkerType(
in In_FWorkerTypeCode char(20))
begin
  if exists(select* from ForeignWorkerType where
      ForeignWorkerType.FWorkerTypeCode = In_FWorkerTypeCode) then
    delete from ForeignWorkerType where
      ForeignWorkerType.FWorkerTypeCode = In_FWorkerTypeCode;
    commit work
  end if
end
;

create procedure dba.DeleteGovContirbType(
in In_CountryId char(10),
in In_GovContribTypeId char(20),
in In_GovContribTypeName char(100))
begin
  if exists(select* from GovermentContribType where
      GovermentContribType.GovContribTypeId = In_GovContribTypeId and
      GovermentContribType.CountryId = In_CountryId) then
    delete from GovermentContribType where
      GovermentContribType.GovContribTypeId = In_GovContribTypeId and
      GovermentContribType.CountryId = In_CountryId;
    commit work
  end if
end
;

create procedure dba.DeleteGroupLvePatternCal(
in In_CalendarId char(20))
begin
  if exists(select* from GroupLeavePattern where
      GroupLeavePattern.CalendarId = In_CalendarId) then
    delete from GroupLeavePattern where
      GroupLeavePattern.CalendarId = In_CalendarId;
    commit work
  end if
end
;

create procedure dba.DeleteGroupLvePatternGrp(
in In_GroupLeavePatternWeekNo char(20))
begin
  if exists(select* from GroupLeavePattern where
      GroupLeavePattern.GroupLeavePatternWeekNo = In_GroupLeavePatternWeekNo) then
    delete from GroupLeavePattern where
      GroupLeavePattern.GroupLeavePatternWeekNo = In_GroupLeavePatternWeekNo;
    commit work
  end if
end
;

create procedure dba.DeleteGroupLvePatternRec(
in In_GroupLeavePatternWeekNo char(20),
in In_CalendarId char(20),
in In_WeekLeavePatternId char(20))
begin
  if exists(select* from GroupLeavePattern where
      GroupLeavePattern.GroupLeavePatternWeekNo = In_GroupLeavePatternWeekNo and
      GroupLeavePattern.CalendarId = In_CalendarId and
      GroupLeavePattern.WeekLeavePatternId = In_WeekLeavePatternId) then
    delete from GroupLeavePattern where
      GroupLeavePattern.GroupLeavePatternWeekNo = In_GroupLeavePatternWeekNo and
      GroupLeavePattern.CalendarId = In_CalendarId and
      GroupLeavePattern.WeekLeavePatternId = In_WeekLeavePatternId;
    commit work
  end if
end
;

create procedure dba.DeleteGroupLvePatternWkP(
in In_WeekLeavePatternId char(20))
begin
  if exists(select* from GroupLeavePattern where
      GroupLeavePattern.WeekLeavePatternId = In_WeekLeavePatternId) then
    delete from GroupLeavePattern where
      GroupLeavePattern.WeekLeavePatternId = In_WeekLeavePatternId;
    commit work
  end if
end
;

create procedure dba.DeleteGroupWorkPatternCal(
in In_CalendarId char(20))
begin
  if exists(select* from GroupWorkPattern where
      GroupWorkPattern.CalendarId = In_CalendarId) then
    delete from GroupWorkPattern where
      GroupWorkPattern.CalendarId = In_CalendarId;
    commit work
  end if
end
;

create procedure dba.DeleteGroupWorkPatternGrp(
in In_GroupWorkPatternWeekNo char(20))
begin
  if exists(select* from GroupWorkPattern where
      GroupWorkPattern.GroupWorkPatternWeekNo = In_GroupWorkPatternWeekNo) then
    delete from GroupWorkPattern where
      GroupWorkPattern.GroupWorkPatternWeekNo = In_GroupWorkPatternWeekNo;
    commit work
  end if
end
;

create procedure dba.DeleteGroupWorkPatternRec(
in In_GroupWorkPatternWeekNo char(20),
in In_CalendarId char(20),
in In_WeekPatternId char(20))
begin
  if exists(select* from GroupWorkPattern where
      GroupWorkPattern.GroupWorkPatternWeekNo = In_GroupWorkPatternWeekNo and
      GroupWorkPattern.CalendarId = In_CalendarId and
      GroupWorkPattern.WeekPatternId = In_WeekPatternId) then
    delete from GroupWorkPattern where
      GroupWorkPattern.GroupWorkPatternWeekNo = In_GroupWorkPatternWeekNo and
      GroupWorkPattern.CalendarId = In_CalendarId and
      GroupWorkPattern.WeekPatternId = In_WeekPatternId;
    commit work
  end if
end
;

create procedure dba.DeleteGroupWorkPatternWkP(
in In_WeekPatternId char(20))
begin
  if exists(select* from GroupWorkPattern where
      GroupWorkPattern.WeekPatternId = In_WeekPatternId) then
    delete from GroupWorkPattern where
      GroupWorkPattern.WeekPatternId = In_WeekPatternId;
    commit work
  end if
end
;

create procedure dba.DeleteHoliday(
in In_HolidayId char(20),
in In_CountryId char(20),
in In_HolidayStartDate date)
begin
  if exists(select* from Holidays where Holidays.HolidayId = In_HolidayId and
      Holidays.CountryId = In_CountryId and
      Holidays.HolidayStartDate = In_HolidayStartDate) then
    delete from Holidays where
      Holidays.HolidayId = In_HolidayId and
      Holidays.CountryId = In_CountryId and
      Holidays.HolidayStartDate = In_HolidayStartDate;
    commit work
  end if
end
;

create procedure dba.DeleteHolidayCountry(
in In_CountryId char(20))
begin
  if exists(select* from Holidays where Holidays.CountryId = In_CountryId) then
    delete from Hoildays where
      Holidays.CountryId = In_CountryId;
    commit work
  end if
end
;

create procedure dba.DeleteIdentityType(
in In_IdentityTypeId char(20))
begin
  if exists(select* from IdentityType where
      IdentityType.IdentityTypeId = In_IdentityTypeId) then
    delete from IdentityType where IdentityType.IdentityTypeId = In_IdentityTypeId;
    commit work
  end if
end
;

create procedure dba.DeleteLanguage(
in In_LanguageId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from Language where LanguageId = In_LanguageId) then
    delete from Language where LanguageId = In_LanguageId;
    commit work;
    if exists(select* from Language where LanguageId = In_LanguageId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteLoginRec(
in In_UserId char(20),
in In_LoginSGSPGenId char(30))
begin
  delete from LoginRec where
    LoginRec.UserId = In_UserId and
    LoginRec.LoginSGSPGenId = In_LoginSGSPGenId and
    LoginRec.ModuleLogoutTime is not null;
  commit work
end
;

create procedure dba.DeleteLoginRecBatch(
in In_FromLoginNo integer,
in In_ToLoginNo integer)
begin
  declare x integer;
  set x=In_FromLoginNo;
  LOOP1:
  while x < In_ToLoginNo+1 loop
    delete from LoginRec where
      LoginRec.LoginNo = x;
    set x=x+1
  end loop LOOP1;
  commit work
end
;

create procedure dba.DeleteLoginRecUser(
in In_UserId char(20))
begin
  delete from LoginRec where
    LoginRec.UserId = In_UserId and
    LoginRec.ModuleLogoutTime is null;
  commit work
end
;

create procedure dba.DeleteMaritalStatus(
in In_MariStatusCode char(20))
begin
  if exists(select* from MaritalStatus where MaritalStatus.MaritalStatusCode = In_MariStatusCode) and DeleteDefault('MaritalStatus',In_MariStatusCode) = 1 then
    if not exists(select* from Personal where MaritalStatusCode = In_MariStatusCode) then
      delete from MaritalStatus where
        MaritalStatus.MaritalStatusCode = In_MariStatusCode;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteModuleScreenGroup(
in In_ModuleScreenId char(20),
in In_Mod_ModuleScreenId char(20))
begin
  if exists(select* from ModuleScreenGroup where
      ModuleScreenGroup.ModuleScreenId = In_ModuleScreenId and
      ModuleScreenGroup.Mod_ModuleScreenId = In_Mod_ModuleScreenId) then
    delete from ModuleScreenGroup where
      ModuleScreenGroup.ModuleScreenId = In_ModuleScreenId and
      ModuleScreenGroup.Mod_ModuleScreenId = In_Mod_ModuleScreenId;
    commit work
  end if
end
;

create procedure dba.DeleteOccupation(
in In_OccupationId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from Occupation where OccupationId = In_OccupationId) then
    delete from Occupation where OccupationId = In_OccupationId;
    commit work;
    if exists(select* from Occupation where OccupationId = In_OccupationId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeletePaymentBankInfo(
in In_PayBankSGSPGenId char(30))
begin
  if exists(select* from PaymentBankInfo where
      PaymentBankInfo.PayBankSGSPGenId = In_PayBankSGSPGenId) then
    delete from PaymentBankInfo where
      PaymentBankInfo.PayBankSGSPGenId = In_PayBankSGSPGenId;
    commit work
  end if
end
;

create procedure dba.DeletePaymentBankInfoEmp(
in In_EmployeeSysId integer)
begin
  if exists(select* from PaymentBankInfo where
      PaymentBankInfo.EmployeeSysId = In_EmployeeSysId) then
    delete from PaymentBankInfo where
      PaymentBankInfo.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.DeletePensionOption(
in In_PensionOptionId char(20))
begin
  if exists(select* from PensionOption where
      PensionOption.PensionOptionId = In_PensionOptionId) then
    delete from PensionOption where
      PensionOption.PensionOptionId = In_PensionOptionId;
    commit work
  end if
end
;

create procedure dba.DeletePersonalAddressAll(
in In_PersonalSysId integer)
begin
  if exists(select* from PersonalAddress where
      PersonalAddress.PersonalSysId = In_PersonalSysId) then
    delete from PersonalAddress where
      PersonalAddress.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.DeletePersonalAddressRec(
in In_PersonalAddressId integer,
in In_PersonalSysId integer)
begin
  if exists(select* from PersonalAddress where
      PersonalAddress.PersonalAddressId = In_PersonalAddressId and
      PersonalAddress.PersonalSysId = In_PersonalSysId) then
    delete from PersonalAddress where
      PersonalAddress.PersonalAddressId = In_PersonalAddressId and
      PersonalAddress.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.DeletePersonalContactAll(
in In_PersonalSysId integer)
begin
  if exists(select* from PersonalContact where
      PersonalContact.PersonalSysId = In_PersonalSysId) then
    delete from PersonalContact where
      PersonalContact.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.DeletePersonalContactRec(
in In_PersonalContactId integer,
in In_PersonalSysId integer)
begin
  if exists(select* from PersonalContact where
      PersonalContact.PersonalContactId = In_PersonalContactId and
      PersonalContact.PersonalSysId = In_PersonalSysId) then
    delete from PersonalContact where
      PersonalContact.PersonalContactId = In_PersonalContactId and
      PersonalContact.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.DeletePersonalEducationRecord(
in In_PersonalSysId integer)
begin
  if exists(select* from EducationRecord where
      EducationRecord.PersonalSysId = In_PersonalSysId) then
    delete from EducationRecord where
      EducationRecord.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.DeletePersonalEmailAll(
in In_PersonalSysId integer)
begin
  if exists(select* from PersonalEmail where
      PersonalEmail.PersonalSysId = In_PersonalSysId) then
    delete from PersonalEmail where
      PersonalEmail.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.DeletePersonalEmailRecord(
in In_PersonalEmailId integer,
in In_PersonalSysId integer)
begin
  if exists(select* from PersonalEmail where
      PersonalEmail.PersonalEmailId = In_PersonalEmailId and
      PersonalEmail.PersonalSysId = In_PersonalSysId) then
    delete from PersonalEmail where
      PersonalEmail.PersonalEmailId = In_PersonalEmailId and
      PersonalEmail.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.DeletePersonalRecord(
in In_PersonalSysId integer)
begin
  if exists(select* from Personal where Personal.PersonalSysId = In_PersonalSysId) then
    EmployeeLoop: for EmployeeFor as Employeecurs dynamic scroll cursor for
      select Employee.EmployeeSysId as Out_EmployeeSysId from Employee where
        Employee.PersonalSysID = In_PersonalSysId do
      call ASQLDeleteEmployment(Out_EmployeeSysId);
      commit work end for;
    /*Standard deletion for all countries*/
    call DeletePersonalEmailAll(In_PersonalSysId);
    call DeletePersonalContactAll(In_PersonalSysId);
    call DeletePersonalAddressAll(In_PersonalSysId);
    call DeleteResStatusRecordBySysId(In_PersonalSysId);
    call DeleteHRDetails(In_PersonalSysId);
    delete from ProjContractWorker where
      ProjContractWorker.PersonalSysId = In_PersonalSysId;
    delete from InterfaceDetails where
      InterfaceDetails.PersonalSysId = In_PersonalSysId;
    delete from Attachment where
      Attachment.PersonalSysId = In_PersonalSysId;
    /*Income Tax Deletion*/
    if FGetDBCountry(*) = 'Singapore' then
      call DeleteYEEmployeeByPersonalSysID(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Indonesia' then
      call DeleteIndoTaxDetails(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Malaysia' then
      call DeleteMalTaxDetails(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Philippines' then
      call DeletePhTaxDetails(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Vietnam' then
      call DeleteVnTaxDetails(In_PersonalSysId)
    end if;
    if FGetDBCountry(*) = 'Thailand' then
      call DeleteThTaxDetails(In_PersonalSysId)
    end if;
    /*Delete Personal*/
    delete from Personal where
      Personal.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.DeletePersonalResStatusRec(
in In_PersonalSysId integer)
begin
  if exists(select* from ResidenceStatusRecord where
      ResidenceStatusRecord.PersonalSysId = In_PersonalSysId) then
    delete from ResidenceStatusRecord where
      ResidenceStatusRecord.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.DeletePosGrp(
in In_PositionGrpId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from PosGrp where PositionGrpId = In_PositionGrpId) and not exists(select* from PositionCode where PositionGrpId = In_PositionGrpId) then
    delete from PosGrp where PositionGrpId = In_PositionGrpId;
    commit work;
    if exists(select* from PosGrp where PositionGrpId = In_PositionGrpId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeletePositionCode(
in In_PositionId char(20))
begin
  if exists(select* from PositionCode where PositionCode.PositionId = In_PositionId) and DeleteDefault('Position',In_PositionId) = 1 then
    if(not exists(select* from Employee where PositionId = In_PositionId) and
      not exists(select* from CareerPath where Pos_PositionId = In_PositionId) and
      not exists(select* from Competency where PositionId = In_PositionId) and
      not exists(select* from RecruitPosition where PositionId = In_PositionId) and
      not exists(select* from ProjContractWorker where PositionId = In_PositionId)) then
      delete from CareerPath where
        CareerPath.PositionId = In_PositionId;
      commit work;
      delete from PositionCode where
        PositionCode.PositionId = In_PositionId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteRace(
in In_RaceId char(20))
begin
  if exists(select* from Race where Race.RaceId = In_RaceId) and DeleteDefault('Race',In_RaceId) = 1 then
    if not exists(select* from Personal where RaceId = In_RaceId) then
      delete from Race where
        Race.RaceId = In_RaceId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteRelationship(
in In_RelationshipId char(20))
begin
  if exists(select* from Relationship where
      Relationship.RelationshipId = RelationshipId) then
    delete from Relationship where
      Relationship.RelationshipId = In_RelationshipId;
    commit work
  end if
end
;

create procedure dba.DeleteReligion(
in In_ReligionId char(20))
begin
  if exists(select* from Religion where Religion.ReligionId = In_ReligionId) and DeleteDefault('Religion',In_ReligionId) = 1 then
    if not exists(select* from Personal where ReligionId = In_ReligionId) then
      delete from Religion where
        Religion.ReligionId = In_ReligionId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteResidenceType(
in In_ResidenceTypeId char(20))
begin
  if exists(select* from ResidenceType where
      ResidenceType.ResidenceTypeId = In_ResidenceTypeId) then
    delete from ResidenceType where
      ResidenceType.ResidenceTypeId = In_ResidenceTypeId;
    commit work
  end if
end
;

create procedure dba.DeleteResponsibility(
in In_ResponsibilityId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from Responsibility where ResponsibilityId = In_ResponsibilityId) then
    if(not exists(select* from jobhisRespon where ResponsibilityId = In_ResponsibilityId) and
      not exists(select* from comperespon where ResponsibilityId = In_ResponsibilityId)) then
      delete from Responsibility where ResponsibilityId = In_ResponsibilityId;
      commit work
    end if;
    if exists(select* from Responsibility where ResponsibilityId = In_ResponsibilityId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteResStatusRecord(
in In_ResStatusEffectiveDate date,
in In_PersonalSysId integer)
begin
  declare DelCurrent smallint;
  select ResStatusCurrent into DelCurrent from ResidenceStatusRecord where
    ResStatusEffectiveDate = In_ResStatusEffectiveDate and PersonalSysId = In_PersonalSysId;
  delete from ResidenceStatusRecord where
    ResidenceStatusRecord.ResStatusEffectiveDate = In_ResStatusEffectiveDate and
    PersonalSysId = In_PersonalSysId;
  if DelCurrent = 1 then
    update ResidenceStatusRecord set
      ResStatusCurrent = 1 where ResStatusEffectiveDate = (select Max(ResStatusEffectiveDate) from
        ResidenceStatusRecord where
        Personalsysid = In_PersonalSysId)
  end if;
  commit work
end
;

create procedure dba.DeleteSalaryGrade(
in In_SalaryGradeId char(20))
begin
  if exists(select* from SalaryGrade where SalaryGrade.SalaryGradeId = In_SalaryGradeId) and
    DeleteDefault('SalaryGradeId',In_SalaryGradeId) = 1 then
    delete from SalaryGrade where
      SalaryGrade.SalaryGradeId = In_SalaryGradeId;
    commit work
  end if
end
;

create procedure dba.DeleteSection(
in In_SectionID char(20))
begin
  if exists(select* from Section where Section.SectionId = In_SectionId) and DeleteDefault('Section',In_SectionID) = 1 then
    if not exists(select* from Employee where SectionId = In_SectionId) then
      delete from Section where
        Section.SectionId = In_SectionId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteState(
in In_CountryId char(20),
in In_StateId char(20))
begin
  if exists(select* from State where State.CountryId = In_CountryId and
      State.StateId = In_StateId) then
    if not exists(select* from City where City.CountryId = In_CountryId and
        City.StateId = In_StateId) then
      delete from State where
        State.CountryId = In_CountryId and
        State.StateId = In_StateId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteSystemUser(
in In_UserId char(20))
begin
  if exists(select* from SystemUser where SystemUser.UserId = In_UserId) then
    DeleteQueryRecLoop: for DeleteQueryFor as Cur_DeleteQuery dynamic scroll cursor for
      select QueryRecId as In_QueryRecId from AdHocQueryRec where UserId = In_UserId do
      call DeleteAdHocQueryFieldsRecord(In_QueryRecId);
      call DeleteUserSecurityQuery(In_QueryRecId);
      call DeleteAdHocQueryRecord(In_QueryRecId) end for;
    delete from LoginRec where LoginRec.UserId = In_UserId;
    delete from UserSearchSetting where UserId = In_UserId;
    delete from SystemUser where
      SystemUser.UserId = In_UserId;
    commit work
  end if
end
;

create procedure dba.DeleteSystemUserGroup(
in In_UserGroupId char(20))
begin
  if exists(select* from SystemUser where
      SystemUser.UserGroupId = In_UserGroupId) then
    delete from SystemUser where
      SystemUser.UserGroupId = In_UserGroupId;
    commit work
  end if
end
;

create procedure dba.DeleteTitleCode(
in In_TitleId char(20))
begin
  if exists(select* from TitleCode where TitleCode.TitleId = In_TitleId) and DeleteDefault('TitleCode',In_TitleId) = 1 then
    if not exists(select* from Personal where TitleId = In_TitleId) then
      delete from TitleCode where
        TitleCode.TitleId = In_TitleId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteUserGroup(
in In_UserGroupId char(20))
begin
  if exists(select* from UserGroup where UserGroup.UserGroupId = In_UserGroupId) then
    delete from AddSecurityItem where
      UserGroupId = In_UserGroupId;
    delete from AdditionalSecurity where
      UserGroupId = In_UserGroupId;
    delete from ReportAccess where
      UserGroupId = In_UserGroupId;
    delete from UserGroup where
      UserGroup.UserGroupId = In_UserGroupId;
    commit work
  end if
end
;

create procedure dba.DeleteUserModuleNoAccessModule(
in In_ModuleScreenId char(20))
begin
  if exists(select* from UserModuleNoAccess where
      UserModuleNoAccess.ModuleScreenId = In_ModuleScreenId) then
    delete from UserModuleNoAccess where
      UserModuleNoAccess.ModuleScreenId = In_ModuleScreenId;
    commit work
  end if
end
;

create procedure dba.DeleteUserModuleNoAccessRecord(
in In_ModuleScreenId char(20),
in In_UserGroupId char(20))
begin
  if exists(select* from UserModuleNoAccess where
      UserModuleNoAccess.ModuleScreenId = In_ModuleScreenId and
      UserModuleNoAccess.UserGroupId = In_UserGroupId) then
    delete from UserModuleNoAccess where
      UserModuleNoAccess.ModuleScreenId = In_ModuleScreenId and
      UserModuleNoAccess.UserGroupId = In_UserGroupId;
    commit work
  end if
end
;

create procedure dba.DeleteUserModuleNoAccessUserGrp(
in In_UserGroupId char(20))
begin
  if exists(select* from UserModuleNoAccess where
      UserModuleNoAccess.UserGroupId = In_UserGroupId) then
    delete from UserModuleNoAccess where
      UserModuleNoAccess.UserGroupId = In_UserGroupId;
    commit work
  end if
end
;

create procedure dba.DeleteUserSearchSetting(
in In_UserID char(20),
in In_SearchID char(20))
begin
  if exists(select* from UserSearchSetting where
      UserSearchSetting.UserID = In_UserID and
      UserSearchSetting.SearchID = In_SearchID) then
    delete from UserSearchSetting where
      UserSearchSetting.UserID = In_UserID and
      UserSearchSetting.SearchID = In_SearchID;
    commit work
  end if
end
;

create procedure dba.DeleteUserSearchSettingByUserID(
in In_UserID char(20))
begin
  if exists(select* from UserSearchSetting where
      UserSearchSetting.UserID = In_UserID) then
    delete from UserSearchSetting where
      UserSearchSetting.UserID = In_UserID;
    commit work
  end if
end
;

create procedure dba.DeleteUserSecurityQuery(
in In_QueryRecId char(60))
begin
  if exists(select* from UserSecurityQuery where
      UserSecurityQuery.QueryRecId = In_QueryRecId) then
    delete from UserSecurityQuery where
      UserSecurityQuery.QueryRecId = In_QueryRecId;
    commit work
  end if
end
;

create procedure dba.DeleteUserSecurityQueryRec(
in In_UserGroupId char(20),
in In_QueryRecId char(60))
begin
  if exists(select* from UserSecurityQuery where
      UserSecurityQuery.QueryRecId = In_QueryRecId and
      UserGroupId = In_UserGroupId) then
    delete from UserSecurityQuery where
      UserSecurityQuery.QueryRecId = In_QueryRecId and
      UserGroupId = In_UserGroupId;
    commit work
  end if
end
;

create procedure dba.DeleteUserSecurityQueryUser(
in In_UserGroupId char(20))
begin
  if exists(select* from UserSecurityQuery where
      UserSecurityQuery.UserGroupId = In_UserGroupId) then
    delete from UserSecurityQuery where
      UserSecurityQuery.UserGroupId = In_UserGroupId;
    commit work
  end if
end
;

create procedure dba.DeleteWeekLeavePattern(
in In_WeekLeavePatternId char(20))
begin
  if exists(select* from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = In_WeekLeavePatternId) then
    delete from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = In_WeekLeavePatternId;
    commit work
  end if
end
;

create procedure dba.DeleteWeekWorkPattern(
in In_WeekPatternId char(20))
begin
  if exists(select* from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = In_WeekPatternId) then
    delete from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = In_WeekPatternId;
    commit work
  end if
end
;

create function DBA.FCheckGroupWeekPattern(
in In_CalendarId char(20),
in In_Type char(20))
returns integer
begin
  declare Char_WkPatternId char(20);
  declare Dec_Mon decimal(4,3);
  declare Dec_Tue decimal(4,3);
  declare Dec_Wed decimal(4,3);
  declare Dec_Thur decimal(4,3);
  declare Dec_Fri decimal(4,3);
  declare Dec_Sat decimal(4,3);
  declare Dec_Sun decimal(4,3);
  if(In_Type = 'LEAVE_PATTERN') then
    GroupLeavePatternLoop: for GroupLeavePatternFor as curs dynamic scroll cursor for
      select WeekLeavePatternId as SourceId from GroupLeavePattern where
        CalendarId = In_CalendarId do
      if exists(select* from WeekWorkPattern where
          WeekWorkPattern.WeekPatternId = SourceId) then
        select WeekLeavePattern.WeekLeavePatternId,
          WeekLeavePattern.LveMonday,WeekLeavePattern.LveTuesday,WeekLeavePattern.LveWenesday,
          WeekLeavePattern.LveThursday,WeekLeavePattern.LveFriday,WeekLeavePattern.LveSaturday,
          WeekLeavePattern.LveSunday into Char_WkPatternId,
          Dec_Mon,Dec_Tue,Dec_Wed,Dec_Thur,Dec_Fri,
          Dec_Sat,Dec_Sun from WeekLeavePattern where
          WeekLeavePattern.WeekLeavePatternId = SourceId;
        if exists(select* from WeekWorkPattern where
            WeekWorkPattern.WeekPatternId = Char_WkPatternId and WeekWorkPattern.WWrkMon = Dec_Mon and
            WeekWorkPattern.WWrkTue = Dec_Tue and WeekWorkPattern.WWrkWed = Dec_Wed and
            WeekWorkPattern.WWrkThur = Dec_Thur and WeekWorkPattern.WWrkFri = Dec_Fri and
            WeekWorkPattern.WWrkSat = Dec_Sat and WeekWorkPattern.WWrkSun = Dec_Sun) then
          return(1)
        else
          return(0)
        end if
      end if end for
  else
    GroupWorkPatternLoop: for GroupWorkPatternFor as cur dynamic scroll cursor for
      select WeekPatternId as SourceId from GroupWorkPattern where
        CalendarId = In_CalendarId do
      if exists(select* from WeekLeavePattern where
          WeekLeavePattern.WeekLeavePatternId = SourceId) then
        select WeekLeavePattern.WeekLeavePatternId,
          WeekLeavePattern.LveMonday,WeekLeavePattern.LveTuesday,WeekLeavePattern.LveWenesday,
          WeekLeavePattern.LveThursday,WeekLeavePattern.LveFriday,WeekLeavePattern.LveSaturday,
          WeekLeavePattern.LveSunday into Char_WkPatternId,
          Dec_Mon,Dec_Tue,Dec_Wed,Dec_Thur,Dec_Fri,
          Dec_Sat,Dec_Sun from WeekLeavePattern where
          WeekLeavePattern.WeekLeavePatternId = SourceId;
        if exists(select* from WeekWorkPattern where
            WeekWorkPattern.WeekPatternId = Char_WkPatternId and WeekWorkPattern.WWrkMon = Dec_Mon and
            WeekWorkPattern.WWrkTue = Dec_Tue and WeekWorkPattern.WWrkWed = Dec_Wed and
            WeekWorkPattern.WWrkThur = Dec_Thur and WeekWorkPattern.WWrkFri = Dec_Fri and
            WeekWorkPattern.WWrkSat = Dec_Sat and WeekWorkPattern.WWrkSun = Dec_Sun) then
          return(1)
        else
          return(0)
        end if
      end if end for
  end if;
  return(1)
end
;

create function DBA.FCheckResStatusDate(
in In_ResStatusEffectiveDate date,
in In_PersonalSysId integer)
returns smallint
begin
  declare result smallint;
  set result=0;
  select 1 into result where In_ResStatusEffectiveDate = any(select ResStatusEffectiveDate from ResidenceStatusRecord where PersonalSysid = In_PersonalSysId);
  return result
end
;

create function dba.FGetBloodGroupType(
in In_BloodGroupId char(10))
returns char(50)
begin
  declare Out_BloodGroupType char(50);
  select BloodGroup.BloodGroupType into Out_BloodGroupType
    from BloodGroup where
    BloodGroup.BloodGroupId = In_BloodGroupId;
  return(Out_BloodGroupType)
end
;

create function dba.FGetBooleanIntegerString(
in booleanInteger smallint,
in TrueString char(30),
in FalseString char(30))
returns char(30)
begin
  declare outputString char(30);
  if booleanInteger > 0 then set outputString=TrueString
  else set outputString=FalseString
  end if;
  return(outputString)
end
;

create function dba.FGetBRProgNextIncDate(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns date
begin
  declare Out_PayGroupId char(20);
  declare Out_Date date;
  declare Out_BRProgNextIncDate date;
  select PayPayGroupId into Out_PayGroupId from PayPeriodRecord where Employeesysid = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and PayRecPeriod = In_PayRecPeriod;
  if Out_PayGroupId is null then
    select PayGroupId into Out_PayGroupId from PayEmployee where Employeesysid = In_EmployeeSysId
  end if;
  select first subperiodEnddate into Out_Date from
    PayGroupPeriod where PayGroupId = Out_PayGroupId and
    PayGroupYear = In_PayRecYear and PayGroupPeriod = In_PayRecPeriod order by SubPeriodEndDate desc;
  select first BRProgNextIncDate into Out_BRProgNextIncDate
    from BasicRateProgression where
    EmployeeSysId = In_EmployeeSysId and
    BRProgEffectiveDate <= Out_Date order by
    BRProgEffectiveDate desc;
  return(Out_BRProgNextIncDate)
end
;

create function dba.FGetCareerDesc(
in In_CareerId char(20))
returns char(100)
begin
  declare Out_CareerDesc char(100);
  select CareerDesc into Out_CareerDesc from career where
    CareerId = In_CareerId;
  if(Out_CareerDesc is null or Out_CareerDesc = '') then
    return(In_CareerId)
  else return(Out_CareerDesc)
  end if
end
;

create function dba.FGetCareerNewValueDesc(
in In_EmployeeSysId integer,
in In_CareerEffectiveDate date,
in In_CareerAttributeID char(20))
returns char(150)
begin
  declare Out_NewValueDescription char(150);
  declare NewValue char(150);
  select CareerNewValue into NewValue from CareerAttribute where
    CareerAttribute.EmployeeSysId = In_EmployeeSysId and
    CareerAttribute.CareerEffectiveDate = In_CareerEffectiveDate and
    CareerAttribute.CareerAttributeID = In_CareerAttributeID;
  if(In_CareerAttributeID = 'CareerBranch') then
    select BranchName into Out_NewValueDescription
      from Branch where Branch.BranchId = NewValue
  elseif(In_CareerAttributeID = 'CareerCategory') then
    select CategoryDesc into Out_NewValueDescription
      from Category where Category.CategoryId = NewValue
  elseif(In_CareerAttributeID = 'CareerDepartment') then
    select DepartmentDesc into Out_NewValueDescription
      from Department where Department.DepartmentId = NewValue
  elseif(In_CareerAttributeID = 'CareerPosition') then
    select PositionDesc into Out_NewValueDescription
      from PositionCode where PositionCode.PositionId = NewValue
  elseif(In_CareerAttributeID = 'CareerSection') then
    select SectionDesc into Out_NewValueDescription
      from Section where Section.SectionId = NewValue
  elseif(In_CareerAttributeID = 'CareerSupervisorID') then
    set Out_NewValueDescription=NewValue
  elseif(In_CareerAttributeID = 'CareerWTCalendar') then
    select WTCalendarDesc into Out_NewValueDescription
      from WTCalendar where WTCalendar.WTCalendarId = NewValue
  elseif(In_CareerAttributeID = 'SalaryGradeId') then
    select SalaryGradeDesc into Out_NewValueDescription
      from SalaryGrade where SalaryGradeId = NewValue
  elseif(In_CareerAttributeID = 'ClassificationCode') then
    select ClassificationDesc into Out_NewValueDescription
      from Classification where ClassificationCode = NewValue
  elseif(In_CareerAttributeID = 'EmpCode1Id') then
    select CustCodeDesc into Out_NewValueDescription
      from EmpCode1 where EmpCode1Id = NewValue
  elseif(In_CareerAttributeID = 'EmpCode2Id') then
    select CustCodeDesc into Out_NewValueDescription
      from EmpCode2 where EmpCode2Id = NewValue
  elseif(In_CareerAttributeID = 'EmpCode3Id') then
    select CustCodeDesc into Out_NewValueDescription
      from EmpCode3 where EmpCode3Id = NewValue
  elseif(In_CareerAttributeID = 'EmpCode4Id') then
    select CustCodeDesc into Out_NewValueDescription
      from EmpCode4 where EmpCode4Id = NewValue
  elseif(In_CareerAttributeID = 'EmpCode5Id') then
    select CustCodeDesc into Out_NewValueDescription
      from EmpCode5 where EmpCode5Id = NewValue
  elseif(In_CareerAttributeID = 'EmpLocation1Id') then
    select CustLocationDesc into Out_NewValueDescription
      from EmpLocation1 where EmpLocation1Id = NewValue
  end if;
  return(Out_NewValueDescription)
end
;

create function dba.FGetCategoryDesc(
in In_CategoryId char(20))
returns char(80)
begin
  declare Out_CategoryDesc char(80);
  select Category.CategoryDesc into Out_CategoryDesc
    from Category where
    Category.CategoryId = In_CategoryId;
  return(Out_CategoryDesc)
end
;

create function dba.FGetCessationDesc(
in In_CessationCode char(20))
returns char(100)
begin
  declare Out_CessationDesc char(100);
  select Cessation.CessationDesc into Out_CessationDesc
    from Cessation where
    Cessation.CessationCode = In_CessationCode;
  return(Out_CessationDesc)
end
;

create function dba.FGetCityName(
in In_CityId char(20))
returns char(60)
begin
  declare Out_CityName char(60);
  select City.CityName into Out_CityName
    from City where
    City.CityId = In_CityId;
  return(Out_CityName)
end
;

create function DBA.FGetCompanyContact(
in In_CompanyId char(20))
returns char(100)
begin
  declare Out_CompanyName char(100);
  select Company.CompanyContact into Out_CompanyName
    from Company where
    Company.CompanyId = In_CompanyId;
  return(Out_CompanyName)
end
;

create function DBA.FGetCompanyName(
in In_CompanyId char(20))
returns char(100)
begin
  declare Out_CompanyName char(100);
  select Company.CompanyName into Out_CompanyName
    from Company where
    Company.CompanyId = In_CompanyId;
  return(Out_CompanyName)
end
;

create function dba.FGetCompanyTypeDesc(
in In_CompanyTypeId char(20))
returns char(100)
begin
  declare Out_CompanyTypeDesc char(100);
  select CompanyType.CompanyTypeDesc into Out_CompanyTypeDesc
    from CompanyType where
    CompanyType.CompanyTypeId = In_CompanyTypeId;
  return(Out_CompanyTypeDesc)
end
;

create function DBA.FGetCompanyEmailAddress(
in In_CompanyId char(20))
returns char(30)
begin
  declare Out_CompanyEmailAddress char(30);
  select Company.CompanyEMailAddress into Out_CompanyEmailAddress
    from Company where
    Company.CompanyId = In_CompanyId;
  return(Out_CompanyEmailAddress)
end
;

create function DBA.FGetCompanyFax(
in In_CompanyId char(20))
returns char(30)
begin
  declare Out_CompanyFax char(30);
  select Company.CompanyFax into Out_CompanyFax
    from Company where
    Company.CompanyId = In_CompanyId;
  return(Out_CompanyFax)
end
;

create function dba.FGetConfirmationDue(
in In_EmployeeSysId integer)
returns date
begin
  declare Date_HireDate date;
  declare Int_ProbationPeriod integer;
  declare Char_ProbationUnit char(10);
  declare ConfirmationDue date;
  select Employee.HireDate,Employee.ProbationPeriod,Employee.ProbationUnit into Date_HireDate,
    Int_ProbationPeriod,
    Char_ProbationUnit from Employee where
    Employee.EmployeeSysId = In_EmployeeSysId;
  if(Char_ProbationUnit = 'Mth') then
    set ConfirmationDue=dateadd(month,Int_ProbationPeriod,Date_HireDate)
  else if(Char_ProbationUnit = 'Yrs') then
      set ConfirmationDue=dateadd(year,Int_ProbationPeriod,Date_HireDate)
    end if
  end if;
  return dateadd(day,-1,ConfirmationDue)
end
;

create function dba.FGetCountCalenLeavePattern(
in In_CalendarId char(20))
returns integer
begin
  declare Count_CalendarId integer;
  select COUNT(GroupLeavePattern.CalendarId) into Count_CalendarId
    from GroupLeavePattern where
    GroupLeavePattern.CalendarId = In_CalendarId;
  return(Count_CalendarId)
end
;

create function dba.FGetCountCalenWorkPattern(
in In_CalendarId char(20))
returns integer
begin
  declare Count_CalendarId integer;
  select COUNT(GroupWorkPattern.CalendarId) into Count_CalendarId
    from GroupWorkPattern where
    GroupWorkPattern.CalendarId = In_CalendarId;
  return(Count_CalendarId)
end
;

create function dba.FGetCountryName(
in In_CountryId char(20))
returns char(60)
begin
  declare Out_CountryName char(60);
  select Country.CountryName into Out_CountryName
    from Country where
    Country.CountryId = In_countryId;
  return(Out_CountryName)
end
;

create function dba.FGetCurrentCareerEffectiveDate(
in in_EmployeeSysID integer)
returns char(40)
begin
  declare output_CurrentDate date;
  select distinct CareerEffectiveDate into output_CurrentDate from CareerProgression where EmployeeSysID = in_EmployeeSysID and
    CareerCurrent = 1;
  return(output_CurrentDate)
end
;

create function DBA.FGetCurrentEmployment(
in In_PersonalSysId integer,
in In_YEYear integer)
returns integer
begin
  declare Out_EmployeeSysId integer;
  declare Out_LatestHireDate date;
  select max(FromDate) into Out_LatestHireDate from EmploymentHistory where
    PersonalSysID = In_PersonalSysId and
    YEYear = In_YEYear;
  select YEEmployeeSysID into Out_EmployeeSysId from EmploymentHistory where
    PersonalSysID = In_PersonalSysId and
    YEYear = In_YEYear and
    FromDate = Out_LatestHireDate;
  return(Out_EmployeeSysId)
end
;

create function dba.FGetDepartmentDesc(
in In_Department char(20))
returns char(100)
begin
  declare Out_DepartmentDesc char(100);
  select Department.DepartmentDesc into Out_DepartmentDesc
    from Department where
    Department.DepartmentId = In_Department;
  return(Out_DepartmentDesc)
end
;

create function dba.FGetEducationDesc(
in In_EducationId char(20))
returns char(80)
begin
  declare Out_EducationDesc char(80);
  select Education.EducationDesc into Out_EducationDesc
    from Education where
    Education.EducationId = In_EducationId;
  return(Out_EducationDesc)
end
;

create function dba.FGetEETerminationStatus(
in In_EmployeeSysID integer)
returns char(3)
begin
  declare fResult char(3);
  declare cessDate char(20);
  select FGetDateFormat(CessationDate) into cessDate from Employee where
    EmployeeSysID = In_EmployeeSysID;
  if cessDate = '' then set fResult='No'
  else set fResult='Yes'
  end if;
  return(fResult)
end
;

create function dba.FGetEmployeeAge(
in In_EmployeeSysId integer)
returns integer
begin
  declare Out_EmployeeAge integer;
  select Year(Now(*))-Year(Employee.DateOfBirth) into Out_EmployeeAge
    from Employee where
    Employee.EmployeeSysId = In_EmployeeSysId;
  return(Out_EmployeeAge)
end
;

create function DBA.FGetEmployeeBranch(
in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_BranchID char(30);
  select Employee.BranchID into Out_BranchID
    from Employee where
    Employee.EmployeeSysId = In_EmployeeSysId;
  return(Out_BranchID)
end
;

create function DBA.FGetEmployeeCurrentSalaryType(
in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_SalaryType char(30);
  select FGetKeyWordUserDefinedName(BasicRateProgression.BRProgBasicRateType) into Out_SalaryType from
    BasicRateProgression where
    BasicRateProgression.EmployeeSysId = In_EmployeeSysId and
    BRProgCurrent = 1;
  return(Out_SalaryType)
end
;

create function DBA.FGetEmployeeNamebyEmployeeID(
in In_EmployeeId char(30))
returns char(40)
begin
  declare Out_EmployeeName char(40);
  select Employee.EmployeeName into Out_EmployeeName
    from Employee where
    Employee.EmployeeId = In_EmployeeId;
  return(Out_EmployeeName)
end
;

create function DBA.FGetEmployeeSupervisor(
in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_SuperVisor char(30);
  select Employee.SuperVisor into Out_SuperVisor
    from Employee where
    Employee.EmployeeSysId = In_EmployeeSysId;
  return(Out_SuperVisor)
end
;

create function dba.FGetEmployeeSysId(
in In_EmployeeId char(30))
returns integer
begin
  declare Out_EmployeeSysId integer;
  select Employee.EmployeeSysId into Out_EmployeeSysId
    from Employee where
    Employee.EmployeeId = In_EmployeeId;
  return(Out_EmployeeSysId)
end
;

create function dba.FGetGenderDesc(
in In_GenderCodeId char(1))
returns char(30)
begin
  declare Out_GenderCodeName char(30);
  select GenderCode.GenderCodeName into Out_GenderCodeName
    from GenderCode where
    GenderCode.GenderCodeId = In_GenderCodeId;
  return(Out_GenderCodeName)
end
;

create function dba.FGetGeneratedId(
in In_AutoGenerationId char(20))
returns char(40)
begin
  declare Char_GeneratedId char(40);
  declare Char_PerFix char(5);
  declare Char_PostFix char(5);
  declare Int_AutoGenerationLength integer;
  declare Char_AutoGenerateLastGenNum char(30);
  declare Int_AutoGenerateNewLastGenNum integer;
  declare Char_AutoGenerateNewLastGenNum char(30);
  declare Length_Counter integer;
  select AutoGenerationKey.AutoGenerateLastGenNum,
    AutoGenerationKey.AutoGenerationLength,AutoGenerationKey.AutoGenerationPreFix,
    AutoGenerationKey.AutoGenerationPostFix into Char_AutoGenerateLastGenNum,
    Int_AutoGenerationLength,Char_PerFix,
    Char_PostFix from AutoGenerationKey where
    AutoGenerationKey.AutoGenerationId = In_AutoGenerationId;
  set Int_AutoGenerateNewLastGenNum=(convert(integer,Char_AutoGenerateLastGenNum)+1);
  set Char_AutoGenerateNewLastGenNum=convert(char,Int_AutoGenerateNewLastGenNum);
  set Length_Counter=Char_Length(Char_AutoGenerateNewLastGenNum);
  CharacterFormingLoop:
  while(Length_Counter < Int_AutoGenerationLength) loop
    set Char_AutoGenerateNewLastGenNum=INSERTSTR(0,Char_AutoGenerateNewLastGenNum,'0');
    set Length_Counter=Char_Length(Char_AutoGenerateNewLastGenNum)
  end loop CharacterFormingLoop;
  set Char_GeneratedId=INSERTSTR(0,Char_AutoGenerateNewLastGenNum,Char_PerFix);
  set Char_GeneratedId=INSERTSTR(0,Char_PostFix,Char_GeneratedId);
  update AutoGenerationKey set
    AutoGenerationKey.AutoGenerateLastGenNum = Char_AutoGenerateNewLastGenNum where
    AutoGenerationKey.AutoGenerationId = In_AutoGenerationId;
  commit work;
  return(Char_GeneratedId)
end
;

create function dba.FGetHighestEduCode(
in In_PersonalSysId integer)
returns char(80)
begin
  declare Out_EducationId char(20);
  select EducationId into Out_EducationId
    from EducationRec where
    PersonalSysId = In_PersonalSysId and
    EduHighest = 1;
  if Out_EducationId is null then set Out_EducationId=''
  end if;
  return(Out_EducationId)
end
;

create function dba.FGetIdentityTypeDesc(
in In_IdentityTypeId char(20))
returns char(60)
begin
  declare Out_IdentityTypeDesc char(60);
  select IdentityType.IdentityTypeDesc into Out_IdentityTypeDesc
    from IdentityType where
    IdentityType.IdentityTypeId = In_IdentityTypeId;
  return(Out_IdentityTypeDesc)
end
;

create function dba.FGetLeavePattern(
in In_CalendarId char(20),
in Date_ActualDate date,
in Int_WeekNo integer,
in Count_GroupLeavePattern integer)
returns numeric(8,4)
begin
  declare DayLeavePattern numeric(8,4);
  declare Int_GroupLeavePatternWeekNo integer;
  declare Char_LeaveWeekPatternNo char(20);
  if(MOD(Int_WeekNo,Count_GroupLeavePattern) = 0) then
    set Int_GroupLeavePatternWeekNo=Count_GroupLeavePattern
  else
    set Int_GroupLeavePatternWeekNo=MOD(Int_WeekNo,Count_GroupLeavePattern)
  end if;
  select GroupLeavePattern.WeekLeavePatternId into Char_LeaveWeekPatternNo
    from GroupLeavePattern where
    GroupLeavePattern.CalendarId = In_CalendarId and
    GroupLeavePattern.GroupLeavePatternWeekNo = Int_GroupLeavePatternWeekNo;
  case DOW(Date_ActualDate)
  when 1 then
    select WeekLeavePattern.LveSunday into DayLeavePattern
      from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = Char_LeaveWeekPatternNo
  when 2 then
    select WeekLeavePattern.LveMonday into DayLeavePattern
      from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = Char_LeaveWeekPatternNo
  when 3 then
    select WeekLeavePattern.LveTuesday into DayLeavePattern
      from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = Char_LeaveWeekPatternNo
  when 4 then
    select WeekLeavePattern.LveWenesday into DayLeavePattern
      from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = Char_LeaveWeekPatternNo
  when 5 then
    select WeekLeavePattern.LveThursday into DayLeavePattern
      from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = Char_LeaveWeekPatternNo
  when 6 then
    select WeekLeavePattern.LveFriday into DayLeavePattern
      from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = Char_LeaveWeekPatternNo
  when 7 then
    select WeekLeavePattern.LveSaturday into DayLeavePattern
      from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = Char_LeaveWeekPatternNo
  end case
  ;
  return(DayLeavePattern)
end
;

create function DBA.FGetLicenseCount()
returns integer
begin
  declare Out_EmployeeSysId integer;
  declare Out_CessationDate date;
  declare Out_LicenseCount integer;
  set Out_LicenseCount=0;
  PersonalLoop: for PersonalFor as Cur_Personal dynamic scroll cursor for
    select PersonalSysId as Out_PersonalSysId from
      Personal do
    set Out_EmployeeSysId=0;
    set Out_CessationDate=null;
    select first EmployeeSysId,CessationDate into Out_EmployeeSysId,
      Out_CessationDate from Employee where PersonalSysId = Out_PersonalSysId order by HireDate desc;
    if(Out_EmployeeSysId = 0 or Out_CessationDate = '1899-12-30') then set Out_LicenseCount=Out_LicenseCount+1
    end if end for;
  return Out_LicenseCount
end
;

create function DBA.FGetLicenseCountExceed(
in In_ExcludeEmployeeSysId integer)
returns integer
begin
  declare Out_EmployeeSysId integer;
  declare Out_CessationDate date;
  declare Out_LicenseCount integer;
  declare TotalLicenseCount integer;
  select NumKey1 into TotalLicenseCount from LicenseRecord;
  set Out_LicenseCount=0;
  PersonalLoop: for PersonalFor as Cur_Personal dynamic scroll cursor for
    select PersonalSysId as Out_PersonalSysId from
      Personal do
    set Out_EmployeeSysId=0;
    set Out_CessationDate=null;
    if(In_ExcludeEmployeeSysId <> Out_PersonalSysId) then
      select first EmployeeSysId,CessationDate into Out_EmployeeSysId,
        Out_CessationDate from Employee where PersonalSysId = Out_PersonalSysId order by HireDate desc;
      if(Out_EmployeeSysId = 0 or Out_CessationDate = '1899-12-30') then set Out_LicenseCount=Out_LicenseCount+1
      end if;
      if(Out_LicenseCount >= TotalLicenseCount) then return 1
      end if
    end if end for;
  return 0
end
;

create function dba.FGetMaritalStatusDesc(
in In_MaritalStatusCode char(10))
returns char(60)
begin
  declare Out_MaritalStatusDesc char(60);
  select MaritalStatus.MaritalStatusDesc into Out_MaritalStatusDesc
    from MaritalStatus where
    MaritalStatus.MaritalStatusCode = In_MaritalStatusCode;
  return(Out_MaritalStatusDesc)
end
;

create function DBA.FGetNationality(
in In_CountryId char(20))
returns char(60)
begin
  declare Out_CountryNationality char(60);
  select Country.CountryNationality into Out_CountryNationality
    from Country where 
    Country.CountryId = In_countryId;
  return(Out_CountryNationality)
end
;

create function dba.FGetNewLeavePattern(
in In_DateType char(20),
in In_WeekLeavePatternCode char(20))
returns numeric(8,4)
begin
  declare N84_LeavePattern numeric(8,4);
  case In_DateType when 'Sunday' then
    select WeekLeavePattern.LveSunday into N84_LeavePattern
      from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = In_WeekLeavePatternCode when 'Monday' then
    select WeekLeavePattern.LveMonday into N84_LeavePattern
      from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = In_WeekLeavePatternCode when 'Tuesday' then
    select WeekLeavePattern.LveTuesday into N84_LeavePattern
      from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = In_WeekLeavePatternCode when 'Wednesday' then
    select WeekLeavePattern.LveWenesday into N84_LeavePattern
      from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = In_WeekLeavePatternCode when 'Thursday' then
    select WeekLeavePattern.LveThursday into N84_LeavePattern
      from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = In_WeekLeavePatternCode when 'Friday' then
    select WeekLeavePattern.LveFriday into N84_LeavePattern
      from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = In_WeekLeavePatternCode when 'Saturday' then
    select WeekLeavePattern.LveSaturday into N84_LeavePattern
      from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = In_WeekLeavePatternCode
  end case
  ;
  return(N84_LeavePattern)
end
;

create function dba.FGetNewSGSPEmpNoGeneratedIndex(
in In_SGSPIndexGeneratorTbl char(200))
returns char(30)
begin
  declare Char_SGSPIndexGenCurrPreFix char(2);
  declare Int_SGSPIndexGenLastNum integer;
  declare Char_GeneratedIndex char(30);
  if not exists(select* from SGSPIndexGenerator where
      SGSPIndexGenerator.SGSPIndexGeneratorTbl = In_SGSPIndexGeneratorTbl) then
    set Int_SGSPIndexGenLastNum=1;
    set Char_SGSPIndexGenCurrPreFix='A';
    set Char_GeneratedIndex=INSERTSTR(0,convert(char,Int_SGSPIndexGenLastNum),
      Char_SGSPIndexGenCurrPreFix);
    insert into SGSPIndexGenerator(SGSPIndexGeneratorTbl,SGSPIndexGenCurrPreFix,SGSPIndexGenLastNum) values(
      In_SGSPIndexGeneratorTbl,Char_SGSPIndexGenCurrPreFix,Int_SGSPIndexGenLastNum);
    return(Char_GeneratedIndex)
  end if;
  select SGSPIndexGenerator.SGSPIndexGenCurrPreFix,
    SGSPIndexGenerator.SGSPIndexGenLastNum into Char_SGSPIndexGenCurrPreFix,
    Int_SGSPIndexGenLastNum from SGSPIndexGenerator where
    SGSPIndexGenerator.SGSPIndexGeneratorTbl = In_SGSPIndexGeneratorTbl;
  if(Int_SGSPIndexGenLastNum > 2147483646) then
    set Int_SGSPIndexGenLastNum=1;
    set Char_SGSPIndexGenCurrPreFix="CHAR"(ASCII(Char_SGSPIndexGenCurrPreFix)+1)
  else
    set Int_SGSPIndexGenLastNum=Int_SGSPIndexGenLastNum+1
  end if;
  set Char_GeneratedIndex=INSERTSTR(0,convert(char,Int_SGSPIndexGenLastNum),
    Char_SGSPIndexGenCurrPreFix);
  CheckNew:
  while exists(select* from Employee where Employee.EmployeeId = Char_GeneratedIndex) loop
    set Int_SGSPIndexGenLastNum=Int_SGSPIndexGenLastNum+1;
    set Char_GeneratedIndex=INSERTSTR(0,convert(char,Int_SGSPIndexGenLastNum),
      Char_SGSPIndexGenCurrPreFix)
  end loop CheckNew;
  update SGSPIndexGenerator set
    SGSPIndexGenerator.SGSPIndexGenCurrPreFix = Char_SGSPIndexGenCurrPreFix,
    SGSPIndexGenerator.SGSPIndexGenLastNum = Int_SGSPIndexGenLastNum where
    SGSPIndexGenerator.SGSPIndexGeneratorTbl = In_SGSPIndexGeneratorTbl;
  commit work;
  return(Char_GeneratedIndex)
end
;

create function dba.FGetNewSGSPGeneratedIndex(
in In_SGSPIndexGeneratorTbl char(200))
returns char(30)
begin
  declare Char_SGSPIndexGenCurrPreFix char(2);
  declare Int_SGSPIndexGenLastNum integer;
  declare Char_GeneratedIndex char(30);
  if not exists(select* from SGSPIndexGenerator where
      SGSPIndexGenerator.SGSPIndexGeneratorTbl = In_SGSPIndexGeneratorTbl) then
    set Int_SGSPIndexGenLastNum=1;
    set Char_SGSPIndexGenCurrPreFix='A';
    set Char_GeneratedIndex=INSERTSTR(0,convert(char,Int_SGSPIndexGenLastNum),
      Char_SGSPIndexGenCurrPreFix);
    insert into SGSPIndexGenerator(SGSPIndexGeneratorTbl,SGSPIndexGenCurrPreFix,SGSPIndexGenLastNum) values(
      In_SGSPIndexGeneratorTbl,Char_SGSPIndexGenCurrPreFix,Int_SGSPIndexGenLastNum);
    return(Char_GeneratedIndex)
  end if;
  select SGSPIndexGenerator.SGSPIndexGenCurrPreFix,
    SGSPIndexGenerator.SGSPIndexGenLastNum into Char_SGSPIndexGenCurrPreFix,
    Int_SGSPIndexGenLastNum from SGSPIndexGenerator where
    SGSPIndexGenerator.SGSPIndexGeneratorTbl = In_SGSPIndexGeneratorTbl;
  if(Int_SGSPIndexGenLastNum > 2147483646) then
    set Int_SGSPIndexGenLastNum=1;
    set Char_SGSPIndexGenCurrPreFix="CHAR"(ASCII(Char_SGSPIndexGenCurrPreFix)+1)
  else
    set Int_SGSPIndexGenLastNum=Int_SGSPIndexGenLastNum+1
  end if;
  set Char_GeneratedIndex=INSERTSTR(0,convert(char,Int_SGSPIndexGenLastNum),
    Char_SGSPIndexGenCurrPreFix);
  update SGSPIndexGenerator set
    SGSPIndexGenerator.SGSPIndexGenCurrPreFix = Char_SGSPIndexGenCurrPreFix,
    SGSPIndexGenerator.SGSPIndexGenLastNum = Int_SGSPIndexGenLastNum where
    SGSPIndexGenerator.SGSPIndexGeneratorTbl = In_SGSPIndexGeneratorTbl;
  return(Char_GeneratedIndex)
end
;

create function dba.FGetNewWorkPattern(
in In_DateType char(20),
in In_WeekWorkPatternCode char(20))
returns numeric(8,4)
begin
  declare N84_WorkPattern numeric(8,4);
  case In_DateType when 'Sunday' then
    select WeekWorkPattern.WWrkSun into N84_WorkPattern
      from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = In_WeekWorkPatternCode when 'Monday' then
    select WeekWorkPattern.WWrkMon into N84_WorkPattern
      from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = In_WeekWorkPatternCode when 'Tuesday' then
    select WeekWorkPattern.WWrkTue into N84_WorkPattern
      from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = In_WeekWorkPatternCode when 'Wednesday' then
    select WeekWorkPattern.WWrkWed into N84_WorkPattern
      from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = In_WeekWorkPatternCode when 'Thursday' then
    select WeekWorkPattern.WWrkThur into N84_WorkPattern
      from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = In_WeekWorkPatternCode when 'Friday' then
    select WeekWorkPattern.WWrkFri into N84_WorkPattern
      from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = In_WeekWorkPatternCode when 'Saturday' then
    select WeekWorkPattern.WWrkSat into N84_WorkPattern
      from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = In_WeekWorkPatternCode
  end case
  ;
  return(N84_WorkPattern)
end
;

create function DBA.FGetPersonalIdentityNo(
in In_PersonalSysId integer)
returns char(30)
begin
  declare Out_IdentityNo char(30);
  select Personal.IdentityNo into Out_IdentityNo
    from Personal where Personal.PersonalSysId = In_PersonalSysId;
  return(Out_IdentityNo)
end
;

create function DBA.FGetPersonalName(
in In_PersonalSysId integer)
returns char(40)
begin
  declare Out_PersonalName char(40);
  select Personal.PersonalName into Out_PersonalName
    from Personal where
    Personal.PersonalSysId = In_PersonalSysId;
  return(Out_PersonalName)
end
;

create function dba.FGetPersonalSysId(
in In_IdentityNo char(30))
returns char(30)
begin
  declare Out_PersonalSysId char(30);
  select Personal.PersonalSysId into Out_PersonalSysId
    from Personal where
    Personal.IdentityNo = In_IdentityNo;
  return(Out_PersonalSysId)
end
;

create function dba.FGetPositionDesc(
in In_PositionId char(20))
returns char(80)
begin
  declare Out_PositionDesc char(80);
  select PositionCode.PositionDesc into Out_PositionDesc
    from PositionCode where
    PositionCode.PositionId = In_PositionId;
  return(Out_PositionDesc)
end
;

create function dba.FGetRaceDesc(
in In_RaceId char(20))
returns char(60)
begin
  declare Out_RaceDesc char(60);
  select Race.RaceDesc into Out_RaceDesc
    from Race where
    Race.RaceId = In_RaceId;
  return(Out_RaceDesc)
end
;

create function dba.FGetReligionDesc(
in In_ReligionId char(20))
returns char(60)
begin
  declare Out_ReligionType char(60);
  select Religion.ReligionType into Out_ReligionType
    from Religion where
    Religion.ReligionId = In_ReligionId;
  return(Out_ReligionType)
end
;

create function DBA.FGetResidenceTypeDesc(
in In_ResidenceTypeId char(20))
returns char(100)
begin
  declare Out_ResidenceTypeDesc char(100);
  select ResidenceType.ResidenceTypeDesc into Out_ResidenceTypeDesc
    from ResidenceType where
    ResidenceType.ResidenceTypeId = In_ResidenceTypeId;
  return(Out_ResidenceTypeDesc)
end
;

create function dba.FGetRetirementDue(
in In_EmployeeSysId integer)
returns date
begin
  declare Int_RetirementAge integer;
  declare Date_DateOfBirth date;
  declare RetirementDue date;
  select DateOfBirth,RetirementAge into Date_DateOfBirth,
    Int_RetirementAge from EMPLOYEE where
    Employee.EmployeeSysId = In_EmployeeSysId;
  set RetirementDue=dateadd(year,Int_RetirementAge,Date_DateOfBirth);
  return dateadd(day,-1,RetirementDue)
end
;

create function dba.FGetSectionDesc(
in In_SectionId char(20))
returns char(80)
begin
  declare Out_SectionDesc char(80);
  select Section.SectionDesc into Out_SectionDesc
    from Section where
    Section.SectionId = In_SectionId;
  return(Out_SectionDesc)
end
;

create function dba.FGetStateName(
in In_StateId char(20))
returns char(60)
begin
  declare Out_StateName char(60);
  select State.StateName into Out_StateName
    from State where
    State.StateId = In_StateId;
  return(Out_StateName)
end
;

create function dba.FGetTitleCodeDesc(
in In_TitleId char(20))
returns char(60)
begin
  declare Out_TitleDesc char(60);
  select TitleCode.TitleDesc into Out_TitleDesc
    from TitleCode where
    TitleCode.TitleId = In_TitleId;
  return(Out_TitleDesc)
end
;

create function dba.FGetWeekLeavePattern(
in In_CalendarId char(20),
in Int_WeekNo integer,
in Count_GroupLeavePattern integer)
returns char(20)
begin
  declare Int_GroupLeavePatternWeekNo integer;
  declare Char_WeekLeavePatternId char(20);
  if(MOD(Int_WeekNo,Count_GroupLeavePattern) = 0) then
    set Int_GroupLeavePatternWeekNo=Count_GroupLeavePattern
  else
    set Int_GroupLeavePatternWeekNo=MOD(Int_WeekNo,Count_GroupLeavePattern)
  end if;
  select GroupLeavePattern.WeekLeavePatternId into Char_WeekLeavePatternId
    from GroupLeavePattern where
    GroupLeavePattern.CalendarId = In_CalendarId and
    GroupLeavePattern.GroupLeavePatternWeekNo = Int_GroupLeavePatternWeekNo;
  return(Char_WeekLeavePatternId)
end
;

create function dba.FGetWeekPatternDayDesc(
in In_FullDesc smallint,
in In_day double)
returns char(20)
begin
  if(In_FullDesc = 0) then
    if(In_day = 0) then return 'O'
    end if;
    if(In_day = .25) then return 'Q'
    end if;
    if(In_day = .5) then return 'H'
    end if;
    if(In_day = 1) then return 'F'
    end if
  else if(In_day = 0) then return 'OFF'
    end if;
    if(In_day = .25) then return 'Quarter'
    end if;
    if(In_day = .5) then return 'Half'
    end if;
    if(In_day = 1) then return 'Full'
    end if
  end if end
;

create function dba.FGetWeekWorkPattern(
in In_CalendarId char(20),
in Int_WeekNo integer,
in Count_GroupWorkPattern integer)
returns char(20)
begin
  declare Int_GroupWorkPatternWeekNo integer;
  declare Char_WeekPatternId char(20);
  if(MOD(Int_WeekNo,Count_GroupWorkPattern) = 0) then
    set Int_GroupWorkPatternWeekNo=Count_GroupWorkPattern
  else
    set Int_GroupWorkPatternWeekNo=MOD(Int_WeekNo,Count_GroupWorkPattern)
  end if;
  select GroupWorkPattern.WeekPatternId into Char_WeekPatternId
    from GroupWorkPattern where
    GroupWorkPattern.CalendarId = In_CalendarId and
    GroupWorkPattern.GroupWorkPatternWeekNo = Int_GroupWorkPatternWeekNo;
  return(Char_WeekPatternId)
end
;

create function dba.FGetWorkPattern(
in In_CalendarId char(20),
in Date_ActualDate date,
in Int_WeekNo integer,
in Count_GroupWorkPattern integer)
returns numeric(8,4)
begin
  declare DayWorkPattern numeric(8,4);
  declare Char_WorkWeekPatternNo char(20);
  declare Int_GroupWorkPatternWeekNo integer;
  if(MOD(Int_WeekNo,Count_GroupWorkPattern) = 0) then
    set Int_GroupWorkPatternWeekNo=Count_GroupWorkPattern
  else
    set Int_GroupWorkPatternWeekNo=MOD(Int_WeekNo,Count_GroupWorkPattern)
  end if;
  select GroupWorkPattern.WeekPatternId into Char_WorkWeekPatternNo
    from GroupWorkPattern where
    GroupWorkPattern.CalendarId = In_CalendarId and
    GroupWorkPattern.GroupWorkPatternWeekNo = Int_GroupWorkPatternWeekNo;
  case DOW(Date_ActualDate)
  when 1 then
    select WeekWorkPattern.WWrkSun into DayWorkPattern
      from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = Char_WorkWeekPatternNo
  when 2 then
    select WeekWorkPattern.WWrkMon into DayWorkPattern
      from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = Char_WorkWeekPatternNo
  when 3 then
    select WeekWorkPattern.WWrkTue into DayWorkPattern
      from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = Char_WorkWeekPatternNo
  when 4 then
    select WeekWorkPattern.WWrkWed into DayWorkPattern
      from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = Char_WorkWeekPatternNo
  when 5 then
    select WeekWorkPattern.WWrkThur into DayWorkPattern
      from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = Char_WorkWeekPatternNo
  when 6 then
    select WeekWorkPattern.WWrkFri into DayWorkPattern
      from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = Char_WorkWeekPatternNo
  when 7 then
    select WeekWorkPattern.WWrkSat into DayWorkPattern
      from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = Char_WorkWeekPatternNo
  end case
  ;
  return(DayWorkPattern)
end
;

create function dba.FGetYesNoDesc(
in In_YNCode smallint)
returns char(5)
begin
  declare Out_YesNo char(5);
  if(In_YNCode = 1) then
    set Out_YesNo='Yes'
  else
    set Out_YesNo='No'
  end if;
  return(Out_YesNo)
end
;

create function dba.FSearchEmployeeId(
in In_EmployeeId char(30))
returns integer
begin
  if exists(select* from Employee where
      Employee.EmployeeId = In_EmployeeId) then
    return(1)
  else
    return(0)
  end if
end
;

create function dba.FSearchEmployeeSysIdHired(
in In_EmployeeId char(30),
in In_EmployeeName char(150))
returns integer
begin
  declare EmpSysId integer;
  if exists(select* from Employee where
      Employee.EmployeeId = In_EmployeeId and
      Employee.EmployeeName = In_EmployeeName and
      Employee.CessationDate = null) then
    select Employee.EmployeeSysId into EmpSysId
      from Employee where
      Employee.EmployeeId = In_EmployeeId and
      Employee.EmployeeName = In_EmployeeName and
      Employee.CessationDate = null
  else
    set EmpSysId=0
  end if;
  return(EmpSysId)
end
;

create procedure dba.GlbChangeBloodGroupId(
in In_NewBloodGroupId char(20),
in In_NewBloodGroupDesc char(60))
begin
  if not exists(select* from BloodGroup where
      BloodGroup.BloodGroupId = In_NewBloodGroupId) then
    call InsertNewBloodGroup(In_NewBloodGroupId,In_NewBloodGroupDesc)
  end if;
  if exists(select* from GlbChangeFilterRec) then
    update Personal,GlbChangeFilterRec set
      Personal.BloodGroupId = In_NewBloodGroupId where
      Personal.PersonalSysId = GlbChangeFilterRec.GCPersonalSysId
  else
    update Personal set
      Personal.BloodGroupId = In_NewBloodGroupId
  end if;
  commit work
end
;

create procedure dba.GlbChangeBranchCode(
in In_CompanyId char(20),
in In_NewBranchCode char(20))
begin
  declare Out_CareerEffectiveDate date;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.BranchId = In_NewBranchCode,
      Employee.CompanyId = In_CompanyId where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
    BranchLoop: for BranchFor as curs dynamic scroll cursor for
      select GCEmployeeSysId as Out_GCEmpoyeeSysId from GlbChangeFilterRec do
      select CareerEffectiveDate into Out_CareerEffectiveDate from CareerProgression where
        EmployeeSysId = Out_GCEmpoyeeSysId and CareerCurrent = 1;
      update CareerAttribute set
        CareerNewValue = In_NewBranchCode where CareerAttributeId = 'CareerBranch' and
        CareerEffectiveDate = Out_CareerEffectiveDate end for
  end if;
  commit work
end
;

create procedure dba.GlbChangeCategoryId(
in In_NewCategoryId char(20),
in In_NewCategoryDesc char(60))
begin
  declare Out_CareerEffectiveDate date;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.CategoryId = In_NewCategoryId where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
    CategoryLoop: for CategoryFor as curs dynamic scroll cursor for
      select GCEmployeeSysId as Out_GCEmpoyeeSysId from GlbChangeFilterRec do
      select CareerEffectiveDate into Out_CareerEffectiveDate from CareerProgression where
        EmployeeSysId = Out_GCEmpoyeeSysId and CareerCurrent = 1;
      update CareerAttribute set
        CareerNewValue = In_NewCategoryId where CareerAttributeId = 'CareerCategory' and
        CareerEffectiveDate = Out_CareerEffectiveDate end for
  end if;
  commit work
end
;

create procedure dba.GlbChangeCessationCode(
in In_NewCessationCode char(20),
in In_NewCessationDesc char(60))
begin
  if not exists(select* from Cessation where
      Cessation.CessationCode = In_NewCessationCode) then
    call InsertNewCessation(In_NewCessationCode,In_NewCessationDesc)
  end if;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.CessationCode = In_NewCessationCode where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId
  else
    update Employee set
      Employee.CessationCode = In_NewCessationCode
  end if;
  commit work
end
;

create procedure dba.GlbChangeCessationDate(
in In_NewCessationDate date)
begin
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.CessationDate = In_NewCessationDate where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId
  else
    update Employee set
      Employee.CessationDate = In_NewCessationDate
  end if;
  commit work
end
;

create procedure dba.GlbChangeClassification(
in In_NewClassificationCode char(20),
in In_NewClassificationDesc char(60))
begin
  declare Out_CareerEffectiveDate date;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.ClassificationCode = In_NewClassificationCode where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
    ClassificationLoop: for ClassificationFor as curs dynamic scroll cursor for
      select GCEmployeeSysId as Out_GCEmpoyeeSysId from GlbChangeFilterRec do
      select CareerEffectiveDate into Out_CareerEffectiveDate from CareerProgression where
        EmployeeSysId = Out_GCEmpoyeeSysId and CareerCurrent = 1;
      update CareerAttribute set
        CareerNewValue = In_NewClassificationCode where CareerAttributeId = 'ClassificationCode' and
        CareerEffectiveDate = Out_CareerEffectiveDate end for
  end if;
  commit work
end
;

create procedure dba.GlbChangeConfirmationDate(
in In_NewConfirmationDate date)
begin
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.ConfirmationDate = In_NewConfirmationDate where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId
  else
    update Employee set
      Employee.ConfirmationDate = In_NewConfirmationDate
  end if;
  commit work
end
;

create procedure dba.GlbChangeCountryOfBirth(
in In_CountryId char(10),
in In_CountryName char(60))
begin
  declare In_CountryTelCode char(20);
  declare In_CountryCurrency char(20);
  declare In_CountryNationality char(100);
  set In_CountryTelCode='';
  set In_CountryCurrency='';
  set In_CountryNationality='';
  if not exists(select* from Country where
      Country.CountryId = In_CountryId) then
    call InsertNewCountry(In_CountryId,In_CountryName,
    In_CountryTelCode,In_CountryNationality,In_CountryCurrency)
  end if;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.CountryOfBirth = In_CountryId where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
    update Personal,GlbChangeFilterRec set
      Personal.CountryOfBirth = In_CountryId where
      Personal.PersonalSysId = GlbChangeFilterRec.GCPersonalSysId
  else
    update Employee set
      Employee.CountryOfBirth = In_CountryId;
    update Personal set
      Personal.CountryOfBirth = In_CountryId
  end if;
  commit work
end
;

create procedure dba.GlbChangeDepartmentId(
in In_NewDepartmentId char(20),
in In_NewDepartmentDesc char(60))
begin
  declare Out_CareerEffectiveDate date;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.DepartmentId = In_NewDepartmentId where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
    DepartmentLoop: for DepartmentFor as curs dynamic scroll cursor for
      select GCEmployeeSysId as Out_GCEmpoyeeSysId from GlbChangeFilterRec do
      select CareerEffectiveDate into Out_CareerEffectiveDate from CareerProgression where
        EmployeeSysId = Out_GCEmpoyeeSysId and CareerCurrent = 1;
      update CareerAttribute set
        CareerNewValue = In_NewDepartmentId where CareerAttributeId = 'CareerDepartment' and
        CareerEffectiveDate = Out_CareerEffectiveDate end for
  end if;
  commit work
end
;

create procedure dba.GlbChangeEducationId(
in In_NewEducationId char(20),
in In_NewEducationDesc char(60))
begin
  if not exists(select* from Education where
      Education.EducationId = In_NewEducationId) then
    call InsertNewEducation(In_NewEducationId,In_NewEducationDesc)
  end if;
  if exists(select* from GlbChangeFilterRec) then
    update EducationRecord,GlbChangeFilterRec set
      EducationRecord.EducationId = In_NewEducationId where
      EducationRecord.PersonalSysId = GlbChangeFilterRec.GCPersonalSysId
  else
    update EducationRecord,GlbChangeFilterRec set
      EducationRecord.EducationId = In_NewEducationId
  end if;
  commit work
end
;

create procedure dba.GlbChangeEmpCode1Id(
in In_NewEmpCode1Id char(20),
in In_NewCustCodeDesc char(60))
begin
  declare Out_CareerEffectiveDate date;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.EmpCode1Id = In_NewEmpCode1Id where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
    EmpCode1IdLoop: for EmpCode1For as curs dynamic scroll cursor for
      select GCEmployeeSysId as Out_GCEmpoyeeSysId from GlbChangeFilterRec do
      select CareerEffectiveDate into Out_CareerEffectiveDate from CareerProgression where
        EmployeeSysId = Out_GCEmpoyeeSysId and CareerCurrent = 1;
      update CareerAttribute set
        CareerNewValue = In_NewEmpCode1Id where CareerAttributeId = 'EmpCode1Id' and
        CareerEffectiveDate = Out_CareerEffectiveDate end for
  end if;
  commit work
end
;

create procedure dba.GlbChangeEmpCode2Id(
in In_NewEmpCode2Id char(20),
in In_NewCustCodeDesc char(60))
begin
  declare Out_CareerEffectiveDate date;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.EmpCode2Id = In_NewEmpCode2Id where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
    EmpCode2IdLoop: for EmpCode2For as curs dynamic scroll cursor for
      select GCEmployeeSysId as Out_GCEmpoyeeSysId from GlbChangeFilterRec do
      select CareerEffectiveDate into Out_CareerEffectiveDate from CareerProgression where
        EmployeeSysId = Out_GCEmpoyeeSysId and CareerCurrent = 1;
      update CareerAttribute set
        CareerNewValue = In_NewEmpCode2Id where CareerAttributeId = 'EmpCode2Id' and
        CareerEffectiveDate = Out_CareerEffectiveDate end for
  end if;
  commit work
end
;

create procedure dba.GlbChangeEmpCode3Id(
in In_NewEmpCode3Id char(20),
in In_NewCustCodeDesc char(60))
begin
  declare Out_CareerEffectiveDate date;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.EmpCode3Id = In_NewEmpCode3Id where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
    EmpCode3IdLoop: for EmpCode3For as curs dynamic scroll cursor for
      select GCEmployeeSysId as Out_GCEmpoyeeSysId from GlbChangeFilterRec do
      select CareerEffectiveDate into Out_CareerEffectiveDate from CareerProgression where
        EmployeeSysId = Out_GCEmpoyeeSysId and CareerCurrent = 1;
      update CareerAttribute set
        CareerNewValue = In_NewEmpCode3Id where CareerAttributeId = 'EmpCode3Id' and
        CareerEffectiveDate = Out_CareerEffectiveDate end for
  end if;
  commit work
end
;

create procedure dba.GlbChangeEmpCode4Id(
in In_NewEmpCode4Id char(20),
in In_NewCustCodeDesc char(60))
begin
  declare Out_CareerEffectiveDate date;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.EmpCode4Id = In_NewEmpCode4Id where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
    EmpCode4IdLoop: for EmpCode4For as curs dynamic scroll cursor for
      select GCEmployeeSysId as Out_GCEmpoyeeSysId from GlbChangeFilterRec do
      select CareerEffectiveDate into Out_CareerEffectiveDate from CareerProgression where
        EmployeeSysId = Out_GCEmpoyeeSysId and CareerCurrent = 1;
      update CareerAttribute set
        CareerNewValue = In_NewEmpCode4Id where CareerAttributeId = 'EmpCode4Id' and
        CareerEffectiveDate = Out_CareerEffectiveDate end for
  end if;
  commit work
end
;

create procedure dba.GlbChangeEmpCode5Id(
in In_NewEmpCode5Id char(20),
in In_NewCustCodeDesc char(60))
begin
  declare Out_CareerEffectiveDate date;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.EmpCode5Id = In_NewEmpCode5Id where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
    EmpCode5IdLoop: for EmpCode5For as curs dynamic scroll cursor for
      select GCEmployeeSysId as Out_GCEmpoyeeSysId from GlbChangeFilterRec do
      select CareerEffectiveDate into Out_CareerEffectiveDate from CareerProgression where
        EmployeeSysId = Out_GCEmpoyeeSysId and CareerCurrent = 1;
      update CareerAttribute set
        CareerNewValue = In_NewEmpCode5Id where CareerAttributeId = 'EmpCode5Id' and
        CareerEffectiveDate = Out_CareerEffectiveDate end for
  end if;
  commit work
end
;

create procedure dba.GlbChangeEmpLocation1Id(
in In_NewEmpLocation1Id char(20),
in In_NewCustLocationDesc char(60))
begin
  declare Out_CareerEffectiveDate date;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.EmpLocation1Id = In_NewEmpLocation1Id where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
    EmpLocation1IdLoop: for EmpLocation1For as curs dynamic scroll cursor for
      select GCEmployeeSysId as Out_GCEmpoyeeSysId from GlbChangeFilterRec do
      select CareerEffectiveDate into Out_CareerEffectiveDate from CareerProgression where
        EmployeeSysId = Out_GCEmpoyeeSysId and CareerCurrent = 1;
      update CareerAttribute set
        CareerNewValue = In_NewEmpLocation1Id where CareerAttributeId = 'EmpLocation1Id' and
        CareerEffectiveDate = Out_CareerEffectiveDate end for
  end if;
  commit work
end
;

create procedure dba.GlbChangeEmploymentStatusId(
in In_NewEmploymentStatusId char(20),
in In_NewEmploymentStatusDesc char(60))
begin
  if not exists(select* from EmploymentStatus where
      EmploymentStatus.EmpStatusId = In_NewEmploymentStatusId) then
    call InsertNewEmploymentStatus(In_NewEmploymentStatusId,In_NewEmploymentStatusDesc)
  end if;
  if exists(select* from GlbChangeFilterRec) then
    update Personal,GlbChangeFilterRec set
      Personal.EmpStatusId = In_NewEmploymentStatusId where
      Personal.PersonalSysId = GlbChangeFilterRec.GCPersonalSysId
  else
    update Personal set
      Personal.EmpStatusId = In_NewEmploymentStatusId
  end if;
  commit work
end
;

create procedure dba.GlbChangeEmpRetirementAge(
in In_NewRetirementAge integer)
begin
  update Employee,GlbChangeFilterRec set
    Employee.RetirementAge = In_NewRetirementAge where
    Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
  commit work
end
;

create procedure dba.GlbChangeHireDate(
in In_NewHireDate date)
begin
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.HireDate = In_NewHireDate where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId
  else
    update Employee set
      Employee.HireDate = In_NewHireDate
  end if;
  commit work
end
;

create procedure dba.GlbChangeIdentityTypeId(
in In_NewIdentityTypeId char(20),
in In_NewIdentityTypeDesc char(60))
begin
  if not exists(select* from IdentityType where
      IdentityType.IdentityTypeId = In_NewIdentityTypeId) then
    call InsertNewIdentityType(In_NewIdentityTypeId,In_NewIdentityTypeDesc)
  end if;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.IdentityTypeCode = In_NewIdentityTypeId where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
    update Personal,GlbChangeFilterRec set
      Personal.IdentityTypeId = In_NewIdentityTypeId where
      Personal.PersonalSysId = GlbChangeFilterRec.GCPersonalSysId
  else
    update Employee set
      Employee.IdentityTypeCode = In_NewIdentityTypeId;
    update Personal set
      Personal.IdentityTypeId = In_NewIdentityTypeId
  end if;
  commit work
end
;

create procedure dba.GlbChangeIsSupervisor(
in In_NewIsSupervisor integer)
begin
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.IsSupervisor = In_NewIsSupervisor where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId
  else
    update Employee,GlbChangeFilterRec set
      Employee.IsSupervisor = In_NewIsSupervisor
  end if;
  commit work
end
;

create procedure dba.GlbChangeMaritalStatusCode(
in In_NewMaritalStatusCode char(20),
in In_NewMaritalStatusDesc char(60))
begin
  if not exists(select* from MaritalStatus where
      MaritalStatus.MaritalStatusCode = In_NewMaritalStatusCode) then
    call InsertNewMaritalStatus(In_NewMaritalStatusCode,In_NewMaritalStatusDesc)
  end if;
  if exists(select* from GlbChangeFilterRec) then
    update Personal,GlbChangeFilterRec set
      Personal.MaritalStatusCode = In_NewMaritalStatusCode where
      Personal.PersonalSysId = GlbChangeFilterRec.GCPersonalSysId;
    update Employee,GlbChangeFilterRec set
      Employee.MaritalStatusCode = In_NewMaritalStatusCode where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId
  else
    update Employee set
      Employee.MaritalStatusCode = In_NewMaritalStatusCode;
    update Personal set
      Personal.MaritalStatusCode = In_NewMaritalStatusCode
  end if;
  commit work
end
;

create procedure dba.GlbChangeNationality(
in In_CountryId char(10),
in In_CountryName char(60),
in In_CountryNationality char(100))
begin
  declare In_CountryTelCode char(20);
  declare In_CountryCurrency char(20);
  set In_CountryTelCode='';
  set In_CountryCurrency='';
  if not exists(select* from Country where
      Country.CountryId = In_CountryId and
      Country.CountryNationality = In_CountryNationality) then
    call InsertNewCountry(In_CountryId,In_CountryName,
    In_CountryTelCode,In_CountryNationality,In_CountryCurrency)
  end if;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.Nationality = In_CountryNationality where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
    update Personal,GlbChangeFilterRec set
      Personal.Nationality = In_CountryNationality where
      Personal.PersonalSysId = GlbChangeFilterRec.GCPersonalSysId
  else
    update Employee set
      Employee.Nationality = In_CountryNationality;
    update Personal set
      Personal.Nationality = In_CountryNationality
  end if;
  commit work
end
;

create procedure dba.GlbChangePositionCode(
in In_NewPositionId char(20),
in In_NewPositionDesc char(60))
begin
  declare Out_CareerEffectiveDate date;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.PositionId = In_NewPositionId where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
    PositionLoop: for PositionFor as curs dynamic scroll cursor for
      select GCEmployeeSysId as Out_GCEmpoyeeSysId from GlbChangeFilterRec do
      select CareerEffectiveDate into Out_CareerEffectiveDate from CareerProgression where
        EmployeeSysId = Out_GCEmpoyeeSysId and CareerCurrent = 1;
      update CareerAttribute set
        CareerNewValue = In_NewPositionId where CareerAttributeId = 'CareerPosition' and
        CareerEffectiveDate = Out_CareerEffectiveDate end for
  end if;
  commit work
end
;

create procedure dba.GlbChangeProbationPeriod(
in In_NewProbationPeriod integer)
begin
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.ProbationPeriod = In_NewProbationPeriod where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId
  else
    update Employee set
      Employee.ProbationPeriod = In_NewProbationPeriod
  end if;
  commit work
end
;

create procedure dba.GlbChangeProbationUnit(
in In_NewProbationUnit char(10))
begin
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.ProbationUnit = In_NewProbationUnit where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId
  else
    update Employee set
      Employee.ProbationUnit = In_NewProbationUnit
  end if;
  commit work
end
;

create procedure dba.GlbChangeRaceId(
in In_NewRaceId char(20),
in In_NewRaceDesc char(60))
begin
  if not exists(select* from Race where
      Race.RaceId = In_NewRaceId) then
    call InsertNewRace(In_NewRaceId,In_NewRaceDesc)
  end if;
  if exists(select* from GlbChangeFilterRec) then
    update Personal,GlbChangeFilterRec set
      Personal.RaceId = In_NewRaceId where
      Personal.PersonalSysId = GlbChangeFilterRec.GCPersonalSysId;
    update Employee,GlbChangeFilterRec set
      Employee.RaceId = In_NewRaceId where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId
  else
    update Employee set
      Employee.RaceId = In_NewRaceId;
    update Personal set
      Personal.RaceId = In_NewRaceId
  end if;
  commit work
end
;

create procedure dba.GlbChangeReligionId(
in In_NewReligionId char(20),
in In_NewReligionDesc char(60))
begin
  if not exists(select* from Religion where
      Religion.ReligionId = In_NewReligionId) then
    call InsertNewReligion(In_NewReligionId,In_NewReligionDesc)
  end if;
  if exists(select* from GlbChangeFilterRec) then
    update Personal,GlbChangeFilterRec set
      Personal.ReligionID = In_NewReligionId where
      Personal.PersonalSysId = GlbChangeFilterRec.GCPersonalSysId;
    update Employee,GlbChangeFilterRec set
      Employee.ReligionID = In_NewReligionId where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId
  else
    update Employee set
      Employee.ReligionID = In_NewReligionId;
    update Personal set
      Personal.ReligionID = In_NewReligionId
  end if;
  commit work
end
;

create procedure dba.GlbChangeRetirementDate(
in In_NewRetirementDate date)
begin
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.RetirementDate = In_NewRetirementDate where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId
  else
    update Employee set
      Employee.RetirementDate = In_NewRetirementDate
  end if;
  commit work
end
;

create procedure dba.GlbChangeSalaryGrade(
in In_NewSalaryGradeId char(20),
in In_NewSalaryGradeDesc char(60))
begin
  declare Out_CareerEffectiveDate date;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.SalaryGradeId = In_NewSalaryGradeId where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
    SalaryGradeLoop: for SalaryGradeFor as curs dynamic scroll cursor for
      select GCEmployeeSysId as Out_GCEmpoyeeSysId from GlbChangeFilterRec do
      select CareerEffectiveDate into Out_CareerEffectiveDate from CareerProgression where
        EmployeeSysId = Out_GCEmpoyeeSysId and CareerCurrent = 1;
      update CareerAttribute set
        CareerNewValue = In_NewSalaryGradeId where CareerAttributeId = 'SalaryGradeId' and
        CareerEffectiveDate = Out_CareerEffectiveDate end for
  end if;
  commit work
end
;

create procedure dba.GlbChangeSectionId(
in In_NewSectionId char(20),
in In_NewSectionDesc char(60))
begin
  declare Out_CareerEffectiveDate date;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.SectionId = In_NewSectionId where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
    SectionLoop: for SectionFor as curs dynamic scroll cursor for
      select GCEmployeeSysId as Out_GCEmpoyeeSysId from GlbChangeFilterRec do
      select CareerEffectiveDate into Out_CareerEffectiveDate from CareerProgression where
        EmployeeSysId = Out_GCEmpoyeeSysId and CareerCurrent = 1;
      update CareerAttribute set
        CareerNewValue = In_NewSectionId where CareerAttributeId = 'CareerSection' and
        CareerEffectiveDate = Out_CareerEffectiveDate end for
  end if;
  commit work
end
;

create procedure dba.GlbChangeSupervisor(
in In_NewSupervisor char(30))
begin
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.Supervisor = In_NewSupervisor where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId
  else
    update Employee,GlbChangeFilterRec set
      Employee.Supervisor = In_NewSupervisor
  end if;
  commit work
end
;

create procedure dba.GlbChangeTitleId(
in In_NewTitleId char(20),
in In_NewTitleDesc char(60))
begin
  if not exists(select* from Title where
      Title.TitleId = In_NewTitleId) then
    call InsertNewTitle(In_NewTitleId,In_NewTitleDesc)
  end if;
  if exists(select* from GlbChangeFilterRec) then
    update Employee,GlbChangeFilterRec set
      Employee.TitleId = In_NewTitleId where
      Employee.EmployeeSysId = GlbChangeFilterRec.GCEmployeeSysId;
    update Personal,GlbChangeFilterRec set
      Personal.TitleId = In_NewTitleId where
      Personal.PersonalSysId = GlbChangeFilterRec.GCPersonalSysId
  else
    update Employee set
      Employee.TitleId = In_NewTitleId;
    update Personal set
      Personal.TitleId = In_NewTitleId
  end if;
  commit work
end
;

create procedure dba.InsertNewAdHocQueryFields(
in In_QueryRecId char(60),
in In_FieldsName char(100),
in In_EntityName char(100),
in In_QueryNotCondition smallint,
in In_QueryFromCondition char(50),
in In_QueryToCondition char(50),
in In_QueryDateFrom date,
in In_QueryDateTo date,
in In_QueryValueFrom double,
in In_QueryValueTo double)
begin
  if not exists(select* from AdHocQueryFields where
      AdHocQueryFields.QueryRecId = In_QueryRecId and
      AdHocQueryFields.FieldsName = In_FieldsName and
      AdHocQueryFields.EntityName = In_EntityName) then
    insert into AdHocQueryFields(QueryRecId,FieldsName,
      EntityName,
      QueryNotCondition,
      QueryFromCondition,
      QueryToCondition,
      QueryDateFrom,
      QueryDateTo,
      QueryValueFrom,
      QueryValueTo) values(
      In_QueryRecId,In_FieldsName,In_EntityName,
      In_QueryNotCondition,
      In_QueryFromCondition,
      In_QueryToCondition,
      In_QueryDateFrom,
      In_QueryDateTo,
      In_QueryValueFrom,
      In_QueryValueTo);
    commit work
  end if
end
;

create procedure dba.InsertNewAdHocQueryRec(
in In_QueryRecId char(60),
in In_UserId char(20),
in In_QueryType char(1),
in In_CustomQuery char(8192),
in In_QueryRecDesc char(150),
in In_SecurityQueryType char(1),
in In_CustomQueryEntities char(200))
begin
  if not exists(select* from AdHocQueryRec where
      AdHocQueryRec.QueryRecId = In_QueryRecId) then
    insert into AdHocQueryRec(QueryRecId,UserId,
      QueryType,CustomQuery,QueryRecDesc,
      SecurityQueryType,CustomQueryEntities) values(
      In_QueryRecId,In_UserId,In_QueryType,In_CustomQuery,
      In_QueryRecDesc,In_SecurityQueryType,In_CustomQueryEntities);
    commit work
  end if
end
;

create procedure dba.InsertNewAutoGenerationKey(
in In_AutoGenerationId char(20),
in In_AutoGeneratioDesc char(100),
in In_AutoGenerationPreFix char(5),
in In_AutoGenerationPostFix char(5),
in In_AutoGenerationStartNum char(10),
in In_KeyTypeId char(20),
in In_AutoGenerationLength integer)
begin
  if not exists(select* from AutoGenerationKey where
      AutoGenerationKey.AutoGenerationId = In_AutoGenerationId and
      AutoGenerationKey.AutoGenerationPostFix = In_AutoGenerationPostFix and
      AutoGenerationKey.AutoGenerationPreFix = In_AutoGenerationPreFix) then
    if(In_AutoGenerationLength = 0) then
      set In_AutoGenerationLength=10
    end if;
    insert into AutoGenerationKey(AutoGenerationId,
      AutoGeneratioDesc,AutoGenerationPreFix,
      AutoGenerationPostFix,AutoGenerationStartNum,
      AutoGenerateLastGenNum,KeyTypeId,
      AutoGenerationLength) values(
      In_AutoGenerationId,
      In_AutoGeneratioDesc,In_AutoGenerationPreFix,
      In_AutoGenerationPostFix,In_AutoGenerationStartNum,
      In_AutoGenerationStartNum,In_KeyTypeId,
      In_AutoGenerationLength);
    commit work
  end if
end
;

create procedure dba.InsertNewBank(
in In_BankId char(20),
in In_BankName char(60),
in In_BankBoolean1 integer,
in In_BankDate1 date,
in In_BankInteger1 integer,
in In_BankNumeric1 double,
in In_BankString1 char(100),
in In_BankString2 char(100),
in In_BankString3 char(100))
begin
  if not exists(select* from Bank where Bank.BankId = In_BankId) then
    insert into Bank(
      BankId,
      BankName,
      BankBoolean1,
      BankDate1,
      BankInteger1,
      BankNumeric1,
      BankString1,
      BankString2,
      BankString3) values(
      In_BankId,
      In_BankName,
      In_BankBoolean1,
      In_BankDate1,
      In_BankInteger1,
      In_BankNumeric1,
      In_BankString1,
      In_BankString2,
      In_BankString3);
    commit work
  end if
end
;

create procedure dba.InsertNewBankAccountType(
in In_BankAccountTypeId char(20),
in In_BankAccountTypeDesc char(100))
begin
  if not exists(select* from BankAccountType where
      BankAccountType.BankAccountTypeId = In_BankAccountTypeId) then
    insert into BankAccountType(BankAccountTypeId,
      BankAccountTypeDesc) values(
      In_BankAccountTypeId,In_BankAccountTypeDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewBankAccType(
in In_BankAccTypeId char(20),
in In_BankAccTypeDesc char(100))
begin
  if not exists(select* from BankAccType where BankAccType.BankAccTypeId = In_BankAccTypeId) then
    insert into BankAccType(BankAccTypeId,BankAccTypeDesc) values(
      In_BankAccTypeId,In_BankAccTypeDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewBankBranch(
in In_BankId char(20),
in In_BankBranchId char(20),
in In_BankBranchDesc char(60),
in In_BankAddress char(150),
in In_BankPCode char(20),
in In_BankCity char(60),
in In_BankState char(60),
in In_BankCountry char(60))
begin
  if not exists(select* from BankBranch where BankBranch.BankId = In_BankId and
      BankBranch.BankBranchId = In_BankBranchId) then
    insert into BankBranch(BankId,BankBranchId,
      BankBranchDesc,BankAddress,BankPCode,
      BankCity,BankState,BankCountry) values(
      In_BankId,In_BankBranchId,In_BankBranchDesc,In_BankAddress,In_BankPCode,
      In_BankCity,In_BankState,In_BankCountry);
    commit work
  end if
end
;

create procedure dba.InsertNewBloodGroup(
in In_BloodGroupId char(10),
in In_BloodGroupType char(50))
begin
  if not exists(select* from BloodGroup where
      BloodGroup.BloodGroupId = In_BloodGroupId) then
    insert into BloodGroup(BloodGroupId,BloodGroupType) values(
      In_BloodGroupId,In_BloodGroupType);
    commit work
  end if
end
;

create procedure dba.InsertNewCalendar(
in In_CalendarId char(20),
in In_CalendarDesc char(100),
in In_AveWorkDaysPerWeek double,
in In_WorkingDaysPerYear double,
in In_HoursPerWeek double,
in In_HoursPerYear double,
in In_HoursPerFullDay double,
in In_HoursPerHalfDay double,
in In_HoursPerQuaterDay double,
in In_CountryCode char(20),
in In_PaidOffDayM smallint,
in In_PaidOffDayD smallint,
in In_PaidOffDayH smallint,
in In_PaidHolidayM smallint,
in In_PaidHolidayD smallint,
in In_PaidHolidayH smallint)
begin
  declare i integer;
  if not exists(select* from Calendar where
      Calendar.CalendarId = In_CalendarId) then
    insert into Calendar(CalendarId,
      CalendarDesc,AveWorkDaysPerWeek,
      WorkingDaysPerYear,HoursPerWeek,
      HoursPerYear,HoursPerFullDay,
      HoursPerHalfDay,HoursPerQuaterDay,
      CountryCode,
      PaidOffDayM,
      PaidOffDayD,
      PaidOffDayH,
      PaidHolidayM,
      PaidHolidayD,
      PaidHolidayH) values(In_CalendarId,
      In_CalendarDesc,In_AveWorkDaysPerWeek,
      In_WorkingDaysPerYear,In_HoursPerWeek,
      In_HoursPerYear,In_HoursPerFullDay,
      In_HoursPerHalfDay,In_HoursPerQuaterDay,
      In_CountryCode,
      In_PaidOffDayM,
      In_PaidOffDayD,
      In_PaidOffDayH,
      In_PaidHolidayM,
      In_PaidHolidayD,
      In_PaidHolidayH);
    set i=1;
    while i <= 12 loop
      insert into FixedCalendar(CalendarId,FixedCalMth,FixedCalNoDays) values(
        In_CalendarId,i,30);
      set i=i+1
    end loop;
    commit work
  end if
end
;

create procedure dba.InsertNewCareerAttribute(
in In_EmployeeSysId integer,
in In_CareerEffectiveDate date,
in In_CareerAttributeID char(20),
in In_CareerNewValue char(100))
begin
  if not exists(select* from CareerAttribute where
      CareerAttribute.EmployeeSysId = In_EmployeeSysId and
      CareerAttribute.CareerEffectiveDate = In_CareerEffectiveDate and
      CareerAttribute.CareerAttributeID = In_CareerAttributeID) then
    insert into CareerAttribute(EmployeeSysId,
      CareerEffectiveDate,
      CareerAttributeID,
      CareerNewValue) values(
      In_EmployeeSysId,
      In_CareerEffectiveDate,
      In_CareerAttributeID,
      In_CareerNewValue);
    commit work
  end if
end
;

create procedure dba.InsertNewCareerProgression(
in In_EmployeeSysId integer,
in In_CareerEffectiveDate date,
in In_CareerRemarks char(100),
in In_CareerAttachmentID char(100),
in In_CareerCareerId char(20),
in In_CareerCurrent integer)
begin
  if(In_CareerCurrent = 1) then
    if exists(select* from CareerProgression where CareerProgression.EmployeeSysId = In_EmployeeSysId and CareerProgression.CareerCurrent = In_CareerCurrent) then
      update CareerProgression set
        CareerProgression.CareerCurrent = 0 where
        CareerProgression.EmployeeSysId = In_EmployeeSysId and CareerProgression.CareerCurrent = In_CareerCurrent;
      commit work
    end if
  end if;
  if not exists(select* from CareerProgression where
      CareerProgression.EmployeeSysId = In_EmployeeSysId and
      CareerProgression.CareerEffectiveDate = In_CareerEffectiveDate) then
    insert into CareerProgression(EmployeeSysId,
      CareerEffectiveDate,
      CareerRemarks,
      CareerAttachmentID,
      CareerCareerId,
      CareerCurrent) values(
      In_EmployeeSysId,
      In_CareerEffectiveDate,
      In_CareerRemarks,
      In_CareerAttachmentID,
      In_CareerCareerId,
      In_CareerCurrent);
    commit work
  end if
end
;

create procedure dba.InsertNewCategory(
in In_CategoryId char(20),
in In_CategoryDesc char(60))
begin
  if not exists(select* from Category where Category.CategoryId = In_CategoryId) then
    insert into Category(CategoryId,CategoryDesc) values(In_CategoryId,In_CategoryDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewCessation(
in In_CessationCode char(20),
in In_CessationDesc char(100))
begin
  if not exists(select* from Cessation where
      Cessation.CessationCode = In_CessationCode) then
    insert into Cessation(CessationCode,CessationDesc) values(
      In_CessationCode,In_CessationDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewCity(
in In_CountryId char(20),
in In_StateId char(20),
in In_CityId char(20),
in In_CityName char(60),
out Out_ErrorCode integer)
begin
  if not exists(select* from City where City.CityId = In_CityId) then
    insert into City(CountryId,StateId,CityId,CityName) values(
      In_CountryId,In_StateId,In_CityId,In_CityName);
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewClassification(
in In_ClassificationCode char(20),
in In_ClassificationDesc char(100))
begin
  if not exists(select* from Classification where Classification.ClassificationCode = In_ClassificationCode) then
    insert into Classification(ClassificationCode,ClassificationDesc) values(
      In_ClassificationCode,In_ClassificationDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewComBank(
in In_ComBankCode char(20),
in In_CompanyId char(20),
in In_ComBankBranchCode char(20),
in In_ComAccountNo char(20),
in In_ComAccType char(50))
begin
  declare Char_ComBankName char(60);
  select Bank.BankName into Char_ComBankName from Bank where
    Bank.BankId = In_ComBankCode;
  if not exists(select* from CompanyBank where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComAccountNo) then
    insert into CompanyBank(ComBankCode,
      CompanyId,ComBankBranchCode,
      ComAccountNo,ComBankName,
      ComAccType) values(
      In_ComBankCode,In_CompanyId,In_ComBankBranchCode,
      In_ComAccountNo,Char_ComBankName,In_ComAccType);
    commit work
  end if
end
;

create procedure dba.InsertNewCompany(
in In_CompanyId char(20),
in In_CompanyTypeId char(20),
in In_CompanyReg char(35),
in In_CompanyName char(100),
in In_CompanyProbationPeriod integer,
in In_CompanyAddress1 char(150),
in In_CompanyAddress2 char(150),
in In_CompanyAddress3 char(150),
in In_CompanyCountry char(60),
in In_CompanyCity char(60),
in In_CompanyPCode char(20),
in In_CompanyState char(60),
in In_CompanyRetireAge integer,
in In_CompanyFax char(30),
in In_CompanyContact char(30),
in In_Remarks1 char(100),
in In_Remarks2 char(100),
in In_DateFormat char(10),
in In_CompanyProbationUnit char(10),
in In_ThousandSeparator char(1),
in In_CompanyCurrency char(20),
in In_CompanyStatutoryContri char(20),
in In_CompanyForeignName char(100),
in In_CompanyEMailAddress char(100))
begin
  if not exists(select* from Company where
      Company.CompanyId = In_CompanyId) then
    if(In_CompanyForeignName = '') then set In_CompanyForeignName=In_CompanyName
    end if;
    insert into Company(CompanyId,CompanyTypeId,
      CompanyReg,CompanyName,CompanyProbationPeriod,
      CompanyAddress,CompanyAddress2,CompanyAddress3,
      CompanyCountry,CompanyCity,
      CompanyPCode,CompanyState,CompanyRetireAge,
      CompanyFax,CompanyContact,Remarks1,
      Remarks2,DateFormat,CompanyProbationUnit,
      ThousandSeparator,CompanyCurrency,CompanyStatutoryContri,
      CompanyForeignName,CompanyEMailAddress) values(
      In_CompanyId,In_CompanyTypeId,
      In_CompanyReg,In_CompanyName,In_CompanyProbationPeriod,
      In_CompanyAddress1,In_CompanyAddress2,In_CompanyAddress3,
      In_CompanyCountry,In_CompanyCity,
      In_CompanyPCode,In_CompanyState,In_CompanyRetireAge,
      In_CompanyFax,In_CompanyContact,In_Remarks1,
      In_Remarks2,In_DateFormat,In_CompanyProbationUnit,
      In_ThousandSeparator,In_CompanyCurrency,In_CompanyStatutoryContri,
      In_CompanyForeignName,In_CompanyEMailAddress);
    commit work
  end if
end
;

create procedure dba.InsertNewCompanyGovt(
in In_CompanyId char(20),
in In_CompanyGovCode char(20),
in In_CompanyGovAccNo char(30))
begin
  declare In_CompanyGovDesc char(100);
  select ComGovTypeName into In_CompanyGovDesc
    from CompanyGovType where
    CompanyGovType.ComGovTypeId = In_CompanyGovCode;
  insert into CompanyGov(CompanyId,
    CompanyGovCode,CompanyGovAccNo,
    CompanyGovDesc) values(
    In_CompanyId,In_CompanyGovCode,In_CompanyGovAccNo,
    In_CompanyGovDesc);
  commit work
end
;

create procedure dba.InsertNewCompanyGovType(
in In_ComGovTypeId char(20),
in In_ComGovTypeName char(100),
in In_CountryId char(20))
begin
  if not exists(select* from CompanyGovType where
      CompanyGovType.ComGovTypeId = In_ComGovTypeId) then
    insert into CompanyGovType(ComGovTypeId,
      ComGovTypeName,CountryId) values(In_ComGovTypeId,
      In_ComGovTypeName,In_CountryId);
    commit work
  end if
end
;

create procedure dba.InsertNewCompanyType(
in In_ComTypeId char(20),
in In_ComTypeDesc char(100))
begin
  if not exists(select* from CompanyType where
      CompanyType.CompanyTypeId = In_ComTypeId) then
    insert into CompanyType(CompanyTypeId,CompanyTypeDesc) values(
      In_ComTypeId,In_ComTypeDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewContactLoc(
in In_ContactLocId char(20),
in In_ContactLocDesc char(80))
begin
  if not exists(select* from ContactLocation where
      ContactLocation.ContactLocationId = In_ContactLocId) then
    insert into ContactLocation(ContactLocationId,
      ContactLocationDesc) values(
      In_ContactLocId,In_ContactLocDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewContractProgression(
in In_EmployeeSysId integer,
in In_ContractStartDate date,
in In_ContractNo char(20),
in In_ContractEndDate date,
in In_ContractRemarks char(100),
in In_ContractCurrent integer)
begin
  if not exists(select* from ContractProgression where
      ContractProgression.EmployeeSysId = In_EmployeeSysId and
      ContractProgression.ContractStartDate = In_ContractStartDate) then
    insert into ContractProgression(EmployeeSysId,
      ContractStartDate,
      ContractNo,
      ContractEndDate,
      ContractRemarks,
      ContractCurrent) values(
      In_EmployeeSysId,
      In_ContractStartDate,
      In_ContractNo,
      In_ContractEndDate,
      In_ContractRemarks,
      In_ContractCurrent);
    commit work
  end if
end
;

create procedure dba.InsertNewCountry(
in In_CountryId char(20),
in In_CountryName char(60),
in In_CountryTelCode char(20),
in In_CountryNationality char(100),
in In_CountryCurrency char(20))
begin
  if not exists(select* from Country where
      Country.CountryId = In_CountryId) then
    insert into Country(CountryId,CountryName,
      CountryTelCode,CountryNationality,CountryCurrency) values(
      In_CountryId,In_CountryName,In_CountryTelCode,
      In_CountryNationality,In_CountryCurrency);
    commit work
  end if
end
;

create procedure dba.InsertNewDepartment(
in In_DepartmentId char(20),
in In_DepartmentDesc char(60))
begin
  if not exists(select* from Department where Department.DepartmentId = In_DepartmentId) then
    insert into Department(DepartmentId,DepartmentDesc) values(In_DepartmentId,In_DepartmentDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewEducation(
in In_EducationId char(20),
in In_EduLevelId char(20),
in In_EducationDesc char(80),
out Out_ErrorCode integer)
begin
  if not exists(select* from Education where EducationId = In_EducationId) then
    insert into Education(EducationId,EduLevelId,EducationDesc) values(
      In_EducationId,In_EduLevelId,In_EducationDesc);
    commit work;
    if not exists(select* from Education where EducationId = In_EducationId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewEmpCode1(
in In_EmpCode1Id char(20),
in In_CustCodeDesc char(100))
begin
  if not exists(select* from EmpCode1 where EmpCode1.EmpCode1Id = In_EmpCode1Id) then
    insert into EmpCode1(EmpCode1Id,CustCodeDesc) values(
      In_EmpCode1Id,In_CustCodeDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewEmpCode2(
in In_EmpCode2Id char(20),
in In_CustCodeDesc char(100))
begin
  if not exists(select* from EmpCode2 where EmpCode2.EmpCode2Id = In_EmpCode2Id) then
    insert into EmpCode2(EmpCode2Id,CustCodeDesc) values(
      In_EmpCode2Id,In_CustCodeDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewEmpCode3(
in In_EmpCode3Id char(20),
in In_CustCodeDesc char(100))
begin
  if not exists(select* from EmpCode3 where EmpCode3.EmpCode3Id = In_EmpCode3Id) then
    insert into EmpCode3(EmpCode3Id,CustCodeDesc) values(
      In_EmpCode3Id,In_CustCodeDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewEmpCode4(
in In_EmpCode4Id char(20),
in In_CustCodeDesc char(100))
begin
  if not exists(select* from EmpCode4 where EmpCode4.EmpCode4Id = In_EmpCode4Id) then
    insert into EmpCode4(EmpCode4Id,CustCodeDesc) values(
      In_EmpCode4Id,In_CustCodeDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewEmpCode5(
in In_EmpCode5Id char(20),
in In_CustCodeDesc char(100))
begin
  if not exists(select* from EmpCode5 where EmpCode5.EmpCode5Id = In_EmpCode5Id) then
    insert into EmpCode5(EmpCode5Id,CustCodeDesc) values(
      In_EmpCode5Id,In_CustCodeDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewEmpeeWkCalen(
in In_CalendarId char(20),
in In_EmpeeWkCalenEffDate date,
in In_EmployeeSysId integer)
begin
  if not exists(select* from EmpeeWkCalen where
      EmpeeWkCalen.EmployeeSysId = In_EmployeeSysId and
      EmpeeWkCalen.EmpeeWkCalenEffDate = In_EmpeeWkCalenEffDate) then
    insert into EmpeeWkCalen(CalendarId,
      EmpeeWkCalenEffDate,EmployeeSysId) values(
      In_CalendarId,In_EmpeeWkCalenEffDate,
      In_EmployeeSysId);
    commit work
  end if
end
;

create procedure dba.InsertNewEmpLocation1(
in In_EmpLocation1Id char(20),
in In_CustLocationDesc char(100),
in In_CustAddress1 char(150),
in In_CustAddress2 char(150),
in In_CustAddress3 char(150),
in In_CustCountry char(20),
in In_CustState char(20),
in In_CustCity char(20),
in In_CustPCode char(20))
begin
  if not exists(select* from EmpLocation1 where EmpLocation1.EmpLocation1Id = In_EmpLocation1Id) then
    insert into EmpLocation1(EmpLocation1Id,
      CustLocationDesc,
      CustAddress1,
      CustAddress2,
      CustAddress3,
      CustCountry,
      CustState,
      CustCity,
      CustPCode) values(In_EmpLocation1Id,
      In_CustLocationDesc,
      In_CustAddress1,
      In_CustAddress2,
      In_CustAddress3,
      In_CustCountry,
      In_CustState,
      In_CustCity,
      In_CustPCode);
    commit work
  end if
end
;

create procedure dba.InsertNewEmployeeRecord(
in In_PersonalSysId integer,
in In_EmployeeId char(30),
in In_CompanyId char(20),
in In_BranchId char(20),
in In_CessationCode char(20),
in In_CategoryId char(20),
in In_DepartmentId char(20),
in In_PositionId char(20),
in In_SectionId char(20),
in In_CessationDate date,
in In_HireDate date,
in In_ConfirmationDate date,
in In_ProbationPeriod integer,
in In_ProbationUnit char(10),
in In_RetirementAge integer,
in In_RetirementDate date,
in In_Supervisor char(30),
in In_IsSupervisor smallint,
in In_PreviousSvcYear double,
in In_SalaryGradeId char(20),
in In_EmpCode1Id char(20),
in In_EmpCode2Id char(20),
in In_EmpCode3Id char(20),
in In_EmpCode4Id char(20),
in In_EmpCode5Id char(20),
in In_EmpLocation1Id char(20),
in In_ClassificationCode char(20),
in In_CustBoolean1 smallint,
in In_CustBoolean2 smallint,
in In_CustBoolean3 smallint,
in In_CustDate1 date,
in In_CustDate2 date,
in In_CustDate3 date,
in In_CustInteger1 integer,
in In_CustInteger2 integer,
in In_CustInteger3 integer,
in In_CustNumeric1 double,
in In_CustNumeric2 double,
in In_CustNumeric3 double,
in In_CustString1 char(50),
in In_CustString2 char(50),
in In_CustString3 char(50),
in In_CustString4 char(50),
in In_CustString5 char(50))
begin
  declare Char_IdentityNo char(30);
  declare Char_RaceId char(20);
  declare Char_ReligionId char(20);
  declare Char_TitleId char(20);
  declare Char_MaritalstatusCode char(10);
  declare Char_IdentityTypeCode char(20);
  declare Char_CountryOfBirth char(60);
  declare Date_DateOfBirth date;
  declare Char_PersonalName char(150);
  declare SInt_Gender char(1);
  declare Char_Nationality char(60);
  declare Int_HighestEduCode integer;
  declare Char_ResidenceStatus char(20);
  declare Int_EmployeeSysId integer;
  declare Out_LicenseExceed integer;
  /*
  Check for License Exceeded
  */
  select FGetLicenseEmployeeCountExceed(In_PersonalSysId) into Out_LicenseExceed;
  if(Out_LicenseExceed = 1) then return
  end if;
  /*
  Create Employee Record
  */
  if not exists(select* from Employee where Employee.EmployeeId = In_EmployeeId and
      Employee.PersonalSysId = In_PersonalsysId) then
    select ResidenceStatusRecord.ResidenceTypeId into Char_ResidenceStatus
      from ResidenceStatusRecord where
      ResidenceStatusRecord.PersonalSysId = In_PersonalSysId and
      ResidenceStatusRecord.ResStatusCurrent = 1;
    select Personal.IdentityNo,Personal.RaceId,Personal.ReligionId,Personal.TitleId,
      Personal.MaritalStatusCode,Personal.IdentityTypeId,Personal.CountryOfBirth,
      Personal.DateOfBirth,Personal.PersonalName,Personal.Gender,Personal.Nationality into Char_IdentityNo,
      Char_RaceId,Char_ReligionId,Char_TitleId,
      Char_MaritalStatusCode,Char_IdentityTypeCode,Char_CountryOfBirth,
      Date_DateOfBirth,Char_PersonalName,SInt_Gender,
      Char_Nationality from Personal where
      Personal.PersonalSysId = In_PersonalSysId;
    select EducationRec.EduRecId into Int_HighestEduCode
      from EducationRec where
      EducationRec.PersonalSysId = In_PersonalSysId and
      EducationRec.EduHighest = 1;
    insert into Employee(PersonalSysId,EmployeeId,IdentityNo,RaceId,
      ReligionID,TitleId,MaritalStatusCode,IdentityTypeCode,
      CountryOfBirth,DateOfBirth,EmployeeName,Gender,Nationality,
      ResidenceStatus,HighestEduCode,CompanyId,BranchId,
      CessationCode,CategoryId,DepartmentId,
      PositionId,SectionId,CessationDate,
      HireDate,ConfirmationDate,ProbationPeriod,
      ProbationUnit,RetirementAge,RetirementDate,
      Supervisor,IsSupervisor,PreviousSvcYear,
      SalaryGradeId,
      EmpCode1Id,
      EmpCode2Id,
      EmpCode3Id,
      EmpCode4Id,
      EmpCode5Id,
      EmpLocation1Id,
      ClassificationCode,
      CustBoolean1,
      CustBoolean2,
      CustBoolean3,
      CustDate1,
      CustDate2,
      CustDate3,
      CustInteger1,
      CustInteger2,
      CustInteger3,
      CustNumeric1,
      CustNumeric2,
      CustNumeric3,
      CustString1,
      CustString2,
      CustString3,
      CustString4,
      CustString5) values(
      In_PersonalSysId,In_EmployeeId,Char_IdentityNo,Char_RaceId,
      Char_ReligionId,Char_TitleId,Char_MaritalStatusCode,Char_IdentityTypeCode,
      Char_CountryOfBirth,Date_DateOfBirth,Char_PersonalName,SInt_Gender,Char_Nationality,
      Char_ResidenceStatus,Int_HighestEduCode,In_CompanyId,In_BranchId,
      In_CessationCode,In_CategoryId,In_DepartmentId,
      In_PositionId,In_SectionId,In_CessationDate,
      In_HireDate,In_ConfirmationDate,In_ProbationPeriod,
      In_ProbationUnit,In_RetirementAge,In_RetirementDate,
      In_Supervisor,In_IsSupervisor,In_PreviousSvcYear,
      In_SalaryGradeId,
      In_EmpCode1Id,
      In_EmpCode2Id,
      In_EmpCode3Id,
      In_EmpCode4Id,
      In_EmpCode5Id,
      In_EmpLocation1Id,
      In_ClassificationCode,
      In_CustBoolean1,
      In_CustBoolean2,
      In_CustBoolean3,
      In_CustDate1,
      In_CustDate2,
      In_CustDate3,
      In_CustInteger1,
      In_CustInteger2,
      In_CustInteger3,
      In_CustNumeric1,
      In_CustNumeric2,
      In_CustNumeric3,
      In_CustString1,
      In_CustString2,
      In_CustString3,
      In_CustString4,
      In_CustString5);
    commit work;
    select Employee.EmployeeSysId into Int_EmployeeSysId
      from Employee where
      Employee.EmployeeId = In_EmployeeId and
      Employee.PersonalSysId = In_PersonalSysId;
    commit work;
    update Personal set
      Personal.EmployeeId = In_EmployeeId where
      Personal.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.InsertNewEmploymentStatus(
in In_EmpStatusId char(20),
in In_EmpStatusDesc char(80))
begin
  if not exists(select* from EmploymentStatus where
      EmploymentStatus.EmpStatusId = In_EmpStatusId) then
    insert into EmploymentStatus(EmpstatusId,EmpStatusDesc) values(
      In_EmpStatusId,In_EmpStatusDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewEmploymentType(
in In_EmploymentTypeId char(20),
in In_EmploymentTypeDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from EmploymentType where EmploymentTypeId = In_EmploymentTypeId) then
    insert into EmploymentType(EmploymentTypeId,EmploymentTypeDesc) values(
      In_EmploymentTypeId,In_EmploymentTypeDesc);
    commit work;
    if not exists(select* from EmploymentType where EmploymentTypeId = In_EmploymentTypeId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewFieldMajor(
in In_FieldMajorId char(20),
in In_FieldMajorDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from FieldMajor where FieldMajorId = In_FieldMajorId) then
    insert into FieldMajor(FieldMajorId,FieldMajorDesc) values(
      In_FieldMajorId,In_FieldMajorDesc);
    commit work;
    if not exists(select* from FieldMajor where FieldMajorId = In_FieldMajorId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewFieldSecurityNoAccess(
in In_UserGroupId char(20),
in In_SecurityAccessDesc char(80),
in In_FieldSecurityId integer)
begin
  if not exists(select* from FieldSecurityNoAccess where
      FieldSecurityNoAccess.FieldSecurityId = In_FieldSecurityId and
      FieldSecurityNoAccess.UserGroupId = In_UserGroupId) then
    insert into FieldSecurityNoAccess(UserGroupId,
      SecurityAccessDesc,FieldSecurityId) values(
      In_UserGroupId,In_SecurityAccessDesc,In_FieldSecurityId);
    commit work
  end if
end
;

create procedure dba.InsertNewForeignWorkerRecord(
in In_FWorkerTypeCode char(20),
in In_EmployeeSysId integer,
in In_FWIssueDate date,
in In_FWExpiryDate date,
in In_FWExtensionDate date,
in In_FWPermitNumber char(30),
in In_CurrentFWRecord smallint)
begin
  insert into ForeignWorkRec(FWorkerTypeCode,
    EmployeeSysId,FWIssueDate,
    FWExpiryDate,FWExtensionDate,
    FWPermitNumber,CurrentFWRecord) values(
    In_FWorkerTypeCode,In_EmployeeSysId,In_FWIssueDate,In_FWExpiryDate,
    In_FWExtensionDate,In_FWPermitNumber,In_CurrentFWRecord);
  commit work
end
;

create procedure dba.InsertNewForeignWorkerType(
in In_FWorkerTypeCode char(20),
in In_FWorkerTypeDesc char(100),
in In_FWorkerDailyRate numeric(6,2),
in In_FWorkerMaxMthRate numeric(6,2))
begin
  if not exists(select* from ForeignWorkerType where
      ForeignWorkerType.FWorkerTypeCode = In_FWorkerTypeCode) then
    insert into ForeignWorkerType(FWorkerTypeCode,
      FWorkerTypeDesc,FWorkerDailyRate,
      FWorkerMaxMthRate) values(
      In_FWorkerTypeCode,In_FWorkerTypeDesc,In_FWorkerDailyRate,
      In_FWorkerMaxMthRate);
    commit work
  end if
end
;

create procedure dba.InsertNewGovContribType(
in In_CountryId char(10),
in In_GovContribTypeId char(20),
in In_GovContribTypeName char(100))
begin
  if not exists(select* from GovermentContribType where
      GovermentContribType.GovContribTypeId = In_GovContribTypeId and
      GovermentContribType.CountryId = In_CountryId) then
    insert into GovermentContribType(GovContribTypeId,
      CountryId,GovContribTypeName) values(
      In_GovContribTypeId,In_CountryId,In_GovContribTypeName);
    commit work
  end if
end
;

create procedure dba.InsertNewGroupLvePattern(
in In_WeekLeavePatternId char(20),
in In_GroupLeavePatternWeekNo integer,
in In_CalendarId char(20))
begin
  if not exists(select* from GroupLeavePattern where
      GroupLeavePattern.GroupLeavePatternWeekNo = In_GroupLeavePatternWeekNo and
      GroupLeavePattern.CalendarId = In_CalendarId and
      GroupLeavePattern.WeekLeavePatternId = In_WeekLeavePatternId) then
    insert into GroupLeavePattern(WeekLeavePatternId,
      GroupLeavePatternWeekNo,CalendarId) values(
      In_WeekLeavePatternId,
      In_GroupLeavePatternWeekNo,In_CalendarId);
    commit work
  end if
end
;

create procedure dba.InsertNewGroupWeekPattern(
in In_CalendarId char(20),
in In_Type char(20))
begin
  declare Char_WkPatternId char(20);
  declare Dec_Mon decimal(4,3);
  declare Dec_Tue decimal(4,3);
  declare Dec_Wed decimal(4,3);
  declare Dec_Thur decimal(4,3);
  declare Dec_Fri decimal(4,3);
  declare Dec_Sat decimal(4,3);
  declare Dec_Sun decimal(4,3);
  if(In_Type = 'LEAVE_PATTERN') then
    GroupLeavePatternLoop: for GroupLeavePatternFor as curs dynamic scroll cursor for
      select WeekLeavePatternId as SourceId,GroupLeavePatternWeekNo,CalendarId from GroupLeavePattern where
        CalendarId = In_CalendarId do
      if exists(select* from WeekLeavePattern where WeekLeavePattern.WeekLeavePatternId = WeekLeavePatternId) then
        select WeekLeavePattern.WeekLeavePatternId,
          WeekLeavePattern.LveMonday,WeekLeavePattern.LveTuesday,WeekLeavePattern.LveWenesday,
          WeekLeavePattern.LveThursday,WeekLeavePattern.LveFriday,WeekLeavePattern.LveSaturday,
          WeekLeavePattern.LveSunday into Char_WkPatternId,
          Dec_Mon,Dec_Tue,Dec_Wed,Dec_Thur,Dec_Fri,
          Dec_Sat,Dec_Sun from WeekLeavePattern where
          WeekLeavePattern.WeekLeavePatternId = SourceId;
        call InsertNewWeekWorkPattern(Char_WkPatternId,Dec_Mon,Dec_Tue,Dec_Wed,Dec_Thur,Dec_Fri,Dec_Sat,Dec_Sun);
        call InsertNewGroupWorkPattern(SourceId,GroupLeavePatternWeekNo,CalendarId)
      end if end for
  else
    GroupPayPatternLoop: for GroupPayPatternFor as cur dynamic scroll cursor for
      select WeekPatternId as SourceId,GroupWorkPatternWeekNo,CalendarId from GroupWorkPattern where
        CalendarId = In_CalendarId do
      if exists(select* from WeekWorkPattern where WeekWorkPattern.WeekPatternId = WeekPatternId) then
        select WeekWorkPattern.WeekPatternId,WeekWorkPattern.WWrkMon,WeekWorkPattern.WWrkTue,WeekWorkPattern.WWrkWed,
          WeekWorkPattern.WWrkThur,WeekWorkPattern.WWrkFri,WeekWorkPattern.WWrkSat,WeekWorkPattern.WWrkSun into Char_WkPatternId,
          Dec_Mon,Dec_Tue,Dec_Wed,Dec_Thur,Dec_Fri,
          Dec_Sat,Dec_Sun from WeekWorkPattern where
          WeekWorkPattern.WeekPatternId = SourceId;
        call InsertNewWeekLeavePattern(Char_WkPatternId,Dec_Mon,Dec_Tue,Dec_Wed,Dec_Thur,Dec_Fri,Dec_Sat,Dec_Sun);
        call InsertNewGroupLvePattern(SourceId,GroupWorkPatternWeekNo,CalendarId)
      end if end for
  end if
end
;

create procedure dba.InsertNewGroupWorkPattern(
in In_WeekPatternId char(20),
in In_GroupWorkPatternWeekNo integer,
in In_CalendarId char(20))
begin
  if not exists(select* from GroupWorkPattern where
      GroupWorkPattern.GroupWorkPatternWeekNo = In_GroupWorkPatternWeekNo and
      GroupWorkPattern.CalendarId = In_CalendarId and
      GroupWorkPattern.WeekPatternId = In_WeekPatternId) then
    insert into GroupWorkPattern(GroupWorkPatternWeekNo,
      WeekPatternId,CalendarId) values(
      In_GroupWorkPatternWeekNo,
      In_WeekPatternId,In_CalendarId);
    commit work
  end if
end
;

create procedure dba.InsertNewHoliday(
in In_HolidayId char(20),
in In_HolidayDesc char(80),
in In_HolidayStartDate date,
in In_CountryId char(20),
in In_HolidayLvePattern numeric(8,4),
in In_HolidayWorkPattern numeric(8,4),
in In_HolidayEndDate date)
begin
  if not exists(select* from Holidays where
      Holidays.HolidayId = In_HolidayId and
      Holidays.HolidayStartDate = In_HolidayStartDate and
      Holidays.CountryId = In_CountryId) then
    insert into Holidays(HolidayId,HolidayDesc,
      HolidayStartDate,CountryId,HolidayLvePattern,
      HolidayWorkPattern,HolidayEndDate) values(
      In_HolidayId,In_HolidayDesc,In_HolidayStartDate,In_CountryId,
      In_HolidayLvePattern,In_HolidayWorkPattern,In_HolidayEndDate);
    commit work
  end if
end
;

create procedure dba.InsertNewIdentityType(
in In_IdentityTypeId char(20),
in In_IdentityTypeDesc char(60))
begin
  if not exists(select* from IdentityType where
      IdentityType.IdentityTypeId = In_IdentityTypeId) then
    insert into IdentityType(IdentityTypeId,IdentityTypeDesc) values(
      In_IdentityTypeId,In_IdentityTypeDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewLanguage(
in In_LanguageId char(20),
in In_LanguageDesc char(80),
out Out_ErrorCode integer)
begin
  if not exists(select* from Language where LanguageId = In_LanguageId) then
    insert into Language(LanguageId,LanguageDesc) values(
      In_LanguageId,In_LanguageDesc);
    commit work;
    if not exists(select* from Language where LanguageId = In_LanguageId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewLoginRec(
in In_UserId char(20),
in In_Module char(20),
in In_IPAddress char(20),
out Out_LoginSGSPGenId char(30))
begin
  declare TS_LoginTimeStamp timestamp;
  set TS_LoginTimeStamp=Now(*);
  select FGetNewSGSPGeneratedIndex('LoginRec') into Out_LoginSGSPGenId;
  insert into LoginRec(LoginSGSPGenId,UserId,Module,ModuleLoginTime,IPAddress) values(
    Out_LoginSGSPGenId,In_UserId,In_Module,TS_LoginTimeStamp,In_IPAddress);
  commit work
end
;

create procedure dba.InsertNewMaritalStatus(
in In_MariStatusCode char(20),
in In_MariStatusDesc char(60))
begin
  if not exists(select* from MaritalStatus where MaritalStatus.MaritalStatusCode = In_MariStatusCode) then
    insert into MaritalStatus(MaritalStatusCode,MaritalStatusDesc) values(
      In_MariStatusCode,In_MariStatusDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewModuleScreenGroup(
in In_ModuleScreenId char(20),
in In_Mod_ModuleScreenId char(20),
in In_ModuleScreenName char(100),
in In_MainModuleName char(100),
in In_HideOnlyWage smallint,
in In_HideScreenForWage smallint)
begin
  if not exists(select* from ModuleScreenGroup where
      ModuleScreenGroup.ModuleScreenId = In_ModuleScreenId and
      ModuleScreenGroup.Mod_ModuleScreenId = In_Mod_ModuleScreenId) then
    insert into ModuleScreenGroup(ModuleScreenId,
      Mod_ModuleScreenId,
      ModuleScreenName,
      MainModuleName,
      HideOnlyWage,
      HideScreenForWage) values(
      In_ModuleScreenId,
      In_Mod_ModuleScreenId,
      In_ModuleScreenName,
      In_MainModuleName,
      In_HideOnlyWage,
      In_HideScreenForWage);
    commit work
  end if
end
;

create procedure dba.InsertNewOccupation(
in In_OccupationId char(20),
in In_OccupationDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from Occupation where OccupationId = In_OccupationId) then
    insert into Occupation(OccupationId,OccupationDesc) values(
      In_OccupationId,In_OccupationDesc);
    commit work;
    if not exists(select* from Occupation where OccupationId = In_OccupationId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewPaymentBankInfo(
in In_EmployeeSysId integer,
in In_BankId char(20),
in In_BankBranchId char(20),
in In_BankAccountNo char(30),
in In_PaymentValue numeric(10,2),
in In_PaymentType char(20),
in In_BankAccTypeId char(20),
in In_PaymentMode char(20),
in In_BankRemarks char(100),
in In_BeneficiaryName char(150),
in In_BankAllocGpId char(20))
begin
  insert into PaymentBankInfo(PayBankSGSPGenId,
    EmployeeSysId,
    BankId,
    BankBranchId,
    BankAccountNo,
    PaymentValue,
    PaymentType,BankAccTypeId,PaymentMode,BankRemarks,
    BeneficiaryName,
    BankAllocGpId) values(
    (select FGetNewSGSPGeneratedIndex('PaymentBankInfo')),
    In_EmployeeSysId,
    In_BankId,
    In_BankBranchId,
    In_BankAccountNo,
    In_PaymentValue,
    In_PaymentType,In_BankAccTypeId,In_PaymentMode,In_BankRemarks,
    In_BeneficiaryName,
    In_BankAllocGpId);
  commit work
end
;

create procedure dba.InsertNewPensionOption(
in In_PensionOptionId char(20),
in In_PensionOptionDesc char(100))
begin
  if not exists(select* from PensionOption where
      PensionOption.PensionOptionId = In_PensionOptionId) then
    insert into PensionOption(PensionOptionId,
      PensionOptionDesc) values(
      In_PensionOptionId,In_PensionOptionDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewPersonalAddress(
in In_ContactLocationId char(20),
in In_Address1 char(150),
in In_Address2 char(150),
in In_Address3 char(150),
in In_Country char(60),
in In_City char(60),
in In_State char(60),
in In_PCode char(20),
in In_PersonalSysId integer,
in In_PersonalAddMailing smallint)
begin
  declare Out_PersonalAddressRecord integer;
  if(In_PersonalAddMailing = 1) then
    call ASQLSetPersonalAddressDefault(In_PersonalSysId)
  end if;
  select count(*) into Out_PersonalAddressRecord from PersonalAddress where
    PersonalSysId = In_PersonalSysId and PersonalAddMailing = 1;
  if(Out_PersonalAddressRecord = 0) then set In_PersonalAddMailing=1
  end if;
  insert into PersonalAddress(ContactLocationId,
    PersonalAddAddress,
    PersonalAddAddress2,
    PersonalAddAddress3,
    PersonalAddCountry,PersonalAddCity,PersonalAddState,
    PersonalAddPCode,PersonalSysId,PersonalAddMailing) values(
    In_ContactLocationId,In_Address1,In_Address2,In_Address3,
    In_Country,In_City,In_State,In_PCode,In_PersonalSysId,In_PersonalAddMailing);
  commit work
end
;

create procedure dba.InsertNewPersonalContact(
in In_ContactLocationId char(20),
in In_ContactNumber char(30),
in In_Extension char(10),
in In_PersonalSysId integer)
begin
  insert into PersonalContact(ContactLocationId,
    ContactNumber,Extension,
    PersonalSysId) values(
    In_ContactLocationId,In_ContactNumber,
    In_Extension,In_PersonalSysId);
  commit work
end
;

create procedure dba.InsertNewPersonalDetail(
in In_IdentityNo char(30),
in In_IdentityTypeCode char(20),
in In_MaritalStatusCode char(10),
in In_RaceId char(20),
in In_ReligionID char(20),
in In_TitleId char(20),
in In_BloodGroupId char(10),
in In_CountryOfBirth char(60),
in In_DateOfBirth date,
in In_PersonalName char(150),
in In_Alias char(100),
in In_Gender char(1),
in In_Nationality char(60),
in In_Height decimal(6,3),
in In_Weight decimal(7,4),
in In_IdentityCheckDigit char(5),
in In_PersonalTypeId char(20),
in In_Mal_OldIdentity char(30),
in In_FirstName char(50),
in In_MiddleName char(50),
in In_LastName char(50),
in In_MiddleInitial char(10),
in In_PassportIssue char(20),
in In_IdentityIssueBy char(20))
begin
  declare In_PersonalSysId integer;
  declare Out_LicenseExceed integer;
  /*
  if Country is philippine, combine the three names into one PersonalName
  */
  declare CombinedPersonalName char(150);
  if FGetDBCountry(*) = 'Philippines' then
    if(In_FirstName <> '') then
      set CombinedPersonalName=In_FirstName+' '
    end if;
    if(In_MiddleInitial <> '') then
      set CombinedPersonalName=CombinedPersonalName+In_MiddleInitial+' '
    end if;
    if(In_LastName <> '') then
      set CombinedPersonalName=CombinedPersonalName+In_LastName
    end if;
    set In_PersonalName=trim(CombinedPersonalName)
  end if;
  /*
  if Country is HongKong, combine the PersonalName = FirstName(Surname) + MiddleName (OtherName)
  example: Ng (surname) Man Tat (other name)
  */
  if FGetDBCountry(*) = 'HongKong' then
    if(In_FirstName <> '') then
      set CombinedPersonalName=In_FirstName+' '
    end if;
    if(In_MiddleName <> '') then
      set CombinedPersonalName=CombinedPersonalName+In_MiddleName+' '
    end if;
    set In_PersonalName=trim(CombinedPersonalName)
  end if;
  /*
  Check for License Exceeded
  */
  select FGetLicenseCountExceed(0) into Out_LicenseExceed;
  if(Out_LicenseExceed = 1) then return
  end if;
  /*
  Create Personal Details and Attachment Record
  */
  insert into Personal(IdentityNo,IdentityTypeId,MaritalStatusCode,
    RaceId,ReligionID,TitleId,BloodGroupId,CountryOfBirth,
    DateOfBirth,PersonalName,Alias,Gender,Nationality,
    Height,Weight,IdentityCheckDigit,PersonalTypeId,Mal_OldIdentity,
    FirstName,MiddleName,LastName,MiddleInitial,PassportIssue,IdentityIssueBy) values(
    In_IdentityNo,In_IdentityTypeCode,In_MaritalStatusCode,In_RaceId,In_ReligionID,
    In_TitleId,In_BloodGroupId,In_CountryOfBirth,In_DateOfBirth,In_PersonalName,In_Alias,In_Gender,In_Nationality,
    In_Height,In_Weight,In_IdentityCheckDigit,In_PersonalTypeId,In_Mal_OldIdentity,
    In_FirstName,In_MiddleName,In_LastName,In_MiddleInitial,In_PassportIssue,In_IdentityIssueBy);
  select PersonalSysId into In_PersonalSysId from Personal where
    IdentityNo = In_IdentityNo and
    PersonalName = In_PersonalName;
  /*
  To create Attachment records for Photo and Notes 
  */
  insert into Attachment(PersonalSysId,AttachmentType) values(
    In_PersonalSysId,'Notes');
  insert into Attachment(PersonalSysId,AttachmentType) values(
    In_PersonalSysId,'Photo');
  commit work
end
;

create procedure dba.InsertNewPersonalEmail(
in In_ContactLocationId char(20),
in In_PersonalEmail char(60),
in In_PersonalSysId integer)
begin
  insert into PersonalEmail(ContactLocationId,
    PersonalEmail,PersonalSysId) values(
    In_ContactLocationId,In_PersonalEmail,In_PersonalSysId);
  commit work
end
;

create procedure dba.InsertNewPosGrp(
in In_PositionGrpId char(20),
in In_PositionGrpDesc char(100),
in In_PositionGrpLevel integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from PosGrp where PositionGrpId = In_PositionGrpId) then
    insert into PosGrp(PositionGrpId,PositionGrpDesc,PositionGrpLevel) values(
      In_PositionGrpId,In_PositionGrpDesc,In_PositionGrpLevel);
    commit work;
    if not exists(select* from PosGrp where PositionGrpId = In_PositionGrpId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewPositionCode(
in In_PositionId char(20),
in In_PositionDesc char(80),
in In_KeyPosition integer,
in In_PositionGrpId char(20))
begin
  if not exists(select* from PositionCode where PositionCode.PositionId = In_PositionId) then
    insert into PositionCode(PositionId,PositionDesc,KeyPosition,PositionGrpId) values(
      In_PositionId,In_PositionDesc,In_KeyPosition,In_PositionGrpId);
    commit work
  end if
end
;

create procedure dba.InsertNewRace(
in In_RaceId char(20),
in In_RaceDesc char(60))
begin
  if not exists(select* from Race where Race.RaceId = In_RaceId) then
    insert into Race(RaceId,RaceDesc) values(
      In_RaceId,In_RaceDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewRelationship(
in In_RelationshipId char(20),
in In_RelationshipDesc char(60))
begin
  if not exists(select* from Relationship where
      Relationship.RelationshipId = In_RelationshipId) then
    insert into Relationship(RelationshipId,RelationshipDesc) values(
      In_RelationshipId,In_RelationshipDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewReligion(
in In_ReligionId char(20),
in In_ReligionType char(60))
begin
  if not exists(select* from Religion where Religion.ReligionId = In_ReligionId) then
    insert into Religion(ReligionId,ReligionType) values(
      In_ReligionId,In_ReligionType);
    commit work
  end if
end
;

create procedure dba.InsertNewResidenceStatusRec(
in In_ResStatusEffectiveDate date,
in In_ResidenceTypeId char(20),
in In_PersonalSysId integer,
in In_ResStatusCurrent integer,
in In_ResStatusCareerId char(20),
in In_ResStatusRemarks char(100))
begin
  if not exists(select* from ResidenceStatusRecord where
      ResidenceStatusRecord.PersonalSysId = In_PersonalSysId and
      ResidenceStatusRecord.ResStatusEffectiveDate = In_ResStatusEffectiveDate) then
    if(In_ResStatusCurrent = 1) then
      update ResidenceStatusRecord set
        ResidenceStatusRecord.ResStatusCurrent = 0 where
        ResidenceStatusRecord.PersonalSysId = In_PersonalSysId;
      update Employee set
        Employee.ResidenceStatus = In_ResidenceTypeId where
        Employee.PersonalSysId = In_PersonalSysId
    end if;
    insert into ResidenceStatusRecord(ResStatusEffectiveDate,
      ResidenceTypeId,PersonalSysId,ResStatusCurrent,ResStatusCareerId,ResStatusRemarks) values(
      In_ResStatusEffectiveDate,In_ResidenceTypeId,In_PersonalSysId,In_ResStatusCurrent,In_ResStatusCareerId,In_ResStatusRemarks);
    commit work
  end if
end
;

create procedure dba.InsertNewResidenceType(
in In_ResidenceTypeId char(20),
in In_ResidenceTypeDesc char(100))
begin
  if not exists(select* from ResidenceType where
      ResidenceType.ResidenceTypeId = In_ResidenceTypeId) then
    insert into ResidenceType(ResidenceTypeId,
      ResidenceTypeDesc) values(
      In_ResidenceTypeId,In_ResidenceTypeDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewResponsibility(
in In_ResponsibilityId char(20),
in In_ResponsibilityDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from Responsibility where ResponsibilityId = In_ResponsibilityId) then
    insert into Responsibility(ResponsibilityId,ResponsibilityDesc) values(
      In_ResponsibilityId,In_ResponsibilityDesc);
    commit work;
    if not exists(select* from Responsibility where ResponsibilityId = In_ResponsibilityId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewSalaryGrade(
in In_SalaryGradeId char(20),
in In_SalaryGradeDesc char(100),
in In_MinBasicRate double,
in In_MaxBasicRate double,
in In_MaxBRIncPercent double,
in In_MaxBRIncAmt double)
begin
  if not exists(select* from SalaryGrade where SalaryGrade.SalaryGradeId = In_SalaryGradeId) then
    insert into SalaryGrade(SalaryGradeId,SalaryGradeDesc,MinBasicRate,MaxBasicRate,MaxBRIncPercent,MaxBRIncAmt) values(
      In_SalaryGradeId,In_SalaryGradeDesc,In_MinBasicRate,In_MaxBasicRate,In_MaxBRIncPercent,In_MaxBRIncAmt);
    commit work
  end if
end
;

create procedure dba.InsertNewSection(
in In_SectionId char(20),
in In_SectionDesc char(60))
begin
  if not exists(select* from Section where Section.SectionId = In_SectionId) then
    insert into Section(SectionId,SectionDesc) values(
      In_SectionId,In_SectionDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewState(
in In_CountryId char(20),
in In_StateId char(20),
in In_StateName char(60),
out Out_ErrorCode integer)
begin
  if not exists(select* from State where State.StateId = In_StateId) then
    insert into State(CountryId,StateId,StateName) values(
      In_CountryId,In_StateId,In_StateName);
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewSystemUser(
in In_UserId char(20),
in In_UserGroup char(20),
in In_UserPassword char(50),
in In_ExpiryDate date,
in In_FirstTimeLogin integer,
in In_SysPersonalSysId integer,
in In_IsDirServices smallint,
in In_DirServicesUserName char(200),
in In_DirServicesDomainName char(200))
begin
  if not exists(select* from SystemUser where SystemUser.UserId = In_UserId) then
    insert into SystemUser(UserId,UserGroupId,
      UserPassword,ExpiryDate,FirstTimeLogin,SysPersonalSysId,
      IsDirServices,DirServicesUserName,
      DirServicesDomainName) values(
      In_UserId,In_UserGroup,In_UserPassword,
      In_ExpiryDate,In_FirstTimeLogin,In_SysPersonalSysId,
      In_IsDirServices,In_DirServicesUserName,In_DirServicesDomainName);
    commit work
  end if
end
;

create procedure dba.InsertNewTitleCode(
in In_TitleId char(20),
in In_TitleDesc char(60))
begin
  if not exists(select* from TitleCode where TitleCode.TitleId = In_TitleId) then
    insert into TitleCode(TitleId,TitleDesc) values(
      In_TitleId,In_TitleDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewUserGroup(
in In_UserGroupId char(20),
in In_UserGroupDesc char(80),
in In_UserGroupHideWage smallint)
begin
  if not exists(select* from UserGroup where UserGroup.UserGroupId = In_UserGroupId) then
    insert into UserGroup(UserGroupId,UserGroupDesc,UserGroupHideWage) values(
      In_UserGroupId,In_UserGroupDesc,In_UserGroupHideWage);
    commit work
  end if
end
;

create procedure dba.InsertNewUserModuleNoAccess(
in In_ModuleScreenId char(20),
in In_UserGroupId char(20))
begin
  if not exists(select* from UserModuleNoAccess where
      UserModuleNoAccess.ModuleScreenId = In_ModuleScreenId and
      UserModuleNoAccess.UserGroupId = In_UserGroupId) then
    insert into UserModuleNoAccess(ModuleScreenId,
      UserGroupId) values(
      In_ModuleScreenId,In_UserGroupId);
    commit work
  end if
end
;

create procedure dba.InsertNewUserSearchSetting(
in In_UserID char(20),
in In_SearchID char(20),
in In_SearchDescription char(40),
in In_SearchField char(20),
in In_SearchOption char(20),
in In_SearchString char(100))
begin
  if not exists(select* from UserSearchSetting where
      UserSearchSetting.UserID = In_UserID and
      UserSearchSetting.SearchID = In_SearchID) then
    insert into UserSearchSetting(UserID,
      SearchID,
      SearchDescription,
      SearchField,
      SearchOption,
      SearchString) values(
      In_UserID,
      In_SearchID,
      In_SearchDescription,
      In_SearchField,
      In_SearchOption,
      In_SearchString);
    commit work
  end if
end
;

create procedure dba.InsertNewUserSecurityQuery(
in In_UserGroupId char(20),
in In_QueryRecId char(60))
begin
  if not exists(select* from UserSecurityQuery where
      UserSecurityQuery.UserGroupId = In_UserGroupId and
      UserSecurityQuery.QueryRecId = In_QueryRecId) then
    insert into UserSecurityQuery(UserGroupId,QueryRecId) values(
      In_UserGroupId,In_QueryRecId);
    commit work
  end if
end
;

create procedure dba.InsertNewWeekLeavePattern(
in In_WeekLeavePatternId char(20),
in In_LveMonday decimal(4,3),
in In_LveTuesday decimal(4,3),
in In_LveWenesday decimal(4,3),
in In_LveThursday decimal(4,3),
in In_LveFriday decimal(4,3),
in In_LveSaturday decimal(4,3),
in In_LveSunday decimal(4,3))
begin
  if not exists(select* from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = In_WeekLeavePatternId) then
    insert into WeekLeavePattern(WeekLeavePatternId,
      LveMonday,LveTuesday,LveWenesday,
      LveThursday,LveFriday,LveSaturday,
      LveSunday) values(In_WeekLeavePatternId,
      In_LveMonday,In_LveTuesday,In_LveWenesday,
      In_LveThursday,In_LveFriday,In_LveSaturday,
      In_LveSunday);
    commit work
  end if
end
;

create procedure dba.InsertNewWeekWorkPattern(
in In_WeekPatternId char(20),
in In_WWrkMon decimal(4,3),
in In_WWrkTue decimal(4,3),
in In_WWrkWed decimal(4,3),
in In_WWrkThur decimal(4,3),
in In_WWrkFri decimal(4,3),
in In_WWrkSat decimal(4,3),
in In_WWrkSun decimal(4,3))
begin
  if not exists(select* from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = In_WeekPatternId) then
    insert into WeekWorkPattern(WeekPatternId,
      WWrkMon,WWrkTue,WWrkWed,
      WWrkThur,WWrkFri,WWrkSat,
      WWrkSun) values(In_WeekPatternId,
      In_WWrkMon,In_WWrkTue,In_WWrkWed,
      In_WWrkThur,In_WWrkFri,In_WWrkSat,
      In_WWrkSun);
    commit work
  end if
end
;

create procedure dba.PCountCalenLeavePattern(
in In_CalendarId char(20),
out Count_CalendarId integer)
begin
  select COUNT(GroupLeavePattern.CalendarId) into Count_CalendarId
    from GroupLeavePattern where
    GroupLeavePattern.CalendarId = In_CalendarId
end
;

create procedure dba.PCountCalenWorkPattern(
in In_CalendarId char(20),
out COUNT_CalendarId integer)
begin
  select COUNT(GroupWorkPattern.CalendarId) into Count_CalendarId
    from GroupWorkPattern where
    GroupWorkPattern.CalendarId = In_CalendarId
end
;

create procedure dba.PGetPositionMaxMinWage(
in In_PositionId char(20))
result("Min Wage" numeric(8,2),"Max Wage" numeric(8,2))
begin
  select Position.DeptPosMinWage,Position.DeptPosMaxWage from
    Position where
    Position.PositionId = In_PositionId
end
;

create procedure dba.RptGetEmergencyMainContact(
in In_PersonalSysId integer)
result(Out_ContactName char(100),Out_ContactNumber char(30),Out_EContactAddress char(150),Out_EContactCountry char(60),Out_EContactCity char(60),Out_EContactState char(60),Out_EContactPCode char(20),Out_RelationshipDesc char(60))
begin
  declare Out_ContactName char(100);
  declare Out_ContactNumber char(30);
  declare Out_EContactAddress char(150);
  declare Out_EContactCountry char(60);
  declare Out_EContactCity char(60);
  declare Out_EContactState char(60);
  declare Out_EContactPCode char(20);
  declare Out_RelationShipId char(20);
  declare Out_RelationShipDesc char(60);
  select EmergencyContact.ContactName,
    EmergencyContact.ContactNumber,
    EmergencyContact.EContactAddress,EmergencyContact.EContactCity,
    EmergencyContact.EContactCountry,EmergencyContact.EContactState,
    EmergencyContact.EContactPCode,EmergencyContact.RelationshipId into Out_ContactName,
    Out_ContactNumber,
    Out_EContactAddress,Out_EContactCity,
    Out_EContactCountry,Out_EContactState,
    Out_EcontactPCode,
    Out_RelationShipId from EmergencyContact where
    EmergencyContact.PersonalSysId = In_PersonalSysId and
    EmergencyContact.EContactMain = 1;
  select RelationshipDesc into Out_RelationshipDesc
    from Relationship where
    Relationship.RelationshipId = Out_RelationshipId;
  commit work
end
;

create procedure dba.UpdateAdHocQueryFields(
in In_QueryRecId char(60),
in In_FieldsName char(100),
in In_EntityName char(100),
in In_QueryNotCondition smallint,
in In_QueryFromCondition char(50),
in In_QueryToCondition char(50),
in In_QueryDateFrom date,
in In_QueryDateTo date,
in In_QueryValueFrom double,
in In_QueryValueTo double)
begin
  if exists(select* from AdHocQueryFields where
      AdHocQueryFields.QueryRecId = In_QueryRecId and
      AdHocQueryFields.FieldsName = In_FieldsName and
      AdHocQueryFields.EntityName = In_EntityName) then
    update AdHocQueryFields set
      AdHocQueryFields.QueryNotCondition = In_QueryNotCondition,
      AdHocQueryFields.QueryFromCondition = In_QueryFromCondition,
      AdHocQueryFields.QueryToCondition = In_QueryToCondition,
      AdHocQueryFields.QueryDateFrom = In_QueryDateFrom,
      AdHocQueryFields.QueryDateTo = In_QueryDateTo,
      AdHocQueryFields.QueryValueFrom = In_QueryValueFrom,
      AdHocQueryFields.QueryValueTo = In_QueryValueTo where
      AdHocQueryFields.QueryRecId = In_QueryRecId and
      AdHocQueryFields.FieldsName = In_FieldsName and
      AdHocQueryFields.EntityName = In_EntityName;
    commit work
  end if
end
;

create procedure dba.UpdateAdHocQueryRecord(
in In_QueryRecId char(60),
in In_UserId char(20),
in In_QueryType char(1),
in In_CustomQuery char(8192),
in In_QueryRecDesc char(150),
in In_SecurityQueryType char(1),
in In_CustomQueryEntities char(200))
begin
  if exists(select* from AdHocQueryRec where
      AdHocQueryRec.QueryRecId = In_QueryRecId) then
    update AdHocQueryRec set
      AdHocQueryRec.QueryRecId = In_QueryRecId,
      AdHocQueryRec.UserId = In_UserId,
      AdHocQueryRec.QueryType = In_QueryType,
      AdHocQueryRec.CustomQuery = In_CustomQuery,
      AdHocQueryRec.QueryRecDesc = In_QueryRecDesc,
      AdHocQueryRec.SecurityQueryType = In_SecurityQueryType,
      AdHocQueryRec.CustomQueryEntities = In_CustomQueryEntities where
      AdHocQueryRec.QueryRecId = In_QueryRecId;
    commit work
  end if
end
;

create procedure dba.UpdateAllNewLabelToDefault()
begin
  update LabelName set
    LabelName.NewLName = LabelName.DefaultLName;
  commit work
end
;

create procedure dba.UpdateBankAccountTypeDesc(
in In_BankAccountTypeId char(20),
in In_BankAccountTypeDesc char(100))
begin
  if exists(select* from BankAccountType where
      BankAccountType.BankAccountTypeId = In_BankAccountTypeId) then
    update BankAccountType set
      BankAccountType.BankAccountTypeDesc = In_BankAccountTypeDesc where
      BankAccountType.BankAccountTypeId = In_BankAccountTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateBankAccType(
in In_BankAccTypeId char(20),
in In_BankAccTypeDesc char(100))
begin
  if exists(select* from BankAccType where BankAccType.BankAccTypeId = In_BankAccTypeId) then
    update BankAccType set
      BankAccType.BankAccTypeDesc = In_BankAccTypeDesc where
      BankAccType.BankAccTypeId = In_BankAccTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateBankBranch(
in In_BankId char(20),
in In_BankBranchId char(20),
in In_BankBranchDesc char(60),
in In_BankAddress char(150),
in In_BankPCode char(20),
in In_BankCity char(60),
in In_BankState char(60),
in In_BankCountry char(60))
begin
  if exists(select* from BankBranch where BankBranch.BankId = In_BankId and
      BankBranch.BankBranchId = In_BankBranchId) then
    update BankBranch set
      BankBranch.BankBranchDesc = In_BankBranchDesc,
      BankBranch.BankAddress = In_BankAddress,
      BankBranch.BankPCode = In_BankPCode,
      BankBranch.BankCity = In_BankCity,
      BankBranch.BankState = In_BankState,
      BankBranch.BankCountry = In_BankCountry where
      BankBranch.BankId = In_BankId and
      BankBranch.BankBranchId = In_BankBranchId;
    commit work
  end if
end
;

create procedure dba.UpdateBankName(
in In_BankId char(20),
in In_BankName char(60),
in In_BankBoolean1 integer,
in In_BankDate1 date,
in In_BankInteger1 integer,
in In_BankNumeric1 double,
in In_BankString1 char(100),
in In_BankString2 char(100),
in In_BankString3 char(100))
begin
  if exists(select* from Bank where Bank.BankId = In_BankId) then
    update Bank set
      Bank.BankName = In_BankName,
      Bank.BankBoolean1 = In_BankBoolean1,
      Bank.BankDate1 = In_BankDate1,
      Bank.BankInteger1 = In_BankInteger1,
      Bank.BankNumeric1 = In_BankNumeric1,
      Bank.BankString1 = In_BankString1,
      Bank.BankString2 = In_BankString2,
      Bank.BankString3 = In_BankString3 where
      Bank.BankId = In_BankId;
    commit work
  end if
end
;

create procedure dba.UpdateBloodGroupDesc(
in In_BloodGroupId char(10),
in In_BloodGroupType char(50))
begin
  if exists(select* from BloodGroup where
      BloodGroup.BloodGroupId = In_BloodGroupId) then
    update BloodGroup set
      BloodGroup.BloodGroupType = In_BloodGroupType where
      BloodGroup.BloodGroupId = In_BloodGroupId;
    commit work
  end if
end
;

create procedure dba.UpdateCalendar(
in In_CalendarId char(20),
in In_CalendarDesc char(100),
in In_AveWorkDaysPerWeek double,
in In_WorkingDaysPerYear double,
in In_HoursPerWeek double,
in In_HoursPerYear double,
in In_HoursPerFullDay double,
in In_HoursPerHalfDay double,
in In_HoursPerQuaterDay double,
in In_CountryCode char(20),
in In_PaidOffDayM smallint,
in In_PaidOffDayD smallint,
in In_PaidOffDayH smallint,
in In_PaidHolidayM smallint,
in In_PaidHolidayD smallint,
in In_PaidHolidayH smallint)
begin
  if exists(select* from Calendar where
      Calendar.CalendarId = In_CalendarId) then
    update Calendar set
      Calendar.CalendarDesc = In_CalendarDesc,
      Calendar.AveWorkDaysPerWeek = In_AveWorkDaysPerWeek,
      Calendar.WorkingDaysPerYear = In_WorkingDaysPerYear,
      Calendar.HoursPerWeek = In_HoursPerWeek,
      Calendar.HoursPerYear = In_HoursPerYear,
      Calendar.HoursPerFullDay = In_HoursPerFullDay,
      Calendar.HoursPerHalfDay = In_HoursPerHalfDay,
      Calendar.HoursPerQuaterDay = In_HoursPerQuaterDay,
      Calendar.CountryCode = In_CountryCode,
      Calendar.PaidOffDayM = In_PaidOffDayM,
      Calendar.PaidOffDayD = In_PaidOffDayD,
      Calendar.PaidOffDayH = In_PaidOffDayH,
      Calendar.PaidHolidayM = In_PaidHolidayM,
      Calendar.PaidHolidayD = In_PaidHolidayD,
      Calendar.PaidHolidayH = In_PaidHolidayH where
      Calendar.CalendarId = In_CalendarId;
    commit work
  end if
end
;

create procedure dba.UpdateCalendarDayWKLvePattern(
in In_CalendarDate date,
in In_CalendarIdCode char(20),
in In_WkCalenDayLvePattern numeric(8,4),
in In_WkCalenDayWkPattern numeric(8,4),
in In_PublicHoliday integer)
begin
  if exists(select* from CalendarDay where
      CalendarDay.CalendarDate = In_CalendarDate and
      CalendarDay.CalendarIdCode = In_CalendarIdCode) then
    update CalendarDay set
      CalendarDay.WkCalenDayLvePattern = In_WkCalenDayLvePattern,
      CalendarDay.WkCalenDayWkPattern = In_WkCalenDayWkPattern,
      CalendarDay.PublicHoliday = In_PublicHoliday where
      CalendarDay.CalendarDate = In_CalendarDate and
      CalendarDay.CalendarIdCode = In_CalendarIdCode;
    commit work
  end if
end
;

create procedure dba.UpdateCareerAttribute(
in In_EmployeeSysId integer,
in In_CareerEffectiveDate date,
in In_CareerAttributeID char(20),
in In_CareerNewValue char(100))
begin
  if exists(select* from CareerAttribute where
      CareerAttribute.EmployeeSysId = In_EmployeeSysId and
      CareerAttribute.CareerEffectiveDate = In_CareerEffectiveDate and
      CareerAttribute.CareerAttributeID = In_CareerAttributeID) then
    update CareerAttribute set
      CareerAttribute.CareerNewValue = In_CareerNewValue where
      CareerAttribute.EmployeeSysId = In_EmployeeSysId and
      CareerAttribute.CareerEffectiveDate = In_CareerEffectiveDate and
      CareerAttribute.CareerAttributeID = In_CareerAttributeID;
    commit work
  end if
end
;

create procedure dba.UpdateCareerNewValueinPayPeriodRec(
in In_EmployeeSysId integer,
in In_CareerEffectiveDate date,
in In_Year integer,
in In_Period integer)
begin
  if exists(select* from PayPeriodRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_Year and
      PayRecPeriod = In_Period) then
    CareerAttributenewValueLoop: for CareerAttributenewValue as ProcessCareerAttributenewValueCurs dynamic scroll cursor for
      select CareerAttributeID,CareerNewValue from
        CareerAttribute where
        CareerAttribute.EmployeeSysId = In_EmployeeSysId and
        CareerAttribute.CareerEffectiveDate = In_CareerEffectiveDate do
      if(CareerAttributeID = 'CareerBranch') then
        update PayPeriodRecord set
          PayBranchId = CareerNewValue where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_Year and
          PayRecPeriod = In_Period
      elseif(CareerAttributeID = 'CareerCategory') then
        update PayPeriodRecord set
          PayCategoryId = CareerNewValue where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_Year and
          PayRecPeriod = In_Period
      elseif(CareerAttributeID = 'CareerDepartment') then
        update PayPeriodRecord set
          PayDepartmentId = CareerNewValue where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_Year and
          PayRecPeriod = In_Period
      elseif(CareerAttributeID = 'CareerPosition') then
        update PayPeriodRecord set
          PayPositionId = CareerNewValue where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_Year and
          PayRecPeriod = In_Period
      elseif(CareerAttributeID = 'CareerSection') then
        update PayPeriodRecord set
          PaySectionId = CareerNewValue where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_Year and
          PayRecPeriod = In_Period
      elseif(CareerAttributeID = 'CareerLeaveGroup') then
        update PayPeriodRecord set
          PaySectionId = CareerNewValue where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_Year and
          PayRecPeriod = In_Period
      elseif(CareerAttributeID = 'ClassificationCode') then
        update PayPeriodRecord set
          PaySectionId = CareerNewValue where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_Year and
          PayRecPeriod = In_Period
      elseif(CareerAttributeID = 'SalaryGradeId') then
        update PayPeriodRecord set
          PaySectionId = CareerNewValue where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_Year and
          PayRecPeriod = In_Period
      elseif(CareerAttributeID = 'EmpCode1Id') then
        update PayPeriodRecord set
          PaySectionId = CareerNewValue where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_Year and
          PayRecPeriod = In_Period
      elseif(CareerAttributeID = 'EmpCode2Id') then
        update PayPeriodRecord set
          PaySectionId = CareerNewValue where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_Year and
          PayRecPeriod = In_Period
      elseif(CareerAttributeID = 'EmpCode3Id') then
        update PayPeriodRecord set
          PaySectionId = CareerNewValue where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_Year and
          PayRecPeriod = In_Period
      elseif(CareerAttributeID = 'EmpCode4Id') then
        update PayPeriodRecord set
          PaySectionId = CareerNewValue where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_Year and
          PayRecPeriod = In_Period
      elseif(CareerAttributeID = 'EmpCode5Id') then
        update PayPeriodRecord set
          PaySectionId = CareerNewValue where
          EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_Year and
          PayRecPeriod = In_Period
      end if end for
  end if;
  commit work
end
;

create procedure dba.UpdateCareerProgression(
in In_EmployeeSysId integer,
in In_CareerEffectiveDate date,
in In_CareerRemarks char(100),
in In_CareerAttachmentID char(100),
in In_CareerCareerId char(20),
in In_CareerCurrent integer)
begin
  if exists(select* from CareerProgression where
      CareerProgression.EmployeeSysId = In_EmployeeSysId and
      CareerProgression.CareerEffectiveDate = In_CareerEffectiveDate) then
    update CareerProgression set
      CareerProgression.CareerRemarks = In_CareerRemarks,
      CareerProgression.CareerAttachmentID = In_CareerAttachmentID,
      CareerProgression.CareerCareerId = In_CareerCareerId,
      CareerProgression.CareerCurrent = In_CareerCurrent where
      CareerProgression.EmployeeSysId = In_EmployeeSysId and
      CareerProgression.CareerEffectiveDate = In_CareerEffectiveDate;
    commit work
  end if
end
;

create procedure dba.UpdateCareerProgressionMarkCurrent(
in In_EmployeeSysId integer,
in In_CareerEffectiveDate date)
begin
  if exists(select* from CareerProgression where CareerProgression.EmployeeSysId = In_EmployeeSysId and CareerProgression.CareerEffectiveDate <> In_CareerEffectiveDate) then
    update CareerProgression set
      CareerProgression.CareerCurrent = 0 where
      CareerProgression.EmployeeSysId = In_EmployeeSysId and CareerProgression.CareerEffectiveDate <> In_CareerEffectiveDate
  end if;
  if exists(select* from CareerProgression where CareerProgression.EmployeeSysId = In_EmployeeSysId and CareerProgression.CareerEffectiveDate = In_CareerEffectiveDate) then
    update CareerProgression set
      CareerProgression.CareerCurrent = 1 where
      CareerProgression.EmployeeSysId = In_EmployeeSysId and CareerProgression.CareerEffectiveDate = In_CareerEffectiveDate
  end if;
  commit work
end
;

create procedure dba.UpdateCategoryDesc(
in In_CategoryId char(20),
in In_CategoryDesc char(60))
begin
  if exists(select* from Category where Category.CategoryId = In_CategoryId) then
    update Category set
      Category.CategoryDesc = IN_CategoryDesc where
      Category.CategoryId = IN_CategoryId;
    commit work
  end if
end
;

create procedure dba.UpdateCessationDesc(
in In_CessationCode char(20),
in In_CessationDesc char(100))
begin
  if exists(select* from Cessation where
      Cessation.CessationCode = In_CessationCode) then
    update Cessation set
      Cessation.CessationDesc = In_CessationDesc where
      Cessation.CessationCode = In_CessationCode;
    commit work
  end if
end
;

create procedure dba.UpdateCityName(
in In_CountryId char(10),
in In_StateId char(20),
in In_CityId char(20),
in In_CityName char(60))
begin
  if exists(select* from City where City.CountryId = In_CountryId and
      City.StateId = In_StateId and City.CityId = In_CityId) then
    update City set
      City.CityName = In_CityName where
      City.CountryId = In_CountryId and
      City.StateId = In_StateId and
      City.CityId = In_CityId;
    commit work
  end if
end
;

create procedure dba.UpdateClassification(
in In_ClassificationCode char(20),
in In_ClassificationDesc char(100))
begin
  if exists(select* from Classification where Classification.ClassificationCode = In_ClassificationCode) then
    update Classification set
      Classification.ClassificationDesc = In_ClassificationDesc where
      Classification.ClassificationCode = In_ClassificationCode;
    commit work
  end if
end
;

create procedure dba.UpdateComBankAccNo(
in In_ComBankCode char(20),
in In_CompanyId char(20),
in In_ComBankBranchCode char(20),
in In_ComOldAccountNo char(20),
in In_ComNewAccNo char(20))
begin
  if exists(select* from CompanyBank where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComOldAccountNo and
      CompanyBank.CompanyId = In_CompanyId) then
    update CompanyBank set
      CompanyBank.ComAccountNo = In_ComNewAccNo where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComOldAccountNo and
      CompanyBank.CompanyId = In_CompanyId;
    commit work
  end if
end
;

create procedure DBA.UpdateComBankAccount(
in In_ComBankCode char(20),
in In_CompanyId char(20),
in In_ComBankBranchCode char(20),
in In_ComAccountNo char(20),
in In_ComNewAccountNo char(20),
in In_ComAccType char(20))
begin
  if exists(select* from CompanyBank where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComAccountNo and
      CompanyBank.CompanyId = In_CompanyId) then
    if In_ComAccountNo <> In_ComNewAccountNo then
      update CompanyBank set
        CompanyBank.ComAccountNo = In_ComNewAccountNo,
        CompanyBank.ComAccType = In_ComAccType where
        CompanyBank.ComBankCode = In_ComBankCode and
        CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
        CompanyBank.ComAccountNo = In_ComAccountNo and
        CompanyBank.CompanyId = In_CompanyId;
      commit work
    else
      update CompanyBank set
        CompanyBank.ComAccType = In_ComAccType where
        CompanyBank.ComBankCode = In_ComBankCode and
        CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
        CompanyBank.ComAccountNo = In_ComAccountNo and
        CompanyBank.CompanyId = In_CompanyId;
      commit work
    end if
  end if
end
;

create procedure dba.UpdateComBankAccType(
in In_ComBankCode char(20),
in In_CompanyId char(20),
in In_ComBankBranchCode char(20),
in In_ComAccountNo char(20),
in In_ComAccType char(50))
begin
  if exists(select* from CompanyBank where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComAccountNo and
      CompanyBank.CompanyId = In_CompanyId) then
    update CompanyBank set
      CompanyBank.ComAccType = In_ComAccType where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComAccountNo and
      CompanyBank.CompanyId = In_CompanyId;
    commit work
  end if
end
;

create procedure dba.UpdateComBankBranch(
in In_ComBankCode char(20),
in In_CompanyId char(20),
in In_ComBankBranchCode char(20),
in In_ComAccountNo char(20),
in In_ComNewBankBranchCode char(20))
begin
  if exists(select* from CompanyBank where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComAccountNo and
      CompanyBank.CompanyId = In_CompanyId) then
    update CompanyBank set
      CompanyBank.ComBankBranchCode = In_ComNewBankBranchCode where
      CompanyBank.ComBankCode = In_ComBankCode and
      CompanyBank.ComBankBranchCode = In_ComBankBranchCode and
      CompanyBank.ComAccountNo = In_ComAccountNo and
      CompanyBank.CompanyId = In_CompanyId;
    commit work
  end if
end
;

create procedure dba.UpdateCompanyBranch(
in In_CompanyId char(20),
in In_BranchId char(20),
in In_BranchName char(80),
in In_BranchAddress1 char(150),
in In_BranchAddress2 char(150),
in In_BranchAddress3 char(150),
in In_BranchCountry char(60),
in In_BranchCity char(60),
in In_BranchPCode char(20),
in In_BranchState char(60),
in In_BranchForeignName char(80))
begin
  if exists(select* from Branch where Branch.CompanyId = In_CompanyId and
      Branch.BranchId = In_BranchId) then
    update Branch set
      Branch.BranchName = In_BranchName,
      Branch.BranchAddress = In_BranchAddress1,
      Branch.BranchAddress2 = In_BranchAddress2,
      Branch.BranchAddress3 = In_BranchAddress3,
      Branch.BranchCountry = In_BranchCountry,
      Branch.BranchCity = In_BranchCity,
      Branch.BranchPCode = In_BranchPCode,
      Branch.BranchState = In_BranchState,
      Branch.BranchForeignName = In_BranchForeignName where
      Branch.CompanyId = In_CompanyId and
      Branch.BranchId = In_BranchId;
    commit work
  end if
end
;

create procedure dba.UpdateCompanyGovt(
in In_CompanyGovTypeSysId integer,
in In_CompanyGovCode char(20),
in In_CompanyGovAccNo char(30),
in In_CompanyId char(20))
begin
  if exists(select* from CompanyGov where
      CompanyGov.CompanyGovTypeSysId = In_CompanyGovTypeSysId and
      CompanyGov.CompanyId = In_CompanyId) then
    update CompanyGov set
      CompanyGov.CompanyGovCode = In_CompanyGovCode,
      CompanyGov.CompanyGovAccNo = In_CompanyGovAccNo where
      CompanyGov.CompanyGovTypeSysId = In_CompanyGovTypeSysId and
      CompanyGov.CompanyId = In_CompanyId;
    commit work
  end if
end
;

create procedure dba.UpdateCompanyGovTypeDesc(
in In_ComGovTypeId char(20),
in In_ComGovTypeName char(100),
in In_CountryId char(20))
begin
  if exists(select* from CompanyGovType where
      CompanyGovType.ComGovTypeId = In_ComGovTypeId and
      CompanyGovType.CountryId = In_CountryId) then
    update CompanyGovType set
      ComGovTypeName = In_ComGovTypeName where
      CompanyGovType.ComGovTypeId = In_ComGovTypeId and
      CompanyGovType.CountryId = In_CountryId;
    commit work
  end if
end
;

create procedure dba.UpdateCompanyRecord(
in In_CompanyId char(100),
in In_CompanyTypeId char(20),
in In_CompanyReg char(35),
in In_CompanyName char(100),
in In_CompanyProbationPeriod integer,
in In_CompanyAddress1 char(150),
in In_CompanyAddress2 char(150),
in In_CompanyAddress3 char(150),
in In_CompanyCountry char(60),
in In_CompanyCity char(60),
in In_CompanyPCode char(20),
in In_CompanyState char(60),
in In_CompanyRetireAge integer,
in In_CompanyFax char(30),
in In_CompanyContact char(30),
in In_Remarks1 char(100),
in In_Remarks2 char(100),
in In_DateFormat char(10),
in In_CompanyProbationUnit char(10),
in In_ThousandSeparator char(1),
in In_CompanyCurrency char(20),
in In_CompanyStatutoryContri char(20),
in In_CompanyForeignName char(100),
in In_CompanyEMailAddress char(100))
begin
  if exists(select* from Company where
      Company.CompanyId = In_CompanyId) then
    update Company set
      Company.CompanyTypeId = In_CompanyTypeId,
      Company.CompanyReg = In_CompanyReg,
      Company.CompanyName = In_CompanyName,
      Company.CompanyProbationPeriod = In_CompanyProbationPeriod,
      Company.CompanyAddress = In_CompanyAddress1,
      Company.CompanyAddress2 = In_CompanyAddress2,
      Company.CompanyAddress3 = In_CompanyAddress3,
      Company.CompanyCountry = In_CompanyCountry,
      Company.CompanyCity = In_CompanyCity,
      Company.CompanyPCode = In_CompanyPCode,
      Company.CompanyState = In_CompanyState,
      Company.CompanyRetireAge = In_CompanyRetireAge,
      Company.CompanyFax = In_CompanyFax,
      Company.CompanyContact = In_CompanyContact,
      Company.Remarks1 = In_Remarks1,
      Company.Remarks2 = In_Remarks2,
      Company.DateFormat = In_DateFormat,
      Company.CompanyProbationUnit = In_CompanyProbationUnit,
      Company.ThousandSeparator = In_ThousandSeparator,
      Company.CompanyCurrency = In_CompanyCurrency,
      Company.CompanyStatutoryContri = In_CompanyStatutoryContri,
      Company.CompanyForeignName = In_CompanyForeignName,
      Company.CompanyEMailAddress = In_CompanyEMailAddress where
      Company.CompanyId = In_CompanyId;
    commit work
  end if
end
;

create procedure dba.UpdateCompanyTypeDesc(
in In_ComTypeId char(20),
in In_ComTypeDesc char(100))
begin
  if exists(select* from CompanyType where
      CompanyType.CompanyTypeId = In_ComTypeId) then
    update CompanyType set
      CompanyType.CompanyTypeDesc = In_ComTypeDesc where
      CompanyType.CompanyTypeId = In_ComTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateContactLocDesc(
in In_ContactLocId char(20),
in In_ContactLocDesc char(80))
begin
  if exists(select* from ContactLocation where
      ContactLocation.ContactLocationId = In_ContactLocId) then
    update ContactLocation set
      ContactLocation.ContactLocationDesc = In_ContactLocDesc where
      ContactLocation.ContactLocationId = In_ContactLocId;
    commit work
  end if
end
;

create procedure dba.UpdateContractProgression(
in In_EmployeeSysId integer,
in In_ContractStartDate date,
in In_ContractNo char(20),
in In_ContractEndDate date,
in In_ContractRemarks char(100),
in In_ContractCurrent integer)
begin
  if exists(select* from ContractProgression where
      ContractProgression.EmployeeSysId = In_EmployeeSysId and
      ContractProgression.ContractStartDate = In_ContractStartDate) then
    update ContractProgression set
      ContractNo = In_ContractNo,
      ContractEndDate = In_ContractEndDate,
      ContractRemarks = In_ContractRemarks,
      ContractCurrent = In_ContractCurrent where
      ContractProgression.EmployeeSysId = In_EmployeeSysId and
      ContractProgression.ContractStartDate = In_ContractStartDate;
    commit work
  end if
end
;

create procedure dba.UpdateCountry(
in In_CountryId char(20),
in In_CountryName char(60),
in In_CountryTelCode char(20),
in In_CountryNationality char(100),
in In_CountryCurrency char(20))
begin
  if exists(select* from Country where
      Country.CountryId = In_CountryId) then
    update Country set
      Country.CountryName = In_CountryName,
      Country.CountryTelCode = In_CountryTelCode,
      Country.CountryNationality = In_CountryNationality,
      Country.CountryCurrency = In_CountryCurrency where
      Country.CountryId = In_CountryId;
    commit work
  end if
end
;

create procedure dba.UpdateDepartmentDesc(
in In_DepartmentId char(20),
in In_DepartmentDesc char(60))
begin
  if exists(select* from Department where Department.DepartmentId = In_DepartmentId) then
    update Department set
      Department.DepartmentDesc = IN_DepartmentDesc where
      Department.DepartmentId = IN_DepartmentId;
    commit work
  end if
end
;

create procedure dba.UpdateEducation(
in In_EducationId char(20),
in In_EduLevelId char(20),
in In_EducationDesc char(80),
out Out_ErrorCode integer)
begin
  if exists(select* from Education where EducationId = In_EducationId) then
    update Education set EduLevelId = In_EduLevelId,
      EducationDesc = In_EducationDesc where
      EducationId = In_EducationId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateEmpCode1(
in In_EmpCode1Id char(20),
in In_CustCodeDesc char(100))
begin
  if exists(select* from EmpCode1 where EmpCode1.EmpCode1Id = In_EmpCode1Id) then
    update EmpCode1 set
      EmpCode1.CustCodeDesc = In_CustCodeDesc where
      EmpCode1.EmpCode1Id = In_EmpCode1Id;
    commit work
  end if
end
;

create procedure dba.UpdateEmpCode2(
in In_EmpCode2Id char(20),
in In_CustCodeDesc char(100))
begin
  if exists(select* from EmpCode2 where EmpCode2.EmpCode2Id = In_EmpCode2Id) then
    update EmpCode2 set
      EmpCode2.CustCodeDesc = In_CustCodeDesc where
      EmpCode2.EmpCode2Id = In_EmpCode2Id;
    commit work
  end if
end
;

create procedure dba.UpdateEmpCode3(
in In_EmpCode3Id char(20),
in In_CustCodeDesc char(100))
begin
  if exists(select* from EmpCode3 where EmpCode3.EmpCode3Id = In_EmpCode3Id) then
    update EmpCode3 set
      EmpCode3.CustCodeDesc = In_CustCodeDesc where
      EmpCode3.EmpCode3Id = In_EmpCode3Id;
    commit work
  end if
end
;

create procedure dba.UpdateEmpCode4(
in In_EmpCode4Id char(20),
in In_CustCodeDesc char(100))
begin
  if exists(select* from EmpCode4 where EmpCode4.EmpCode4Id = In_EmpCode4Id) then
    update EmpCode4 set
      EmpCode4.CustCodeDesc = In_CustCodeDesc where
      EmpCode4.EmpCode4Id = In_EmpCode4Id;
    commit work
  end if
end
;

create procedure dba.UpdateEmpCode5(
in In_EmpCode5Id char(20),
in In_CustCodeDesc char(100))
begin
  if exists(select* from EmpCode5 where EmpCode5.EmpCode5Id = In_EmpCode5Id) then
    update EmpCode5 set
      EmpCode5.CustCodeDesc = In_CustCodeDesc where
      EmpCode5.EmpCode5Id = In_EmpCode5Id;
    commit work
  end if
end
;

create procedure dba.UpdateEmpeeWkCalen(
in In_CalendarId char(20),
in In_EmpeeWkCalenEffDate date,
in In_EmpeeWkCalenId integer)
begin
  update EmpeeWkCalen set
    EmpeeWkCalen.EmpeeWkCalenEffDate = In_EmpeeWkCalenEffDate,
    EmpeeWkCalen.CalendarId = IN_CalendarId where
    EmpeeWkCalen.EmpeeWkCalenId = In_EmpeeWkCalenId
end
;

create procedure dba.UpdateEmpLocation1(
in In_EmpLocation1Id char(20),
in In_CustLocationDesc char(100),
in In_CustAddress1 char(150),
in In_CustAddress2 char(150),
in In_CustAddress3 char(150),
in In_CustCountry char(20),
in In_CustState char(20),
in In_CustCity char(20),
in In_CustPCode char(20))
begin
  if exists(select* from EmpLocation1 where EmpLocation1.EmpLocation1Id = In_EmpLocation1Id) then
    update EmpLocation1 set
      EmpLocation1.CustLocationDesc = In_CustLocationDesc,
      EmpLocation1.CustAddress1 = In_CustAddress1,
      EmpLocation1.CustAddress2 = In_CustAddress2,
      EmpLocation1.CustAddress3 = In_CustAddress3,
      EmpLocation1.CustCountry = In_CustCountry,
      EmpLocation1.CustState = In_CustState,
      EmpLocation1.CustCity = In_CustCity,
      EmpLocation1.CustPCode = In_CustPCode where
      EmpLocation1.EmpLocation1Id = In_EmpLocation1Id;
    commit work
  end if
end
;

create procedure dba.UpdateEmployeeRecord(
in In_EmployeeSysId integer,
in In_PersonalSysId integer,
in In_EmployeeId char(30),
in In_CompanyId char(20),
in In_BranchId char(20),
in In_CessationCode char(20),
in In_CategoryId char(20),
in In_DepartmentId char(20),
in In_PositionId char(20),
in In_SectionId char(20),
in In_CessationDate date,
in In_HireDate date,
in In_ConfirmationDate date,
in In_ProbationPeriod integer,
in In_ProbationUnit char(10),
in In_RetirementAge integer,
in In_RetirementDate date,
in In_Supervisor char(30),
in In_IsSupervisor smallint,
in In_PreviousSvcYear double,
in In_SalaryGradeId char(20),
in In_EmpCode1Id char(20),
in In_EmpCode2Id char(20),
in In_EmpCode3Id char(20),
in In_EmpCode4Id char(20),
in In_EmpCode5Id char(20),
in In_EmpLocation1Id char(20),
in In_ClassificationCode char(20),
in In_CustBoolean1 smallint,
in In_CustBoolean2 smallint,
in In_CustBoolean3 smallint,
in In_CustDate1 date,
in In_CustDate2 date,
in In_CustDate3 date,
in In_CustInteger1 integer,
in In_CustInteger2 integer,
in In_CustInteger3 integer,
in In_CustNumeric1 double,
in In_CustNumeric2 double,
in In_CustNumeric3 double,
in In_CustString1 char(50),
in In_CustString2 char(50),
in In_CustString3 char(50),
in In_CustString4 char(50),
in In_CustString5 char(50))
begin
  declare Old_HireDate date;
  declare Old_ConfirmationDate date;
  declare In_BRProgDate date;
  declare In_BRProgRemarks char(255);
  declare In_BRProgEffectiveDate date;
  declare In_BRProgBasicRateType char(20);
  declare In_BRProgNewBasicRate double;
  declare In_BRProgPercentage double;
  declare In_BRProgressionCode char(20);
  declare In_BRProgCareerId char(20);
  declare In_BRProgPrevBasicRate double;
  declare In_BRProgIncrementAmt double;
  declare In_BRProgPayGroup char(20);
  declare In_BRProgCurrent smallint;
  declare Current_EmployeeSysId integer;
  if exists(select* from Employee where Employee.EmployeeSysId = In_EmployeeSysId) then
    select HireDate,ConfirmationDate into Old_HireDate,Old_ConfirmationDate from Employee where EmployeeSysId = In_EmployeeSysId;
    update Employee set
      Employee.CompanyId = In_CompanyId,
      Employee.BranchId = In_BranchId,
      Employee.CessationCode = In_CessationCode,
      Employee.CategoryId = In_CategoryId,
      Employee.DepartmentId = In_DepartmentId,
      Employee.PositionId = In_PositionId,
      Employee.SectionId = In_SectionId,
      Employee.CessationDate = In_CessationDate,
      Employee.HireDate = In_HireDate,
      Employee.ConfirmationDate = In_ConfirmationDate,
      Employee.ProbationPeriod = In_ProbationPeriod,
      Employee.ProbationUnit = In_ProbationUnit,
      Employee.RetirementAge = In_RetirementAge,
      Employee.RetirementDate = In_RetirementDate,
      Employee.Supervisor = In_Supervisor,
      Employee.IsSupervisor = In_IsSupervisor,
      Employee.PreviousSvcYear = In_PreviousSvcYear,
      Employee.SalaryGradeId = In_SalaryGradeId,
      Employee.EmpCode1Id = In_EmpCode1Id,
      Employee.EmpCode2Id = In_EmpCode2Id,
      Employee.EmpCode3Id = In_EmpCode3Id,
      Employee.EmpCode4Id = In_EmpCode4Id,
      Employee.EmpCode5Id = In_EmpCode5Id,
      Employee.EmpLocation1Id = In_EmpLocation1Id,
      Employee.ClassificationCode = In_ClassificationCode,
      Employee.CustBoolean1 = In_CustBoolean1,
      Employee.CustBoolean2 = In_CustBoolean2,
      Employee.CustBoolean3 = In_CustBoolean3,
      Employee.CustDate1 = In_CustDate1,
      Employee.CustDate2 = In_CustDate2,
      Employee.CustDate3 = In_CustDate3,
      Employee.CustInteger1 = In_CustInteger1,
      Employee.CustInteger2 = In_CustInteger2,
      Employee.CustInteger3 = In_CustInteger3,
      Employee.CustNumeric1 = In_CustNumeric1,
      Employee.CustNumeric2 = In_CustNumeric2,
      Employee.CustNumeric3 = In_CustNumeric3,
      Employee.CustString1 = In_CustString1,
      Employee.CustString2 = In_CustString2,
      Employee.CustString3 = In_CustString3,
      Employee.CustString4 = In_CustString4,
      Employee.CustString5 = In_CustString5,
      Employee.EmployeeId = In_EmployeeId where
      Employee.EmployeeSysId = In_EmployeeSysId;
    select first EmployeeSysId into Current_EmployeeSysId from Employee where PersonalSysId = In_PersonalSysId order by hiredate desc;
    if(Current_EmployeeSysId = In_EmployeeSysId) then
      update Personal set
        Personal.EmployeeId = In_EmployeeId where
        Personal.PersonalSysId = In_PersonalSysId
    end if;
    if(Old_HireDate <> In_HireDate) then
      if(not exists(select* from BasicRateProgression where EmployeeSysId = In_EmployeeSysId and BRProgDate = In_HireDate)) then
        select BRProgressionCode,
          BRProgCareerId,
          BRProgPrevBasicRate,
          BRProgIncrementAmt,
          BRProgPercentage,
          BRProgNewBasicRate,
          BRProgBasicRateType,
          BRProgPayGroup,
          BRProgCurrent,
          BRProgRemarks into In_BRProgressionCode,
          In_BRProgCareerId,
          In_BRProgPrevBasicRate,
          In_BRProgIncrementAmt,
          In_BRProgPercentage,
          In_BRProgNewBasicRate,
          In_BRProgBasicRateType,
          In_BRProgPayGroup,
          In_BRProgCurrent,
          In_BRProgRemarks from BasicRateProgression where
          EmployeeSysId = In_EmployeeSysId and
          BRProgDate = Old_HireDate;
        insert into BasicRateProgression(EmployeeSysId,
          BRProgRemarks,
          BRProgDate,
          BRProgEffectiveDate,
          BRProgBasicRateType,
          BRProgNewBasicRate,
          BRProgPercentage,
          BRProgressionCode,
          BRProgCareerId,
          BRProgPrevBasicRate,
          BRProgIncrementAmt,
          BRProgPayGroup,BRProgCurrent) values(
          In_EmployeeSysId,
          In_BRProgRemarks,
          In_HireDate,
          In_HireDate,
          In_BRProgBasicRateType,
          In_BRProgNewBasicRate,
          In_BRProgPercentage,
          In_BRProgressionCode,
          In_BRProgCareerId,
          In_BRProgPrevBasicRate,
          In_BRProgIncrementAmt,
          In_BRProgPayGroup,
          In_BRProgCurrent);
        update PolicyProgression set
          BRProgDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          BRProgDate = Old_HireDate;
        delete from BasicRateProgression where
          EmployeeSysId = In_EmployeeSysId and
          BRProgDate = Old_HireDate
      end if;
      if(not exists(select* from SOCSOProgression where EmployeeSysId = In_EmployeeSysId and SOCSOEffectiveDate = In_HireDate)) then
        update SOCSOProgression set
          SOCSOEffectiveDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          SOCSOEffectiveDate = Old_HireDate
      end if;
      if(not exists(select* from EPFProgression where EmployeeSysId = In_EmployeeSysId and EPFEffectiveDate = In_HireDate)) then
        update EPFProgression set
          EPFEffectiveDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          EPFEffectiveDate = Old_HireDate
      end if;
      if(not exists(select* from CPFProgression where EmployeeSysId = In_EmployeeSysId and CPFEffectiveDate = In_HireDate)) then
        update CPFProgression set
          CPFEffectiveDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          CPFEffectiveDate = Old_HireDate
      end if;
      if(not exists(select* from EmployPassProgression where EmployeeSysId = In_EmployeeSysId and EPEffectiveDate = In_HireDate)) then
        update EmployPassProgression set
          EPEffectiveDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          EPEffectiveDate = Old_HireDate
      end if;
      if(not exists(select* from FWLProgression where EmployeeSysId = In_EmployeeSysId and FWLEffectiveDate = In_HireDate)) then
        update FWLProgression set
          FWLEffectiveDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          FWLEffectiveDate = Old_HireDate
      end if;
      if(not exists(select* from CostProgression where EmployeeSysId = In_EmployeeSysId and CostProgEffectiveDate = In_HireDate)) then
        update CostProgression set
          CostProgEffectiveDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          CostProgEffectiveDate = Old_HireDate
      end if;
      if(not exists(select* from MandatoryContributeProg where EmployeeSysId = In_EmployeeSysId and MandContriEffDate = In_HireDate)) then
        update MandatoryContributeProg set
          MandContriEffDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          MandContriEffDate = Old_HireDate
      end if;
      if(not exists(select* from MPFProgression where EmployeeSysId = In_EmployeeSysId and MPFProgEffDate = In_HireDate)) then
        update MPFProgression set
          MPFProgEffDate = In_HireDate where
          EmployeeSysId = In_EmployeeSysId and
          MPFProgEffDate = Old_HireDate
      end if
    end if;
    if(Old_ConfirmationDate <> In_ConfirmationDate) then
      if(not exists(select* from SIProgression where EmployeeSysId = In_EmployeeSysId and SIProgressionDate = In_ConfirmationDate)) then
        update SIProgression set
          SIProgressionDate = In_ConfirmationDate,
          SIEffectiveDate = In_ConfirmationDate where
          EmployeeSysId = In_EmployeeSysId and
          SIProgressionDate = Old_ConfirmationDate
      end if;
      if(not exists(select* from HIProgression where EmployeeSysId = In_EmployeeSysId and HIEffectiveDate = In_ConfirmationDate)) then
        update HIProgression set
          HIEffectiveDate = In_ConfirmationDate where
          EmployeeSysId = In_EmployeeSysId and
          HIEffectiveDate = Old_ConfirmationDate
      end if
    end if;
    call ASQLChgKeyCareerProgression(In_EmployeeSysId,In_HireDate,Old_HireDate);
    commit work
  end if
end
;

create procedure dba.UpdateEmploymentCareerAttribute(
in In_EmployeeSysId integer,
in In_CareerEffectiveDate date,
out Out_ErrMessage char(100))
begin
  declare SQLE_INVALID_FOREIGN_KEY exception for sqlstate value '23503';
  declare ShortString1 char(100);
  declare ShortString2 char(100);
  declare ShortString3 char(100);
  declare ShortString4 char(100);
  declare ShortString5 char(100);
  declare ShortString6 char(100);
  declare HasShiftRotationFlag integer;
  set Out_ErrMessage='';
  CareerAttributenewValueLoop: for CareerAttributenewValue as ProcessCareerAttributenewValueCurs dynamic scroll cursor for
    select CareerAttributeID,CareerNewValue from
      CareerAttribute where
      CareerAttribute.EmployeeSysId = In_EmployeeSysId and
      CareerAttribute.CareerEffectiveDate = In_CareerEffectiveDate do
    if(CareerAttributeID = 'CareerLeaveGroup') then
      begin
        if(CareerNewValue = '') then set CareerNewValue=null
        end if;
        update LeaveEmployee set
          LeaveEmployee.LeaveGroupId = CareerNewValue where
          LeaveEmployee.EmployeeSysId = In_EmployeeSysId
      exception
        when SQLE_INVALID_FOREIGN_KEY then
          begin
            set Out_ErrMessage='Leave Group ID does not exist';
            return
          end
        when others then
          begin
            set Out_ErrMessage='Leave Group Updating Error';
            return
          end
      end
    elseif(CareerAttributeID = 'CareerBranch') then
      begin
        update Employee set
          Employee.BranchId = CareerNewValue where
          Employee.EmployeeSysId = In_EmployeeSysId
      exception
        when SQLE_INVALID_FOREIGN_KEY then
          begin
            set Out_ErrMessage='Branch ID does not exist';
            return
          end
        when others then
          begin
            set Out_ErrMessage='Branch Updating Error';
            return
          end
      end
    elseif(CareerAttributeID = 'CareerCategory') then
      begin
        update Employee set
          Employee.CategoryId = CareerNewValue where
          Employee.EmployeeSysId = In_EmployeeSysId
      exception
        when SQLE_INVALID_FOREIGN_KEY then
          begin
            set Out_ErrMessage='Category ID does not exist';
            return
          end
        when others then
          begin
            set Out_ErrMessage='Category Updating Error';
            return
          end
      end
    elseif(CareerAttributeID = 'CareerDepartment') then
      begin
        update Employee set
          Employee.DepartmentId = CareerNewValue where
          Employee.EmployeeSysId = In_EmployeeSysId
      exception
        when SQLE_INVALID_FOREIGN_KEY then
          begin
            set Out_ErrMessage='Department ID does not exist';
            return
          end
        when others then
          begin
            set Out_ErrMessage='Department Updating Error';
            return
          end
      end
    elseif(CareerAttributeID = 'CareerPosition') then
      begin
        update Employee set
          Employee.PositionId = CareerNewValue where
          Employee.EmployeeSysId = In_EmployeeSysId
      exception
        when SQLE_INVALID_FOREIGN_KEY then
          begin
            set Out_ErrMessage='Position ID does not exist';
            return
          end
        when others then
          begin
            set Out_ErrMessage='Position Updating Error';
            return
          end
      end
    elseif(CareerAttributeID = 'CareerSection') then
      begin
        update Employee set
          Employee.SectionId = CareerNewValue where
          Employee.EmployeeSysId = In_EmployeeSysId
      exception
        when SQLE_INVALID_FOREIGN_KEY then
          begin
            set Out_ErrMessage='Section ID does not exist';
            return
          end
        when others then
          begin
            set Out_ErrMessage='Section Updating Error';
            return
          end
      end
    elseif(CareerAttributeID = 'CareerSupervisorID') then
      begin
        update Employee set
          Employee.Supervisor = CareerNewValue where
          Employee.EmployeeSysId = In_EmployeeSysId
      exception
        when others then
          begin
            set Out_ErrMessage='Supervisor Updating Error';
            return
          end
      end
    elseif(CareerAttributeID = 'CareerWTCalendar') then
      begin
        select HasShiftRotation into HasShiftRotationFlag from LeaveEmployee where
          LeaveEmployee.EmployeeSysId = In_EmployeeSysId;
        if(HasShiftRotationFlag = 1) then
          update LeaveEmployee set
            LeaveEmployee.WTCalendarId = CareerNewValue where
            LeaveEmployee.EmployeeSysId = In_EmployeeSysId
        elseif(HasShiftRotationFlag = 0) then
          update LeaveEmployee set
            LeaveEmployee.WTCalendarId = null where
            LeaveEmployee.EmployeeSysId = In_EmployeeSysId
        end if
      exception
        when SQLE_INVALID_FOREIGN_KEY then
          begin
            set Out_ErrMessage='Key Shift Team does not exist';
            return
          end
        when others then
          begin
            set Out_ErrMessage='Key Shift Team Updating Error';
            return
          end
      end
    elseif(CareerAttributeID = 'ClassificationCode') then
      begin
        if(CareerNewValue = '') then set CareerNewValue=null
        end if;
        update Employee set
          Employee.ClassificationCode = CareerNewValue where
          Employee.EmployeeSysId = In_EmployeeSysId
      exception
        when SQLE_INVALID_FOREIGN_KEY then
          begin
            set Out_ErrMessage='Classification does not exist';
            return
          end
        when others then
          begin
            set Out_ErrMessage='Classification Updating Error';
            return
          end
      end
    elseif(CareerAttributeID = 'SalaryGradeId') then
      begin
        if(CareerNewValue = '') then set CareerNewValue=null
        end if;
        update Employee set
          Employee.SalaryGradeId = CareerNewValue where
          Employee.EmployeeSysId = In_EmployeeSysId
      exception
        when SQLE_INVALID_FOREIGN_KEY then
          begin
            set Out_ErrMessage='Salary Grade does not exist';
            return
          end
        when others then
          begin
            set Out_ErrMessage='Salary Grade Updating Error';
            return
          end
      end
    elseif(CareerAttributeID = 'EmpCode1Id') then
      begin
        if(CareerNewValue = '') then set CareerNewValue=null
        end if;
        update Employee set
          Employee.EmpCode1Id = CareerNewValue where
          Employee.EmployeeSysId = In_EmployeeSysId
      exception
        when SQLE_INVALID_FOREIGN_KEY
        then
          begin
            select ShortStringAttr into ShortString1 from SubRegistry where registryid = 'CareerAttribute' and SubRegistryId = 'EmpCode1Id';
            set Out_ErrMessage=ShortString1+' does not exist';
            return
          end
        when others then
          begin
            set Out_ErrMessage=ShortString1+' Updating Error';
            return
          end
      end
    elseif(CareerAttributeID = 'EmpCode2Id') then
      begin
        if(CareerNewValue = '') then set CareerNewValue=null
        end if;
        update Employee set
          Employee.EmpCode2Id = CareerNewValue where
          Employee.EmployeeSysId = In_EmployeeSysId
      exception
        when SQLE_INVALID_FOREIGN_KEY
        then
          begin
            select ShortStringAttr into ShortString2 from SubRegistry where registryid = 'CareerAttribute' and SubRegistryId = 'EmpCode2Id';
            set Out_ErrMessage=ShortString2+' does not exist';
            return
          end
        when others then
          begin
            set Out_ErrMessage=ShortString2+' Updating Error';
            return
          end
      end
    elseif(CareerAttributeID = 'EmpCode3Id') then
      begin
        if(CareerNewValue = '') then set CareerNewValue=null
        end if;
        update Employee set
          Employee.EmpCode3Id = CareerNewValue where
          Employee.EmployeeSysId = In_EmployeeSysId
      exception
        when SQLE_INVALID_FOREIGN_KEY
        then
          begin
            select ShortStringAttr into ShortString3 from SubRegistry where registryid = 'CareerAttribute' and SubRegistryId = 'EmpCode3Id';
            set Out_ErrMessage=ShortString3+' does not exist';
            return
          end
        when others then
          begin
            set Out_ErrMessage=ShortString3+' Updating Error';
            return
          end
      end
    elseif(CareerAttributeID = 'EmpCode4Id') then
      begin
        if(CareerNewValue = '') then set CareerNewValue=null
        end if;
        update Employee set
          Employee.EmpCode4Id = CareerNewValue where
          Employee.EmployeeSysId = In_EmployeeSysId
      exception
        when SQLE_INVALID_FOREIGN_KEY
        then
          begin
            select ShortStringAttr into ShortString4 from SubRegistry where registryid = 'CareerAttribute' and SubRegistryId = 'EmpCode4Id';
            set Out_ErrMessage=ShortString4+' does not exist';
            return
          end
        when others then
          begin
            set Out_ErrMessage=ShortString4+' Updating Error';
            return
          end
      end
    elseif(CareerAttributeID = 'EmpCode5Id') then
      begin
        if(CareerNewValue = '') then set CareerNewValue=null
        end if;
        update Employee set
          Employee.EmpCode5Id = CareerNewValue where
          Employee.EmployeeSysId = In_EmployeeSysId
      exception
        when SQLE_INVALID_FOREIGN_KEY
        then
          begin
            select ShortStringAttr into ShortString5 from SubRegistry where registryid = 'CareerAttribute' and SubRegistryId = 'EmpCode5Id';
            set Out_ErrMessage=ShortString5+' does not exist';
            return
          end
        when others then
          begin
            set Out_ErrMessage=ShortString5+' Updating Error';
            return
          end
      end
    elseif(CareerAttributeID = 'EmpLocation1Id') then
      begin
        if(CareerNewValue = '') then set CareerNewValue=null
        end if;
        update Employee set
          Employee.EmpLocation1Id = CareerNewValue where
          Employee.EmployeeSysId = In_EmployeeSysId
      exception
        when SQLE_INVALID_FOREIGN_KEY
        then
          begin
            select ShortStringAttr into ShortString6 from SubRegistry where registryid = 'CareerAttribute' and SubRegistryId = 'EmpLocation1Id';
            set Out_ErrMessage=ShortString6+' does not exist';
            return
          end
        when others then
          begin
            set Out_ErrMessage=ShortString6+' Updating Error';
            return
          end
      end
    end if;
    commit work end for
end
;

create procedure dba.UpdateEmploymentStatus(
in In_EmpStatusId char(20),
in In_EmpStatusDesc char(80))
begin
  if exists(select* from EmploymentStatus where
      EmploymentStatus.EmpStatusId = In_EmpStatusId) then
    update EmploymentStatus set
      EmploymentStatus.EmpStatusDesc = In_EmpStatusDesc where
      EmploymentStatus.EmpStatusId = In_EmpStatusId;
    commit work
  end if
end
;

create procedure dba.UpdateEmploymentType(
in In_EmploymentTypeId char(20),
in In_EmploymentTypeDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from EmploymentType where EmploymentTypeId = In_EmploymentTypeId) then
    update EmploymentType set
      EmploymentTypeDesc = In_EmploymentTypeDesc where
      EmploymentTypeId = In_EmploymentTypeId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateFieldMajor(
in In_FieldMajorId char(20),
in In_FieldMajorDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from FieldMajor where FieldMajorId = In_FieldMajorId) then
    update FieldMajor set FieldMajorDesc = In_FieldMajorDesc where
      FieldMajorId = In_FieldMajorId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateFieldSecurityNoAccess(
in In_FieldSecurityId integer,
in In_UserGroupId char(20),
in In_SecurityAccessDesc char(80))
begin
  if exists(select* from FieldSecurityNoAccess where
      FieldSecurityNoAccess.FieldSecurityId = In_FieldSecurityId and
      FieldSecurityNoAccess.UserGroupId = In_UserGroupId) then
    update FieldSecurityNoAccess set
      FieldSecurityNoAccess.SecurityAccessDesc = In_SecurityAccessDesc where
      FieldSecurityNoAccess.SecruityFieldId = In_SecruityFieldId and
      FieldSecurityNoAccess.UserGroupId = In_UserGroupId;
    commit work
  end if
end
;

create procedure dba.UpdateForeignWorkerRecord(
in In_FWorkerTypeCode char(20),
in In_EmployeeSysId integer,
in In_FWIssueDate date,
in In_FWExpiryDate date,
in In_FWExtensionDate date,
in In_FWPermitNumber char(30),
in In_CurrentFWRecord smallint,
in In_FWRecordId integer)
begin
  if exists(select* from ForeignWorkRec where
      ForeignWorkRec.FWRecordId = In_FWRecordId and
      ForeignWorkRec.EmployeeSysId = In_EmployeeSysId) then
    update ForeignWorkRec set
      ForeignWorkRec.CurrentFWRecord = In_CurrentFWRecord,
      ForeignWorkRec.FWExpiryDate = In_FWExpiryDate,
      ForeignWorkRec.FWExtensionDate = In_FWExtensionDate,
      ForeignWorkRec.FWIssueDate = In_FWIssueDate,
      ForeignWorkRec.FWorkerTypeCode = In_FWorkerTypeCode,
      ForeignWorkRec.FWPermitNumber = In_FWPermitNumber where
      ForeignWorkRec.FWRecordId = In_FWRecordId and
      ForeignWorkRec.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.UpdateForeignWorkerType(
in In_FWorkerTypeCode char(20),
in In_FWorkerTypeDesc char(100),
in In_FWorkerDailyRate numeric(6,2),
in In_FWorkerMaxMthRate numeric(6,2))
begin
  if exists(select* from ForeignWorkerType where
      ForeignWorkerType.FWorkerTypeCode = In_FWorkerTypeCode) then
    update ForeignWorkerType set
      ForeignWorkerType.FWorkerTypeDesc = In_FWorkerTypeDesc,
      ForeignWorkerType.FWorkerDailyRate = In_FWorkerDailyRate,
      ForeignWorkerType.FWorkerMaxMthRate = In_FWorkerMaxMthRate where
      ForeignWorkerType.FWorkerTypeCode = In_FWorkerTypeCode;
    commit work
  end if
end
;

create procedure dba.UpdateGenderDesc(
in In_GenderCodeId char(1),
in In_GenderCodeName char(30))
begin
  if exists(select* from GenderCode where
      GenderCode.GenderCodeId = In_GenderCodeId) then
    update GenderCode set
      GenderCode.GenderCodeName = In_GenderCodeName where
      GenderCode.GenderCodeId = In_GenderCodeId;
    commit work
  end if
end
;

create procedure dba.UpdateGovContribType(
in In_CountryId char(10),
in In_GovContribTypeId char(20),
in In_GovContribTypeName char(100))
begin
  if exists(select* from GovermentContribType where
      GovermentContribType.GovContribTypeId = In_GovContribTypeId and
      GovermentContribType.CountryId = In_CountryId) then
    update GovermentContribType set
      GovermentContribType.GovContribTypeName = In_GovContribTypeName where
      GovermentContribType.GovContribTypeId = In_GovContribTypeId and
      GovermentContribType.CountryId = In_CountryId;
    commit work
  end if
end
;

create procedure dba.UpdateGroupLeavePatternWeekNo(
in In_CalendarId char(20),
in In_WeekLeavePatternId char(20),
in In_GroupLeavePatternWeekNo integer,
in In_NewGroupLeavePatternWeekNo integer)
begin
  if not exists(select* from GroupLeavePattern where
      GroupLeavePattern.CalendarId = In_CalendarId and
      GroupLeavePattern.WeekLeavePatternId = In_WeekLeavePatternId and
      GroupLeavePattern.GroupLeavePatternWeekNo = In_NewGroupLeavePatternWeekNo) then
    update GroupLeavePattern set
      GroupLeavePattern.GroupLeavePatternWeekNo = In_NewGroupLeavePatternWeekNo where
      GroupLeavePattern.CalendarId = In_CalendarId and
      GroupLeavePattern.WeekLeavePatternId = In_WeekLeavePatternId and
      GroupLeavePattern.GroupLeavePatternWeekNo = In_GroupLeavePatternWeekNo;
    commit work
  end if
end
;

create procedure dba.UpdateGroupWorkPatternWeekNo(
in In_CalendarId char(20),
in In_WeekPatternId char(20),
in In_GroupWorkPatternWeekNo integer,
in In_NewGroupWorkPatternWeekNo integer)
begin
  if not exists(select* from GroupWorkPattern where
      GroupWorkPattern.CalendarId = In_CalendarId and
      GroupWorkPattern.WeekPatternId = In_WeekPatternId and
      GroupWorkPattern.GroupWorkPatternWeekNo = In_NewGroupWorkPatternWeekNo) then
    update GroupWorkPattern set
      GroupWorkPattern.GroupWorkPatternWeekNo = In_NewGroupWorkPatternWeekNo where
      GroupWorkPattern.CalendarId = In_CalendarId and
      GroupWorkPattern.WeekPatternId = In_WeekPatternId and
      GroupWorkPattern.GroupWorkPatternWeekNo = In_GroupWorkPatternWeekNo;
    commit work
  end if
end
;

create procedure dba.UpdateHoliday(
in In_HolidayId char(20),
in In_HolidayDesc char(80),
in In_HolidayStartDate date,
in In_CountryId char(20),
in In_HolidayLvePattern numeric(8,4),
in In_HolidayWorkPattern numeric(8,4),
in In_HolidayEndDate date)
begin
  if exists(select* from Holidays where Holidays.HolidayId = In_HolidayId and
      Holidays.HolidayStartDate = In_HolidayStartDate and
      Holidays.CountryId = In_CountryId) then
    update Holidays set
      Holidays.HolidayDesc = In_HolidayDesc,
      Holidays.HolidayStartDate = In_HolidayStartDate,
      Holidays.HolidayLvePattern = In_HolidayLvePattern,
      Holidays.HolidayEndDate = In_HolidayEndDate,
      Holidays.HolidayWorkPattern = In_HolidayWorkPattern where
      Holidays.HolidayId = In_HolidayId and
      Holidays.HolidayStartDate = In_HolidayStartDate and
      Holidays.CountryId = In_CountryId;
    commit work
  end if
end
;

create procedure dba.UpdateIdentityTypeDesc(
in In_IdentityTypeId char(20),
in In_IdentityTypeDesc char(60))
begin
  if exists(select* from IdentityType where
      IdentityType.IdentityTypeId = In_IdentityTypeId) then
    update IdentityType set
      IdentityType.IdentityTypeDesc = In_IdentityTypeDesc where
      IdentityType.IdentityTypeId = In_IdentityTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateLanguage(
in In_LanguageId char(20),
in In_LanguageDesc char(80),
out Out_ErrorCode integer)
begin
  if exists(select* from Language where LanguageId = In_LanguageId) then
    update Language set
      LanguageDesc = In_LanguageDesc where
      LanguageId = In_LanguageId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateLoginRec(
in In_UserId char(20))
begin
  declare TS_LogoutTimeStamp timestamp;
  set TS_LogoutTimeStamp=Now(*);
  update LoginRec set
    LoginRec.ModuleLogoutTime = TS_LogoutTimeStamp where
    LoginRec.UserId = In_UserId and
    LoginRec.ModuleLogoutTime is null;
  commit work
end
;

create procedure dba.UpdateMaritalStatusDesc(
in In_MariStatusCode char(20),
in In_MariStatusDesc char(60))
begin
  if exists(select* from MaritalStatus where MaritalStatus.MaritalStatusCode = In_MariStatusCode) then
    update MaritalStatus set
      MaritalStatus.MaritalStatusDesc = IN_MariStatusDesc where
      MaritalStatus.MaritalStatusCode = IN_MariStatusCode;
    commit work
  end if
end
;

create procedure dba.UpdateModuleScreenGroup(
in In_ModuleScreenId char(20),
in In_Mod_NewModuleScreenId char(20),
in In_ModuleScreenName char(100),
in In_MainModuleName char(100),
in In_Mod_OldModuleScreenId char(20),
in In_HideOnlyWage smallint,
in In_HideScreenForWage smallint)
begin
  if exists(select* from ModuleScreenGroup where
      ModuleScreenGroup.ModuleScreenId = In_ModuleScreenId and
      ModuleScreenGroup.Mod_ModuleScreenId = In_Mod_OldModuleScreenId) then
    update ModuleScreenGroup set
      ModuleScreenGroup.MainModuleName = In_MainModuleScreenId,
      ModuleScreenGroup.ModuleScreenName = In_ModuleScreenName,
      ModuleScreenGroup.Mod_ModuleScreenId = In_Mod_NewModuleScreenId,
      ModuleScreenGroup.HideOnlyWage = In_HideOnlyWage,
      ModuleScreenGroup.HideScreenForWage = In_HideScreenForWage where
      ModuleScreenGroup.ModuleScreenId = In_ModuleScreenId and
      ModuleScreenGroup.Mod_ModuleScreenId = In_Mod_OldModuleScreenId;
    commit work
  end if
end
;

create procedure dba.UpdateNewLabelName(
in In_DefaultLName char(100),
in In_NewLName char(100))
begin
  update LabelName set
    LabelName.NewLName = In_NewLName where
    LabelName.DefaultLName = In_DefaultLName;
  commit work
end
;

create procedure dba.UpdateOccupation(
in In_OccupationId char(20),
in In_OccupationDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from Occupation where OccupationId = In_OccupationId) then
    update Occupation set
      OccupationDesc = In_OccupationDesc where
      OccupationId = In_OccupationId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdatePaymentBankInfo(
in In_PayBankSGSPGenId char(30),
in In_BankId char(20),
in In_BankBranchId char(20),
in In_BankAccountNo char(30),
in In_PaymentValue numeric(10,2),
in In_PaymentType char(20),
in In_BankAccTypeId char(20),
in In_PaymentMode char(20),
in In_BankRemarks char(100),
in In_BeneficiaryName char(150),
in In_BankAllocGpId char(20))
begin
  if exists(select* from PaymentBankInfo where
      PaymentBankInfo.PayBankSGSPGenId = In_PayBankSGSPGenId) then
    update PaymentBankInfo set
      PaymentBankInfo.BankId = In_BankId,
      PaymentBankInfo.BankBranchId = In_BankBranchId,
      PaymentBankInfo.BankAccountNo = In_BankAccountNo,
      PaymentBankInfo.PaymentValue = In_PaymentValue,
      PaymentBankInfo.PaymentType = In_PaymentType,
      PaymentBankInfo.BankAccTypeId = In_BankAccTypeId,
      PaymentBankInfo.PaymentMode = In_PaymentMode,
      PaymentBankInfo.BankRemarks = In_BankRemarks,
      PaymentBankInfo.BeneficiaryName = In_BeneficiaryName,
      PaymentBankInfo.BankAllocGpId = In_BankAllocGpId where
      PaymentBankInfo.PayBankSGSPGenId = In_PayBankSGSPGenId;
    commit work
  end if
end
;

create procedure dba.UpdatePensionOptionDesc(
in In_PensionOptionId char(20),
in In_PensionOptionDesc char(100))
begin
  if exists(select* from PensionOption where
      PensionOption.PensionOptionId = In_PensionOptionId) then
    update PensionOption set
      PensionOption.PensionOptionDesc = In_PensionOptionDesc where
      PensionOption.PensionOptionId = In_PensionOptionId;
    commit work
  end if
end
;

create procedure
dba.UpdatePersonalAddress(in In_PersonalAddressId integer,in In_ContactLocationId char(20),in In_Address1 char(150),in In_Address2 char(150),in In_Address3 char(150),in In_Country char(60),in In_City char(60),in In_State char(60),in In_PCode char(20),in In_PersonalSysId integer,in In_PersonalAddMailing smallint)
begin
  if exists(select* from PersonalAddress where
      PersonalAddress.PersonalAddressId = In_PersonalAddressId and
      PersonalAddress.PersonalSysId = In_PersonalSysId) then
    if(In_PersonalAddMailing = 1) then
      call ASQLSetPersonalAddressDefault(In_PersonalSysId)
    end if;
    update PersonalAddress set
      PersonalAddress.ContactLocationId = In_ContactLocationId,
      PersonalAddress.PersonalAddAddress = In_Address1,
      PersonalAddress.PersonalAddAddress2 = In_Address2,
      PersonalAddress.PersonalAddAddress3 = In_Address3,
      PersonalAddress.PersonalAddCountry = In_Country,
      PersonalAddress.PersonalAddCity = In_City,
      PersonalAddress.PersonalAddState = In_State,
      PersonalAddress.PersonalAddPCode = In_PCode,
      PersonalAddress.PersonalAddMailing = In_PersonalAddMailing where
      PersonalAddress.PersonalAddressId = In_PersonalAddressId and
      PersonalAddress.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.UpdatePersonalContact(
in In_PersonalContactId integer,
in In_ContactLocationId char(20),
in In_ContactNumber char(30),
in In_Extension char(10),
in In_PersonalSysId integer)
begin
  if exists(select* from PersonalContact where
      PersonalContact.PersonalContactId = In_PersonalContactId and
      PersonalContact.PersonalSysId = In_PersonalSysId) then
    update PersonalContact set
      PersonalContact.ContactLocationId = In_ContactLocationId,
      PersonalContact.ContactNumber = In_ContactNumber,
      PersonalContact.Extension = In_Extension where
      PersonalContact.PersonalContactId = In_PersonalContactId and
      PersonalContact.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.UpdatePersonalDetails(
in In_PersonalSysId integer,
in In_IdentityNo char(30),
in In_IdentityTypeCode char(20),
in In_MaritalStatusCode char(10),
in In_RaceId char(20),
in In_ReligionID char(20),
in In_TitleId char(20),
in In_BloodGroupId char(10),
in In_CountryOfBirth char(60),
in In_DateOfBirth date,
in In_PersonalName char(150),
in In_Alias char(100),
in In_Gender char(1),
in In_Nationality char(60),
in In_Height decimal(6,3),
in In_Weight decimal(7,4),
in In_IdentityCheckDigit char(5),
in In_PersonalTypeId char(20),
in In_Mal_OldIdentity char(30),
in In_FirstName char(50),
in In_MiddleName char(50),
in In_LastName char(50),
in In_MiddleInitial char(10),
in In_PassportIssue char(20),
in In_IdentityIssueBy char(20))
begin
  declare Old_DateOfBirth date;
  /*
  if Country is philippine, combine the three names into one PersonalName
  */
  declare CombinedPersonalName char(150);
  if FGetDBCountry(*) = 'Philippines' then
    if(In_FirstName <> '') then
      set CombinedPersonalName=In_FirstName+' '
    end if;
    if(In_MiddleInitial <> '') then
      set CombinedPersonalName=CombinedPersonalName+In_MiddleInitial+' '
    end if;
    if(In_LastName <> '') then
      set CombinedPersonalName=CombinedPersonalName+In_LastName
    end if;
    set In_PersonalName=trim(CombinedPersonalName)
  end if;
  /*
  if Country is HongKong, combine the PersonalName = FirstName(Surname) + MiddleName (OtherName)
  example: Ng (surname) Man Tat (other name)
  */
  if FGetDBCountry(*) = 'HongKong' then
    if(In_FirstName <> '') then
      set CombinedPersonalName=In_FirstName+' '
    end if;
    if(In_MiddleName <> '') then
      set CombinedPersonalName=CombinedPersonalName+In_MiddleName+' '
    end if;
    set In_PersonalName=trim(CombinedPersonalName)
  end if;
  if exists(select* from Personal where Personal.PersonalSysId = In_PersonalSysId) then
    select DateOfBirth into Old_DateOfBirth from Personal where PersonalSysId = In_PersonalSysId;
    update Personal set
      Personal.IdentityNo = In_IdentityNo,
      Personal.IdentityTypeId = In_IdentityTypeCode,
      Personal.MaritalStatusCode = In_MaritalStatusCode,
      Personal.RaceId = In_RaceId,
      Personal.ReligionID = In_ReligionID,
      Personal.TitleId = In_TitleId,
      Personal.BloodGroupId = In_BloodGroupId,
      Personal.CountryOfBirth = In_CountryOfBirth,
      Personal.DateOfBirth = In_DateOfBirth,
      Personal.PersonalName = In_PersonalName,
      Personal.Alias = In_Alias,
      Personal.Gender = In_Gender,
      Personal.Nationality = In_Nationality,
      Personal.Height = In_Height,
      Personal.Weight = In_Weight,
      Personal.IdentityCheckDigit = In_IdentityCheckDigit,
      Personal.PersonalTypeId = In_PersonalTypeId,
      Personal.Mal_OldIdentity = In_Mal_OldIdentity,
      Personal.FirstName = In_FirstName,
      Personal.MiddleName = In_MiddleName,
      Personal.LastName = In_LastName,
      Personal.MiddleInitial = In_MiddleInitial,
      Personal.PassportIssue = In_PassportIssue,
      Personal.IdentityIssueBy = In_IdentityIssueBy where
      Personal.PersonalSysId = In_PersonalSysId;
    update Employee set
      Employee.IdentityNo = In_IdentityNo,
      Employee.IdentityTypeCode = In_IdentityTypeCode,
      Employee.MaritalStatusCode = In_MaritalStatusCode,
      Employee.RaceId = In_RaceId,
      Employee.ReligionID = In_ReligionID,
      Employee.TitleId = In_TitleId,
      Employee.CountryOfBirth = In_CountryOfBirth,
      Employee.DateOfBirth = In_DateOfBirth,
      Employee.EmployeeName = In_PersonalName,
      Employee.Gender = In_Gender,
      Employee.Nationality = In_Nationality where
      Employee.PersonalSysId = In_PersonalSysId;
    if(Old_DateOfBirth <> In_DateOfBirth) then
      update ResidenceStatusRecord set
        ResStatusEffectiveDate = In_DateOfBirth where
        PersonalSysId = In_PersonalSysId and
        ResStatusEffectiveDate = Old_DateOfBirth
    end if;
    if FGetDBCountry(*) = 'Singapore' then
      update PaymentBankInfo set
        BeneficiaryName = In_PersonalName where
        EmployeeSysId = any(select EmployeeSysId from Employee where
          PersonalSysId = In_PersonalSysId);
      if(In_PersonalTypeId <> 'Casual Only') then
        update PayEmployee set EECPFPaidByER = 0 where
          EmployeeSysId = any(select EmployeeSysId from Employee where PersonalsysId = In_PersonalSysId)
      end if
    end if;
    commit work
  end if
end
;

create procedure dba.UpdatePersonalEmail(
in In_PersonalEmailId integer,
in In_ContactLocationId char(20),
in In_PersonalEmail char(60),
in In_PersonalSysId integer)
begin
  if exists(select* from PersonalEmail where
      PersonalEmail.PersonalEmailId = In_PersonalEmailId and
      PersonalEmail.PersonalSysId = In_PersonalSysId) then
    update PersonalEmail set
      PersonalEmail.ContactLocationId = In_ContactLocationId,
      PersonalEmail.PersonalEmail = In_PersonalEmail where
      PersonalEmail.PersonalEmailId = In_PersonalEmailId and
      PersonalEmail.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.UpdatePosGrp(
in In_PositionGrpId char(20),
in In_PositionGrpDesc char(100),
in In_PositionGrpLevel integer,
out Out_ErrorCode integer)
begin
  if exists(select* from PosGrp where PositionGrpId = In_PositionGrpId) then
    if not exists(select* from PosGrp where PosGrp.PositionGrpId = In_PositionGrpId and PositionGrpLevel = In_PositionGrpLevel) then
      delete from CareerPath where Pos_PositionId = any(select* from PositionCode where PositionCode.PositionGrpId = In_PositionGrpId);
      commit work
    end if;
    update PosGrp set
      PositionGrpDesc = In_PositionGrpDesc,
      PositionGrpLevel = In_PositionGrpLevel where
      PositionGrpId = In_PositionGrpId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdatePosition(
in In_PositionId char(20),
in In_PositionDesc char(80),
in In_KeyPosition integer,
in In_PositionGrpId char(20))
begin
  if exists(select* from PositionCode where PositionCode.PositionId = In_PositionId) then
    if not exists(select* from PositionCode where PositionCode.PositionId = In_PositionId and PositionGrpId = In_PositionGrpId) then
      delete from CareerPath where
        CareerPath.Pos_PositionId = In_PositionId;
      commit work
    end if;
    update PositionCode set
      PositionCode.PositionDesc = In_PositionDesc,
      PositionCode.KeyPosition = In_KeyPosition,
      PositionCode.PositionGrpId = In_PositionGrpId where
      PositionCode.PositionId = In_PositionId;
    commit work
  end if
end
;

create procedure dba.UpdateRaceDesc(
in In_RaceId char(20),
in In_RaceDesc char(60))
begin
  if exists(select* from Race where Race.RaceId = In_RaceId) then
    update Race set
      Race.RaceDesc = IN_RaceDesc where
      Race.RaceId = IN_RaceId;
    commit work
  end if
end
;

create procedure dba.UpdateRelationshipDesc(
in In_RelationshipId char(20),
in In_RelationshipDesc char(60))
begin
  if exists(select* from Relationship where
      Relationship.RelationshipId = In_RelationshipId) then
    update Relationship set
      Relationship.RelationshipDesc = In_RelationshipDesc where
      Relationship.RelationshipId = In_RelationshipId;
    commit work
  end if
end
;

create procedure dba.UpdateReligionDesc(
in In_ReligionId char(20),
in In_ReligionType char(60))
begin
  if exists(select* from Religion where Religion.ReligionId = In_ReligionId) then
    update Religion set
      Religion.ReligionType = IN_ReligionType where
      Religion.ReligionId = IN_ReligionId;
    commit work
  end if
end
;

create procedure dba.UpdateResidenceTypeDesc(
in In_ResidenceTypeId char(20),
in In_ResidenceTypeDesc char(100))
begin
  if exists(select* from ResidenceType where
      ResidenceType.ResidenceTypeId = In_ResidenceTypeId) then
    update ResidenceType set
      ResidenceType.ResidenceTypeDesc = In_ResidenceTypeDesc where
      ResidenceType.ResidenceTypeId = In_ResidenceTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateResponsibility(
in In_ResponsibilityId char(20),
in In_ResponsibilityDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from Responsibility where ResponsibilityId = In_ResponsibilityId) then
    update Responsibility set
      ResponsibilityDesc = In_ResponsibilityDesc where
      ResponsibilityId = In_ResponsibilityId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateResStatusRec(
in In_ResStatusEffectiveDate date,
in In_ResidenceTypeId char(20),
in In_PersonalSysId integer,
in In_ResStatusCurrent integer,
in In_ResStatusCareerId char(20),
in In_ResStatusRemarks char(100))
begin
  if exists(select* from ResidenceStatusRecord where
      ResidenceStatusRecord.ResStatusEffectiveDate = In_ResStatusEffectiveDate and
      ResidenceStatusRecord.PersonalSysId = In_PersonalSysId) then
    if(In_ResStatusCurrent = 1) then
      update ResidenceStatusRecord set
        ResidenceStatusRecord.ResStatusCurrent = 0 where
        ResidenceStatusRecord.ResStatusCurrent = 1 and ResidenceStatusRecord.PersonalSysId = In_PersonalSysId;
      update Employee set
        Employee.ResidenceStatus = In_ResidenceTypeId where
        Employee.PersonalSysId = In_PersonalSysId
    end if;
    update ResidenceStatusRecord set
      ResidenceStatusRecord.ResStatusCurrent = In_ResStatusCurrent,
      ResidenceStatusRecord.ResStatusCareerId = In_ResStatusCareerId,
      ResidenceStatusRecord.ResStatusRemarks = In_ResStatusRemarks,
      ResidenceStatusRecord.ResidenceTypeId = In_ResidenceTypeId where
      ResidenceStatusRecord.ResStatusEffectiveDate = In_ResStatusEffectiveDate and
      ResidenceStatusRecord.PersonalSysId = In_PersonalSysId
  end if;
  commit work
end
;

create procedure dba.UpdateSalaryGrade(
in In_SalaryGradeId char(20),
in In_SalaryGradeDesc char(100),
in In_MinBasicRate double,
in In_MaxBasicRate double,
in In_MaxBRIncPercent double,
in In_MaxBRIncAmt double)
begin
  if exists(select* from SalaryGrade where SalaryGrade.SalaryGradeId = In_SalaryGradeId) then
    update SalaryGrade set
      SalaryGrade.SalaryGradeDesc = In_SalaryGradeDesc,
      SalaryGrade.MinBasicRate = In_MinBasicRate,
      SalaryGrade.MaxBasicRate = In_MaxBasicRate,
      SalaryGrade.MaxBRIncPercent = In_MaxBRIncPercent,
      SalaryGrade.MaxBRIncAmt = In_MaxBRIncAmt where
      SalaryGrade.SalaryGradeId = In_SalaryGradeId;
    commit work
  end if
end
;

create procedure dba.UpdateSectionDesc(
in In_SectionID char(20),
in In_SectionDesc char(60))
begin
  if exists(select* from Section where Section.SectionId = In_SectionId) then
    update Section set
      Section.SectionDesc = IN_SectionDesc where
      Section.SectionId = IN_SectionId;
    commit work
  end if
end
;

create procedure dba.UpdateStateName(
in In_CountryId char(10),
in In_StateId char(20),
in In_StateName char(60))
begin
  if exists(select* from State where State.CountryId = In_CountryId and
      State.StateId = In_StateId) then
    update State set
      State.StateName = In_StateName where
      State.CountryId = In_CountryId and
      State.StateId = In_StateId;
    commit work
  end if
end
;

create procedure dba.UpdateSystemUser(
in In_UserId char(20),
in In_UserGroupId char(20),
in In_UserPassword char(50),
in In_ExpiryDate date,
in In_FirstTimeLogin integer,
in In_SysPersonalSysId integer,
in In_IsDirServices smallint,
in In_DirServicesUserName char(200),
in In_DirServicesDomainName char(200))
begin
  if exists(select* from SystemUser where SystemUser.UserId = In_UserId) then
    update SystemUser set
      SystemUser.UserGroupId = In_UserGroupId,
      SystemUser.UserPassword = In_UserPassword,
      SystemUser.ExpiryDate = In_ExpiryDate,
      SystemUser.FirstTimeLogin = In_FirstTimeLogin,
      SystemUser.SysPersonalSysId = In_SysPersonalSysId,
      SystemUser.IsDirServices = In_IsDirServices,
      SystemUser.DirServicesUserName = In_DirServicesUserName,
      SystemUser.DirServicesDomainName = In_DirServicesDomainName where
      SystemUser.UserId = In_UserId;
    commit work
  end if
end
;

create procedure dba.UpdateTitleCodeDesc(
in In_TitleId char(20),
in In_TitleDesc char(60))
begin
  if exists(select* from TitleCode where TitleCode.TitleId = In_TitleId) then
    update TitleCode set
      TitleCode.TitleDesc = IN_TitleDesc where
      TitleCode.TitleId = IN_TitleId;
    commit work
  end if
end
;

create procedure dba.UpdateUserGroupDesc(
in In_UserGroupId char(20),
in In_UserGroupDesc char(80),
in In_UserGroupHideWage smallint)
begin
  if exists(select* from UserGroup where UserGroup.UserGroupId = In_UserGroupId) then
    update UserGroup set
      UserGroup.UserGroupDesc = IN_UserGroupDesc,
      UserGroup.UserGroupHideWage = IN_UserGroupHideWage where
      UserGroup.UserGroupId = IN_UserGroupId;
    commit work
  end if
end
;

create procedure dba.UpdateUserModuleNoAccess(
in In_ModuleScreenId char(20),
in In_UserGroupId char(20),
in In_NewModuleScreenId char(20))
begin
  if exists(select* from UserModuleNoAccess where
      UserModuleNoAccess.ModuleScreenId = In_ModuleScreenId and
      UserModuleNoAccess.UserGroupId = In_UserGroupId) then
    if not exists(select* from UserModuleNoAccess where
        UserModuleNoAccess.ModuleScreenId = In_NewModuleScreenId and
        UserModuleNoAccess.UserGroupId = In_UserGroupId) then
      update UserModuleNoAccess set
        UserModuleNoAccess.ModuleScreenId = In_NewModuleScreenId where
        UserModuleNoAccess.ModuleScreenId = In_ModuleScreenId and
        UserModuleNoAccess.UserGroupId = In_UserGroupId;
      commit work
    end if
  end if
end
;

create procedure dba.UpdateUserSearchSetting(
in In_UserID char(20),
in In_SearchID char(20),
in In_SearchDescription char(40),
in In_SearchField char(20),
in In_SearchOption char(20),
in In_SearchString char(100))
begin
  if exists(select* from UserSearchSetting where
      UserSearchSetting.UserID = In_UserID and
      UserSearchSetting.SearchID = In_SearchID) then
    update UserSearchSetting set
      SearchDescription = In_SearchDescription,
      SearchField = In_SearchField,
      SearchOption = In_SearchOption,
      SearchString = In_SearchString where
      UserID = In_UserID and
      SearchID = In_SearchID;
    commit work
  end if
end
;

create procedure dba.UpdateUserSecurityQuery(
in In_QueryRecId char(20),
in In_UserGroupId char(60),
in In_OldQueryRecId char(20))
begin
  if exists(select* from UserSecurityQuery where
      UserSecurityQuery.UserGroupId = In_UserGroupId and
      UserSecurityQuery.QueryRecId = In_OldQueryRecId) then
    update UserSecurityQuery set
      UserSecurityQuery.QueryRecId = In_QueryRecId where
      UserSecurityQuery.UserGroupId = In_UserGroupId and
      UserSecurityQuery.QueryRecId = In_OldQueryRecId;
    commit work
  end if
end
;

create procedure dba.UpdateWeekLeavePattern(
in In_WeekLeavePatternId char(20),
in In_LveMonday decimal(4,3),
in In_LveTuesday decimal(4,3),
in In_LveWenesday decimal(4,3),
in In_LveThursday decimal(4,3),
in In_LveFriday decimal(4,3),
in In_LveSaturday decimal(4,3),
in In_LveSunday decimal(4,3))
begin
  if exists(select* from WeekLeavePattern where
      WeekLeavePattern.WeekLeavePatternId = In_WeekLeavePatternId) then
    update WeekLeavePattern set
      WeekLeavePattern.LveMonday = In_LveMonday,
      WeekLeavePattern.LveTuesday = In_LveTuesday,
      WeekLeavePattern.LveWenesday = In_LveWenesday,
      WeekLeavePattern.LveThursday = In_LveThursday,
      WeekLeavePattern.LveFriday = In_LveFriday,
      WeekLeavePattern.LveSaturday = In_LveSaturday,
      WeekLeavePattern.LveSunday = In_LveSunday where
      WeekLeavePattern.WeekLeavePatternId = In_WeekLeavePatternId;
    commit work
  end if
end
;

create procedure dba.UpdateWeekWorkPattern(
in In_WeekPatternId char(20),
in In_WWrkMon decimal(4,3),
in In_WWrkTue decimal(4,3),
in In_WWrkWed decimal(4,3),
in In_WWrkThur decimal(4,3),
in In_WWrkFri decimal(4,3),
in In_WWrkSat decimal(4,3),
in In_WWrkSun decimal(4,3))
begin
  if exists(select* from WeekWorkPattern where
      WeekWorkPattern.WeekPatternId = In_WeekPatternId) then
    update WeekWorkPattern set
      WeekWorkPattern.WWrkMon = In_WWrkMon,
      WeekWorkPattern.WWrkTue = In_WWrkTue,
      WeekWorkPattern.WWrkWed = In_WWrkWed,
      WeekWorkPattern.WWrkThur = In_WWrkThur,
      WeekWorkPattern.WWrkFri = In_WWrkFri,
      WeekWorkPattern.WWrkSat = In_WWrkSat,
      WeekWorkPattern.WWrkSun = In_WWrkSun where
      WeekWorkPattern.WeekPatternId = In_WeekPatternId;
    commit work
  end if
end
;

create procedure dba.InsertNewOtherBankInfo(
in In_EmployeeSysId integer,
in In_BankAccTypeId char(20),
in In_BankId char(20),
in In_BankBranchId char(20),
in In_BankAccountNo char(30),
in In_SubmitFor char(20),
in In_PaymentMode char(20),
in In_OtherBankInfoRemarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from OtherBankInfo where EmployeeSysId = In_EmployeeSysId and SubmitFor = In_SubmitFor) then
    set Out_ErrorCode=-1; // Record exists
    return
  elseif not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-2; // EmployeeSysId not exist
    return
  else
    insert into OtherBankInfo(EmployeeSysId,BankAccTypeId,BankId,BankBranchId,BankAccountNo,SubmitFor,PaymentMode,OtherBankInfoRemarks) values(
      In_EmployeeSysId,In_BankAccTypeId,In_BankId,In_BankBranchId,In_BankAccountNo,In_SubmitFor,In_PaymentMode,In_OtherBankInfoRemarks);
    commit work
  end if;
  if not exists(select* from OtherBankInfo where EmployeeSysId = In_EmployeeSysId and SubmitFor = In_SubmitFor) then
    set Out_ErrorCode=0; // System error
    return
  else
    // Successful: set error code to OtherBankInfoSysId for the new record
    set Out_ErrorCode=(select OtherBankInfoSysId from OtherBankInfo where EmployeeSysId = In_EmployeeSysId and SubmitFor = In_SubmitFor)
  end if
end
;

create procedure dba.UpdateOtherBankInfo(
in In_OtherBankInfoSysId integer,
in In_EmployeeSysId integer,
in In_BankAccTypeId char(20),
in In_BankId char(20),
in In_BankBranchId char(20),
in In_BankAccountNo char(30),
in In_SubmitFor char(20),
in In_PaymentMode char(20),
in In_OtherBankInfoRemarks char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from OtherBankInfo where EmployeeSysId = In_EmployeeSysId and SubmitFor = In_SubmitFor) then
    set Out_ErrorCode=-1; // Record not exists
    return
  elseif not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-2; // EmployeeSysId not exist
    return
  else
    update OtherBankInfo set
      EmployeeSysId = In_EmployeeSysId,
      BankAccTypeId = In_BankAccTypeId,
      BankId = In_BankId,
      BankBranchId = In_BankBranchId,
      BankAccountNo = In_BankAccountNo,
      SubmitFor = In_SubmitFor,
      PaymentMode = In_PaymentMode,
      OtherBankInfoRemarks = In_OtherBankInfoRemarks where
      OtherBankInfoSysId = In_OtherBankInfoSysId;
    commit work
  end if;
  if not exists(select* from OtherBankInfo where EmployeeSysId = In_EmployeeSysId and SubmitFor = In_SubmitFor) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.DeleteOtherBankInfo(
in In_OtherBankInfoSysId integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from OtherBankInfo where OtherBankInfoSysId = In_OtherBankInfoSysId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    delete from OtherBankInfo where
      OtherBankInfoSysId = In_OtherBankInfoSysId;
    commit work
  end if;
  if exists(select* from OtherBankInfo where OtherBankInfoSysId = In_OtherBankInfoSysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.ASQLRefreshEmpeeOtherInfo(
in In_EmployeeSysId integer,
in In_EmpeeOtherInfoDataType char(100),
out Out_ErrorCode integer)
begin
  declare Out_ResStatus char(30);
  declare Out_IdentityNo char(20);
  if not exists(select* from Employee where Employee.EmployeeSysId = In_EmployeeSysId) then
    set Out_ErrorCode=-1; // Record not exists
    return
  else
    if In_EmpeeOtherInfoDataType is null or In_EmpeeOtherInfoDataType = '' then
      set In_EmpeeOtherInfoDataType='%'
    end if;
    EmpeeOtherInfoLoop: for EmpeeOtherInfoForLoop as Cur_EmpeeOtherInfo dynamic scroll cursor for
      select SubRegistryId as In_EmpeeOtherInfoId,RegProperty1 as In_EmpeeOtherInfoCaption,RegProperty2 as In_EmpeeOtherInfoType from
        Subregistry where
        RegistryId = 'EmpeeOtherInfo' and
        RegProperty2 like In_EmpeeOtherInfoDataType and
        In_EmpeeOtherInfoCaption <> '' do
      if not exists(select* from EmpeeOtherInfo where
          EmpeeOtherInfoId = In_EmpeeOtherInfoId and
          EmployeeSysId = In_EmployeeSysId) then
        if(In_EmpeeOtherInfoId = 'SOCSONo') then
          // special processing for SOCSONo
          select FGetCurrentResStatus(PersonalSysId) into Out_ResStatus from Employee where EmployeeSysId = In_EmployeeSysId;
          if(Out_ResStatus = 'Local') then
            select IdentityNo into Out_IdentityNo from Employee where EmployeeSysId = In_EmployeeSysId
          else
            set Out_IdentityNo=''
          end if;
          call InsertNewEmpeeOtherInfo(In_EmployeeSysId,In_EmpeeOtherInfoId,In_EmpeeOtherInfoType,In_EmpeeOtherInfoCaption,null,Out_IdentityNo,0,0)
        else
          // normal insert
          call InsertNewEmpeeOtherInfo(In_EmployeeSysId,In_EmpeeOtherInfoId,In_EmpeeOtherInfoType,In_EmpeeOtherInfoCaption,null,'',0,0)
        end if
      else
        update EmpeeOtherInfo set
          EmpeeOtherInfoCaption = In_EmpeeOtherInfoCaption,
          EmpeeOtherInfoType = In_EmpeeOtherInfoType where
          EmpeeOtherInfoId = In_EmpeeOtherInfoId and
          EmployeeSysId = In_EmployeeSysId
      end if end for;
    commit work
  end if
end
;

create procedure dba.InsertNewEmpeeOtherInfo(
in In_EmployeeSysId integer,
in In_EmpeeOtherInfoId char(20),
in In_EmpeeOtherInfoType char(20),
in In_EmpeeOtherInfoCaption char(100),
in In_EmpeeOtherInfoDate date,
in In_EmpeeOtherInfoString char(20),
in In_EmpeeOtherInfoBoolean smallint,
in In_EmpeeOtherInfoDouble double,
out Out_ErrorCode integer)
begin
  if exists(select* from EmpeeOtherInfo where EmployeeSysId = In_EmployeeSysId and EmpeeOtherInfoId = In_EmpeeOtherInfoId) then
    set Out_ErrorCode=-1; // Record exists
    return
  elseif not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-2; // EmployeeSysId not exist
    return
  else
    insert into EmpeeOtherInfo(EmployeeSysId,EmpeeOtherInfoId,EmpeeOtherInfoType,EmpeeOtherInfoCaption,EmpeeOtherInfoDate,EmpeeOtherInfoString,EmpeeOtherInfoBoolean,EmpeeOtherInfoDouble) values(
      In_EmployeeSysId,In_EmpeeOtherInfoId,In_EmpeeOtherInfoType,In_EmpeeOtherInfoCaption,In_EmpeeOtherInfoDate,In_EmpeeOtherInfoString,In_EmpeeOtherInfoBoolean,In_EmpeeOtherInfoDouble);
    commit work
  end if;
  if not exists(select* from EmpeeOtherInfo where EmployeeSysId = In_EmployeeSysId and EmpeeOtherInfoId = In_EmpeeOtherInfoId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.DeleteEmpeeOtherInfo(
in In_EmployeeSysId integer,
in In_EmpeeOtherInfoId char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from EmpeeOtherInfo where EmployeeSysId = In_EmployeeSysId and EmpeeOtherInfoId = In_EmpeeOtherInfoId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    delete from EmpeeOtherInfo where
      EmployeeSysId = In_EmployeeSysId and
      EmpeeOtherInfoId = In_EmpeeOtherInfoId;
    commit work
  end if;
  if exists(select* from EmpeeOtherInfo where EmployeeSysId = In_EmployeeSysId and EmpeeOtherInfoId = In_EmpeeOtherInfoId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create function DBA.FGetEmpeeOtherInfoBooleanInfo(
in In_Type char(30),
in In_EmployeeSysId integer)
returns integer
begin
  declare Out_Result integer;
  select EmpeeOtherInfo.EmpeeOtherInfoBoolean into Out_Result
    from EmpeeOtherInfo where EmpeeOtherInfo.EmployeeSysId = In_EmployeeSysId and
    EmpeeOtherInfo.EmpeeOtherInfoId = In_Type;
  return(Out_Result)
end
;

create function DBA.FGetEmpeeOtherInfoStringInfo(
in In_Type char(30),
in In_EmployeeSysId integer)
returns char(20)
begin
  declare Out_Result char(20);
  select EmpeeOtherInfo.EmpeeOtherInfoString into Out_Result
    from EmpeeOtherInfo where EmpeeOtherInfo.EmployeeSysId = In_EmployeeSysId and
    EmpeeOtherInfo.EmpeeOtherInfoId = In_Type;
  return(Out_Result)
end
;

create function DBA.FGetPersonalBirthDate(
in In_PersonalSysId integer)
returns char(30)
begin
  declare Out_BirthDate char(30);
  select Personal.DateOfBirth into Out_BirthDate
    from Personal where Personal.PersonalSysId = In_PersonalSysId;
  return(Out_BirthDate)
end
;

create function DBA.FGetPersonalGender(
in In_PersonalSysId integer)
returns char(30)
begin
  declare Out_Gender char(30);
  select Personal.Gender into Out_Gender
    from Personal where Personal.PersonalSysId = In_PersonalSysId;
  if(Out_Gender = '0') then set Out_Gender='Female'
  else
    set Out_Gender='Male'
  end if;
  return(Out_Gender)
end
;

create procedure dba.InsertNewOrgPubChart(
in In_ChartId char(20),
in In_TrueBoolOutput char(20),
in In_FalseBoolOutput char(20),
in In_Description char(150),
out Out_ErrorCode integer)
begin
  if In_ChartId is null then
    set Out_ErrorCode=-1;
    return
  end if;
  if not exists(select* from OrgPubChart where ChartId = In_ChartId) then
    insert into OrgPubChart(ChartId,
      TrueBoolOutput,
      FalseBoolOutput,
      Description) values(
      In_ChartId,
      In_TrueBoolOutput,
      In_FalseBoolOutput,
      In_Description);
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=-2
  end if
end
;

create procedure dba.DeleteOrgPubChart(
in In_ChartId char(20),
out Out_ErrorCode integer)
begin
  delete from OrgPubCustomMapping where ChartId = In_ChartId;
  delete from OrgPubChart where ChartId = In_ChartId;
  set Out_ErrorCode=1
end
;

create procedure dba.UpdateOrgPubChart(
in In_ChartId char(20),
in In_TrueBoolOutput char(20),
in In_FalseBoolOutput char(20),
in In_Description char(150),
out Out_ErrorCode integer)
begin
  if exists(select* from OrgPubChart where ChartId = In_ChartId) then
    update OrgPubChart set
      TrueBoolOutput = In_TrueBoolOutput,
      FalseBoolOutput = In_FalseBoolOutput,
      Description = In_Description where
      ChartId = In_ChartId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=-1
  end if
end
;

create function DBA.FGetPersonalAddPCode(
in In_PersonalSysId integer,
in In_ContactLocId char(20),
in In_MailingAdd integer)
returns char(150)
begin
  declare Out_AddPCode char(150);
  if(In_MailingAdd = 0) then
    select first PersonalAddress.PersonalAddPCode into Out_AddPCode
      from PersonalAddress where ContactLocationId = In_ContactLocId and
      PersonalAddress.PersonalSysId = In_PersonalSysId order by PersonalAddressId;
  else
    select first PersonalAddress.PersonalAddPCode into Out_AddPCode
      from PersonalAddress where PersonalAddMailing = 1 and
      PersonalAddress.PersonalSysId = In_PersonalSysId order by PersonalAddressId;
  end if;
  return(Out_AddPCode)
end
;

create function DBA.FGetPersonalAddress1(
in In_PersonalSysId integer,
in In_ContactLocId char(20),
in In_MailingAdd integer)
returns char(150)
begin
  declare Out_Address char(150);
  if(In_MailingAdd = 0) then
    select first PersonalAddress.PersonalAddAddress into Out_Address
      from PersonalAddress where ContactLocationId = In_ContactLocId and
      PersonalAddress.PersonalSysId = In_PersonalSysId order by PersonalAddressId;
  else
    select first PersonalAddress.PersonalAddAddress into Out_Address
      from PersonalAddress where PersonalAddMailing = 1 and
      PersonalAddress.PersonalSysId = In_PersonalSysId order by PersonalAddressId;
  end if;
  return(Out_Address)
end
;

create function DBA.FGetPersonalAddress2(
in In_PersonalSysId integer,
in In_ContactLocId char(20),
in In_MailingAdd integer)
returns char(150)
begin
  declare Out_Address char(150);
  if(In_MailingAdd = 0) then
    select first PersonalAddress.PersonalAddAddress2 into Out_Address
      from PersonalAddress where ContactLocationId = In_ContactLocId and
      PersonalAddress.PersonalSysId = In_PersonalSysId order by PersonalAddressId;
  else
    select first PersonalAddress.PersonalAddAddress2 into Out_Address
      from PersonalAddress where PersonalAddMailing = 1 and
      PersonalAddress.PersonalSysId = In_PersonalSysId order by PersonalAddressId;
  end if;
  return(Out_Address)
end
;

create function DBA.FGetPersonalAddress3(
in In_PersonalSysId integer,
in In_ContactLocId char(20),
in In_MailingAdd integer)
returns char(150)
begin
  declare Out_Address char(150);
  if(In_MailingAdd = 0) then
    select first PersonalAddress.PersonalAddAddress3 into Out_Address
      from PersonalAddress where ContactLocationId = In_ContactLocId and
      PersonalAddress.PersonalSysId = In_PersonalSysId order by PersonalAddressId;
  else
    select first PersonalAddress.PersonalAddAddress3 into Out_Address
      from PersonalAddress where PersonalAddMailing = 1 and
      PersonalAddress.PersonalSysId = In_PersonalSysId order by PersonalAddressId;
  end if;
  return(Out_Address)
end
;

create function DBA.FGetFWLFirstPermitNo(
in In_EmployeeSysId integer)
returns char(20)
begin
  declare Out_PermitNo char(20);
  select first FWLPermitNumber into Out_PermitNo
    from FWLProgression where EmployeeSysId = In_EmployeeSysId Order by FWLEffectiveDate;
  return(Out_PermitNo)
end
;

create function DBA.FGetEmployeeIdByPersonalSysId(
in In_PersonalSysId integer)
returns char(30)
begin
  declare Out_EmployeeId char(30);
  select Personal.EmployeeId into Out_EmployeeId
    from Personal where
    Personal.PersonalSysId = In_PersonalSysId;
  return(Out_EmployeeId)
end
;

create function DBA.FGetFamilyIdentityNo(
in In_PersonalSysId integer,
in In_RelationShipId char(20))
returns char(30)
begin
  declare Out_IdentityNo char(30);
  select Family.IdentityNo into Out_IdentityNo
    from Family where RelationShipId = In_RelationShipId and
    Family.PersonalSysId = In_PersonalSysId;
  return(Out_IdentityNo)
end
;

create function DBA.FGetFamilyIdentityNoChkMale(
in In_PersonalSysId integer,
in In_RelationShipId char(20))
returns char(30)
begin
  declare Out_IdentityNo char(30);
  if exists(select* from Personal where
      Personal.PersonalSysId = In_PersonalSysId and
      Gender = 0 and MaritalStatusCode = 'Married') then
    select Family.IdentityNo into Out_IdentityNo
      from Family where RelationShipId = In_RelationShipId and
      Family.PersonalSysId = In_PersonalSysId;
    return(Out_IdentityNo)
  end if
end
;

create function DBA.FGetFamilyName(
in In_PersonalSysId integer,
in In_RelationShipId char(20))
returns char(150)
begin
  declare Out_Name char(150);
  select Family.PersonName into Out_Name
    from Family where RelationShipId = In_RelationShipId and
    Family.PersonalSysId = In_PersonalSysId;
  return(Out_Name)
end
;

create function DBA.FGetFamilyNameChkMale(
in In_PersonalSysId integer,
in In_RelationShipId char(20))
returns char(150)
begin
  declare Out_Name char(150);
  if exists(select* from Personal where
      Personal.PersonalSysId = In_PersonalSysId and
      Gender = 0 and MaritalStatusCode = 'Married') then
    select Family.PersonName into Out_Name
      from Family where RelationShipId = In_RelationShipId and
      Family.PersonalSysId = In_PersonalSysId;
    return(Out_Name)
  end if
end
;

create function DBA.FGetCompanyReg(
in In_CompanyId char(20))
returns char(100)
begin
  declare Out_CompanyReg char(100);
  select Company.CompanyReg into Out_CompanyReg
    from Company where
    Company.CompanyId = In_CompanyId;
  return(Out_CompanyReg)
end
;

create procedure dba.ASQLCareerProgUpdateFields(
in In_EmployeeSysId integer,
in In_EffectiveDate date)
begin
  SubregistryLoop: for SubregistryFor as SubregistryDate dynamic scroll cursor for
    select SubregistryId as Out_SubregistryId from
      Subregistry where
      RegistryId = 'CareerAttribute' and
      ShortStringAttr <> '' order by SubregistryId asc do
    if not exists(select* from careerattribute where
        Employeesysid = In_EmployeeSysId and
        CareerEffectiveDate = In_EffectiveDate and
        CareerAttributeID = Out_SubregistryId) then
      insert into careerattribute(EmployeeSysId,CareerEffectiveDate,CareerAttributeID,CareerNewValue) values(
        In_EmployeeSysId,In_EffectiveDate,Out_SubregistryId,'');
      commit work
    end if end for
end
;

create procedure dba.ASQLGenNewShiftCalendarYear(
in In_EmployeeSysId integer,
in In_NewYear integer,
in In_WTCalendarId char(20))
begin
  declare Int_NewFollowingYearDays integer;
  declare @DaysCounter integer;
  declare Date_ActualDate date;
  set Int_NewFollowingYearDays=DATEDIFF(day,YMD(In_NewYear-1,12,31),YMD(In_NewYear,12,31));
  set @DaysCounter=0;
  GenNewFollowingYearDaysLoop:
  while @DaysCounter < Int_NewFollowingYearDays loop
    set @DaysCounter=@DaysCounter+1;
    set Date_ActualDate=DATEADD(Day,@DaysCounter,YMD(In_NewYear-1,12,31));
    insert into ShiftCalendar(EmployeeSysId,
      ShiftCalendarDate,WTCalendarId) values(
      In_EmployeeSysId,
      Date_ActualDate,
      In_WTCalendarId)
  end loop GenNewFollowingYearDaysLoop;
  commit work
end
;

create procedure dba.ASQLGenWTDay(
in In_ShiftTeamID char(20),
in In_StartDate date,
in In_EndDate date,
in In_MONID char(20),
in In_TUEID char(20),
in In_WEDID char(20),
in In_THUID char(20),
in In_FRIID char(20),
in In_SATID char(20),
in In_SUNID char(20))
begin
  declare Int_Days integer;
  declare @DaysCounter integer;
  declare Date_ActualDate date;
  declare ProfileID char(20);
  set Int_Days=DATEDIFF(day,In_StartDate,In_EndDate)+1;
  set @DaysCounter=0;
  delete from WTDay where WTCalendarId = In_ShiftTeamID and WTDate >= In_StartDate and WTDate <= In_EndDate;
  GenWTDayLoop:
  while @DaysCounter < Int_Days loop
    set Date_ActualDate=DATEADD(Day,@DaysCounter,In_StartDate);
    set @DaysCounter=@DaysCounter+1;
    case DOW(Date_ActualDate)
    when 1 then set ProfileID=In_SUNID
    when 2 then set ProfileID=In_MONID
    when 3 then set ProfileID=In_TUEID
    when 4 then set ProfileID=In_WEDID
    when 5 then set ProfileID=In_THUID
    when 6 then set ProfileID=In_FRIID
    when 7 then set ProfileID=In_SATID
    end case
    ;
    insert into WTDay(WTCalendarId,
      WTDate,WTProfileId) values(
      In_ShiftTeamID,
      Date_ActualDate,
      ProfileID)
  end loop GenWTDayLoop;
  commit work
end
;

create procedure dba.ASQLGenWTDayUsingPattern(
in In_ShiftTeamID char(20),
in In_Year integer)
begin
  // declare variables
  declare Int_NewYearDays integer;
  declare Count_PatternOrder integer;
  declare UsedPatternOrder integer;
  declare @DaysCounter integer;
  declare Date_ActualDate date;
  declare Char_WTProfileId char(20);
  set @DaysCounter=0;
  set Int_NewYearDays=DATEDIFF(day,YMD(In_Year-1,12,31),YMD(In_Year,12,31));
  GenNewFollowingYearDaysLoop:
  while @DaysCounter < Int_NewYearDays loop
    set @DaysCounter=@DaysCounter+1;
    set Date_ActualDate=DATEADD(Day,@DaysCounter,YMD(In_Year-1,12,31));
    // get the PatternOrder for this date using the following formula:
    // Free pattern: PatternOrder for the given date counter = ( (@DaysCounter-1) % Count_PatternOrder ) + 1
    // Day of week pattern: PatternOrder for the given date counter = DOW(Date_ActualDate)
    case(select WTPatternType from WTCalendar where WTCalendarId = In_ShiftTeamID)
    when 0 then
      set UsedPatternOrder=DOW(Date_ActualDate)
    when 1 then
      select COUNT(PatternOrder) into Count_PatternOrder
        from WTCalendarPattern where
        WTCalendarId = In_ShiftTeamID;
      set UsedPatternOrder=mod(@DaysCounter-1,Count_PatternOrder)+1
    end case
    ; // select the WTProfileId for the given date
    select WTProfileId into Char_WTProfileId
      from WTCalendarPattern where
      WTCalendarId = In_ShiftTeamID and
      PatternOrder = UsedPatternOrder;
    insert into WTDay(WTCalendarId,WTDate,WTProfileId) values(In_ShiftTeamId,Date_ActualDate,Char_WTProfileId)
  end loop GenNewFollowingYearDaysLoop;
  commit work
end
;

create procedure dba.DeleteBranchGov(
in In_BranchGovSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from BranchGov where BranchGov.BranchGovSysId = In_BranchGovSysId) then
    delete from BranchGov where BranchGov.BranchGovSysId = In_BranchGovSysId;
    commit work;
    if exists(select* from BranchGov where BranchGov.BranchGovSysId = In_BranchGovSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteCalendarDayByCalendarAndYear(
in In_CalendarIdCode char(20),
in In_CalendarYear integer)
begin
  delete from CalendarDay where
    CalendarDay.CalendarIdCode = In_CalendarIdCode and
    YEAR(CalendarDay.CalendarDate) = In_CalendarYear;
  commit work
end
;

create procedure dba.DeleteShiftCalendarByEmployeeAndYear(
in In_EmployeeSysId integer,
in In_Year integer)
begin
  if exists(select* from ShiftCalendar where
      EmployeeSysId = In_EmployeeSysId and Year(ShiftCalendarDate) = In_Year) then
    delete from ShiftCalendar where
      EmployeeSysId = In_EmployeeSysId and Year(ShiftCalendarDate) = In_Year;
    commit work
  end if
end
;

create procedure dba.DeleteWTDayByWTCalendarIdAndYear(
in In_WTCalendarId char(20),
in In_Year integer)
begin
  if exists(select* from WTDay where
      WTDay.WTCalendarId = In_WTCalendarId and Year(WTDay.WTDate) = In_Year) then
    delete from WTDay where
      WTDay.WTCalendarId = In_WTCalendarId and Year(WTDay.WTDate) = In_Year;
    commit work
  end if
end
;

create function DBA.FGetWorkTimeEndTime(
in In_WTCalendarId char(20),
in In_WTDate date)
returns time
begin
  declare Out_EndTime time;
  select first EndTime into Out_EndTime
    from WTDay join WTProfile join WorkTime where
    WTDay.WTCalendarId = In_WTCalendarId and
    WTDay.WTDate = In_WTDate order by
    DayAppControlId desc,StartTime desc;
  return Out_EndTime
end
;

create function DBA.FGetWorkTimeStartTime(
in In_WTCalendarId char(20),
in In_WTDate date)
returns time
begin
  declare Out_StartTime time;
  select first StartTime into Out_StartTime
    from WTDay join WTProfile join WorkTime where
    WTDay.WTCalendarId = In_WTCalendarId and
    WTDay.WTDate = In_WTDate order by
    DayAppControlId asc,StartTime asc;
  return Out_StartTime
end
;

create procedure dba.InsertNewBranchGov(
in In_CompanyId char(20),
in In_BranchId char(20),
in In_BranchGovAccNo char(30),
in In_BranchGovCode char(20),
in In_BranchGovDesc char(100),
in In_BranchGovCategory char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from BranchGov where CompanyId = In_CompanyId and
      BranchId = In_BranchId and
      BranchGovCode = In_BranchGovCode) then
    insert into BranchGov(CompanyId,
      BranchId,
      BranchSystem,
      BranchGovAccNo,
      BranchGovCode,
      BranchGovDesc,
      BranchGovCategory) values(
      In_CompanyId,
      In_BranchId,1,
      In_BranchGovAccNo,
      In_BranchGovCode,
      In_BranchGovDesc,
      In_BranchGovCategory);
    commit work;
    if not exists(select* from BranchGov where CompanyId = In_CompanyId and
        BranchId = In_BranchId and
        BranchGovCode = In_BranchGovCode) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewBranchGovByComBranch(
in In_CompanyId char(20),
in In_BranchId char(20))
begin
  CreateBranchGovLoop: for CreateBranchGovFor as CreateBranchGovCursor dynamic scroll cursor for
    select RegProperty1 as Out_BranchGovCode,
      RegProperty2 as Out_BranchGovDesc,
      RegProperty3 as Out_BranchGovCategory from
      SubRegistry where RegistryId = 'BranchGov' do
    if not exists(select* from BranchGov where CompanyId = In_CompanyId and
        BranchId = In_BranchId and
        BranchGovCode = Out_BranchGovCode) then
      insert into BranchGov(CompanyId,
        BranchId,
        BranchSystem,
        BranchGovAccNo,
        BranchGovCode,
        BranchGovDesc,
        BranchGovCategory) values(
        In_CompanyId,
        In_BranchId,1,null,
        Out_BranchGovCode,
        Out_BranchGovDesc,
        Out_BranchGovCategory)
    end if end for;
  commit work
end
;

create procedure dba.InsertNewCompanyBranch(
in In_CompanyId char(20),
in In_BranchId char(20),
in In_BranchName char(80),
in In_BranchAddress1 char(150),
in In_BranchAddress2 char(150),
in In_BranchAddress3 char(150),
in In_BranchCountry char(60),
in In_BranchCity char(60),
in In_BranchPCode char(20),
in In_BranchState char(60),
in In_BranchForeignName char(80))
begin
  if not exists(select* from Branch where Branch.CompanyId = In_CompanyId and
      Branch.BranchId = In_BranchId) then
    if(In_BranchForeignName = '') then set In_BranchForeignName=In_BranchName
    end if;
    insert into Branch(CompanyId,BranchId,BranchName,
      BranchAddress,BranchAddress2,BranchAddress3,
      BranchCountry,BranchCity,
      BranchPCode,BranchState,BranchForeignName) values(
      In_CompanyId,In_BranchId,In_BranchName,
      In_BranchAddress1,In_BranchAddress2,In_BranchAddress3,
      In_BranchCountry,In_BranchCity,
      In_BranchPCode,In_BranchState,In_BranchForeignName);
    call InsertNewBranchGovByComBranch(In_CompanyId,In_BranchId);
    commit work
  end if
end
;

create procedure dba.PatchBranchGov()
begin
  CompanyRecLoop: for CompanyRecFor as CompanyRecCursor dynamic scroll cursor for
    select CompanyId as Out_CompanyId from Company do
    BranchRecLoop: for BranchRecFor as BranchRecCursor dynamic scroll cursor for
      select BranchId as Out_BranchId from Branch where CompanyId = Out_CompanyId do
      CreateBranchGovLoop: for CreateBranchGovFor as CreateBranchGovCursor dynamic scroll cursor for
        select RegProperty1 as Out_BranchGovCode,
          RegProperty2 as Out_BranchGovDesc,
          RegProperty3 as Out_BranchGovCategory from
          SubRegistry where RegistryId = 'BranchGov' do
        if not exists(select* from BranchGov where CompanyId = Out_CompanyId and
            BranchId = Out_BranchId and
            BranchGovCode = Out_BranchGovCode) then
          insert into BranchGov(CompanyId,
            BranchId,
            BranchSystem,
            BranchGovAccNo,
            BranchGovCode,
            BranchGovDesc,
            BranchGovCategory) values(
            Out_CompanyId,
            Out_BranchId,1,null,
            Out_BranchGovCode,
            Out_BranchGovDesc,
            Out_BranchGovCategory)
        end if end for end for end for;
  commit work
end
;


create procedure dba.UpdateBranchGov(
in In_BranchGovSysId integer,
in In_CompanyId char(20),
in In_BranchId char(20),
in In_BranchGovAccNo char(30),
in In_BranchGovCode char(20),
in In_BranchGovDesc char(100),
in In_BranchGovCategory char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from BranchGov where BranchGovSysId = In_BranchGovSysId) then
    update BranchGov set
      CompanyId = In_CompanyId,
      BranchId = In_BranchId,
      BranchGovAccNo = In_BranchGovAccNo,
      BranchGovCode = In_BranchGovCode,
      BranchGovDesc = In_BranchGovDesc,
      BranchGovCategory = In_BranchGovCategory where
      BranchGovSysId = In_BranchGovSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteWTCalendarPattern(
in In_WTCalendarId char(20),
in In_PatternOrder integer,
out Out_ErrorCode integer)
begin
  // validations
  if not exists(select* from WTCalendarPattern where WTCalendarId = In_WTCalendarId and PatternOrder = In_PatternOrder) then
    set Out_ErrorCode=-1; // Record not exists
    return
  end if;
  // delete
  delete from WTCalendarPattern where
    WTCalendarId = In_WTCalendarId and
    PatternOrder = In_PatternOrder;
  commit work;
  // check
  if exists(select* from WTCalendarPattern where WTCalendarId = In_WTCalendarId and PatternOrder = In_PatternOrder) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.InsertNewWTCalendarPattern(
in In_WTCalendarId char(20),
in In_PatternOrder integer,
in In_WTProfileId char(20),
out Out_ErrorCode integer)
begin
  // validations
  if exists(select* from WTCalendarPattern where WTCalendarId = In_WTCalendarId and PatternOrder = In_PatternOrder) then
    set Out_ErrorCode=-1; // Record exists
    return
  end if;
  if not In_WTCalendarId = any(select WTCalendarId from WTCalendar) then
    set Out_ErrorCode=-2; // WTCalendarId not exist
    return
  end if;
  if not In_WTProfileId = any(select WTProfileId from WTProfile) then
    set Out_ErrorCode=-3; // WTProfileId not exist
    return
  end if;
  // insert
  insert into WTCalendarPattern(WTCalendarId,PatternOrder,WTProfileId) values(
    In_WTCalendarId,In_PatternOrder,In_WTProfileId);
  commit work;
  // check
  if not exists(select* from WTCalendarPattern where WTCalendarId = In_WTCalendarId and PatternOrder = In_PatternOrder) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.UpdateWTCalendarPattern(
in In_WTCalendarId char(20),
in In_PatternOrder integer,
in In_WTProfileId char(20),
out Out_ErrorCode integer)
begin
  // validations
  if not exists(select* from WTCalendarPattern where WTCalendarId = In_WTCalendarId and PatternOrder = In_PatternOrder) then
    set Out_ErrorCode=-1; // Record not exists
    return
  end if;
  if not In_WTProfileId = any(select WTProfileId from WTProfile) then
    set Out_ErrorCode=-2; // WTProfileId not exist
    return
  end if;
  // update
  update WTCalendarPattern set
    WTProfileId = In_WTProfileId where
    WTCalendarId = In_WTCalendarId and
    PatternOrder = In_PatternOrder;
  commit work;
  set Out_ErrorCode=1 // Successful
end
;

create procedure
dba.ASQLUpdateEmployeeSystemAttribute()
begin
  declare EmpCode1_Id char(100);
  declare EmpCode1_Desc char(100);
  declare EmpCode2_Id char(100);
  declare EmpCode2_Desc char(100);
  declare EmpCode3_Id char(100);
  declare EmpCode3_Desc char(100);
  declare EmpCode4_Id char(100);
  declare EmpCode4_Desc char(100);
  declare EmpCode5_Id char(100);
  declare EmpCode5_Desc char(100);
  declare EmpLocation1_Id char(100);
  declare EmpLocation1_Desc char(100);
  declare CustBoolean1_Id char(100);
  declare CustBoolean2_Id char(100);
  declare CustBoolean3_Id char(100);
  declare CustDate1_Id char(100);
  declare CustDate2_Id char(100);
  declare CustDate3_Id char(100);
  declare CustInteger1_Id char(100);
  declare CustInteger2_Id char(100);
  declare CustInteger3_Id char(100);
  declare CustNumeric1_Id char(100);
  declare CustNumeric2_Id char(100);
  declare CustNumeric3_Id char(100);
  declare CustString1_Id char(100);
  declare CustString2_Id char(100);
  declare CustString3_Id char(100);
  declare CustString4_Id char(100);
  declare CustString5_Id char(100);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode1_Desc from LabelName where TableName = 'EmpCode1' and AttributeName = 'CustCodeDesc';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode2_Desc from LabelName where TableName = 'EmpCode2' and AttributeName = 'CustCodeDesc';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode3_Desc from LabelName where TableName = 'EmpCode3' and AttributeName = 'CustCodeDesc';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode4_Desc from LabelName where TableName = 'EmpCode4' and AttributeName = 'CustCodeDesc';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  select NewLName into EmpCode5_Desc from LabelName where TableName = 'EmpCode5' and AttributeName = 'CustCodeDesc';
  select NewLName into EmpLocation1_Id from LabelName where TableName = 'EmpLocation1' and AttributeName = 'EmpLocation1Id';
  select NewLName into EmpLocation1_Desc from LabelName where TableName = 'EmpLocation1' and AttributeName = 'CustLocationDesc';
  select NewLName into CustBoolean1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustBoolean1';
  select NewLName into CustBoolean2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustBoolean2';
  select NewLName into CustBoolean3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustBoolean3';
  select NewLName into CustDate1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate1';
  select NewLName into CustDate2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate2';
  select NewLName into CustDate3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate3';
  select NewLName into CustInteger1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger1';
  select NewLName into CustInteger2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger2';
  select NewLName into CustInteger3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger3';
  select NewLName into CustNumeric1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustNumeric1';
  select NewLName into CustNumeric2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustNumeric2';
  select NewLName into CustNumeric3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustNumeric3';
  select NewLName into CustString1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString1';
  select NewLName into CustString2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString2';
  select NewLName into CustString3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString3';
  select NewLName into CustString4_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString4';
  select NewLName into CustString5_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString5';
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode1Id') then
    update SystemAttribute set SysUserdefinedName = EmpCode1_Id where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode1Id'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode1Desc') then
    update SystemAttribute set SysUserdefinedName = EmpCode1_Desc where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode1Desc'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode2Id') then
    update SystemAttribute set SysUserdefinedName = EmpCode2_Id where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode2Id'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode2Desc') then
    update SystemAttribute set SysUserdefinedName = EmpCode2_Desc where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode2Desc'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode3Id') then
    update SystemAttribute set SysUserdefinedName = EmpCode3_Id where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode3Id'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode3Desc') then
    update SystemAttribute set SysUserdefinedName = EmpCode3_Desc where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode3Desc'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode4Id') then
    update SystemAttribute set SysUserdefinedName = EmpCode4_Id where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode4Id'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode4Desc') then
    update SystemAttribute set SysUserdefinedName = EmpCode4_Desc where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode4Desc'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode5Id') then
    update SystemAttribute set SysUserdefinedName = EmpCode5_Id where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode5Id'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode5Desc') then
    update SystemAttribute set SysUserdefinedName = EmpCode5_Desc where
      SysTableId = 'Employee' and SysAttributeId = 'EmpCode5Desc'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'EmpLocation1Id') then
    update SystemAttribute set SysUserdefinedName = EmpLocation1_Id where
      SysTableId = 'Employee' and SysAttributeId = 'EmpLocation1Id'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'EmpLocation1Desc') then
    update SystemAttribute set SysUserdefinedName = EmpLocation1_Desc where
      SysTableId = 'Employee' and SysAttributeId = 'EmpLocation1Desc'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'CustBoolean1') then
    update SystemAttribute set SysUserdefinedName = CustBoolean1_Id where
      SysTableId = 'Employee' and SysAttributeId = 'CustBoolean1'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'CustBoolean2') then
    update SystemAttribute set SysUserdefinedName = CustBoolean2_Id where
      SysTableId = 'Employee' and SysAttributeId = 'CustBoolean2'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'CustBoolean3') then
    update SystemAttribute set SysUserdefinedName = CustBoolean3_Id where
      SysTableId = 'Employee' and SysAttributeId = 'CustBoolean3'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'CustDate1') then
    update SystemAttribute set SysUserdefinedName = CustDate1_Id where
      SysTableId = 'Employee' and SysAttributeId = 'CustDate1'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'CustDate2') then
    update SystemAttribute set SysUserdefinedName = CustDate2_Id where
      SysTableId = 'Employee' and SysAttributeId = 'CustDate2'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'CustDate3') then
    update SystemAttribute set SysUserdefinedName = CustDate3_Id where
      SysTableId = 'Employee' and SysAttributeId = 'CustDate3'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'CustInteger1') then
    update SystemAttribute set SysUserdefinedName = CustInteger1_Id where
      SysTableId = 'Employee' and SysAttributeId = 'CustInteger1'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'CustInteger2') then
    update SystemAttribute set SysUserdefinedName = CustInteger2_Id where
      SysTableId = 'Employee' and SysAttributeId = 'CustInteger2'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'CustInteger3') then
    update SystemAttribute set SysUserdefinedName = CustInteger3_Id where
      SysTableId = 'Employee' and SysAttributeId = 'CustInteger3'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'CustNumeric1') then
    update SystemAttribute set SysUserdefinedName = CustNumeric1_Id where
      SysTableId = 'Employee' and SysAttributeId = 'CustNumeric1'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'CustNumeric2') then
    update SystemAttribute set SysUserdefinedName = CustNumeric2_Id where
      SysTableId = 'Employee' and SysAttributeId = 'CustNumeric2'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'CustNumeric3') then
    update SystemAttribute set SysUserdefinedName = CustNumeric3_Id where
      SysTableId = 'Employee' and SysAttributeId = 'CustNumeric3'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'CustString1') then
    update SystemAttribute set SysUserdefinedName = CustString1_Id where
      SysTableId = 'Employee' and SysAttributeId = 'CustString1'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'CustString2') then
    update SystemAttribute set SysUserdefinedName = CustString2_Id where
      SysTableId = 'Employee' and SysAttributeId = 'CustString2'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'CustString3') then
    update SystemAttribute set SysUserdefinedName = CustString3_Id where
      SysTableId = 'Employee' and SysAttributeId = 'CustString3'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'CustString4') then
    update SystemAttribute set SysUserdefinedName = CustString4_Id where
      SysTableId = 'Employee' and SysAttributeId = 'CustString4'
  end if;
  if exists(select* from SystemAttribute where
      SysTableId = 'Employee' and SysAttributeId = 'CustString5') then
    update SystemAttribute set SysUserdefinedName = CustString5_Id where
      SysTableId = 'Employee' and SysAttributeId = 'CustString5'
  end if;
  commit work
end
;

Create function DBA.FGetEmployeeKeyShiftTeam(
in In_EmployeeSysId integer)
returns char(20)
begin
  declare Out_WTCalendarId char(20);
  select WTCalendarId into Out_WTCalendarId from LeaveEmployee where EmployeeSysId = In_EmployeeSysId;
  return(Out_WTCalendarId)
end
;

create procedure dba.UpdateAnalyserSetEndTime(
in In_AnalyserSysId integer,
out Out_ErrorCode integer)
begin
  declare Out_AnalyserStartTime timestamp;
  declare Out_AnalyserEndTime timestamp;
  if not exists(select* from Analyser where AnalyserSysId = In_AnalyserSysId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    select AnalyserStartTime into Out_AnalyserStartTime from Analyser where
      AnalyserSysId = In_AnalyserSysId;
    set Out_AnalyserEndTime=Now(*);
    update Analyser set
      AnalyserEndTime = Out_AnalyserEndTime,
      AnalyserTotalTime = datediff(second,Out_AnalyserStartTime,Out_AnalyserEndTime) where
      AnalyserSysId = In_AnalyserSysId;
    commit work
  end if;
  set Out_ErrorCode=In_AnalyserSysId // Successful
end
;

create procedure dba.DeleteAnalyser(
in In_AnalyserSysId integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from Analyser where AnalyserSysId = In_AnalyserSysId) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    delete from Analyser where AnalyserSysId = In_AnalyserSysId;
    commit work
  end if;
  if exists(select* from InsurProg where AnalyserSysId = In_AnalyserSysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.InsertNewAnalyser(
in In_AnalyserUserId char(20),
in In_AnalyserModuleScreenId char(20),
in In_AnalyserOpCode integer,
out Out_ErrorCode integer)
begin
  declare Out_AnalyserSysId integer;
  declare Out_AnalyserStartTime timestamp;
  set Out_AnalyserStartTime=Now(*);
  // purge entries older than 365 days
  delete from Analyser where datediff(day,AnalyserStartTime,Out_AnalyserStartTime) > 365;
  // insert record
  insert into Analyser(AnalyserUserId,AnalyserModuleScreenId,AnalyserOpCode,AnalyserStartTime) values(
    In_AnalyserUserId,In_AnalyserModuleScreenId,In_AnalyserOpCode,Out_AnalyserStartTime);
  commit work;
  if not exists(select AnalyserSysId from Analyser where
      AnalyserUserId = In_AnalyserUserId and
      AnalyserModuleScreenId = In_AnalyserModuleScreenId and
      AnalyserOpCode = In_AnalyserOpCode and
      AnalyserStartTime = Out_AnalyserStartTime) then
    set Out_ErrorCode=0; // System error
    return
  else
    select AnalyserSysId into Out_AnalyserSysId from Analyser where
      AnalyserUserId = In_AnalyserUserId and
      AnalyserModuleScreenId = In_AnalyserModuleScreenId and
      AnalyserOpCode = In_AnalyserOpCode and
      AnalyserStartTime = Out_AnalyserStartTime;
    set Out_ErrorCode=Out_AnalyserSysId // Successful
  end if
end
;

create function DBA.FGetCompanyCurrency(
in In_CompanyId char(20))
returns char(20)
begin
  declare Out_CompanyCurrency char(20);
  select Company.CompanyCurrency into Out_CompanyCurrency
    from Company where
    Company.CompanyId = In_CompanyId;
  return(Out_CompanyCurrency)
end
;

create function dba.FGetCountryCurrency(
in In_CountryId char(20))
returns char(20)
begin
  declare Out_CountryCurrency char(20);
  select Country.CountryCurrency into Out_CountryCurrency
    from Country where
    Country.CountryId = In_CountryId;
  return(Out_CountryCurrency)
end
;

create function dba.FGetForeignCountry(
in In_ExchangeRateId char(20))
returns char(20)
begin
  declare Out_ForeignCountryId char(20);
  select ExchangeRate.ForeignCountryId into Out_ForeignCountryId
    from ExchangeRate where ExchangeRate.ExchangeRateId = In_ExchangeRateId;
  return(Out_ForeignCountryId)
end
;

create function dba.FGetForeignCurrency(
in In_ExchangeRateId char(20))
returns char(20)
begin
  declare Out_ForeignCurrency char(20);
  select Country.CountryCurrency into Out_ForeignCurrency
    from Country where
    Country.CountryId = FGetForeignCountry(In_ExchangeRateId);
  return(Out_ForeignCurrency)
end
;

create function DBA.FGetLicenseEmployeeCount()
returns integer
begin
  declare Out_LicenseCount integer;
  set Out_LicenseCount=0;
  select count(*) into Out_LicenseCount from employee where CessationDate = '1899-12-30';
  return Out_LicenseCount
end
;

create function DBA.FGetLicenseEmployeeCountExceed(
in In_ExcludeEmployeeSysId integer)
returns integer
begin
  declare Out_LicenseCount integer;
  declare TotalLicenseCount integer;
  set TotalLicenseCount=0;
  select NumKey15 into TotalLicenseCount from LicenseRecord;
  if(TotalLicenseCount = 0) then
    select NumKey1 into TotalLicenseCount from LicenseRecord
  end if;
  set Out_LicenseCount=0;
  select count(*) into Out_LicenseCount from employee where CessationDate = '1899-12-30';
  if(Out_LicenseCount >= TotalLicenseCount) then return 1
  end if;
  return 0
end
;

create function DBA.FGetEmpeeOtherInfoDateInfo(
in In_Type char(30),
in In_EmployeeSysId integer)
returns date
begin
  declare Out_Result date;
  select EmpeeOtherInfo.EmpeeOtherInfoDate into Out_Result
    from EmpeeOtherInfo where EmpeeOtherInfo.EmployeeSysId = In_EmployeeSysId and
    EmpeeOtherInfo.EmpeeOtherInfoId = In_Type;
  return(Out_Result)
end
;

create function dba.FGetFamilyAge(
in In_FamilySysId integer)
returns integer
begin
  declare Out_FamilyAge integer;
  select Year(Now(*))-Year(Family.DOB) into Out_FamilyAge
    from Family where
    Family.FamilySysId = In_FamilySysId;
  return(Out_FamilyAge)
end
;

create procedure dba.ASQLUpdatePayKeyword()
begin
  declare CustInteger1_Id char(20);
  declare CustInteger2_Id char(20);
  declare CustInteger3_Id char(20);
  declare CustNumeric1_Id char(20);
  declare CustNumeric2_Id char(20);
  declare CustNumeric3_Id char(20);
  select NewLName into CustInteger1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger1';
  select NewLName into CustInteger2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger2';
  select NewLName into CustInteger3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger3';
  select NewLName into CustNumeric1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustNumeric1';
  select NewLName into CustNumeric2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustNumeric2';
  select NewLName into CustNumeric3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustNumeric3';
  if exists(select* from Keyword where
      KeywordId = 'CustInteger1') then
    update Keyword set KeywordUserDefinedName = CustInteger1_Id where
      KeywordId = 'CustInteger1'
  end if;
  if exists(select* from Keyword where
      KeywordId = 'CustInteger2') then
    update Keyword set KeywordUserDefinedName = CustInteger2_Id where
      KeywordId = 'CustInteger2'
  end if;
  if exists(select* from Keyword where
      KeywordId = 'CustInteger3') then
    update Keyword set KeywordUserDefinedName = CustInteger3_Id where
      KeywordId = 'CustInteger3'
  end if;
  if exists(select* from Keyword where
      KeywordId = 'CustNumeric1') then
    update Keyword set KeywordUserDefinedName = CustNumeric1_Id where
      KeywordId = 'CustNumeric1'
  end if;
  if exists(select* from Keyword where
      KeywordId = 'CustNumeric2') then
    update Keyword set KeywordUserDefinedName = CustNumeric2_Id where
      KeywordId = 'CustNumeric2'
  end if;
  if exists(select* from Keyword where
      KeywordId = 'CustNumeric3') then
    update Keyword set KeywordUserDefinedName = CustNumeric3_Id where
      KeywordId = 'CustNumeric3'
  end if;
  commit work
end
;

create function DBA.FGetBRProgPeriodBasicRate(in In_EmployeeSysId integer,in In_SPeriodEndDate date)
returns double
begin
  declare Out_BRProgDate date;
  declare Out_BRProgNewBasicRate double;
  select max(BRProgDate) into Out_BRProgDate from BasicRateProgression where EmployeeSysId = in_EmployeeSysId and
    BRProgDate <= In_SPeriodEndDate;
  if Out_BRProgDate is null then return 0
  end if;
  select BRProgNewBasicRate into Out_BRProgNewBasicRate from BasicRateProgression where EmployeeSysId = in_EmployeeSysId and
    BRProgDate = Out_BRProgDate;
  return Out_BRProgNewBasicRate
end
;

create procedure dba.UpdateLoginRecQueryId(
in In_UserId char(20),
in In_Module char(20),
in In_IPAddress char(20),
in In_QueryId char(20),
out Out_LoginSGSPGenId char(30))
begin
  update LoginRec set
    LoginRec.QueryId = In_QueryId where
    LoginRec.UserId = In_UserId and
    LoginRec.Module = In_Module and
    LoginRec.IPAddress = In_IPAddress and
    LoginRec.LoginSGSPGenId = (select Max(LoginSGSPGenId) from LoginRec where
      UserId = In_UserId and
      IPAddress = In_IPAddress and
      Module = In_Module);
  commit work;
  select Max(LoginSGSPGenId) into Out_LoginSGSPGenId from LoginRec where
    UserId = In_UserId and
    Module = In_Module and
    IPAddress = In_IPAddress
end
;

create procedure dba.ASQLUpdateHRBasisSubregistry()
begin
  declare EmpCode1_Id char(20);
  declare EmpCode2_Id char(20);
  declare EmpCode3_Id char(20);
  declare EmpCode4_Id char(20);
  declare EmpCode5_Id char(20);
  declare EmpLocation1_Id char(20);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  select NewLName into EmpLocation1_Id from LabelName where TableName = 'EmpLocation1' and AttributeName = 'EmpLocation1Id';
  if exists(select* from Subregistry where
      RegistryId = 'HRRangeBasis' and SubRegistryId = 'EmpCode1Id') then
    update Subregistry set ShortStringAttr = EmpCode1_Id,RegProperty2 = EmpCode1_Id where
      RegistryId = 'HRRangeBasis' and SubRegistryId = 'EmpCode1Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'HRRangeBasis' and SubRegistryId = 'EmpCode2Id') then
    update Subregistry set
      ShortStringAttr = EmpCode2_Id,RegProperty2 = EmpCode2_Id where
      RegistryId = 'HRRangeBasis' and SubRegistryId = 'EmpCode2Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'HRRangeBasis' and SubRegistryId = 'EmpCode3Id') then
    update Subregistry set
      ShortStringAttr = EmpCode3_Id,RegProperty2 = EmpCode3_Id where
      RegistryId = 'HRRangeBasis' and SubRegistryId = 'EmpCode3Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'HRRangeBasis' and SubRegistryId = 'EmpCode4Id') then
    update Subregistry set
      ShortStringAttr = EmpCode4_Id,RegProperty2 = EmpCode4_Id where
      RegistryId = 'HRRangeBasis' and SubRegistryId = 'EmpCode4Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'HRRangeBasis' and SubRegistryId = 'EmpCode5Id') then
    update Subregistry set
      ShortStringAttr = EmpCode5_Id,RegProperty2 = EmpCode5_Id where
      RegistryId = 'HRRangeBasis' and SubRegistryId = 'EmpCode5Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'HRRangeBasis' and SubRegistryId = 'EmpLoc1Id') then
    update Subregistry set
      ShortStringAttr = EmpLocation1_Id,RegProperty2 = EmpLocation1_Id where
      RegistryId = 'HRRangeBasis' and SubRegistryId = 'EmpLoc1Id'
  end if;
  commit work
end
;

create function DBA.FGetForeignNameByPersonalSysId(
in In_PersonalSysId integer)
returns char(40)
begin
  declare Out_PersonalName char(40);
  declare Out_Alias char(40);
  declare Out_ForeignName char(40);
  select Personal.PersonalName,Personal.Alias into Out_PersonalName,Out_Alias from
    Personal where
    Personal.PersonalSysId = In_PersonalSysId;
  if Out_Alias = '' or Out_Alias is null then
    set Out_ForeignName=Out_PersonalName
  else
    set Out_ForeignName=Out_Alias
  end if;
  return(Out_ForeignName)
end
;

create function DBA.FGetForeignNameByEmployeeSysId(
in In_EmployeeSysId integer)
returns char(40)
begin
  declare Out_PersonalSysId char(40);
  select Employee.PersonalSysId into Out_PersonalSysId from
    Employee where
    Employee.EmployeeSysId = In_EmployeeSysId;
  return(FGetForeignNameByPersonalSysId(Out_PersonalSysId))
end
;

create procedure dba.ASQLUpdateCEBasisSubregistry()
begin
  declare EmpCode1_Id char(20);
  declare EmpCode2_Id char(20);
  declare EmpCode3_Id char(20);
  declare EmpCode4_Id char(20);
  declare EmpCode5_Id char(20);
  declare EmpLocation1_Id char(20);
  declare CustString1_Id char(20);
  declare CustString2_Id char(20);
  declare CustString3_Id char(20);
  declare CustString4_Id char(20);
  declare CustString5_Id char(20);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  select NewLName into EmpLocation1_Id from LabelName where TableName = 'EmpLocation1' and AttributeName = 'EmpLocation1Id';
  select NewLName into CustString1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString1';
  select NewLName into CustString2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString2';
  select NewLName into CustString3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString3';
  select NewLName into CustString4_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString4';
  select NewLName into CustString5_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString5';
  if exists(select* from Subregistry where
      RegistryId = 'CEBasis' and SubRegistryId = 'CEEmpCode1Id') then
    update Subregistry set ShortStringAttr = EmpCode1_Id where
      RegistryId = 'CEBasis' and SubRegistryId = 'CEEmpCode1Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CEBasis' and SubRegistryId = 'CEEmpCode2Id') then
    update Subregistry set
      ShortStringAttr = EmpCode2_Id where
      RegistryId = 'CEBasis' and SubRegistryId = 'CEEmpCode2Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CEBasis' and SubRegistryId = 'CEEmpCode3Id') then
    update Subregistry set
      ShortStringAttr = EmpCode3_Id where
      RegistryId = 'CEBasis' and SubRegistryId = 'CEEmpCode3Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CEBasis' and SubRegistryId = 'CEEmpCode4Id') then
    update Subregistry set
      ShortStringAttr = EmpCode4_Id where
      RegistryId = 'CEBasis' and SubRegistryId = 'CEEmpCode4Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CEBasis' and SubRegistryId = 'CEEmpCode5Id') then
    update Subregistry set
      ShortStringAttr = EmpCode5_Id where
      RegistryId = 'CEBasis' and SubRegistryId = 'CEEmpCode5Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CEBasis' and SubRegistryId = 'CEEmpLocation1Id') then
    update Subregistry set
      ShortStringAttr = EmpLocation1_Id where
      RegistryId = 'CEBasis' and SubRegistryId = 'CEEmpLocation1Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CEBasis' and SubRegistryId = 'CECustString1') then
    update Subregistry set
      ShortStringAttr = CustString1_Id where
      RegistryId = 'CEBasis' and SubRegistryId = 'CECustString1'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CEBasis' and SubRegistryId = 'CECustString2') then
    update Subregistry set
      ShortStringAttr = CustString2_Id where
      RegistryId = 'CEBasis' and SubRegistryId = 'CECustString2'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CEBasis' and SubRegistryId = 'CECustString3') then
    update Subregistry set
      ShortStringAttr = CustString3_Id where
      RegistryId = 'CEBasis' and SubRegistryId = 'CECustString3'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CEBasis' and SubRegistryId = 'CECustString4') then
    update Subregistry set
      ShortStringAttr = CustString4_Id where
      RegistryId = 'CEBasis' and SubRegistryId = 'CECustString4'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'CEBasis' and SubRegistryId = 'CECustString5') then
    update Subregistry set
      ShortStringAttr = CustString5_Id where
      RegistryId = 'CEBasis' and SubRegistryId = 'CECustString5'
  end if;
  commit work
end
;

create function DBA.FGetLatestBREffectiveDate(
in In_EmployeeSysId integer)
returns date
begin
  declare Out_LatestBREffectiveDate date;
  select first BasicRateProgression.BRProgEffectiveDate into Out_LatestBREffectiveDate
    from BasicRateProgression where
    BasicRateProgression.EmployeeSysId = In_EmployeeSysId and BasicRateProgression.BRProgEffectiveDate <= Now(*) order by
    BasicRateProgression.BRProgEffectiveDate desc;
  return(Out_LatestBREffectiveDate)
end
;

create procedure dba.DeleteCETmsExportEmpEmp(
in In_EmployeeSysId integer)
begin
  delete from CETmsExportEmp where EmployeeSysId = In_EmployeeSysId;
  commit work
end
;

create procedure dba.ASQLInterfaceCareerProgression(
in In_EmployeeSysId integer)
begin
  OneCareerProgLoop: for OneCareerProgFor as curs dynamic scroll cursor for
    select CareerEffectiveDate as Out_CareerEffectiveDate from
      CareerProgression where EmployeeSysId = In_EmployeeSysId and
      CareerCurrent = 0 do
    call DeleteCareerProgression(In_EmployeeSysId,Out_CareerEffectiveDate) end for;
  commit work
end
;

create procedure dba.ASQLUpdateIntercorpBasisSubregistry()
begin
  declare EmpCode1_Id char(20);
  declare EmpCode2_Id char(20);
  declare EmpCode3_Id char(20);
  declare EmpCode4_Id char(20);
  declare EmpCode5_Id char(20);
  declare EmpLocation1_Id char(20);
  declare CustDate1_Id char(20);
  declare CustDate2_Id char(20);
  declare CustDate3_Id char(20);
  declare CustInteger1_Id char(20);
  declare CustInteger2_Id char(20);
  declare CustInteger3_Id char(20);
  declare CustString1_Id char(20);
  declare CustString2_Id char(20);
  declare CustString3_Id char(20);
  declare CustString4_Id char(20);
  declare CustString5_Id char(20);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  select NewLName into EmpLocation1_Id from LabelName where TableName = 'EmpLocation1' and AttributeName = 'EmpLocation1Id';
  select NewLName into CustDate1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate1';
  select NewLName into CustDate2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate2';
  select NewLName into CustDate3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate3';
  select NewLName into CustInteger1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger1';
  select NewLName into CustInteger2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger2';
  select NewLName into CustInteger3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustInteger3';
  select NewLName into CustString1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString1';
  select NewLName into CustString2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString2';
  select NewLName into CustString3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString3';
  select NewLName into CustString4_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString4';
  select NewLName into CustString5_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustString5';
  if exists(select* from Subregistry where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterEmpCode1Id') then
    update Subregistry set ShortStringAttr = EmpCode1_Id where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterEmpCode1Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterEmpCode2Id') then
    update Subregistry set
      ShortStringAttr = EmpCode2_Id where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterEmpCode2Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterEmpCode3Id') then
    update Subregistry set
      ShortStringAttr = EmpCode3_Id where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterEmpCode3Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterEmpCode4Id') then
    update Subregistry set
      ShortStringAttr = EmpCode4_Id where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterEmpCode4Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterEmpCode5Id') then
    update Subregistry set
      ShortStringAttr = EmpCode5_Id where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterEmpCode5Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterEmpLocation1Id') then
    update Subregistry set
      ShortStringAttr = EmpLocation1_Id where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterEmpLocation1Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustDate1') then
    update Subregistry set
      ShortStringAttr = CustDate1_Id where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustDate1'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustDate2') then
    update Subregistry set
      ShortStringAttr = CustDate2_Id where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustDate2'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustDate3') then
    update Subregistry set
      ShortStringAttr = CustDate3_Id where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustDate3'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustInteger1') then
    update Subregistry set
      ShortStringAttr = CustInteger1_Id where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustInteger1'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustInteger2') then
    update Subregistry set
      ShortStringAttr = CustInteger2_Id where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustInteger2'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustInteger3') then
    update Subregistry set
      ShortStringAttr = CustInteger3_Id where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustInteger3'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustString1') then
    update Subregistry set
      ShortStringAttr = CustString1_Id where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustString1'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustString2') then
    update Subregistry set
      ShortStringAttr = CustString2_Id where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustString2'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustString3') then
    update Subregistry set
      ShortStringAttr = CustString3_Id where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustString3'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustString4') then
    update Subregistry set
      ShortStringAttr = CustString4_Id where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustString4'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustString5') then
    update Subregistry set
      ShortStringAttr = CustString5_Id where
      RegistryId = 'IntercorpBasis' and SubRegistryId = 'InterCustString5'
  end if;
  commit work
end
;

create function DBA.FGetLatestResStatusEffectiveDate(
in In_PersonalSysId integer)
returns date
begin
  declare Out_LatestResStatusEffectiveDate date;
  select first ResidenceStatusRecord.ResStatusEffectiveDate into Out_LatestResStatusEffectiveDate
    from ResidenceStatusRecord where
    ResidenceStatusRecord.PersonalSysId = In_PersonalSysId and ResidenceStatusRecord.ResStatusEffectiveDate <= Now(*) order by
    ResidenceStatusRecord.ResStatusEffectiveDate desc;
  return(Out_LatestResStatusEffectiveDate)
end
;

create function DBA.FGetLatestFWLEffectiveDate(
in In_EmployeeSysId integer)
returns date
begin
  declare Out_LatestFWLEffectiveDate date;
  select first FWLProgression.FWLEffectiveDate into Out_LatestFWLEffectiveDate
    from FWLProgression where
    FWLProgression.EmployeeSysId = In_EmployeeSysId and FWLProgression.FWLEffectiveDate <= Now(*) order by
    FWLProgression.FWLEffectiveDate desc;
  return(Out_LatestFWLEffectiveDate)
end
;

create function DBA.FGetLatestEPEffectiveDate(
in In_EmployeeSysId integer)
returns date
begin
  declare Out_LatestEPEffectiveDate date;
  select first EmployPassProgression.EPEffectiveDate into Out_LatestEPEffectiveDate
    from EmployPassProgression where
    EmployPassProgression.EmployeeSysId = In_EmployeeSysId and EmployPassProgression.EPEffectiveDate <= Now(*) order by
    EmployPassProgression.EPEffectiveDate desc;
  return(Out_LatestEPEffectiveDate)
end
;

create procedure dba.DeleteIntercorpTmsExportEmpEmp(
in In_EmployeeSysId integer)
begin
  delete from IntercorpTmsExportEmp where EmployeeSysId = In_EmployeeSysId;
  commit work
end
;

create function dba.FGetEmpCode1Desc(
in In_EmpCode1Id char(20))
returns char(100)
begin
  declare Out_CustCodeDesc char(100);
  select EmpCode1.CustCodeDesc into Out_CustCodeDesc
    from EmpCode1 where
    EmpCode1.EmpCode1Id = In_EmpCode1Id;
  return(Out_CustCodeDesc)
end
;

create function dba.FGetEmpCode2Desc(
in In_EmpCode2Id char(20))
returns char(100)
begin
  declare Out_CustCodeDesc char(100);
  select EmpCode2.CustCodeDesc into Out_CustCodeDesc
    from EmpCode2 where
    EmpCode2.EmpCode2Id = In_EmpCode2Id;
  return(Out_CustCodeDesc)
end
;

create function dba.FGetEmpCode3Desc(
in In_EmpCode3Id char(20))
returns char(100)
begin
  declare Out_CustCodeDesc char(100);
  select EmpCode3.CustCodeDesc into Out_CustCodeDesc
    from EmpCode3 where
    EmpCode3.EmpCode3Id = In_EmpCode3Id;
  return(Out_CustCodeDesc)
end
;

create function dba.FGetEmpCode4Desc(
in In_EmpCode4Id char(20))
returns char(100)
begin
  declare Out_CustCodeDesc char(100);
  select EmpCode4.CustCodeDesc into Out_CustCodeDesc
    from EmpCode4 where
    EmpCode4.EmpCode4Id = In_EmpCode4Id;
  return(Out_CustCodeDesc)
end
;

create function dba.FGetEmpCode5Desc(
in In_EmpCode5Id char(20))
returns char(100)
begin
  declare Out_CustCodeDesc char(100);
  select EmpCode5.CustCodeDesc into Out_CustCodeDesc
    from EmpCode5 where
    EmpCode5.EmpCode5Id = In_EmpCode5Id;
  return(Out_CustCodeDesc)
end
;

create function dba.FGetEmpLocation1Desc(
in In_EmpLocation1Id char(20))
returns char(100)
begin
  declare Out_CustLocationDesc char(100);
  select EmpLocation1.CustLocationDesc into Out_CustLocationDesc
    from EmpLocation1 where
    EmpLocation1.EmpLocation1Id = In_EmpLocation1Id;
  return(Out_CustLocationDesc)
end
;

create procedure dba.InsertNewPersonalAddressEPE(
in In_ContactLocationId char(20),
in In_Address1 char(150),
in In_Address2 char(150),
in In_Address3 char(150),
in In_Country char(60),
in In_City char(60),
in In_State char(60),
in In_PCode char(20),
in In_PersonalSysId integer,
in In_PersonalAddMailing smallint,
in In_CustString1 char(50),
in In_CustString2 char(50),
in In_CustString3 char(50),
in In_CustString4 char(50),
in In_CustString5 char(50),
in In_CustString6 char(50))
begin
  declare Out_PersonalAddressRecord integer;
  if(In_PersonalAddMailing = 1) then
    call ASQLSetPersonalAddressDefault(In_PersonalSysId)
  end if;
  select count(*) into Out_PersonalAddressRecord from PersonalAddress where
    PersonalSysId = In_PersonalSysId and PersonalAddMailing = 1;
  if(Out_PersonalAddressRecord = 0) then set In_PersonalAddMailing=1
  end if;
  insert into PersonalAddress(ContactLocationId,
    PersonalAddAddress,
    PersonalAddAddress2,
    PersonalAddAddress3,
    PersonalAddCountry,PersonalAddCity,PersonalAddState,
    PersonalAddPCode,PersonalSysId,PersonalAddMailing,
    CustString1,CustString2,CustString3,CustString4,CustString5,CustString6) values(
    In_ContactLocationId,In_Address1,In_Address2,In_Address3,
    In_Country,In_City,In_State,In_PCode,In_PersonalSysId,In_PersonalAddMailing,
    In_CustString1,In_CustString2,In_CustString3,In_CustString4,In_CustString5,In_CustString6);
  commit work
end
;

create procedure dba.UpdatePersonalAddressEPE(
in In_PersonalAddressId integer,
in In_ContactLocationId char(20),
in In_Address1 char(150),
in In_Address2 char(150),
in In_Address3 char(150),
in In_Country char(60),
in In_City char(60),
in In_State char(60),
in In_PCode char(20),
in In_PersonalSysId integer,
in In_PersonalAddMailing smallint,
in In_CustString1 char(50),
in In_CustString2 char(50),
in In_CustString3 char(50),
in In_CustString4 char(50),
in In_CustString5 char(50),
in In_CustString6 char(50))
begin
  if exists(select* from PersonalAddress where
      PersonalAddress.PersonalAddressId = In_PersonalAddressId and
      PersonalAddress.PersonalSysId = In_PersonalSysId) then
    if(In_PersonalAddMailing = 1) then
      call ASQLSetPersonalAddressDefault(In_PersonalSysId)
    end if;
    update PersonalAddress set
      PersonalAddress.ContactLocationId = In_ContactLocationId,
      PersonalAddress.PersonalAddAddress = In_Address1,
      PersonalAddress.PersonalAddAddress2 = In_Address2,
      PersonalAddress.PersonalAddAddress3 = In_Address3,
      PersonalAddress.PersonalAddCountry = In_Country,
      PersonalAddress.PersonalAddCity = In_City,
      PersonalAddress.PersonalAddState = In_State,
      PersonalAddress.PersonalAddPCode = In_PCode,
      PersonalAddress.PersonalAddMailing = In_PersonalAddMailing,
      PersonalAddress.CustString1 = In_CustString1,
      PersonalAddress.CustString2 = In_CustString2,
      PersonalAddress.CustString3 = In_CustString3,
      PersonalAddress.CustString4 = In_CustString4,
      PersonalAddress.CustString5 = In_CustString5,
      PersonalAddress.CustString6 = In_CustString6 where
      PersonalAddress.PersonalAddressId = In_PersonalAddressId and
      PersonalAddress.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create function dba.FGetPersonalContactNumber(
in In_PersonalSysId integer,
in In_ContactLocationId char(20))
returns char(30)
begin
  declare Out_ContactNumber char(30);
  if exists(select* from PersonalContact where ContactLocationId = In_ContactLocationId) then
    select first ContactNumber into Out_ContactNumber from PersonalContact where
      PersonalSysId = In_PersonalSysId and ContactLocationId = In_ContactLocationId order by
      PersonalContactId asc
  else
    set Out_ContactNumber=''
  end if;
  return Out_ContactNumber
end
;

create procedure dba.ASQLUpdateAuditTrialBasisSubregistry()
begin
  declare EmpCode1_Id char(20);
  declare EmpCode2_Id char(20);
  declare EmpCode3_Id char(20);
  declare EmpCode4_Id char(20);
  declare EmpCode5_Id char(20);
  declare EmpLocation1_Id char(20);
  select NewLName into EmpCode1_Id from LabelName where TableName = 'EmpCode1' and AttributeName = 'EmpCode1Id';
  select NewLName into EmpCode2_Id from LabelName where TableName = 'EmpCode2' and AttributeName = 'EmpCode2Id';
  select NewLName into EmpCode3_Id from LabelName where TableName = 'EmpCode3' and AttributeName = 'EmpCode3Id';
  select NewLName into EmpCode4_Id from LabelName where TableName = 'EmpCode4' and AttributeName = 'EmpCode4Id';
  select NewLName into EmpCode5_Id from LabelName where TableName = 'EmpCode5' and AttributeName = 'EmpCode5Id';
  select NewLName into EmpLocation1_Id from LabelName where TableName = 'EmpLocation1' and AttributeName = 'EmpLocation1Id';
  if exists(select* from Subregistry where
      RegistryId = 'AuditTrialBasis' and SubRegistryId = 'EmpCode1Id') then
    update Subregistry set
      ShortStringAttr = EmpCode1_Id where
      RegistryId = 'AuditTrialBasis' and SubRegistryId = 'EmpCode1Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'AuditTrialBasis' and SubRegistryId = 'EmpCode2Id') then
    update Subregistry set
      ShortStringAttr = EmpCode2_Id where
      RegistryId = 'AuditTrialBasis' and SubRegistryId = 'EmpCode2Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'AuditTrialBasis' and SubRegistryId = 'EmpCode3Id') then
    update Subregistry set
      ShortStringAttr = EmpCode3_Id where
      RegistryId = 'AuditTrialBasis' and SubRegistryId = 'EmpCode3Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'AuditTrialBasis' and SubRegistryId = 'EmpCode4Id') then
    update Subregistry set
      ShortStringAttr = EmpCode4_Id where
      RegistryId = 'AuditTrialBasis' and SubRegistryId = 'EmpCode4Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'AuditTrialBasis' and SubRegistryId = 'EmpCode5Id') then
    update Subregistry set
      ShortStringAttr = EmpCode5_Id where
      RegistryId = 'AuditTrialBasis' and SubRegistryId = 'EmpCode5Id'
  end if;
  if exists(select* from Subregistry where
      RegistryId = 'AuditTrialBasis' and SubRegistryId = 'EmpLocation1Id') then
    update Subregistry set
      ShortStringAttr = EmpLocation1_Id where
      RegistryId = 'AuditTrialBasis' and SubRegistryId = 'EmpLocation1Id'
  end if;
  commit work
end
;

create function dba.FGetPersonalSysIdByEmployeeSysId(
in In_EmployeeSysId integer)
returns integer
begin
  declare Out_PersonalSysId integer;
  select PersonalSysId into Out_PersonalSysId from Employee where EmployeeSysId = In_EmployeeSysId;
  return(Out_PersonalSysId)
end
;

create procedure dba.UpdateEmpeeOtherInfo(
in In_EmployeeSysId integer,
in In_EmpeeOtherInfoId char(20),
in In_EmpeeOtherInfoType char(20),
in In_EmpeeOtherInfoCaption char(100),
in In_EmpeeOtherInfoDate date,
in In_EmpeeOtherInfoString char(20),
in In_EmpeeOtherInfoBoolean smallint,
in In_EmpeeOtherInfoDouble double,
out Out_ErrorCode integer)
begin
  if not exists(select* from EmpeeOtherInfo where EmployeeSysId = In_EmployeeSysId and EmpeeOtherInfoId = In_EmpeeOtherInfoId) then
    set Out_ErrorCode=-1; // Record not exists
    return
  elseif not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-2; // EmployeeSysId not exist
    return
  else
    update EmpeeOtherInfo set
      EmpeeOtherInfoType = In_EmpeeOtherInfoType,
      EmpeeOtherInfoCaption = In_EmpeeOtherInfoCaption,
      EmpeeOtherInfoDate = In_EmpeeOtherInfoDate,
      EmpeeOtherInfoString = In_EmpeeOtherInfoString,
      EmpeeOtherInfoBoolean = In_EmpeeOtherInfoBoolean,
      EmpeeOtherInfoDouble = In_EmpeeOtherInfoDouble where
      EmployeeSysId = In_EmployeeSysId and
      EmpeeOtherInfoId = In_EmpeeOtherInfoId;
    commit work
  end if;
  if not exists(select* from EmpeeOtherInfo where EmployeeSysId = In_EmployeeSysId and EmpeeOtherInfoId = In_EmpeeOtherInfoId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create function DBA.FGetPersonalMaritalStatus(
in In_PersonalSysId integer)
returns char(30)
begin
  declare Out_MaritalStatus char(30);
  select Personal.MaritalStatusCode into Out_MaritalStatus
    from Personal where Personal.PersonalSysId = In_PersonalSysId;
  return(Out_MaritalStatus)
end
;

create procedure DBA.ASQLInsertUserModuleNoAccess(
in In_UserGroupId char(20),
in In_ModuleScreenId char(20))
begin
  message In_UserGroupId || ',' || In_ModuleScreenId type info to console;
  //
  // check that current node is a parent node
  //
  if exists(select* from ModuleScreenGroup where Mod_ModuleScreenId = In_ModuleScreenId) then
    //
    // loop through list of child nodes of current node,
    // filtering out top-level nodes, e.g. Alert, Core, Costing, etc (parent node = child node)
    //
    ModuleScreenGroupLoop: for ModuleScreenGroupFor as ModuleScreenGroupcurs dynamic scroll cursor for
      select ModuleScreenId as Child_ModuleScreenId,Mod_ModuleScreenId as Parent_ModuleScreenId from
        ModuleScreenGroup where Parent_ModuleScreenId = In_ModuleScreenId and
        Parent_ModuleScreenId <> Child_ModuleScreenId order by
        Parent_ModuleScreenId asc,Child_ModuleScreenId asc do
      message Parent_ModuleScreenId || ',' || Child_ModuleScreenId type info to console;
      // 
      // check if selected node has been visited before, 
      // if not, enter recursive function to insert branch of nodes into UserModuleNoAccess
      //
      if not exists(select* from tmpVisitedNodes where UserGroupId = In_UserGroupId and
          ModuleScreenId = Child_ModuleScreenId) then
        call ASQLInsertUserModuleNoAccess(In_UserGroupId,Child_ModuleScreenId);
        commit work
      end if end for
  end if;
  //
  // if current node is not a parent node or if its children have been visited,
  // insert into UserModuleNoAccess (if it does not already exist)
  //
  if not exists(select* from UserModuleNoAccess where UserGroupId = In_UserGroupId and
      ModuleScreenId = In_ModuleScreenId) then
    message 'insert into UserModuleNoAccess(' || In_UserGroupId || ', ' || In_ModuleScreenId || ')' type info to console;
    insert into UserModuleNoAccess(UserGroupId,ModuleScreenId) values(
      In_UserGroupId,In_ModuleScreenId);
    commit work
  end if;
  //
  // if current node has not been visited, append to list
  //
  if not exists(select* from tmpVisitedNodes where UserGroupId = In_UserGroupId and
      ModuleScreenId = In_ModuleScreenId) then
    message 'insert into tmpVisitedNodes(' || In_UserGroupId || ', ' || In_ModuleScreenId || ')' type info to console;
    insert into tmpVisitedNodes(UserGroupId,ModuleScreenId) values(
      In_UserGroupId,In_ModuleScreenId);
    commit work
  end if
end
;

create procedure DBA.ASQLPatchUserModuleNoAccess()
begin
  //
  // create temp table to store list of visited nodes of security tree
  //
  if exists(select* from View_SysTable where Table_Name = 'tmpVisitedNodes') then
    drop table tmpVisitedNodes
  end if;
  create global temporary table DBA.tmpVisitedNodes(
    UserGroupId char(20) null,
    ModuleScreenId char(20) null,
    ) on commit delete rows;
  //
  // loop through distinct list of UserGroupIds
  //
  UserGroupIdLoop: for UserGroupIdFor as UserGroupIdcurs dynamic scroll cursor for
    select distinct UserGroupId as Loop_UserGroupId from UserModuleNoAccess order by Loop_UserGroupId asc do
    //
    // loop through list of no-access ModuleScreenIds for current UserGroupId which are parent nodes
    // (a parent node will have its ModuleScreenId appear in the Mod_ModuleScreenId column of another node)
    //
    ModuleScreenIdLoop: for ModuleScreenIdFor as ModuleScreenIdcurs dynamic scroll cursor for
      select ModuleScreenId as Loop_ModuleScreenId from UserModuleNoAccess where UserGroupId = Loop_UserGroupId and
        Loop_ModuleScreenId = any(select distinct Mod_ModuleScreenId from ModuleScreenGroup) order by
        ModuleScreenId asc do
      // 
      // check if current node has been visited before, 
      // if not, enter recursive function to insert branch of nodes into UserModuleNoAccess
      //
      if not exists(select* from tmpVisitedNodes where UserGroupId = Loop_UserGroupId and
          ModuleScreenId = Loop_ModuleScreenId) then
        call ASQLInsertUserModuleNoAccess(Loop_UserGroupId,Loop_ModuleScreenId);
        commit work
      end if end for end for;
  //
  // drop temp table after use
  //
  if exists(select* from View_SysTable where Table_Name = 'tmpVisitedNodes') then
    drop table tmpVisitedNodes
  end if
end
;

create function dba.GenYearFromHireDate(
in In_EmployeesysId integer,
in In_Date date)
returns double
begin
  declare NoOfYear double;
  select DateDiff(month,HireDate,In_Date)/12.0 into NoOfYear
    from Employee where EmployeeSysId = In_EmployeesysId;
  return(NoOfYear)
end
;

create function dba.FGetPeriodEmployeeStatus(
in In_EmployeeSysId integer,
in In_PrevYear integer,
in In_PrevPeriod integer,
in In_CurYear integer,
in In_CurPeriod integer,
in In_CycleMethod char(20),
in In_Basis1 char(20),
in In_Basis2 char(20),
in In_Basis3 char(20))
returns char(20)
begin
  declare Out_PayGroupId char(20);
  declare Out_PrevStartDate date;
  declare Out_PrevEndDate date;
  declare Out_CurStartDate date;
  declare Out_CurEndDate date;
  declare Out_HireDate date;
  declare Out_CessationDate date;
  declare Out_LastPayDate date;
  declare CurEmployeeSysId integer;
  declare CurPaySectionId char(20);
  declare CurPayCostCenterId char(20);
  declare CurPayCategoryId char(20);
  declare CurPayDepartmentId char(20);
  declare CurPayBranchId char(20);
  declare CurPayPositionId char(20);
  declare CurPayPayGroupId char(20);
  declare CurPayWTCalendarId char(20);
  declare CurPayLeaveGroupId char(20);
  declare CurPaySalaryGradeId char(20);
  declare CurPayClassification char(20);
  declare CurPayEmpCode1Id char(20);
  declare CurPayEmpCode2Id char(20);
  declare CurPayEmpCode3Id char(20);
  declare CurPayEmpCode4Id char(20);
  declare CurPayEmpCode5Id char(20);
  declare PrevPaySectionId char(20);
  declare PrevEmployeeSysId integer;
  declare PrevPayCostCenterId char(20);
  declare PrevPayCategoryId char(20);
  declare PrevPayDepartmentId char(20);
  declare PrevPayBranchId char(20);
  declare PrevPayPositionId char(20);
  declare PrevPayPayGroupId char(20);
  declare PrevPayWTCalendarId char(20);
  declare PrevPayLeaveGroupId char(20);
  declare PrevPaySalaryGradeId char(20);
  declare PrevPayClassification char(20);
  declare PrevPayEmpCode1Id char(20);
  declare PrevPayEmpCode2Id char(20);
  declare PrevPayEmpCode3Id char(20);
  declare PrevPayEmpCode4Id char(20);
  declare PrevPayEmpCode5Id char(20);
  select PayEmployee.PayGroupId,Employee.HireDate,Employee.CessationDate,PayEmployee.LastPayDate into Out_PayGroupId,
    Out_HireDate,Out_CessationDate,Out_LastPayDate from Employee join PayEmployee where Employee.EmployeeSysId = In_EmployeeSysId;
  //
  // Convert Calendar Year/Month to Payroll Year/Period 
  //
  if In_CycleMethod = 'CycMtdCalen' then
    set In_PrevYear=FGetPayrollYearGivenPhyYrMth(Out_PayGroupId,In_PrevYear,In_PrevPeriod);
    set In_PrevPeriod=FGetPayrollPeriodGivenPhyYrMth(Out_PayGroupId,In_PrevYear,In_PrevPeriod);
    set In_CurYear=FGetPayrollYearGivenPhyYrMth(Out_PayGroupId,In_CurYear,In_CurPeriod);
    set In_CurPeriod=FGetPayrollPeriodGivenPhyYrMth(Out_PayGroupId,In_CurYear,In_CurPeriod)
  end if;
  //
  // Get Previous Period Start/End Date 
  //
  select first SubPeriodStartDate into Out_PrevStartDate from PayGroupPeriod where
    PayGroupId = Out_PayGroupId and
    PayGroupYear = In_PrevYear and
    PayGroupPeriod = In_PrevPeriod order by PayGroupPeriod asc;
  select first SubPeriodEndDate into Out_PrevEndDate from PayGroupPeriod where
    PayGroupId = Out_PayGroupId and
    PayGroupYear = In_PrevYear and
    PayGroupPeriod = In_PrevPeriod order by PayGroupPeriod desc;
  //
  // Get Current Period Start/End Date 
  //
  select first SubPeriodStartDate into Out_CurStartDate from PayGroupPeriod where
    PayGroupId = Out_PayGroupId and
    PayGroupYear = In_CurYear and
    PayGroupPeriod = In_CurPeriod order by PayGroupPeriod asc;
  select first SubPeriodEndDate into Out_CurEndDate from PayGroupPeriod where
    PayGroupId = Out_PayGroupId and
    PayGroupYear = In_CurYear and
    PayGroupPeriod = In_CurPeriod order by PayGroupPeriod desc;
  //
  // Check Status
  //
  if(Out_HireDate between Out_CurStartDate and Out_CurEndDate) then
    return 'CurHire'
  else
    if(Out_CessationDate between Out_PrevStartDate and Out_PrevEndDate) then
      return 'PrevResign'
    else
      if(Out_HireDate between Out_PrevStartDate and Out_PrevEndDate) then
        return 'PrevHire'
      else
        if(Out_CessationDate between Out_CurStartDate and Out_CurEndDate) then
          return 'CurResign'
        else
          if(Out_LastPayDate between Out_CurStartDate and Out_CurEndDate) then
            return 'CurLastPay'
          else
            if(In_Basis1 = '' and In_Basis2 = '' and In_Basis3 = '') then
              return 'Existing'
            else
              //
              // Get Current Employee Pay Record
              //
              select EmployeeSysId,PaySectionId,PayCostCenterId,PayCategoryId,PayDepartmentId,
                PayBranchId,PayPositionId,PayPayGroupId,PayWTCalendarId,
                PayLeaveGroupId,PaySalaryGradeId,PayClassification,PayEmpCode1Id,
                PayEmpCode2Id,PayEmpCode3Id,PayEmpCode4Id,PayEmpCode5Id into CurEmployeeSysId,
                CurPaySectionId,CurPayCostCenterId,CurPayCategoryId,CurPayDepartmentId,
                CurPayBranchId,CurPayPositionId,CurPayPayGroupId,CurPayWTCalendarId,
                CurPayLeaveGroupId,CurPaySalaryGradeId,CurPayClassification,CurPayEmpCode1Id,
                CurPayEmpCode2Id,CurPayEmpCode3Id,CurPayEmpCode4Id,
                CurPayEmpCode5Id from
                PayPeriodRecord where PayRecYear = In_CurYear and
                PayRecPeriod = In_CurPeriod and EmployeeSysId = In_EmployeeSysId;
              //
              // Get Previous Employee Pay Record
              //
              select EmployeeSysId,PaySectionId,PayCostCenterId,PayCategoryId,PayDepartmentId,
                PayBranchId,PayPositionId,PayPayGroupId,PayWTCalendarId,
                PayLeaveGroupId,PaySalaryGradeId,PayClassification,PayEmpCode1Id,
                PayEmpCode2Id,PayEmpCode3Id,PayEmpCode4Id,PayEmpCode5Id into PrevEmployeeSysId,
                PrevPaySectionId,PrevPayCostCenterId,PrevPayCategoryId,PrevPayDepartmentId,
                PrevPayBranchId,PrevPayPositionId,PrevPayPayGroupId,PrevPayWTCalendarId,
                PrevPayLeaveGroupId,PrevPaySalaryGradeId,PrevPayClassification,PrevPayEmpCode1Id,
                PrevPayEmpCode2Id,PrevPayEmpCode3Id,PrevPayEmpCode4Id,
                PrevPayEmpCode5Id from
                PayPeriodRecord as PayPeriodRecord where
                PayRecYear = In_PrevYear and
                PayRecPeriod = In_PrevPeriod and EmployeeSysId = In_EmployeeSysId;
              //
              // Check for Transfer 
              //
              if CurEmployeeSysId is not null and PrevEmployeeSysId is not null then
                //message 'test' type info to client;
                if(In_Basis1 = 'PaySectionId' or In_Basis2 = 'PaySectionId' or In_Basis3 = 'PaySectionId') and PrevPaySectionId <> CurPaySectionId then
                  return 'Transfer'
                end if;
                if(In_Basis1 = 'PayCostCenterId' or In_Basis2 = 'PayCostCenterId' or In_Basis3 = 'PayCostCenterId') and PrevPayCostCenterId <> CurPayCostCenterId then
                  return 'Transfer'
                end if;
                if(In_Basis1 = 'PayCategoryId' or In_Basis2 = 'PayCategoryId' or In_Basis3 = 'PayCategoryId') and PrevPayCategoryId <> CurPayCategoryId then
                  return 'Transfer'
                end if;
                if(In_Basis1 = 'PayDepartmentId' or In_Basis2 = 'PayDepartmentId' or In_Basis3 = 'PayDepartmentId') and PrevPayDepartmentId <> CurPayDepartmentId then
                  return 'Transfer'
                end if;
                if(In_Basis1 = 'PayBranchId' or In_Basis2 = 'PayBranchId' or In_Basis3 = 'PayBranchId') and PrevPayBranchId <> CurPayBranchId then
                  return 'Transfer'
                end if;
                if(In_Basis1 = 'PayPositionId' or In_Basis2 = 'PayPositionId' or In_Basis3 = 'PayPositionId') and PrevPayPositionId <> CurPayPositionId then
                  return 'Transfer'
                end if;
                if(In_Basis1 = 'PayPayGroupId' or In_Basis2 = 'PayPayGroupId' or In_Basis3 = 'PayPayGroupId') and PrevPayPayGroupId <> CurPayPayGroupId then
                  return 'Transfer'
                end if;
                if(In_Basis1 = 'PayWTCalendarId' or In_Basis2 = 'PayWTCalendarId' or In_Basis3 = 'PayWTCalendarId') and PrevPayWTCalendarId <> CurPayWTCalendarId then
                  return 'Transfer'
                end if;
                if(In_Basis1 = 'PayLeaveGroupId' or In_Basis2 = 'PayLeaveGroupId' or In_Basis3 = 'PayLeaveGroupId') and PrevPayLeaveGroupId <> CurPayLeaveGroupId then
                  return 'Transfer'
                end if;
                if(In_Basis1 = 'PaySalaryGradeId' or In_Basis2 = 'PaySalaryGradeId' or In_Basis3 = 'PaySalaryGradeId') and PrevPaySalaryGradeId <> CurPaySalaryGradeId then
                  return 'Transfer'
                end if;
                if(In_Basis1 = 'PayClassification' or In_Basis2 = 'PayClassification' or In_Basis3 = 'PayClassification') and PrevPayClassification <> CurPayClassification then
                  return 'Transfer'
                end if;
                if(In_Basis1 = 'PayEmpCode1Id' or In_Basis2 = 'PayEmpCode1Id' or In_Basis3 = 'PayEmpCode1Id') and PrevPayEmpCode1Id <> CurPayEmpCode1Id then
                  return 'Transfer'
                end if;
                if(In_Basis1 = 'PayEmpCode2Id' or In_Basis2 = 'PayEmpCode2Id' or In_Basis3 = 'PayEmpCode2Id') and PrevPayEmpCode2Id <> CurPayEmpCode2Id then
                  return 'Transfer'
                end if;
                if(In_Basis1 = 'PayEmpCode3Id' or In_Basis2 = 'PayEmpCode3Id' or In_Basis3 = 'PayEmpCode3Id') and PrevPayEmpCode3Id <> CurPayEmpCode3Id then
                  return 'Transfer'
                end if;
                if(In_Basis1 = 'PayEmpCode4Id' or In_Basis2 = 'PayEmpCode4Id' or In_Basis3 = 'PayEmpCode4Id') and PrevPayEmpCode4Id <> CurPayEmpCode4Id then
                  return 'Transfer'
                end if;
                if(In_Basis1 = 'PayEmpCode5Id' or In_Basis2 = 'PayEmpCode5Id' or In_Basis3 = 'PayEmpCode5Id') and PrevPayEmpCode5Id <> CurPayEmpCode5Id then
                  return 'Transfer'
                end if
              end if
            end if
          end if
        end if
      end if
    end if
  end if;
  return 'Existing'
end
;

create procedure dba.DeleteBankAllocGroup(
in In_BankAllocGpId char(20))
begin
  if exists(select* from BankAllocGroup where BankAllocGroup.BankAllocGpId = In_BankAllocGpId) then
    delete from BankAllocGroup where
      BankAllocGroup.BankAllocGpId = In_BankAllocGpId;
    commit work
  end if
end
;

create procedure dba.InsertNewBankAllocGroup(
in In_BankAllocGpId char(20),
in In_BankAllocGpDesc char(100))
begin
  if not exists(select* from BankAllocGroup where BankAllocGroup.BankAllocGpId = In_BankAllocGpId) then
    insert into BankAllocGroup(BankAllocGpId,BankAllocGpDesc) values(In_BankAllocGpId,In_BankAllocGpDesc);
    commit work
  end if
end
;

create procedure dba.UpdateBankAllocGroup(
in In_BankAllocGpId char(20),
in In_BankAllocGpDesc char(100))
begin
  if exists(select* from BankAllocGroup where BankAllocGroup.BankAllocGpId = In_BankAllocGpId) then
    update BankAllocGroup set
      BankAllocGroup.BankAllocGpDesc = In_BankAllocGpDesc where
      BankAllocGroup.BankAllocGpId = In_BankAllocGpId;
    commit work
  end if
end
;

create function DBA.FGetEmployeeIdentityNo(
in In_EmployeeSysId integer)
returns char(30)
begin
  declare Out_EmployeeIdentityNo char(30);
  select Employee.IdentityNo into Out_EmployeeIdentityNo
    from Employee where
    Employee.EmployeeSysId = In_EmployeeSysId;
  return(Out_EmployeeIdentityNo)
end
;

create procedure dba.ASQLUpdateCareerAttributeValueAll(
in In_EmployeeSysId integer,
in In_CareerAttributeId char(20),
in In_CareerNewValue char(100))
begin
  CareerProgLoop: for CareerProgFor as CareerProgCurs dynamic scroll cursor for
    select CareerEffectiveDate as tmp_CareerEffectiveDate from CareerProgression where
      EmployeeSysId = In_EmployeeSysId order by
      CareerEffectiveDate asc do
    if exists(select* from CareerAttribute where
        EmployeeSysId = In_EmployeeSysId and
        CareerEffectiveDate = tmp_CareerEffectiveDate and
        CareerAttributeId = In_CareerAttributeId) then
      update CareerAttribute set CareerNewValue = In_CareerNewValue where
        EmployeeSysId = In_EmployeeSysId and
        CareerEffectiveDate = tmp_CareerEffectiveDate and
        CareerAttributeId = In_CareerAttributeId
    else
      insert into CareerAttribute(EmployeeSysId,CareerEffectiveDate,CareerAttributeID,CareerNewValue) values(
        In_EmployeeSysId,tmp_CareerEffectiveDate,In_CareerAttributeId,In_CareerNewValue)
    end if;
    commit work end for
end
;

create procedure dba.ASQLUpdateCareerAttributeValueDateRange(
in In_EmployeeSysId integer,
in In_FromEffectiveDate date,
in In_ToEffectiveDate date,
in In_CareerAttributeId char(20),
in In_CareerNewValue char(100))
begin
  CareerProgLoopAll: for CareerProgAllFor as CareerProgAllCurs dynamic scroll cursor for
    select CareerEffectiveDate as tmp_CareerEffectiveDate from CareerProgression where
      EmployeeSysId = In_EmployeeSysId and
      CareerEffectiveDate between In_FromEffectiveDate and In_ToEffectiveDate order by
      CareerEffectiveDate asc do
    if exists(select* from CareerAttribute where
        EmployeeSysId = In_EmployeeSysId and
        CareerEffectiveDate = tmp_CareerEffectiveDate and
        CareerAttributeId = In_CareerAttributeId) then
      update CareerAttribute set CareerNewValue = In_CareerNewValue where
        EmployeeSysId = In_EmployeeSysId and
        CareerEffectiveDate = tmp_CareerEffectiveDate and
        CareerAttributeId = In_CareerAttributeId;
      commit work
    else
      insert into CareerAttribute(EmployeeSysId,CareerEffectiveDate,CareerAttributeID,CareerNewValue) values(
        In_EmployeeSysId,tmp_CareerEffectiveDate,In_CareerAttributeId,In_CareerNewValue);
      commit work
    end if end for
end
;

create procedure dba.ASQLUpdateCareerAttributeValueLatest(
in In_EmployeeSysId integer,
in In_CareerAttributeId char(20),
in In_CareerNewValue char(100))
begin
  declare In_CareerEffectiveDate date;
  select first CareerEffectiveDate into In_CareerEffectiveDate from CareerProgression where
    EmployeeSysId = In_EmployeeSysId order by
    CareerEffectiveDate desc;
  if exists(select* from CareerAttribute where
      EmployeeSysId = In_EmployeeSysId and
      CareerEffectiveDate = In_CareerEffectiveDate and
      CareerAttributeId = In_CareerAttributeId) then
    update CareerAttribute set CareerNewValue = In_CareerNewValue where
      EmployeeSysId = In_EmployeeSysId and
      CareerEffectiveDate = In_CareerEffectiveDate and
      CareerAttributeId = In_CareerAttributeId
  else
    insert into CareerAttribute(EmployeeSysId,CareerEffectiveDate,CareerAttributeID,CareerNewValue) values(
      In_EmployeeSysId,In_CareerEffectiveDate,In_CareerAttributeId,In_CareerNewValue)
  end if;
  commit work
end
;

commit work;
