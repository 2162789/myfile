IF EXISTS(SELECT viewname FROM SysViews WHERE viewname='View_Alc_PayPeriodSummContriTax') THEN
    DROP VIEW "DBA"."View_Alc_PayPeriodSummContriTax";
END IF;

CREATE VIEW "DBA"."View_Alc_PayPeriodSummContriTax" AS 
 SELECT FGetEmployeeId(PayPeriodRecord.EmployeeSysId) AS EmployeeId, FGetEmployeeName(PayPeriodRecord.EmployeeSysId) AS EmployeeName, PayPeriodRecord.PayRecYear, PayPeriodRecord.PayRecPeriod
, PeriodPolicySummary.ContriAddEECPF AS ContriAddEECPF
, PeriodPolicySummary.ContriAddERCPF AS ContriAddERCPF
, PeriodPolicySummary.ContriFWL AS ContriFWL
, PeriodPolicySummary.ContriOrdEECPF AS ContriOrdEECPF
, PeriodPolicySummary.ContriOrdERCPF AS ContriOrdERCPF
, PeriodPolicySummary.ContriSDF AS ContriSDF
, PeriodPolicySummary.CPFClass AS CPFClass
, PeriodPolicySummary.CPFStatus AS CPFStatus
, PeriodPolicySummary.CPFWage AS CPFWage
, PeriodPolicySummary.CurAdditionalWage AS CurAdditionalWage
, PeriodPolicySummary.CurOrdinaryWage AS CurOrdinaryWage
, PeriodPolicySummary.MAWContriCurAddWage AS MAWContriCurAddWage
, PeriodPolicySummary.MAWContriLimit AS MAWContriLimit
, PeriodPolicySummary.MAWContriOption AS MAWContriOption
, PeriodPolicySummary.MAWContriPrevAddWage AS MAWContriPrevAddWage
, PeriodPolicySummary.OverseasEECPF AS OverseasEECPF
, PeriodPolicySummary.OverseasERCPF AS OverseasERCPF
, PeriodPolicySummary.PrevAdditionalWage AS PrevAdditionalWage
, PeriodPolicySummary.PrevOrdinaryWage AS PrevOrdinaryWage
, PeriodPolicySummary.SDFWage AS SDFWage
, PeriodPolicySummary.TotalCDAC AS TotalCDAC
, PeriodPolicySummary.TotalComm AS TotalComm
, PeriodPolicySummary.TotalContriEECPF AS TotalContriEECPF
, PeriodPolicySummary.TotalContriERCPF AS TotalContriERCPF
, PeriodPolicySummary.TotalEUCF AS TotalEUCF
, PeriodPolicySummary.TotalMOSQ AS TotalMOSQ
, PeriodPolicySummary.TotalSINDA AS TotalSINDA
, PeriodPolicySummary.TotalYMF AS TotalYMF
, PeriodPolicySummary.VolAddEECPF AS VolAddEECPF
, PeriodPolicySummary.VolAddERCPF AS VolAddERCPF
, PeriodPolicySummary.VolOrdEECPF AS VolOrdEECPF
, PeriodPolicySummary.VolOrdERCPF AS VolOrdERCPF
 FROM PayPeriodRecord
 LEFT OUTER JOIN PeriodPolicySummary