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
    
    /* BIK Record Process is only for Malaysia */
    if(FGetDBCountry(*) = 'Malaysia') then
      call InsertNewInterfaceProcess(In_InterfaceProjectID,'BIK Record Process',null,0,0,'');
    end if;
    
    commit work
  end if
end;

if exists(select * from sys.sysprocedure where proc_name = 'ASQLCalPayRecNetWage') then
   drop procedure ASQLCalPayRecNetWage
end if;
create procedure dba.ASQLCalPayRecNetWage(
in In_EmployeeSysId integer,
in In_PayRecYear integer,
in In_PayRecPeriod integer,
in In_PayRecSubPeriod integer,
in In_PayRecID char(20),
in In_NetWageExRate double,
in In_NetWageExRateId char(20))
begin
  declare In_NetWage double;
  declare In_CalTotalWage double;
  declare In_CalOTAmount double;
  declare In_CalOTBackPay double;
  declare In_CalShiftAmount double;
  declare In_CalLveDeductAmt double;
  declare In_CalBackPay double;
  declare In_TotalContriEECPF double;
  declare In_TaxAmt double;
  declare In_TaxMethod char(20);
  declare In_ECOLA double;
  declare In_NetWageContriDiff double;
  declare In_NetWageP double;

  declare Out_AllocatedBasicRate double;
  declare Out_AllocatedBasicRateF double;
  declare Out_CurrentBRExRateId char(20);
  declare Out_NetWageExRateId char(20);

  /*
  Set initial Tax Amount
  */
  set In_TaxAmt=0;
  set In_TotalContriEECPF=0;
  select CalTotalWage into In_CalTotalWage
    from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  select CalOTAmount into In_CalOTAmount
    from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  select CalOTBackPay into In_CalOTBackPay
    from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  select CalShiftAmount into In_CalShiftAmount
    from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  select CalLveDeductAmt into In_CalLveDeductAmt from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  select CalBackPay into In_CalBackPay from DetailRecord where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  /*
  Brunei consider EE TAP 1,2 and 3
  */
  if(FGetDBCountry(*) = 'Brunei') then
    select TotalContriEECPF + ContriOrdEECPF + ContriAddEECPF + CurrEEManContri into In_TotalContriEECPF from PolicyRecord 

where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  /*
  Indonesia consider EE Jamsostek, EE BPJS Kesehatan, EE BPJS Pensiun & Tax Amt (For Gross To Net)
  */
  elseif(FGetDBCountry(*) = 'Indonesia') then
    select ContriOrdEECPF+CurrEEManContri+CurrEEVolContri into In_TotalContriEECPF from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    Check for Gross To Net    
    */
    select IndoTaxMethod into In_TaxMethod from IndoTaxDetails where
      PersonalSysId = (select PersonalSysId from Employee where EmployeeSysId = In_EmployeeSysId);
    if(In_TaxMethod = 'GrossToNet') then
      select CurAdditionalWage into In_TaxAmt from PolicyRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID
    elseif(In_TaxMethod = 'Userdefined') then
      select PrevOrdinaryWage into In_TaxAmt from PolicyRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID 
    end if
  /*
  Malaysia consider EPF, SOCSO & Tax Amt
  */
  elseif(FGetDBCountry(*) = 'Malaysia') then
    select ContriOrdEECPF+CurrEEManContri+CurrEEVolContri+PrevEEManContri+PrevEEVolContri into In_TotalContriEECPF
      from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    /*
    Check for Employee Pay Tax
    */
    select MalTaxMethod into In_TaxMethod from MalTaxDetails where
      PersonalSysId = (select PersonalSysId from Employee where EmployeeSysId = In_EmployeeSysId);
    if(In_TaxMethod = 'EEPayTax') then
      select PaidCurrentTaxAmt+PaidPreviousTaxAmt into In_TaxAmt from PolicyRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID
    end if
  /*
  Singapore consider CPF
  */
  elseif(FGetDBCountry(*) = 'Singapore') then
    select TotalContriEECPF into In_TotalContriEECPF from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  /*
  Philippines consider PHIC / HDMF / SSS / ECOLA / Tax
  */
  elseif(FGetDBCountry(*) = 'Philippines') then
    select ContriOrdEECPF+ContriAddEECPF+CurrEEManContri into In_TotalContriEECPF from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID;
    select ContriSDF into In_ECOLA from PeriodPolicySummary where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod;
    set In_TotalContriEECPF=In_TotalContriEECPF-In_ECOLA;
    /*
    Check for Employee Pay Tax
    */
    select PhTaxMethod into In_TaxMethod from PhTaxDetails where
      PersonalSysId = (select PersonalSysId from Employee where EmployeeSysId = In_EmployeeSysId);
    if(In_TaxMethod = 'EEPayTax') then
      select PaidCurrentTaxAmt into In_TaxAmt from PolicyRecord where
        EmployeeSysId = In_EmployeeSysId and
        PayRecYear = In_PayRecYear and
        PayRecPeriod = In_PayRecPeriod and
        PayRecSubPeriod = In_PayRecSubPeriod and
        PayRecID = In_PayRecID
    end if
  /*
  Vietnam consider HI / SI / Tax
  */
  elseif(FGetDBCountry(*) = 'Vietnam') then
    select CurrEEVolContri+PrevEEVolContri+CurrEEVolWage+PrevEEVolWage+ContriAddEECPF,PreviousTaxAmount+CurNWCHrDaysRate into 

