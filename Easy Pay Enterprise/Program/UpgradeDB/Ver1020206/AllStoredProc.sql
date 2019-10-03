if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteCustomizedBankInfo') then
   drop procedure DeleteCustomizedBankInfo
end if
;

CREATE PROCEDURE "DBA"."DeleteCustomizedBankInfo"(
in In_TTEntryGenSysID char(30),
out Out_ErrorCode integer)
begin
end
;


if exists(select 1 from sys.sysprocedure where proc_name = 'DeletePaymentBankInfo') then
   drop procedure DeletePaymentBankInfo
end if
;

CREATE PROCEDURE "DBA"."DeletePaymentBankInfo"(
in In_PayBankSGSPGenId char(30))
begin
  if exists(select* from PaymentBankInfo where
      PaymentBankInfo.PayBankSGSPGenId = In_PayBankSGSPGenId) then
    call DeleteCustomizedBankInfo(In_PayBankSGSPGenId);
    delete from PaymentBankInfo where
      PaymentBankInfo.PayBankSGSPGenId = In_PayBankSGSPGenId;
    commit work
  end if
end
;

commit work;