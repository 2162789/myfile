if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalArrearEEEPFByGenId') then
   drop FUNCTION FGetMalArrearEEEPFByGenId
end if;

create FUNCTION DBA.FGetMalArrearEEEPFByGenId(
in In_GenId char(30),
in In_Tablename char(40))
RETURNS double
BEGIN
    declare In_EmployeeSysId int;
    declare In_PayRecYear int;
    declare In_PayRecPeriod int;
    declare In_PayRecSubPeriod int;
    declare In_PayRecId char(20);
    declare Out_EEEPF double;
    
    if (In_Tablename = 'PolicyRecord' or In_Tablename = '') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId 
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecId 
        from PolicyRecord Where PolicyRecSGSPGenId = In_GenId;
    elseif (In_Tablename = 'PeriodPolicySummary' or In_Tablename = 'PayPeriodRecord') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod
        from PeriodPolicySummary Where PayPeriodSGSPGenId = In_GenId;
        return FGetMalArrearEEEPF(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,'');
    elseif (In_Tablename = 'AllowanceRecord') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId 
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecId 
        from AllowanceRecord Where AllowanceSGSPGenId = In_GenId;
    elseif (In_Tablename = 'PayRecord') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId 
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecId 
        from PayRecord Where PayRecSGSPGenId = In_GenId;
    elseif (In_Tablename = 'DetailRecord') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId 
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecId 
        from DetailRecord Where DetailRecSGSPGenId = In_GenId;
    else
        return 0;
    end if;

    Select Sum(UserDef2Value) into Out_EEEPF From AllowanceRecord join AllowanceHistoryRecord Where
        EmployeeSysId = In_EmployeeSysId And
        PayRecYear = In_PayRecYear And
        PayRecPeriod = In_PayRecPeriod And
        PayRecId = In_PayRecId And
        AllowanceFormulaId in 
            (Select FormulaId From Formula Where FormulaType= 'Formula' And FormulaSubCategory='Allowance' And Substring(FormulaId,1,6) = 'Arrear');

    if Out_EEEPF is null then set Out_EEEPF = 0 end if;
	return Out_EEEPF;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalArrearEEEPFWageByGenId') then
   drop FUNCTION FGetMalArrearEEEPFWageByGenId
end if;

create FUNCTION DBA.FGetMalArrearEEEPFWageByGenId(
in In_GenId char(30),
in In_Tablename char(40))
RETURNS double
BEGIN
    declare In_EmployeeSysId int;
    declare In_PayRecYear int;
    declare In_PayRecPeriod int;
    declare In_PayRecSubPeriod int;
    declare In_PayRecId char(20);
    declare Out_EREPFWage double;
   
    if (In_Tablename = 'PolicyRecord' or In_Tablename = '') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId 
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecId 
        from PolicyRecord Where PolicyRecSGSPGenId = In_GenId;
    elseif (In_Tablename = 'PeriodPolicySummary' or In_Tablename = 'PayPeriodRecord') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod
        from PeriodPolicySummary Where PayPeriodSGSPGenId = In_GenId;
        return FGetMalArrearEEEPFWage(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,'');
    elseif (In_Tablename = 'AllowanceRecord') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId 
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecId 
        from AllowanceRecord Where AllowanceSGSPGenId = In_GenId;
    elseif (In_Tablename = 'PayRecord') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId 
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecId 
        from PayRecord Where PayRecSGSPGenId = In_GenId;
    elseif (In_Tablename = 'DetailRecord') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId 
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecId 
        from DetailRecord Where DetailRecSGSPGenId = In_GenId;
    else
        return 0;
    end if;

    Select Sum(UserDef1Value) into Out_EREPFWage From AllowanceRecord join AllowanceHistoryRecord Where
        EmployeeSysId = In_EmployeeSysId And
        PayRecYear = In_PayRecYear And
        PayRecPeriod = In_PayRecPeriod And
        PayRecId = In_PayRecId And
        AllowanceFormulaId in 
            (Select FormulaId From Formula Where FormulaType= 'Formula' And FormulaSubCategory='Allowance' And Substring(FormulaId,1,6) = 'Arrear');
 
    if Out_EREPFWage is null then set Out_EREPFWage = 0 end if;
	return Out_EREPFWage;
END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalArrearEREPFByGenId') then
   drop FUNCTION FGetMalArrearEREPFByGenId
end if;

