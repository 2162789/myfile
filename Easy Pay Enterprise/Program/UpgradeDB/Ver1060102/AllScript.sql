if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLDeleteEmployeeProgression') then
   drop procedure ASQLDeleteEmployeeProgression
end if
;
create procedure DBA.ASQLDeleteEmployeeProgression(
in In_EmployeeSysId integer)
begin
  //
  //    Delete Policy Progression
  //    
  call DeletePolicyProgression(In_EmployeeSysId);
  //
  //    Delete Basic Rate Progression
  //  
  call DeleteBasicRateProgression(In_EmployeeSysId);
  //
  //    Delete CPF Progression
  //  
  call DeleteCPFProgression(In_EmployeeSysId);
  //
  //    Delete EPF, SOCSO Progression
  //
  if FGetDBCountry(*) = 'Malaysia' then
    call DeleteEPFProgression(In_EmployeeSysId);
    call DeleteSOCSOProgression(In_EmployeeSysId)
  end if;
  //
  //    Delete Mandatory Contribution Progression
  //
  if FGetDBCountry(*) = 'Philippines' then
    DeleteMandatoryContributeProgressionLoop: for MandatoryContributeProgressionFor as MandatoryContributeProgressioncurs dynamic scroll cursor for
      select MandContriSysId as In_MandContriSysId from MandatoryContributeProg where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteMandatoryContributeProg(In_MandContriSysId) end for
  end if;
  //
  //    Delete VnC45 Record
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteVnC45Loop: for VnC45For as VnC45curs dynamic scroll cursor for
      select VnC45SGSPGenId as In_VnC45SGSPGenId from VnC45Record where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteVnC45Record(In_VnC45SGSPGenId) end for
  end if;
  //
  //    Delete VnC47 Record
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteVnC47Loop: for VnC47For as VnC47curs dynamic scroll cursor for
      select VnC47SGSPGenId as In_VnC47SGSPGenId from VnC47Record where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteVnC47Record(In_VnC47SGSPGenId) end for
  end if;
  //
  //    Delete VnC04 Record
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteVnC04Loop: for VnC04For as VnC04curs dynamic scroll cursor for
      select VnC04SGSPGenId as In_VnC04SGSPGenId from VnC04Record where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteVnC04Record(In_VnC04SGSPGenId) end for
  end if;
  //
  //    Delete VnC47a Record
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteVnC47aLoop: for VnC47aFor as VnC47acurs dynamic scroll cursor for
      select VnC47aSGSPGenId as In_VnC47aSGSPGenId from VnC47aRecord where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteVnC47aRecord(In_VnC47aSGSPGenId) end for
  end if;
  //
  //    Delete SI Progression
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteSIProgressionLoop: for SIProgressionFor as SIProgressioncurs dynamic scroll cursor for
      select SIProgSysId as In_SIProgSysId from SIProgression where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteSIProgression(In_SIProgSysId) end for
  end if;
  //
  //    Delete HI Progression
  //
  if FGetDBCountry(*) = 'Vietnam' then
    DeleteHIProgressionLoop: for HIProgressionFor as HIProgressioncurs dynamic scroll cursor for
      select HIProgSysId as In_HIProgSysId from HIProgression where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteHIProgression(In_HIProgSysId) end for
  end if;
  //
  //    Delete MPF Progression
  //
  if FGetDBCountry(*) = 'HongKong' then
    DeleteMPFProgressionLoop: for MPFProgressionFor as MPFProgressioncurs dynamic scroll cursor for
      select MPFProgSysId as In_MPFProgSysId from MPFProgression where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteMPFProgression(In_MPFProgSysId) end for
  end if;
  //
  //Delete Mandatory Contribution
  //
  if FGetDBCountry(*) = 'Thailand' or FGetDBCountry(*) = 'Brunei' then
    DeletePFSSProgressionLoop: for PFSSProgressionFor as PFSSProgressioncurs dynamic scroll cursor for
      select MandContriSysId as In_MandContriSysId from MandatoryContributeProg where
        EmployeeSysId = In_EmployeeSysId do
      call DeleteMandatoryContributeProg(In_MandContriSysId) end for
  end if;
  //
  //    Delete Career Progression
  //
  DeleteCareerProgressionLoop: for CareerProgressionFor as CareerProgressioncurs dynamic scroll cursor for
    select CareerEffectiveDate as In_CareerEffectiveDate from CareerProgression where
      EmployeeSysId = In_EmployeeSysId do
    call DeleteCareerProgression(In_EmployeeSysId,In_CareerEffectiveDate) end for;
  //
  //    Delete Contract Progression
  //
  DeleteContractProgressionLoop: for ContractProgressionFor as ContractProgressioncurs dynamic scroll cursor for
    select ContractStartDate as In_ContractStartDate from ContractProgression where
      EmployeeSysId = In_EmployeeSysId do
    call DeleteContractProgression(In_EmployeeSysId,In_ContractStartDate) end for;
  //
  // Delete FWL Progression
  //
  if exists(select* from FWLProgression where
      FWLProgression.EmployeeSysId = In_EmployeeSysId) then
    delete from FWLProgression where
      FWLProgression.EmployeeSysId = In_EmployeeSysId
  end if;
  //
  // Delete EP Progression
  //
  if exists(select* from EmployPassProgression where
      EmployPassProgression.EmployeeSysId = In_EmployeeSysId) then
    delete from EmployPassProgression where
      EmployPassProgression.EmployeeSysId = In_EmployeeSysId
  end if;
  commit work
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLAdvReportUpdate') then
   drop procedure ASQLAdvReportUpdate
