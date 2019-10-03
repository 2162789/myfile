if exists(select * from sys.sysprocedure where proc_name = 'InsertNewDetailRecord') then
   drop procedure InsertNewDetailRecord
end if;
Create PROCEDURE "DBA"."InsertNewDetailRecord"(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_CurrentBasicRate double,
in In_PreviousBasicRate double,
in In_CurrentBasicRateType char(20),
in In_PreviousBasicRateType char(20),
in In_PreviousHrDays double,
in In_CurrentHrDays double,
in In_PreviousHrDaysRate double,
in In_CurrentHrDaysRate double,
in In_PayAllocationType char(20),
in In_PayAllocationValue double,
in In_CalTotalWage double,
in In_CalOTAmount double,
in In_CalOTBackPay double,
in In_CalShiftAmount double,
in In_CalLveDeductAmt double,
in In_CalBackPay double,
in In_CalGrossWage double,
in In_CalTotalGrossWage double,
in In_CalNetWage double,
in In_AllocatedBasicRate double,
in In_CurBackPayBasicRate double,
in In_PrevBackPayBasicRate double,
in In_FullBackPayFreq double,
in In_ProratedBackPayFreq double,
in In_BackPayProgressionDate date,
in In_CurrentBasicRateF double,
in In_CurrentBRExRateId char(20),
in In_CurrentBRExRate double,
in In_PreviousBasicRateF double,
in In_AllocatedBasicRateF double,
in In_CalTotalWageF double,
in In_CalBackPayF double,
in In_CurBackPayBasicRateF double,
in In_PrevBackPayBasicRateF double,
in In_FreeNumeric1 double,
in In_FreeNumeric2 double,
in In_FreeNumeric3 double,
in In_FreeNumeric4 double,
in In_FreeNumeric5 double,
in In_FreeString1 char(200),
in In_FreeString2 char(200),
in In_FreeString3 char(200),
in In_FreeString4 char(200),
in In_FreeString5 char(200),
in In_NetWageP double,
in In_NetWageExRateId char(20),
in In_NetWageExRate double,
in In_NetWageBankAllocGpId char(20),
in In_PayRecBasicRate double,
in In_PayRecBasicRateF double)
begin
  if not exists(select* from DetailRecord where
      DetailRecord.EmployeeSysId = In_EmployeeSysId and
      DetailRecord.PayRecYear = In_PayRecYear and
      DetailRecord.PayRecPeriod = In_PayRecPeriod and
      DetailRecord.PayRecSubPeriod = In_PayRecSubPeriod and
      DetailRecord.PayRecID = In_PayRecID) then
    insert into DetailRecord(DetailRecSGSPGenId,
      EmployeeSysId,
      PayRecYear,
      PayRecPeriod,
      PayRecSubPeriod,
      PayRecID,
      CurrentBasicRate,
      PreviousBasicRate,
      CurrentBasicRateType,
      PreviousBasicRateType,
      PreviousHrDays,
      CurrentHrDays,
      PreviousHrDaysRate,
      CurrentHrDaysRate,
      PayAllocationType,
      PayAllocationValue,
      CalTotalWage,
      CalOTAmount,
      CalOTBackPay,
      CalShiftAmount,
      CalLveDeductAmt,
      CalBackPay,
      CalGrossWage,
      CalTotalGrossWage,
      CalNetWage,
      AllocatedBasicRate,
      CurBackPayBasicRate,
      PrevBackPayBasicRate,
      FullBackPayFreq,
      ProratedBackPayFreq,
      BackPayProgressionDate,
      CurrentBasicRateF,
      CurrentBRExRateId,
      CurrentBRExRate,
      PreviousBasicRateF,
      AllocatedBasicRateF,
      CalTotalWageF,
      CalBackPayF,
      CurBackPayBasicRateF,
      PrevBackPayBasicRateF,
      FreeNumeric1,
      FreeNumeric2,
      FreeNumeric3,
      FreeNumeric4,
      FreeNumeric5,
      FreeString1,
      FreeString2,
      FreeString3,
      FreeString4,
      FreeString5,
      NetWageP,
      NetWageExRateId,
      NetWageExRate,
      NetWageBankAllocGpId,
      PayRecBasicRate,
      PayRecBasicRateF) values(
      FGetNewSGSPGeneratedIndex('DetailRecord'),
      In_EmployeeSysId,
      In_PayRecYear,
      In_PayRecPeriod,
      In_PayRecSubPeriod,
      In_PayRecID,
      In_CurrentBasicRate,
      In_PreviousBasicRate,
      In_CurrentBasicRateType,
      In_PreviousBasicRateType,
      In_PreviousHrDays,
      In_CurrentHrDays,
      In_PreviousHrDaysRate,
      In_CurrentHrDaysRate,
      In_PayAllocationType,
      In_PayAllocationValue,
      In_CalTotalWage,
      In_CalOTAmount,
      In_CalOTBackPay,
      In_CalShiftAmount,
      In_CalLveDeductAmt,
      In_CalBackPay,
      In_CalGrossWage,
      In_CalTotalGrossWage,
      In_CalNetWage,
      In_AllocatedBasicRate,
      In_CurBackPayBasicRate,
      In_PrevBackPayBasicRate,
      In_FullBackPayFreq,
      In_ProratedBackPayFreq,
      In_BackPayProgressionDate,
      In_CurrentBasicRateF,
      In_CurrentBRExRateId,
      In_CurrentBRExRate,
      In_PreviousBasicRateF,
      In_AllocatedBasicRateF,
      In_CalTotalWageF,
      In_CalBackPayF,
      In_CurBackPayBasicRateF,
      In_PrevBackPayBasicRateF,
      In_FreeNumeric1,
      In_FreeNumeric2,
      In_FreeNumeric3,
      In_FreeNumeric4,
      In_FreeNumeric5,
      In_FreeString1,
      In_FreeString2,
      In_FreeString3,
      In_FreeString4,
      In_FreeString5,
      In_NetWageP,
      In_NetWageExRateId,
      In_NetWageExRate,
      In_NetWageBankAllocGpId,
      In_PayRecBasicRate,
      In_PayRecBasicRateF);
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'UpdateDetailRecord') then
   drop procedure UpdateDetailRecord
