READ UpgradeDB\Ver1060004\CPFPolicyTable.sql;
READ UpgradeDB\Ver1060004\CPF_EP.sql;
READ UpgradeDB\Ver1060004\CPF_FW.sql;
READ UpgradeDB\Ver1060004\CPF_Local.sql;
READ UpgradeDB\Ver1060004\CPF_PR1Full.sql;
READ UpgradeDB\Ver1060004\CPF_PR1Grad.sql;
READ UpgradeDB\Ver1060004\CPF_PR2Full.sql;
READ UpgradeDB\Ver1060004\CPF_PR2Grad.sql;
READ UpgradeDB\Ver1060004\CPF_PR3.sql;

If exists (select 1 from sys.sysprocedure where proc_name = 'PatchInsertCPFProgression') then
   Drop procedure PatchInsertCPFProgression
end if;

create procedure DBA.PatchInsertCPFProgression(in In_EffectiveDate date,in In_CPFProgPolicyId char(20))
begin
  declare Out_CPFEffectiveDate date;
  declare Out_CPFCareerId char(20);
  declare Out_CPFProgAccountNo char(30);
  declare Out_CPFProgSchemeId char(20);
  declare Out_CPFMAWOption smallint;
  declare Out_CPFMAWLimit double;
  declare Out_CPFMAWPeriodOrdWage double;
  declare Out_CPFMedisavePaidByER smallint;
  /*  Get Employee that have payment */
  EmployeeLoop: for EmployeeFor as curs dynamic scroll cursor for
    select EmployeeSysId as Out_EmployeeSysId,
      LastPayDate as Out_LastPayDate from
      PayEmployee where
      (LastPayDate = '1899-12-30' or LastPayDate >= In_EffectiveDate) do
    /*  Record not inserted yet */
    if not exists(select* from CPFProgression where CPFEffectiveDate = In_EffectiveDate and EmployeeSysID = Out_EmployeeSysId) then
      /* Get the nearest CPF Progression Record */ 
      set Out_CPFEffectiveDate = null;
      select first CPFEffectiveDate,
        CPFCareerId,
        CPFProgAccountNo,
        CPFProgSchemeId,
        CPFMAWOption,
        CPFMAWLimit,
        CPFMAWPeriodOrdWage,
        CPFMedisavePaidByER into Out_CPFEffectiveDate,
        Out_CPFCareerId,
        Out_CPFProgAccountNo,
        Out_CPFProgSchemeId,
        Out_CPFMAWOption,
        Out_CPFMAWLimit,
        Out_CPFMAWPeriodOrdWage,
        Out_CPFMedisavePaidByER from CPFProgression where
        EmployeeSysID = Out_EmployeeSysId and
        CPFEffectiveDate < In_EffectiveDate and
        CPFProgPolicyId <> '' and
        CPFProgSchemeId <> '' order by
        CPFEffectiveDate desc;
      /* Nearest CPF Progression Record is found */
      if(Out_CPFEffectiveDate is not null) then
        call InsertNewCPFProgression(
        Out_EmployeeSysId,
        In_EffectiveDate,
        0,
        Out_CPFCareerId,
        In_CPFProgPolicyId,
        Out_CPFProgAccountNo,
        Out_CPFProgSchemeId,
        Out_CPFMAWOption,
        Out_CPFMAWLimit,
        Out_CPFMAWPeriodOrdWage,
        Out_CPFMedisavePaidByER,'')
      end if
    end if end for
end;

call PatchInsertCPFProgression('2012-01-01','Year2012Jan');
Drop procedure PatchInsertCPFProgression;

Update CPFProgression Set CPFMAWLimit = 25000 Where CPFEffectiveDate = '2012-01-01' And CPFMAWLimit = 23333;

Commit Work;