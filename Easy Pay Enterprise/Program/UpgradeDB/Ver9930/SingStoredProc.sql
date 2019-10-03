/*==============================================================*/
/* DBMS name:      Sybase AS Anywhere 9                         */
/* Created on:     08-09-2008 4:01:50 PM                        */
/*==============================================================*/


if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateYEEmployer' and user_name(creator) = 'DBA') then
   drop procedure DBA.UpdateYEEmployer
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateYEEmployee' and user_name(creator) = 'DBA') then
   drop procedure DBA.UpdateYEEmployee
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateIR21Details' and user_name(creator) = 'DBA') then
   drop procedure DBA.UpdateIR21Details
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateIR21A2Record' and user_name(creator) = 'DBA') then
   drop procedure DBA.UpdateIR21A2Record
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateIR21A2' and user_name(creator) = 'DBA') then
   drop procedure DBA.UpdateIR21A2
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateA8BRecord' and user_name(creator) = 'DBA') then
   drop procedure DBA.UpdateA8BRecord
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'UpdateA8B' and user_name(creator) = 'DBA') then
   drop procedure DBA.UpdateA8B
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewYEEmployer' and user_name(creator) = 'DBA') then
   drop procedure DBA.InsertNewYEEmployer
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewYEEmployee' and user_name(creator) = 'DBA') then
   drop procedure DBA.InsertNewYEEmployee
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewIR21Details' and user_name(creator) = 'DBA') then
   drop procedure DBA.InsertNewIR21Details
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewIR21A2Record' and user_name(creator) = 'DBA') then
   drop procedure DBA.InsertNewIR21A2Record
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewIR21A2' and user_name(creator) = 'DBA') then
   drop procedure DBA.InsertNewIR21A2
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewA8BRecord' and user_name(creator) = 'DBA') then
   drop procedure DBA.InsertNewA8BRecord
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'InsertNewA8B' and user_name(creator) = 'DBA') then
   drop procedure DBA.InsertNewA8B
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetYEEmployeeCPFAge' and user_name(creator) = 'DBA') then
   drop function DBA.FGetYEEmployeeCPFAge
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'FConvertNullDate' and user_name(creator) = 'DBA') then
   drop function DBA.FConvertNullDate
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLYEProcessYEEmployee' and user_name(creator) = 'DBA') then
   drop procedure DBA.ASQLYEProcessYEEmployee
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLYEProcessIR21A2' and user_name(creator) = 'DBA') then
   drop procedure DBA.ASQLYEProcessIR21A2
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLYEProcessIR21' and user_name(creator) = 'DBA') then
   drop procedure DBA.ASQLYEProcessIR21
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLYEProcessA8B' and user_name(creator) = 'DBA') then
   drop procedure DBA.ASQLYEProcessA8B
end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLYEEmploymentHistory' and user_name(creator) = 'DBA') then
   drop procedure DBA.ASQLYEEmploymentHistory
end if;


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
    select first PayPayGroupId into Out_YEPayGroupId from
      PayPeriodRecord where EmployeeSysId = Out_YEEmployeeSysId and
      PayRecYear = In_YEYear order by PayRecPeriod desc;
    call InsertNewEmploymentHistory(In_PersonalSysId,
    In_YEYear,
    Out_YEEmployeeSysId,
    Out_YEPayGroupId,
    Out_FromDate,
    Out_ToDate) end for
end;