end if
;
create procedure DBA.ASQLAdvReportUpdate(
in In_AdvReportId char(20),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecordID char(20))
begin
  declare In_Country char(20);
  declare Out_AdvEEFund1 double;
  declare Out_AdvERFund1 double;
  declare Out_AdvEEFund2 double;
  declare Out_AdvERFund2 double;
  declare Out_AdvEEFund3 double;
  declare Out_AdvERFund3 double;
  declare Out_AdvEEFund4 double;
  declare Out_AdvERFund4 double;
  declare Out_AdvEEFund5 double;
  declare Out_AdvERFund5 double;
  declare Out_AdvEEFund6 double;
  declare Out_AdvERFund6 double;
  declare Out_AdvEEFund7 double;
  declare Out_AdvERFund7 double;
  declare Out_AdvEEFund8 double;
  declare Out_AdvERFund8 double;
  declare Out_AdvEEFund9 double;
  declare Out_AdvERFund9 double;
  declare Out_AdvEEFund10 double;
  declare Out_AdvERFund10 double;
  set Out_AdvEEFund1=0;
  set Out_AdvERFund1=0;
  set Out_AdvEEFund2=0;
  set Out_AdvERFund2=0;
  set Out_AdvEEFund3=0;
  set Out_AdvERFund3=0;
  set Out_AdvEEFund4=0;
  set Out_AdvERFund4=0;
  set Out_AdvEEFund5=0;
  set Out_AdvERFund5=0;
  set Out_AdvEEFund6=0;
  set Out_AdvERFund6=0;
  set Out_AdvEEFund7=0;
  set Out_AdvERFund7=0;
  set Out_AdvEEFund8=0;
  set Out_AdvERFund8=0;
  set Out_AdvEEFund9=0;
  set Out_AdvERFund9=0;
  set Out_AdvEEFund10=0;
  set Out_AdvERFund10=0;
  select FGetDBCountry(*) into In_Country;
  /*
  Singapore Update CPF
  */
  if(In_Country = 'Singapore') then
    select ContriOrdEECPF+ContriAddEECPF, //  Employee CPF 
      ContriOrdERCPF+ContriAddERCPF into Out_AdvEEFund1, // Employer CPF 
      Out_AdvERFund1 from PolicyRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecordID
  /*
  Brunei Update TAP 1,2,3
  */
  elseif(In_Country = 'Brunei') then
    select TotalContriEECPF, // TAP 1
      TotalContriERCPF,
      ContriOrdEECPF, // TAP 2
      ContriOrdERCPF,
      ContriAddEECPF, // TAP 3
      ContriAddERCPF, 
      CurrEEManContri, // SCP
      CurrERManContri
