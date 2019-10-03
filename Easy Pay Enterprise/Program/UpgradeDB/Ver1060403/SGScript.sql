IF EXISTS(SELECT 1 FROM sys.sysprocedure WHERE proc_name ='ASQLYEUpdateIR8A') THEN
    DROP Procedure ASQLYEUpdateIR8A;
END IF;

create Procedure DBA.ASQLYEUpdateIR8A(
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
  declare In_OverseasEECPF double;    
  declare In_OverseasERCPF double;
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
    ActualAddEECPF,
    OverseasEECPF,    
    OverseasERCPF
 into In_ContriOrdEECPF,
    In_ContriAddEECPF,
    In_ActualOrdEECPF,
    In_ActualAddEECPF, 
    In_OverseasEECPF,    
    In_OverseasERCPF
 from IR8SA where
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
      In_EESupCPFPension -
      In_OverseasEECPF;

    /* 
        If EE more than Government then set at Government Contribution otherwise the paid CPF excluding overseas
    */
    if (In_EECPFPension > In_ActualOrdEECPF + In_ActualAddEECPF) then
        set In_EECPFPension = In_ActualOrdEECPF + In_ActualAddEECPF;
    end if;

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

Commit work;