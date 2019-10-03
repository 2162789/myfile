/*==============================================================*/
/* Table: PeriodPolicySummary                                        */
/*==============================================================*/
if not exists(select 1 from sys.syscolumns where tname='PeriodPolicySummary' and cname='SocsoEmpStatus') then
    alter table DBA.PeriodPolicySummary Add SocsoEmpStatus char(20);
end if;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewPeriodPolicySummary') then
    drop procedure InsertNewPeriodPolicySummary
end if;
CREATE PROCEDURE "DBA"."InsertNewPeriodPolicySummary"(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_CalFWL double,
in In_CalSDF double,
in In_ContriFWL double,
in In_ContriSDF double,
in In_CurOrdinaryWage double,
in In_CurAdditionalWage double,
in In_PrevOrdinaryWage double,
in In_PrevAdditionalWage double,
in In_ContriOrdEECPF double,
in In_ContriAddEECPF double,
in In_ContriOrdERCPF double,
in In_ContriAddERCPF double,
in In_ActualOrdEECPF double,
in In_ActualOrdERCPF double,
in In_ActualAddEECPF double,
in In_ActualAddERCPF double,
in In_VolOrdEECPF double,
in In_VolOrdERCPF double,
in In_VolAddEECPF double,
in In_VolAddERCPF double,
in In_TotalContriEECPF double,
in In_TotalContriERCPF double,
in In_CPFWage double,
in In_SDFWage double,
in In_OverseasEECPF double,
in In_OverseasERCPF double,
in In_TotalCDAC double,
in In_TotalSINDA double,
in In_TotalEUCF double,
in In_TotalMBMF double,
in In_TotalComm double,
in In_TotalMOSQ double,
in In_TotalYMF double,
in In_MediSaveOrdinary double,
in In_MediSaveAdditional double,
in In_CPFClass char(20),
in In_CPFStatus char(20),
in In_SupIR8ACurOrdWage double,
in In_SupIR8ACurAddWage double,
in In_SupIR8APrevOrdWage double,
in In_SupIR8APrevAddWage double,
in In_SupIR8ACPFWage double,
in In_SupIR8AOrdEECPF double,
in In_SupIR8AAddEECPF double,
in In_SupIR8AOrdERCPF double,
in In_SupIR8AAddERCPF double,
in In_SupIR8AActOrdEECPF double,
in In_SupIR8AActAddEECPF double,
in In_SupIR8AActOrdERCPF double,
in In_SupIR8AActAddERCPF double,
in In_SupIR8AEECPF double,
in In_SupIR8AERCPF double,
in In_CompanyAddEECPF double,
in In_CompanyAddERCPF double,
in In_MAWContriCurAddWage double,
in In_MAWContriPrevAddWage double,
in In_MAWContriLimit double,
in In_MAWContriPOrdWage double,
in In_MAWContriOption double,
in In_MAWBalCurAddWage double,
in In_MAWBalPrevAddWage double,
in In_MAWBalLimit double,
in In_MAWBalPOrdWage double,
in In_MAWBalOption integer,
in In_TaxCategory char(20),
in In_TaxMaritalStatus char(20),
in In_TaxChildRelief double,
in In_CurrentTaxWage double,
in In_PreviousTaxWage double,
in In_CurrentAddTaxWage double,
in In_PreviousAddTaxWage double,
in In_CurrentTaxAmount double,
in In_PreviousTaxAmount double,
in In_TaxEPFRelief double,
in In_TaxZakatRelief double,
in In_PaidCurrentTaxAmt double,
in In_PaidPreviousTaxAmt double,
in In_TaxBenefit double,
in In_SocsoEmpStatus char(20))
begin
  declare In_PayPeriodSGSPGenId char(30);
  if not exists(select* from PeriodPolicySummary where
      PeriodPolicySummary.PayPeriodSGSPGenId = In_PayPeriodSGSPGenId and
      PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId) then
    select PayPeriodSGSPGenId into In_PayPeriodSGSPGenId from PayPeriodRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    if(In_PayPeriodSGSPGenId is not null) then
      insert into PeriodPolicySummary(EmployeeSysId,
        PayPeriodSGSPGenId,
        PayRecYear,
        PayRecPeriod,
        CalFWL,
        CalSDF,
        ContriFWL,
        ContriSDF,
        CurOrdinaryWage,
        CurAdditionalWage,
        PrevOrdinaryWage,
        PrevAdditionalWage,
        ContriOrdEECPF,
        ContriAddEECPF,
        ContriOrdERCPF,
        ContriAddERCPF,
        ActualOrdEECPF,
        ActualOrdERCPF,
        ActualAddEECPF,
        ActualAddERCPF,
        VolOrdEECPF,
        VolOrdERCPF,
        VolAddEECPF,
        VolAddERCPF,
        TotalContriEECPF,
        TotalContriERCPF,
        CPFWage,
        SDFWage,
        OverseasEECPF,
        OverseasERCPF,
        TotalCDAC,
        TotalSINDA,
        TotalEUCF,
        TotalMBMF,
        TotalComm,
        TotalMOSQ,
        TotalYMF,
        MediSaveOrdinary,
        MediSaveAdditional,
        CPFClass,
        CPFStatus,
        SupIR8ACurOrdWage,
        SupIR8ACurAddWage,
        SupIR8APrevOrdWage,
        SupIR8APrevAddWage,
        SupIR8ACPFWage,
        SupIR8AOrdEECPF,
        SupIR8AAddEECPF,
        SupIR8AOrdERCPF,
        SupIR8AAddERCPF,
        SupIR8AActOrdEECPF,
        SupIR8AActAddEECPF,
        SupIR8AActOrdERCPF,
        SupIR8AActAddERCPF,
        SupIR8AEECPF,
        SupIR8AERCPF,
        CompanyAddEECPF,
        CompanyAddERCPF,
        MAWContriCurAddWage,
        MAWContriPrevAddWage,
        MAWContriLimit,
        MAWContriPOrdWage,
        MAWContriOption,
        MAWBalCurAddWage,
        MAWBalPrevAddWage,
        MAWBalLimit,
        MAWBalPOrdWage,
        MAWBalOption,
        TaxCategory,
        TaxMaritalStatus,
        TaxChildRelief,
        CurrentTaxWage,
        PreviousTaxWage,
        CurrentAddTaxWage,
        PreviousAddTaxWage,
        CurrentTaxAmount,
        PreviousTaxAmount,
        TaxEPFRelief,
        TaxZakatRelief,
        PaidCurrentTaxAmt,
        PaidPreviousTaxAmt,
        TaxBenefit,
        SocsoEmpStatus) values(
        In_EmployeeSysId,
        In_PayPeriodSGSPGenId,
        In_PayRecYear,
        In_PayRecPeriod,
        In_CalFWL,
        In_CalSDF,
        In_ContriFWL,
        In_ContriSDF,
        In_CurOrdinaryWage,
        In_CurAdditionalWage,
        In_PrevOrdinaryWage,
        In_PrevAdditionalWage,
        In_ContriOrdEECPF,
        In_ContriAddEECPF,
        In_ContriOrdERCPF,
        In_ContriAddERCPF,
        In_ActualOrdEECPF,
        In_ActualOrdERCPF,
        In_ActualAddEECPF,
        In_ActualAddERCPF,
        In_VolOrdEECPF,
        In_VolOrdERCPF,
        In_VolAddEECPF,
        In_VolAddERCPF,
        In_TotalContriEECPF,
        In_TotalContriERCPF,
        In_CPFWage,
        In_SDFWage,
        In_OverseasEECPF,
        In_OverseasERCPF,
        In_TotalCDAC,
        In_TotalSINDA,
        In_TotalEUCF,
        In_TotalMBMF,
        In_TotalComm,
        In_TotalMOSQ,
        In_TotalYMF,
        In_MediSaveOrdinary,
        In_MediSaveAdditional,
        In_CPFClass,
        In_CPFStatus,
        In_SupIR8ACurOrdWage,
        In_SupIR8ACurAddWage,
        In_SupIR8APrevOrdWage,
        In_SupIR8APrevAddWage,
        In_SupIR8ACPFWage,
        In_SupIR8AOrdEECPF,
        In_SupIR8AAddEECPF,
        In_SupIR8AOrdERCPF,
        In_SupIR8AAddERCPF,
        In_SupIR8AActOrdEECPF,
        In_SupIR8AActAddEECPF,
        In_SupIR8AActOrdERCPF,
        In_SupIR8AActAddERCPF,
        In_SupIR8AEECPF,
        In_SupIR8AERCPF,
        In_CompanyAddEECPF,
        In_CompanyAddERCPF,
        In_MAWContriCurAddWage,
        In_MAWContriPrevAddWage,
        In_MAWContriLimit,
        In_MAWContriPOrdWage,
        In_MAWContriOption,
        In_MAWBalCurAddWage,
        In_MAWBalPrevAddWage,
        In_MAWBalLimit,
        In_MAWBalPOrdWage,
        In_MAWBalOption,
        In_TaxCategory,
        In_TaxMaritalStatus,
        In_TaxChildRelief,
        In_CurrentTaxWage,
        In_PreviousTaxWage,
        In_CurrentAddTaxWage,
        In_PreviousAddTaxWage,
        In_CurrentTaxAmount,
        In_PreviousTaxAmount,
        In_TaxEPFRelief,
        In_TaxZakatRelief,
        In_PaidCurrentTaxAmt,
        In_PaidPreviousTaxAmt,
        In_TaxBenefit,
        In_SocsoEmpStatus);
      commit work
    end if
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdatePeriodPolicySummary') then
    drop procedure UpdatePeriodPolicySummary
