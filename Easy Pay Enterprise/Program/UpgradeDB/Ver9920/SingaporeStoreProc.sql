if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLUpdateCasRecord') then
   drop procedure ASQLUpdateCasRecord
end if
;

CREATE PROCEDURE "DBA"."ASQLUpdateCasRecord"(
in In_CasualSGSPGenId char(30),
out Out_Error integer)
begin
  declare Out_DailyWage double;
  declare Out_TotalDailyWage double;
  declare Out_CurOrdinaryWage double;
  declare Out_CurAdditionalWage double;
  declare Out_NonCPFWage double;
  set Out_Error=0;
  set Out_DailyWage=FGetCasRecordDailyWage(In_CasualSGSPGenId);
  set Out_TotalDailyWage=FGetCasRecordTotalDailyWage(In_CasualSGSPGenId);
  set Out_CurOrdinaryWage=FGetCasRecordCurOrdinaryWage(In_CasualSGSPGenId);
  set Out_CurAdditionalWage=FGetCasRecordCurAdditionalWage(In_CasualSGSPGenId);
  set Out_NonCPFWage=FGetCasRecordNonCPFWage(In_CasualSGSPGenId);
  /*
  Check Record exists
  */
  if exists(select* from CasRecord where
      CasualSGSPGenId = In_CasualSGSPGenId) then
    update CasRecord set
      DailyWage = Out_DailyWage,
      TotalDailyWage = Out_TotalDailyWage,
      CurOrdinaryWage = Out_CurOrdinaryWage,
      CurAdditionalWage = Out_CurAdditionalWage,
      NonCPFWage = Out_NonCPFWage where
      CasualSGSPGenId = In_CasualSGSPGenId;
    commit work;
    set Out_Error=1
  end if
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'FGetCasRecordDailyWage') then
   drop procedure FGetCasRecordDailyWage
end if
;

CREATE FUNCTION "DBA"."FGetCasRecordDailyWage"(
in In_CasualSGSPGenId char(30))
returns double
begin
  declare Out_DailyWage double;
  select(cast(CasRecord.NoOfHour as MONEY) * cast(CasRecord.HourRate as MONEY)) into Out_DailyWage
    from CasRecord where
    CasRecord.CasualSGSPGenId = In_CasualSGSPGenId;
  set Out_DailyWage=Round(Out_DailyWage,FGetDBPayDecimal(*));
  return(Out_DailyWage)
end
;

COMMIT WORK;