In_TotalContriEECPF,In_TaxAmt from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  /*
  Hongkong consider MPF
  */
  elseif(FGetDBCountry(*) = 'HongKong') then
    select PrevEEVolContri+PrevEEManContri into In_TotalContriEECPF from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  /*
  Thailand consider PF / Tax
  */
  elseif(FGetDBCountry(*) = 'Thailand') then
    select ContriOrdEECPF+TotalContriEECPF+CurrEEManContri+PrevEEManContri+CurrEEManWage+PrevEEManWage,PaidCurrentTaxAmt into 

In_TotalContriEECPF,In_TaxAmt from PolicyRecord where
      EmployeeSysId = In_EmployeeSysId and
      PayRecYear = In_PayRecYear and
      PayRecPeriod = In_PayRecPeriod and
      PayRecSubPeriod = In_PayRecSubPeriod and
      PayRecID = In_PayRecID
  end if;
  set In_NetWage
    =In_CalTotalWage+
    In_CalOTAmount+
    In_CalOTBackPay+
    In_CalShiftAmount+
    In_CalBackPay+
    FGetPayRecAllPayElement(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecID)+
    In_CalLveDeductAmt-
    In_TotalContriEECPF-
    In_TaxAmt;
  set In_NetWage=Round(In_NetWage,FGetDBPayDecimal(*));

  select AllocatedBasicRate,AllocatedBasicRateF,CurrentBRExRateId,NetWageExRateId into
         Out_AllocatedBasicRate,Out_AllocatedBasicRateF,Out_CurrentBRExRateId,Out_NetWageExRateId from DetailRecord where
         EmployeeSysId = In_EmployeeSysId and
         PayRecYear = In_PayRecYear and
         PayRecPeriod = In_PayRecPeriod and
         PayRecSubPeriod = In_PayRecSubPeriod and
         PayRecID = In_PayRecID;

  if (In_NetWage = Out_AllocatedBasicRate and Out_CurrentBRExRateId = Out_NetWageExRateId and Length(Out_CurrentBRExRateId)>0) then
    set In_NetWageP=Out_AllocatedBasicRateF;  
  else  
    set In_NetWageP=Round(In_NetWage*In_NetWageExRate,FGetDBPayDecimal(*));
  end if;  

  update DetailRecord set
    CalNetWage = In_NetWage,
    NetWageP = In_NetWageP,
    NetWageExRate = In_NetWageExRate,
    NetWageExRateId = In_NetWageExRateId where
    EmployeeSysId = In_EmployeeSysId and
    PayRecYear = In_PayRecYear and
    PayRecPeriod = In_PayRecPeriod and
    PayRecSubPeriod = In_PayRecSubPeriod and
    PayRecID = In_PayRecID;
  commit work
