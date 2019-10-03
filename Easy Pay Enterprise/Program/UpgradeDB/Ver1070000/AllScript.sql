if exists(select * from sys.sysprocedure where proc_name = 'ASQLTimeSheetDistributeSDF') then
   drop procedure ASQLTimeSheetDistributeSDF
end if;
create procedure DBA.ASQLTimeSheetDistributeSDF(
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
    select Number(*) as In_ID,
	  TimeSheet.TMSSGSPGenId as In_TMSSGSPGenId,
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
		if (In_ID = In_TotalRecord) then
		   set In_ContriSDF=Round(Cast(In_TotalContriSDF-Accu_ContriSDF as numeric(18,2)),In_DecimalPlace)
		else
		  if(In_ContriSDF+Accu_ContriSDF > In_TotalContriSDF) then
             set In_ContriSDF=Round(Cast(In_TotalContriSDF-Accu_ContriSDF as numeric(18,2)),In_DecimalPlace)
          end if
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