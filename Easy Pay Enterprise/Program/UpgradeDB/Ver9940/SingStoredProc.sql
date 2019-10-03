if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLYEUpdateIR8A') then
   drop procedure ASQLYEUpdateIR8A
end if
;

create procedure
DBA.ASQLYEUpdateIR8A(in In_PersonalSysId integer,in In_YEYear integer,in In_Operation char(20))
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
      TotalESOPStockGainsBef+TotalEESOPStockGainsBef+TotalCSOPStockGainsBef+TotalNSOPStockGainsBef into In_ShareAmt,
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

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLYEProcessA8B') then
   drop procedure ASQLYEProcessA8B
end if
;

create procedure
DBA.ASQLYEProcessA8B(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_Operation char(20)
)
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
    NoTaxExempt = "Truncate"(Round((MktValueExerciseStock-ExercisePriceStock)*SharesAcquired,3),2) where
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
    EESOPTaxExempt = "Truncate"(Round((MktValueExerciseStock-MktValueStockGrant)*SharesAcquired,3),2),
    CSOPTaxExempt = 0,
    NSOPTaxExempt = 0,
    NoTaxExempt = "Truncate"(Round((MktValueStockGrant-ExercisePriceStock)*SharesAcquired,3),2) where
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
    CSOPTaxExempt = "Truncate"(Round((MktValueExerciseStock-MktValueStockGrant)*SharesAcquired,3),2),
    NSOPTaxExempt = 0,
    NoTaxExempt = "Truncate"(Round((MktValueStockGrant-ExercisePriceStock)*SharesAcquired,3),2) where
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
    NSOPTaxExempt = "Truncate"(Round((MktValueExerciseStock-MktValueStockGrant)*SharesAcquired,3),2),
    NoTaxExempt = "Truncate"(Round((MktValueStockGrant-ExercisePriceStock)*SharesAcquired,3),2) where
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
end
;