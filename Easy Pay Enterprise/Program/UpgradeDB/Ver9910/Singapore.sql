create procedure DBA.ASQLNSGenerateOffDays(
in In_EmployeeSysId integer,
in In_NSPaySysId integer)
begin
  declare In_CalendarId char(20);
  declare In_NSStartDate date;
  declare In_NSEndDate date;
  select first CalendarId into In_CalendarId from EmpeeWkCalen where
    EmployeeSysId = In_EmployeeSysId order by EmpeeWkCalenEffDate;
  select NSStartDate,NSEndDate into In_NSStartDate,In_NSEndDate from NSPayCase where NSPaySysId = In_NSPaySysId;
  delete from NSOffDayDate where NSPaySysId = In_NSPaySysId;
  commit work;
  OffDayLoop: for OffDayFor as curs dynamic scroll cursor for
    select CalendarDate as In_CalendarDate from CalendarDay where
      CalendarIdCode = In_CalendarId and
      WkCalenDayWkPattern = 0 and
      CalendarDate between In_NSStartDate and In_NSEndDate do
    insert into NSOffDayDate(NSPaySysId,NSOffDayDate) values(In_NSPaySysId,In_CalendarDate) end for;
  commit work
end
;


create procedure DBA.ASQLNSItemRecord(
in In_NSPaySysId integer,
in In_NSFormulaId char(20),
in In_NSFormulaType char(20),
in In_NSFormulaString char(100),
in In_NSItemAvgAmt double,
in In_NSItemAmt double,
in In_NSMonth1Amt double,
in In_NSMonth2Amt double,
in In_NSMonth3Amt double,
in In_NSMonth4Amt double,
in In_NSMonth5Amt double,
in In_NSMonth6Amt double)
begin
  if exists(select* from NSItemRecord where
      NSPaySysId = In_NSPaySysId and
      NSFormulaId = In_NSFormulaId and
      NSFormulaType = In_NSFormulaType) then
    if(In_NSItemAmt <> 0) then
      update NSItemRecord set
        NSFormulaString = In_NSFormulaString,
        NSItemAvgAmt = In_NSItemAvgAmt,
        NSItemAmt = In_NSItemAmt,
        NSMonth1Amt = In_NSMonth1Amt,
        NSMonth2Amt = In_NSMonth2Amt,
        NSMonth3Amt = In_NSMonth3Amt,
        NSMonth4Amt = In_NSMonth4Amt,
        NSMonth5Amt = In_NSMonth5Amt,
        NSMonth6Amt = In_NSMonth6Amt where
        NSPaySysId = In_NSPaySysId and
        NSFormulaId = In_NSFormulaId and
        NSFormulaType = In_NSFormulaType
    else
      delete from NSItemRecord where
        NSPaySysId = In_NSPaySysId and
        NSFormulaId = In_NSFormulaId and
        NSFormulaType = In_NSFormulaType
    end if
  else
    if(In_NSItemAmt <> 0) then
      insert into NSItemRecord(NSPaySysId,
        NSFormulaId,
        NSFormulaType,
        NSFormulaString,
        NSItemAvgAmt,
        NSItemAmt,
        NSMonth1Amt,
        NSMonth2Amt,
        NSMonth3Amt,
        NSMonth4Amt,
        NSMonth5Amt,
        NSMonth6Amt) values(In_NSPaySysId,
        In_NSFormulaId,
        In_NSFormulaType,
        In_NSFormulaString,
        In_NSItemAvgAmt,
        In_NSItemAmt,
        In_NSMonth1Amt,
        In_NSMonth2Amt,
        In_NSMonth3Amt,
        In_NSMonth4Amt,
        In_NSMonth5Amt,
        In_NSMonth6Amt)
    end if
  end if;
  commit work
end
;


