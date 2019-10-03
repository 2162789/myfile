IF exists(select 1 from sys.syscolumns where tname = 'PayPeriodRecord' and cname = 'PayClassificationCode') then
   alter table PayPeriodRecord rename PayClassificationCode to PayClassification;
END IF;

READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_Employee.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_EmployeeBank1.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_EmployeeBank2.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_EmployeeCompany.sql';

READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_EmployeeCurCPFProgression.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_EmployeeCurEPProgression.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_EmployeeCurFWLProgression.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_EmployeeCurResidenceStatus.sql';

READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_EmployeeCustom.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_EmployeeDetails.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_EmployeeEportalContact.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_EmployeeEportalEmail.sql';

READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_EmployeeMailAddress.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_EmployeePayCalc.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_EmployeeStandard.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_LveApprovedRecord.sql';

READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_LvePeriodPolicyHistory.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_LvePeriodPolicySumm.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_LvePeriodSumm.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_LveYearPolicyHistory.sql';

READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_LveYearPolicySumm.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_LveYearSumm.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_PayEmployeeDetails.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_PayPeriodBalance.sql';

READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_PayPeriodEmployeeInfo.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_PayPeriodSumm.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_PayPeriodSummary.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_PayPeriodSummContriTax.sql';

READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_PayStandardDetails.sql';
READ 'UpgradeDB\Ver1060304\ViewTable\View_Alc_PersonnelDetails.sql';

READ 'UpgradeDB\Ver1060304\ASQLGrantSelect.sql';
CALL ASQLGrantSelect('AlchemexUser');
DROP Procedure DBA.ASQLGrantSelect;

IF EXISTS(SELECT 1 FROM sys.sysprocedure where proc_name = 'UpdateLoginRecIP') THEN
   DROP PROCEDURE UpdateLoginRecIP
END IF;

IF EXISTS(SELECT 1 FROM sys.sysprocedure where proc_name = 'DeleteRemSetup') THEN
   DROP PROCEDURE DeleteRemSetup
END IF;

create PROCEDURE DBA.DeleteRemSetup(
in In_RemSetupSysID integer,
out Out_ErrorCode integer)
begin
 if exists (select * from Task where RemSetupSysID= In_RemSetupSysID) then
    set Out_ErrorCode = -1
 else
      if exists(select* from RemSetup where RemSetupSysID = In_RemSetupSysID) then
        delete from RemSetup where
        RemSetupSysID  = In_RemSetupSysID;
      commit work;
    if exists(select* from RemSetup where  RemSetupSysID  = In_RemSetupSysID) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end if
end
;

IF EXISTS(SELECT 1 FROM sys.sysprocedure where proc_name = 'FGetLveCreditRemaks') THEN
   DROP PROCEDURE FGetLveCreditRemaks
END IF;

create FUNCTION DBA.FGetLveCreditRemaks(
in In_EmployeeSysId integer,
in In_LeaveTypeId char(20),
in In_LeaveStatus char(20),
in In_LeaveDate date)
RETURNS char(100)
BEGIN
	DECLARE Out_Result char(100);
    DECLARE TempDate date;
    SET Out_Result = '';

	If In_LeaveStatus = 'Earned' then
       Select CreditExpireDate into TempDate from AdjustCredit
         where EmployeeSysId = In_EmployeeSysId and LeaveTypeId = In_LeaveTypeId and AdjEffectiveDate = In_LeaveDate ;
       If FGetInvalidDate(TempDate) != '' then
          set Out_Result = 'Expired on ' + FGetDateFormat(TempDate);
       end if;
    end if; 

	If In_LeaveStatus = 'Expired' then       
        set Out_Result = 'Earned on ';
        GetEarnedLoop: for GetEarnedFor as Cur_AdjustCredit dynamic scroll cursor for
        Select AdjEffectiveDate as EarnedDate from AdjustCredit
         where EmployeeSysId = In_EmployeeSysId and LeaveTypeId = In_LeaveTypeId and CreditExpireDate = In_LeaveDate Order by AdjEffectiveDate
        do
            If FGetInvalidDate(EarnedDate) != '' then
                set Out_Result = Out_Result + FGetDateFormat(EarnedDate) + ' ';
            end if;
        end for
    end if; 

	RETURN Out_Result;
END
;

if not exists (select 1 from Registry where Registryid = 'Task') then
  insert into registry values('Task','Task');
  insert into subregistry values('Task','TaskOn','','','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

Update RemFunction SET SysDateAttributeID='EPExpiryDate', FuncKeyAttributeId1='E.EmployeeSysID', FuncKeyword3='EPExpiryDate' where RemFunctionID='PayEPExpiry'; 

commit work;