into Out_AdvEEFund1, // TAP 1
      Out_AdvERFund1,
      Out_AdvEEFund2, // TAP 2
      Out_AdvERFund2,
      Out_AdvEEFund3, // TAP 3
      Out_AdvERFund3,
      Out_AdvEEFund4, // SCP
      Out_AdvERFund4
      from PolicyRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecordID
  /*
  Indonesia Update Jamsostek
  */
  elseif(In_Country = 'Indonesia') then
    select ContriOrdEECPF, // Employee Jamsostek
      ContriOrdERCPF, // Accident Jamsostek
      ContriAddEECPF, // Old Age Jamsostek
      ContriAddERCPF into Out_AdvEEFund1, // Death Jamsostek
      Out_AdvERFund2,
      Out_AdvERFund3,
      Out_AdvERFund4 from PolicyRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecordID
  /*
  Malaysia Update EPF / SOCSO
  */
  elseif(In_Country = 'Malaysia') then
    select ContriOrdEECPF, // SOCSO EE Contribution 
      ContriOrdERCPF, // SOCSO ER Contribution
      CurrEEManContri, // Current EE Mandatory EPF 
      CurrERManContri, // Current ER Mandatory EPF 
      CurrEEVolContri, // Current EE Voluntary EPF
      CurrERVolContri, // Current ER Voluntary EPF
      PrevEEManContri, // Previous EE Mandatory EPF
      PrevERManContri, // Previous ER Mandatory EPF
      PrevEEVolContri, // Previous EE Voluntary EPF
      PrevERVolContri into Out_AdvEEFund1, // Previous ER Voluntary EPF
      Out_AdvERFund1,
      Out_AdvEEFund2,
      Out_AdvERFund2,
      Out_AdvEEFund3,
      Out_AdvERFund3,
      Out_AdvEEFund4,
      Out_AdvERFund4,
      Out_AdvEEFund5,
      Out_AdvERFund5 from PolicyRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecordID
  /*
  Philippines SSS / PHIC / HDMF
  */
  elseif(In_Country = 'Philippines') then
    select ContriOrdEECPF, // PHIC EE
      ContriOrdERCPF, // PHIC ER
      ContriAddEECPF, // HDMF EE
      ContriAddERCPF, // HDMF ER
      CurrEEManContri, // SSS EE
      CurrERManContri, // SSS ER SS
      CurrERVolContri into Out_AdvEEFund1, // SSS ER EC
      Out_AdvERFund1,
      Out_AdvEEFund2,
      Out_AdvERFund2,
      Out_AdvEEFund3,
      Out_AdvERFund3,
      Out_AdvEEFund4 from PolicyRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecordID
  /*
  Vietnam no Fund Contribution
  */
  /*
  Hong Kong MPF Contribution
  */
  elseif(In_Country = 'HongKong') then
    select CurrEEManContri, // EE Man MPF Contri
      CurrERManContri, // ER Man MPF Contri
      CurrEEVolContri, // EE Vol MPF Contri
      CurrERVolContri into Out_AdvEEFund1, // ER Vol MPF Contri
      Out_AdvERFund1,
      Out_AdvEEFund2,
      Out_AdvERFund2 from PolicyRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecordID
  /*
  Thailand SS and PF Contribution
  */
  elseif(In_Country = 'Thailand') then
    select ContriOrdEECPF, //	PF1 EE
      ContriOrdERCPF, //	PF1 ER
      CurrEEManContri, //	PF2 EE
      CurrERManContri, //	PF2 ER
      PrevEEManContri, //	PF3 EE
      PrevERManContri, //	PF3 ER
      CurrEEManWage, //	PF4 EE
      CurrERManWage, //	PF4 ER
      PrevEEManWage, //	PF5 EE
      PrevERManWage, //	PF5 ER   
      TotalContriEECPF, //	SS EE 
      TotalContriERCPF, //	SS ER
      ContriAddERCPF, //	PF1 ER Special
      CurrERVolContri, //	PF2 ER Special
      PrevERVolContri, //	PF3 ER Special
      CurrERVolWage, //	PF4 ER Special
      PrevERVolWage into Out_AdvEEFund1, //	PF5 ER Special
      Out_AdvERFund1,
      Out_AdvEEFund2,
      Out_AdvERFund2,
      Out_AdvEEFund3,
      Out_AdvERFund3,
      Out_AdvEEFund4,
      Out_AdvERFund4,
      Out_AdvEEFund5,
      Out_AdvERFund5,
      Out_AdvEEFund6,
      Out_AdvERFund6,
      Out_AdvEEFund7,
      Out_AdvERFund7,
      Out_AdvEEFund8,
      Out_AdvERFund8,
      Out_AdvEEFund9 from PolicyRecord where EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecordID
  end if;
  update AdvanceReport set
    AdvEEFund1 = Out_AdvEEFund1,
    AdvERFund1 = Out_AdvERFund1,
    AdvEEFund2 = Out_AdvEEFund2,
    AdvERFund2 = Out_AdvERFund2,
    AdvEEFund3 = Out_AdvEEFund3,
    AdvERFund3 = Out_AdvERFund3,
    AdvEEFund4 = Out_AdvEEFund4,
    AdvERFund4 = Out_AdvERFund4,
    AdvEEFund5 = Out_AdvEEFund5,
    AdvERFund5 = Out_AdvERFund5,
    AdvEEFund6 = Out_AdvEEFund6,
    AdvERFund6 = Out_AdvERFund6,
    AdvEEFund7 = Out_AdvEEFund7,
    AdvERFund7 = Out_AdvERFund7,
    AdvEEFund8 = Out_AdvEEFund8,
    AdvERFund8 = Out_AdvERFund8,
    AdvEEFund9 = Out_AdvEEFund9,
    AdvERFund9 = Out_AdvERFund9,
    AdvEEFund10 = Out_AdvEEFund10,
    AdvERFund10 = Out_AdvERFund10 where
    AdvEmployeeSysId = In_EmployeeSysId and
    AdvReportId = In_AdvReportId
end
;

Delete from Subregistry WHERE RegistryId='HRRangeBasis' and SubRegistryId='ClaimAmount';

COMMIT WORK;