end if;
Create PROCEDURE "DBA"."UpdateDetailRecord"(
in In_DetailRecSGSPGenId char(30),
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_CurrentBasicRate double,
in In_PreviousBasicRate double,
in In_CurrentBasicRateType char(20),
in In_PreviousBasicRateType char(20),
in In_PreviousHrDays double,
in In_CurrentHrDays double,
in In_PreviousHrDaysRate double,
in In_CurrentHrDaysRate double,
in In_PayAllocationType char(20),
in In_PayAllocationValue double,
in In_CalTotalWage double,
in In_CalOTAmount double,
in In_CalOTBackPay double,
in In_CalShiftAmount double,
in In_CalLveDeductAmt double,
in In_CalBackPay double,
in In_CalGrossWage double,
in In_CalTotalGrossWage double,
in In_CalNetWage double,
in In_AllocatedBasicRate double,
in In_CurBackPayBasicRate double,
in In_PrevBackPayBasicRate double,
in In_FullBackPayFreq double,
in In_ProratedBackPayFreq double,
in In_BackPayProgressionDate date,
in In_CurrentBasicRateF double,
in In_CurrentBRExRateId char(20),
in In_CurrentBRExRate double,
in In_PreviousBasicRateF double,
in In_AllocatedBasicRateF double,
in In_CalTotalWageF double,
in In_CalBackPayF double,
in In_CurBackPayBasicRateF double,
in In_PrevBackPayBasicRateF double,
in In_FreeNumeric1 double,
in In_FreeNumeric2 double,
in In_FreeNumeric3 double,
in In_FreeNumeric4 double,
in In_FreeNumeric5 double,
in In_FreeString1 char(200),
in In_FreeString2 char(200),
in In_FreeString3 char(200),
in In_FreeString4 char(200),
in In_FreeString5 char(200),
in In_NetWageP double,
in In_NetWageExRateId char(20),
in In_NetWageExRate double,
in In_NetWageBankAllocGpId char(20),
in In_PayRecBasicRate double,
in In_PayRecBasicRateF double)
begin
  if exists(select* from DetailRecord where
      DetailRecord.DetailRecSGSPGenId = In_DetailRecSGSPGenId) then
    update DetailRecord set
      DetailRecSGSPGenId = In_DetailRecSGSPGenId,
      EmployeeSysId = In_EmployeeSysId,
      PayRecYear = In_PayRecYear,
      PayRecPeriod = In_PayRecPeriod,
      PayRecSubPeriod = In_PayRecSubPeriod,
      PayRecID = In_PayRecID,
      CurrentBasicRate = In_CurrentBasicRate,
      PreviousBasicRate = In_PreviousBasicRate,
      CurrentBasicRateType = In_CurrentBasicRateType,
      PreviousBasicRateType = In_PreviousBasicRateType,
      PreviousHrDays = In_PreviousHrDays,
      CurrentHrDays = In_CurrentHrDays,
      PreviousHrDaysRate = In_PreviousHrDaysRate,
      CurrentHrDaysRate = In_CurrentHrDaysRate,
      PayAllocationType = In_PayAllocationType,
      PayAllocationValue = In_PayAllocationValue,
      CalTotalWage = In_CalTotalWage,
      CalOTAmount = In_CalOTAmount,
      CalOTBackPay = In_CalOTBackPay,
      CalShiftAmount = In_CalShiftAmount,
      CalLveDeductAmt = In_CalLveDeductAmt,
      CalBackPay = In_CalBackPay,
      CalGrossWage = In_CalGrossWage,
      CalTotalGrossWage = In_CalTotalGrossWage,
      CalNetWage = In_CalNetWage,
      AllocatedBasicRate = In_AllocatedBasicRate,
      CurBackPayBasicRate = In_CurBackPayBasicRate,
      PrevBackPayBasicRate = In_PrevBackPayBasicRate,
      FullBackPayFreq = In_FullBackPayFreq,
      ProratedBackPayFreq = In_ProratedBackPayFreq,
      BackPayProgressionDate = In_BackPayProgressionDate,
      CurrentBasicRateF = In_CurrentBasicRateF,
      CurrentBRExRateId = In_CurrentBRExRateId,
      CurrentBRExRate = In_CurrentBRExRate,
      PreviousBasicRateF = In_PreviousBasicRateF,
      AllocatedBasicRateF = In_AllocatedBasicRateF,
      CalTotalWageF = In_CalTotalWageF,
      CalBackPayF = In_CalBackPayF,
      CurBackPayBasicRateF = In_CurBackPayBasicRateF,
      PrevBackPayBasicRateF = In_PrevBackPayBasicRateF,
      FreeNumeric1 = In_FreeNumeric1,
      FreeNumeric2 = In_FreeNumeric2,
      FreeNumeric3 = In_FreeNumeric3,
      FreeNumeric4 = In_FreeNumeric4,
      FreeNumeric5 = In_FreeNumeric5,
      FreeString1 = In_FreeString1,
      FreeString2 = In_FreeString2,
      FreeString3 = In_FreeString3,
      FreeString4 = In_FreeString4,
      FreeString5 = In_FreeString5,
      NetWageP = In_NetWageP,
      NetWageExRateId = In_NetWageExRateId,
      NetWageExRate = In_NetWageExRate,
      NetWageBankAllocGpId = In_NetWageBankAllocGpId,
      PayRecBasicRate = In_PayRecBasicRate,
      PayRecBasicRateF = In_PayRecBasicRateF where
      DetailRecord.DetailRecSGSPGenId = In_DetailRecSGSPGenId;
    commit work
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewInterfaceProject') then
   drop procedure InsertNewInterfaceProject
