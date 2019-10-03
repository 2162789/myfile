if exists(select 1 from sys.systrigger 
where trigger_name = 
'AuditTrailDeleteEmployee') then
   drop  trigger 
AuditTrailDeleteEmployee
end if
;
if exists(select 1 from sys.systrigger 
where trigger_name = 
'AuditTrailInsertEmployee') then
   drop  trigger 
AuditTrailInsertEmployee
end if
;
if exists(select 1 from sys.systrigger 
where trigger_name ='AuditTrailUpdateEmployee_CessationDate')  
then
   drop  trigger  AuditTrailUpdateEmployee_CessationDate
end if
;
if exists(select 1 from sys.systrigger 
where trigger_name = 
'AuditTrailUpdateEmployee_HireDate'
) then
   drop  trigger 
AuditTrailUpdateEmployee_HireDate
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailDeletePayEmployee') then
   drop  trigger AuditTrailDeletePayEmployee
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailInsertPayEmployee') then
   drop  trigger AuditTrailInsertPayEmployee
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePayEmployee_BonusFactor') then
   drop  trigger AuditTrailUpdatePayEmployee_BonusFactor
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePayEmployee_CurrentBasicRate') then
   drop  trigger AuditTrailUpdatePayEmployee_CurrentBasicRate
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePayEmployee_CurrentBasicRateType') then
   drop  trigger AuditTrailUpdatePayEmployee_CurrentBasicRateType
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePayEmployee_LastPayDate') then
   drop  trigger AuditTrailUpdatePayEmployee_LastPayDate
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePayEmployee_PreviousBasicRate') then
   drop  trigger AuditTrailUpdatePayEmployee_PreviousBasicRate
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePayEmployee_PreviousBasicRateType') then
   drop  trigger AuditTrailUpdatePayEmployee_PreviousBasicRateType
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailDeletePaymentBankInfo') then
   drop  trigger AuditTrailDeletePaymentBankInfo
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailInsertPaymentBankInfo') then
   drop  trigger AuditTrailInsertPaymentBankInfo
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePaymentBankInfo_BankAccountNo') then
   drop  trigger AuditTrailUpdatePaymentBankInfo_BankAccountNo
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePaymentBankInfo_BankBranchId') then
   drop  trigger AuditTrailUpdatePaymentBankInfo_BankBranchId
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePaymentBankInfo_BankId') then
   drop  trigger AuditTrailUpdatePaymentBankInfo_BankId
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePaymentBankInfo_PaymentType') then
   drop  trigger AuditTrailUpdatePaymentBankInfo_PaymentType
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePaymentBankInfo_PaymentValue') then
   drop  trigger AuditTrailUpdatePaymentBankInfo_PaymentValue
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePaymentBankInfo_BeneficiaryName') then
   drop  trigger AuditTrailUpdatePaymentBankInfo_BeneficiaryName
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailDeleteBasicRateProgression') then
	drop  trigger AuditTrailDeleteBasicRateProgression
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailInsertBasicRateProgression') then
	drop  trigger AuditTrailInsertBasicRateProgression
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBasicRateProgression_BRProgressionCode') then
	drop  trigger AuditTrailUpdateBasicRateProgression_BRProgressionCode
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBasicRateProgression_BRProgEffectiveDate') then
	drop  trigger AuditTrailUpdateBasicRateProgression_BRProgEffectiveDate
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBasicRateProgression_BRProgNextIncDate') then
	drop  trigger AuditTrailUpdateBasicRateProgression_BRProgNextIncDate
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBasicRateProgression_BRProgCareerId') then
	drop  trigger AuditTrailUpdateBasicRateProgression_BRProgCareerId
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBasicRateProgression_BRProgPrevBasicRate') then
	drop  trigger AuditTrailUpdateBasicRateProgression_BRProgPrevBasicRate
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBasicRateProgression_BRProgIncrementAmt') then
	drop  trigger AuditTrailUpdateBasicRateProgression_BRProgIncrementAmt
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBasicRateProgression_BRProgPercentage') then
	drop  trigger AuditTrailUpdateBasicRateProgression_BRProgPercentage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBasicRateProgression_BRProgNewBasicRate') then
	drop  trigger AuditTrailUpdateBasicRateProgression_BRProgNewBasicRate
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBasicRateProgression_BRProgBasicRateType') then
	drop  trigger AuditTrailUpdateBasicRateProgression_BRProgBasicRateType
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBasicRateProgression_BRProgPayGroup') then
	drop  trigger AuditTrailUpdateBasicRateProgression_BRProgPayGroup
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBasicRateProgression_BRProgCurrent') then
   drop  trigger AuditTrailUpdateBasicRateProgression_BRProgCurrent
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailDeleteDetailRecord') then
   drop  trigger AuditTrailDeleteDetailRecord
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailInsertDetailRecord') then
   drop  trigger AuditTrailInsertDetailRecord
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateDetailRecord_CurrentBasicRate') then
   drop  trigger AuditTrailUpdateDetailRecord_CurrentBasicRate
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateDetailRecord_AllocatedBasicRate') then
   drop  trigger AuditTrailUpdateDetailRecord_AllocatedBasicRate
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateDetailRecord_PreviousHrDays') then
   drop  trigger AuditTrailUpdateDetailRecord_PreviousHrDays
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateDetailRecord_CurrentHrDays') then
   drop  trigger AuditTrailUpdateDetailRecord_CurrentHrDays
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateDetailRecord_CalTotalWage') then
   drop  trigger AuditTrailUpdateDetailRecord_CalTotalWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateDetailRecord_CalTotalGrossWage') then
   drop  trigger AuditTrailUpdateDetailRecord_CalTotalGrossWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateDetailRecord_CalOTAmount') then
   drop  trigger AuditTrailUpdateDetailRecord_CalOTAmount
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateDetailRecord_CalOTBackPay') then
   drop  trigger AuditTrailUpdateDetailRecord_CalOTBackPay
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateDetailRecord_CalShiftAmount') then
   drop  trigger AuditTrailUpdateDetailRecord_CalShiftAmount
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateDetailRecord_CalLveDeductAmt') then
   drop  trigger AuditTrailUpdateDetailRecord_CalLveDeductAmt
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateDetailRecord_CalBackPay') then
   drop  trigger AuditTrailUpdateDetailRecord_CalBackPay
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateDetailRecord_CalGrossWage') then
   drop  trigger AuditTrailUpdateDetailRecord_CalGrossWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateDetailRecord_CalNetWage') then
   drop  trigger AuditTrailUpdateDetailRecord_CalNetWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailDeleteAllowanceRecord') then
   drop  trigger AuditTrailDeleteAllowanceRecord
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailInsertAllowanceRecord') then
   drop  trigger AuditTrailInsertAllowanceRecord
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateAllowanceRecord_AllowanceAmount') then
   drop  trigger AuditTrailUpdateAllowanceRecord_AllowanceAmount
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateAllowanceRecord_AllowanceDeclaredDate') then
   drop  trigger AuditTrailUpdateAllowanceRecord_AllowanceDeclaredDate
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailInsertResidenceStatusRecord') then
   drop  trigger AuditTrailInsertResidenceStatusRecord
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateResidenceStatusRecord_ResidenceTypeId') then
   drop  trigger AuditTrailUpdateResidenceStatusRecord_ResidenceTypeId
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateResidenceStatusRecord_ResStatusCareerId') then
   drop  trigger AuditTrailUpdateResidenceStatusRecord_ResStatusCareerId
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateResidenceStatusRecord_ResStatusCurrent') then
   drop  trigger AuditTrailUpdateResidenceStatusRecord_ResStatusCurrent
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailDeleteResidenceStatusRecord') then
   drop  trigger AuditTrailDeleteResidenceStatusRecord
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailInsertSystemUser') then
   drop  trigger AuditTrailInsertSystemUser
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateSystemUser_UserGroupId') then
   drop  trigger AuditTrailUpdateSystemUser_UserGroupId
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateSystemUser_UserPassword') then
   drop  trigger AuditTrailUpdateSystemUser_UserPassword
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateSystemUser_ExpiryDate') then
   drop  trigger AuditTrailUpdateSystemUser_ExpiryDate
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateSystemUser_SysPersonalSysId') then
   drop  trigger AuditTrailUpdateSystemUser_SysPersonalSysId
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailDeleteSystemUser') then
   drop  trigger AuditTrailDeleteSystemUser
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailInsertUserGroup') then
   drop  trigger AuditTrailInsertUserGroup
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateUserGroup_UserGroupDesc') then
   drop  trigger AuditTrailUpdateUserGroup_UserGroupDesc
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateUserGroup_UserGroupHideWage') then
   drop  trigger AuditTrailUpdateUserGroup_UserGroupHideWage
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailDeleteUserGroup') then
   drop  trigger AuditTrailDeleteUserGroup
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailInsertUserModuleNoAccess') then
   drop  trigger AuditTrailInsertUserModuleNoAccess
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailDeleteUserModuleNoAccess') then
   drop  trigger AuditTrailDeleteUserModuleNoAccess
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailDeleteBankRecord') then
   drop  trigger AuditTrailDeleteBankRecord
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailInsertBankRecord') then
   drop  trigger AuditTrailInsertBankRecord
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBankRecord_PaymentBankBrCode') then
   drop  trigger AuditTrailUpdateBankRecord_PaymentBankBrCode
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBankRecord_PaymentBankCode') then
   drop  trigger AuditTrailUpdateBankRecord_PaymentBankCode
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBankRecord_PaymentAmt') then
   drop  trigger AuditTrailUpdateBankRecord_PaymentAmt
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBankRecord_PaymentCategory') then
   drop  trigger AuditTrailUpdateBankRecord_PaymentCategory
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBankRecord_PaymentValue') then
   drop  trigger AuditTrailUpdateBankRecord_PaymentValue
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBankRecord_PaymentType') then
   drop  trigger AuditTrailUpdateBankRecord_PaymentType
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBankRecord_PaymentBankAccNo') then
   drop  trigger AuditTrailUpdateBankRecord_PaymentBankAccNo
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBankRecord_PaymentBankAccType') then
   drop  trigger AuditTrailUpdateBankRecord_PaymentBankAccType
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBankRecord_PaymentMode') then
   drop  trigger AuditTrailUpdateBankRecord_PaymentMode
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdateBankRecord_BeneficiaryName') then
   drop  trigger AuditTrailUpdateBankRecord_BeneficiaryName
