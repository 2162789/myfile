
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
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_ContriOrdEECPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_ContriOrdEECPF
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_ContriOrdERCPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_ContriOrdERCPF
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_ActualAddEECPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_ActualAddEECPF
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
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_VolAddEECPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_VolAddEECPF
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_VolAddERCPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_VolAddERCPF
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TotalCDAC') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_TotalCDAC
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TotalSINDA') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_TotalSINDA
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TotalEUCF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_TotalEUCF
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
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_SupIR8ACurOrdWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_SupIR8ACurOrdWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_SupIR8ACurAddWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_SupIR8ACurAddWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_SupIR8APrevOrdWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_SupIR8APrevOrdWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_SupIR8APrevAddWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_SupIR8APrevAddWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_SupIR8AActAddEECPF') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_SupIR8AActAddEECPF
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
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TaxCategory') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_TaxCategory
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TaxMaritalStatus') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_TaxMaritalStatus
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TaxChildRelief') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_TaxChildRelief
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CurrentTaxWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_CurrentTaxWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_PreviousTaxWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_PreviousTaxWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CurrentAddTaxWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_CurrentAddTaxWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_PreviousAddTaxWage') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_PreviousAddTaxWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_CurrentTaxAmount') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_CurrentTaxAmount
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_PreviousTaxAmount') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_PreviousTaxAmount
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TaxEPFRelief') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_TaxEPFRelief
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TaxZakatRelief') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_TaxZakatRelief
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_PaidCurrentTaxAmt') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_PaidCurrentTaxAmt
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_PaidPreviousTaxAmt') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_PaidPreviousTaxAmt
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePeriodPolicySummary_TaxBenefit') then
	drop  trigger AuditTrailUpdatePeriodPolicySummary_TaxBenefit
end if
;
commit work;