create procedure dba.InsertNewNSPayCase(
in In_EmployeeSysId integer,
in In_NSStartDate date,
in In_NSEndDate date,
in In_NSDays double,
in In_NSPositionId char(40),
in In_NSVenue char(100),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_PostalCode char(6),
in In_ContactPerson char(50),
in In_ContactNumber char(30),
in In_NSFormulaCategory char(2),
in In_NSFormulaCode char(2),
in In_NSPayElementId char(20),
in In_NSPeriodStart integer,
in In_NSPayoutAmt double,
in In_NSLastGeneration timestamp,
in In_NSDateFirstSatOff date,
in In_NSShiftWorkStart time,
in In_NSShiftWorkEnd time,
in In_NSInsertPayElement integer,
in In_PayrollDate date,
in In_PayrollYear integer,
in In_PayrollPeriod integer,
in In_PayrollSubPeriod integer,
in In_PayrollProcessDate date,
in In_NSPayRecId char(20),
in In_AuthorisedName char(60),
in In_NSDesignation char(20),
in In_NSMonth1Str char(20),
in In_NSMonth2Str char(20),
in In_NSMonth3Str char(20),
in In_NSMonth4Str char(20),
in In_NSMonth5Str char(20),
in In_NSMonth6Str char(20),
in In_BatchID char(20),
in In_PayPeriodStartDay integer,
out Out_NSPaySysId integer,
out Out_ErrorCode integer)
begin
  set Out_NSPaySysId=null;
  if(FGetInvalidDate(In_NSStartDate) = '') then
    set Out_ErrorCode=-1;
    return
  end if;
  if(FGetInvalidDate(In_NSEndDate) = '') then
    set Out_ErrorCode=-2;
    return
  end if;
  if(In_AuthorisedName = '') then
    set Out_ErrorCode=-3;
    return
  end if;
  if(In_NSDesignation = '') then
    set Out_ErrorCode=-4;
    return
  end if;
  if(In_NSStartDate = In_NSEndDate and In_NSShiftWorkStart is null) then
    set Out_ErrorCode=-5;
    return
  end if;
  if(In_NSStartDate = In_NSEndDate and In_NSShiftWorkEnd is null) then
    set Out_ErrorCode=-6;
    return
  end if;
  if(In_NSStartDate <> In_NSEndDate and In_NSDays <= 1) then
    set Out_ErrorCode=-7;
    return
  end if;
  if(In_NSStartDate = In_NSEndDate and In_NSDays <> 1 and In_NSDays <> .5) then
    set Out_ErrorCode=-8;
    return
  end if;
  if(In_NSStartDate <> In_NSEndDate) then
    set In_NSShiftWorkStart='12:00:00 am';
    set In_NSShiftWorkEnd='12:00:00 am'
  end if;
  select max(NSPaySysId) into Out_NSPaySysId from NSPayCase;
  if(Out_NSPaySysId is null) then
    set Out_NSPaySysId=0
  end if;
  if not exists(select* from NSPayCase where
      NSPayCase.NSPaySysId = Out_NSPaySysId+1) then
    insert into NSPayCase(NSPaySysId,
      EmployeeSysId,
      NSStartDate,
      NSEndDate,
      NSDays,
      NSPositionId,
      NSVenue,
      Address1,
      Address2,
      Address3,
      PostalCode,
      ContactPerson,
      ContactNumber,
      NSFormulaCategory,
      NSFormulaCode,
      NSPayElementId,
      NSPeriodStart,
      NSPayoutAmt,
      NSLastGeneration,
      NSDateFirstSatOff,
      NSShiftWorkStart,
      NSShiftWorkEnd,
      NSInsertPayElement,
      PayrollDate,
      PayrollYear,
      PayrollPeriod,
      PayrollSubPeriod,
      PayrollProcessDate,
      NSPayRecId,
      AuthorisedName,
      NSDesignation,
      NSMonth1Str,
      NSMonth2Str,
      NSMonth3Str,
      NSMonth4Str,
      NSMonth5Str,
      NSMonth6Str,BatchID,
      PayPeriodStartDay) values(
      Out_NSPaySysId+1,
      In_EmployeeSysId,
      In_NSStartDate,
      In_NSEndDate,
      In_NSDays,
      In_NSPositionId,
      In_NSVenue,
      In_Address1,
      In_Address2,
      In_Address3,
      In_PostalCode,
      In_ContactPerson,
      In_ContactNumber,
      In_NSFormulaCategory,
      In_NSFormulaCode,
      In_NSPayElementId,
      In_NSPeriodStart,
      In_NSPayoutAmt,
      In_NSLastGeneration,
      In_NSDateFirstSatOff,
      In_NSShiftWorkStart,
      In_NSShiftWorkEnd,
      In_NSInsertPayElement,
      In_PayrollDate,
      In_PayrollYear,
      In_PayrollPeriod,
      In_PayrollSubPeriod,
      In_PayrollProcessDate,
      In_NSPayRecId,
      In_AuthorisedName,
      In_NSDesignation,
      In_NSMonth1Str,
      In_NSMonth2Str,
      In_NSMonth3Str,
      In_NSMonth4Str,
      In_NSMonth5Str,
      In_NSMonth6Str,In_BatchID,
      In_PayPeriodStartDay);
    commit work;
    if not exists(select* from NSPayCase where
        NSPayCase.NSPaySysId = Out_NSPaySysId+1) then
      set Out_NSPaySysId=null;
      set Out_ErrorCode=0
    else
      set Out_NSPaySysId=Out_NSPaySysId+1;
      set Out_ErrorCode=1
    end if
  else
    set Out_NSPaySysId=null;
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateNSPayCase(
in In_NSPaySysId integer,
in In_EmployeeSysId integer,
in In_NSStartDate date,
in In_NSEndDate date,
in In_NSDays double,
in In_NSPositionId char(40),
in In_NSVenue char(100),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_PostalCode char(6),
in In_ContactPerson char(50),
in In_ContactNumber char(30),
in In_NSFormulaCategory char(2),
in In_NSFormulaCode char(2),
in In_NSPayElementId char(20),
in In_NSPeriodStart integer,
in In_NSPayoutAmt double,
in In_NSLastGeneration timestamp,
in In_NSDateFirstSatOff date,
in In_NSShiftWorkStart time,
in In_NSShiftWorkEnd time,
in In_NSInsertPayElement integer,
in In_PayrollDate date,
in In_PayrollYear integer,
in In_PayrollPeriod integer,
in In_PayrollSubPeriod integer,
in In_PayrollProcessDate date,
in In_NSPayRecId char(20),
in In_AuthorisedName char(60),
in In_NSDesignation char(20),
in In_NSMonth1Str char(20),
in In_NSMonth2Str char(20),
in In_NSMonth3Str char(20),
in In_NSMonth4Str char(20),
in In_NSMonth5Str char(20),
in In_NSMonth6Str char(20),
in In_BatchID char(20),
in In_PayPeriodStartDay integer,
out Out_ErrorCode integer)
begin
  if(FGetInvalidDate(In_NSStartDate) = '') then
    set Out_ErrorCode=-1;
    return
  end if;
  if(FGetInvalidDate(In_NSEndDate) = '') then
    set Out_ErrorCode=-2;
    return
  end if;
  if(In_AuthorisedName = '') then
    set Out_ErrorCode=-3;
    return
  end if;
  if(In_NSDesignation = '') then
    set Out_ErrorCode=-4;
    return
  end if;
  if(In_NSStartDate = In_NSEndDate and In_NSShiftWorkStart is null) then
    set Out_ErrorCode=-5;
    return
  end if;
  if(In_NSStartDate = In_NSEndDate and In_NSShiftWorkEnd is null) then
    set Out_ErrorCode=-6;
    return
  end if;
  if(In_NSStartDate <> In_NSEndDate and In_NSDays <= 1) then
    set Out_ErrorCode=-7;
    return
  end if;
  if(In_NSStartDate = In_NSEndDate and In_NSDays <> 1 and In_NSDays <> .5) then
    set Out_ErrorCode=-8;
    return
  end if;
  if(In_NSFormulaCategory = 16 and(In_PayPeriodStartDay < 2 or In_PayPeriodStartDay > 31)) then
    set Out_ErrorCode=-9;
    return
  end if;
  if(In_NSStartDate <> In_NSEndDate) then
    set In_NSShiftWorkStart='12:00:00 am';
    set In_NSShiftWorkEnd='12:00:00 am'
  end if;
  if exists(select* from NSPayCase where
      NSPayCase.NSPaySysId = In_NSPaySysId) then
    update NSPayCase set EmployeeSysId = In_EmployeeSysId,
      NSStartDate = In_NSStartDate,
      NSEndDate = In_NSEndDate,
      NSDays = In_NSDays,
      NSPositionId = In_NSPositionId,
      NSVenue = In_NSVenue,
      Address1 = In_Address1,
      Address2 = In_Address2,
      Address3 = In_Address3,
      PostalCode = In_PostalCode,
      ContactPerson = In_ContactPerson,
      ContactNumber = In_ContactNumber,
      NSFormulaCategory = In_NSFormulaCategory,
      NSFormulaCode = In_NSFormulaCode,
      NSPayElementId = In_NSPayElementId,
      NSPeriodStart = In_NSPeriodStart,
      NSPayoutAmt = In_NSPayoutAmt,
      NSLastGeneration = In_NSLastGeneration,
      NSDateFirstSatOff = In_NSDateFirstSatOff,
      NSShiftWorkStart = In_NSShiftWorkStart,
      NSShiftWorkEnd = In_NSShiftWorkEnd,
      NSInsertPayElement = In_NSInsertPayElement,
      PayrollDate = In_PayrollDate,
      PayrollYear = In_PayrollYear,
      PayrollPeriod = In_PayrollPeriod,
      PayrollSubPeriod = In_PayrollSubPeriod,
      PayrollProcessDate = In_PayrollProcessDate,
      NSPayRecId = In_NSPayRecId,
      AuthorisedName = In_AuthorisedName,
      NSDesignation = In_NSDesignation,
      NSMonth1Str = In_NSMonth1Str,
      NSMonth2Str = In_NSMonth2Str,
      NSMonth3Str = In_NSMonth3Str,
      NSMonth4Str = In_NSMonth4Str,
      NSMonth5Str = In_NSMonth5Str,
      NSMonth6Str = In_NSMonth6Str,
      BatchID = In_BatchID,
      PayPeriodStartDay = In_PayPeriodStartDay where
      NSPayCase.NSPaySysId = In_NSPaySysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteNSPayCase(
in In_NSPaySysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from NSPayCase where
      NSPayCase.NSPaySysId = In_NSPaySysId) then
    if exists(select* from NSOffDayDate where
        NSOffDayDate.NSPaySysId = In_NSPaySysId) then
      delete from NSOffDayDate where NSOffDayDate.NSPaySysId = In_NSPaySysId
    end if;
    if exists(select* from NSItemRecord where
        NSItemRecord.NSPaySysId = In_NSPaySysId) then
      delete from NSItemRecord where NSItemRecord.NSPaySysId = In_NSPaySysId
    end if;
    delete from NSPayCase where
      NSPayCase.NSPaySysId = In_NSPaySysId;
    commit work;
    if exists(select* from NSPayCase where
        NSPayCase.NSPaySysId = In_NSPaySysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.ASQLUpdateNSLastGeneration(
in In_NSPaySysId integer,
in In_NSLastGeneration timestamp)
begin
  if exists(select* from NSPayCase where NSPaySysId = In_NSPaySysId) then
    update NSPayCase set NSLastGeneration = In_NSLastGeneration where
      NSPaySysId = In_NSPaySysId;
    commit work
  end if
end
;

/* ============================================================ */
/*   Database name:  Model_2                                    */
/*   DBMS name:      Sybase AS Anywhere 6                       */
/*   Created on:     9/10/2004  3:47 PM                         */
/* ============================================================ */

create procedure DBA.ASQLUpdateIRASNationality()
begin
  declare Ins_IRASNationalityCode char(20);
  CountryLoop: for CountryFor as curs dynamic scroll cursor for
    select CountryID as CountryFor from Country do
    if not exists(select EPECountryID from IRASNAtionality where EPECountryID = CountryFor) then
      if not exists(select YEProperty3 from YEKeyword where YEKeywordId = CountryFor and YEKeywordCategory = 'IRASNationality') then
        set Ins_IRASNationalityCode=999
      else select YEProperty3 into Ins_IRASNationalityCode from YEKeyword where YEKeywordId = CountryFor and YEKeywordCategory = 'IRASNationality'
      end if;
      insert into IRASNationality(EPECountryID,IRASNationalityCode) values(CountryFor,Ins_IRASNationalityCode);
      commit work
    end if end for
end
;

create procedure DBA.ASQLYEEmploymentHistory(
in In_PersonalSysId integer,
in In_YEYear integer)
begin
  CreateEmploymentLoop: for EmploymentFor as curs dynamic scroll cursor for
    select Employee.EmployeeSysId as Out_YEEmployeeSysId,
      HireDate as Out_FromDate,
      CessationDate as Out_ToDate,
      PayGroupId as Out_YEPayGroupId from
      Employee join PayEmployee where Employee.PersonalSysId = In_PersonalSysId and
      (CessationDate = '1899-12-30' or Year(LastPayDate) >= In_YEYear) do
    call InsertNewEmploymentHistory(In_PersonalSysId,
    In_YEYear,
    Out_YEEmployeeSysId,
    Out_YEPayGroupId,
    Out_FromDate,
    Out_ToDate) end for
end
;

create procedure DBA.ASQLYEIR8SCrossUpdate(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_FlagOverseasCPF char(1),
in In_FlagExcessCPF char(1),
in In_IR8SIndicator char(1),
in In_Flag100K char(1),
in In_FlagPercentOrdWage char(1),
in In_EEOverseasCPF double,
in In_EEVoluntaryCPF double,
in In_ERExcessContri double)
begin
  update YEEmployee set
    IR8SIndicator = In_IR8SIndicator,
    Flag100K = In_Flag100K,
    FlagPercentOrdWage = In_FlagPercentOrdWage,
    FlagOverseasCPF = In_FlagOverseasCPF,
    FlagExcessCPF = In_FlagExcessCPF where
    YEEmployee.PersonalSysID = In_PersonalSysID and
    YEEmployee.YEYear = In_YEYear;
  update IR8A set
    ERExcessContri = In_ERExcessContri,
    EEVoluntaryCPF = In_EEVoluntaryCPF,
    EEOverseasCPF = In_EEOverseasCPF where
    IR8A.PersonalSysID = In_PersonalSysID and
    IR8A.YEYear = In_YEYear and
    IR8A.IR8AType = 'CurIR8A';
  commit work
end
;

create procedure DBA.ASQLYEProcessA8A(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_Operation char(20),
in In_OtherBenefits double,
in In_ProcessIR21 char(1))
begin
  declare In_OccupationFrom date;
  declare In_OccupationTo date;
  declare In_OccupationDays integer;
  declare In_ResidenceAddress1 char(30);
  declare In_ResidenceAddress2 char(30);
  declare In_ResidenceAddress3 char(30);
  declare In_TotalBenefitInKind double;
  declare In_Section2Total double;
  declare In_Section3Total double;
  declare In_Section4Total double;
  declare In_ResidenceValue double;
  declare In_NoOfEESharingQtr double;
  declare In_IncidentalBenefits double;
  declare In_OHQStatus char(1);
  declare DayInYear double;
  /*
  To default the Occupation Dates and residence Address
  */
  if(In_Operation = 'Create') then
    set In_ResidenceAddress1='';
    set In_ResidenceAddress2='';
    set In_ResidenceAddress3='';
    select 0 into In_OccupationDays
  else
    select OccupationFrom,OccupationTo into In_OccupationFrom,In_OccupationTo from A8A where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear;
    if(In_OccupationFrom = '1899-12-30' or In_OccupationTo = '1899-12-30') then
      set In_OccupationDays=0
    else
      select days(In_OccupationFrom,In_OccupationTo)+1 into In_OccupationDays
    end if
  end if;
  if(In_Operation = 'Create') then
    call InsertNewA8A(In_PersonalSysId,
    In_YEYear,'',
    /*In_FormHeaderMsg*/
    0, /*In_ResidenceValue*/
    In_ResidenceAddress1,
    In_ResidenceAddress2,
    In_ResidenceAddress3,
    0, /*In_ERPaidRent*/
    0, /*In_EEPaidRent*/
    In_OccupationFrom,
    In_OccupationTo,
    In_OccupationDays,
    0, /*In_Section2Total*/
    0, /*In_Section3Total*/
    0, /*In_Section4Total*/
    0, /*In_IncidentalBenefits*/
    0, /*In_PassagesSelf*/
    0, /*In_PassagesWife*/
    0, /*In_PassagesChildren*/
    0, /*In_InterestLoan*/
    0, /*In_LifeInsurance*/
    0, /*In_Holidays*/
    0, /*In_Education*/
    0, /*In_LongService*/
    0, /*In_Clubs*/
    0, /*In_Assets*/
    0, /*In_MotorVehicle*/
    0, /*In_CarBenefit*/
    In_OtherBenefits,'','','','',
    /*In_OtherBenefitsDetails*/
    /*In_OHQStatus*/
    /*In_OHQDetails*/
    /*In_Additional*/
    0, /*In_TotalBenefitInKind*/
    0); /*NoOfEESharingQtr*/
    /*
    To create A8A section 2 Items
    */
    if(In_ProcessIR21 = 'N') then
      call ASQLYECreateA8A_S2S3(In_PersonalSysID,In_YEYear)
    else
      call ASQLYECreateIR21A1_S2S3(In_PersonalSysID,In_YEYear)
    end if
  else
    update A8A set
      OccupationDays = In_OccupationDays where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear;
    /*
    For Re-Reprocess Only
    */
    if(In_Operation = 'Reprocess') then
      /*
      No Of EE Sharing Quarter
      */
      select NoOfEESharingQtr into In_NoOfEESharingQtr
        from A8A where
        PersonalSysId = In_PersonalSysId and
        YEYear = In_YEYear;
      if(In_NoOfEESharingQtr < 0) then
        set In_NoOfEESharingQtr=0
      end if;
      if(In_ProcessIR21 = 'N') then
        call ASQLYEReprocessA8A_S2S3(In_PersonalSysID,In_YEYear,In_NoOfEESharingQtr)
      else
        call ASQLYEReprocessIR21A1_S2S3(In_PersonalSysID,In_YEYear,In_NoOfEESharingQtr)
      end if;
      /*
      Update the OtherBenefits value if reprocess
      */
      update A8A set
        OtherBenefits = In_OtherBenefits where
        PersonalSysId = In_PersonalSysId and
        YEYear = In_YEYear;
      commit work
    end if
  end if;
  /*
  Compute Total for Section 2, 3 and 4
  */
  select sum(Sec2Value) into In_Section2Total from A8AS2 where Sec2Selection = 1 and
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  if(In_Section2Total is null) then
    set In_Section2Total=0
  end if;
  select sum(Sec3Value) into In_Section3Total from A8AS3 where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  if(In_Section3Total is null) then
    set In_Section3Total=0
  end if;
  select Round(IncidentalBenefits+
    InterestLoan+
    LifeInsurance+
    Holidays+
    Education+
    LongService+
    Clubs+
    Assets+
    MotorVehicle+
    CarBenefit+
    OtherBenefits,2) into In_Section4Total from A8A where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  if(In_Section4Total is null) then
    set In_Section4Total=0
  end if;
  /*
  Compute A8A Total Benefits in Kind
  */
  select ResidenceValue,IncidentalBenefits,OHQStatus into In_ResidenceValue,In_IncidentalBenefits,In_OHQStatus from A8A where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  /*
  Default OHQ Status to No if NA when Incidental Benefits is not zero
  */
  if(In_IncidentalBenefits <> 0 and In_OHQStatus = '') then
    set In_OHQStatus='N'
  end if;
  /*
  Update Total
  */
  set In_TotalBenefitInKind=In_ResidenceValue+
    In_Section2Total+In_Section3Total+In_Section4Total;
  update A8A set
    OHQStatus = In_OHQStatus,
    TotalBenefitInKind = In_TotalBenefitInKind,
    Section2Total = In_Section2Total,
    Section3Total = In_Section3Total,
    Section4Total = In_Section4Total where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  commit work
end
;

create procedure DBA.ASQLYEProcessA8B(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_Operation char(20))
begin
  declare Out_TotalEESOPTaxExempt double;
  declare Out_TotalCSOPTaxExempt double;
  declare Out_TotalESOPNoTaxExempt double;
  declare Out_TotalEESOPNoTaxExempt double;
  declare Out_TotalCSOPNoTaxExempt double;
  declare Out_TotalESOPStockGains double;
  declare Out_TotalEESOPStockGains double;
  declare Out_TotalCSOPStockGains double;
  declare Out_GrandTotalStockGains double;
  declare Out_TotalESOPNoTaxExemptBef double;
  declare Out_TotalESOPStockGainsBef double;
  declare Out_TotalEESOPTaxExemptBef double;
  declare Out_TotalEESOPNoTaxExemptBef double;
  declare Out_TotalEESOPStockGainsBef double;
  declare Out_TotalCSOPTaxExemptBef double;
  declare Out_TotalCSOPNoTaxExemptBef double;
  declare Out_TotalCSOPStockGainsBef double;
  /*
  To create A8B record
  */
  if(In_Operation = 'Create') then
    call InsertNewA8B(In_PersonalsysId,
    In_YEYear,'',
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,'',0,
    0,0,0,0,0,0,0,0)
  end if;
  /*
  To compute ESOP
  */
  update A8BRecord set
    EESOPTaxExempt = 0,
    CSOPTaxExempt = 0,
    NoTaxExempt = Round((MktValueExerciseStock-ExercisePriceStock)*SharesAcquired,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'ESOP';
  update A8BRecord set
    StockGains = Round(NoTaxExempt,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'ESOP';
  /*
  To compute EESOP
  */
  update A8BRecord set
    EESOPTaxExempt = Round((MktValueExerciseStock-MktValueStockGrant)*SharesAcquired,2),
    CSOPTaxExempt = 0,
    NoTaxExempt = Round((MktValueStockGrant-ExercisePriceStock)*SharesAcquired,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'EESOP';
  update A8BRecord set
    StockGains = Round(EESOPTaxExempt+NoTaxExempt,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'EESOP';
  /*
  To compute CSOP
  */
  update A8BRecord set
    EESOPTaxExempt = 0,
    CSOPTaxExempt = Round((MktValueExerciseStock-MktValueStockGrant)*SharesAcquired,2),
    NoTaxExempt = Round((MktValueStockGrant-ExercisePriceStock)*SharesAcquired,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'CSOP';
  update A8BRecord set
    StockGains = Round(CSOPTaxExempt+NoTaxExempt,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'CSOP';
  /*
  To EESOP Tax Exempt
  */
  select Sum(EESOPTaxExempt) into Out_TotalEESOPTaxExempt from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'EESOP';
  if(Out_TotalEESOPTaxExempt is null) then set Out_TotalEESOPTaxExempt=0
  end if;
  select Sum(EESOPTaxExempt) into Out_TotalEESOPTaxExemptBef from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'EESOP' and GrantedBef = 1;
  if(Out_TotalEESOPTaxExemptBef is null) then set Out_TotalEESOPTaxExemptBef=0
  end if;
  /*
  To CSOP Tax Exempt
  */
  select Sum(CSOPTaxExempt) into Out_TotalCSOPTaxExempt from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'CSOP';
  if(Out_TotalCSOPTaxExempt is null) then set Out_TotalCSOPTaxExempt=0
  end if;
  select Sum(CSOPTaxExempt) into Out_TotalCSOPTaxExemptBef from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'CSOP' and GrantedBef = 1;
  if(Out_TotalCSOPTaxExemptBef is null) then set Out_TotalCSOPTaxExemptBef=0
  end if;
  /*
  To ESOP's No Tax Exempt
  */
  select Sum(NoTaxExempt) into Out_TotalESOPNoTaxExempt from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'ESOP';
  if(Out_TotalESOPNoTaxExempt is null) then set Out_TotalESOPNoTaxExempt=0
  end if;
  select Sum(NoTaxExempt) into Out_TotalESOPNoTaxExemptBef from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'ESOP' and GrantedBef = 1;
  if(Out_TotalESOPNoTaxExemptBef is null) then set Out_TotalESOPNoTaxExemptBef=0
  end if;
  /*
  To EESOP's No Tax Exempt
  */
  select Sum(NoTaxExempt) into Out_TotalEESOPNoTaxExempt from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'EESOP';
  if(Out_TotalEESOPNoTaxExempt is null) then set Out_TotalEESOPNoTaxExempt=0
  end if;
  select Sum(NoTaxExempt) into Out_TotalEESOPNoTaxExemptBef from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'EESOP' and GrantedBef = 1;
  if(Out_TotalEESOPNoTaxExemptBef is null) then set Out_TotalEESOPNoTaxExemptBef=0
  end if;
  /*
  To CSOP's No Tax Exempt
  */
  select Sum(NoTaxExempt) into Out_TotalCSOPNoTaxExempt from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'CSOP';
  if(Out_TotalCSOPNoTaxExempt is null) then set Out_TotalCSOPNoTaxExempt=0
  end if;
  select Sum(NoTaxExempt) into Out_TotalCSOPNoTaxExemptBef from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'CSOP' and GrantedBef = 1;
  if(Out_TotalCSOPNoTaxExemptBef is null) then set Out_TotalCSOPNoTaxExemptBef=0
  end if;
  /*
  To ESOP's Stock Gain
  */
  select Sum(StockGains) into Out_TotalESOPStockGains from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'ESOP';
  if(Out_TotalESOPStockGains is null) then set Out_TotalESOPStockGains=0
  end if;
  select Sum(StockGains) into Out_TotalESOPStockGainsBef from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'ESOP' and GrantedBef = 1;
  if(Out_TotalESOPStockGainsBef is null) then set Out_TotalESOPStockGainsBef=0
  end if;
  /*
  To EESOP's Stock Gain
  */
  select Sum(StockGains) into Out_TotalEESOPStockGains from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'EESOP';
  if(Out_TotalEESOPStockGains is null) then set Out_TotalEESOPStockGains=0
  end if;
  select Sum(StockGains) into Out_TotalEESOPStockGainsBef from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'EESOP' and GrantedBef = 1;
  if(Out_TotalEESOPStockGainsBef is null) then set Out_TotalEESOPStockGainsBef=0
  end if;
  /*
  To CSOP's Stock Gain
  */
  select Sum(StockGains) into Out_TotalCSOPStockGains from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'CSOP';
  if(Out_TotalCSOPStockGains is null) then set Out_TotalCSOPStockGains=0
  end if;
  select Sum(StockGains) into Out_TotalCSOPStockGainsBef from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'CSOP' and GrantedBef = 1;
  if(Out_TotalCSOPStockGainsBef is null) then set Out_TotalCSOPStockGainsBef=0
  end if;
  /*
  Compute Grand Total
  */
  update A8B set
    TotalEESOPTaxExempt = Out_TotalEESOPTaxExempt,
    TotalCSOPTaxExempt = Out_TotalCSOPTaxExempt,
    TotalESOPNoTaxExempt = Out_TotalESOPNoTaxExempt,
    TotalEESOPNoTaxExempt = Out_TotalEESOPNoTaxExempt,
    TotalCSOPNoTaxExempt = Out_TotalCSOPNoTaxExempt,
    TotalESOPStockGains = Out_TotalESOPStockGains,
    TotalEESOPStockGains = Out_TotalEESOPStockGains,
    TotalCSOPStockGains = Out_TotalCSOPStockGains,
    TotalEESOPTaxExemptBef = Out_TotalEESOPTaxExemptBef,
    TotalCSOPTaxExemptBef = Out_TotalCSOPTaxExemptBef,
    TotalESOPNoTaxExemptBef = Out_TotalESOPNoTaxExemptBef,
    TotalEESOPNoTaxExemptBef = Out_TotalEESOPNoTaxExemptBef,
    TotalCSOPNoTaxExemptBef = Out_TotalCSOPNoTaxExemptBef,
    TotalESOPStockGainsBef = Out_TotalESOPStockGainsBef,
    TotalEESOPStockGainsBef = Out_TotalEESOPStockGainsBef,
    TotalCSOPStockGainsBef = Out_TotalCSOPStockGainsBef where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  update A8B set
    GrandTotalStockGains = Out_TotalESOPStockGains+Out_TotalEESOPStockGains+Out_TotalCSOPStockGains where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  commit work
end
;

create procedure DBA.ASQLYEProcessIR8A(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_IR8AType char(20),
in In_Operation char(20),
in In_NSPay double,
in In_GrossTotal double,
in In_ContractualBonus double,
in In_NonContractualBonus double,
in In_DirectorFee double,
in In_Commission double,
in In_Pension double,
in In_Transport double,
in In_Entertainment double,
in In_Insurance double,
in In_OtherAllowance double,
in In_Gratuity double,
in In_EECPFPension double,
in In_EECPF smallint,
in In_Donation double,
in In_MOSQFund double,
in In_MBMF smallint,
in In_COMC smallint,
in In_SINDA smallint,
in In_CDAC smallint,
in In_ECF smallint,
in In_MOSQ smallint,
in In_YMF smallint,
in In_OtherDonation smallint,
in In_LumpSumGratuity double,
in In_LumpSumCompensation double,
in In_LumpSumNoticePay double,
in In_LumpSumExGratia double,
in In_LumpSumOthers double,
out Out_ProcessResult integer)
begin
  declare In_PaymentFrom date;
  declare In_PaymentTo date;
  declare StartBasis date;
  declare EndBasis date;
  declare In_AccruedFrom double;
  declare In_EROutsideContri double;
  declare In_ShareAmt double;
  declare In_TotalSectionD double;
  declare In_EEPensionDetails char(60);
  declare In_BenefitsInKind double;
  declare In_OtherAllowanceAmt double;
  set In_AccruedFrom=0;
  set In_EROutsideContri=0;
  set In_ShareAmt=0;
  set In_BenefitsInKind=0;
  set In_TotalSectionD=0;
  set In_EEPensionDetails='';
  set In_OtherAllowanceAmt=0;
  if((In_Operation = 'Recalculate' or In_Operation = 'Reprocess')) then
    select AccruedFrom,EROutsideContri,ShareAmt,EEPensionDetails,OtherAllowanceAmt into In_AccruedFrom,
      In_EROutsideContri,
      In_ShareAmt,In_EEPensionDetails,
      In_OtherAllowanceAmt from IR8A where PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and IR8AType = In_IR8AType
  end if;
  if exists(select* from YERecord where PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and YERecordType = 'A8A') and In_IR8AType = 'CurIR8A' then
    select TotalBenefitInKind into In_BenefitsInKind from A8A where PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear
  else
    set In_BenefitsInKind=0
  end if;
  if(In_GrossTotal = 0 and
    In_ContractualBonus = 0 and
    In_NonContractualBonus = 0 and
    In_DirectorFee = 0 and
    In_Commission = 0 and
    In_Pension = 0 and
    In_Transport = 0 and
    In_Entertainment = 0 and
    In_Insurance = 0 and
    In_OtherAllowance = 0 and
    In_OtherAllowanceAmt = 0 and
    In_Gratuity = 0 and
    In_EECPFPension = 0 and
    In_IR8AType = 'SupIR8A') then
    delete from YERecord where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      YERecordType = In_IR8AType;
    delete from IR8A where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      IR8AType = In_IR8AType;
    commit work;
    set Out_ProcessResult=0;
    return
  end if;
  if(In_IR8AType = 'CurIR8A') then
    set StartBasis="date"(str(In_YEYear)+'-01-01');
    set EndBasis="date"(str(In_YEYear)+'-12-31')
  else
    set StartBasis="date"(str(In_YEYear-1)+'-01-01');
    set EndBasis="date"(str(In_YEYear-1)+'-12-31')
  end if;
  select Commencement,Cessation into In_PaymentFrom,In_PaymentTo from YEEmployee where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  if(In_PaymentFrom < StartBasis or In_PaymentFrom is null) then
    set In_PaymentFrom=StartBasis
  end if;
  if(In_PaymentTo is null or In_PaymentTo = '1899-12-30') then
    set In_PaymentTo=EndBasis
  end if;
  if(In_EECPFPension <> 0 and(In_EEPensionDetails = '' or In_EEPensionDetails is null)) then
    set In_EEPensionDetails='Central Provident Fund';
    set In_EECPF=1
  end if;
  if(In_EECPFPension = 0) then
    set In_EEPensionDetails=''
  end if;
  set In_TotalSectionD
    =In_Commission+
    In_Pension+
    In_Transport+
    In_Entertainment+
    In_OtherAllowance+
    In_OtherAllowanceAmt+
    In_Gratuity+
    In_AccruedFrom+
    In_EROutsideContri+
    In_ShareAmt;
  if(In_Operation = 'Recalculate') then
    update IR8A set
      GrossTotal = In_GrossTotal,
      PaymentFrom = In_PaymentFrom,
      PaymentTo = In_PaymentTo,
      Gratuity = In_Gratuity,
      LumpSumGratuity = In_LumpSumGratuity,
      LumpSumCompensation = In_LumpSumCompensation,
      LumpSumNoticePay = In_LumpSumNoticePay,
      LumpSumExGratia = In_LumpSumExGratia,
      LumpSumOthers = In_LumpSumOthers,
      BenefitsInKind = In_BenefitsInKind,
      TotalSectionD = In_TotalSectionD where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      IR8AType = In_IR8AType;
    commit work
  end if;
  if(In_Operation = 'Reprocess') then
    update IR8A set
      EEPensionDetails = In_EEPensionDetails,
      NSPay = In_NSPay,
      GrossTotal = In_GrossTotal,
      ContratualBonus = In_ContractualBonus,
      NonContratualBonus = In_NonContractualBonus,
      DirectorFee = In_DirectorFee,
      Commission = In_Commission,
      Pension = In_Pension,
      Transport = In_Transport,
      Entertainment = In_Entertainment,
      OtherAllowance = In_OtherAllowance,
      Gratuity = In_Gratuity,
      EECPFPension = In_EECPFPension,
      EECPF = In_EECPF,
      Donation = In_Donation,
      MOSQFund = In_MOSQFund,
      MBMF = In_MBMF,
      COMC = In_COMC,
      SINDA = In_SINDA,
      CDAC = In_CDAC,
      ECF = In_ECF,
      MOSQ = In_MOSQ,
      YMF = In_YMF,
      OtherDonation = In_OtherDonation,
      Insurance = In_Insurance,
      PaymentFrom = In_PaymentFrom,
      PaymentTo = In_PaymentTo,
      BenefitsInKind = In_BenefitsInKind,
      TotalSectionD = In_TotalSectionD,
      LumpSumGratuity = In_LumpSumGratuity,
      LumpSumCompensation = In_LumpSumCompensation,
      LumpSumNoticePay = In_LumpSumNoticePay,
      LumpSumExGratia = In_LumpSumExGratia,
      LumpSumOthers = In_LumpSumOthers,
      LastChangedDateTime = now(*) where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      IR8AType = In_IR8AType;
    commit work
  end if;
  if(In_Operation = 'Create') then
    call InsertNewIR8A(
    In_PersonalSysID,
    In_YEYear,
    In_IR8AType,'',
    In_NSPay,
    In_GrossTotal,
    In_ContractualBonus,
    In_DirectorFee,
    In_Commission,
    In_Pension,
    In_Transport,
    In_Entertainment,
    In_OtherAllowance,
    In_Gratuity,'','',
    0,
    0,
    0,'',
    0,
    0,'',
    In_BenefitsInKind,
    0,'','',
    In_EECPFPension,
    In_EECPF,
    0,
    In_EEPensionDetails,
    0,
    In_Donation,
    In_MOSQFund,
    In_MBMF,
    In_COMC,
    In_SINDA,
    In_CDAC,
    In_ECF,
    In_MOSQ,
    In_YMF,
    In_OtherDonation,'',
    In_Insurance,
    In_PaymentFrom,
    In_PaymentTo,
    0,
    In_NonContractualBonus,
    In_TotalSectionD,'',
    0,
    In_LumpSumGratuity,
    In_LumpSumCompensation,
    In_LumpSumNoticePay,
    In_LumpSumExGratia,
    In_LumpSumOthers,'','',
    0, //CPFBorneByER 
    0, //TaxBorneByER
    0,'1899-12-30','IncomeTypeNA', //FixedAmtBorneByEE
    //CompensationApprovedDate
    //ExemptIncomeType
    0, //ExemptIncomeAmt  
    0, //In_OtherAllowanceAmt
    0); //In_TotalStockGainsBef
    update IR8A set
      LengthOfService = 0 where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      IR8AType = In_IR8AType;
    commit work
  end if;
  set Out_ProcessResult=In_TotalSectionD
end
;

create procedure DBA.ASQLYEProcessIR8S(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_Operation char(20),
in In_PreviousBonus double,
in In_OverseasPostFrom date,
in In_OverseasPostTo date,
in In_CPFOverseasObligatory char(1),
in In_CPFCapping smallint,
in In_EEVolCPF double,
in In_ERVolCPF double,
in In_VolCPFObligatory char(1),
in In_EROverseasCPF double,
in In_EEOverseasCPF double)
begin
  /*
  Create Operation
  */
  declare Out_DateofPRGranted date;
  select first ResStatusEffectiveDate into Out_DateofPRGranted from ResidenceStatusRecord where
    PersonalSysId = In_PersonalsysId and
    ResidenceTypeId = 'PR1' and Year(ResStatusEffectiveDate) >= In_YEYear-2 order by
    ResStatusEffectiveDate desc;
  if In_Operation = 'Create' then
    call InsertNewIR8S(
    In_PersonalsysId,
    In_YEYear,'',
    In_OverseasPostFrom,
    In_OverseasPostTo,
    In_EEOverseasCPF,
    In_EROverseasCPF,
    In_CPFOverseasObligatory,
    In_CPFCapping,
    In_EEVolCPF,
    In_ERVolCPF,
    In_VolCPFObligatory,
    In_PreviousBonus,'','',Out_DateofPRGranted,'1899-12-30',' ','B');
    /*SectionCRemarks*/
    /*DateofPRGranted*/
    /*DateofPRRenounce*/
    /*ApprovalForFullCPF*/
    /*CPFWageType*/
    call InsertNewIR8SC(In_PersonalsysId,
    In_YEYear,0,'1899-12-30','1899-12-30','1899-12-30',
    0,0,'1899-12-30',
    0,0,'1899-12-30','')
  end if;
  /*
  Reprocess Operation
  */
  if In_Operation = 'Reprocess' then
    update IR8S set
      IR8S.DateofPRGranted = Out_DateofPRGranted where
      IR8S.PersonalSysId = In_PersonalsysId and
      IR8S.YEYear = In_YEYear;
    commit work
  end if;
  /*
  Recalculate and Reprocess Operation
  */
  if In_Operation = 'Recalculate' or In_Operation = 'Reprocess' then
    update IR8S set
      IR8S.OverseasPostFrom = In_OverseasPostFrom,
      IR8S.OverseasPostTo = In_OverseasPostTo,
      IR8S.EEOverseasCPF = In_EEOverseasCPF,
      IR8S.EROverseasCPF = In_EROverseasCPF,
      IR8S.CPFOverseasObligatory = In_CPFOverseasObligatory,
      IR8S.CPFCapping = In_CPFCapping,
      IR8S.EEVolCPF = In_EEVolCPF,
      IR8S.ERVolCPF = In_ERVolCPF,
      IR8S.VolCPFObligatory = In_VolCPFObligatory,
      IR8S.PreviousBonus = In_PreviousBonus,
      IR8S.LastChangedDateTime = now(*) where
      IR8S.PersonalSysId = In_PersonalsysId and
      IR8S.YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure DBA.ASQLYEProcessIR8SA(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_Operation char(20),
in In_IR8SOrder integer,
in In_OrdWages double,
in In_ContriOrdEECPF double,
in In_ContriOrdERCPF double,
in In_ActualOrdEECPF double,
in In_ActualOrdERCPF double,
in In_AddWages double,
in In_ContriAddEECPF double,
in In_ContriAddERCPF double,
in In_ActualAddEECPF double,
in In_ActualAddERCPF double,
in In_CurOrdinaryWage double,
in In_CurAdditionalWage double,
in In_PrevOrdinaryWage double,
in In_PrevAdditionalWage double,
in In_OverseasEECPF double,
in In_OverseasERCPF double,
in In_CPFClass char(20),
in In_CPFPeriodCapping double,
in In_CPFLessThanCapping double,
in In_CPFGreaterThanCapping double,
in In_CappedOrdWage double)
begin
  declare Out_IR8SSysId integer;
  declare In_IR8SColDesc char(20);
  case In_IR8SOrder
  when 1 then
    set In_IR8SColDesc='JAN'
  when 2 then
    set In_IR8SColDesc='FEB'
  when 3 then
    set In_IR8SColDesc='MAR'
  when 4 then
    set In_IR8SColDesc='APR'
  when 5 then
    set In_IR8SColDesc='MAY'
  when 6 then
    set In_IR8SColDesc='JUN'
  when 7 then
    set In_IR8SColDesc='JUL'
  when 8 then
    set In_IR8SColDesc='AUG'
  when 9 then
    set In_IR8SColDesc='SEP'
  when 10 then
    set In_IR8SColDesc='OCT'
  when 11 then
    set In_IR8SColDesc='NOV'
  when 12 then
    set In_IR8SColDesc='DEC'
  else
    set In_IR8SColDesc='TOTAL'
  end case
  ;
  if In_Operation = 'Create' then
    call InsertNewIR8SA(In_PersonalSysId,
    In_YEYear,
    In_IR8SOrder,
    In_OrdWages,
    In_ContriOrdEECPF,
    In_ContriOrdERCPF,
    In_ActualOrdEECPF,
    In_ActualOrdERCPF,
    In_AddWages,
    In_ContriAddEECPF,
    In_ContriAddERCPF,
    In_ActualAddEECPF,
    In_ActualAddERCPF,
    In_IR8SColDesc,
    In_CurOrdinaryWage,
    In_PrevOrdinaryWage,
    In_CurAdditionalWage,
    In_PrevAdditionalWage,
    In_OverseasEECPF,
    In_OverseasERCPF,
    In_CPFClass,
    In_CPFPeriodCapping,
    In_CPFLessThanCapping,
    In_CPFGreaterThanCapping,
    In_CappedOrdWage,
    Out_IR8SSysId)
  end if;
  if In_Operation = 'Recalculate' or In_Operation = 'Reprocess' then
    call UpdateIR8SA(In_PersonalSysId,
    In_YEYear,
    In_IR8SOrder,
    In_OrdWages,
    In_ContriOrdEECPF,
    In_ContriOrdERCPF,
    In_ActualOrdEECPF,
    In_ActualOrdERCPF,
    In_AddWages,
    In_ContriAddEECPF,
    In_ContriAddERCPF,
    In_ActualAddEECPF,
    In_ActualAddERCPF,
    In_IR8SColDesc,
    In_CurOrdinaryWage,
    In_PrevOrdinaryWage,
    In_CurAdditionalWage,
    In_PrevAdditionalWage,
    In_OverseasEECPF,
    In_OverseasERCPF,
    In_CPFClass,
    In_CPFPeriodCapping,
    In_CPFLessThanCapping,
    In_CPFGreaterThanCapping,
    In_CappedOrdWage)
  end if
end
;

create procedure DBA.ASQLYEProcessYEEmployee(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_CurrentYEGlobalId char(20),
in In_SupYEGlobalId char(20),
in In_YEEmployerId char(20),
in In_Operation char(20),
in In_ProcessIR21 char(1))
begin
  declare In_TaxNo char(20);
  declare In_DOB date;
  declare In_PersonalName char(150);
  declare In_EEName1 char(35);
  declare In_EEName2 char(35);
  declare In_EEName3 char(10);
  declare In_EEAddress1 char(30);
  declare In_EEAddress2 char(30);
  declare In_EEAddress3 char(30);
  declare In_EEAddress4 char(30);
  declare In_EEAddressCountry char(20);
  declare In_PostalCode char(6);
  declare In_IdentityTypeId char(20);
  declare In_PayeeIDType char(1);
  declare In_GenderCodeId char(1);
  declare In_Gender char(1);
  declare In_MaritalStatusCode char(20);
  declare In_MaritalStatusDesc char(60);
  declare In_IRASNationalityCode char(20);
  declare In_Nationality char(20);
  declare In_CommencementDate date;
  declare In_CessationDate date;
  declare In_Designation char(20);
  declare In_EmployeeSysId integer;
  declare In_CessationProvision char(1);
  declare In_AddressType char(20);
  /*
  Recalculate Operation
  */
  if(In_Operation = 'Recalculate') then
    select Commencement,Cessation into In_CommencementDate,In_CessationDate from YEEmployee where
      PersonalSysID = In_PersonalSysID and
      YEYear = In_YEYear;
    /*
    Cessation Provision
    */
    if(In_CommencementDate < '1969-1-1' and Year(In_CessationDate) = In_YEYear) then
      set In_CessationProvision='Y'
    else
      set In_CessationProvision='N'
    end if;
    update YEEmployee set
      CessationProvision = In_CessationProvision where
      PersonalSysID = In_PersonalSysID and
      YEYear = In_YEYear;
    commit work;
    return
  end if;
  /*
  For Create and Reprocess Operation  
  Get the latest Employment
  */
  select Max(HireDate) into In_CommencementDate from Employee where PersonalSysId = In_PersonalSysId;
  if In_CommencementDate is null then return // not employed yet
  end if;
  select EmployeeSysId into In_EmployeeSysId from Employee where PersonalSysId = In_PersonalSysId and HireDate = In_CommencementDate;
  select PositionDesc,CessationDate into In_Designation,In_CessationDate from Employee join PositionCode where EmployeeSysId = In_EmployeeSysId;
  if In_CessationDate is null then set In_CessationDate='1899-12-30'
  end if;
  /*
  Cessation Provision
  */
  if(In_CommencementDate < '1969-1-1' and Year(In_CessationDate) = In_YEYear) then
    set In_CessationProvision='Y'
  else
    set In_CessationProvision='N'
  end if;
  /*
  Check if Hire date not in Current Year then blank
  Check if Cessation date not in Current Year then blank
  */
  if(Year(In_CommencementDate) <> In_YEYear and In_CessationProvision = 'N') then set In_CommencementDate='1899-12-30'
  end if;
  if(Year(In_CessationDate) <> In_YEYear) then set In_CessationDate='1899-12-30'
  end if;
  /*
  Get information from Personal
  */
  select Nationality,
    MaritalStatusCode,
    Gender,
    Trim(IdentityNo),
    IdentityTypeId,
    DateOfBirth,
    PersonalName into In_Nationality,
    In_MaritalStatusCode,
    In_GenderCodeId,
    In_TaxNo,
    In_IdentityTypeId,
    In_DOB,
    In_PersonalName from Personal where PersonalSysId = In_PersonalSysId;
  /*
  Map Nationality
  */
  select IRASNationalityCode into In_IRASNationalityCode from IRASNationality where EPECountryId = In_Nationality;
  /*
  Get Marital Status
  */
  select MaritalStatusDesc into In_MaritalStatusDesc from MaritalStatus where MaritalStatusCode = In_MaritalStatusCode;
  /*
  Decode Payee Type
  */
  if In_IdentityTypeId = 'SNRIC(PINK)' or In_IdentityTypeId = 'SNRIC(BLUE)' then
    set In_PayeeIDType='1' // NRIC
  elseif In_IdentityTypeId = 'FIN(EP)' then
    set In_PayeeIDType='2' // FIN
  elseif In_IdentityTypeId = 'FIN' then
    set In_PayeeIDType='2' // FIN   
  elseif In_IdentityTypeId = 'Passport' then
    set In_PayeeIDType='6' // Passport 
  /*
  Immigration File Ref No.
  */
  elseif In_IdentityTypeId = 'Other' and
  Length(In_TaxNo) = 8 and
  SubString(In_TaxNo,1,1) between '0' and '9' and
  SubString(In_TaxNo,2,1) between '0' and '9' and
  SubString(In_TaxNo,3,1) between '0' and '9' and
  SubString(In_TaxNo,4,1) between '0' and '9' and
  SubString(In_TaxNo,5,1) between '0' and '9' and
  SubString(In_TaxNo,6,1) between '0' and '9' and
  SubString(In_TaxNo,7,1) between '0' and '9' and
  Upper(SubString(In_TaxNo,8,1)) between 'A' and 'Z' then
    set In_PayeeIDType='3'
  /*
  Malaysia IC 12 numeric Format
  */
  elseif In_IdentityTypeId = 'Other' and
  Length(In_TaxNo) = 12 and
  SubString(In_TaxNo,1,1) between '0' and '9' and
  SubString(In_TaxNo,2,1) between '0' and '9' and
  SubString(In_TaxNo,3,1) between '0' and '9' and
  SubString(In_TaxNo,4,1) between '0' and '9' and
  SubString(In_TaxNo,5,1) between '0' and '9' and
  SubString(In_TaxNo,6,1) between '0' and '9' and
  SubString(In_TaxNo,7,1) between '0' and '9' and
  SubString(In_TaxNo,8,1) between '0' and '9' and
  SubString(In_TaxNo,9,1) between '0' and '9' and
  SubString(In_TaxNo,10,1) between '0' and '9' and
  SubString(In_TaxNo,11,1) between '0' and '9' and
  SubString(In_TaxNo,12,1) between '0' and '9' then
    set In_PayeeIDType='5'
  /*
  Malaysia IC 7 to 8 alphaNumeric Format
  */
  elseif In_IdentityTypeId = 'Other' and
  Length(In_TaxNo) between 7 and 8 then
    set In_PayeeIDType='5'
  else
    set In_PayeeIDType='0'
  end if;
  /*
  Decode Gender
  */
  if In_GenderCodeId = '1' then set In_Gender='M'
  else set In_Gender='F'
  end if;
  /*
  Break Name
  */
  select SubString(In_PersonalName,1,35) into In_EEName1;
  select SubString(In_PersonalName,36,35) into In_EEName2;
  select SubString(In_PersonalName,71,10) into In_EEName3;
  /*
  Get Address Type
  */
  select CustString1 into In_AddressType from PersonalAddress where PersonalSysId = In_PersonalSysId and
    PersonalAddMailing = 1;
  if(In_AddressType = '' or In_AddressType is null) then set In_AddressType='N'
  end if; /*
  Get Formatted Address
  */
  if(In_AddressType = 'L') then
    select CustString2,CustString3,CustString4,CustString5,PersonalAddPCode,PersonalAddCountry into In_EEAddress1,
      In_EEAddress2,In_EEAddress3,In_EEAddress4,In_PostalCode,In_EEAddressCountry from PersonalAddress where
      PersonalSysId = In_PersonalSysId and PersonalAddMailing = 1
  else
    /*
    Get UnFormatted Address
    */
    select PersonalAddAddress,PersonalAddAddress2,PersonalAddAddress3,PersonalAddPCode,PersonalAddCountry into In_EEAddress1,
      In_EEAddress2,In_EEAddress3,In_PostalCode,In_EEAddressCountry from PersonalAddress where
      PersonalSysId = In_PersonalSysId and PersonalAddMailing = 1;
    set In_EEAddress4=''
  end if;
  /*
  Convert Country Code to IRAS Code
  */
  select IRASNationalityCode into In_EEAddressCountry from IRASNationality where EPECountryId = In_EEAddressCountry;
  if(In_EEAddressCountry = '') then set In_EEAddressCountry='999'
  end if; /*
  Create new YEEmployee
  */
  if(In_Operation = 'Create') then
    call InsertNewYEEmployee(
    In_PersonalSysID,
    In_YEYear,
    In_CurrentYEGlobalId,
    In_YEEmployerId,
    In_TaxNo,
    In_Designation,
    In_EEAddress1,
    In_EEAddress2,
    In_EEAddress3,
    In_EEAddress4,
    In_PostalCode,
    In_AddressType,
    In_EEAddressCountry,
    In_EEName1,
    In_EEName2,
    In_EEName3,
    In_DOB,
    In_CommencementDate,
    In_CessationDate,'N','N','N','N','N','N','N',
    /* In_IRASSection45 */
    /* In_IR8SIndicator */
    /* In_A8AIndicator */
    /* In_Flag100K */
    /* In_FlagPercentOrdWage */
    /* In_FlagOverseasCPF */
    /* In_FlagExcessCPF */
    In_IRASNationalityCode,
    In_PayeeIDType,
    In_CessationProvision,
    In_Gender,
    In_MaritalStatusDesc,
    In_SupYEGlobalId,In_ProcessIR21)
  else
    /* Only Reprocess */
    update YEEmployee set
      TaxNo = In_TaxNo,
      Designation = In_Designation,
      EEAddress1 = In_EEAddress1,
      EEAddress2 = In_EEAddress2,
      EEAddress3 = In_EEAddress3,
      EEAddress4 = In_EEAddress4,
      PostalCode = In_PostalCode,
      EEAddressType = In_AddressType,
      EEAddressCountry = In_EEAddressCountry,
      EEName1 = In_EEName1,
      EEName2 = In_EEName2,
      EEName3 = In_EEName3,
      DOB = In_DOB,
      Commencement = In_CommencementDate,
      Cessation = In_CessationDate,
      IRASNationalityCode = In_IRASNationalityCode,
      PayeeIDType = In_PayeeIDType,
      CessationProvision = In_CessationProvision,
      Gender = In_Gender,
      MaritalStatusDesc = In_MaritalStatusDesc,
      LastChangedDateTime = now(*) where
      PersonalSysID = In_PersonalSysID and
      YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure DBA.ASQLYEProcessYERecord(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_YERecordType char(20),
in In_Operation char(20))
begin
  if(In_Operation = 'Create') then
    insert into YERecord(PersonalSysId,
      YEYear,
      YERecordType,
      Status,
      LastProcessed) values(
      In_PersonalSysId,
      In_YEYear,
      In_YERecordType,'Active',
      now(*))
  else
    update YERecord set
      LastProcessed = now(*) where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      YERecordType = In_YERecordType
  end if
end
;

create procedure DBA.ASQLYEUpdateIR8A(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_Operation char(20))
begin
  declare In_GrossTotal double;
  declare In_ContractualBonus double;
  declare In_NonContractualBonus double;
  declare In_DirectorFee double;
  declare In_Commission double;
  declare In_Pension double;
  declare In_Transport double;
  declare In_Entertainment double;
  declare In_OtherAllowance double;
  declare In_OtherAllowanceAmt double;
  declare In_Gratuity double;
  declare In_AccruedFrom double;
  declare In_EROutsideContri double;
  declare In_ERExcessContri double;
  declare In_ShareAmt double;
  declare In_BenefitsInKind double;declare In_EEOverseasCPF double;
  declare In_EEVoluntaryCPF double;
  declare In_EECPFPension double;
  declare In_ContriOrdEECPF double;
  declare In_ContriAddEECPF double;
  declare In_EESupCPFPension double;
  declare In_TotalSectionD double;
  declare In_EEPensionDetails char(60);
  declare In_EEContribution double;
  declare In_EECPF smallint;
  declare In_CPFOverseasObligatory char(1);
  declare In_VolCPFObligatory char(1);
  declare In_IR8ABenefitsInKind double;
  declare In_CPFTaxableStatus smallint;
  declare In_EmployeeSysId integer;
  declare In_EECPFPaidByER smallint;
  declare In_CPFBorneByER double;
  declare In_ActualOrdEECPF double;
  declare In_ActualAddEECPF double;
  declare In_TotalStockGainsBef double;
  declare In_OldValue double;
  declare In_OldValue1 double;
  declare In_OldValue2 double;
  declare In_OldString char(100);
  declare In_CntBefore double;
  declare In_CntAfter double;
  /*
  Update Benefits In Kind Amount From A8A
  */
  if exists(select* from YERecord where PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and YERecordType = 'A8A') then
    select TotalBenefitInKind into In_BenefitsInKind from A8A where PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear;
    /*
    Check change of value before update
    */
    select BenefitsInKind into In_OldValue from IR8A where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and IR8AType = 'CurIR8A';
    if In_OldValue <> In_BenefitsInKind then
      update IR8A set
        BenefitsInKind = In_BenefitsInKind,
        LastChangedDateTime = now(*) where
        PersonalSysId = In_PersonalSysId and
        YEYear = In_YEYear and IR8AType = 'CurIR8A';
      commit work
    end if
  end if;
  /*
  Update Share Amount From A8B
  */
  if exists(select* from YERecord where PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and YERecordType = 'A8B') then
    select GrandTotalStockGains+OtherShareAmt,
      TotalESOPStockGainsBef+TotalEESOPStockGainsBef+TotalCSOPStockGainsBef into In_ShareAmt,
      In_TotalStockGainsBef from A8B where PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear;
    /*
    Check change of value before update
    */
    select ShareAmt,TotalStockGainsBef into In_OldValue,In_OldValue1 from IR8A where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and IR8AType = 'CurIR8A';
    if In_OldValue <> In_ShareAmt or In_OldValue1 <> In_TotalStockGainsBef then
      update IR8A set
        ShareAmt = In_ShareAmt,
        TotalStockGainsBef = In_TotalStockGainsBef,
        LastChangedDateTime = now(*) where
        PersonalSysId = In_PersonalSysId and
        YEYear = In_YEYear and IR8AType = 'CurIR8A';
      commit work
    end if
  end if;
  /*
  Update Share Amount From Appendix 2
  */
  if exists(select* from YERecord where PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and YERecordType = 'IR21A2') then
    select GrandTotalStockGains+OtherShareAmt into In_ShareAmt from IR21A2 where PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear;
    /*
    Check change of value before update
    */
    select ShareAmt into In_OldValue from IR8A where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and IR8AType = 'CurIR8A';
    if In_OldValue <> In_ShareAmt then
      update IR8A set
        ShareAmt = In_ShareAmt,
        LastChangedDateTime = now(*) where
        PersonalSysId = In_PersonalSysId and
        YEYear = In_YEYear and IR8AType = 'CurIR8A';
      commit work
    end if
  end if;
  /*
  Update IR21 From Appendix 3
  */
  if exists(select* from YERecord where PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and YERecordType = 'IR21A3') then
    select Count(*) into In_CntBefore from IR21A3Record where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      Year(DateStockGranted) < 2003;
    select Count(*) into In_CntAfter from IR21A3Record where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      Year(DateStockGranted) >= 2003;
    if(In_CntBefore > 0) then set In_CntBefore=1
    end if;
    if(In_CntAfter > 0) then set In_CntAfter=1
    end if;
    update IR21Details set
      UnexercisedGainsBef = In_CntBefore,
      UnexercisedGainsAft = In_CntAfter where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear;
    commit work
  end if;
  /*
  Compute Section D Total
  */
  select GrossTotal,
    ContratualBonus,
    NonContratualBonus,
    DirectorFee,
    Commission,
    Pension,
    Transport,
    Entertainment,
    OtherAllowance,
    OtherAllowanceAmt,
    Gratuity,
    AccruedFrom,
    EROutsideContri,
    ERExcessContri,
    ShareAmt,
    BenefitsInKind,
    IR8ABenefitsInKind,
    TotalSectionD into In_GrossTotal,
    In_ContractualBonus,
    In_NonContractualBonus,
    In_DirectorFee,
    In_Commission,
    In_Pension,
    In_Transport,
    In_Entertainment,
    In_OtherAllowance,
    In_OtherAllowanceAmt,
    In_Gratuity,
    In_AccruedFrom,
    In_EROutsideContri,
    In_ERExcessContri,
    In_ShareAmt,
    In_BenefitsInKind,
    In_IR8ABenefitsInKind,
    In_OldValue from IR8A where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and
    IR8AType = 'CurIR8A';
  set In_TotalSectionD
    =In_Commission+
    In_Pension+
    In_Transport+
    In_Entertainment+
    In_OtherAllowance+
    In_OtherAllowanceAmt+
    In_Gratuity+
    In_AccruedFrom+
    In_EROutsideContri+
    In_ERExcessContri+
    In_ShareAmt+
    In_BenefitsInKind+In_IR8ABenefitsInKind;
  if In_OldValue <> In_TotalSectionD then
    update IR8A set
      TotalSectionD = In_TotalSectionD,
      LastChangedDateTime = now(*) where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      IR8AType = 'CurIR8A';
    commit work
  end if;
  /*
  Get Overseas CPF and Settings from IR8S
  */
  select EEOverseasCPF,CPFOverseasObligatory,EEVolCPF,VolCPFObligatory into In_EEOverseasCPF,
    In_CPFOverseasObligatory,In_EEVoluntaryCPF,In_VolCPFObligatory from IR8S where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  /*
  Get Total CPF from IR8S Section A
  */
  select ContriOrdEECPF,
    ContriAddEECPF,
    ActualOrdEECPF,
    ActualAddEECPF into In_ContriOrdEECPF,
    In_ContriAddEECPF,
    In_ActualOrdEECPF,
    In_ActualAddEECPF from IR8SA where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and
    IR8SOrder = 13;
  /*
  Check Current Employment has Employee CPF Paid By Employer  
  */
  select first YEEmployeeSysId into In_EmployeeSysId from EmploymentHistory where
    YEYear = In_YEYear and
    PersonalSysId = In_PersonalSysId order by
    ToDate desc;
  select EECPFPaidByER into In_EECPFPaidByER from PayEmployee where EmployeeSysId = In_EmployeeSysId;
  /*
  Applicable to "Casual Only"
  */
  if(In_EECPFPaidByER = 1) then
    /*
    Get Global Setup's Employee CPF Taxable Option  
    */
    select CPFTaxableStatus into In_CPFTaxableStatus from YEGlobal where YEGlobalId = 
      any(select CurrentYEGlobalId from YEEmployee where
        PersonalSysId = In_PersonalSysId and
        YEYear = In_YEYear);
    /*
    Compute IR8A Employee CPF (DOES NOT SUPPORT OVERSEAS and SUPPLEMENTARY)
    */
    if(In_CPFTaxableStatus = 1) then
      set In_EECPFPension=In_ContriOrdEECPF+In_ContriAddEECPF;
      set In_CPFBorneByER=In_ActualOrdEECPF+In_ActualAddEECPF-In_ContriOrdEECPF-In_ContriAddEECPF
    else
      set In_EECPFPension=In_ContriOrdEECPF+In_ContriAddEECPF;
      set In_CPFBorneByER=0
    end if
  else
    set In_CPFBorneByER=0;
    /*
    Get Supplementary CPF from Supplementary IR8A
    */
    select EECPFPension into In_EESupCPFPension
      from IR8A where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      IR8AType = 'SupIR8A';
    if In_EESupCPFPension is null then set In_EESupCPFPension=0
    end if;
    /*
    Compute IR8A Employee CPF
    */
    set In_EECPFPension=In_ContriOrdEECPF+
      In_ContriAddEECPF-
      In_EESupCPFPension;
    if(In_CPFOverseasObligatory = 'Y' or In_CPFOverseasObligatory = 'N') then
      set In_EECPFPension=In_EECPFPension-
        In_EEOverseasCPF
    end if;
    if(In_VolCPFObligatory = 'Y' or In_VolCPFObligatory = 'N') then
      set In_EECPFPension=In_EECPFPension-
        In_EEVoluntaryCPF
    end if
  end if;
  /*
  Get Employee Compulsory Option and Description from IR8A
  */
  select EEPensionDetails,EECPF into In_EEPensionDetails,
    In_EECPF from IR8A where PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR8AType = 'CurIR8A';
  if(In_EECPFPension <> 0 and In_EEPensionDetails = '') then
    set In_EEPensionDetails='Central Provident Fund';
    set In_EECPF=1
  end if;
  /*
  Check change of value before update
  */
  select CPFBorneByER,
    EECPFPension,
    EEPensionDetails,
    EECPF into In_OldValue,
    In_OldValue1,
    In_OldString,
    In_OldValue2 from IR8A where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and
    IR8AType = 'CurIR8A';
  if
    In_OldValue <> In_CPFBorneByER or
    In_OldValue1 <> In_EECPFPension or
    In_OldString <> In_EEPensionDetails or
    In_OldValue2 <> In_EECPF then
    update IR8A set
      CPFBorneByER = In_CPFBorneByER,
      TotalSectionD = In_TotalSectionD,
      EECPFPension = In_EECPFPension,
      EEPensionDetails = In_EEPensionDetails,
      EECPF = In_EECPF,
      LastChangedDateTime = now(*) where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      IR8AType = 'CurIR8A';
    commit work
  end if
end
;

create procedure dba.DeleteA8A(
in In_PersonalSysId integer,
in In_YEYear integer)
begin
  if exists(select* from A8A where
      A8A.PersonalSysId = In_PersonalSysId and
      A8A.YEYear = In_YEYear) then
    delete from A8AS2 where
      A8AS2.PersonalSysId = In_PersonalSysId and
      A8AS2.YEYear = In_YEYear;
    delete from A8AS3 where
      A8AS3.PersonalSysId = In_PersonalSysId and
      A8AS3.YEYear = In_YEYear;
    delete from A8A where
      A8A.PersonalSysId = In_PersonalSysId and
      A8A.YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.DeleteA8AByPersonalSysId(
in In_PersonalSysId integer)
begin
  if exists(select* from A8A where
      A8A.PersonalSysId = In_PersonalSysId) then
    delete from A8AS2 where
      A8AS2.PersonalSysId = In_PersonalSysId;
    delete from A8AS3 where
      A8AS3.PersonalSysId = In_PersonalSysId;
    delete from A8A where
      A8A.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.DeleteA8AS2(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_Sec2ItemsNo char(3))
begin
  if exists(select* from A8AS2 where
      A8AS2.PersonalSysId = In_PersonalSysId and
      A8AS2.YEYear = In_YEYear and
      A8AS2.Sec2ItemsNo = In_Sec2ItemsNo) then
    delete from A8AS2 where
      A8AS2.PersonalSysId = In_PersonalSysId and
      A8AS2.YEYear = In_YEYear and
      A8AS2.Sec2ItemsNo = In_Sec2ItemsNo;
    commit work
  end if
end
;

create procedure dba.DeleteA8AS3(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_Sec3No char(3))
begin
  if exists(select* from A8AS3 where
      IR8SA.PersonalSysId = In_PersonalSysId and
      IR8SA.YEYear = In_YEYear and
      IR8SA.Sec3No = In_Sec3No) then
    delete from A8AS3 where
      IR8SA.PersonalSysId = In_PersonalSysId and
      IR8SA.YEYear = In_YEYear and
      IR8SA.Sec3No = In_Sec3No;
    commit work
  end if
end
;

create procedure dba.DeleteA8B(
in In_PersonalSysId integer,
in In_YEYear integer)
begin
  if exists(select* from A8B where
      A8B.PersonalSysId = In_PersonalSysId and
      A8B.YEYear = In_YEYear) then
    delete from A8BRecord where
      A8BRecord.PersonalSysId = In_PersonalSysId and
      A8BRecord.YEYear = In_YEYear;
    delete from A8B where
      A8B.PersonalSysId = In_PersonalSysId and
      A8B.YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.DeleteA8BByPersonalSysId(
in In_PersonalSysId integer)
begin
  if exists(select* from A8B where
      A8B.PersonalSysId = In_PersonalSysId) then
    delete from A8BRecord where
      A8BRecord.PersonalSysId = In_PersonalSysId;
    delete from A8B where
      A8B.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.DeleteA8BRecord(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_StockOptionType char(20))
begin
  if exists(select* from A8BRecord where
      A8BRecord.PersonalSysId = In_PersonalSysId and
      A8BRecord.YEYear = In_YEYear and
      A8BRecord.StockOptionType = In_StockOptionType) then
    delete from A8BRecord where
      A8BRecord.PersonalSysId = In_PersonalSysId and
      A8BRecord.YEYear = In_YEYear and
      A8BRecord.StockOptionType = In_StockOptionType;
    commit work
  end if
end
;

create procedure dba.DeleteEmploymentHistory(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_YEEmployeeSysId integer)
begin
  if exists(select* from EmploymentHistory where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      YEEmployeeSysId = In_YEEmployeeSysId) then
    delete from EmploymentHistory where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      YEEmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

create procedure dba.DeleteEmploymentHistorybyPerId(
in In_PersonalSysId integer,
in In_YEYear integer)
begin
  if exists(select* from EmploymentHistory where
      PersonalSysId = In_PersonalsysId and
      YEYear = In_YEYear) then
    delete from EmploymentHistory where
      PersonalSysId = In_PersonalsysId and
      YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.DeleteEmploymentHistoryByPersonalSysID(
in In_PersonalSysId integer)
begin
  if exists(select* from EmploymentHistory where
      PersonalSysId = In_PersonalSysId) then
    delete from EmploymentHistory where
      PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.DeleteEmploymentHistoryByYEYear(
in In_PersonalSysId integer,
in In_YEYear integer)
begin
  if exists(select* from EmploymentHistory where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear) then
    delete from EmploymentHistory where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.DeleteIR8A(
in In_PersonalSysID integer,
in In_YEYear integer,in In_IR8AType char(20))
begin
  if exists(select* from IR8A where
      IR8A.PersonalSysID = In_PersonalSysID and
      IR8A.YEYear = In_YEYear and
      IR8A.IR8AType = In_IR8AType) then
    delete from IR8A where
      IR8A.PersonalSysID = In_PersonalSysID and
      IR8A.YEYear = In_YEYear and
      IR8A.IR8AType = In_IR8AType;
    commit work
  end if
end
;

create procedure dba.DeleteIR8AByPersonalSysID(
in In_PersonalSysID integer)
begin
  if exists(select* from IR8A where
      IR8A.PersonalSysID = In_PersonalSysID) then
    delete from IR8A where
      IR8A.PersonalSysID = In_PersonalSysID;
    commit work
  end if
end
;

create procedure dba.DeleteIR8AByYEYear(
in In_PersonalSysID integer,
in In_YEYear integer)
begin
  if exists(select* from IR8A where
      IR8A.PersonalSysID = In_PersonalSysID and
      IR8A.YEYear = In_YEYear) then
    delete from IR8A where
      IR8A.PersonalSysID = In_PersonalSysID and
      IR8A.YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.DeleteIR8S(
in In_PersonalSysId integer,
in In_Year integer)
begin
  if exists(select* from IR8S where
      IR8S.PersonalSysId = In_PersonalSysId and
      IR8S.YEYear = In_Year) then
    delete from IR8SA where
      IR8SA.PersonalSysId = In_PersonalSysId and
      IR8SA.YEYear = In_Year;
    delete from IR8SC where
      IR8SC.PersonalSysId = In_PersonalSysId and
      IR8SC.YEYear = In_Year;
    delete from IR8S where
      IR8S.PersonalSysId = In_PersonalSysId and
      IR8S.YEYear = In_Year;
    commit work
  end if
end
;

create procedure dba.DeleteIR8SA(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_IR8SOrder integer)
begin
  if exists(select* from IR8SA where
      IR8SA.PersonalSysId = In_PersonalSysId and
      IR8SA.YEYear = In_YEYear and
      IR8SA.IR8SOrder = In_IR8SOrder) then
    delete from IR8SA where
      IR8SA.PersonalSysId = In_PersonalSysId and
      IR8SA.YEYear = In_YEYear and
      IR8SA.IR8SOrder = In_IR8SOrder;
    commit work
  end if
end
;

create procedure dba.DeleteIR8SATwoID(
in In_PersonalSysId integer,
in In_YEYear integer)
begin
  if exists(select* from IR8SA where
      IR8SA.PersonalSysId = In_PersonalSysId and
      IR8SA.YEYear = In_YEYear) then
    delete from IR8SA where
      IR8SA.PersonalSysId = In_PersonalSysId and
      IR8SA.YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.DeleteIR8SByPersonalSysId(
in In_PersonalSysId integer)
begin
  if exists(select* from IR8S where
      IR8S.PersonalSysId = In_PersonalSysId) then
    delete from IR8SA where
      IR8SA.PersonalSysId = In_PersonalSysId;
    delete from IR8SC where
      IR8SC.PersonalSysId = In_PersonalSysId;
    delete from IR8S where
      IR8S.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.DeleteIR8SC(
in In_PersonalSysId integer,
in In_Year integer,
in In_RefundSysId integer)
begin
  if exists(select* from IR8SC where
      IR8SC.PersonalSysId = In_PersonalSysId and
      IR8SC.YEYear = In_Year and
      IR8SC.RefundSysId = In_RefundSysId) then
    delete from IR8SC where
      IR8SC.PersonalSysId = In_PersonalSysId and
      IR8SC.YEYear = In_Year and
      IR8SC.RefundSysId = In_RefundSysId;
    update IR8SC set RefundSysId = Number(*) where YEYear = In_Year and PersonalSysId = In_PersonalSysId order by
        PersonalSysId asc,RefundSysId asc;
    commit work
  end if
end
;

create procedure dba.DeleteIRASNationality(
in In_EPECountryID char(20))
begin
  if exists(select* from IRASNationality where IRASNationality.EPECountryID = In_EPECountryID) then
    delete from IRASNationality where IRASNationality.EPECountryID = In_EPECountryId;
    commit work
  end if
end
;

create procedure dba.DeleteYEEmployee(
in In_PersonalSysID integer,
in In_YEYear integer)
begin
  if exists(select* from YEEmployee where
      YEEmployee.PersonalSysID = In_PersonalSysID and
      YEEmployee.YEYear = In_YEYear) then
    call DeleteIR8S(In_PersonalSysId,In_YEYear);
    call DeleteIR8AByYEYear(In_PersonalSysID,In_YEYear);
    call DeleteA8A(In_PersonalSysId,In_YEYear);
    call DeleteA8B(In_PersonalSysId,In_YEYear);
    call DeleteIR21Details(In_PersonalSysId,In_YEYear);
    call DeleteIR21A2(In_PersonalSysId,In_YEYear);
    call DeleteIR21A3(In_PersonalSysId,In_YEYear);
    call DeleteEmploymentHistoryByYEYear(In_PersonalSysId,In_YEYear);
    delete from YEEmployee where
      YEEmployee.PersonalSysID = In_PersonalSysID and
      YEEmployee.YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.DeleteYEEmployeeByPersonalSysID(
in In_PersonalSysID integer)
begin
  if exists(select* from YEEmployee where
      YEEmployee.PersonalSysID = In_PersonalSysID) then
    call DeleteIR8AByPersonalSysID(In_PersonalSysID);
    call DeleteIR8SByPersonalSysId(In_PersonalSysID);
    call DeleteA8AByPersonalSysId(In_PersonalSysID);
    call DeleteA8BByPersonalSysId(In_PersonalSysID);
    call DeleteIR21DetailsByPersonalSysID(In_PersonalSysID);
    call DeleteIR21A2ByPersonalSysID(In_PersonalSysID);
    call DeleteIR21A3ByPersonalSysID(In_PersonalSysID);
    call DeleteYERecordByPersonalSysID(In_PersonalSysID);
    call DeleteEmploymentHistoryByPersonalSysID(In_PersonalSysID);
    delete from YEEmployee where
      YEEmployee.PersonalSysID = In_PersonalSysID;
    commit work
  end if
end
;

create procedure dba.DeleteYEEmployer(
in In_YEEmployerID char(20))
begin
  if exists(select* from YEEmployer where YEEmployer.YEEmployerID = In_YEEmployerID) then
    delete from LastSubmission where
      LastSubmission.YEEmployerID = In_YEEmployerID;
    delete from YEEmployer where
      YEEmployer.YEEmployerID = In_YEEmployerID;
    commit work
  end if
end
;

create procedure dba.DeleteYEGlobal(
in In_YEGlobalID char(20))
begin
  if exists(select* from YEGlobal where YEGlobal.YEGlobalID = In_YEGlobalID) then
    delete from YEGlobal where YEGlobal.YEGlobalID = In_YEGlobalID;
    commit work
  end if
end
;

create procedure dba.DeleteYERecord(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_YERecordType char(20))
begin
  if exists(select* from YERecord where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      YERecordType = In_YERecordType) then
    delete from YERecord where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      YERecordType = In_YERecordType;
    commit work
  end if
end
;

create procedure dba.DeleteYERecordByPersonalSysID(
in In_PersonalSysId integer)
begin
  if exists(select* from YERecord where
      PersonalSysId = In_PersonalSysId) then
    delete from YERecord where
      PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.DeleteYERecordByYEYear(
in In_PersonalSysId integer,
in In_YEYear integer)
begin
  if exists(select* from YERecord where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear) then
    delete from YERecord where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear;
    commit work
  end if
end
;

create function dba.FGetA8AS2Items(
in In_Sec2ItemsNo char(3),
in In_YEYear integer,
in In_PersonalSysId integer)
returns char(150)
begin
  declare Out_ItemsResult char(150);
  declare FinalItem char(150);
  set Out_ItemsResult='';
  A8ASection2Loop: for A8ASection2For as ProcessA8ASec2Curs dynamic scroll cursor for
    select A8AS2.Sec2Items as Out_Sec2Items from
      A8AS2 where
      A8AS2.Sec2ItemsNo like In_Sec2ItemsNo+'%' and
      A8AS2.YEYear = In_YEYear and
      A8AS2.PersonalSysId = In_PersonalSysId order by A8AS2.Sec2ItemsNo asc do
    set Out_ItemsResult=Out_ItemsResult+' '+Out_Sec2Items+'/' end for;
  set FinalItem=In_Sec2ItemsNo+'. '+STUFF(Out_ItemsResult,length(Out_ItemsResult),1,null);
  return(FinalItem)
end
;

create function dba.FGetA8AS2Rate(
in In_Sec2ItemsNo char(3),
in In_YEYear integer,
in In_PersonalSysId integer)
returns char(150)
begin
  declare Out_RateResult char(150);
  declare OutSec2Rate char(150);
  set Out_RateResult='';
  A8ASection2Loop: for A8ASection2For as ProcessA8ASec2Curs dynamic scroll cursor for
    select A8AS2.Sec2Rate as Out_Sec2Rate from
      A8AS2 where
      A8AS2.Sec2ItemsNo like In_Sec2ItemsNo+'%' and
      A8AS2.YEYear = In_YEYear and
      A8AS2.PersonalSysId = In_PersonalSysId order by A8AS2.Sec2ItemsNo asc do
    set OutSec2Rate=STR(Out_Sec2Rate,12,2);
    set Out_RateResult=Out_RateResult+' '+Trim(STR(Out_Sec2Rate,12,2))+'/' end for;
  if(In_Sec2ItemsNo = 'C') then
    set Out_RateResult=OutSec2Rate
  elseif(In_Sec2ItemsNo = 'E') then
    set Out_RateResult=OutSec2Rate
  elseif(In_Sec2ItemsNo = 'F') then
    set Out_RateResult=OutSec2Rate
  else
    set Out_RateResult=STUFF(Out_RateResult,length(Out_RateResult),1,null)
  end if;
  return(Out_RateResult)
end
;

create function dba.FGetA8AS2Units(
in In_Sec2ItemsNo char(3),
in In_YEYear integer,
in In_PersonalSysId integer)
returns char(150)
begin
  declare Out_UnitResult char(150);
  set Out_UnitResult='';
  A8ASection2Loop: for A8ASection2For as ProcessA8ASec2Curs dynamic scroll cursor for
    select A8AS2.Sec2Unit as Out_Sec2Unit from
      A8AS2 where
      A8AS2.Sec2ItemsNo like In_Sec2ItemsNo+'%' and
      A8AS2.YEYear = In_YEYear and
      A8AS2.PersonalSysId = In_PersonalSysId order by A8AS2.Sec2ItemsNo asc do
    if(IfNULL(Out_Sec2Unit,0,Out_Sec2Unit) = 0) then
      set Out_UnitResult=Out_UnitResult+' '+'NA'+'/'
    else
      set Out_UnitResult=Out_UnitResult+' '+Trim(STR(Out_Sec2Unit,12,1))+'/'
    end if end for;
  set Out_UnitResult=STUFF(Out_UnitResult,length(Out_UnitResult),1,null);
  return(Out_UnitResult)
end
;

create function dba.FGetA8AS2Value(
in In_Sec2ItemsNo char(3),
in In_YEYear integer,
in In_PersonalSysId integer)
returns char(50)
begin
  declare Out_finalResult char(50);
  declare Out_ValueResult double;
  set Out_ValueResult=0;
  A8ASection2Loop: for A8ASection2For as ProcessA8ASec2Curs dynamic scroll cursor for
    select A8AS2.Sec2Value as Out_Sec2Value from
      A8AS2 where
      A8AS2.Sec2ItemsNo like In_Sec2ItemsNo+'%' and
      A8AS2.YEYear = In_YEYear and
      A8AS2.PersonalSysId = In_PersonalSysId order by A8AS2.Sec2ItemsNo asc do
    set Out_ValueResult=Out_ValueResult+Out_Sec2Value end for;
  if(IfNULL(Out_ValueResult,0,Out_ValueResult) = 0) then
    set Out_finalResult='NA'
  else
    set Out_finalResult=STR(Out_ValueResult,12,2)
  end if;
  return(Out_finalResult)
end
;

create function DBA.FGetIRASNationalityCode(
in In_CountryId char(20))
returns char(20)
begin
  declare Out_IRASNationalityCode char(20);
  select IRASNationality.IRASNationalityCode into Out_IRASNationalityCode
    from IRASNationality where
    IRASNationality.EPECountryId = In_CountryId;
  return(Out_IRASNationalityCode)
end
;

create function dba.FGetYEKeywordUserDefinedName(
in In_KeywordID char(20))
returns char(100)
begin
  declare Out_YEKeywordUserDefinedName char(100);
  select YEKeywordUserDefinedName into Out_YEKeywordUserDefinedName from YEKeyword where
    YEKeywordId = In_KeywordID;
  return(Out_YEKeywordUserDefinedName)
end
;

create function DBA.FGetYERecordStatus(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_YERecordType char(20))
returns char(20)
begin
  declare Out_YERecordStatus char(20);
  select Status into Out_YERecordStatus from YERecord where PersonalSysID = In_PersonalSysID and
    YEYear = In_YEYear and YERecordType = In_YERecordType;
  return Out_YERecordStatus
end
;

create procedure dba.InsertNewA8A(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_FormHeaderMsg char(100),
in In_ResidenceValue double,
in In_ResidenceAddress1 char(30),
in In_ResidenceAddress2 char(30),
in In_ResidenceAddress3 char(30),
in In_ERPaidRent double,
in In_EEPaidRent double,
in In_OccupationFrom date,
in In_OccupationTo date,
in In_OccupationDays integer,
in In_Section2Total double,
in In_Section3Total double,
in In_Section4Total double,
in In_IncidentalBenefits double,
in In_PassagesSelf integer,
in In_PassagesWife integer,
in In_PassagesChildren integer,
in In_InterestLoan double,
in In_LifeInsurance double,
in In_Holidays double,
in In_Education double,
in In_LongService double,
in In_Clubs double,
in In_Assets double,
in In_MotorVehicle double,
in In_CarBenefit double,
in In_OtherBenefits double,
in In_OtherBenefitsDetails char(50),
in In_OHQStatus char(1),
in In_OHQDetails char(150),
in In_Additional char(200),
in In_TotalBenefitInKind double,
in In_NoOfEESharingQtr integer)
begin
  if not exists(select* from A8A where
      A8A.PersonalSysId = In_PersonalSysId and
      A8A.YEYear = In_YEYear) then
    insert into A8A(PersonalSysId,
      YEYear,
      FormHeaderMsg,
      ResidenceValue,
      ResidenceAddress1,
      ResidenceAddress2,
      ResidenceAddress3,
      ERPaidRent,
      EEPaidRent,
      OccupationFrom,
      OccupationTo,
      OccupationDays,
      Section2Total,
      Section3Total,
      Section4Total,
      IncidentalBenefits,
      PassagesSelf,
      PassagesWife,
      PassagesChildren,
      InterestLoan,
      LifeInsurance,
      Holidays,
      Education,
      LongService,
      Clubs,
      Assets,
      MotorVehicle,
      CarBenefit,
      OtherBenefits,
      OtherBenefitsDetails,
      OHQStatus,
      OHQDetails,
      Additional,
      TotalBenefitInKind,
      NoOfEESharingQtr,
      LastChangedDateTime) values(
      In_PersonalSysId,
      In_YEYear,
      In_FormHeaderMsg,
      In_ResidenceValue,
      In_ResidenceAddress1,
      In_ResidenceAddress2,
      In_ResidenceAddress3,
      In_ERPaidRent,
      In_EEPaidRent,
      In_OccupationFrom,
      In_OccupationTo,
      In_OccupationDays,
      In_Section2Total,
      In_Section3Total,
      In_Section4Total,
      In_IncidentalBenefits,
      In_PassagesSelf,
      In_PassagesWife,
      In_PassagesChildren,
      In_InterestLoan,
      In_LifeInsurance,
      In_Holidays,
      In_Education,
      In_LongService,
      In_Clubs,
      In_Assets,
      In_MotorVehicle,
      In_CarBenefit,
      In_OtherBenefits,
      In_OtherBenefitsDetails,
      In_OHQStatus,
      In_OHQDetails,
      In_Additional,
      In_TotalBenefitInKind,
      In_NoOfEESharingQtr,
      now(*));
    commit work
  end if
end
;

create procedure dba.InsertNewA8AS2(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_Sec2ItemsNo char(3),
in In_Sec2Items char(50),
in In_Sec2Selection integer,
in In_Sec2Unit double,
in In_Sec2Rate double,
in In_Sec2Days double,
in In_Sec2Value double,
in In_Sec2YEKeywordId char(20))
begin
  if not exists(select* from A8AS2 where
      A8AS2.PersonalSysId = In_PersonalSysId and
      A8AS2.YEYear = In_YEYear and
      A8AS2.Sec2ItemsNo = In_Sec2ItemsNo) then
    insert into A8AS2(PersonalSysId,
      YEYear,
      Sec2ItemsNo,
      Sec2Items,
      Sec2Selection,
      Sec2Unit,
      Sec2Rate,
      Sec2Days,
      Sec2Value,
      Sec2YEKeywordId) values(
      In_PersonalSysId,
      In_YEYear,
      In_Sec2ItemsNo,
      In_Sec2Items,
      In_Sec2Selection,
      In_Sec2Unit,
      In_Sec2Rate,
      In_Sec2Days,
      In_Sec2Value,
      In_Sec2YEKeywordId);
    commit work;
    update A8A set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.InsertNewA8AS3(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_Sec3No char(3),
in In_Sec3NoOfPersons integer,
in In_Sec3Rate double,
in In_Sec3Period double,
in In_Sec3Value double,
in In_Sec3DisplayMsg char(50),
in In_Sec3YEKeywordId char(20))
begin
  if not exists(select* from A8AS3 where
      A8AS3.PersonalSysId = In_PersonalSysId and
      A8AS3.YEYear = In_YEYear and
      A8AS3.Sec3No = In_Sec3No) then
    insert into A8AS3(PersonalSysId,
      YEYear,
      Sec3No,
      Sec3NoOfPersons,
      Sec3Rate,
      Sec3Period,
      Sec3Value,
      Sec3DisplayMsg,
      Sec3YEKeywordId) values(
      In_PersonalSysId,
      In_YEYear,
      In_Sec3No,
      In_Sec3NoOfPersons,
      In_Sec3Rate,
      In_Sec3Period,
      In_Sec3Value,
      In_Sec3DisplayMsg,
      In_Sec3YEKeywordId);
    commit work;
    update A8A set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.InsertNewA8B(
in In_PersonalsysId integer,
in In_YEYear integer,
in In_FormHeaderMsg char(100),
in In_TotalEESOPTaxExempt double,
in In_TotalCSOPTaxExempt double,
in In_TotalESOPNoTaxExempt double,
in In_TotalEESOPNoTaxExempt double,
in In_TotalCSOPNoTaxExempt double,
in In_TotalESOPStockGains double,
in In_TotalEESOPStockGains double,
in In_TotalCSOPStockGains double,
in In_GrandTotalStockGains double,
in In_Remarks char(200),
in In_OtherShareAmt double,
in In_TotalESOPNoTaxExemptBef double,
in In_TotalESOPStockGainsBef double,
in In_TotalEESOPTaxExemptBef double,
in In_TotalEESOPNoTaxExemptBef double,
in In_TotalEESOPStockGainsBef double,
in In_TotalCSOPTaxExemptBef double,
in In_TotalCSOPNoTaxExemptBef double,
in In_TotalCSOPStockGainsBef double)
begin
  if not exists(select* from A8B where
      A8B.PersonalSysId = In_PersonalsysId and
      A8B.YEYear = In_YEYear) then
    insert into A8B(PersonalsysId,
      YEYear,
      FormHeaderMsg,
      TotalEESOPTaxExempt,
      TotalCSOPTaxExempt,
      TotalESOPNoTaxExempt,
      TotalEESOPNoTaxExempt,
      TotalCSOPNoTaxExempt,
      TotalESOPStockGains,
      TotalEESOPStockGains,
      TotalCSOPStockGains,
      GrandTotalStockGains,
      Remarks,
      OtherShareAmt,
      TotalESOPNoTaxExemptBef,
      TotalESOPStockGainsBef,
      TotalEESOPTaxExemptBef,
      TotalEESOPNoTaxExemptBef,
      TotalEESOPStockGainsBef,
      TotalCSOPTaxExemptBef,
      TotalCSOPNoTaxExemptBef,
      TotalCSOPStockGainsBef,
      LastChangedDateTime) values(In_PersonalsysId,
      In_YEYear,
      In_FormHeaderMsg,
      In_TotalEESOPTaxExempt,
      In_TotalCSOPTaxExempt,
      In_TotalESOPNoTaxExempt,
      In_TotalEESOPNoTaxExempt,
      In_TotalCSOPNoTaxExempt,
      In_TotalESOPStockGains,
      In_TotalEESOPStockGains,
      In_TotalCSOPStockGains,
      In_GrandTotalStockGains,
      In_Remarks,
      In_OtherShareAmt,
      In_TotalESOPNoTaxExemptBef,
      In_TotalESOPStockGainsBef,
      In_TotalEESOPTaxExemptBef,
      In_TotalEESOPNoTaxExemptBef,
      In_TotalEESOPStockGainsBef,
      In_TotalCSOPTaxExemptBef,
      In_TotalCSOPNoTaxExemptBef,
      In_TotalCSOPStockGainsBef,
      now(*));
    commit work
  end if
end
;

create procedure dba.InsertNewA8BRecord(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_A8BSysId integer,
in In_StockOptionType char(20),
in In_RCBNo char(20),
in In_CompanyIDType char(20),
in In_CompanyName char(40),
in In_TypePlanGranted char(20),
in In_DateStockGranted date,
in In_DateExerciseStock date,
in In_ExercisePriceStock double,
in In_MktValueStockGrant double,
in In_MktValueExerciseStock double,
in In_SharesAcquired double,
in In_EESOPTaxExempt double,
in In_CSOPTaxExempt double,
in In_NoTaxExempt double,
in In_StockGains double)
begin
  declare In_GrantedBef smallint;
  if not exists(select* from A8BRecord where
      A8BRecord.PersonalSysId = In_PersonalSysId and
      A8BRecord.YEYear = In_YEYear and
      A8BRecord.A8BSysId = In_A8BSysId and
      A8BRecord.StockOptionType = In_StockOptionType) then
    /*
    Only ESOP requires check before or after 2003        
    */
    if(In_TypePlanGranted = 'ESOW') then
      set In_GrantedBef=0
    else
      select(case when YEProperty3 <= Year(In_DateStockGranted) then 0 else 1 end) into In_GrantedBef from YEKeyword where YEKeywordid = 'A8B'
    end if;
    insert into A8BRecord(PersonalSysId,
      YEYear,
      A8BSysId,
      StockOptionType,
      RCBNo,
      CompanyIDType,
      CompanyName,
      TypePlanGranted,
      DateStockGranted,
      DateExerciseStock,
      ExercisePriceStock,
      MktValueStockGrant,
      MktValueExerciseStock,
      SharesAcquired,
      EESOPTaxExempt,
      CSOPTaxExempt,
      NoTaxExempt,
      StockGains,
      GrantedBef) values(
      In_PersonalSysId,
      In_YEYear,
      In_A8BSysId,
      In_StockOptionType,
      In_RCBNo,
      In_CompanyIDType,
      In_CompanyName,
      In_TypePlanGranted,
      In_DateStockGranted,
      In_DateExerciseStock,
      In_ExercisePriceStock,
      In_MktValueStockGrant,
      In_MktValueExerciseStock,
      In_SharesAcquired,
      In_EESOPTaxExempt,
      In_CSOPTaxExempt,
      In_NoTaxExempt,
      In_StockGains,
      In_GrantedBef);
    commit work;
    update A8B set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.InsertNewEmploymentHistory(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_YEEmployeeSysId integer,
in In_YEPayGroupId char(20),
in In_FromDate date,
in In_ToDate date)
begin
  if not exists(select* from EmploymentHistory where
      PersonalSysId = In_PersonalsysId and
      YEYear = In_YEYear and
      YEEmployeeSysId = In_YEEmployeeSysId) then
    insert into EmploymentHistory(PersonalSysId,
      YEYear,
      YEEmployeeSysId,
      YEPayGroupId,
      FromDate,
      ToDate) values(
      In_PersonalSysId,
      In_YEYear,
      In_YEEmployeeSysId,
      In_YEPayGroupId,
      In_FromDate,
      In_ToDate);
    commit work
  end if
end
;

create procedure dba.InsertNewIR8A(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_IR8AType char(20),
in In_FormHeaderMsg char(100),
in In_NSPay double,
in In_GrossTotal double,
in In_ContratualBonus double,
in In_DirectorFee double,
in In_Commission double,
in In_Pension double,
in In_Transport double,
in In_Entertainment double,
in In_OtherAllowance double,
in In_Gratuity double,
in In_GratuityDetails char(150),
in In_RetirementDetails char(60),
in In_AccruedFrom double,
in In_AccruedTo double,
in In_EROutsideContri double,
in In_EROutsideContriDetails char(150),
in In_ERExcessContri double,
in In_ShareAmt double,
in In_ShareDetails char(150),
in In_BenefitsInKind double,
in In_IncomeBorne smallint,
in In_IncomeBorneStatus char(20),
in In_IncomeBorneDetails char(150),
in In_EECPFPension double,
in In_EECPF smallint,
in In_EEPension smallint,
in In_EEPensionDetails char(60),
in In_EEVoluntaryCPF double,
in In_Donation double,
in In_MOSQFund double,
in In_MBMF smallint,
in In_COMC smallint,
in In_SINDA smallint,
in In_CDAC smallint,
in In_ECF smallint,
in In_MOSQ smallint,
in In_YMF smallint,
in In_OtherDonation smallint,
in In_Remarks char(200),
in In_Insurance double,
in In_PaymentFrom date,
in In_PaymentTo date,
in In_EEOverseasCPF double,
in In_NonContratualBonus double,
in In_TotalSectionD double,
in In_FormFooterMsg char(100),
in In_IR8ABenefitsInKind double,
in In_LumpSumGratuity double,
in In_LumpSumCompensation double,
in In_LumpSumNoticePay double,
in In_LumpSumExGratia double,
in In_LumpSumOthers double,
in In_LumpSumBasis char(150),
in In_BenefitsInKindDesc char(150),
in In_CPFBorneByER double,
in In_TaxBorneByER double,
in In_FixedAmtBorneByEE double,
in In_CompensationApprovedDate date,
in In_ExemptIncomeType char(20),
in In_ExemptIncomeAmt double,
in In_OtherAllowanceAmt double,
in In_TotalStockGainsBef double)
begin
  if not exists(select* from IR8A where
      IR8A.PersonalSysID = In_PersonalSysID and
      IR8A.YEYear = In_YEYear and
      IR8A.IR8AType = In_IR8AType) then
    insert into IR8A(PersonalSysID,
      YEYear,
      IR8AType,
      FormHeaderMsg,
      NSPay,
      GrossTotal,
      ContratualBonus,
      DirectorFee,
      Commission,
      Pension,
      Transport,
      Entertainment,
      OtherAllowance,
      Gratuity,
      GratuityDetails,
      RetirementDetails,
      AccruedFrom,
      AccruedTo,
      EROutsideContri,
      EROutsideContriDetails,
      ERExcessContri,
      ShareAmt,
      ShareDetails,
      BenefitsInKind,
      IncomeBorne,
      IncomeBorneStatus,
      IncomeBorneDetails,
      EECPFPension,
      EECPF,
      EEPension,
      EEPensionDetails,
      EEVoluntaryCPF,
      Donation,
      MOSQFund,
      MBMF,
      COMC,
      SINDA,
      CDAC,
      ECF,
      MOSQ,
      YMF,
      OtherDonation,
      Remarks,
      Insurance,
      PaymentFrom,
      PaymentTo,
      EEOverseasCPF,
      NonContratualBonus,
      TotalSectionD,FormFooterMsg,
      IR8ABenefitsInKind,
      LumpSumGratuity,
      LumpSumCompensation,
      LumpSumNoticePay,
      LumpSumExGratia,
      LumpSumOthers,
      LumpSumBasis,
      BenefitsInKindDesc,
      CPFBorneByER,
      TaxBorneByER,
      FixedAmtBorneByEE,
      LastChangedDateTime,
      CompensationApprovedDate,
      ExemptIncomeType,
      ExemptIncomeAmt,
      OtherAllowanceAmt,
      TotalStockGainsBef) values(
      In_PersonalSysID,
      In_YEYear,
      In_IR8AType,
      In_FormHeaderMsg,
      In_NSPay,
      In_GrossTotal,
      In_ContratualBonus,
      In_DirectorFee,
      In_Commission,
      In_Pension,
      In_Transport,
      In_Entertainment,
      In_OtherAllowance,
      In_Gratuity,
      In_GratuityDetails,
      In_RetirementDetails,
      In_AccruedFrom,
      In_AccruedTo,
      In_EROutsideContri,
      In_EROutsideContriDetails,
      In_ERExcessContri,
      In_ShareAmt,
      In_ShareDetails,
      In_BenefitsInKind,
      In_IncomeBorne,
      In_IncomeBorneStatus,
      In_IncomeBorneDetails,
      In_EECPFPension,
      In_EECPF,
      In_EEPension,
      In_EEPensionDetails,
      In_EEVoluntaryCPF,
      In_Donation,
      In_MOSQFund,
      In_MBMF,
      In_COMC,
      In_SINDA,
      In_CDAC,
      In_ECF,
      In_MOSQ,
      In_YMF,
      In_OtherDonation,
      In_Remarks,
      In_Insurance,
      In_PaymentFrom,
      In_PaymentTo,
      In_EEOverseasCPF,
      In_NonContratualBonus,
      In_TotalSectionD,In_FormFooterMsg,In_IR8ABenefitsInKind,
      In_LumpSumGratuity,
      In_LumpSumCompensation,
      In_LumpSumNoticePay,
      In_LumpSumExGratia,
      In_LumpSumOthers,
      In_LumpSumBasis,
      In_BenefitsInKindDesc,
      In_CPFBorneByER,
      In_TaxBorneByER,
      In_FixedAmtBorneByEE,
      now(*),
      In_CompensationApprovedDate,
      In_ExemptIncomeType,
      In_ExemptIncomeAmt,
      In_OtherAllowanceAmt,
      In_TotalStockGainsBef);
    commit work
  end if
end
;

create procedure dba.InsertNewIR8S(
in In_PersonalsysId integer,
in In_Year integer,
in In_FormHeaderMsg char(100),
in In_OverseasPostFrom date,
in In_OverseasPostTo date,
in In_EEOverseasCPF double,
in In_EROverseasCPF double,
in In_CPFOverseasObligatory char(1),
in In_CPFCapping smallint,
in In_EEVolCPF double,
in In_ERVolCPF double,
in In_VolCPFObligatory char(1),
in In_PreviousBonus double,
in In_Additional char(100),
in In_SectionCRemarks char(100),
in In_DateofPRGranted date,
in In_DateofPRRenounce date,
in In_ApprovalForFullCPF char(1),
in In_CPFWageType char(1))
begin
  if not exists(select* from IR8S where
      IR8S.PersonalSysId = In_PersonalsysId and
      IR8S.YEYear = In_Year) then
    insert into IR8S(PersonalSysId,
      YEYear,
      FormHeaderMsg,
      OverseasPostFrom,
      OverseasPostTo,
      EEOverseasCPF,
      EROverseasCPF,
      CPFOverseasObligatory,
      CPFCapping,
      EEVolCPF,
      ERVolCPF,
      VolCPFObligatory,
      PreviousBonus,
      Additional,
      SectionCRemarks,
      DateofPRGranted,
      DateofPRRenounce,
      ApprovalForFullCPF,
      CPFWageType,
      LastChangedDateTime) values(
      In_PersonalsysId,
      In_Year,
      In_FormHeaderMsg,
      In_OverseasPostFrom,
      In_OverseasPostTo,
      In_EEOverseasCPF,
      In_EROverseasCPF,
      In_CPFOverseasObligatory,
      In_CPFCapping,
      In_EEVolCPF,
      In_ERVolCPF,
      In_VolCPFObligatory,
      In_PreviousBonus,
      In_Additional,
      In_SectionCRemarks,
      In_DateofPRGranted,
      In_DateofPRRenounce,
      In_ApprovalForFullCPF,
      In_CPFWageType,
      now(*));
    commit work
  end if
end
;

create procedure dba.InsertNewIR8SA(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_IR8SOrder integer,
in In_OrdWages double,
in In_ContriOrdEECPF double,
in In_ContriOrdERCPF double,
in In_ActualOrdEECPF double,
in In_ActualOrdERCPF double,
in In_AddWages double,
in In_ContriAddEECPF double,
in In_ContriAddERCPF double,
in In_ActualAddEECPF double,
in In_ActualAddERCPF double,
in In_IR8SColDesc char(20),
in In_CurOrdinaryWage double,
in In_PrevOrdinaryWage double,
in In_CurAdditionalWage double,
in In_PrevAdditionalWage double,
in In_OverseasEECPF double,
in In_OverseasERCPF double,
in In_CPFClass char(20),
in In_CPFPeriodCapping double,
in In_CPFLessThanCapping double,
in In_CPFGreaterThanCapping double,
in In_CappedOrdWage double,
out Out_IR8SSysId integer)
begin
  if not exists(select* from IR8SA where
      IR8SA.PersonalSysId = In_PersonalSysId and
      IR8SA.YEYear = In_YEYear and
      IR8SA.IR8SOrder = In_IR8SOrder) then
    insert into IR8SA(PersonalSysId,
      YEYear,
      IR8SOrder,
      OrdWages,
      ContriOrdEECPF,
      ContriOrdERCPF,
      ActualOrdEECPF,
      ActualOrdERCPF,
      AddWages,
      ContriAddEECPF,
      ContriAddERCPF,
      ActualAddEECPF,
      ActualAddERCPF,
      IR8SColDesc,
      CurOrdinaryWage,
      PrevOrdinaryWage,
      CurAdditionalWage,
      PrevAdditionalWage,
      OverseasEECPF,
      OverseasERCPF,
      CPFClass,
      CPFPeriodCapping,
      CPFLessThanCapping,
      CPFGreaterThanCapping,
      CappedOrdWage) values(
      In_PersonalSysId,
      In_YEYear,
      In_IR8SOrder,
      In_OrdWages,
      In_ContriOrdEECPF,
      In_ContriOrdERCPF,
      In_ActualOrdEECPF,
      In_ActualOrdERCPF,
      In_AddWages,
      In_ContriAddEECPF,
      In_ContriAddERCPF,
      In_ActualAddEECPF,
      In_ActualAddERCPF,
      In_IR8SColDesc,
      In_CurOrdinaryWage,
      In_PrevOrdinaryWage,
      In_CurAdditionalWage,
      In_PrevAdditionalWage,
      In_OverseasEECPF,
      In_OverseasERCPF,
      In_CPFClass,
      In_CPFPeriodCapping,
      In_CPFLessThanCapping,
      In_CPFGreaterThanCapping,
      In_CappedOrdWage);
    commit work;
    update IR8S set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
    commit work;
    select IR8SA.IR8SSysId into Out_IR8SSysId from IR8SA where IR8SA.PersonalSysId = In_PersonalSysId and IR8SA.YEYear = In_YEYear and IR8SA.IR8SOrder = In_IR8SOrder
  end if
end
;

create procedure dba.InsertNewIR8SC(
in In_PersonalsysId integer,
in In_Year integer,
in In_AddWageAmt double,
in In_AddWageFrom date,
in In_AddWageTo date,
in In_AddWagePaidDate date,
in In_ERContribution double,
in In_ERInterest double,
in In_ERDate date,
in In_EEContribution double,
in In_EEInterest double,
in In_EEDate date,
out Out_RefundSysId integer)
begin
  select Max(IR8SC.RefundSysId) into Out_RefundSysId from IR8SC where IR8SC.PersonalSysId = In_PersonalsysId and IR8SC.YEYear = In_Year;
  if(Out_RefundSysId is null) then set Out_RefundSysId=1
  else set Out_RefundSysId=Out_RefundSysId+1
  end if;
  insert into IR8SC(PersonalSysId,
    YEYear,
    RefundSysId,
    AddWageAmt,
    AddWageFrom,
    AddWageTo,
    AddWagePaidDate,
    ERContribution,
    ERInterest,
    ERDate,
    EEContribution,
    EEInterest,
    EEDate) values(
    In_PersonalsysId,
    In_Year,
    Out_RefundSysId,
    In_AddWageAmt,
    In_AddWageFrom,
    In_AddWageTo,
    In_AddWagePaidDate,
    In_ERContribution,
    In_ERInterest,
    In_ERDate,
    In_EEContribution,
    In_EEInterest,
    In_EEDate);
  commit work;
  update IR8S set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_Year;
  commit work
end
;

create procedure dba.InsertNewIRASNationality(
in In_EPECountryID char(20),
in In_IRASNationalityCode char(20))
begin
  if not exists(select* from IRASNationality where IRASNationality.EPECountryID = In_EPECountryID) then
    insert into IRASNationality(EPECountryID,IRASNationalityCode) values(
      In_EPECountryID,In_IRASNationalityCode);
    commit work
  end if
end
;

create procedure dba.InsertNewYEEmployee(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_CurrentYEGlobalId char(20),
in In_YEEmployerId char(20),
in In_TaxNo char(20),
in In_Designation char(20),
in In_EEAddress1 char(30),
in In_EEAddress2 char(30),
in In_EEAddress3 char(30),
in In_EEAddress4 char(30),
in In_PostalCode char(6),
in In_EEAddressType char(20),
in In_EEAddressCountry char(20),
in In_EEName1 char(35),
in In_EEName2 char(35),
in In_EEName3 char(10),
in In_DOB date,
in In_Commencement date,
in In_Cessation date,
in In_IRASSection45 char(1),
in In_IR8SIndicator char(1),
in In_A8AIndicator char(1),
in In_Flag100K char(1),
in In_FlagPercentOrdWage char(1),
in In_FlagOverseasCPF char(1),
in In_FlagExcessCPF char(1),
in In_IRASNationalityCode char(20),
in In_PayeeIDType char(1),
in In_CessationProvision char(1),
in In_Gender char(1),
in In_MaritalStatusDesc char(50),
in In_SupYEGlobalId char(20),
in In_IR21Indicator char(1))
begin
  if not exists(select* from YEEmployee where
      YEEmployee.PersonalSysID = In_PersonalSysID and
      YEEmployee.YEYear = In_YEYear) then
    insert into YEEmployee(PersonalSysID,
      YEYear,
      CurrentYEGlobalId,
      YEEmployerId,
      TaxNo,
      Designation,
      EEAddress1,
      EEAddress2,
      EEAddress3,
      EEAddress4,
      PostalCode,
      EEAddressType,
      EEAddressCountry,
      EEName1,
      EEName2,
      EEName3,
      DOB,
      Commencement,
      Cessation,
      IRASSection45,
      IR8SIndicator,
      A8AIndicator,
      Flag100K,
      FlagPercentOrdWage,
      FlagOverseasCPF,
      FlagExcessCPF,
      IRASNationalityCode,
      PayeeIDType,
      CessationProvision,
      Gender,
      MaritalStatusDesc,
      SupYEGlobalId,
      IR21Indicator,
      LastChangedDateTime) values(
      In_PersonalSysID,
      In_YEYear,
      In_CurrentYEGlobalId,
      In_YEEmployerId,
      In_TaxNo,
      In_Designation,
      In_EEAddress1,
      In_EEAddress2,
      In_EEAddress3,
      In_EEAddress4,
      In_PostalCode,
      In_EEAddressType,
      In_EEAddressCountry,
      In_EEName1,
      In_EEName2,
      In_EEName3,
      In_DOB,
      In_Commencement,
      In_Cessation,
      In_IRASSection45,
      In_IR8SIndicator,
      In_A8AIndicator,
      In_Flag100K,
      In_FlagPercentOrdWage,
      In_FlagOverseasCPF,
      In_FlagExcessCPF,
      In_IRASNationalityCode,
      In_PayeeIDType,
      In_CessationProvision,
      In_Gender,
      In_MaritalStatusDesc,
      In_SupYEGlobalId,
      In_IR21Indicator,
      now(*));
    commit work
  end if
end
;

create procedure dba.InsertNewYEEmployer(
in In_YEEmployerID char(20),
in In_YEEmployerDesc char(100),
in In_TaxRefNo char(20),
in In_TelephoneNo char(20),
in In_ERName1 char(35),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_AuthorisedName char(60),
in In_DeclaredDate date,
in In_Designation char(27),
in In_EmployerSource char(20),
in In_PayerId char(20),
in In_ERName2 char(35),
in In_IsAutoInclusion smallint,
in In_DivisionBranch char(100),
in In_EmailAddress char(100),
in In_HandphonePagerNo char(20),
in In_ContactPerson char(60),
in In_FaxNo char(20))
begin
  if not exists(select* from YEEmployer where YEEmployer.YEEmployerID = In_YEEmployerID) then
    insert into YEEmployer(YEEmployerID,
      YEEmployerDesc,
      TaxRefNo,
      TelephoneNo,
      ERName1,
      DivisionBranch,
      Address1,
      Address2,
      Address3,
      AuthorisedName,
      DeclaredDate,
      Designation,
      EmailAddress,
      EmployerSource,
      PayerId,
      ERName2,
      IsAutoInclusion,
      HandphonePagerNo,
      ContactPerson,
      FaxNo) values(
      In_YEEmployerID,
      In_YEEmployerDesc,
      In_TaxRefNo,
      In_TelephoneNo,
      In_ERName1,
      In_DivisionBranch,
      In_Address1,
      In_Address2,
      In_Address3,
      In_AuthorisedName,
      In_DeclaredDate,
      In_Designation,
      In_EmailAddress,
      In_EmployerSource,
      In_PayerId,
      In_ERName2,
      In_IsAutoInclusion,
      In_HandphonePagerNo,
      In_ContactPerson,
      In_FaxNo);
    commit work
  end if
end
;

create procedure dba.InsertNewYEGlobal(
in In_YEGlobalID char(20),
in In_YEGlobalDesc char(100),
in In_BonusDeclared date,
in In_DirFeeApproved date,
in In_CommissionFrom date,
in In_CommissionTo date,
in In_CommissionStatus char(20),
in In_DirFeeFrom date,
in In_DirFeeTo date,
in In_AddEndPeriod integer,
in In_SupStartPeriod integer,
in In_AddCPFOption smallint,
in In_SupCPFOption smallint,
in In_CPFTaxableStatus smallint)
begin
  if not exists(select* from YEGlobal where YEGlobal.YEGlobalID = In_YEGlobalID) then
    insert into YEGlobal(YEGlobalID,
      YEGlobalDesc,
      BonusDeclared,
      DirFeeApproved,
      CommissionFrom,
      CommissionTo,
      CommissionStatus,
      DirFeeFrom,
      DirFeeTo,
      AddEndPeriod,
      SupStartPeriod,
      AddCPFOption,
      SupCPFOption,CPFTaxableStatus) values(
      In_YEGlobalID,
      In_YEGlobalDesc,
      In_BonusDeclared,
      In_DirFeeApproved,
      In_CommissionFrom,
      In_CommissionTo,
      In_CommissionStatus,
      In_DirFeeFrom,
      In_DirFeeTo,
      In_AddEndPeriod,
      In_SupStartPeriod,
      In_AddCPFOption,
      In_SupCPFOption,In_CPFTaxableStatus);
    commit work
  end if
end
;

create procedure dba.InsertNewYERecord(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_YERecordType char(20),
in In_Status char(20),
in In_LastProcessed timestamp)
begin
  if not exists(select* from YERecord where
      PersonalSysId = In_PersonalsysId and
      YEYear = In_YEYear and
      YERecordType = In_YERecordType) then
    insert into YERecord(PersonalSysId,
      YEYear,
      YERecordType,
      Status,
      LastProcessed) values(
      In_PersonalSysId,
      In_YEYear,
      In_YERecordType,
      In_Status,
      In_LastProcessed);
    commit work
  end if
end
;

create function DBA.IsA8AS2UseActualValue(
in In_YEKeyWordId char(20))
returns smallint
begin
  declare In_YEProperty3 integer;
  select YEProperty3 into In_YEProperty3 from YEKeyword where
    YEKeywordId = In_YEKeyWordId;
  return In_YEProperty3
end
;

create procedure dba.PatchMOSQYMF()
begin
  declare Out_MOSQ double;
  declare Out_YMF double;
  declare Out_MBMF double;
  CreateOTRecLoop: for CreateOTRecFor as curs dynamic scroll cursor for
    select EmployeeSysId as In_EmployeeSysId,
      PayRecYear as In_PayRecYear,
      PayRecPeriod as In_PayRecPeriod from PeriodPolicySummary do
    select FGetPeriodFund(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,'MBMFCode') into Out_MOSQ;
    select FGetPeriodFund(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,'YMFCode') into Out_YMF;
    set Out_MOSQ=Out_MOSQ*-1;
    set Out_YMF=Out_YMF*-1;
    set Out_MBMF=Out_MOSQ+Out_YMF;
    update PeriodPolicySummary set
      TotalMBMF = Out_MBMF,
      TotalYMF = Out_YMF,
      TotalMOSQ = Out_MOSQ where current of curs end for;
  commit work
end
;

create procedure dba.UpdateA8A(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_FormHeaderMsg char(100),
in In_ResidenceValue double,
in In_ResidenceAddress1 char(30),
in In_ResidenceAddress2 char(30),
in In_ResidenceAddress3 char(30),
in In_ERPaidRent double,
in In_EEPaidRent double,
in In_OccupationFrom date,
in In_OccupationTo date,
in In_OccupationDays integer,
in In_Section2Total double,
in In_Section3Total double,
in In_Section4Total double,
in In_IncidentalBenefits double,
in In_PassagesSelf integer,
in In_PassagesWife integer,
in In_PassagesChildren integer,
in In_InterestLoan double,
in In_LifeInsurance double,
in In_Holidays double,
in In_Education double,
in In_LongService double,
in In_Clubs double,
in In_Assets double,
in In_MotorVehicle double,
in In_CarBenefit double,
in In_OtherBenefits double,
in In_OtherBenefitsDetails char(50),
in In_OHQStatus char(1),
in In_OHQDetails char(150),
in In_Additional char(200),
in In_TotalBenefitInKind double,
in In_NoOfEESharingQtr integer)
begin
  if exists(select* from A8A where
      A8A.PersonalSysId = In_PersonalSysId and
      A8A.YEYear = In_YEYear) then
    update A8A set
      A8A.FormHeaderMsg = In_FormHeaderMsg,
      A8A.ResidenceValue = In_ResidenceValue,
      A8A.ResidenceAddress1 = In_ResidenceAddress1,
      A8A.ResidenceAddress2 = In_ResidenceAddress2,
      A8A.ResidenceAddress3 = In_ResidenceAddress3,
      A8A.ERPaidRent = In_ERPaidRent,
      A8A.EEPaidRent = In_EEPaidRent,
      A8A.OccupationFrom = In_OccupationFrom,
      A8A.OccupationTo = In_OccupationTo,
      A8A.OccupationDays = In_OccupationDays,
      A8A.Section2Total = In_Section2Total,
      A8A.Section3Total = In_Section3Total,
      A8A.Section4Total = In_Section4Total,
      A8A.IncidentalBenefits = In_IncidentalBenefits,
      A8A.PassagesSelf = In_PassagesSelf,
      A8A.PassagesWife = In_PassagesWife,
      A8A.PassagesChildren = In_PassagesChildren,
      A8A.InterestLoan = In_InterestLoan,
      A8A.LifeInsurance = In_LifeInsurance,
      A8A.Holidays = In_Holidays,
      A8A.Education = In_Education,
      A8A.LongService = In_LongService,
      A8A.Clubs = In_Clubs,
      A8A.Assets = In_Assets,
      A8A.MotorVehicle = In_MotorVehicle,
      A8A.CarBenefit = In_CarBenefit,
      A8A.OtherBenefits = In_OtherBenefits,
      A8A.OtherBenefitsDetails = In_OtherBenefitsDetails,
      A8A.OHQStatus = In_OHQStatus,
      A8A.OHQDetails = In_OHQDetails,
      A8A.Additional = In_Additional,
      A8A.TotalBenefitInKind = In_TotalBenefitInKind,
      A8A.NoOfEESharingQtr = In_NoOfEESharingQtr,
      A8A.LastChangedDateTime = now(*) where
      A8A.PersonalSysId = In_PersonalSysId and
      A8A.YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.UpdateA8AS2(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_Sec2ItemsNo char(3),
in In_Sec2Items char(50),
in In_Sec2Selection integer,
in In_Sec2Unit double,
in In_Sec2Rate double,
in In_Sec2Days double,
in In_Sec2Value double,
in In_Sec2YEKeywordId char(20))
begin
  if exists(select* from A8AS2 where
      A8AS2.PersonalSysId = In_PersonalSysId and
      A8AS2.YEYear = In_YEYear and
      A8AS2.Sec2ItemsNo = In_Sec2ItemsNo) then
    update A8AS2 set
      A8AS2.Sec2Items = In_Sec2Items,
      A8AS2.Sec2Selection = In_Sec2Selection,
      A8AS2.Sec2Unit = In_Sec2Unit,
      A8AS2.Sec2Rate = In_Sec2Rate,
      A8AS2.Sec2Days = In_Sec2Days,
      A8AS2.Sec2Value = In_Sec2Value,
      A8AS2.Sec2YEKeywordId = In_Sec2YEKeywordId where
      A8AS2.PersonalSysId = In_PersonalSysId and
      A8AS2.YEYear = In_YEYear and
      A8AS2.Sec2ItemsNo = In_Sec2ItemsNo;
    commit work;
    update A8A set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.UpdateA8AS3(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_Sec3No char(3),
in In_Sec3NoOfPersons integer,
in In_Sec3Rate double,
in In_Sec3Period double,
in In_Sec3Value double,
in In_Sec3DisplayMsg char(50),
in In_Sec3YEKeywordId char(20))
begin
  if exists(select* from A8AS3 where
      A8AS3.PersonalSysId = In_PersonalSysId and
      A8AS3.YEYear = In_YEYear and
      A8AS3.Sec3No = In_Sec3No) then
    update A8AS3 set
      A8AS3.Sec3NoOfPersons = In_Sec3NoOfPersons,
      A8AS3.Sec3Rate = In_Sec3Rate,
      A8AS3.Sec3Period = In_Sec3Period,
      A8AS3.Sec3Value = In_Sec3Value,
      A8AS3.Sec3DisplayMsg = In_Sec3DisplayMsg,
      A8AS3.Sec3YEKeywordId = In_Sec3YEKeywordId where
      A8AS3.PersonalSysId = In_PersonalSysId and
      A8AS3.YEYear = In_YEYear and
      A8AS3.Sec3No = In_Sec3No;
    commit work;
    update A8A set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.UpdateA8B(
in In_PersonalsysId integer,
in In_YEYear integer,
in In_FormHeaderMsg char(100),
in In_TotalEESOPTaxExempt double,
in In_TotalCSOPTaxExempt double,
in In_TotalESOPNoTaxExempt double,
in In_TotalEESOPNoTaxExempt double,
in In_TotalCSOPNoTaxExempt double,
in In_TotalESOPStockGains double,
in In_TotalEESOPStockGains double,
in In_TotalCSOPStockGains double,
in In_GrandTotalStockGains double,
in In_Remarks char(200),
in In_OtherShareAmt double,
in In_TotalESOPNoTaxExemptBef double,
in In_TotalESOPStockGainsBef double,
in In_TotalEESOPTaxExemptBef double,
in In_TotalEESOPNoTaxExemptBef double,
in In_TotalEESOPStockGainsBef double,
in In_TotalCSOPTaxExemptBef double,
in In_TotalCSOPNoTaxExemptBef double,
in In_TotalCSOPStockGainsBef double)
begin
  if exists(select* from A8B where
      A8B.PersonalSysId = In_PersonalsysId and
      A8B.YEYear = In_YEYear) then
    update A8B set
      A8B.FormHeaderMsg = In_FormHeaderMsg,
      A8B.TotalEESOPTaxExempt = In_TotalEESOPTaxExempt,
      A8B.TotalCSOPTaxExempt = In_TotalCSOPTaxExempt,
      A8B.TotalESOPNoTaxExempt = In_TotalESOPNoTaxExempt,
      A8B.TotalEESOPNoTaxExempt = In_TotalEESOPNoTaxExempt,
      A8B.TotalCSOPNoTaxExempt = In_TotalCSOPNoTaxExempt,
      A8B.TotalESOPStockGains = In_TotalESOPStockGains,
      A8B.TotalEESOPStockGains = In_TotalEESOPStockGains,
      A8B.TotalCSOPStockGains = In_TotalCSOPStockGains,
      A8B.GrandTotalStockGains = In_GrandTotalStockGains,
      A8B.Remarks = In_Remarks,
      A8B.OtherShareAmt = In_OtherShareAmt,
      A8B.TotalESOPNoTaxExemptBef = In_TotalESOPNoTaxExemptBef,
      A8B.TotalESOPStockGainsBef = In_TotalESOPStockGainsBef,
      A8B.TotalEESOPTaxExemptBef = In_TotalEESOPTaxExemptBef,
      A8B.TotalEESOPNoTaxExemptBef = In_TotalEESOPNoTaxExemptBef,
      A8B.TotalEESOPStockGainsBef = In_TotalEESOPStockGainsBef,
      A8B.TotalCSOPTaxExemptBef = In_TotalCSOPTaxExemptBef,
      A8B.TotalCSOPNoTaxExemptBef = In_TotalCSOPNoTaxExemptBef,
      A8B.TotalCSOPStockGainsBef = In_TotalCSOPStockGainsBef,
      A8B.LastChangedDateTime = now(*) where
      A8B.PersonalSysId = In_PersonalsysId and
      A8B.YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.UpdateA8BRecord(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_A8BSysId integer,
in In_StockOptionType char(20),
in In_RCBNo char(20),
in In_CompanyIDType char(20),
in In_CompanyName char(40),
in In_TypePlanGranted char(20),
in In_DateStockGranted date,
in In_DateExerciseStock date,
in In_ExercisePriceStock double,
in In_MktValueStockGrant double,
in In_MktValueExerciseStock double,
in In_SharesAcquired double,
in In_EESOPTaxExempt double,
in In_CSOPTaxExempt double,
in In_NoTaxExempt double,
in In_StockGains double)
begin
  declare In_GrantedBef smallint;
  if exists(select* from A8BRecord where
      A8BRecord.PersonalSysId = In_PersonalSysId and
      A8BRecord.YEYear = In_YEYear and
      A8BRecord.A8BSysId = In_A8BSysId and
      A8BRecord.StockOptionType = In_StockOptionType) then
    /*
    Only ESOP requires check before or after 2003        
    */
    if(In_TypePlanGranted = 'ESOW') then
      set In_GrantedBef=0
    else
      select(case when YEProperty3 <= Year(In_DateStockGranted) then 0 else 1 end) into In_GrantedBef from YEKeyword where YEKeywordid = 'A8B'
    end if;
    update A8BRecord set
      A8BRecord.RCBNo = In_RCBNo,
      A8BRecord.CompanyIDType = In_CompanyIDType,
      A8BRecord.CompanyName = In_CompanyName,
      A8BRecord.TypePlanGranted = In_TypePlanGranted,
      A8BRecord.DateStockGranted = In_DateStockGranted,
      A8BRecord.DateExerciseStock = In_DateExerciseStock,
      A8BRecord.ExercisePriceStock = In_ExercisePriceStock,
      A8BRecord.MktValueStockGrant = In_MktValueStockGrant,
      A8BRecord.MktValueExerciseStock = In_MktValueExerciseStock,
      A8BRecord.SharesAcquired = In_SharesAcquired,
      A8BRecord.EESOPTaxExempt = In_EESOPTaxExempt,
      A8BRecord.CSOPTaxExempt = In_CSOPTaxExempt,
      A8BRecord.NoTaxExempt = In_NoTaxExempt,
      A8BRecord.StockGains = In_StockGains,
      A8BRecord.GrantedBef = In_GrantedBef where
      A8BRecord.PersonalSysId = In_PersonalSysId and
      A8BRecord.YEYear = In_YEYear and
      A8BRecord.A8BSysId = In_A8BSysId and
      A8BRecord.StockOptionType = In_StockOptionType;
    commit work;
    update A8B set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.UpdateEmploymentHistory(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_YEEmployeeSysId integer,
in In_YEPayGroupId char(20),
in In_FromDate date,
in ToDate date)
begin
  if not exists(select* from EmploymentHistory where
      PersonalSysId = In_PersonalsysId and
      YEYear = In_YEYear and
      YEEmployeeSysId = In_YEEmployeeSysId) then
    update EmploymentHistory set
      PersonalSysId = In_PersonalSysId,
      YEYear = In_YEYear,
      YEEmployeeSysId = In_YEEmployeeSysId,
      YEPayGroupId = In_YEPayGroupId,
      FromDate = In_FromDate,
      ToDate = In_ToDate where
      PersonalSysId = In_PersonalsysId and
      YEYear = In_YEYear and
      YEEmployeeSysId = In_YEEmployeeSysId;
    commit work
  end if
end
;

create procedure dba.UpdateIR8A(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_IR8AType char(20),
in In_FormHeaderMsg char(100),
in In_NSPay double,
in In_GrossTotal double,
in In_ContratualBonus double,
in In_DirectorFee double,
in In_Commission double,
in In_Pension double,
in In_Transport double,
in In_Entertainment double,
in In_OtherAllowance double,
in In_Gratuity double,
in In_GratuityDetails char(150),
in In_RetirementDetails char(60),
in In_AccruedFrom double,
in In_AccruedTo double,
in In_EROutsideContri double,
in In_EROutsideContriDetails char(150),
in In_ERExcessContri double,
in In_ShareAmt double,
in In_ShareDetails char(150),
in In_BenefitsInKind double,
in In_IncomeBorne smallint,
in In_IncomeBorneStatus char(20),
in In_IncomeBorneDetails char(150),
in In_EECPFPension double,
in In_EECPF smallint,
in In_EEPension smallint,
in In_EEPensionDetails char(60),
in In_EEVoluntaryCPF double,
in In_Donation double,
in In_MOSQFund double,
in In_MBMF smallint,
in In_COMC smallint,
in In_SINDA smallint,
in In_CDAC smallint,
in In_ECF smallint,
in In_MOSQ smallint,
in In_YMF smallint,
in In_OtherDonation smallint,
in In_Remarks char(200),
in In_Insurance double,
in In_PaymentFrom date,
in In_PaymentTo date,
in In_EEOverseasCPF double,
in In_NonContratualBonus double,
in In_TotalSectionD double,
in In_FormFooterMsg char(100),
in In_IR8ABenefitsInKind double,
in In_LumpSumGratuity double,
in In_LumpSumCompensation double,
in In_LumpSumNoticePay double,
in In_LumpSumExGratia double,
in In_LumpSumOthers double,
in In_LumpSumBasis char(150),
in In_BenefitsInKindDesc char(150),
in In_CPFBorneByER double,
in In_TaxBorneByER double,
in In_FixedAmtBorneByEE double,
in In_CompensationApprovedDate date,
in In_ExemptIncomeType char(20),
in In_ExemptIncomeAmt double,
in In_OtherAllowanceAmt double,
in In_TotalStockGainsBef double)
begin
  if exists(select* from IR8A where
      IR8A.PersonalSysID = In_PersonalSysID and
      IR8A.YEYear = In_YEYear and
      IR8A.IR8AType = In_IR8AType) then
    update IR8A set
      FormHeaderMsg = In_FormHeaderMsg,
      NSPay = In_NSPay,
      GrossTotal = In_GrossTotal,
      ContratualBonus = In_ContratualBonus,
      DirectorFee = In_DirectorFee,
      Commission = In_Commission,
      Pension = In_Pension,
      Transport = In_Transport,
      Entertainment = In_Entertainment,
      OtherAllowance = In_OtherAllowance,
      Gratuity = In_Gratuity,
      GratuityDetails = In_GratuityDetails,
      RetirementDetails = In_RetirementDetails,
      AccruedFrom = In_AccruedFrom,
      AccruedTo = In_AccruedTo,
      EROutsideContri = In_EROutsideContri,
      EROutsideContriDetails = In_EROutsideContriDetails,
      ERExcessContri = In_ERExcessContri,
      ShareAmt = In_ShareAmt,
      ShareDetails = In_ShareDetails,
      BenefitsInKind = In_BenefitsInKind,
      IncomeBorne = In_IncomeBorne,
      IncomeBorneStatus = In_IncomeBorneStatus,
      IncomeBorneDetails = In_IncomeBorneDetails,
      EECPFPension = In_EECPFPension,
      EECPF = In_EECPF,
      EEPension = In_EEPension,
      EEPensionDetails = In_EEPensionDetails,
      EEVoluntaryCPF = In_EEVoluntaryCPF,
      Donation = In_Donation,
      MOSQFund = In_MOSQFund,
      MBMF = In_MBMF,
      COMC = In_COMC,
      SINDA = In_SINDA,
      CDAC = In_CDAC,
      ECF = In_ECF,
      MOSQ = In_MOSQ,
      YMF = In_YMF,
      OtherDonation = In_OtherDonation,
      Remarks = In_Remarks,
      Insurance = In_Insurance,
      PaymentFrom = In_PaymentFrom,
      PaymentTo = In_PaymentTo,
      EEOverseasCPF = In_EEOverseasCPF,
      NonContratualBonus = In_NonContratualBonus,
      TotalSectionD = In_TotalSectionD,
      FormFooterMsg = In_FormFooterMsg,
      IR8ABenefitsInKind = In_IR8ABenefitsInKind,
      LumpSumGratuity = In_LumpSumGratuity,
      LumpSumCompensation = In_LumpSumCompensation,
      LumpSumNoticePay = In_LumpSumNoticePay,
      LumpSumExGratia = In_LumpSumExGratia,
      LumpSumOthers = In_LumpSumOthers,
      LumpSumBasis = In_LumpSumBasis,
      BenefitsInKindDesc = In_BenefitsInKindDesc,
      CPFBorneByER = In_CPFBorneByER,
      TaxBorneByER = In_TaxBorneByER,
      FixedAmtBorneByEE = In_FixedAmtBorneByEE,
      LastChangedDateTime = now(*),
      CompensationApprovedDate = In_CompensationApprovedDate,
      ExemptIncomeType = In_ExemptIncomeType,
      ExemptIncomeAmt = In_ExemptIncomeAmt,
      OtherAllowanceAmt = In_OtherAllowanceAmt,
      TotalStockGainsBef = In_TotalStockGainsBef where
      IR8A.PersonalSysID = In_PersonalSysID and
      IR8A.YEYear = In_YEYear and
      IR8A.IR8AType = In_IR8AType;
    commit work
  end if
end
;

create procedure dba.UpdateIR8S(
in In_PersonalsysId integer,
in In_Year integer,
in In_FormHeaderMsg char(100),
in In_OverseasPostFrom date,
in In_OverseasPostTo date,
in In_EEOverseasCPF double,
in In_EROverseasCPF double,
in In_CPFOverseasObligatory char(1),
in In_CPFCapping smallint,
in In_EEVolCPF double,
in In_ERVolCPF double,
in In_VolCPFObligatory char(1),
in In_PreviousBonus double,
in In_Additional char(100),
in In_SectionCRemarks char(100),
in In_DateofPRGranted date,
in In_DateofPRRenounce date,
in In_ApprovalForFullCPF char(1),
in In_CPFWageType char(1))
begin
  if exists(select* from IR8S where
      IR8S.PersonalSysId = In_PersonalsysId and
      IR8S.YEYear = In_Year) then
    update IR8S set
      IR8S.FormHeaderMsg = In_FormHeaderMsg,
      IR8S.OverseasPostFrom = In_OverseasPostFrom,
      IR8S.OverseasPostTo = In_OverseasPostTo,
      IR8S.EEOverseasCPF = In_EEOverseasCPF,
      IR8S.EROverseasCPF = In_EROverseasCPF,
      IR8S.CPFOverseasObligatory = In_CPFOverseasObligatory,
      IR8S.CPFCapping = In_CPFCapping,
      IR8S.EEVolCPF = In_EEVolCPF,
      IR8S.ERVolCPF = In_ERVolCPF,
      IR8S.VolCPFObligatory = In_VolCPFObligatory,
      IR8S.PreviousBonus = In_PreviousBonus,
      IR8S.Additional = In_Additional,
      IR8S.SectionCRemarks = In_SectionCRemarks,
      IR8S.DateofPRGranted = In_DateofPRGranted,
      IR8S.DateofPRRenounce = In_DateofPRRenounce,
      IR8S.ApprovalForFullCPF = In_ApprovalForFullCPF,
      IR8S.CPFWageType = In_CPFWageType,
      IR8S.LastChangedDateTime = now(*) where
      IR8S.PersonalSysId = In_PersonalsysId and
      IR8S.YEYear = In_Year;
    commit work
  end if
end
;

create procedure dba.UpdateIR8SA(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_IR8SOrder integer,
in In_OrdWages double,
in In_ContriOrdEECPF double,
in In_ContriOrdERCPF double,
in In_ActualOrdEECPF double,
in In_ActualOrdERCPF double,
in In_AddWages double,
in In_ContriAddEECPF double,
in In_ContriAddERCPF double,
in In_ActualAddEECPF double,
in In_ActualAddERCPF double,
in In_IR8SColDesc char(20),
in In_CurOrdinaryWage double,
in In_PrevOrdinaryWage double,
in In_CurAdditionalWage double,
in In_PrevAdditionalWage double,
in In_OverseasEECPF double,
in In_OverseasERCPF double,
in In_CPFClass char(20),
in In_CPFPeriodCapping double,
in In_CPFLessThanCapping double,
in In_CPFGreaterThanCapping double,
in In_CappedOrdWage double)
begin
  if exists(select* from IR8SA where
      IR8SA.PersonalSysId = In_PersonalSysId and
      IR8SA.YEYear = In_YEYear and
      IR8SA.IR8SOrder = In_IR8SOrder) then
    update IR8SA set
      IR8SA.OrdWages = In_OrdWages,
      IR8SA.ContriOrdEECPF = In_ContriOrdEECPF,
      IR8SA.ContriOrdERCPF = In_ContriOrdERCPF,
      IR8SA.ActualOrdEECPF = In_ActualOrdEECPF,
      IR8SA.ActualOrdERCPF = In_ActualOrdERCPF,
      IR8SA.AddWages = In_AddWages,
      IR8SA.ContriAddEECPF = In_ContriAddEECPF,
      IR8SA.ContriAddERCPF = In_ContriAddERCPF,
      IR8SA.ActualAddEECPF = In_ActualAddEECPF,
      IR8SA.ActualAddERCPF = In_ActualAddERCPF,
      IR8SA.IR8SColDesc = In_IR8SColDesc,
      IR8SA.CurOrdinaryWage = In_CurOrdinaryWage,
      IR8SA.PrevOrdinaryWage = In_PrevOrdinaryWage,
      IR8SA.CurAdditionalWage = In_CurAdditionalWage,
      IR8SA.PrevAdditionalWage = In_PrevAdditionalWage,
      IR8SA.OverseasEECPF = In_OverseasEECPF,
      IR8SA.OverseasERCPF = In_OverseasERCPF,
      IR8SA.CPFClass = In_CPFClass,
      IR8SA.CPFPeriodCapping = In_CPFPeriodCapping,
      IR8SA.CPFLessThanCapping = In_CPFLessThanCapping,
      IR8SA.CPFGreaterThanCapping = In_CPFGreaterThanCapping,
      IR8SA.CappedOrdWage = In_CappedOrdWage where
      IR8SA.PersonalSysId = In_PersonalSysId and
      IR8SA.YEYear = In_YEYear and
      IR8SA.IR8SOrder = In_IR8SOrder;
    commit work;
    update IR8S set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.UpdateIR8SC(
in In_PersonalsysId integer,
in In_Year integer,
in In_RefundSysId integer,
in In_AddWageAmt double,
in In_AddWageFrom date,
in In_AddWageTo date,
in In_AddWagePaidDate date,
in In_ERContribution double,
in In_ERInterest double,
in In_ERDate date,
in In_EEContribution double,
in In_EEInterest double,
in In_EEDate date)
begin
  if exists(select* from IR8SC where
      IR8SC.PersonalSysId = In_PersonalsysId and
      IR8SC.YEYear = In_Year and
      IR8SC.RefundSysId = In_RefundSysId) then
    update IR8SC set
      IR8SC.AddWageAmt = In_AddWageAmt,
      IR8SC.AddWageFrom = In_AddWageFrom,
      IR8SC.AddWageTo = In_AddWageTo,
      IR8SC.AddWagePaidDate = In_AddWagePaidDate,
      IR8SC.ERContribution = In_ERContribution,
      IR8SC.ERInterest = In_ERInterest,
      IR8SC.ERDate = In_ERDate,
      IR8SC.EEContribution = In_EEContribution,
      IR8SC.EEInterest = In_EEInterest,
      IR8SC.EEDate = In_EEDate where
      IR8SC.PersonalSysId = In_PersonalsysId and
      IR8SC.YEYear = In_Year and
      IR8SC.RefundSysId = In_RefundSysId;
    commit work;
    update IR8S set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_Year;
    commit work
  end if
end
;

create procedure dba.UpdateIRASNationality(
in In_EPECountryID char(20),
in In_IRASNationalityCode char(20))
begin
  if exists(select* from IRASNationality where IRASNationality.EPECountryID = In_EPECountryID) then
    update IRASNationality set
      IRASNationality.IRASNationalityCode = In_IRASNationalityCode where
      IRASNationality.EPECountryID = In_EPECountryID;
    commit work
  end if
end
;

create procedure dba.UpdateYEEmployee(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_CurrentYEGlobalId char(20),
in In_YEEmployerId char(20),
in In_TaxNo char(20),
in In_Designation char(20),
in In_EEAddress1 char(30),
in In_EEAddress2 char(30),
in In_EEAddress3 char(30),
in In_EEAddress4 char(30),
in In_PostalCode char(6),
in In_EEAddressType char(20),
in In_EEAddressCountry char(20),
in In_EEName1 char(35),
in In_EEName2 char(35),
in In_EEName3 char(10),
in In_DOB date,
in In_Commencement date,
in In_Cessation date,
in In_IRASSection45 char(1),
in In_IR8SIndicator char(1),
in In_A8AIndicator char(1),
in In_Flag100K char(1),
in In_FlagPercentOrdWage char(1)
,in In_FlagOverseasCPF char(1),
in In_FlagExcessCPF char(1),
in In_IRASNationalityCode char(20),
in In_PayeeIDType char(1),
in In_CessationProvision char(1),
in In_Gender char(1),
in In_MaritalStatusDesc char(50),
in In_SupYEGlobalId char(20),
in In_IR21Indicator char(1))
begin
  if exists(select* from YEEmployee where
      YEEmployee.PersonalSysID = In_PersonalSysID and
      YEEmployee.YEYear = In_YEYear) then
    update YEEmployee set
      CurrentYEGlobalId = In_CurrentYEGlobalId,
      YEEmployerId = In_YEEmployerId,
      TaxNo = In_TaxNo,
      Designation = In_Designation,
      EEAddress1 = In_EEAddress1,
      EEAddress2 = In_EEAddress2,
      EEAddress3 = In_EEAddress3,
      EEAddress4 = In_EEAddress4,
      PostalCode = In_PostalCode,
      EEAddressType = In_EEAddressType,
      EEAddressCountry = In_EEAddressCountry,
      EEName1 = In_EEName1,
      EEName2 = In_EEName2,
      EEName3 = In_EEName3,
      DOB = In_DOB,
      Commencement = In_Commencement,
      Cessation = In_Cessation,
      IRASSection45 = In_IRASSection45,
      IR8SIndicator = In_IR8SIndicator,
      A8AIndicator = In_A8AIndicator,
      Flag100K = In_Flag100K,
      FlagPercentOrdWage = In_FlagPercentOrdWage,
      FlagOverseasCPF = In_FlagOverseasCPF,
      FlagExcessCPF = In_FlagExcessCPF,
      IRASNationalityCode = In_IRASNationalityCode,
      PayeeIDType = In_PayeeIDType,
      CessationProvision = In_CessationProvision,
      Gender = In_Gender,
      MaritalStatusDesc = In_MaritalStatusDesc,
      SupYEGlobalId = In_SupYEGlobalId,
      IR21Indicator = In_IR21Indicator,
      LastChangedDateTime = now(*) where
      YEEmployee.PersonalSysID = In_PersonalSysID and
      YEEmployee.YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.UpdateYEEmployer(
in In_YEEmployerID char(20),
in In_YEEmployerDesc char(100),
in In_TaxRefNo char(20),
in In_TelephoneNo char(20),
in In_ERName1 char(35),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_AuthorisedName char(60),
in In_DeclaredDate date,
in In_Designation char(27),
in In_EmployerSource char(20),
in In_PayerId char(20),
in In_ERName2 char(35),
in In_IsAutoInclusion smallint,
in In_DivisionBranch char(100),
in In_EmailAddress char(100),
in In_HandphonePagerNo char(20),
in In_ContactPerson char(60),
in In_FaxNo char(20))
begin
  if exists(select* from YEEmployer where YEEmployer.YEEmployerID = In_YEEmployerID) then
    update YEEmployer set
      YEEmployer.YEEmployerID = In_YEEmployerID,
      YEEmployer.YEEmployerDesc = In_YEEmployerDesc,
      YEEmployer.TaxRefNo = In_TaxRefNo,
      YEEmployer.TelephoneNo = In_TelephoneNo,
      YEEmployer.ERName1 = In_ERName1,
      YEEmployer.DivisionBranch = In_DivisionBranch,
      YEEmployer.Address1 = In_Address1,
      YEEmployer.Address2 = In_Address2,
      YEEmployer.Address3 = In_Address3,
      YEEmployer.AuthorisedName = In_AuthorisedName,
      YEEmployer.DeclaredDate = In_DeclaredDate,
      YEEmployer.Designation = In_Designation,
      YEEmployer.EmailAddress = In_EmailAddress,
      YEEmployer.EmployerSource = In_EmployerSource,
      YEEmployer.PayerId = In_PayerId,
      YEEmployer.ERName2 = In_ERName2,
      YEEmployer.IsAutoInclusion = In_IsAutoInclusion,
      YEEmployer.HandphonePagerNo = In_HandphonePagerNo,
      YEEmployer.ContactPerson = In_ContactPerson,
      YEEmployer.FaxNo = In_FaxNo where
      YEEmployer.YEEmployerID = In_YEEmployerID;
    update YEEmployee set LastChangedDateTime = now(*) where YEEmployerId = In_YEEmployerID;
    commit work
  end if
end
;

create procedure dba.UpdateYEGlobal(
in In_YEGlobalID char(20),
in In_YEGlobalDesc char(100),
in In_BonusDeclared date,
in In_DirFeeApproved date,
in In_CommissionFrom date,
in In_CommissionTo date,
in In_CommissionStatus char(20),
in In_DirFeeFrom date,
in In_DirFeeTo date,
in In_AddEndPeriod integer,
in In_SupStartPeriod integer,
in In_AddCPFOption smallint,
in In_SupCPFOption smallint,
in In_CPFTaxableStatus smallint)
begin
  if exists(select* from YEGlobal where YEGlobal.YEGlobalID = In_YEGlobalID) then
    update YEGlobal set
      YEGlobal.YEGlobalID = In_YEGlobalID,
      YEGlobal.YEGlobalDesc = In_YEGlobalDesc,
      YEGlobal.BonusDeclared = In_BonusDeclared,
      YEGlobal.DirFeeApproved = In_DirFeeApproved,
      YEGlobal.CommissionFrom = In_CommissionFrom,
      YEGlobal.CommissionTo = In_CommissionTo,
      YEGlobal.CommissionStatus = In_CommissionStatus,
      YEGlobal.DirFeeFrom = In_DirFeeFrom,
      YEGlobal.DirFeeTo = In_DirFeeTo,
      YEGlobal.AddEndPeriod = In_AddEndPeriod,
      YEGlobal.SupStartPeriod = In_SupStartPeriod,
      YEGlobal.AddCPFOption = In_AddCPFOption,
      YEGlobal.SupCPFOption = In_SupCPFOption,
      YEGlobal.CPFTaxableStatus = In_CPFTaxableStatus where
      YEGlobal.YEGlobalID = In_YEGlobalID;
    commit work
  end if
end
;

create procedure dba.UpdateYERecord(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_YERecordType char(20),
in In_Status char(20),
in In_LastProcessed timestamp)
begin
  if exists(select* from YERecord where
      PersonalSysId = In_PersonalsysId and
      YEYear = In_YEYear and
      YERecordType = In_YERecordType) then
    update YERecord set
      PersonalSysId = In_PersonalSysId,
      YEYear = In_YEYear,
      YERecordType = In_YERecordType,
      Status = In_Status,
      LastProcessed = In_LastProcessed where
      PersonalSysId = In_PersonalsysId and
      YEYear = In_YEYear and
      YERecordType = In_YERecordType;
    commit work
  end if
end
;


create function DBA.FGetYEOverseasCPFAmount(
in In_PersonalSysID integer,
in In_YEYear integer)
returns double
begin
  declare Out_OverseasCPFAmount double;
  select sum(OverseasEECPF+OverseasERCPF) into Out_OverseasCPFAmount
    from EmploymentHistory join PeriodPolicySummary on
    EmploymentHistory.YEEmployeeSysId = PeriodPolicySummary.EmployeeSysId where
    PayRecYear = In_YEYear and
    PersonalSysID = In_PersonalSysID;
  if Out_OverseasCPFAmount is null then set Out_OverseasCPFAmount=0
  end if;
  return Out_OverseasCPFAmount
end
;

create function dba.IsYEPeriodOverseas(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer)
returns smallint
begin
  declare TotalOverseas double;
  select OverseasEECPF+OverseasERCPF into TotalOverseas from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod;
  if(TotalOverseas <> 0) then return 1
  end if;
  return 0
end
;

create function DBA.IsCPFProgExists(
in In_EmployeeSysId integer,
in In_Ref_CPFEffectiveDate date)
returns smallint
begin
  declare Out_CPFEffectiveDate date;
  select max(CPFEffectiveDate) into Out_CPFEffectiveDate from CPFProgression where EmployeeSysId = In_EmployeeSysId and
    CPFEffectiveDate < In_Ref_CPFEffectiveDate;
  if exists(select* from CPFProgression where CPFProgression.EmployeeSysId = In_EmployeeSysId and
      CPFEffectiveDate = Out_CPFEffectiveDate and CPFProgPolicyId <> '' and CPFProgSchemeId <> '') then
    return 1
  end if;
  return 0
end
;

create function DBA.FGetCasRecordDailyWage(
in In_CasualSGSPGenId char(30))
returns double
begin
  declare Out_DailyWage double;
  select(CasRecord.NoOfHour*CasRecord.HourRate) into Out_DailyWage
    from CasRecord where
    CasRecord.CasualSGSPGenId = In_CasualSGSPGenId;
  set Out_DailyWage=Round(Out_DailyWage,FGetDBPayDecimal(*));
  return(Out_DailyWage)
end
;

create function DBA.FGetCasRecordTotalDailyWage(
in In_CasualSGSPGenId char(30))
returns double
begin
  declare Out_TotalDailyWage double;
  declare Out_TotalAllowanceAmt double;
  select Sum(CasAllowance.AllowanceAmount) into Out_TotalAllowanceAmt
    from CasAllowance where
    CasAllowance.CasualSGSPGenId = In_CasualSGSPGenId
    group by CasAllowance.CasualSGSPGenId;
  if Out_TotalAllowanceAmt is null then set Out_TotalAllowanceAmt=0
  end if;
  set Out_TotalDailyWage=Round(FGetCasRecordDailyWage(In_CasualSGSPGenId)+Out_TotalAllowanceAmt,FGetDBPayDecimal(*));
  return(Out_TotalDailyWage)
end
;

create function DBA.FGetCasRecordCurAdditionalWage(
in In_CasualSGSPGenId char(30))
returns double
begin
  declare Out_CurAdditionalWage double;
  declare valid_cpf smallint;
  set Out_CurAdditionalWage=0;
  select IsCPFProgExists(CasRecord.EmployeeSysId,CasRecord.CasualPayrollDate) into valid_cpf
    from CasRecord where CasRecord.CasualSGSPGenId = In_CasualSGSPGenId;
  if(valid_cpf > 0) then
    select SUM(CasAllowance.AllowanceAmount) into Out_CurAdditionalWage
      from CasAllowance join Formula on CasAllowance.AllowanceFormulaId = Formula.FormulaId where
      FormulaCategory = 'PayElement' and(IsFormulaIdHasProperty(AllowanceFormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjOrdinary') = 0) and CasAllowance.CasualSGSPGenId = In_CasualSGSPGenId
      group by CasAllowance.CasualSGSPGenId;
    set Out_CurAdditionalWage=Round(Out_CurAdditionalWage,FGetDBPayDecimal(*))
  end if;
  return(Out_CurAdditionalWage)
end
;

create function DBA.FGetCasRecordCurOrdinaryWage(
in In_CasualSGSPGenId char(30))
returns double
begin
  declare Out_CurOrdinaryWage double;
  declare Out_DaliyWage double;
  declare valid_cpf smallint;
  set Out_CurOrdinaryWage=0;
  select IsCPFProgExists(CasRecord.EmployeeSysId,CasRecord.CasualPayrollDate) into valid_cpf
    from CasRecord where CasRecord.CasualSGSPGenId = In_CasualSGSPGenId;
  select FGetCasRecordDailyWage(In_CasualSGSPGenId) into Out_DaliyWage;
  if(valid_cpf > 0) then
    select SUM(CasAllowance.AllowanceAmount) into Out_CurOrdinaryWage
      from CasAllowance join Formula on CasAllowance.AllowanceFormulaId = Formula.FormulaId where
      FormulaCategory = 'PayElement' and(IsFormulaIdHasProperty(AllowanceFormulaId,'SubjAdditional') = 0 and
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjOrdinary') = 1) and CasAllowance.CasualSGSPGenId = In_CasualSGSPGenId
      group by CasAllowance.CasualSGSPGenId;
    set Out_CurOrdinaryWage=Round(Out_CurOrdinaryWage+Out_DaliyWage,FGetDBPayDecimal(*))
  end if;
  return(Out_CurOrdinaryWage)
end
;

create function DBA.FGetCasRecordNonCPFWage(
in In_CasualSGSPGenId char(30))
returns double
begin
  declare Out_NonCPFWage double;
  set Out_NonCPFWage=FGetCasRecordTotalDailyWage(In_CasualSGSPGenId)-(FGetCasRecordCurOrdinaryWage(In_CasualSGSPGenId)+FGetCasRecordCurAdditionalWage(In_CasualSGSPGenId));
  return(Out_NonCPFWage)
end
;

create procedure DBA.ASQLUpdateCasRecord(
in In_CasualSGSPGenId char(30),
out Out_Error integer)
begin
  declare Out_DailyWage double;
  declare Out_TotalDailyWage double;
  declare Out_CurOrdinaryWage double;
  declare Out_CurAdditionalWage double;
  declare Out_NonCPFWagee double;
  set Out_Error=0;
  set Out_DailyWage=FGetCasRecordDailyWage(In_CasualSGSPGenId);
  set Out_TotalDailyWage=FGetCasRecordTotalDailyWage(In_CasualSGSPGenId);
  set Out_CurOrdinaryWage=FGetCasRecordCurOrdinaryWage(In_CasualSGSPGenId);
  set Out_CurAdditionalWage=FGetCasRecordCurAdditionalWage(In_CasualSGSPGenId);
  set Out_NonCPFWagee=FGetCasRecordNonCPFWage(In_CasualSGSPGenId);
  /*
  Check Record exists
  */
  if exists(select* from CasRecord where
      CasualSGSPGenId = In_CasualSGSPGenId) then
    update CasRecord set
      DailyWage = Out_DailyWage,
      TotalDailyWage = Out_TotalDailyWage,
      CurOrdinaryWage = Out_CurOrdinaryWage,
      CurAdditionalWage = Out_CurAdditionalWage,
      NonCPFWage = Out_NonCPFWagee where
      CasualSGSPGenId = In_CasualSGSPGenId;
    commit work;
    set Out_Error=1
  end if
end
;

create function DBA.FGetCasualBasis()
returns char(100)
begin
  declare Out_RegProperty1 char(100);
  declare Out_RegProperty5 char(100);
  select RegProperty1 into Out_RegProperty1 from subregistry where RegistryId = 'MapAutomationBasis' and
    SubRegistryId = 'MapCasualBasis';
  select RegProperty5 into Out_RegProperty5 from subregistry where RegistryId = 'ItemBasis' and
    SubRegistryId = Out_RegProperty1;
  return Out_RegProperty5
end
;

create function DBA.FGetCasualBasisUserDefinedName()
returns char(100)
begin
  declare Out_RegProperty1 char(100);
  declare Out_ShortStringAttr char(100);
  select RegProperty1 into Out_RegProperty1 from subregistry where RegistryId = 'MapAutomationBasis' and
    SubRegistryId = 'MapCasualBasis';
  select ShortStringAttr into Out_ShortStringAttr from subregistry where RegistryId = 'ItemBasis' and
    SubRegistryId = Out_RegProperty1;
  return Out_ShortStringAttr
end
;

create procedure dba.InsertNewCasRecord(
in In_EmployeeSysId integer,
in In_CasualBatchNo char(20),
in In_CasualWorkingDate date,
in In_CasualPayrollDate date,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_RefNo char(50),
in In_CasualRecBasis char(20),
in In_HourRate double,
in In_NoOfHour double,
in In_Remarks char(100),
in In_DailyWage double,
in In_TotalDailyWage double,
in In_CurOrdinaryWage double,
in In_CurAdditionalWage double,
in In_NonCPFWage double,
in In_CasualPayment integer,
out Out_CasualSGSPGenId char(30))
begin
  select FGetNewSGSPGeneratedIndex('CasRecord') into Out_CasualSGSPGenId;
  insert into CasRecord(CasualSGSPGenId,
    EmployeeSysId,
    CasualBatchNo,
    CasualWorkingDate,
    CasualPayrollDate,
    PayRecYear,
    PayRecPeriod,
    PayRecSubPeriod,
    RefNo,
    CasualRecBasis,
    HourRate,
    NoOfHour,
    Remarks,
    DailyWage,
    TotalDailyWage,
    CurOrdinaryWage,
    CurAdditionalWage,
    NonCPFWage,
    CasualPayment) values(
    Out_CasualSGSPGenId,
    In_EmployeeSysId,
    In_CasualBatchNo,
    In_CasualWorkingDate,
    In_CasualPayrollDate,
    In_PayRecYear,
    In_PayRecPeriod,
    In_PayRecSubPeriod,
    In_RefNo,
    In_CasualRecBasis,
    In_HourRate,
    In_NoOfHour,
    In_Remarks,
    In_DailyWage,
    In_TotalDailyWage,
    In_CurOrdinaryWage,
    In_CurAdditionalWage,
    In_NonCPFWage,
    In_CasualPayment);
  commit work
end
;

create procedure dba.UpdateCasRecord(
in In_CasualSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_CasualBatchNo char(20),
in In_CasualWorkingDate date,
in In_CasualPayrollDate date,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_RefNo char(50),
in In_CasualRecBasis char(20),
in In_HourRate double,
in In_NoOfHour double,
in In_Remarks char(100),
in In_DailyWage double,
in In_TotalDailyWage double,
in In_CurOrdinaryWage double,
in In_CurAdditionalWage double,
in In_NonCPFWage double,
in In_CasualPayment integer)
begin
  if exists(select* from CasRecord where
      CasRecord.CasualSGSPGenId = In_CasualSGSPGenId) then
    update CasRecord set
      CasualSGSPGenId = In_CasualSGSPGenId,
      EmployeeSysId = In_EmployeeSysId,
      CasualBatchNo = In_CasualBatchNo,
      CasualWorkingDate = In_CasualWorkingDate,
      CasualPayrollDate = In_CasualPayrollDate,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      RefNo = In_RefNo,
      CasualRecBasis = In_CasualRecBasis,
      HourRate = In_HourRate,
      NoOfHour = In_NoOfHour,
      Remarks = In_Remarks,
      DailyWage = In_DailyWage,
      TotalDailyWage = In_TotalDailyWage,
      CurOrdinaryWage = In_CurOrdinaryWage,
      CurAdditionalWage = In_CurAdditionalWage,
      NonCPFWage = In_NonCPFWage,
      CasualPayment = In_CasualPayment where
      CasRecord.CasualSGSPGenId = In_CasualSGSPGenId;
    commit work
  end if
end
;

create procedure dba.DeleteCasRecord(
in In_CasualSGSPGenId char(30))
begin
  if exists(select* from CasRecord where
      CasRecord.CasualSGSPGenId = In_CasualSGSPGenId) then
    delete from CasDistribute where
      CasDistribute.CasualSGSPGenId = In_CasualSGSPGenId;
    delete from CasAllowance where
      CasAllowance.CasualSGSPGenId = In_CasualSGSPGenId;
    delete from CasRecord where
      CasRecord.CasualSGSPGenId = In_CasualSGSPGenId;
    commit work
  end if
end
;

create function DBA.FGetCasRecordTotalDailyWageByEmp(
in In_EmployeeSysId integer,
in In_CasualRecBasis char(20),
in In_FromDate date,
in In_ToDate date)
returns double
begin
  declare Out_TotalDailyWage double;
  select SUM(TotalDailyWage) into Out_TotalDailyWage
    from CasRecord where
    EmployeeSysId = In_EmployeeSysId and
    CasualRecBasis = In_CasualRecBasis and
    CasualWorkingDate between In_FromDate and In_ToDate;
  if Out_TotalDailyWage is null then set Out_TotalDailyWage=0
  end if;
  return(Out_TotalDailyWage)
end
;

create function DBA.FGetCasRecordTotalNoOfHoursByEmp(
in In_EmployeeSysId integer,
in In_CasualRecBasis char(20),
in In_FromDate date,
in In_ToDate date)
returns double
begin
  declare Out_TotalNoOfHours double;
  select SUM(NoOfHour) into Out_TotalNoOfHours
    from CasRecord where
    EmployeeSysId = In_EmployeeSysId and
    CasualRecBasis = In_CasualRecBasis and
    CasualWorkingDate between In_FromDate and In_ToDate;
  if Out_TotalNoOfHours is null then set Out_TotalNoOfHours=0
  end if;
  return(Out_TotalNoOfHours)
end
;

create function dba.FGetCasualBatchDesc(
in In_CasualBatchNo char(20))
returns char(150)
begin
  declare Out_CasualBatchDesc char(150);
  select Description into Out_CasualBatchDesc from CasBatchNo where CasualBatchNo = In_CasualBatchNo;
  return(Out_CasualBatchDesc)
end
;

create procedure DBA.ASQLUpdateCasDistribute(
in In_CasualSGSPGenId char(30),
in In_CasDistributeId char(20),
in In_CasDistributeAmount double)
begin
  if exists(select* from CasDistribute where CasualSGSPGenId = In_CasualSGSPGenId and
      CasDistributeId = In_CasDistributeId) then
    update CasDistribute set
      CasDistributeAmount = In_CasDistributeAmount where
      CasualSGSPGenId = In_CasualSGSPGenId and
      CasDistributeId = In_CasDistributeId
  else
    insert into CasDistribute(CasualSGSPGenId,CasDistributeId,CasDistributeAmount) values(
      In_CasualSGSPGenId,In_CasDistributeId,In_CasDistributeAmount)
  end if;
  commit work
end
;

create procedure DBA.ASQLCasPayCPFWage(
in In_EmployeeSysId char(20),
in In_PayrollStartDate date,
in In_PayrollEndDate date)
begin
  declare Out_OrdAllowance double;
  declare Out_AddAllowance double;
  /*
  Get Casual Records within Payroll Date and Update its Ordinary and Additional Wages
  */
  CasualRecLoop: for CasualRecFor as curs dynamic scroll cursor for
    select CasualSGSPGenId as Out_GenId,DailyWage as Out_DailyWage,TotalDailyWage as Out_TotalDailyWage from CasRecord where
      EmployeeSysId = In_EmployeeSysId and
      CasualPayrollDate between In_PayrollStartDate and In_PayrollEndDate do
    select Sum(AllowanceAmount) into Out_OrdAllowance from CasAllowance where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjOrdinary') = 1 and
      CasualSGSPGenId = Out_GenId;
    select Sum(AllowanceAmount) into Out_AddAllowance from CasAllowance where
      IsFormulaIdHasProperty(AllowanceFormulaId,'SubjAdditional') = 1 and
      CasualSGSPGenId = Out_GenId;
    if(Out_OrdAllowance is null) then set Out_OrdAllowance=0
    end if;
    if(Out_AddAllowance is null) then set Out_AddAllowance=0
    end if;
    update CasRecord set
      CurOrdinaryWage = Out_OrdAllowance+Out_DailyWage,
      CurAdditionalWage = Out_AddAllowance,
      NonCPFWage = Out_TotalDailyWage-CurOrdinaryWage-CurAdditionalWage where current of curs end for
end
;

create function DBA.FGetYEEmployerId(
in In_PersonalSysId integer,
in In_YEYear integer)
returns char(20)
begin
  declare Out_YEEmployerId char(20);
  select YEEmployerId into Out_YEEmployerId
    from YEEmployee where
    YEYear = In_YEYear and
    PersonalSysId = In_PersonalSysId;
  return Out_YEEmployerId
end
;

create function dba.IsRecordUpdatedA8A(
in In_PersonalSysId integer,
in In_YEYear integer)
returns smallint
begin
  declare OriginalDateTime timestamp;
  declare AmendmentDateTime timestamp;
  declare Out_Result smallint;
  if(IsRecordUpdatedYEEmployee(In_PersonalSysId,In_YEYear) = 1) then
    set Out_Result=1
  else
    if exists(select* from A8A where
        PersonalSysId = In_PersonalSysId and YEYear = In_YEYear) then
      if exists(select* from A8A where
          PersonalSysId = In_PersonalSysId and YEYear = 90000+In_YEYear) then
        select LastChangedDateTime into OriginalDateTime
          from A8A where
          PersonalSysId = In_PersonalSysId and
          YEYear = In_YEYear;
        select LastChangedDateTime into AmendmentDateTime
          from A8A where
          PersonalSysId = In_PersonalSysId and
          YEYear = 90000+In_YEYear;
        if OriginalDateTime <> AmendmentDateTime then
          set Out_Result=1
        else
          set Out_Result=0
        end if
      else
        set Out_Result=1
      end if
    else
      if exists(select* from A8A where
          PersonalSysId = In_PersonalSysId and YEYear = 90000+In_YEYear) then
        set Out_Result=1
      else
        set Out_Result=0
      end if
    end if
  end if;
  return Out_Result
end
;

create function dba.IsRecordUpdatedA8B(
in In_PersonalSysId integer,
in In_YEYear integer)
returns smallint
begin
  declare OriginalDateTime timestamp;
  declare AmendmentDateTime timestamp;
  declare Out_Result smallint;
  if(IsRecordUpdatedYEEmployee(In_PersonalSysId,In_YEYear) = 1) then
    set Out_Result=1
  else
    if exists(select* from A8B where
        PersonalSysId = In_PersonalSysId and YEYear = In_YEYear) then
      if exists(select* from A8B where
          PersonalSysId = In_PersonalSysId and YEYear = 90000+In_YEYear) then
        select LastChangedDateTime into OriginalDateTime
          from A8B where
          PersonalSysId = In_PersonalSysId and
          YEYear = In_YEYear;
        select LastChangedDateTime into AmendmentDateTime
          from A8B where
          PersonalSysId = In_PersonalSysId and
          YEYear = 90000+In_YEYear;
        if OriginalDateTime <> AmendmentDateTime then
          set Out_Result=1
        else
          set Out_Result=0
        end if
      else
        set Out_Result=1
      end if
    else
      if exists(select* from A8B where
          PersonalSysId = In_PersonalSysId and YEYear = 90000+In_YEYear) then
        set Out_Result=1
      else
        set Out_Result=0
      end if
    end if
  end if;
  return Out_Result
end
;

create function dba.IsRecordUpdatedIR8A(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_IR8AType char(20))
returns smallint
begin
  declare OriginalDateTime timestamp;
  declare AmendmentDateTime timestamp;
  declare Out_Result smallint;
  if(IsRecordUpdatedYEEmployee(In_PersonalSysId,In_YEYear) = 1) then
    set Out_Result=1
  else
    if exists(select* from IR8A where
        PersonalSysId = In_PersonalSysId and YEYear = In_YEYear and IR8AType = In_IR8AType) then
      if exists(select* from IR8A where
          PersonalSysId = In_PersonalSysId and YEYear = 90000+In_YEYear and IR8AType = In_IR8AType) then
        select LastChangedDateTime into OriginalDateTime
          from IR8A where
          PersonalSysId = In_PersonalSysId and
          YEYear = In_YEYear and
          IR8AType = In_IR8AType;
        select LastChangedDateTime into AmendmentDateTime
          from IR8A where
          PersonalSysId = In_PersonalSysId and
          YEYear = 90000+In_YEYear and
          IR8AType = In_IR8AType;
        if OriginalDateTime <> AmendmentDateTime then
          set Out_Result=1
        else
          set Out_Result=0
        end if
      else
        set Out_Result=1
      end if
    else
      if exists(select* from IR8A where
          PersonalSysId = In_PersonalSysId and YEYear = 90000+In_YEYear and IR8AType = In_IR8AType) then
        set Out_Result=1
      else
        set Out_Result=0
      end if
    end if
  end if;
  return Out_Result
end
;

create function dba.IsRecordUpdatedIR8S(
in In_PersonalSysId integer,
in In_YEYear integer)
returns smallint
begin
  declare OriginalDateTime timestamp;
  declare AmendmentDateTime timestamp;
  declare Out_Result smallint;
  if(IsRecordUpdatedYEEmployee(In_PersonalSysId,In_YEYear) = 1) then
    set Out_Result=1
  else
    if exists(select* from IR8S where
        PersonalSysId = In_PersonalSysId and YEYear = In_YEYear) then
      if exists(select* from IR8S where
          PersonalSysId = In_PersonalSysId and YEYear = 90000+In_YEYear) then
        select LastChangedDateTime into OriginalDateTime
          from IR8S where
          PersonalSysId = In_PersonalSysId and
          YEYear = In_YEYear;
        select LastChangedDateTime into AmendmentDateTime
          from IR8S where
          PersonalSysId = In_PersonalSysId and
          YEYear = 90000+In_YEYear;
        if OriginalDateTime <> AmendmentDateTime then
          set Out_Result=1
        else
          set Out_Result=0
        end if
      else
        set Out_Result=1
      end if
    else
      if exists(select* from IR8S where
          PersonalSysId = In_PersonalSysId and YEYear = 90000+In_YEYear) then
        set Out_Result=1
      else
        set Out_Result=0
      end if
    end if
  end if;
  return Out_Result
end
;

create function dba.IsRecordUpdatedYEEmployee(
in In_PersonalSysId integer,
in In_YEYear integer)
returns smallint
begin
  declare OriginalDateTime timestamp;
  declare AmendmentDateTime timestamp;
  declare Out_Result smallint;
  if exists(select* from YEEmployee where
      PersonalSysId = In_PersonalSysId and YEYear = In_YEYear) then
    if exists(select* from YEEmployee where
        PersonalSysId = In_PersonalSysId and YEYear = 90000+In_YEYear) then
      select LastChangedDateTime into OriginalDateTime
        from YEEmployee where
        PersonalSysId = In_PersonalSysId and
        YEYear = In_YEYear;
      select LastChangedDateTime into AmendmentDateTime
        from YEEmployee where
        PersonalSysId = In_PersonalSysId and
        YEYear = 90000+In_YEYear;
      if OriginalDateTime <> AmendmentDateTime then
        set Out_Result=1
      else
        set Out_Result=0
      end if
    else
      set Out_Result=1
    end if
  else
    if exists(select* from YEEmployee where
        PersonalSysId = In_PersonalSysId and YEYear = 90000+In_YEYear) then
      set Out_Result=1
    else
      set Out_Result=0
    end if
  end if;
  return Out_Result
end
;

create function dba.FGetA8AS3C1Value(
in In_PersonalSysId integer,
in In_YEYear integer)
returns double
begin
  declare Out_ValueResult double;
  declare AnnTotalWage double;
  declare C1Percent double;
  declare StartDate date;
  declare EndDate date;
  declare OccDays double;
  set AnnTotalWage=0;
  set C1Percent=0;
  set Out_ValueResult=0;
  //
  // Compute C1 Value
  //
  //
  // 2% X GrossTotal X OccupationDays(A8AS3.Sec3Period where A8AS3.Sec3No = 'A1')
  //    ---------------
  //      365 or 366(leap year)
  //
  //
  // Get Annual Total Wage 
  // 
  select GrossTotal into AnnTotalWage from IR8A where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear and IR8AType = 'CurIR8A';
  if AnnTotalWage is null then
    set AnnTotalWage=0
  end if;
  //
  // Get A8A
  //
  select Sec3Period into OccDays from A8AS3 where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear and Sec3No = 'A1';
  //
  // Get Year Days
  //
  select(cast(In_YEYear as char(4))+'-01-01'),(cast(In_YEYear+1 as char(4))+'-01-01') into StartDate,EndDate;
  //
  // Get C1 Percent
  //
  select YEProperty6 into C1Percent from YEKeyword where YEKeywordId = 'Plus2%';
  //
  // Compute C1 Value
  //
  set Out_ValueResult=ROUND(C1Percent/100.0*OccDays/Days(StartDate,EndDate)*AnnTotalWage,2);
  if Out_ValueResult is null then
    return(0)
  end if;
  return(Out_ValueResult)
end
;

create function DBA.FGetIRASEmployeeBank(
in In_EmployeeSysId integer)
returns char(1)
begin
  declare Out_IRASEmployeeBank char(1);
  declare Out_BankId char(20);
  select first BankId into Out_BankId from PaymentBankInfo where EmployeeSysId = In_EmployeeSysId order by PaymentValue desc;
  case Out_BankId when '7171' then
    set Out_IRASEmployeeBank='1' when '7348' then
    set Out_IRASEmployeeBank='2' when '7375' then
    set Out_IRASEmployeeBank='2' when '7339' then
    set Out_IRASEmployeeBank='3'
  else
    set Out_IRASEmployeeBank='4'
  end case
  ;
  return(Out_IRASEmployeeBank)
end
;

create function DBA.FGetIR21Indicator(
in In_PersonalSysId integer,
in In_YEYear integer)
returns char(1)
begin
  declare Out_IR21Indicator char(20);
  select IR21Indicator into Out_IR21Indicator
    from YEEmployee where
    YEYear = In_YEYear and
    PersonalSysId = In_PersonalSysId;
  return Out_IR21Indicator
end
;

create function DBA.FGetEmployeeFirstBankId(
in In_EmployeeSysId integer)
returns char(20)
begin
  declare Out_BankId char(20);
  select first BankId into Out_BankId from PaymentBankInfo where EmployeeSysId = In_EmployeeSysId order by PaymentValue desc;
  return(Out_BankId)
end
;

create function DBA.FGetTimeSheetCurAdditionalWage(
in In_TMSSGSPGenId char(30))
returns double
begin
  declare CurAdditionalWage double;
  declare Out_CurAdditionalWage double;
  set CurAdditionalWage=0;
  set Out_CurAdditionalWage=0;
  if(IsWageElementInUsed('SubjAdditional','AddWage') = 1) then
    /*
    Pay Element
    */
    select SUM(CostingAmount) into CurAdditionalWage
      from TMSAllowance where
      IsFormulaIdHasProperty(FormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(FormulaId,'PreviousRateCPF') = 0 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if CurAdditionalWage is not null then
      set Out_CurAdditionalWage=Out_CurAdditionalWage+CurAdditionalWage;
      message '   Pay Element : '+cast(CurAdditionalWage as char(20)) type info to client
    end if;
    /*
    OT Amount
    */
    select Sum(CurrentCostingAmt)+Sum(LastOTCostingAmt)+Sum(BackPayOTCostingAmt) into CurAdditionalWage
      from TMSOvertime where
      IsFormulaIdHasProperty(FormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(FormulaId,'PreviousRateCPF') = 0 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if CurAdditionalWage is not null then
      set Out_CurAdditionalWage=Out_CurAdditionalWage+CurAdditionalWage;
      message '   OT : '+cast(CurAdditionalWage as char(20)) type info to client
    end if;
    /*
    Shift Amount
    */
    select Sum(CostingAmount) into CurAdditionalWage from
      TMSShift where
      IsFormulaIdHasProperty(FormulaId,'SubjAdditional') = 1 and
      IsFormulaIdHasProperty(FormulaId,'PreviousRateCPF') = 0 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if CurAdditionalWage is not null then
      set Out_CurAdditionalWage=Out_CurAdditionalWage+CurAdditionalWage;
      message '   Shift : '+cast(CurAdditionalWage as char(20)) type info to client
    end if
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt','AddWage') = 1) then
    select Sum(CurrentCostingAmt)+Sum(PreviousCostingAmt) into CurAdditionalWage
      from TMSLeaveDeduction where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if CurAdditionalWage is not null then
      set Out_CurAdditionalWage=Out_CurAdditionalWage+CurAdditionalWage;
      message '   Leave Deduction : '+cast(CurAdditionalWage as char(20)) type info to client
    end if
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay','AddWage') = 1) then
    select Sum(BackPayCostingAmt) into CurAdditionalWage
      from TMSDetail where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if CurAdditionalWage is not null then
      set Out_CurAdditionalWage=Out_CurAdditionalWage+CurAdditionalWage;
      message '   Back Pay : '+cast(CurAdditionalWage as char(20)) type info to client
    end if
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage','AddWage') = 1) then
    select Sum(BasicRateCostingAmt) into CurAdditionalWage
      from TMSDetail where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if CurAdditionalWage is not null then
      set Out_CurAdditionalWage=Out_CurAdditionalWage+CurAdditionalWage;
      message '   Total Wage : '+cast(CurAdditionalWage as char(20)) type info to client
    end if
  end if;
  message '   Total Wage : '+cast(Out_CurAdditionalWage as char(20)) type info to client;
  return(Out_CurAdditionalWage)
end
;

create function DBA.FGetTimeSheetCurOrdinaryWage(
in In_TMSSGSPGenId char(30))
returns double
begin
  declare CurOrdinaryWage double;
  declare Out_CurOrdinaryWage double;
  set CurOrdinaryWage=0;
  set Out_CurOrdinaryWage=0;
  if(IsWageElementInUsed('SubjOrdinary','OrdWage') = 1) then
    /*
    Pay Element
    */
    select SUM(CostingAmount) into CurOrdinaryWage
      from TMSAllowance where
      IsFormulaIdHasProperty(FormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(FormulaId,'PreviousRateCPF') = 0 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if CurOrdinaryWage is not null then
      set Out_CurOrdinaryWage=Out_CurOrdinaryWage+CurOrdinaryWage;
      message '   Pay Element : '+cast(CurOrdinaryWage as char(20)) type info to client
    end if;
    /*
    OT Amount
    */
    select Sum(CurrentCostingAmt)+Sum(LastOTCostingAmt)+Sum(BackPayOTCostingAmt) into CurOrdinaryWage
      from TMSOvertime where
      IsFormulaIdHasProperty(FormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(FormulaId,'PreviousRateCPF') = 0 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if CurOrdinaryWage is not null then
      set Out_CurOrdinaryWage=Out_CurOrdinaryWage+CurOrdinaryWage;
      message '   OT : '+cast(CurOrdinaryWage as char(20)) type info to client
    end if;
    /*
    Shift Amount
    */
    select Sum(CostingAmount) into CurOrdinaryWage from
      TMSShift where
      IsFormulaIdHasProperty(FormulaId,'SubjOrdinary') = 1 and
      IsFormulaIdHasProperty(FormulaId,'PreviousRateCPF') = 0 and
      TMSSGSPGenId = In_TMSSGSPGenId;
    if CurOrdinaryWage is not null then
      set Out_CurOrdinaryWage=Out_CurOrdinaryWage+CurOrdinaryWage;
      message '   Shift : '+cast(CurOrdinaryWage as char(20)) type info to client
    end if
  end if;
  /*
  Leave Deduction
  */
  if(IsWageElementInUsed('LeaveDeductAmt','OrdWage') = 1) then
    select Sum(CurrentCostingAmt)+Sum(PreviousCostingAmt) into CurOrdinaryWage
      from TMSLeaveDeduction where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if CurOrdinaryWage is not null then
      set Out_CurOrdinaryWage=Out_CurOrdinaryWage+CurOrdinaryWage;
      message '   Leave Deduction : '+cast(CurOrdinaryWage as char(20)) type info to client
    end if
  end if;
  /*
  Back Pay
  */
  if(IsWageElementInUsed('BackPay','OrdWage') = 1) then
    select Sum(BackPayCostingAmt) into CurOrdinaryWage
      from TMSDetail where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if CurOrdinaryWage is not null then
      set Out_CurOrdinaryWage=Out_CurOrdinaryWage+CurOrdinaryWage;
      message '   Back Pay : '+cast(CurOrdinaryWage as char(20)) type info to client
    end if
  end if;
  /*
  Total Wage
  */
  if(IsWageElementInUsed('TotalWage','OrdWage') = 1) then
    select Sum(BasicRateCostingAmt) into CurOrdinaryWage
      from TMSDetail where
      TMSSGSPGenId = In_TMSSGSPGenId;
    if CurOrdinaryWage is not null then
      set Out_CurOrdinaryWage=Out_CurOrdinaryWage+CurOrdinaryWage;
      message '   Ordinary Wage : '+cast(CurOrdinaryWage as char(20)) type info to client
    end if
  end if;
  message '   Total Ordinary Wage : '+cast(Out_CurOrdinaryWage as char(20)) type info to client;
  return(Out_CurOrdinaryWage)
end
;

create procedure DBA.ASQLTimeSheetDistributeCPF(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
out Out_CPFErrorCode integer)
begin
  /*
  Time Sheet cannot Support Previous CPF Rate as Policy Record 
  only stores Total Ord / Add Employee CPF without breakdown of Current and Previous CPF
  */
  declare In_TotalCurOrdCPFWage double;
  declare In_TotalCurAddCPFWage double;
  declare In_TotalContriOrdERCPF double;
  declare In_TotalContriAddERCPF double;
  declare In_TotalContriOrdEECPF double;
  declare In_TotalContriAddEECPF double;
  declare Accu_EECurOrdCPF double;
  declare Accu_ERCurOrdCPF double;
  declare Accu_EECurAddCPF double;
  declare Accu_ERCurAddCPF double;
  declare In_EECurOrdCPF double;
  declare In_ERCurOrdCPF double;
  declare In_EECurAddCPF double;
  declare In_ERCurAddCPF double;
  declare In_TotalRecord integer;
  declare In_DecimalPlace integer;
  declare Out_ErrorCode integer;
  set In_DecimalPlace=FGetDBPayDecimal(*);
  /*
  Get the CPF Contribution for Time Sheet Records only
  */
  select Sum(ContriOrdERCPF),Sum(ContriAddERCPF),
    Sum(ContriOrdEECPF),Sum(ContriAddEECPF) into In_TotalContriOrdERCPF,
    In_TotalContriAddERCPF,
    In_TotalContriOrdEECPF,
    In_TotalContriAddEECPF from PayRecord join PolicyRecord on
    (PayRecord.PayRecYear = PolicyRecord.PayRecYear and
    PayRecord.PayRecPeriod = PolicyRecord.PayRecPeriod and
    PayRecord.PayRecSubPeriod = PolicyRecord.PayRecSubPeriod and
    PayRecord.PayRecID = PolicyRecord.PayRecID and
    PayRecord.EmployeeSysId = PolicyRecord.EmployeeSysId) where
    PayRecord.EmployeeSysId = In_EmployeeSysId and
    PayRecord.PayRecYear = In_TMSYear and
    PayRecord.PayRecPeriod = In_TMSPeriod and
    (PayRecord.PayRecType = 'RegularTimeSheetPay' or PayRecord.PayRecType = 'AdHocTimeSheetPay');
  if In_TotalContriOrdERCPF is null then set In_TotalContriOrdERCPF=0
  end if;
  if In_TotalContriAddERCPF is null then set In_TotalContriAddERCPF=0
  end if;
  if In_TotalContriOrdEECPF is null then set In_TotalContriOrdEECPF=0
  end if;
  if In_TotalContriAddEECPF is null then set In_TotalContriAddEECPF=0
  end if;
  message '   ER Ord CPF : '+cast(In_TotalContriOrdERCPF as char(20)) type info to client;
  message '   ER Add CPF : '+cast(In_TotalContriAddERCPF as char(20)) type info to client;
  message '   EE Ord CPF : '+cast(In_TotalContriOrdEECPF as char(20)) type info to client;
  message '   EE Add CPF : '+cast(In_TotalContriAddEECPF as char(20)) type info to client;
  /*
  No CPF Contribution
  */
  if(In_TotalContriOrdERCPF = 0 and
    In_TotalContriAddERCPF = 0 and
    In_TotalContriOrdEECPF = 0 and
    In_TotalContriAddEECPF = 0) then
    update TMSDistribute set
      CostingAmount = 0 where
      TMSDistributeId = 'TsCurOrdCPFWage' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
        EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod);
    update TMSDistribute set
      CostingAmount = 0 where
      TMSDistributeId = 'TsCurAddCPFWage' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
        EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod);
    update TMSDistribute set
      CostingAmount = 0 where
      TMSDistributeId = 'TsEECurOrdCPF' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
        EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod);
    update TMSDistribute set
      CostingAmount = 0 where
      TMSDistributeId = 'TsEECurAddCPF' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
        EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod);
    update TMSDistribute set
      CostingAmount = 0 where
      TMSDistributeId = 'TsERCurOrdCPF' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
        EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod);
    update TMSDistribute set
      CostingAmount = 0 where
      TMSDistributeId = 'TsERCurAddCPF' and
      TMSSGSPGenId = any(select TMSSGSPGenId from TimeSheet where
        EmployeeSysId = In_EmployeeSysId and
        TMSYear = In_TMSYear and
        TMSPeriod = In_TMSPeriod);
    message '   No CPF Contribution' type info to client;
    set Out_CPFErrorCode=0;
    commit work;
    return
  end if;
  /*
  Distribute CPF Wage
  */
  message ' Distribute CPF Wage' type info to client;
  set In_TotalCurOrdCPFWage=0;
  set In_TotalCurAddCPFWage=0;
  CPFWageLoop: for CPFWageFor as CPFWage_curs dynamic scroll cursor for
    select TMSSGSPGenId as In_TMSSGSPGenId,
      FGetTimeSheetCurOrdinaryWage(TMSSGSPGenId) as In_CurOrdCPFWage,
      FGetTimeSheetCurAdditionalWage(TMSSGSPGenId) as In_CurAddCPFWage from
      TimeSheet where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod do
    /*
    Compute Current Ordinary CPF Wage for each Time Sheet
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsCurOrdCPFWage') then
      if(In_CurOrdCPFWage <> 0) then
        call InsertNewTMSDistribute('TsCurOrdCPFWage',In_TMSSGSPGenId,In_CurOrdCPFWage,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsCurOrdCPFWage',In_TMSSGSPGenId,In_CurOrdCPFWage,Out_ErrorCode)
    end if;
    /*
    If Successful Insert and Update Store Procedure return 1
    */
    if(Out_ErrorCode <> 1) then
      set Out_CPFErrorCode=1;
      message '   Fail to update Ordinary CPF Wage' type info to client;
      return
    end if;
    /*
    Compute Current Additional CPF Wage for each Time Sheet
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsCurAddCPFWage') then
      if(In_CurAddCPFWage <> 0) then
        call InsertNewTMSDistribute('TsCurAddCPFWage',In_TMSSGSPGenId,In_CurAddCPFWage,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsCurAddCPFWage',In_TMSSGSPGenId,In_CurAddCPFWage,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then
      set Out_CPFErrorCode=2;
      message '   Fail to update Additional CPF Wage' type info to client;
      return
    end if;
    set In_TotalCurOrdCPFWage=In_TotalCurOrdCPFWage+In_CurOrdCPFWage;
    set In_TotalCurAddCPFWage=In_TotalCurAddCPFWage+In_CurAddCPFWage end for;
  /*
  Count for CPF Ord Records 
  */
  select Count(*) into In_TotalRecord from
    TimeSheet join TMSDistribute where EmployeeSysId = In_EmployeeSysId and
    TMSYear = In_TMSYear and
    TMSPeriod = In_TMSPeriod and
    TMSDistributeId = 'TsCurOrdCPFWage';
  /*
  Distribute Ordinary EE / ER CPF
  */
  message ' Distribute Ordinary CPF' type info to client;
  set Accu_EECurOrdCPF=0;
  set Accu_ERCurOrdCPF=0;
  OrdCPFLoop: for OrdCPFFor as OrdCPF_curs dynamic scroll cursor for
    select TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId,
      CostingAmount as In_CurOrdCPFWage from
      TimeSheet join TMSDistribute where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSDistributeId = 'TsCurOrdCPFWage' do
    if(In_TotalRecord = 1) then
      set In_EECurOrdCPF=Round(In_TotalContriOrdEECPF-Accu_EECurOrdCPF,In_DecimalPlace);
      set In_ERCurOrdCPF=Round(In_TotalContriOrdERCPF-Accu_ERCurOrdCPF,In_DecimalPlace)
    else
      if(In_TotalContriOrdEECPF = 0) then
        set In_EECurOrdCPF=0
      else
        set In_EECurOrdCPF=Round(In_CurOrdCPFWage/In_TotalCurOrdCPFWage*In_TotalContriOrdEECPF,In_DecimalPlace);
        if(In_EECurOrdCPF+Accu_EECurOrdCPF > In_TotalContriOrdEECPF) then
          set In_EECurOrdCPF=Round(In_TotalContriOrdEECPF-Accu_EECurOrdCPF,In_DecimalPlace)
        end if
      end if;
      if(In_TotalContriOrdERCPF = 0) then
        set In_ERCurOrdCPF=0
      else
        set In_ERCurOrdCPF=Round(In_CurOrdCPFWage/In_TotalCurOrdCPFWage*In_TotalContriOrdERCPF,In_DecimalPlace);
        if(In_ERCurOrdCPF+Accu_ERCurOrdCPF > In_TotalContriOrdERCPF) then
          set In_ERCurOrdCPF=Round(In_TotalContriOrdERCPF-Accu_ERCurOrdCPF,In_DecimalPlace)
        end if
      end if
    end if;
    set Accu_EECurOrdCPF=Accu_EECurOrdCPF+In_EECurOrdCPF;
    set Accu_ERCurOrdCPF=Accu_ERCurOrdCPF+In_ERCurOrdCPF;
    /*
    Update EE Current Ordinary CPF
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsEECurOrdCPF') then
      if(In_EECurOrdCPF <> 0) then
        call InsertNewTMSDistribute('TsEECurOrdCPF',In_TMSSGSPGenId,In_EECurOrdCPF,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsEECurOrdCPF',In_TMSSGSPGenId,In_EECurOrdCPF,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then set
        Out_CPFErrorCode=3;
      message '   Fail to update EE Ordinary CPF' type info to client;
      return
    end if;
    /*
    Update ER Current Ordinary CPF
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsERCurOrdCPF') then
      if(In_ERCurOrdCPF <> 0) then
        call InsertNewTMSDistribute('TsERCurOrdCPF',In_TMSSGSPGenId,In_ERCurOrdCPF,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsERCurOrdCPF',In_TMSSGSPGenId,In_ERCurOrdCPF,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then
      set Out_CPFErrorCode=4;
      message '   Fail to update ER Ordinary CPF' type info to client;
      return
    end if end for;
  /*
  Distribute Additional EE / ER CPF
  */
  message ' Distribute Additional CPF' type info to client;
  set Accu_EECurAddCPF=0;
  set Accu_ERCurAddCPF=0;
  AddCPFLoop: for AddCPFFor as AddCPF_curs dynamic scroll cursor for
    select TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId,
      CostingAmount as In_CurAddCPFWage from
      TimeSheet join TMSDistribute where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod and
      TMSDistributeId = 'TsCurAddCPFWage' do
    if(In_TotalRecord = 1) then
      set In_EECurAddCPF=Round(In_TotalContriAddEECPF-Accu_EECurAddCPF,In_DecimalPlace);
      set In_ERCurAddCPF=Round(In_TotalContriAddERCPF-Accu_ERCurAddCPF,In_DecimalPlace)
    else
      if(In_TotalContriAddEECPF = 0) then
        set In_EECurAddCPF=0
      else
        set In_EECurAddCPF=Round(In_CurAddCPFWage/In_TotalCurAddCPFWage*In_TotalContriAddEECPF,In_DecimalPlace);
        if(In_EECurAddCPF+Accu_EECurAddCPF > In_TotalContriAddEECPF) then
          set In_EECurAddCPF=Round(In_TotalContriAddEECPF-Accu_EECurAddCPF,In_DecimalPlace)
        end if
      end if;
      if(In_TotalContriAddERCPF = 0) then
        set In_ERCurAddCPF=0
      else
        set In_ERCurAddCPF=Round(In_CurAddCPFWage/In_TotalCurAddCPFWage*In_TotalContriAddERCPF,In_DecimalPlace);
        if(In_ERCurAddCPF+Accu_ERCurAddCPF > In_TotalContriAddERCPF) then
          set In_ERCurAddCPF=Round(In_TotalContriAddERCPF-Accu_ERCurAddCPF,In_DecimalPlace)
        end if
      end if
    end if;
    set Accu_EECurAddCPF=Accu_EECurAddCPF+In_EECurAddCPF;
    set Accu_ERCurAddCPF=Accu_ERCurAddCPF+In_ERCurAddCPF;
    /*
    Update EE Current Ordinary CPF
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsEECurAddCPF') then
      if(In_EECurAddCPF <> 0) then
        call InsertNewTMSDistribute('TsEECurAddCPF',In_TMSSGSPGenId,In_EECurAddCPF,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsEECurAddCPF',In_TMSSGSPGenId,In_EECurAddCPF,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then
      set Out_CPFErrorCode=5;
      message '   Fail to update EE Additional CPF' type info to client;
      return
    end if;
    /*
    Update ER Current Ordinary CPF
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsERCurAddCPF') then
      if(In_ERCurAddCPF <> 0) then
        call InsertNewTMSDistribute('TsERCurAddCPF',In_TMSSGSPGenId,In_ERCurAddCPF,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsERCurAddCPF',In_TMSSGSPGenId,In_ERCurAddCPF,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then
      set Out_CPFErrorCode=6;
      message '   Fail to update ER Additional CPF' type info to client;
      return
    end if end for;
  set Out_CPFErrorCode=0;
  message '   End CPF' type info to client;
  commit work
end
;

create procedure DBA.ASQLTimeSheetDistributeFWL(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
out Out_FWLErrorCode integer)
begin
  declare In_TotalContriFWL double;
  declare In_ContriFWL double;
  declare Accu_ContriFWL double;
  declare In_TotalFreq double;
  declare In_TotalRecord integer;
  declare In_DecimalPlace integer;
  declare Out_ErrorCode integer;
  set In_DecimalPlace=FGetDBPayDecimal(*);
  set Out_FWLErrorCode=0;
  /*
  Get the FWL Contribution
  */
  select ContriFWL into In_TotalContriFWL
    from PeriodPolicySummary where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_TMSYear and
    PayRecPeriod = In_TMSPeriod;
  /*
  Count for TMS Records 
  */
  select Count(*) into In_TotalRecord from
    TimeSheet where EmployeeSysId = In_EmployeeSysId and
    TMSYear = In_TMSYear and
    TMSPeriod = In_TMSPeriod;
  /*
  Get Total Working Days
  */
  select Sum(CurrentHrDays) into In_TotalFreq from
    DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_TMSYear and
    PayRecPeriod = In_TMSPeriod;
  /*
  Distribute FWL
  */
  set Accu_ContriFWL=0;
  FWLLoop: for FWLFor as FWL_curs dynamic scroll cursor for
    select TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId,
      TMSWorkingDayHour as In_TMSWorkingDayHour from
      TimeSheet join TMSDetail where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod do
    if(In_TotalRecord = 1) then
      set In_ContriFWL=Round(In_TotalContriFWL-Accu_ContriFWL,In_DecimalPlace)
    else
      if(In_TotalFreq = 0) then
        set In_ContriFWL=0
      else
        set In_ContriFWL=Round(In_TMSWorkingDayHour/In_TotalFreq*In_TotalContriFWL,In_DecimalPlace);
        if(In_ContriFWL+Accu_ContriFWL > In_TotalContriFWL) then
          set In_ContriFWL=Round(In_TotalContriFWL-Accu_ContriFWL,In_DecimalPlace)
        end if
      end if
    end if;
    set Accu_ContriFWL=Accu_ContriFWL+In_ContriFWL;
    /*
    Update FWL
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = 'TsFWL') then
      if(In_ContriFWL <> 0) then
        call InsertNewTMSDistribute('TsFWL',In_TMSSGSPGenId,In_ContriFWL,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute('TsFWL',In_TMSSGSPGenId,In_ContriFWL,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then set Out_FWLErrorCode=1;
      return
    end if end for;
  set Out_FWLErrorCode=0;
  message 'End FWL' type info to client
end
;

create procedure DBA.ASQLYECreateA8A_S2S3(
in In_PersonalSysID integer,
in In_YEYear integer)
begin
  /*
  To create A8A section 2 Items 
  */
  A8ASection2Loop: for A8ASection2For as CreateSec2Curs dynamic scroll cursor for
    select YEKeywordId as In_Sec2YEKeywordId,
      YEKeywordUserdefinedName as In_Sec2Items,
      YEProperty1 as In_Sec2ItemsNo,
      YEProperty5 as In_Sec2Rate from
      YEKeyword where
      YEKeywordCategory = 'A8AS2' order by YEProperty1 asc do
    call InsertNewA8AS2(
    In_PersonalSysId,
    In_YEYear,
    In_Sec2ItemsNo,
    In_Sec2Items,
    0,
    0,
    In_Sec2Rate,
    0,
    0,
    In_Sec2YEKeywordId) end for;
  /*
  To create A8A section 3 Items
  */
  A8ASection3Loop: for A8ASection3For as CreateSec3Curs dynamic scroll cursor for
    select YEKeywordId as In_Sec3YEKeywordId,
      YEKeywordUserdefinedName as In_Sec3DisplayMsg,
      YEProperty1 as In_Sec3No,
      YEProperty5 as In_Sec3Rate from
      YEKeyword where
      YEKeywordCategory = 'A8AS3' order by YEProperty1 asc do
    call InsertNewA8AS3(
    In_PersonalSysId,
    In_YEYear,
    In_Sec3No,
    0,
    In_Sec3Rate,
    0,
    0,
    In_Sec3DisplayMsg,
    In_Sec3YEKeywordId) end for
end
;

create procedure DBA.ASQLYECreateIR21A1_S2S3(
in In_PersonalSysID integer,
in In_YEYear integer)
begin
  /*
  To create A8A section 2 Items
  */
  A8ASection2Loop: for A8ASection2For as CreateSec2Curs dynamic scroll cursor for
    select YEKeywordId as In_Sec2YEKeywordId,
      YEKeywordUserdefinedName as In_Sec2Items,
      YEProperty1 as In_Sec2ItemsNo,
      YEProperty5 as In_Sec2Rate from
      YEKeyword where
      YEKeywordCategory = 'IR21A1S2' order by YEProperty1 asc do
    call InsertNewA8AS2(
    In_PersonalSysId,
    In_YEYear,
    In_Sec2ItemsNo,
    In_Sec2Items,
    0,
    0,
    In_Sec2Rate,
    0,
    0,
    In_Sec2YEKeywordId) end for;
  /*
  To create A8A section 3 Items
  */
  A8ASection3Loop: for A8ASection3For as CreateSec3Curs dynamic scroll cursor for
    select YEKeywordId as In_Sec3YEKeywordId,
      YEKeywordUserdefinedName as In_Sec3DisplayMsg,
      YEProperty1 as In_Sec3No,
      YEProperty5 as In_Sec3Rate from
      YEKeyword where
      YEKeywordCategory = 'IR21A1S3' order by YEProperty1 asc do
    call InsertNewA8AS3(
    In_PersonalSysId,
    In_YEYear,
    In_Sec3No,
    0,
    In_Sec3Rate,
    0,
    0,
    In_Sec3DisplayMsg,
    In_Sec3YEKeywordId) end for
end
;

create procedure DBA.ASQLYEProcessIR21(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_Operation char(20))
begin
  declare EndBasis date;
  declare In_EmployeeSysId integer;
  declare In_IR21Type integer;
  declare In_ResidenceTypeId char(20);
  declare In_DateOfArrival date;
  declare In_DateOfDeparture date;
  declare In_CessationDate date;
  declare In_DateResignationTendered date;
  declare In_DateLastSalaryPaid date;
  declare In_AmtOfLastSalaryPaid double;
  declare In_PeriodLastSalaryPaid char(50);
  set EndBasis="date"(str(In_YEYear)+'-12-31');
  /*
  Get latest Employee ID from latest Employment
  */
  select first YEEmployeeSysId into In_EmployeeSysId from EmploymentHistory where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear order by FromDate desc;
  if(In_Operation = 'Create' or In_Operation = 'Reprocess') then
    /*
    Get the latest Residence Status within Taxation Year
    */
    select first ResidenceTypeId into In_ResidenceTypeId from ResidenceStatusRecord where
      PersonalSysId = In_PersonalSysId and
      ResStatusEffectiveDate <= EndBasis order by ResStatusEffectiveDate desc;
    /*
    Get the Arrival and Departure Date
    */
    if(In_ResidenceTypeId = 'EP') then
      select first EPArrivalDate,EPCancellationDate into In_DateOfArrival,In_DateOfDeparture from EmployPassProgression where
        EmployeeSysId = In_EmployeeSysID and
        EPEffectiveDate <= EndBasis order by EPEffectiveDate desc
    elseif(In_ResidenceTypeId = 'FW') then
      select first FWLArrivalDate,FWLCancellationDate into In_DateOfArrival,In_DateOfDeparture from FWLProgression where
        EmployeeSysId = In_EmployeeSysID and
        FWLEffectiveDate <= EndBasis order by FWLEffectiveDate desc
    end if
  end if;
  /*
  Create
  */
  if(In_Operation = 'Create') then
    /*
    Set to Original
    */
    set In_IR21Type=0;
    /*
    Set Date Resignation to be 1 month before Cessation Date
    */
    select Cessation into In_CessationDate from YEEmployee where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear;
    set In_DateResignationTendered=dateadd(day,-1,dateadd(month,-1,In_CessationDate));
    /*
    Get last Pay Date from latest Employment
    */
    select LastPayDate into In_DateLastSalaryPaid from PayEmployee where EmployeeSysId = In_EmployeeSysId;
    message In_EmployeeSysId type info to client;
    message In_DateLastSalaryPaid type info to client;
    if(In_DateLastSalaryPaid <> '1899-12-30') then
      /*
      Get latest Gross Salary Pay Record of the Year
      */
      select Sum(CalGrossWage) into In_AmtOfLastSalaryPaid from DetailRecord where EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_YEYear and PayRecPeriod = (select Max(PayRecPeriod) from PayPeriodRecord where EmployeeSysId = In_EmployeeSysId and
          PayRecYear = In_YEYear);
      message In_AmtOfLastSalaryPaid type info to client;
      /*
      Convert Last Pay Date into String
      */
      select MonthName(In_DateLastSalaryPaid)+' '+cast(Year(In_DateLastSalaryPaid) as char(4)) into In_PeriodLastSalaryPaid
    else
      set In_AmtOfLastSalaryPaid=0;
      set In_PeriodLastSalaryPaid=''
    end if;
    /*
    Create record
    */
    call InsertNewIR21Details(
    In_PersonalSysID,
    In_YEYear,
    In_IR21Type,'1899-12-30',
    //In_SupersedeIR21Date,
    In_DateOfArrival,
    In_DateOfDeparture,
    In_DateResignationTendered,'',
    //In_ReasonsLessThan1Mth
    0, //In_AmtOfMoniesWithheld,
    In_DateLastSalaryPaid,
    In_AmtOfLastSalaryPaid,
    In_PeriodLastSalaryPaid,'','','','1899-12-30','1899-12-30',
    //In_ReasonsNotWithholding,
    //In_NameOfNewEmployer
    //In_TelNoOfNewEmployer
    //In_MailingAddEffDate
    //In_DateOfMarriage
    0, //In_UnexercisedGainsBef
    0,'') //In_UnexercisedGainsAft
  end if; //SpouseNationality
  /*
  Reprocess 
  */
  if(In_Operation = 'Reprocess') then
    update IR21Details set
      DateOfArrival = In_DateOfArrival,
      DateOfDeparture = In_DateOfDeparture where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure DBA.ASQLYEProcessIR21A2(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_Operation char(20))
begin
  declare Out_TotalEESOPTaxExempt double;
  declare Out_TotalCSOPTaxExempt double;
  declare Out_TotalESOPNoTaxExempt double;
  declare Out_TotalEESOPNoTaxExempt double;
  declare Out_TotalCSOPNoTaxExempt double;
  declare Out_TotalESOPStockGains double;
  declare Out_TotalEESOPStockGains double;
  declare Out_TotalCSOPStockGains double;
  declare Out_GrandTotalStockGains double;
  if(In_Operation = 'Create') then
    call InsertNewIR21A2(
    In_PersonalSysID,
    In_YEYear,'',
    //In_FormHeaderMsg
    0, //In_TotalEESOPTaxExempt
    0, //In_TotalCSOPTaxExempt
    0, //In_TotalESOPNoTaxExempt
    0, //In_TotalEESOPNoTaxExempt
    0, //In_TotalCSOPNoTaxExempt
    0, //In_TotalESOPStockGains
    0, //In_TotalEESOPStockGains
    0, //In_TotalCSOPStockGains
    0, //In_GrandTotalStockGains
    0,'') //In_OtherShareAmt
  end if; //In_Remarks
  /*
  To compute ESOP
  */
  update IR21A2Record set
    EESOPTaxExempt = 0,
    CSOPTaxExempt = 0,
    NoTaxExempt = Round((MktValueExerciseStock-ExercisePriceStock)*SharesAcquired,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'ESOP';
  update IR21A2Record set
    StockGains = Round(NoTaxExempt,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'ESOP';
  /*
  To compute EESOP
  */
  update IR21A2Record set
    EESOPTaxExempt = Round((MktValueExerciseStock-MktValueStockGrant)*SharesAcquired,2),
    CSOPTaxExempt = 0,
    NoTaxExempt = Round((MktValueStockGrant-ExercisePriceStock)*SharesAcquired,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'EESOP';
  update IR21A2Record set
    StockGains = Round(EESOPTaxExempt+NoTaxExempt,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'EESOP';
  /*
  To compute CSOP
  */
  update IR21A2Record set
    EESOPTaxExempt = 0,
    CSOPTaxExempt = Round((MktValueExerciseStock-MktValueStockGrant)*SharesAcquired,2),
    NoTaxExempt = Round((MktValueStockGrant-ExercisePriceStock)*SharesAcquired,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'CSOP';
  update IR21A2Record set
    StockGains = Round(CSOPTaxExempt+NoTaxExempt,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'CSOP';
  /*
  To EESOP Tax Exempt
  */
  select Sum(EESOPTaxExempt) into Out_TotalEESOPTaxExempt from IR21A2Record where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'EESOP';
  if(Out_TotalEESOPTaxExempt is null) then set Out_TotalEESOPTaxExempt=0
  end if;
  /*
  To CSOP Tax Exempt
  */
  select Sum(CSOPTaxExempt) into Out_TotalCSOPTaxExempt from IR21A2Record where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'CSOP';
  if(Out_TotalCSOPTaxExempt is null) then set Out_TotalCSOPTaxExempt=0
  end if;
  /*
  To ESOP's No Tax Exempt
  */
  select Sum(NoTaxExempt) into Out_TotalESOPNoTaxExempt from IR21A2Record where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'ESOP';
  if(Out_TotalESOPNoTaxExempt is null) then set Out_TotalESOPNoTaxExempt=0
  end if;
  /*
  To EESOP's No Tax Exempt
  */
  select Sum(NoTaxExempt) into Out_TotalEESOPNoTaxExempt from IR21A2Record where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'EESOP';
  if(Out_TotalEESOPNoTaxExempt is null) then set Out_TotalEESOPNoTaxExempt=0
  end if;
  /*
  To CSOP's No Tax Exempt
  */
  select Sum(NoTaxExempt) into Out_TotalCSOPNoTaxExempt from IR21A2Record where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'CSOP';
  if(Out_TotalCSOPNoTaxExempt is null) then set Out_TotalCSOPNoTaxExempt=0
  end if;
  /*
  To ESOP's Stock Gain
  */
  select Sum(StockGains) into Out_TotalESOPStockGains from IR21A2Record where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'ESOP';
  if(Out_TotalESOPStockGains is null) then set Out_TotalESOPStockGains=0
  end if;
  /*
  To EESOP's Stock Gain
  */
  select Sum(StockGains) into Out_TotalEESOPStockGains from IR21A2Record where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'EESOP';
  if(Out_TotalEESOPStockGains is null) then set Out_TotalEESOPStockGains=0
  end if;
  /*
  To CSOP's Stock Gain
  */
  select Sum(StockGains) into Out_TotalCSOPStockGains from IR21A2Record where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'CSOP';
  if(Out_TotalCSOPStockGains is null) then set Out_TotalCSOPStockGains=0
  end if;
  /*
  Compute Grand Total
  */
  update IR21A2 set
    TotalEESOPTaxExempt = Out_TotalEESOPTaxExempt,
    TotalCSOPTaxExempt = Out_TotalCSOPTaxExempt,
    TotalESOPNoTaxExempt = Out_TotalESOPNoTaxExempt,
    TotalEESOPNoTaxExempt = Out_TotalEESOPNoTaxExempt,
    TotalCSOPNoTaxExempt = Out_TotalCSOPNoTaxExempt,
    TotalESOPStockGains = Out_TotalESOPStockGains,
    TotalEESOPStockGains = Out_TotalEESOPStockGains,
    TotalCSOPStockGains = Out_TotalCSOPStockGains where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  update IR21A2 set
    GrandTotalStockGains = Out_TotalESOPStockGains+Out_TotalEESOPStockGains+Out_TotalCSOPStockGains where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  commit work
end
;

create procedure DBA.ASQLYEProcessIR21A3(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_Operation char(20))
begin
  if(In_Operation = 'Create') then
    call InsertNewIR21A3(In_PersonalSysID,In_YEYear,'','')
  end if
end
;

create procedure DBA.ASQLYEReprocessA8A_S2S3(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_NoOfEESharingQtr integer)
begin
  declare DayInYear double;
  set DayInYear=Days(cast(In_YEYear as char(4))+'-01-01',cast(In_YEYear as char(4))+'-12-31')+1;
  /*
  Update the Section 2 Rate if found else create the record
  */
  A8ASection2Loop: for A8ASectionFor as ReprocessSec2Curs dynamic scroll cursor for
    select YEKeywordId as In_Sec2YEKeywordId,
      YEKeywordUserdefinedName as In_Sec2Items,
      YEProperty1 as In_Sec2ItemsNo,
      YEProperty5 as In_Sec2Rate from
      YEKeyword where
      YEKeywordCategory = 'A8AS2' order by YEProperty1 asc do
    if(exists(select* from A8AS2 where
        PersonalSysId = In_PersonalSysId and
        YEYear = In_YEYear and
        Sec2YEKeywordId = In_Sec2YEKeywordId)) then
      update A8AS2 set
        Sec2Rate = In_Sec2Rate where
        PersonalSysId = In_PersonalSysId and
        YEYear = In_YEYear and
        Sec2YEKeywordId = In_Sec2YEKeywordId
    else
      call InsertNewA8AS2(
      In_PersonalSysId,
      In_YEYear,
      In_Sec2ItemsNo,
      In_Sec2Items,
      0,
      0,
      In_Sec2Rate,
      0,
      0,
      In_Sec2YEKeywordId)
    end if end for;
  /*
  Update Section 3 Rate
  */
  A8ASection3Loop: for A8ASection3For as ReprocessSec3Curs dynamic scroll cursor for
    select YEKeywordId as In_Sec3YEKeywordId,
      YEKeywordUserdefinedName as In_Sec3DisplayMsg,
      YEProperty1 as In_Sec3No,
      YEProperty5 as In_Sec3Rate from
      YEKeyword where
      YEKeywordCategory = 'A8AS3' order by YEProperty1 asc do
    update A8AS3 set
      Sec3Rate = In_Sec3Rate where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      Sec3YEKeywordId = In_Sec3YEKeywordId end for;
  /*
  Compute Section 2 Items value
  */
  A8ASection2Loop: for A8ASectionFor as RecalculateSec2Curs dynamic scroll cursor for
    select Sec2Selection as In_Sec2Selection,
      Sec2Unit as In_Sec2Unit,
      Sec2Rate as In_Sec2Rate,
      Sec2Days as In_Sec2Days,
      Sec2Value as In_Sec2Value,
      IsA8AS2UseActualValue(Sec2YEKeywordId) as In_UseActualValue from
      A8AS2 where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear do
    if(In_Sec2Selection = 1 and In_UseActualValue = 0) then
      if(In_NoOfEESharingQtr <> 0) then
        set In_Sec2Value=round(In_Sec2Unit*In_Sec2Rate*12*In_Sec2Days/DayInYear/In_NoOfEESharingQtr,2)
      else
        set In_Sec2Value=0
      end if;
      update A8AS2 set
        Sec2Value = In_Sec2Value where current of RecalculateSec2Curs
    end if end for;
  /*
  Compute Section 3 Items value
  */
  A8ASection3Loop: for A8ASectionFor as RecalculateSec3Curs dynamic scroll cursor for
    select Sec3Period as In_Sec3Period,
      Sec3Rate as In_Sec3Rate,
      Sec3NoofPersons as In_Sec3NoofPersons,
      Sec3Value as In_Sec3Value,
      IsA8AS2UseActualValue(Sec3YEKeywordId) as In_UseActualValue from
      A8AS3 where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear do
    if(In_UseActualValue = 0) then
      set In_Sec3Value=round(In_Sec3NoofPersons*In_Sec3Rate*12*In_Sec3Period/DayInYear,2);
      update A8AS3 set
        Sec3Value = In_Sec3Value where current of RecalculateSec3Curs
    end if end for;
  commit work
end
;

create procedure DBA.ASQLYEReprocessIR21A1_S2S3(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_NoOfEESharingQtr integer)
begin
  declare DayInYear double;
  set DayInYear=Days(cast(In_YEYear as char(4))+'-01-01',cast(In_YEYear as char(4))+'-12-31')+1;
  /*
  Update the Section 2 Rate if found else create the record
  */
  A8ASection2Loop: for A8ASectionFor as ReprocessSec2Curs dynamic scroll cursor for
    select YEKeywordId as In_Sec2YEKeywordId,
      YEKeywordUserdefinedName as In_Sec2Items,
      YEProperty1 as In_Sec2ItemsNo,
      YEProperty5 as In_Sec2Rate from
      YEKeyword where
      YEKeywordCategory = 'IR21A1S2' order by YEProperty1 asc do
    if(exists(select* from A8AS2 where
        PersonalSysId = In_PersonalSysId and
        YEYear = In_YEYear and
        Sec2YEKeywordId = In_Sec2YEKeywordId)) then
      update A8AS2 set
        Sec2Rate = In_Sec2Rate where
        PersonalSysId = In_PersonalSysId and
        YEYear = In_YEYear and
        Sec2YEKeywordId = In_Sec2YEKeywordId
    else
      call InsertNewA8AS2(
      In_PersonalSysId,
      In_YEYear,
      In_Sec2ItemsNo,
      In_Sec2Items,
      0,
      0,
      In_Sec2Rate,
      0,
      0,
      In_Sec2YEKeywordId)
    end if end for;
  /*
  Update Section 3 Rate
  */
  A8ASection3Loop: for A8ASection3For as ReprocessSec3Curs dynamic scroll cursor for
    select YEKeywordId as In_Sec3YEKeywordId,
      YEKeywordUserdefinedName as In_Sec3DisplayMsg,
      YEProperty1 as In_Sec3No,
      YEProperty5 as In_Sec3Rate from
      YEKeyword where
      YEKeywordCategory = 'IR21A1S3' order by YEProperty1 asc do
    update A8AS3 set
      Sec3Rate = In_Sec3Rate where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear and
      Sec3YEKeywordId = In_Sec3YEKeywordId end for;
  /*
  Compute Section 2 Items value
  */
  A8ASection2Loop: for A8ASectionFor as RecalculateSec2Curs dynamic scroll cursor for
    select Sec2Selection as In_Sec2Selection,
      Sec2Unit as In_Sec2Unit,
      Sec2Rate as In_Sec2Rate,
      Sec2Days as In_Sec2Days,
      Sec2Value as In_Sec2Value,
      IsA8AS2UseActualValue(Sec2YEKeywordId) as In_UseActualValue from
      A8AS2 where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear do
    if(In_Sec2Selection = 1 and In_UseActualValue = 0) then
      if(In_NoOfEESharingQtr <> 0) then
        set In_Sec2Value=round(In_Sec2Unit*In_Sec2Rate*In_Sec2Days/DayInYear/In_NoOfEESharingQtr,2)
      else
        set In_Sec2Value=0
      end if;
      update A8AS2 set
        Sec2Value = In_Sec2Value where current of RecalculateSec2Curs
    end if end for;
  /*
  Compute Section 3 Items value
  */
  A8ASection3Loop: for A8ASectionFor as RecalculateSec3Curs dynamic scroll cursor for
    select Sec3Period as In_Sec3Period,
      Sec3Rate as In_Sec3Rate,
      Sec3NoofPersons as In_Sec3NoofPersons,
      Sec3Value as In_Sec3Value,
      IsA8AS2UseActualValue(Sec3YEKeywordId) as In_UseActualValue from
      A8AS3 where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear do
    if(In_UseActualValue = 0) then
      set In_Sec3Value=round(In_Sec3NoofPersons*In_Sec3Rate*In_Sec3Period/DayInYear,2);
      update A8AS3 set
        Sec3Value = In_Sec3Value where current of RecalculateSec3Curs
    end if end for;
  commit work
end
;

create procedure dba.DeleteIR21A2(
in In_PersonalSysID integer,
in In_YEYear integer)
begin
  if exists(select* from IR21A2 where
      IR21A2.PersonalSysID = In_PersonalSysID and
      IR21A2.YEYear = In_YEYear) then
    delete from IR21A2Record where
      IR21A2Record.PersonalSysId = In_PersonalSysId and
      IR21A2Record.YEYear = In_YEYear;
    delete from IR21A2 where
      IR21A2.PersonalSysID = In_PersonalSysID and
      IR21A2.YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.DeleteIR21A2ByPersonalSysID(
in In_PersonalSysID integer)
begin
  if exists(select* from IR21A2 where
      IR21A2.PersonalSysID = In_PersonalSysID) then
    delete from IR21A2Record where
      IR21A2Record.PersonalSysId = In_PersonalSysId;
    delete from IR21A2 where
      IR21A2.PersonalSysID = In_PersonalSysID;
    commit work
  end if
end
;

create procedure dba.DeleteIR21A2Record(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_IR21A2StockOptionType char(20))
begin
  if exists(select* from IR21A2Record where
      IR21A2Record.PersonalSysID = In_PersonalSysID and
      IR21A2Record.YEYear = In_YEYear and
      IR21A2Record.IR21A2StockOptionType = In_IR21A2StockOptionType) then
    delete from IR21A2Record where
      IR21A2Record.PersonalSysID = In_PersonalSysID and
      IR21A2Record.YEYear = In_YEYear and
      IR21A2Record.IR21A2StockOptionType = In_IR21A2StockOptionType;
    commit work
  end if
end
;

create procedure dba.DeleteIR21A3(
in In_PersonalSysID integer,
in In_YEYear integer)
begin
  if exists(select* from IR21A3 where
      IR21A3.PersonalSysID = In_PersonalSysID and
      IR21A3.YEYear = In_YEYear) then
    delete from IR21A3Record where
      IR21A3Record.PersonalSysID = In_PersonalSysID and
      IR21A3Record.YEYear = In_YEYear;
    delete from IR21A3 where
      IR21A3.PersonalSysID = In_PersonalSysID and
      IR21A3.YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.DeleteIR21A3ByPersonalSysID(
in In_PersonalSysID integer)
begin
  if exists(select* from IR21A3 where
      IR21A3.PersonalSysID = In_PersonalSysID) then
    delete from IR21A3Record where
      IR21A3Record.PersonalSysID = In_PersonalSysID;
    delete from IR21A3 where
      IR21A3.PersonalSysID = In_PersonalSysID;
    commit work
  end if
end
;

create procedure dba.DeleteIR21A3Record(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_IR21A3StockOptionType char(20))
begin
  if exists(select* from IR21A3Record where
      IR21A3Record.PersonalSysID = In_PersonalSysID and
      IR21A3Record.YEYear = In_YEYear and
      IR21A3Record.IR21A3StockOptionType = In_IR21A3StockOptionType) then
    delete from IR21A3Record where
      IR21A3Record.PersonalSysID = In_PersonalSysID and
      IR21A3Record.YEYear = In_YEYear and
      IR21A3Record.IR21A3StockOptionType = In_IR21A3StockOptionType;
    commit work
  end if
end
;

create procedure dba.DeleteIR21Details(
in In_PersonalSysID integer,
in In_YEYear integer)
begin
  if exists(select* from IR21Details where
      IR21Details.PersonalSysID = In_PersonalSysID and
      IR21Details.YEYear = In_YEYear) then
    delete from IR21Details where
      IR21Details.PersonalSysID = In_PersonalSysID and
      IR21Details.YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.InsertNewIR21A2(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_FormHeaderMsg char(100),
in In_TotalEESOPTaxExempt double,
in In_TotalCSOPTaxExempt double,
in In_TotalESOPNoTaxExempt double,
in In_TotalEESOPNoTaxExempt double,
in In_TotalCSOPNoTaxExempt double,
in In_TotalESOPStockGains double,
in In_TotalEESOPStockGains double,
in In_TotalCSOPStockGains double,
in In_GrandTotalStockGains double,
in In_OtherShareAmt double,
in In_Remarks char(100))
begin
  if not exists(select* from IR21A2 where
      IR21A2.PersonalSysID = In_PersonalSysID and
      IR21A2.YEYear = In_YEYear) then
    insert into IR21A2(PersonalSysID,
      YEYear,
      FormHeaderMsg,
      TotalEESOPTaxExempt,
      TotalCSOPTaxExempt,
      TotalESOPNoTaxExempt,
      TotalEESOPNoTaxExempt,
      TotalCSOPNoTaxExempt,
      TotalESOPStockGains,
      TotalEESOPStockGains,
      TotalCSOPStockGains,
      GrandTotalStockGains,
      OtherShareAmt,
      Remarks,
      LastChangedDateTime) values(
      In_PersonalSysID,
      In_YEYear,
      In_FormHeaderMsg,
      In_TotalEESOPTaxExempt,
      In_TotalCSOPTaxExempt,
      In_TotalESOPNoTaxExempt,
      In_TotalEESOPNoTaxExempt,
      In_TotalCSOPNoTaxExempt,
      In_TotalESOPStockGains,
      In_TotalEESOPStockGains,
      In_TotalCSOPStockGains,
      In_GrandTotalStockGains,
      In_OtherShareAmt,
      In_Remarks,
      now(*));
    commit work
  end if
end
;

create procedure dba.InsertNewIR21A2Record(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_IR21A2SysId integer,
in In_IR21A2StockOptionType char(20),
in In_RCBNo char(20),
in In_CompanyIDType char(20),
in In_CompanyName char(100),
in In_DateStockGranted date,
in In_DateExerciseStock date,
in In_ExercisePriceStock double,
in In_MktValueStockGrant double,
in In_MktValueExerciseStock double,
in In_SharesAcquired double,
in In_EESOPTaxExempt double,
in In_CSOPTaxExempt double,
in In_NoTaxExempt double,
in In_StockGains double,
in In_TypePlanGranted char(20),
in In_GrantedBef smallint,
in In_TypeOfExercise char(20))
begin
  if not exists(select* from IR21A2Record where
      IR21A2Record.PersonalSysID = In_PersonalSysID and
      IR21A2Record.YEYear = In_YEYear and
      IR21A2Record.IR21A2SysId = In_IR21A2SysId and
      IR21A2Record.IR21A2StockOptionType = In_IR21A2StockOptionType) then
    insert into IR21A2Record(PersonalSysID,
      YEYear,
      IR21A2SysId,
      IR21A2StockOptionType,
      RCBNo,
      CompanyIDType,
      CompanyName,
      DateStockGranted,
      DateExerciseStock,
      ExercisePriceStock,
      MktValueStockGrant,
      MktValueExerciseStock,
      SharesAcquired,
      EESOPTaxExempt,
      CSOPTaxExempt,
      NoTaxExempt,
      StockGains,
      TypePlanGranted,
      GrantedBef,
      TypeOfExercise) values(
      In_PersonalSysID,
      In_YEYear,
      In_IR21A2SysId,
      In_IR21A2StockOptionType,
      In_RCBNo,
      In_CompanyIDType,
      In_CompanyName,
      In_DateStockGranted,
      In_DateExerciseStock,
      In_ExercisePriceStock,
      In_MktValueStockGrant,
      In_MktValueExerciseStock,
      In_SharesAcquired,
      In_EESOPTaxExempt,
      In_CSOPTaxExempt,
      In_NoTaxExempt,
      In_StockGains,
      In_TypePlanGranted,
      In_GrantedBef,
      In_TypeOfExercise);
    commit work;
    update IR21A2 set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.InsertNewIR21A3(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_FormHeaderMsg char(100),
in In_Remarks char(100))
begin
  if not exists(select* from IR21A3 where
      IR21A3.PersonalSysID = In_PersonalSysID and
      IR21A3.YEYear = In_YEYear) then
    insert into IR21A3(PersonalSysID,
      YEYear,
      FormHeaderMsg,
      Remarks,
      LastChangedDateTime) values(
      In_PersonalSysID,
      In_YEYear,
      In_FormHeaderMsg,
      In_Remarks,
      now(*));
    commit work
  end if
end
;

create procedure dba.InsertNewIR21A3Record(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_IR21A3SysId integer,
in In_IR21A3StockOptionType char(20),
in In_RCBNo char(20),
in In_CompanyIDType char(20),
in In_CompanyName char(100),
in In_DateStockGranted date,
in In_ExercisePriceStock double,
in In_MktValueStockGrant double,
in In_MktValueExerciseStock double,
in In_SharesAcquired double,
in In_TypePlanGranted char(20),
in In_DateOfExpiryOfExercise date)
begin
  message 'in storproc InsertNewIR21A3Record' type info to console;
  if not exists(select* from IR21A3Record where
      IR21A3Record.PersonalSysID = In_PersonalSysID and
      IR21A3Record.YEYear = In_YEYear and
      IR21A3Record.IR21A3SysId = In_IR21A3SysId and
      IR21A3Record.IR21A3StockOptionType = In_IR21A3StockOptionType) then
    insert into IR21A3Record(PersonalSysID,
      YEYear,
      IR21A3SysId,
      IR21A3StockOptionType,
      RCBNo,
      CompanyIDType,
      CompanyName,
      DateStockGranted,
      ExercisePriceStock,
      MktValueStockGrant,
      MktValueExerciseStock,
      SharesAcquired,
      TypePlanGranted,
      DateOfExpiryOfExercise) values(
      In_PersonalSysID,
      In_YEYear,
      In_IR21A3SysId,
      In_IR21A3StockOptionType,
      In_RCBNo,
      In_CompanyIDType,
      In_CompanyName,
      In_DateStockGranted,
      In_ExercisePriceStock,
      In_MktValueStockGrant,
      In_MktValueExerciseStock,
      In_SharesAcquired,
      In_TypePlanGranted,
      In_DateOfExpiryOfExercise);
    commit work;
    update IR21A3 set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.InsertNewIR21Details(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_IR21Type integer,
in In_SupersedeIR21Date date,
in In_DateOfArrival date,
in In_DateOfDeparture date,
in In_DateResignationTendered date,
in In_ReasonsLessThan1Mth char(100),
in In_AmtOfMoniesWithheld double,
in In_DateLastSalaryPaid date,
in In_AmtOfLastSalaryPaid double,
in In_PeriodLastSalaryPaid char(50),
in In_ReasonsNotWithholding char(100),
in In_NameOfNewEmployer char(50),
in In_TelNoOfNewEmployer char(30),
in In_MailingAddEffDate date,
in In_DateOfMarriage date,
in In_UnexercisedGainsBef integer,
in In_UnexercisedGainsAft integer,
in In_SpouseNationality char(50))
begin
  if not exists(select* from IR21Details where
      IR21Details.PersonalSysID = In_PersonalSysID and
      IR21Details.YEYear = In_YEYear) then
    insert into IR21Details(PersonalSysID,
      YEYear,
      IR21Type,
      SupersedeIR21Date,
      DateOfArrival,
      DateOfDeparture,
      DateResignationTendered,
      ReasonsLessThan1Mth,
      AmtOfMoniesWithheld,
      DateLastSalaryPaid,
      AmtOfLastSalaryPaid,
      PeriodLastSalaryPaid,
      ReasonsNotWithholding,
      NameOfNewEmployer,
      TelNoOfNewEmployer,
      MailingAddEffDate,
      DateOfMarriage,
      UnexercisedGainsBef,
      UnexercisedGainsAft,
      SpouseNationality) values(
      In_PersonalSysID,
      In_YEYear,
      In_IR21Type,
      In_SupersedeIR21Date,
      In_DateOfArrival,
      In_DateOfDeparture,
      In_DateResignationTendered,
      In_ReasonsLessThan1Mth,
      In_AmtOfMoniesWithheld,
      In_DateLastSalaryPaid,
      In_AmtOfLastSalaryPaid,
      In_PeriodLastSalaryPaid,
      In_ReasonsNotWithholding,
      In_NameOfNewEmployer,
      In_TelNoOfNewEmployer,
      In_MailingAddEffDate,
      In_DateOfMarriage,
      In_UnexercisedGainsBef,
      In_UnexercisedGainsAft,
      In_SpouseNationality);
    commit work
  end if
end
;

create procedure dba.UpdateIR21A2(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_FormHeaderMsg char(100),
in In_TotalEESOPTaxExempt double,
in In_TotalCSOPTaxExempt double,
in In_TotalESOPNoTaxExempt double,
in In_TotalEESOPNoTaxExempt double,
in In_TotalCSOPNoTaxExempt double,
in In_TotalESOPStockGains double,
in In_TotalEESOPStockGains double,
in In_TotalCSOPStockGains double,
in In_GrandTotalStockGains double,
in In_OtherShareAmt double,
in In_Remarks char(100))
begin
  if exists(select* from IR21A2 where
      IR21A2.PersonalSysID = In_PersonalSysID and
      IR21A2.YEYear = In_YEYear) then
    update IR21A2 set
      FormHeaderMsg = In_FormHeaderMsg,
      TotalEESOPTaxExempt = In_TotalEESOPTaxExempt,
      TotalCSOPTaxExempt = In_TotalCSOPTaxExempt,
      TotalESOPNoTaxExempt = In_TotalESOPNoTaxExempt,
      TotalEESOPNoTaxExempt = In_TotalEESOPNoTaxExempt,
      TotalCSOPNoTaxExempt = In_TotalCSOPNoTaxExempt,
      TotalESOPStockGains = In_TotalESOPStockGains,
      TotalEESOPStockGains = In_TotalEESOPStockGains,
      TotalCSOPStockGains = In_TotalCSOPStockGains,
      GrandTotalStockGains = In_GrandTotalStockGains,
      OtherShareAmt = In_OtherShareAmt,
      Remarks = In_Remarks,
      LastChangedDateTime = now(*) where
      PersonalSysID = In_PersonalSysID and
      YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.UpdateIR21A2Record(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_IR21A2SysId integer,
in In_IR21A2StockOptionType char(20),
in In_RCBNo char(20),
in In_CompanyIDType char(20),
in In_CompanyName char(100),
in In_DateStockGranted date,
in In_DateExerciseStock date,
in In_ExercisePriceStock double,
in In_MktValueStockGrant double,
in In_MktValueExerciseStock double,
in In_SharesAcquired double,
in In_EESOPTaxExempt double,
in In_CSOPTaxExempt double,
in In_NoTaxExempt double,
in In_StockGains double,
in In_TypePlanGranted char(20),
in In_GrantedBef smallint,
in In_TypeOfExercise char(20))
begin
  if exists(select* from IR21A2Record where
      IR21A2Record.PersonalSysID = In_PersonalSysID and
      IR21A2Record.YEYear = In_YEYear and
      IR21A2Record.IR21A2SysId = In_IR21A2SysId and
      IR21A2Record.IR21A2StockOptionType = In_IR21A2StockOptionType) then
    update IR21A2Record set
      RCBNo = In_RCBNo,
      CompanyIDType = In_CompanyIDType,
      CompanyName = In_CompanyName,
      DateStockGranted = In_DateStockGranted,
      DateExerciseStock = In_DateExerciseStock,
      ExercisePriceStock = In_ExercisePriceStock,
      MktValueStockGrant = In_MktValueStockGrant,
      MktValueExerciseStock = In_MktValueExerciseStock,
      SharesAcquired = In_SharesAcquired,
      EESOPTaxExempt = In_EESOPTaxExempt,
      CSOPTaxExempt = In_CSOPTaxExempt,
      NoTaxExempt = In_NoTaxExempt,
      StockGains = In_StockGains,
      TypePlanGranted = In_TypePlanGranted,
      GrantedBef = In_GrantedBef,
      TypeOfExercise = In_TypeOfExercise where
      PersonalSysID = In_PersonalSysID and
      YEYear = In_YEYear and
      IR21A2SysId = In_IR21A2SysId and
      IR21A2StockOptionType = In_IR21A2StockOptionType;
    commit work;
    update IR21A2 set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.UpdateIR21A3(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_FormHeaderMsg char(100),
in In_Remarks char(100))
begin
  if exists(select* from IR21A3 where
      IR21A3.PersonalSysID = In_PersonalSysID and
      IR21A3.YEYear = In_YEYear) then
    update IR21A3 set
      FormHeaderMsg = In_FormHeaderMsg,
      Remarks = In_Remarks,
      LastChangedDateTime = now(*) where
      PersonalSysID = In_PersonalSysID and
      YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure dba.UpdateIR21A3Record(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_IR21A3SysId integer,
in In_IR21A3StockOptionType char(20),
in In_RCBNo char(20),
in In_CompanyIDType char(20),
in In_CompanyName char(100),
in In_DateStockGranted date,
in In_ExercisePriceStock double,
in In_MktValueStockGrant double,
in In_MktValueExerciseStock double,
in In_SharesAcquired double,
in In_TypePlanGranted char(20),
in In_DateOfExpiryOfExercise date)
begin
  if exists(select* from IR21A3Record where
      IR21A3Record.PersonalSysID = In_PersonalSysID and
      IR21A3Record.YEYear = In_YEYear and
      IR21A3Record.IR21A3SysId = In_IR21A3SysId and
      IR21A3Record.IR21A3StockOptionType = In_IR21A3StockOptionType) then
    update IR21A3Record set
      RCBNo = In_RCBNo,
      CompanyIDType = In_CompanyIDType,
      CompanyName = In_CompanyName,
      DateStockGranted = In_DateStockGranted,
      ExercisePriceStock = In_ExercisePriceStock,
      MktValueStockGrant = In_MktValueStockGrant,
      MktValueExerciseStock = In_MktValueExerciseStock,
      SharesAcquired = In_SharesAcquired,
      TypePlanGranted = In_TypePlanGranted,
      DateOfExpiryOfExercise = In_DateOfExpiryOfExercise where
      PersonalSysID = In_PersonalSysID and
      YEYear = In_YEYear and
      IR21A3SysId = In_IR21A3SysId and
      IR21A3StockOptionType = In_IR21A3StockOptionType;
    commit work;
    update IR21A3 set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
    commit work
  end if
end
;

create procedure DBA.UpdateIR21Details(
in In_PersonalSysId integer,
in In_YEYear integer,
in In_IR21Type integer,
in In_SupersedeIR21Date date,
in In_DateOfArrival date,
in In_DateOfDeparture date,
in In_DateResignationTendered date,
in In_ReasonsLessThan1Mth char(100),
in In_AmtOfMoniesWithheld double,
in In_DateLastSalaryPaid date,
in In_AmtOfLastSalaryPaid double,
in In_PeriodLastSalaryPaid char(50),
in In_ReasonsNotWithholding char(100),
in In_NameOfNewEmployer char(50),
in In_TelNoOfNewEmployer char(30),
in In_MailingAddEffDate date,
in In_DateOfMarriage date,
in In_UnexercisedGainsBef integer,
in In_UnexercisedGainsAft integer,
in In_SpouseNationality char(50))
begin
  if exists(select* from IR21Details where
      IR21Details.PersonalSysID = In_PersonalSysID and
      IR21Details.YEYear = In_YEYear) then
    update IR21Details set
      IR21Type = In_IR21Type,
      SupersedeIR21Date = In_SupersedeIR21Date,
      DateOfArrival = In_DateOfArrival,
      DateOfDeparture = In_DateOfDeparture,
      DateResignationTendered = In_DateResignationTendered,
      ReasonsLessThan1Mth = In_ReasonsLessThan1Mth,
      AmtOfMoniesWithheld = In_AmtOfMoniesWithheld,
      DateLastSalaryPaid = In_DateLastSalaryPaid,
      AmtOfLastSalaryPaid = In_AmtOfLastSalaryPaid,
      PeriodLastSalaryPaid = In_PeriodLastSalaryPaid,
      ReasonsNotWithholding = In_ReasonsNotWithholding,
      NameOfNewEmployer = In_NameOfNewEmployer,
      TelNoOfNewEmployer = In_TelNoOfNewEmployer,
      MailingAddEffDate = In_MailingAddEffDate,
      DateOfMarriage = In_DateOfMarriage,
      UnexercisedGainsBef = In_UnexercisedGainsBef,
      SpouseNationality = In_SpouseNationality,
      UnexercisedGainsAft = In_UnexercisedGainsAft where
      IR21Details.PersonalSysID = In_PersonalSysID and
      IR21Details.YEYear = In_YEYear;
    commit work
  end if
end
;

create function dba.FGetYEKeywordDefaultName(
in In_KeywordID char(20))
returns char(100)
begin
  declare Out_YEKeywordDefaultName char(100);
  select YEKeywordDefaultName into Out_YEKeywordDefaultName from YEKeyword where
    YEKeywordId = In_KeywordID;
  return(Out_YEKeywordDefaultName)
end
;

create function dba.FGetIR21A1S2Items(
in In_Sec2ItemsNo char(3),
in In_YEYear integer,
in In_PersonalSysId integer)
returns char(150)
begin
  declare Out_ItemsResult char(150);
  declare FinalItem char(150);
  declare DisplayItemNo char(2);
  set Out_ItemsResult='';
  A8ASection2Loop: for A8ASection2For as ProcessA8ASec2Curs dynamic scroll cursor for
    select A8AS2.Sec2Items as Out_Sec2Items from
      A8AS2 where
      A8AS2.Sec2ItemsNo like In_Sec2ItemsNo+'%' and
      A8AS2.YEYear = In_YEYear and
      A8AS2.PersonalSysId = In_PersonalSysId order by A8AS2.Sec2ItemsNo asc do
    set Out_ItemsResult=Out_ItemsResult+' '+Out_Sec2Items+'/' end for;
  case upper(In_Sec2ItemsNo) when 'A' then
    set DisplayItemNo='1' when 'B' then
    set DisplayItemNo='2' when 'C' then
    set DisplayItemNo='3' when 'D' then
    set DisplayItemNo='4' when 'E' then
    set DisplayItemNo='5' when 'F' then
    set DisplayItemNo='6' when 'G' then
    set DisplayItemNo='7' when 'K' then
    set DisplayItemNo='8' when 'H' then
    set DisplayItemNo='10' when 'I' then
    set DisplayItemNo='11' when 'J' then
    set DisplayItemNo='12'
  end case
  ;
  set FinalItem=DisplayItemNo+'. '+STUFF(Out_ItemsResult,length(Out_ItemsResult),1,null);
  return(FinalItem)
end
;

create procedure dba.DeleteIR21DetailsByPersonalSysID(
in In_PersonalSysID integer)
begin
  if exists(select* from IR21Details where
      IR21Details.PersonalSysID = In_PersonalSysID) then
    delete from IR21Details where
      IR21Details.PersonalSysID = In_PersonalSysID;
    commit work
  end if
end
;

create procedure DBA.ASQLCalPayPeriodBalMedisave(
in In_EmployeeSysId char(20),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
out Out_PeriodMediSaveOrdinary double,
out Out_PeriodMediSaveAdditional double,
out Out_YTDMediSaveAdditional double)
begin
  declare Tmp_MediSaveOrdinary double;
  declare Tmp_MediSaveAdditional double;
  /*
  Get accumulated contributions for the period excluding current record
  */
  select FConvertNull(sum(CurrentTaxAmount)) into Out_PeriodMediSaveOrdinary from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod <= In_PayRecSubPeriod;
  select FConvertNull(sum(PreviousTaxAmount)) into Out_PeriodMediSaveAdditional from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod <= In_PayRecSubPeriod;
  /*
  Get accumulated additional contribution for the year excluding current record
  */
  select FConvertNull(sum(PreviousTaxAmount)) into Out_YTDMediSaveAdditional from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod <= In_PayRecPeriod and
    PayRecSubPeriod <= In_PayRecSubPeriod;
  /*
  Get the specified Record
  */
  select FConvertNull(sum(CurrentTaxAmount)),FConvertNull(sum(PreviousTaxAmount)) into Tmp_MediSaveOrdinary,
    Tmp_MediSaveAdditional from PolicyRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  /*
  Deduct away from the specified
  */
  set Out_PeriodMediSaveOrdinary=Out_PeriodMediSaveOrdinary-Tmp_MediSaveOrdinary;
  set Out_PeriodMediSaveAdditional=Out_PeriodMediSaveAdditional-Tmp_MediSaveAdditional;
  set Out_YTDMediSaveAdditional=Out_YTDMediSaveAdditional-Tmp_MediSaveAdditional
end
;

create procedure DBA.DeleteMedisaveProgression(
in In_MedisaveEffectiveDate date)
begin
  declare CtrCurrent integer;
  declare EmpSysId integer;
  declare CtrStartDate date;
  if exists(select* from MedisaveProgression where
      MedisaveProgression.MedisaveEffectiveDate = In_MedisaveEffectiveDate) then
    delete from MedisaveProgression where
      MedisaveProgression.MedisaveEffectiveDate = In_MedisaveEffectiveDate;
    commit work
  end if
end
;

create procedure DBA.InsertNewMedisaveProgression(
in In_MedisaveEffectiveDate date,
in In_MedisaveTotalWageCapping double,
in In_MedisaveContriRate double,
in In_MedisaveMaxOrdContri double,
in In_MedisaveMaxAddContri double,
in In_MedisaveRemarks char(255))
begin
  if not exists(select* from MedisaveProgression where
      MedisaveProgression.MEdisaveEffectiveDate = In_MedisaveEffectiveDate) then
    insert into MedisaveProgression(MedisaveEffectiveDate,
      MedisaveTotalWageCapping,
      MedisaveContriRate,
      MedisaveMaxOrdContri,
      MedisaveMaxAddContri,
      MedisaveRemarks) values(
      In_MedisaveEffectiveDate,
      In_MedisaveTotalWageCapping,
      In_MedisaveContriRate,
      In_MedisaveMaxOrdContri,
      In_MedisaveMaxAddContri,
      In_MedisaveRemarks);
    commit work
  end if
end
;

create procedure DBA.UpdateMedisaveProgression(
in In_MedisaveEffectiveDate date,
in In_MedisaveTotalWageCapping double,
in In_MedisaveContriRate double,
in In_MedisaveMaxOrdContri double,
in In_MedisaveMaxAddContri double,
in In_MedisaveRemarks char(255))
begin
  if exists(select* from MedisaveProgression where
      MedisaveProgression.MEdisaveEffectiveDate = In_MedisaveEffectiveDate) then
    update MedisaveProgression set
      MedisaveEffectiveDate = In_MedisaveEffectiveDate,
      MedisaveTotalWageCapping = In_MedisaveTotalWageCapping,
      MedisaveContriRate = In_MedisaveContriRate,
      MedisaveMaxOrdContri = In_MedisaveMaxOrdContri,
      MedisaveMaxAddContri = In_MedisaveMaxAddContri,
      MedisaveRemarks = In_MedisaveRemarks where
      MedisaveProgression.MEdisaveEffectiveDate = In_MedisaveEffectiveDate;
    commit work
  end if
end
;

create procedure dba.ASQLYEProcessPension(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_IR8AType char(20),
in In_Operation char(20),
out Out_ProcessResult integer,
out Out_PensionAmt double)
begin
  set Out_ProcessResult=1;
  set Out_PensionAmt=0
end
;

create function DBA.FGetMedisaveAmt(
in In_EmployeeSysId integer,
in In_Grouping char(255),
in In_BasisValue char(255),
in In_PayGroup char(255),
in In_Year integer,
in In_Period integer) 
returns double
begin
  declare Out_MedisaveAmt double;
  if In_Grouping = 'EmployeeSysId' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    end if
  elseif In_Grouping = 'Department' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayDepartmentId = In_BasisValue and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.PayDepartmentId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayDepartmentId = In_BasisValue and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.PayDepartmentId
    end if
  elseif In_Grouping = 'PayBranchId' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayBranchId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayBranchId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    end if
  elseif In_Grouping = 'PayCategoryId' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayCategoryId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayCategoryId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    end if
  elseif In_Grouping = 'PayClassification' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayClassification = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayClassification = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    end if
  elseif In_Grouping = 'PayCostCentreId' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayCostCentreId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayCostCentreId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    end if
  elseif In_Grouping = 'PayDepartmentId' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayDepartmentId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayDepartmentId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    end if
  elseif In_Grouping = 'PayEmpCode1Id' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayEmpCode1Id = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayEmpCode1Id = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    end if
  elseif In_Grouping = 'PayEmpCode2Id' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayEmpCode2Id = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayEmpCode2Id = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    end if
  elseif In_Grouping = 'PayEmpCode3Id' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayEmpCode3Id = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayEmpCode3Id = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    end if
  elseif In_Grouping = 'PayEmpCode4Id' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayEmpCode4Id = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayEmpCode4Id = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    end if
  elseif In_Grouping = 'PayEmpCode5Id' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayEmpCode5Id = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayEmpCode5Id = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    end if
  elseif In_Grouping = 'PayLeaveGroupId' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayLeaveGroupId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayLeaveGroupId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    end if
  elseif In_Grouping = 'PayPayGroupId' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayPayGroupId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayPayGroupId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    end if
  elseif In_Grouping = 'PayPositionId' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayPositionId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PayPositionId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    end if
  elseif In_Grouping = 'PaySalaryGradeId' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PaySalaryGradeId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PaySalaryGradeId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    end if
  elseif In_Grouping = 'PaySectionId' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PaySectionId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.PaySectionId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    end if
  elseif In_Grouping = 'PayWTCalendarId' then
    if(In_PayGroup = '') then
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.EmployeeSysId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    else
      select SUM(MedisaveOrdinary+MedisaveAdditional) into Out_MedisaveAmt
        from PayPeriodRecord join PeriodPolicySummary where
        PayPeriodRecord.EmployeeSysId = In_BasisValue and
        PayPeriodRecord.EmployeeSysId = In_EmployeeSysId and
        PayPeriodRecord.PayPayGroupId = In_PayGroup and
        PayPeriodRecord.PayRecYear = In_Year and
        PayPeriodRecord.PayRecPeriod = In_Period
        group by PayPeriodRecord.EmployeeSysId
    end if
  end if;
  if Out_MedisaveAmt is null then
    return 0
  else
    return Out_MedisaveAmt
  end if
end
;

Commit Work;