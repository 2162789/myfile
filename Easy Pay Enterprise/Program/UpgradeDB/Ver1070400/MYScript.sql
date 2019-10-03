if exists (select 1 from CPFTableComponent where CPFTableCodeId = 'EP18EX' and MinSalary = 0 and MinCPFAge = 0
	and EEOrdCPFFormula = 'EP18EXA0$0EEM' and EROrdCPFFormula = 'EP18EXA0$0ERM' and MaxSalary = 9999999 and MaxCPFAge = 75
	and EEAddCPFFormula = 'EP18EXA0$0EEV' and ERAddCPFFormula = 'EP18EXA0$0ERV')
	and (select count(1) from CPFTableComponent where CPFTableCodeId = 'EP18EX') = 1
	and (select count(1) from Formula where FormulaId like 'EP18EX%') = 4
	and exists (select 1 from Formula where FormulaId = 'EP18EXA0$0ERM' and FormulaType = 'T4')
	and exists (select 1 from Formula where FormulaId = 'EP18EXA0$0EEM' and FormulaType not in ('T4', 'Adv'))
	and exists (select 1 from Formula where FormulaId = 'EP18EXA0$0ERV' and FormulaType not in ('T4', 'Adv'))
	and exists (select 1 from Formula where FormulaId = 'EP18EXA0$0EEV' and FormulaType not in ('T4', 'Adv')) then

	// Insert Formula ER Mandatory (all use Template 4)
	insert into Formula values('EP18EXA0$10ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
	insert into Formula values('EP18EXA60$0ERM',1,0,0,'EPFFormula','ER','T4','','','','','');
	insert into Formula values('EP18EXA60$10ERM',1,0,0,'EPFFormula','ER','T4','','','','','');

	// Insert Formula EE Mandatory (salary 0 to 10 uses Template 4, salary 10 to 9999999 copies from existing EE Mandatory)
	insert into Formula
	select 'EP18EXA0$10EEM',FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank
	from Formula where FormulaId = 'EP18EXA0$0EEM';
	insert into Formula values('EP18EXA60$0EEM',1,0,0,'EPFFormula','EE','T4','','','','','');
	insert into Formula
	select 'EP18EXA60$10EEM',FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank
	from Formula where FormulaId = 'EP18EXA0$0EEM';
	update Formula set FormulaType = 'T4' where FormulaId = 'EP18EXA0$0EEM';

	// Insert Formula ER Voluntary (copy from existing ER Voluntary formula)
	insert into Formula
	select 'EP18EXA0$10ERV',FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank
	from Formula where FormulaId = 'EP18EXA0$0ERV';
	insert into Formula
	select 'EP18EXA60$0ERV',FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank
	from Formula where FormulaId = 'EP18EXA0$0ERV';
	insert into Formula
	select 'EP18EXA60$10ERV',FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank
	from Formula where FormulaId = 'EP18EXA0$0ERV';

	// Insert Formula EE Voluntary (copy from existing EE Voluntary formula)
	insert into Formula select 'EP18EXA0$10EEV',FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank
	from Formula where FormulaId = 'EP18EXA0$0EEV';
	insert into Formula select 'EP18EXA60$0EEV',FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank
	from Formula where FormulaId = 'EP18EXA0$0EEV';
	insert into Formula select 'EP18EXA60$10EEV',FormulaActive,FormulaPreprocess,FormulaRecurring,FormulaCategory,FormulaSubCategory,FormulaType,FormulaRangeBasis,FormulaDesc,FormulaExRateId,FormulaStage,FormulaRank
	from Formula where FormulaId = 'EP18EXA0$0EEV';

	// Insert FormulaRange ER Mandatory (copy from existing ER Mandatory formula)
	insert into FormulaRange
	select 'EP18EXA0$10ERM',FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10
	from FormulaRange where FormulaId = 'EP18EXA0$0ERM';
	insert into FormulaRange
	select 'EP18EXA60$0ERM',FormulaRangeId,Maximum,Minimum,Formula,0,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10
	from FormulaRange where FormulaId = 'EP18EXA0$0ERM';
	insert into FormulaRange
	select 'EP18EXA60$10ERM',FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10
	from FormulaRange where FormulaId = 'EP18EXA0$0ERM';
	update FormulaRange set Constant1 = 0 where FormulaId = 'EP18EXA0$0ERM';

	// Insert FormulaRange EE Mandatory (salary 0 to 10 uses 0 contribution, salary 10 to 9999999 copy from existing EE Mandatory, where age 60 to 75 uses 5.5%)
	insert into FormulaRange
	select 'EP18EXA0$10EEM',FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10
	from FormulaRange where FormulaId = 'EP18EXA0$0EEM';
	insert into FormulaRange
	select 'EP18EXA60$0EEM',FormulaRangeId,Maximum,Minimum,Formula,0,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10
	from FormulaRange where FormulaId = 'EP18EXA0$0EEM';
	insert into FormulaRange
	select 'EP18EXA60$10EEM',FormulaRangeId,Maximum,Minimum,Formula,5.5,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10
	from FormulaRange where FormulaId = 'EP18EXA0$0EEM';
	update FormulaRange set Formula = 'C1;', Constant1 = 0 where FormulaId = 'EP18EXA0$0EEM';

	// Insert FormulaRange EE Voluntary (copy from existing EE Voluntary formula)
	insert into FormulaRange
	select 'EP18EXA0$10ERV',FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10
	from FormulaRange where FormulaId = 'EP18EXA0$0ERV';
	insert into FormulaRange
	select 'EP18EXA60$0ERV',FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10
	from FormulaRange where FormulaId = 'EP18EXA0$0ERV';
	insert into FormulaRange
	select 'EP18EXA60$10ERV',FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10
	from FormulaRange where FormulaId = 'EP18EXA0$0ERV';

	// Insert FormulaRange EE Voluntary (copy from existing ER Mandatory formula)
	insert into FormulaRange
	select 'EP18EXA0$10EEV',FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10
	from FormulaRange where FormulaId = 'EP18EXA0$0EEV';
	insert into FormulaRange
	select 'EP18EXA60$0EEV',FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10
	from FormulaRange where FormulaId = 'EP18EXA0$0EEV';
	insert into FormulaRange
	select 'EP18EXA60$10EEV',FormulaRangeId,Maximum,Minimum,Formula,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10
	from FormulaRange where FormulaId = 'EP18EXA0$0EEV';

	// Insert EPF Table Component
	insert into CPFTableComponent values('EP18EX',10,0,'EP18EXA0$10EEM','EP18EXA0$10ERM',9999999,60,'EP18EXA0$10EEV','EP18EXA0$10ERV');
	insert into CPFTableComponent values('EP18EX',0,60,'EP18EXA60$0EEM','EP18EXA60$0ERM',10,75,'EP18EXA60$0EEV','EP18EXA60$0ERV');
	insert into CPFTableComponent values('EP18EX',10,60,'EP18EXA60$10EEM','EP18EXA60$10ERM',9999999,75,'EP18EXA60$10EEV','EP18EXA60$10ERV');
	update CPFTableComponent set MaxSalary = 10, MaxCPFAge = 60 where CPFTableCodeId = 'EP18EX' and MinSalary = 0 and MinCPFAge = 0;

end if;
commit work;