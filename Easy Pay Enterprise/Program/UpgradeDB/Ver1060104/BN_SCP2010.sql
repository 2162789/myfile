if not exists(select * from CPFPolicy where CPFPolicyId = 'SCPYr2010Jan') then
	Insert into CPFPolicy Values('SCPYr2010Jan',1,'Employer 3.5% and Employee 3.5%');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'S0110ST') then
	Insert into CPFTableCode Values('S0110ST','Local','SCPScheme','Employer 3.5% and Employee 3.5%',0,0,0);	
	Insert into CPFPolicyMember Values('SCPYr2010Jan','S0110ST');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'S0110PR') then
	Insert into CPFTableCode Values('S0110PR','PR','SCPScheme','Employer 3.5% and Employee 3.5%',0,0,0);	
	Insert into CPFPolicyMember Values('SCPYr2010Jan','S0110PR');
end if;

if not exists(select * from CPFTableCode  where CPFTableCodeId = 'S0110CC') then
	Insert into CPFTableCode Values('S0110CC','CertCitizen','SCPScheme','Employer 3.5% and Employee 3.5%',0,0,0);	
	Insert into CPFPolicyMember Values('SCPYr2010Jan','S0110CC');
end if;

if not exists(select * from Formula where Locate(FormulaId,'S0110') = 1 and FormulaCategory='TAPFormula') then

	Insert into Formula Values('S0110STA0$0ER',1,0,0,'TAPFormula','ER','T2','','','','','');
	Insert into Formula Values('S0110STA0$0EE',1,0,0,'TAPFormula','EE','T2','','','','','');
	Insert into Formula Values('S0110PRA0$0ER',1,0,0,'TAPFormula','ER','T2','','','','','');
	Insert into Formula Values('S0110PRA0$0EE',1,0,0,'TAPFormula','EE','T2','','','','','');
	Insert into Formula Values('S0110CCA0$0ER',1,0,0,'TAPFormula','ER','T2','','','','','');
	Insert into Formula Values('S0110CCA0$0EE',1,0,0,'TAPFormula','EE','T2','','','','','');

	Insert into FormulaRange Values('S0110STA0$0ER',1,0,0,'@LIMIT(@ROUND((C1/100)*K1 ,2),C2,C3);',3.5,17.5,98,0,0,'SCPWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('S0110STA0$0EE',1,0,0,'@LIMIT(@ROUND((C1/100)*K1 ,2),C2,C3);',3.5,17.5,98,0,0,'SCPWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('S0110PRA0$0ER',1,0,0,'@LIMIT(@ROUND((C1/100)*K1 ,2),C2,C3);',3.5,17.5,98,0,0,'SCPWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('S0110PRA0$0EE',1,0,0,'@LIMIT(@ROUND((C1/100)*K1 ,2),C2,C3);',3.5,17.5,98,0,0,'SCPWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('S0110CCA0$0ER',1,0,0,'@LIMIT(@ROUND((C1/100)*K1 ,2),C2,C3);',3.5,17.5,98,0,0,'SCPWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('S0110CCA0$0EE',1,0,0,'@LIMIT(@ROUND((C1/100)*K1 ,2),C2,C3);',3.5,17.5,98,0,0,'SCPWage','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

	Insert Into  CPFTableComponent Values('S0110ST',0,0,'S0110STA0$0EE','S0110STA0$0ER',9999999,99,'','');
	Insert Into  CPFTableComponent Values('S0110PR',0,0,'S0110PRA0$0EE','S0110PRA0$0ER',9999999,99,'','');
	Insert Into  CPFTableComponent Values('S0110CC',0,0,'S0110CCA0$0EE','S0110CCA0$0ER',9999999,99,'','');

end if;

if exists(select 1 from sys.sysprocedure where proc_name = 'PatchInsertSCPProgression') then
   drop procedure PatchInsertSCPProgression
end if
;

create procedure DBA.PatchInsertSCPProgression(in In_EffectiveDate date,in In_SCPProgPolicyId char(20))
begin
  declare Out_ErrorCode integer;

  /*  Get Employee that have payment */
  EmployeeLoop: for EmployeeFor as curs dynamic scroll cursor for
    select Employee.EmployeeSysId as Out_EmployeeSysId,
      FGetCurrentResStatus(FGetPersonalSysIdByEmployeeSysId(Employee.EmployeeSysId)) as ResStatus,
      HireDate as Out_HireDate,
      LastPayDate as Out_LastPayDate from
      Employee join PayEmployee where
      ResStatus in ('Local','PR','CertCitizen') and
      (LastPayDate = '1899-12-30' or LastPayDate >= In_EffectiveDate) do
    /*  Record not inserted yet */
    if not exists(select* from MandatoryContributeProg where MandContriPolicyId=In_SCPProgPolicyId and EmployeeSysID = Out_EmployeeSysId) then

        if (In_EffectiveDate < Out_HireDate) then set In_EffectiveDate = Out_HireDate end if;
        call InsertNewMandatoryContributeProg(
        Out_EmployeeSysId,
        'FirstRecord',
        In_EffectiveDate,
        In_SCPProgPolicyId,
        'SCPScheme','',1,Out_ErrorCode);
      end if
    end for
end;

call PatchInsertSCPProgression('2010-01-01','SCPYr2010Jan');
drop procedure PatchInsertSCPProgression;

commit work;