end;

if exists(select * from sys.sysprocedure where proc_name = 'DeleteEmpCode1') then
   drop procedure DeleteEmpCode1
end if;
create procedure dba.DeleteEmpCode1(
in In_EmpCode1Id char(20))
begin
  if exists(select* from EmpCode1 where EmpCode1.EmpCode1Id = In_EmpCode1Id) and DeleteDefault('EmpCode1Id',In_EmpCode1Id) = 1 then
     if not exists(select * from Employee where EmpCode1Id = In_EmpCode1Id) then
        delete from EmpCode1 where
        EmpCode1.EmpCode1Id = In_EmpCode1Id;
        commit work
     end if
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'DeleteEmpCode2') then
   drop procedure DeleteEmpCode2
end if;
create procedure dba.DeleteEmpCode2(
in In_EmpCode2Id char(20))
begin
  if exists(select* from EmpCode2 where EmpCode2.EmpCode2Id = In_EmpCode2Id) and DeleteDefault('EmpCode2Id',In_EmpCode2Id) = 1 then
    if not exists(select * from Employee where EmpCode2Id = In_EmpCode2Id) then
       delete from EmpCode2 where
       EmpCode2.EmpCode2Id = In_EmpCode2Id;
       commit work
    end if
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'DeleteEmpCode3') then
   drop procedure DeleteEmpCode3
end if;
create procedure dba.DeleteEmpCode3(
in In_EmpCode3Id char(20))
begin
  if exists(select* from EmpCode3 where EmpCode3.EmpCode3Id = In_EmpCode3Id) and DeleteDefault('EmpCode3Id',In_EmpCode3Id) = 1 then
    if not exists(select * from Employee where EmpCode3Id = In_EmpCode3Id) then
       delete from EmpCode3 where
       EmpCode3.EmpCode3Id = In_EmpCode3Id;
       commit work
    end if
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'DeleteEmpCode4') then
   drop procedure DeleteEmpCode4
end if;
create procedure dba.DeleteEmpCode4(
in In_EmpCode4Id char(20))
begin
  if exists(select* from EmpCode4 where EmpCode4.EmpCode4Id = In_EmpCode4Id) and DeleteDefault('EmpCode4Id',In_EmpCode4Id) = 1 then
    if not exists(select * from Employee where EmpCode4Id = In_EmpCode4Id) then
       delete from EmpCode4 where
       EmpCode4.EmpCode4Id = In_EmpCode4Id;
       commit work
    end if
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'DeleteEmpCode5') then
   drop procedure DeleteEmpCode5
end if;
create procedure dba.DeleteEmpCode5(
in In_EmpCode5Id char(20))
begin
  if exists(select* from EmpCode5 where EmpCode5.EmpCode5Id = In_EmpCode5Id) and DeleteDefault('EmpCode5Id',In_EmpCode5Id) = 1 then
    if not exists(select * from Employee where EmpCode5Id = In_EmpCode5Id) then      
       delete from EmpCode5 where
       EmpCode5.EmpCode5Id = In_EmpCode5Id;
      commit work
    end if
  end if
end
;

if exists(select * from sys.sysprocedure where proc_name = 'DeleteEmpLocation1') then
   drop procedure DeleteEmpLocation1
end if;
create procedure dba.DeleteEmpLocation1(
in In_EmpLocation1Id char(20))
begin
  if exists(select* from EmpLocation1 where EmpLocation1.EmpLocation1Id = In_EmpLocation1Id) and DeleteDefault('EmpLocation1Id',In_EmpLocation1Id) = 1 then
    if not exists(select * from Employee where EmpLocation1Id = In_EmpLocation1Id) then    
      delete from EmpLocation1 where
      EmpLocation1.EmpLocation1Id = In_EmpLocation1Id;
      commit work
    end if
  end if
end
;

commit work;