if not exists(select * from CPFPolicy where CPFPolicyId = 'SSYr2013Jan') then
	Insert into CPFPolicy Values('SSYr2013Jan',1,'Social Security Fund Employer 5%, Employee 5% wef Jan 1, 2013');
	Update SubRegistry Set ShortStringAttr='SSYr2013Jan' Where RegistryId='PaySetupData' and SubRegistryId='SSPolicy';
end if;

if not exists(select * from CPFTableCode where CPFTableCodeId = '0113SS') then
	Insert into CPFTableCode (CPFTableCodeId,CPFResidenceTypeId,CPFSchemeId,CPFTableDesc,CPFPeriodCapping,CPFGreaterThanCapping,CPFLessThanCapping) 
	Values('0113SS','Local','SS','Social Security Fund Employer 5%, Employee 5% wef Jan 1, 2013',0,1650,15000);
	Insert into CPFPolicyMember Values('SSYr2013Jan','0113SS');
end if;

if not exists(select * from Formula where Locate(FormulaId,'0113SS') = 1 and FormulaCategory='PFFormula1') then

	Insert into Formula Values('0113SSOA0$0ER',1,0,0,'PFFormula1','ER','T2','','','',0,0);
	Insert into Formula Values('0113SSOA0$0EE',1,0,0,'PFFormula1','EE','T2','','','',0,0);
	Insert into Formula Values('0113SSAA0$0ER',1,0,0,'PFFormula1','ER','T3','','','',0,0);
	Insert into Formula Values('0113SSAA0$0EE',1,0,0,'PFFormula1','EE','T3','','','',0,0);

	Insert into FormulaRange Values('0113SSOA0$0ER',1,0,0,'@MAX( @ROUND((C1 / 100) * K1,2), C2 );',5,750,0,0,0,'SSWage','','','','','','','','','','R2D','SSWage','','','' ,'','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0113SSOA0$0EE',1,0,0,'@MAX( @ROUND((C1 / 100) * K1,2), C2 );',5,750,0,0,0,'SSWage','','','','','','','','','','R2D','SSWage','','','' ,'','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0113SSAA0$0ER',1,0,0,'C1;',0,0,0,0,0,'SSWage','','','','','','','','','','R2D','SSWage','','','' ,'','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0113SSAA0$0EE',1,0,0,'C1;',0,0,0,0,0,'SSWage','','','','','','','','','','R2D','SSWage','','','' ,'','','','','','','','','','','','','','','','','','','','');

	Insert Into CPFTableComponent Values('0113SS',0,0,'0113SSOA0$0EE','0113SSOA0$0ER',9999999,99,'0113SSAA0$0EE','0113SSAA0$0ER');

end if;

If exists (select 1 from sys.sysprocedure where proc_name = 'PatchInsertSSSProgression') then
   Drop procedure PatchInsertSSSProgression
end if;


create procedure DBA.PatchInsertSSSProgression(in In_EffectiveDate date,in In_MandContriPolicyId char(20))
begin
  declare Out_MandContriEffDate date;
  declare Out_MandContriCareerId char(20);
  declare Out_MandContriSchemeId char(20); 

  /*  Get Employee that have payment */
  EmployeeLoop: for EmployeeFor as curs dynamic scroll cursor for
    select EmployeeSysId as Out_EmployeeSysId,
      LastPayDate as Out_LastPayDate from
      PayEmployee where
      (LastPayDate = '1899-12-30' or LastPayDate >= In_EffectiveDate) do

    /*  Record not inserted yet */
    if not exists(select* from MandatoryContributeProg where MandContriSchemeId = 'SS' And MandContriEffDate = In_EffectiveDate And EmployeeSysID = Out_EmployeeSysId) then

      /* Get the nearest Progression Record */ 
      set Out_MandContriEffDate = null;

      select first MandContriEffDate, 
        MandContriCareerId,
        MandContriSchemeId 
        into Out_MandContriEffDate,
        Out_MandContriCareerId,
        Out_MandContriSchemeId 
        from MandatoryContributeProg where
        EmployeeSysID = Out_EmployeeSysId and
        MandContriEffDate < In_EffectiveDate and
        MandContriPolicyId <> '' and
        MandContriSchemeId = 'SS' order by
        MandContriEffDate desc;


      /* Nearest CPF Progression Record is found */
      if (Out_MandContriEffDate is not null) then

	call InsertNewMandatoryContributeProg(Out_EmployeeSysId,
	Out_MandContriCareerId,
	In_EffectiveDate,
	In_MandContriPolicyId,
	Out_MandContriSchemeId, 
	'',0);

      end if

    end if end for
end;

call PatchInsertSSSProgression('2013-01-01','SSYr2013Jan');
Drop procedure PatchInsertSSSProgression;

Commit work;