end if;
CREATE PROCEDURE "DBA"."InsertNewInterfaceProject"(
in In_InterfaceProjectID char(20),
in In_InterfaceProjRemarks char(100))
begin
  if not exists(select* from InterfaceProject where
      InterfaceProject.InterfaceProjectID = In_InterfaceProjectID) then
    insert into InterfaceProject(InterfaceProjectID,InterfaceProjRemarks) values(In_InterfaceProjectID,In_InterfaceProjRemarks);
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'OT Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Shift Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Employment Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Pay Element Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Leave Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Lve Summary Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'HR Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Daily Hourly Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Income Tax Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Casual Pay Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'YTD Process',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Time Sheet Detail',null,0,0,'');
    call InsertNewInterfaceProcess(In_InterfaceProjectID,'Setup Process',null,0,0,'');
    
    /* BIK Record Process & Rebate Claim is only for Malaysia */
    if(FGetDBCountry(*) = 'Malaysia') then
      call InsertNewInterfaceProcess(In_InterfaceProjectID,'BIK Record Process',null,0,0,'');
      call InsertNewInterfaceProcess(In_InterfaceProjectID,'Rebate Claim Process',null,0,0,'');
    end if;
    
    commit work
  end if
end;


if exists(select * from sys.sysprocedure where proc_name = 'ASQLRefreshEmpeeOtherInfo') then
   drop procedure ASQLRefreshEmpeeOtherInfo
end if;
CREATE PROCEDURE "DBA"."ASQLRefreshEmpeeOtherInfo"(in In_EmployeeSysId integer,
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
        elseif(In_EmpeeOtherInfoId = 'SDFOption') then
          // special processing for SDFOption
          call InsertNewEmpeeOtherInfo(In_EmployeeSysId,In_EmpeeOtherInfoId,In_EmpeeOtherInfoType,In_EmpeeOtherInfoCaption,null,'',1,0)
        elseif(In_EmpeeOtherInfoId = 'HRDFOption') then
          // special processing for HRDFOption
          select FGetCurrentResStatus(PersonalSysId) into Out_ResStatus from Employee where EmployeeSysId = In_EmployeeSysId;
          if(Out_ResStatus = 'Local' or Out_ResStatus = 'PR') then
            call InsertNewEmpeeOtherInfo(In_EmployeeSysId,In_EmpeeOtherInfoId,In_EmpeeOtherInfoType,In_EmpeeOtherInfoCaption,null,'',1,0)
          else
            call InsertNewEmpeeOtherInfo(In_EmployeeSysId,In_EmpeeOtherInfoId,In_EmpeeOtherInfoType,In_EmpeeOtherInfoCaption,null,'',0,0)
          end if;
        elseif(In_EmpeeOtherInfoId = 'ContriToSocso') then
          // special processing for ContriToSocso
          call InsertNewEmpeeOtherInfo(In_EmployeeSysId,In_EmpeeOtherInfoId,In_EmpeeOtherInfoType,In_EmpeeOtherInfoCaption,null,'',1,0)
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
end;

commit work;