end if;
CREATE PROCEDURE "DBA"."UpdatePeriodPolicySummary"(
in In_EmployeeSysId integer,
in In_PayPeriodSGSPGenId char(30),
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_CalFWL double,
in In_CalSDF double,
in In_ContriFWL double,
in In_ContriSDF double,
in In_CurOrdinaryWage double,
in In_CurAdditionalWage double,
in In_PrevOrdinaryWage double,
in In_PrevAdditionalWage double,
in In_ContriOrdEECPF double,
in In_ContriAddEECPF double,
in In_ContriOrdERCPF double,
in In_ContriAddERCPF double,
in In_ActualOrdEECPF double,
in In_ActualOrdERCPF double,
in In_ActualAddEECPF double,
in In_ActualAddERCPF double,
in In_VolOrdEECPF double,
in In_VolOrdERCPF double,
in In_VolAddEECPF double,
in In_VolAddERCPF double,
in In_TotalContriEECPF double,
in In_TotalContriERCPF double,
in In_CPFWage double,
in In_SDFWage double,
in In_OverseasEECPF double,
in In_OverseasERCPF double,
in In_TotalCDAC double,
in In_TotalSINDA double,
in In_TotalEUCF double,
in In_TotalMBMF double,
in In_TotalComm double,
in In_TotalMOSQ double,
in In_TotalYMF double,
in In_MediSaveOrdinary double,
in In_MediSaveAdditional double,
in In_CPFClass char(20),
in In_CPFStatus char(20),
in In_SupIR8ACurOrdWage double,
in In_SupIR8ACurAddWage double,
in In_SupIR8APrevOrdWage double,
in In_SupIR8APrevAddWage double,
in In_SupIR8ACPFWage double,
in In_SupIR8AOrdEECPF double,
in In_SupIR8AAddEECPF double,
in In_SupIR8AOrdERCPF double,
in In_SupIR8AAddERCPF double,
in In_SupIR8AActOrdEECPF double,
in In_SupIR8AActAddEECPF double,
in In_SupIR8AActOrdERCPF double,
in In_SupIR8AActAddERCPF double,
in In_SupIR8AEECPF double,
in In_SupIR8AERCPF double,
in In_CompanyAddEECPF double,
in In_CompanyAddERCPF double,
in In_MAWContriCurAddWage double,
in In_MAWContriPrevAddWage double,
in In_MAWContriLimit double,
in In_MAWContriPOrdWage double,
in In_MAWContriOption double,
in In_MAWBalCurAddWage double,
in In_MAWBalPrevAddWage double,
in In_MAWBalLimit double,
in In_MAWBalPOrdWage double,
in In_MAWBalOption integer,
in In_TaxCategory char(20),
in In_TaxMaritalStatus char(20),
in In_TaxChildRelief double,
in In_CurrentTaxWage double,
in In_PreviousTaxWage double,
in In_CurrentAddTaxWage double,
in In_PreviousAddTaxWage double,
in In_CurrentTaxAmount double,
in In_PreviousTaxAmount double,
in In_TaxEPFRelief double,
in In_TaxZakatRelief double,
in In_PaidCurrentTaxAmt double,
in In_PaidPreviousTaxAmt double,
in In_TaxBenefit double,
in In_SocsoEmpStatus char(20))
begin
  if exists(select* from PeriodPolicySummary where
      PeriodPolicySummary.PayPeriodSGSPGenId = In_PayPeriodSGSPGenId and
      PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId) then
    update PeriodPolicySummary set
      EmployeeSysId = In_EmployeeSysId,
      PayPeriodSGSPGenId = In_PayPeriodSGSPGenId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      CalFWL = In_CalFWL,
      CalSDF = In_CalSDF,
      ContriFWL = In_ContriFWL,
      ContriSDF = In_ContriSDF,
      CurOrdinaryWage = In_CurOrdinaryWage,
      CurAdditionalWage = In_CurAdditionalWage,
      PrevOrdinaryWage = In_PrevOrdinaryWage,
      PrevAdditionalWage = In_PrevAdditionalWage,
      ContriOrdEECPF = In_ContriOrdEECPF,
      ContriAddEECPF = In_ContriAddEECPF,
      ContriOrdERCPF = In_ContriOrdERCPF,
      ContriAddERCPF = In_ContriAddERCPF,
      ActualOrdEECPF = In_ActualOrdEECPF,
      ActualOrdERCPF = In_ActualOrdERCPF,
      ActualAddEECPF = In_ActualAddEECPF,
      ActualAddERCPF = In_ActualAddERCPF,
      VolOrdEECPF = In_VolOrdEECPF,
      VolOrdERCPF = In_VolOrdERCPF,
      VolAddEECPF = In_VolAddEECPF,
      VolAddERCPF = In_VolAddERCPF,
      TotalContriEECPF = In_TotalContriEECPF,
      TotalContriERCPF = In_TotalContriERCPF,
      CPFWage = In_CPFWage,
      SDFWage = In_SDFWage,
      OverseasEECPF = In_OverseasEECPF,
      OverseasERCPF = In_OverseasERCPF,
      TotalCDAC = In_TotalCDAC,
      TotalSINDA = In_TotalSINDA,
      TotalEUCF = In_TotalEUCF,
      TotalMBMF = In_TotalMBMF,
      TotalComm = In_TotalComm,
      TotalMOSQ = In_TotalMOSQ,
      TotalYMF = In_TotalYMF,
      MediSaveOrdinary = In_MediSaveOrdinary,
      MediSaveAdditional = In_MediSaveAdditional,
      CPFClass = In_CPFClass,
      CPFStatus = In_CPFStatus,
      SupIR8ACurOrdWage = In_SupIR8ACurOrdWage,
      SupIR8ACurAddWage = In_SupIR8ACurAddWage,
      SupIR8APrevOrdWage = In_SupIR8APrevOrdWage,
      SupIR8APrevAddWage = In_SupIR8APrevAddWage,
      SupIR8ACPFWage = In_SupIR8ACPFWage,
      SupIR8AOrdEECPF = In_SupIR8AOrdEECPF,
      SupIR8AAddEECPF = In_SupIR8AAddEECPF,
      SupIR8AOrdERCPF = In_SupIR8AOrdERCPF,
      SupIR8AAddERCPF = In_SupIR8AAddERCPF,
      SupIR8AActOrdEECPF = In_SupIR8AActOrdEECPF,
      SupIR8AActAddEECPF = In_SupIR8AActAddEECPF,
      SupIR8AActOrdERCPF = In_SupIR8AActOrdERCPF,
      SupIR8AActAddERCPF = In_SupIR8AActAddERCPF,
      SupIR8AEECPF = In_SupIR8AEECPF,
      SupIR8AERCPF = In_SupIR8AERCPF,
      CompanyAddEECPF = In_CompanyAddEECPF,
      CompanyAddERCPF = In_CompanyAddERCPF,
      MAWContriCurAddWage = In_MAWContriCurAddWage,
      MAWContriPrevAddWage = In_MAWContriPrevAddWage,
      MAWContriLimit = In_MAWContriLimit,
      MAWContriPOrdWage = In_MAWContriPOrdWage,
      MAWContriOption = In_MAWContriOption,
      MAWBalCurAddWage = In_MAWBalCurAddWage,
      MAWBalPrevAddWage = In_MAWBalPrevAddWage,
      MAWBalLimit = In_MAWBalLimit,
      MAWBalPOrdWage = In_MAWBalPOrdWage,
      MAWBalOption = In_MAWBalOption,
      TaxCategory = In_TaxCategory,
      TaxMaritalStatus = In_TaxMaritalStatus,
      TaxChildRelief = In_TaxChildRelief,
      CurrentTaxWage = In_CurrentTaxWage,
      PreviousTaxWage = In_PreviousTaxWage,
      CurrentAddTaxWage = In_CurrentAddTaxWage,
      PreviousAddTaxWage = In_PreviousAddTaxWage,
      CurrentTaxAmount = In_CurrentTaxAmount,
      PreviousTaxAmount = In_PreviousTaxAmount,
      TaxEPFRelief = In_TaxEPFRelief,
      TaxZakatRelief = In_TaxZakatRelief,
      PaidCurrentTaxAmt = In_PaidCurrentTaxAmt,
      PaidPreviousTaxAmt = In_PaidPreviousTaxAmt,
      TaxBenefit = In_TaxBenefit,
      SocsoEmpStatus = In_SocsoEmpStatus where
      PeriodPolicySummary.PayPeriodSGSPGenId = In_PayPeriodSGSPGenId and
      PeriodPolicySummary.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeSDF') then
   drop PROCEDURE ASQLTimeSheetDistributeSDF;