create FUNCTION DBA.FGetMalArrearEREPFByGenId(
in In_GenId char(30),
in In_Tablename char(40))
RETURNS double
BEGIN
    declare In_EmployeeSysId int;
    declare In_PayRecYear int;
    declare In_PayRecPeriod int;
    declare In_PayRecSubPeriod int;
    declare In_PayRecId char(20);
    declare Out_EREPF double;
    
    if (In_Tablename = 'PolicyRecord' or In_Tablename = '') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId 
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecId 
        from PolicyRecord Where PolicyRecSGSPGenId = In_GenId;
    elseif (In_Tablename = 'PeriodPolicySummary' or In_Tablename = 'PayPeriodRecord') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod
        from PeriodPolicySummary Where PayPeriodSGSPGenId = In_GenId;
        return FGetMalArrearEREPF(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,'');
    elseif (In_Tablename = 'AllowanceRecord') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId 
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecId 
        from AllowanceRecord Where AllowanceSGSPGenId = In_GenId;
    elseif (In_Tablename = 'PayRecord') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId 
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecId 
        from PayRecord Where PayRecSGSPGenId = In_GenId;
    elseif (In_Tablename = 'DetailRecord') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId 
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecId 
        from DetailRecord Where DetailRecSGSPGenId = In_GenId;
    else
        return 0;
    end if;

    Select Sum(UserDef3Value) into Out_EREPF From AllowanceRecord join AllowanceHistoryRecord Where
        EmployeeSysId = In_EmployeeSysId And
        PayRecYear = In_PayRecYear And
        PayRecPeriod = In_PayRecPeriod And
        PayRecSubPeriod = In_PayRecSubPeriod And
        PayRecId = In_PayRecId And
        AllowanceFormulaId in 
            (Select FormulaId From Formula Where FormulaType= 'Formula' And FormulaSubCategory='Allowance' And Substring(FormulaId,1,6) = 'Arrear');

    if Out_EREPF is null then set Out_EREPF = 0 end if;
	return Out_EREPF;

END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalArrearTaxByGenId') then
   drop FUNCTION FGetMalArrearTaxByGenId
end if;

create FUNCTION DBA.FGetMalArrearTaxByGenId(
in In_GenId char(30),
in In_Tablename char(40))
RETURNS double
BEGIN
    declare In_EmployeeSysId int;
    declare In_PayRecYear int;
    declare In_PayRecPeriod int;
    declare In_PayRecSubPeriod int;
    declare In_PayRecId char(20);
    declare Out_Tax double;    

    if (In_Tablename = 'PolicyRecord' or In_Tablename = '') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId 
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecId 
        from PolicyRecord Where PolicyRecSGSPGenId = In_GenId;
    elseif (In_Tablename = 'PeriodPolicySummary' or In_Tablename = 'PayPeriodRecord') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod
        from PeriodPolicySummary Where PayPeriodSGSPGenId = In_GenId;
        return FGetMalArrearTax(In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,'');
    elseif (In_Tablename = 'AllowanceRecord') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId 
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecId 
        from AllowanceRecord Where AllowanceSGSPGenId = In_GenId;
    elseif (In_Tablename = 'PayRecord') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId 
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecId 
        from PayRecord Where PayRecSGSPGenId = In_GenId;
    elseif (In_Tablename = 'DetailRecord') then
        Select EmployeeSysId,PayRecYear,PayRecPeriod,PayRecSubPeriod,PayRecId 
        into In_EmployeeSysId,In_PayRecYear,In_PayRecPeriod,In_PayRecSubPeriod,In_PayRecId 
        from DetailRecord Where DetailRecSGSPGenId = In_GenId;
    else
        return 0;
    end if;

    Select Sum(UserDef4Value) into Out_Tax From AllowanceRecord join AllowanceHistoryRecord Where
        EmployeeSysId = In_EmployeeSysId And
        PayRecYear = In_PayRecYear And
        PayRecPeriod = In_PayRecPeriod And
        PayRecSubPeriod = In_PayRecSubPeriod And
        PayRecId = In_PayRecId And
        AllowanceFormulaId in 
            (Select FormulaId From Formula Where FormulaType= 'Formula' And FormulaSubCategory='Allowance' And Substring(FormulaId,1,6) = 'Arrear');

    if Out_Tax is null then set Out_Tax = 0 end if;
	return Out_Tax;

