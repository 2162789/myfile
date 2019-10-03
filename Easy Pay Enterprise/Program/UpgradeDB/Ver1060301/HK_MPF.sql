//-------------------------------------------------------------------------------------------------
//	2012 Jun
//-------------------------------------------------------------------------------------------------

if not exists(select * from CPFPolicy where CPFPolicyId = 'Year2012Jun') then
	Insert into CPFPolicy Values('Year2012Jun',1,'Local Citizen Employer 5%, Employee 5% and Minimum Income 6500 and Maximum 25,000 wef Jun 1, 2012');
	Update SubRegistry Set ShortStringAttr='Year2012Jun' Where RegistryId='PaySetupData' and SubRegistryId='MPFMandatoryPolicyId';
end if;

if not exists(select * from CPFTableCode where CPFTableCodeId = '0612ST') then
	Insert into CPFTableCode (CPFTableCodeId,CPFResidenceTypeId,CPFSchemeId,CPFTableDesc,CPFPeriodCapping,CPFGreaterThanCapping,CPFLessThanCapping) 
	Values('0612ST','Local','MPF','Local Citizen Employer 5%, Employee 5% and Minimum Income 6500 and Maximum 25,000 wef Jun 1, 2012',0,60,30);
	Insert into CPFPolicyMember Values('Year2012Jun','0612ST');
end if;

if not exists(select * from Formula where Locate(FormulaId,'0612ST') = 1 and FormulaCategory='MPFFormula1') then

	Insert into Formula Values('0612STA0$0ER',1,0,0,'MPFFormula1','ER','T1','','','',0,0);
	Insert into Formula Values('0612STA0$0EE',1,0,0,'MPFFormula1','EE','T1','','','',0,0);
	Insert into Formula Values('0612STA0$6500ER',1,0,0,'MPFFormula1','ER','T1','','','',0,0);
	Insert into Formula Values('0612STA0$6500EE',1,0,0,'MPFFormula1','EE','T1','','','',0,0);
	Insert into Formula Values('0612STA0$25000ER',1,0,0,'MPFFormula1','ER','T1','','','',0,0);
	Insert into Formula Values('0612STA0$25000EE',1,0,0,'MPFFormula1','EE','T1','','','',0,0);
	Insert into Formula Values('0612STA18$0ER',1,0,0,'MPFFormula1','ER','T1','','','',0,0);
	Insert into Formula Values('0612STA18$0EE',1,0,0,'MPFFormula1','EE','T1','','','',0,0);
	Insert into Formula Values('0612STA18$6500ER',1,0,0,'MPFFormula1','ER','T2','','','',0,0);
	Insert into Formula Values('0612STA18$6500EE',1,0,0,'MPFFormula1','EE','T2','','','',0,0);
	Insert into Formula Values('0612STA18$25000ER',1,0,0,'MPFFormula1','ER','T2','','','',0,0);
	Insert into Formula Values('0612STA18$25000EE',1,0,0,'MPFFormula1','EE','T2','','','',0,0);
	Insert into Formula Values('0612STA65$0ER',1,0,0,'MPFFormula1','ER','T1','','','',0,0);
	Insert into Formula Values('0612STA65$0EE',1,0,0,'MPFFormula1','EE','T1','','','',0,0);
	Insert into Formula Values('0612STA65$6500ER',1,0,0,'MPFFormula1','ER','T1','','','',0,0);
	Insert into Formula Values('0612STA65$6500EE',1,0,0,'MPFFormula1','EE','T1','','','',0,0);
	Insert into Formula Values('0612STA65$25000ER',1,0,0,'MPFFormula1','ER','T1','','','',0,0);
	Insert into Formula Values('0612STA65$25000EE',1,0,0,'MPFFormula1','EE','T1','','','',0,0);

	Insert into FormulaRange Values('0612STA0$0ER',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0612STA0$0EE',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0612STA0$6500ER',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0612STA0$6500EE',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0612STA0$25000ER',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0612STA0$25000EE',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0612STA18$0ER',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',5,5,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0612STA18$0EE',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0612STA18$6500ER',1,0,0,'@MAX( @RNDPVT( ((C1 / 100) * K1) + ((C2 / 100) * K2),0.5 ), C3 );',5,5,1250,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0612STA18$6500EE',1,0,0,'@MAX( @RNDPVT( ((C1 / 100) * K1) + ((C2 / 100) * K2),0.5 ), C3 );',5,5,1250,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0612STA18$25000ER',1,0,0,'@MAX( @RNDPVT( ((C1 / 100) * K1) + ((C2 / 100) * K2),0.5 ), C3 );',5,5,1250,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0612STA18$25000EE',1,0,0,'@MAX( @RNDPVT( ((C1 / 100) * K1) + ((C2 / 100) * K2),0.5 ), C3 );',5,5,1250,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0612STA65$0ER',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0612STA65$0EE',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0612STA65$6500ER',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0612STA65$6500EE',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0612STA65$25000ER',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');
	Insert into FormulaRange Values('0612STA65$25000EE',1,0,0,'@RNDPVT( ((C1 / 100)* K1) + ((C2 / 100) * K2),0.5 );',0,0,0,0,0,'OrdMPFWage','AddMPFWage','','','','','','','','','RNDPVT','0.5','','','','','','','','','','','','','','','','','','','','','','','');

	Insert Into  CPFTableComponent Values('0612ST',0,0,'0612STA0$0EE','0612STA0$0ER',6500,18,'','');
	Insert Into  CPFTableComponent Values('0612ST',6500,0,'0612STA0$6500EE','0612STA0$6500ER',25000,18,'','');
	Insert Into  CPFTableComponent Values('0612ST',25000,0,'0612STA0$25000EE','0612STA0$25000ER',999999999,18,'','');
	Insert Into  CPFTableComponent Values('0612ST',0,18,'0612STA18$0EE','0612STA18$0ER',6500,65,'','');
	Insert Into  CPFTableComponent Values('0612ST',6500,18,'0612STA18$6500EE','0612STA18$6500ER',25000,65,'','');
	Insert Into  CPFTableComponent Values('0612ST',25000,18,'0612STA18$25000EE','0612STA18$25000ER',999999999,65,'','');
	Insert Into  CPFTableComponent Values('0612ST',0,65,'0612STA65$0EE','0612STA65$0ER',6500,99,'','');
	Insert Into  CPFTableComponent Values('0612ST',6500,65,'0612STA65$6500EE','0612STA65$6500ER',25000,99,'','');
	Insert Into  CPFTableComponent Values('0612ST',25000,65,'0612STA65$25000EE','0612STA65$25000ER',999999999,99,'','');
	