create procedure DBA.ASQLYEProcessA8B(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_Operation char(20))
begin
  declare Out_TotalEESOPTaxExempt double;
  declare Out_TotalCSOPTaxExempt double;
  declare Out_TotalNSOPTaxExempt double;
  declare Out_TotalESOPNoTaxExempt double;
  declare Out_TotalEESOPNoTaxExempt double;
  declare Out_TotalCSOPNoTaxExempt double;
  declare Out_TotalNSOPNoTaxExempt double;
  declare Out_TotalESOPStockGains double;
  declare Out_TotalEESOPStockGains double;
  declare Out_TotalCSOPStockGains double;
  declare Out_TotalNSOPStockGains double;
  declare Out_GrandTotalStockGains double;
  declare Out_TotalESOPNoTaxExemptBef double;
  declare Out_TotalESOPStockGainsBef double;
  declare Out_TotalEESOPTaxExemptBef double;
  declare Out_TotalEESOPNoTaxExemptBef double;
  declare Out_TotalEESOPStockGainsBef double;
  declare Out_TotalCSOPTaxExemptBef double;
  declare Out_TotalCSOPNoTaxExemptBef double;
  declare Out_TotalCSOPStockGainsBef double;
  declare Out_TotalNSOPTaxExemptBef double;
  declare Out_TotalNSOPNoTaxExemptBef double;
  declare Out_TotalNSOPStockGainsBef double;
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
    0,
    0,
    0,
    0,'',
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0)
  end if;
  /*
  To compute ESOP (Section A)
  */
  update A8BRecord set
    EESOPTaxExempt = 0,
    CSOPTaxExempt = 0,
    NSOPTaxExempt = 0,
    NoTaxExempt = Round((MktValueExerciseStock-ExercisePriceStock)*SharesAcquired,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'ESOP';
  update A8BRecord set
    StockGains = Round(NoTaxExempt,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'ESOP';
  /*
  To compute EESOP (Section B)
  */
  update A8BRecord set
    EESOPTaxExempt = Round((MktValueExerciseStock-MktValueStockGrant)*SharesAcquired,2),
    CSOPTaxExempt = 0,
    NSOPTaxExempt = 0,
    NoTaxExempt = Round((MktValueStockGrant-ExercisePriceStock)*SharesAcquired,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'EESOP';
  update A8BRecord set
    StockGains = Round(EESOPTaxExempt+NoTaxExempt,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'EESOP';
  /*
  To compute CSOP (Section C)
  */
  update A8BRecord set
    EESOPTaxExempt = 0,
    CSOPTaxExempt = Round((MktValueExerciseStock-MktValueStockGrant)*SharesAcquired,2),
    NSOPTaxExempt = 0,
    NoTaxExempt = Round((MktValueStockGrant-ExercisePriceStock)*SharesAcquired,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'CSOP';
  update A8BRecord set
    StockGains = Round(CSOPTaxExempt+NoTaxExempt,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'CSOP';
  /*
  To compute NSOP (Section D)
  */
  update A8BRecord set
    EESOPTaxExempt = 0,
    CSOPTaxExempt = 0,
    NSOPTaxExempt = Round((MktValueExerciseStock-MktValueStockGrant)*SharesAcquired,2),
    NoTaxExempt = Round((MktValueStockGrant-ExercisePriceStock)*SharesAcquired,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'NSOP';
  update A8BRecord set
    StockGains = Round(NSOPTaxExempt+NoTaxExempt,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'NSOP';
  /*
  To EESOP Tax Exempt (Section B)
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
  To CSOP Tax Exempt (Section C)
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
  To NSOP Tax Exempt (Section D)
  */
  select Sum(NSOPTaxExempt) into Out_TotalNSOPTaxExempt from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'NSOP';
  if(Out_TotalNSOPTaxExempt is null) then set Out_TotalNSOPTaxExempt=0
  end if;
  select Sum(NSOPTaxExempt) into Out_TotalNSOPTaxExemptBef from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'NSOP' and GrantedBef = 1;
  if(Out_TotalNSOPTaxExemptBef is null) then set Out_TotalNSOPTaxExemptBef=0
  end if;
  /*
  To ESOP's No Tax Exempt (Section A)
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
  To EESOP's No Tax Exempt (Section B)
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
  To CSOP's No Tax Exempt (Section C)
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
  To NSOP's No Tax Exempt (Section D)
  */
  select Sum(NoTaxExempt) into Out_TotalNSOPNoTaxExempt from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'NSOP';
  if(Out_TotalNSOPNoTaxExempt is null) then set Out_TotalNSOPNoTaxExempt=0
  end if;
  select Sum(NoTaxExempt) into Out_TotalNSOPNoTaxExemptBef from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'NSOP' and GrantedBef = 1;
  if(Out_TotalNSOPNoTaxExemptBef is null) then set Out_TotalNSOPNoTaxExemptBef=0
  end if;
  /*
  To ESOP's Stock Gain (Section A)
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
  To EESOP's Stock Gain (Section B)
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
  To CSOP's Stock Gain (Section C)
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
  To NSOP's Stock Gain (Section D)
  */
  select Sum(StockGains) into Out_TotalNSOPStockGains from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'NSOP';
  if(Out_TotalNSOPStockGains is null) then set Out_TotalNSOPStockGains=0
  end if;
  select Sum(StockGains) into Out_TotalNSOPStockGainsBef from A8BRecord where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and StockOptionType = 'NSOP' and GrantedBef = 1;
  if(Out_TotalNSOPStockGainsBef is null) then set Out_TotalNSOPStockGainsBef=0
  end if;
  /*
  Compute Grand Total
  */
  update A8B set
    TotalEESOPTaxExempt = Out_TotalEESOPTaxExempt,
    TotalCSOPTaxExempt = Out_TotalCSOPTaxExempt,
    TotalNSOPTaxExempt = Out_TotalNSOPTaxExempt,
    TotalESOPNoTaxExempt = Out_TotalESOPNoTaxExempt,
    TotalEESOPNoTaxExempt = Out_TotalEESOPNoTaxExempt,
    TotalCSOPNoTaxExempt = Out_TotalCSOPNoTaxExempt,
    TotalNSOPNoTaxExempt = Out_TotalNSOPNoTaxExempt,
    TotalESOPStockGains = Out_TotalESOPStockGains,
    TotalEESOPStockGains = Out_TotalEESOPStockGains,
    TotalCSOPStockGains = Out_TotalCSOPStockGains,
    TotalNSOPStockGains = Out_TotalNSOPStockGains,
    TotalEESOPTaxExemptBef = Out_TotalEESOPTaxExemptBef,
    TotalCSOPTaxExemptBef = Out_TotalCSOPTaxExemptBef,
    TotalNSOPTaxExemptBef = Out_TotalNSOPTaxExemptBef,
    TotalESOPNoTaxExemptBef = Out_TotalESOPNoTaxExemptBef,
    TotalEESOPNoTaxExemptBef = Out_TotalEESOPNoTaxExemptBef,
    TotalCSOPNoTaxExemptBef = Out_TotalCSOPNoTaxExemptBef,
    TotalNSOPNoTaxExemptBef = Out_TotalNSOPNoTaxExemptBef,
    TotalESOPStockGainsBef = Out_TotalESOPStockGainsBef,
    TotalEESOPStockGainsBef = Out_TotalEESOPStockGainsBef,
    TotalCSOPStockGainsBef = Out_TotalCSOPStockGainsBef,
    TotalNSOPStockGainsBef = Out_TotalNSOPStockGainsBef where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  update A8B set
    GrandTotalStockGains
     = Out_TotalESOPStockGains+
    Out_TotalEESOPStockGains+
    Out_TotalCSOPStockGains+
    Out_TotalNSOPStockGains where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  commit work
end;


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
    elseif(SubString(In_ResidenceTypeId,1,2) = 'PR') then
      select HireDate,CessationDate into In_DateOfArrival,In_DateOfDeparture from Employee where
        EmployeeSysId = In_EmployeeSysID
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
    set In_DateOfArrival=FConvertNullDate(In_DateOfArrival);
    set In_DateOfDeparture=FConvertNullDate(In_DateOfDeparture);
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
    0,'', //In_UnexercisedGainsAft
    //SpouseNationality
    0) //In_MoniesStatus 
  end if;
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
end;


create procedure DBA.ASQLYEProcessIR21A2(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_Operation char(20))
begin
  declare Out_TotalEESOPTaxExempt double;
  declare Out_TotalCSOPTaxExempt double;
  declare Out_TotalNSOPTaxExempt double;
  declare Out_TotalESOPNoTaxExempt double;
  declare Out_TotalEESOPNoTaxExempt double;
  declare Out_TotalCSOPNoTaxExempt double;
  declare Out_TotalNSOPNoTaxExempt double;
  declare Out_TotalESOPStockGains double;
  declare Out_TotalEESOPStockGains double;
  declare Out_TotalCSOPStockGains double;
  declare Out_TotalNSOPStockGains double;
  declare Out_GrandTotalStockGains double;
  if(In_Operation = 'Create') then
    call InsertNewIR21A2(
    In_PersonalSysID,
    In_YEYear,'',
    //In_FormHeaderMsg
    0, //In_TotalEESOPTaxExempt
    0, //In_TotalCSOPTaxExempt
    0, //In_TotalNSOPTaxExempt
    0, //In_TotalESOPNoTaxExempt
    0, //In_TotalEESOPNoTaxExempt
    0, //In_TotalCSOPNoTaxExempt
    0, //In_TotalNSOPNoTaxExempt
    0, //In_TotalESOPStockGains
    0, //In_TotalEESOPStockGains
    0, //In_TotalCSOPStockGains
    0, //In_TotalNSOPStockGains
    0, //In_GrandTotalStockGains
    0,'') //In_OtherShareAmt
  end if;
  //In_Remarks
  /*
  To compute ESOP
  */
  update IR21A2Record set
    EESOPTaxExempt = 0,
    CSOPTaxExempt = 0,
    NSOPTaxExempt = 0,
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
    NSOPTaxExempt = 0,
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
    NSOPTaxExempt = 0,
    NoTaxExempt = Round((MktValueStockGrant-ExercisePriceStock)*SharesAcquired,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'CSOP';
  update IR21A2Record set
    StockGains = Round(CSOPTaxExempt+NoTaxExempt,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'CSOP';
  /*
  To compute NSOP
  */
  update IR21A2Record set
    EESOPTaxExempt = 0,
    CSOPTaxExempt = 0,
    NSOPTaxExempt = Round((MktValueExerciseStock-MktValueStockGrant)*SharesAcquired,2),
    NoTaxExempt = Round((MktValueStockGrant-ExercisePriceStock)*SharesAcquired,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'NSOP';
  update IR21A2Record set
    StockGains = Round(NSOPTaxExempt+NoTaxExempt,2) where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'NSOP';
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
  To NSOP Tax Exempt
  */
  select Sum(NSOPTaxExempt) into Out_TotalNSOPTaxExempt from IR21A2Record where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'NSOP';
  if(Out_TotalNSOPTaxExempt is null) then set Out_TotalNSOPTaxExempt=0
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
  To NSOP's No Tax Exempt
  */
  select Sum(NoTaxExempt) into Out_TotalNSOPNoTaxExempt from IR21A2Record where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'NSOP';
  if(Out_TotalNSOPNoTaxExempt is null) then set Out_TotalNSOPNoTaxExempt=0
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
  To NSOP's Stock Gain
  */
  select Sum(StockGains) into Out_TotalNSOPStockGains from IR21A2Record where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear and IR21A2StockOptionType = 'NSOP';
  if(Out_TotalNSOPStockGains is null) then set Out_TotalNSOPStockGains=0
  end if;
  /*
  Compute Grand Total
  */
  update IR21A2 set
    TotalEESOPTaxExempt = Out_TotalEESOPTaxExempt,
    TotalCSOPTaxExempt = Out_TotalCSOPTaxExempt,
    TotalNSOPTaxExempt = Out_TotalNSOPTaxExempt,
    TotalESOPNoTaxExempt = Out_TotalESOPNoTaxExempt,
    TotalEESOPNoTaxExempt = Out_TotalEESOPNoTaxExempt,
    TotalCSOPNoTaxExempt = Out_TotalCSOPNoTaxExempt,
    TotalNSOPNoTaxExempt = Out_TotalNSOPNoTaxExempt,
    TotalESOPStockGains = Out_TotalESOPStockGains,
    TotalEESOPStockGains = Out_TotalEESOPStockGains,
    TotalCSOPStockGains = Out_TotalCSOPStockGains,
    TotalNSOPStockGains = Out_TotalNSOPStockGains where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  update IR21A2 set
    GrandTotalStockGains = Out_TotalESOPStockGains+Out_TotalEESOPStockGains+Out_TotalCSOPStockGains+Out_TotalNSOPStockGains where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  commit work
end;


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
  declare In_Designation char(30);
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
end;


create function DBA.FConvertNullDate(in in_value date)
returns date
begin
  declare convertedValue date;
  if in_value is null then set convertedValue='1899-12-30'
  else set convertedValue=in_Value
  end if;
  return(convertedValue)
end;


create function DBA.FGetYEEmployeeCPFAge(
in in_EmployeeSysId integer,
in In_PayGroupId char(20),
in in_PayRecYear integer,
in in_PayRecPeriod integer,
in in_PayRecSubPeriod integer)
returns double
begin
  declare in_StartDate date;
  declare in_DateOfBirth date;
  declare in_PersonalSysId integer;
  declare iEmpeeCPFAge double;
  declare TempAge double;
  select PersonalSysId into in_PersonalSysId from Employee where
    EmployeeSysId = in_EmployeeSysId;
  select DateOfBirth into in_DateOfBirth from Personal where PersonalSysId = in_PersonalSysId;
  select SubPeriodStartDate into in_StartDate from PayGroupPeriod where
    PayGroupId = in_PayGroupId and
    PayGroupYear = in_PayRecYear and
    PayGroupPeriod = in_PayRecPeriod and
    PayGroupSubPeriod = 1;
  set TempAge=Months(in_DateOfBirth,in_StartDate);
  set iEmpeeCPFAge=Round(TempAge/12,2);
  return(iEmpeeCPFAge)
end;


create procedure DBA.InsertNewA8B(
in In_PersonalsysId integer,
in In_YEYear integer,
in In_FormHeaderMsg char(100),
in In_TotalEESOPTaxExempt double,
in In_TotalCSOPTaxExempt double,
in In_TotalNSOPTaxExempt double,
in In_TotalESOPNoTaxExempt double,
in In_TotalEESOPNoTaxExempt double,
in In_TotalCSOPNoTaxExempt double,
in In_TotalNSOPNoTaxExempt double,
in In_TotalESOPStockGains double,
in In_TotalEESOPStockGains double,
in In_TotalCSOPStockGains double,
in In_TotalNSOPStockGains double,
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
in In_TotalCSOPStockGainsBef double,
in In_TotalNSOPTaxExemptBef double,
in In_TotalNSOPNoTaxExemptBef double,
in In_TotalNSOPStockGainsBef double)
begin
  if not exists(select* from A8B where
      A8B.PersonalSysId = In_PersonalsysId and
      A8B.YEYear = In_YEYear) then
    insert into A8B(PersonalsysId,
      YEYear,
      FormHeaderMsg,
      TotalEESOPTaxExempt,
      TotalCSOPTaxExempt,
      TotalNSOPTaxExempt,
      TotalESOPNoTaxExempt,
      TotalEESOPNoTaxExempt,
      TotalCSOPNoTaxExempt,
      TotalNSOPNoTaxExempt,
      TotalESOPStockGains,
      TotalEESOPStockGains,
      TotalCSOPStockGains,
      TotalNSOPStockGains,
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
      TotalNSOPTaxExemptBef,
      TotalNSOPNoTaxExemptBef,
      TotalNSOPStockGainsBef,
      LastChangedDateTime) values(In_PersonalsysId,
      In_YEYear,
      In_FormHeaderMsg,
      In_TotalEESOPTaxExempt,
      In_TotalCSOPTaxExempt,
      In_TotalNSOPTaxExempt,
      In_TotalESOPNoTaxExempt,
      In_TotalEESOPNoTaxExempt,
      In_TotalCSOPNoTaxExempt,
      In_TotalNSOPNoTaxExempt,
      In_TotalESOPStockGains,
      In_TotalEESOPStockGains,
      In_TotalCSOPStockGains,
      In_TotalNSOPStockGains,
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
      In_TotalNSOPTaxExemptBef,
      In_TotalNSOPNoTaxExemptBef,
      In_TotalNSOPStockGainsBef,
      now(*));
    commit work
  end if
end;


create procedure DBA.InsertNewA8BRecord(
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
in In_NSOPTaxExempt double,
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
      select(case when YEProperty3 <= Year(In_DateStockGranted) then 0 else 1 end) into 
        In_GrantedBef from YEKeyword where YEKeywordid = 'A8B'
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
      NSOPTaxExempt,
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
      In_NSOPTaxExempt,
      In_NoTaxExempt,
      In_StockGains,
      In_GrantedBef);
    commit work;
    update A8B set LastChangedDateTime = now(*) where 
        PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
    commit work
  end if
end;


create procedure DBA.InsertNewIR21A2(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_FormHeaderMsg char(100),
in In_TotalEESOPTaxExempt double,
in In_TotalCSOPTaxExempt double,
in In_TotalNSOPTaxExempt double,
in In_TotalESOPNoTaxExempt double,
in In_TotalEESOPNoTaxExempt double,
in In_TotalCSOPNoTaxExempt double,
in In_TotalNSOPNoTaxExempt double,
in In_TotalESOPStockGains double,
in In_TotalEESOPStockGains double,
in In_TotalCSOPStockGains double,
in In_TotalNSOPStockGains double,
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
      TotalNSOPTaxExempt,
      TotalESOPNoTaxExempt,
      TotalEESOPNoTaxExempt,
      TotalCSOPNoTaxExempt,
      TotalNSOPNoTaxExempt,
      TotalESOPStockGains,
      TotalEESOPStockGains,
      TotalCSOPStockGains,
      TotalNSOPStockGains,
      GrandTotalStockGains,
      OtherShareAmt,
      Remarks,
      LastChangedDateTime) values(
      In_PersonalSysID,
      In_YEYear,
      In_FormHeaderMsg,
      In_TotalEESOPTaxExempt,
      In_TotalCSOPTaxExempt,
      In_TotalNSOPTaxExempt,
      In_TotalESOPNoTaxExempt,
      In_TotalEESOPNoTaxExempt,
      In_TotalCSOPNoTaxExempt,
      In_TotalNSOPNoTaxExempt,
      In_TotalESOPStockGains,
      In_TotalEESOPStockGains,
      In_TotalCSOPStockGains,
      In_TotalNSOPStockGains,
      In_GrandTotalStockGains,
      In_OtherShareAmt,
      In_Remarks,
      now(*));
    commit work
  end if
end;


create procedure DBA.InsertNewIR21A2Record(
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
in In_NSOPTaxExempt double,
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
      NSOPTaxExempt,
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
      In_NSOPTaxExempt,
      In_NoTaxExempt,
      In_StockGains,
      In_TypePlanGranted,
      In_GrantedBef,
      In_TypeOfExercise);
    commit work;
    update IR21A2 set LastChangedDateTime = now(*) where 
        PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
    commit work
  end if
end;


create procedure DBA.InsertNewIR21Details(
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
in In_SpouseNationality char(50),
in In_MoniesStatus integer)
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
      SpouseNationality,
      MoniesStatus) values(
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
      In_SpouseNationality,
      In_MoniesStatus);
    commit work
  end if
end;


create procedure DBA.InsertNewYEEmployee(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_CurrentYEGlobalId char(20),
in In_YEEmployerId char(20),
in In_TaxNo char(20),
in In_Designation char(30),
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
end;


create procedure DBA.InsertNewYEEmployer(
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
in In_FaxNo char(20),
in In_DateIncorporation date,
in In_AddressBlock char(20),
in In_AddressStorey char(20),
in In_AddressUnit char(20),
in In_AddressStreetName char(100),
in In_AddressPostalCode char(20))
begin
  if not exists(select* from YEEmployer where 
        YEEmployer.YEEmployerID = In_YEEmployerID) then
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
      FaxNo,
      DateIncorporation,
      AddressBlock,
      AddressStorey,
      AddressUnit,
      AddressStreetName,
      AddressPostalCode) values(
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
      In_FaxNo,
      In_DateIncorporation,
      In_AddressBlock,
      In_AddressStorey,
      In_AddressUnit,
      In_AddressStreetName,
      In_AddressPostalCode);
    commit work
  end if
end;


create procedure DBA.UpdateA8B(
in In_PersonalsysId integer,
in In_YEYear integer,
in In_FormHeaderMsg char(100),
in In_TotalEESOPTaxExempt double,
in In_TotalCSOPTaxExempt double,
in In_TotalNSOPTaxExempt double,
in In_TotalESOPNoTaxExempt double,
in In_TotalEESOPNoTaxExempt double,
in In_TotalCSOPNoTaxExempt double,
in In_TotalNSOPNoTaxExempt double,
in In_TotalESOPStockGains double,
in In_TotalEESOPStockGains double,
in In_TotalCSOPStockGains double,
in In_TotalNSOPStockGains double,
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
in In_TotalCSOPStockGainsBef double,
in In_TotalNSOPTaxExemptBef double,
in In_TotalNSOPNoTaxExemptBef double,
in In_TotalNSOPStockGainsBef double)
begin
  if exists(select* from A8B where
      A8B.PersonalSysId = In_PersonalsysId and
      A8B.YEYear = In_YEYear) then
    update A8B set
      A8B.FormHeaderMsg = In_FormHeaderMsg,
      A8B.TotalEESOPTaxExempt = In_TotalEESOPTaxExempt,
      A8B.TotalCSOPTaxExempt = In_TotalCSOPTaxExempt,
      A8B.TotalNSOPTaxExempt = In_TotalNSOPTaxExempt,
      A8B.TotalESOPNoTaxExempt = In_TotalESOPNoTaxExempt,
      A8B.TotalEESOPNoTaxExempt = In_TotalEESOPNoTaxExempt,
      A8B.TotalCSOPNoTaxExempt = In_TotalCSOPNoTaxExempt,
      A8B.TotalNSOPNoTaxExempt = In_TotalNSOPNoTaxExempt,
      A8B.TotalESOPStockGains = In_TotalESOPStockGains,
      A8B.TotalEESOPStockGains = In_TotalEESOPStockGains,
      A8B.TotalCSOPStockGains = In_TotalCSOPStockGains,
      A8B.TotalNSOPStockGains = In_TotalNSOPStockGains,
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
      A8B.TotalNSOPTaxExemptBef = In_TotalNSOPTaxExemptBef,
      A8B.TotalNSOPNoTaxExemptBef = In_TotalNSOPNoTaxExemptBef,
      A8B.TotalNSOPStockGainsBef = In_TotalNSOPStockGainsBef,
      A8B.LastChangedDateTime = now(*) where
      A8B.PersonalSysId = In_PersonalsysId and
      A8B.YEYear = In_YEYear;
    commit work
  end if
end;


create procedure DBA.UpdateA8BRecord(
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
in In_NSOPTaxExempt double,
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
      select(case when YEProperty3 <= Year(In_DateStockGranted) then 0 else 1 end) into 
        In_GrantedBef from YEKeyword where YEKeywordid = 'A8B'
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
      A8BRecord.NSOPTaxExempt = In_NSOPTaxExempt,
      A8BRecord.NoTaxExempt = In_NoTaxExempt,
      A8BRecord.StockGains = In_StockGains,
      A8BRecord.GrantedBef = In_GrantedBef where
      A8BRecord.PersonalSysId = In_PersonalSysId and
      A8BRecord.YEYear = In_YEYear and
      A8BRecord.A8BSysId = In_A8BSysId and
      A8BRecord.StockOptionType = In_StockOptionType;
    commit work;
    update A8B set LastChangedDateTime = now(*) where 
        PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
    commit work
  end if
end;


create procedure DBA.UpdateIR21A2(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_FormHeaderMsg char(100),
in In_TotalEESOPTaxExempt double,
in In_TotalCSOPTaxExempt double,
in In_TotalNSOPTaxExempt double,
in In_TotalESOPNoTaxExempt double,
in In_TotalEESOPNoTaxExempt double,
in In_TotalCSOPNoTaxExempt double,
in In_TotalNSOPNoTaxExempt double,
in In_TotalESOPStockGains double,
in In_TotalEESOPStockGains double,
in In_TotalCSOPStockGains double,
in In_TotalNSOPStockGains double,
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
      TotalNSOPTaxExempt = In_TotalNSOPTaxExempt,
      TotalESOPNoTaxExempt = In_TotalESOPNoTaxExempt,
      TotalEESOPNoTaxExempt = In_TotalEESOPNoTaxExempt,
      TotalCSOPNoTaxExempt = In_TotalCSOPNoTaxExempt,
      TotalNSOPNoTaxExempt = In_TotalNSOPNoTaxExempt,
      TotalESOPStockGains = In_TotalESOPStockGains,
      TotalEESOPStockGains = In_TotalEESOPStockGains,
      TotalCSOPStockGains = In_TotalCSOPStockGains,
      TotalNSOPStockGains = In_TotalNSOPStockGains,
      GrandTotalStockGains = In_GrandTotalStockGains,
      OtherShareAmt = In_OtherShareAmt,
      Remarks = In_Remarks,
      LastChangedDateTime = now(*) where
        PersonalSysID = In_PersonalSysID and
        YEYear = In_YEYear;
    commit work
  end if
end;


create procedure DBA.UpdateIR21A2Record(
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
in In_NSOPTaxExempt double,
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
      NSOPTaxExempt = In_NSOPTaxExempt,
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
end;


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
in In_SpouseNationality char(50),
in In_MoniesStatus integer)
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
      UnexercisedGainsAft = In_UnexercisedGainsAft,
      SpouseNationality = In_SpouseNationality,
      MoniesStatus = In_MoniesStatus where
      IR21Details.PersonalSysID = In_PersonalSysID and
      IR21Details.YEYear = In_YEYear;
    commit work
  end if
end;


create procedure DBA.UpdateYEEmployee(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_CurrentYEGlobalId char(20),
in In_YEEmployerId char(20),
in In_TaxNo char(20),
in In_Designation char(30),
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
end;


create procedure DBA.UpdateYEEmployer(
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
in In_FaxNo char(20),
in In_DateIncorporation date,
in In_AddressBlock char(20),
in In_AddressStorey char(20),
in In_AddressUnit char(20),
in In_AddressStreetName char(100),
in In_AddressPostalCode char(20))
begin
  if exists(select* from YEEmployer where 
        YEEmployer.YEEmployerID = In_YEEmployerID) then
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
      YEEmployer.FaxNo = In_FaxNo,
      YEEmployer.DateIncorporation = In_DateIncorporation,
      YEEmployer.AddressBlock = In_AddressBlock,
      YEEmployer.AddressStorey = In_AddressStorey,
      YEEmployer.AddressUnit = In_AddressUnit,
      YEEmployer.AddressStreetName = In_AddressStreetName,
      YEEmployer.AddressPostalCode = In_AddressPostalCode where
      YEEmployer.YEEmployerID = In_YEEmployerID;
    update YEEmployee set LastChangedDateTime = now(*) where 
        YEEmployerId = In_YEEmployerID;
    commit work
  end if
end;

