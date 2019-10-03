
Read upgradeDB\Audit\DelBasic.sql;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailDeletePeriodPolicySummary') then
	drop  trigger AuditTrailDeletePeriodPolicySummary
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailInsertPeriodPolicySummary') then
	drop  trigger AuditTrailInsertPeriodPolicySummary
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_ContriSDF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_ContriSDF
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_ContriAddEECPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_ContriAddEECPF
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
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_ContriAddERCPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_ContriAddERCPF
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CPFWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_CPFWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_SDFWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_SDFWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CPFStatus') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_CPFStatus
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CPFClass') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_CPFClass
end if
;
commit work;
