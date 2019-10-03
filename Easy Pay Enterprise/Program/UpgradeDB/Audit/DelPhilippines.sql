
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

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CPFStatus') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_CPFStatus
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CPFClass') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_CPFClass
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CalSDF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_CalSDF
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_ContriSDF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_ContriSDF
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_PrevOrdinaryWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_PrevOrdinaryWage
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_SDFWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_SDFWage
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_MAWContriOption') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_MAWContriOption
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

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TaxMaritalStatus') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_TaxMaritalStatus
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

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TaxBenefit') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_TaxBenefit
end if
;

Commit work;