end if;
CREATE PROCEDURE "DBA"."ASQLTimeSheetDistributeSDF"(
in In_EmployeeSysId integer,
in In_TMSYear integer,
in In_TMSPeriod integer,
out Out_SDFErrorCode integer)
begin
  declare DistributeId char(20);
  declare Remark char(20);
  declare In_TotalContriSDF double;
  declare In_ContriSDF double;
  declare Accu_ContriSDF double;
  declare In_TotalFreq double;
  declare In_TotalRecord integer;
  declare In_DecimalPlace integer;
  declare Out_ErrorCode integer;
  set In_DecimalPlace=FGetDBPayDecimal(*);
  set Out_SDFErrorCode=0;
  if FGetDBCountry(*) = 'Malaysia' then
     set DistributeId = 'TsHRDLevy'; 
     set Remark = 'HRD'; 
  else
     set DistributeId = 'TsSDF';
     set Remark = 'SDF';
  end if;
  /*
  Get the SDF Contribution
  */
  select ContriSDF into In_TotalContriSDF
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
  Distribute SDF
  */
  set Accu_ContriSDF=0;
  SDFLoop: for SDFFor as SDF_curs dynamic scroll cursor for
    select TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId,
      TMSWorkingDayHour as In_TMSWorkingDayHour from
      TimeSheet join TMSDetail where
      EmployeeSysId = In_EmployeeSysId and
      TMSYear = In_TMSYear and
      TMSPeriod = In_TMSPeriod do
    if(In_TotalRecord = 1) then
      set In_ContriSDF=Round(In_TotalContriSDF-Accu_ContriSDF,In_DecimalPlace)
    else
      if(In_TotalFreq = 0) then
        set In_ContriSDF=0
      else
        set In_ContriSDF=Round(In_TMSWorkingDayHour/In_TotalFreq*In_TotalContriSDF,In_DecimalPlace);
        if(In_ContriSDF+Accu_ContriSDF > In_TotalContriSDF) then
          set In_ContriSDF=Round(In_TotalContriSDF-Accu_ContriSDF,In_DecimalPlace)
        end if
      end if
    end if;
    set Accu_ContriSDF=Accu_ContriSDF+In_ContriSDF;
    /*
    Update SDF
    */
    if not exists(select* from TMSDistribute where TMSSGSPGenId = In_TMSSGSPGenId and TMSDistributeId = DistributeId) then
      if(In_ContriSDF <> 0) then
        call InsertNewTMSDistribute(DistributeId,In_TMSSGSPGenId,In_ContriSDF,Out_ErrorCode)
      else
        set Out_ErrorCode=1
      end if
    else
      call UpdateTMSDistribute(DistributeId,In_TMSSGSPGenId,In_ContriSDF,Out_ErrorCode)
    end if;
    if(Out_ErrorCode <> 1) then set Out_SDFErrorCode=1;
      return
    end if end for;
  set Out_SDFErrorCode=0;
  message 'End ' + Remark type info to client
end
;

commit work;