end if;


If exists (select 1 from sys.sysprocedure where proc_name = 'PatchInsertMPFProgression') then
   Drop procedure PatchInsertMPFProgression
end if;


create procedure DBA.PatchInsertMPFProgression(in In_EffectiveDate date,in In_MPFMandatoryPolicyId char(20))
begin

  declare Out_MPFProgEffDate  date;
  declare Out_MPFPaymentDate date;
  declare Out_MPFEEStartDate date;
  declare Out_MPFERVolStartDate date;
  declare Out_MPFCareerId char(20);
  declare Out_MPFMandatoryPolicyId char(20);
  declare Out_MPFVoluntaryPolicyId char(20);
  declare Out_MPFScheme char(20);
  declare Out_MPFMembershipNo char(30);
  declare Out_MPFTrustee char(50);

  /*  Get Employee that have payment */
  EmployeeLoop: for EmployeeFor as curs dynamic scroll cursor for
    select EmployeeSysId as Out_EmployeeSysId,
      LastPayDate as Out_LastPayDate from
      PayEmployee where
      (LastPayDate = '1899-12-30' or LastPayDate >= In_EffectiveDate) do

    /*  Record not inserted yet */
    if not exists(select* from MPFProgression where MPFScheme = 'MPF' And MPFProgEffDate = In_EffectiveDate And EmployeeSysID = Out_EmployeeSysId) then

      /* Get the nearest Progression Record */ 
      set Out_MPFProgEffDate  = null;

      select first MPFProgEffDate, 
	MPFPaymentDate,
	MPFEEStartDate,
	MPFERVolStartDate,
	MPFCareerId,
	MPFMandatoryPolicyId,
	MPFVoluntaryPolicyId,
	MPFScheme,
	MPFMembershipNo,
	MPFTrustee
        into 
	Out_MPFProgEffDate, 
	Out_MPFPaymentDate,
	Out_MPFEEStartDate,
	Out_MPFERVolStartDate,
	Out_MPFCareerId,
	Out_MPFMandatoryPolicyId,
	Out_MPFVoluntaryPolicyId,
	Out_MPFScheme,
	Out_MPFMembershipNo,
	Out_MPFTrustee
        from MPFProgression where
        EmployeeSysID = Out_EmployeeSysId and
        MPFProgEffDate < In_EffectiveDate and
        (MPFMandatoryPolicyId = 'Year2003Feb' or MPFMandatoryPolicyId = 'Year2011Nov') and
        MPFScheme = 'MPF' order by
        MPFProgEffDate desc;

      /* Nearest CPF Progression Record is found */
      if (Out_MPFProgEffDate  is not null) then

	call InsertNewMPFProgression(
		Out_EmployeeSysId,
		In_EffectiveDate,
		Out_MPFPaymentDate,
		Out_MPFEEStartDate,
		Out_MPFERVolStartDate,
		Out_MPFCareerId,
		In_MPFMandatoryPolicyId,
		Out_MPFVoluntaryPolicyId,
		Out_MPFScheme,
		Out_MPFMembershipNo,
		'',
		0,
		Out_MPFTrustee);
      end if

    end if end for

end;

call PatchInsertMPFProgression('2012-06-01','Year2012Jun');
Drop procedure PatchInsertMPFProgression;

Commit work;