END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetMalPolicyRecTotalEPF') then
   drop FUNCTION FGetMalPolicyRecTotalEPF
end if;

create FUNCTION DBA.FGetMalPolicyRecTotalEPF(
in In_GenId char(30))
RETURNS double
BEGIN
    declare In_EmployeeSysId int;
    declare In_PayRecYear int;
    declare In_PayRecPeriod int;
    declare In_PayRecSubPeriod int;
    declare In_PayRecId char(20);
    declare In_CurrEEManContri double;
    declare In_CurrEEVolContri double;
    declare In_PrevEEManContri double;
    declare In_PrevEEVolContri double;
    declare In_CurrERManContri double;
    declare In_CurrERVolContri double;
    declare In_PrevERManContri double;
    declare In_PrevERVolContri double;
    declare In_ArrearEPF double;
    declare Out_TotalEPF double;       

    Select EmployeeSysId,
        PayRecYear,
        PayRecPeriod,
        PayRecSubPeriod,
        PayRecId,
        CurrEEManContri,
        CurrEEVolContri,
        PrevEEManContri,
        PrevEEVolContri,
        CurrERManContri,
        CurrERVolContri,
        PrevERManContri,
        PrevERVolContri
    into 
        In_EmployeeSysId,
        In_PayRecYear,
        In_PayRecPeriod,
        In_PayRecSubPeriod,
        In_PayRecId, 
        In_CurrEEManContri,
        In_CurrEEVolContri,
        In_PrevEEManContri,
        In_PrevEEVolContri,
        In_CurrERManContri,
        In_CurrERVolContri,
        In_PrevERManContri,
        In_PrevERVolContri
    from PolicyRecord Where PolicyRecSGSPGenId = In_GenId;

    Select Sum(UserDef2Value + UserDef3Value) into In_ArrearEPF From AllowanceRecord join AllowanceHistoryRecord Where
            EmployeeSysId = In_EmployeeSysId And
            PayRecYear = In_PayRecYear And
            PayRecPeriod = In_PayRecPeriod And
            PayRecSubPeriod = In_PayRecSubPeriod And
            PayRecId = In_PayRecId And
            AllowanceFormulaId in 
                (Select FormulaId From Formula Where FormulaType= 'Formula' And FormulaSubCategory='Allowance' And Substring(FormulaId,1,6) = 'Arrear');

    if In_ArrearEPF is null then set In_ArrearEPF = 0 end if;
    
    set Out_TotalEPF = In_CurrEEManContri + 
                       In_CurrEEVolContri + 
                       In_PrevEEManContri + 
                       In_PrevEEVolContri + 
                       In_CurrERManContri + 
                       In_CurrERVolContri + 
                       In_PrevERManContri + 
                       In_PrevERVolContri + 
                       In_ArrearEPF;

    return Out_TotalEPF;

END
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLMalReOrderSerialNo') then
   drop PROCEDURE ASQLMalReOrderSerialNo
end if;

