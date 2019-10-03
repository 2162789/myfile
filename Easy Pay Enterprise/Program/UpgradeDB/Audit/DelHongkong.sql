
Read upgradeDB\Audit\DelBasic.sql;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailDeletePeriodPolicySummary') then
	drop  trigger AuditTrailDeletePeriodPolicySummary
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailInsertPeriodPolicySummary') then
	drop  trigger AuditTrailInsertPeriodPolicySummary
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CurOrdinaryWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_CurOrdinaryWage
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_PrevOrdinaryWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_PrevOrdinaryWage
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CuradditionalWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_CuradditionalWage
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_PrevadditionalWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_PrevadditionalWage
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_ContriOrdERCPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_ContriOrdERCPF
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_VolOrdEECPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_VolOrdEECPF
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_VolOrdERCPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_VolOrdERCPF
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

Commit work;
