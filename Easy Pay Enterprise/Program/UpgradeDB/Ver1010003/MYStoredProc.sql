if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLMalReOrderSerialNo') then
   drop procedure ASQLMalReOrderSerialNo
end if
;

CREATE PROCEDURE "DBA"."ASQLMalReOrderSerialNo"(
in In_MalTaxYear integer)
begin
  /*
  Clear all Serial No
  */
  declare A_Serial integer;
  declare B_Serial integer; // New Hire
  declare C_Serial integer; // Terminated
  declare SerialNo integer;
  declare sSerialNo char(20);
  set A_Serial=0;
  set B_Serial=0;
  set C_Serial=0;
  /*
  Set all Serial No to contain Letter only
  */
  update MalTaxRecord set MalTaxSerialNo = SubString(MalTaxSerialNo,1,1) where
    FGetMalTaxRecordYear(MalTaxYear) = In_MalTaxYear;
  UpdateSerialNoLoop: for UpdateSerialNoFor as curs dynamic scroll cursor for
    select MalTaxSerialNo as Out_MalTaxSerialNo from MalTaxRecord where FGetMalTaxRecordYear(MalTaxYear) = In_MalTaxYear do
    if(Out_MalTaxSerialNo = 'C') then
      set C_Serial=C_Serial+1;
      set SerialNo=C_Serial
    elseif(Out_MalTaxSerialNo = 'B') then
      set B_Serial=B_Serial+1;
      set SerialNo=B_Serial
    else
      set A_Serial=A_Serial+1;
      set SerialNo=A_Serial
    end if;
    if(SerialNo < 10) then set sSerialNo=String(Out_MalTaxSerialNo,'0000',SerialNo)
    elseif(SerialNo < 100) then set sSerialNo=String(Out_MalTaxSerialNo,'000',SerialNo)
    elseif(SerialNo < 1000) then set sSerialNo=String(Out_MalTaxSerialNo,'00',SerialNo)
    elseif(SerialNo < 10000) then set sSerialNo=String(Out_MalTaxSerialNo,'0',SerialNo)
    else set sSerialNo=String(Out_MalTaxSerialNo,SerialNo)
    end if;
    update MalTaxRecord set
      MalTaxSerialNo = sSerialNo where current of curs end for;
  commit work
end
;

commit work;