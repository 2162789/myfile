
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

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CurAdditionalWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_CurAdditionalWage
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

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_ActualAddERCPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_ActualAddERCPF
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_ActualOrdEECPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_ActualOrdEECPF
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_ActualOrdERCPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_ActualOrdERCPF
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

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_VolAddERCPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_VolAddERCPF
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TotalContriEECPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_TotalContriEECPF 
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TotalContriERCPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_TotalContriERCPF 
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CPFWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_CPFWage
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_SupIR8AAddERCPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_SupIR8AAddERCPF
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_SupIR8AOrdERCPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_SupIR8AOrdERCPF
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_SupIR8AERCPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_SupIR8AERCPF
end if
;


if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_SupIR8AActAddERCPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_SupIR8AActAddERCPF
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_SupIR8AActOrdEECPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_SupIR8AActOrdEECPF
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_SupIR8AActOrdERCPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_SupIR8AActOrdERCPF
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CurrentTaxWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_CurrentTaxWage
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CurrentTaxAmount') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_CurrentTaxAmount
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_PaidCurrentTaxAmt') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_PaidCurrentTaxAmt
end if
;

Commit work;
