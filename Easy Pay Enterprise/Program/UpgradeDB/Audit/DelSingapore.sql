
Read upgradeDB\Audit\DelBasic.sql;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailDeletePeriodPolicySummary') then
   drop  trigger AuditTrailDeletePeriodPolicySummary
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailInsertPeriodPolicySummary') then
   drop  trigger AuditTrailInsertPeriodPolicySummary
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CalFWL') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_CalFWL
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CalSDF') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_CalSDF
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_ContriAddEECPF') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_ContriAddEECPF
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_ContriAddERCPF') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_ContriAddERCPF
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_ContriFWL') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_ContriFWL
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_ContriOrdEECPF') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_ContriOrdEECPF
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_ContriOrdERCPF') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_ContriOrdERCPF
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_ContriSDF') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_ContriSDF
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CurAdditionalWage') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_CurAdditionalWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CurOrdinaryWage') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_CurOrdinaryWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_PrevAdditionalWage') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_PrevAdditionalWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_PrevOrdinaryWage') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_PrevOrdinaryWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TotalCDAC') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_TotalCDAC
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TotalComm') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_TotalComm
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TotalEUCF') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_TotalEUCF
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TotalMBMF') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_TotalMBMF
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TotalMOSQ') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_TotalMOSQ
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TotalSINDA') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_TotalSINDA
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TotalYMF') then
   drop  trigger AuditTrailUpdatePeriodPolicySummary_TotalYMF
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePersonalAddress_CustString1') then
   drop  trigger AuditTrailUpdatePersonalAddress_CustString1
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePersonalAddress_CustString2') then
   drop  trigger AuditTrailUpdatePersonalAddress_CustString2
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePersonalAddress_CustString3') then
   drop  trigger AuditTrailUpdatePersonalAddress_CustString3
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePersonalAddress_CustString4') then
   drop  trigger AuditTrailUpdatePersonalAddress_CustString4
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePersonalAddress_CustString5') then
   drop  trigger AuditTrailUpdatePersonalAddress_CustString5
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePersonalAddress_CustString6') then
   drop  trigger AuditTrailUpdatePersonalAddress_CustString6
end if
;
commit work;