CREATE PROCEDURE DBA.ASQLMalReOrderSerialNo(
in In_MalTaxYear integer,
in In_Option char(20))
begin
  /*
  Clear all Serial No
  */
  declare A_Serial integer;
  declare B_Serial integer; // New Hire
  declare C_Serial integer; // Terminated
  declare SerialNo integer;
  declare sSerialNo char(20);
  set A_Serial=0;
  set B_Serial=0;
  set C_Serial=0;
  /*
  Set all Serial No to contain Letter only
  */
  update MalTaxRecord set MalTaxSerialNo = SubString(MalTaxSerialNo,1,1) where
    FGetMalTaxRecordYear(MalTaxYear) = In_MalTaxYear;

  if (In_Option = 'Name') then
      UpdateSerialNoLoop: for UpdateSerialNoFor as Namecurs dynamic scroll cursor for
        select PersonalSysId as Out_PersonalSysId, MalTaxYear as Out_MalTaxYear,
        MalTaxSerialNo as Out_MalTaxSerialNo,
        FGetPersonalName(PersonalsysId) as PersonalName 
        from MalTaxRecord
        where FGetMalTaxRecordYear(MalTaxYear) = In_MalTaxYear Order By PersonalName do
        if(Out_MalTaxSerialNo = 'C') then
          set C_Serial=C_Serial+1;
          set SerialNo=C_Serial
        elseif(Out_MalTaxSerialNo = 'B') then
          set B_Serial=B_Serial+1;
          set SerialNo=B_Serial
        else
          set A_Serial=A_Serial+1;
          set SerialNo=A_Serial
        end if;
        if(SerialNo < 10) then set sSerialNo=String(Out_MalTaxSerialNo,'0000',SerialNo)
        elseif(SerialNo < 100) then set sSerialNo=String(Out_MalTaxSerialNo,'000',SerialNo)
        elseif(SerialNo < 1000) then set sSerialNo=String(Out_MalTaxSerialNo,'00',SerialNo)
        elseif(SerialNo < 10000) then set sSerialNo=String(Out_MalTaxSerialNo,'0',SerialNo)
        else set sSerialNo=String(Out_MalTaxSerialNo,SerialNo)
        end if;
        update MalTaxRecord set
          MalTaxSerialNo = sSerialNo where PersonalSysId = Out_PersonalSysId and MalTaxYear = Out_MalTaxYear;
        end for;
  elseif (In_Option = 'Employee ID') then
      
      UpdateSerialNoLoop: for UpdateSerialNoFor as EmployeeIdcurs dynamic scroll cursor for
        select PersonalSysId as Out_PersonalSysId, MalTaxYear as Out_MalTaxYear,
        MalTaxSerialNo as Out_MalTaxSerialNo, 
        FGetEmployeeId(FGetMalTaxRecordEmployeeSysId(PersonalSysId,MalTaxYear)) as EmployeeId
        from MalTaxRecord 
        where FGetMalTaxRecordYear(MalTaxYear) = In_MalTaxYear Order By EmployeeId do
        if(Out_MalTaxSerialNo = 'C') then
          set C_Serial=C_Serial+1;
          set SerialNo=C_Serial
        elseif(Out_MalTaxSerialNo = 'B') then
          set B_Serial=B_Serial+1;
          set SerialNo=B_Serial
        else
          set A_Serial=A_Serial+1;
          set SerialNo=A_Serial
        end if;
        if(SerialNo < 10) then set sSerialNo=String(Out_MalTaxSerialNo,'0000',SerialNo)
        elseif(SerialNo < 100) then set sSerialNo=String(Out_MalTaxSerialNo,'000',SerialNo)
        elseif(SerialNo < 1000) then set sSerialNo=String(Out_MalTaxSerialNo,'00',SerialNo)
        elseif(SerialNo < 10000) then set sSerialNo=String(Out_MalTaxSerialNo,'0',SerialNo)
        else set sSerialNo=String(Out_MalTaxSerialNo,SerialNo)
        end if;
        update MalTaxRecord set
          MalTaxSerialNo = sSerialNo where PersonalSysId = Out_PersonalSysId and MalTaxYear = Out_MalTaxYear;
        end for;
  else

      UpdateSerialNoLoop: for UpdateSerialNoFor as IdentityNocurs dynamic scroll cursor for
        select PersonalSysId as Out_PersonalSysId, MalTaxYear as Out_MalTaxYear,
        MalTaxSerialNo as Out_MalTaxSerialNo, 
        FGetIdentityNo(PersonalSysId) as IdentityNo
        from MalTaxRecord 
        where FGetMalTaxRecordYear(MalTaxYear) = In_MalTaxYear Order By IdentityNo do
        if(Out_MalTaxSerialNo = 'C') then
          set C_Serial=C_Serial+1;
          set SerialNo=C_Serial
        elseif(Out_MalTaxSerialNo = 'B') then
          set B_Serial=B_Serial+1;
          set SerialNo=B_Serial
        else
          set A_Serial=A_Serial+1;
          set SerialNo=A_Serial
        end if;
        if(SerialNo < 10) then set sSerialNo=String(Out_MalTaxSerialNo,'0000',SerialNo)
        elseif(SerialNo < 100) then set sSerialNo=String(Out_MalTaxSerialNo,'000',SerialNo)
        elseif(SerialNo < 1000) then set sSerialNo=String(Out_MalTaxSerialNo,'00',SerialNo)
        elseif(SerialNo < 10000) then set sSerialNo=String(Out_MalTaxSerialNo,'0',SerialNo)
        else set sSerialNo=String(Out_MalTaxSerialNo,SerialNo)
        end if;
        update MalTaxRecord set
          MalTaxSerialNo = sSerialNo where PersonalSysId = Out_PersonalSysId and MalTaxYear = Out_MalTaxYear;
        end for;
  end if;
  commit work
end
;
commit work;