end if
;

if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailDeletePersonalAddress') then
   drop  trigger AuditTrailDeletePersonalAddress
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailInsertPersonalAddress') then
   drop  trigger AuditTrailInsertPersonalAddress
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePersonalAddress_PersonalAddAddress') then
   drop  trigger AuditTrailUpdatePersonalAddress_PersonalAddAddress
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePersonalAddress_PersonalAddAddress2') then
   drop  trigger AuditTrailUpdatePersonalAddress_PersonalAddAddress2
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePersonalAddress_PersonalAddAddress3') then
   drop  trigger AuditTrailUpdatePersonalAddress_PersonalAddAddress3
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePersonalAddress_PersonalAddCity') then
   drop  trigger AuditTrailUpdatePersonalAddress_PersonalAddCity
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePersonalAddress_PersonalAddCountry') then
   drop  trigger AuditTrailUpdatePersonalAddress_PersonalAddCountry
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePersonalAddress_PersonalAddMailing') then
   drop  trigger AuditTrailUpdatePersonalAddress_PersonalAddMailing
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePersonalAddress_PersonalAddPCode') then
   drop  trigger AuditTrailUpdatePersonalAddress_PersonalAddPCode
end if
;
if exists(select 1 from sys.systrigger where trigger_name = 'AuditTrailUpdatePersonalAddress_PersonalAddState') then
   drop  trigger AuditTrailUpdatePersonalAddress_PersonalAddState
end if
;



commit work;
