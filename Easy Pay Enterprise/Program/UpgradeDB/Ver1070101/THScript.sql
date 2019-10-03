/* Thailand New tax rate with effective from 1st Jan 2017 */
begin

Declare Temp_PolidyId char(20);
Declare Temp_TaxProgressionId integer;
Declare Temp_EffectiveDate Date;
set Temp_PolidyId = 'Default';
set Temp_EffectiveDate = '2017-01-01';

if not exists(select * from ThTaxPolicy where ThTaxPolicyId = Temp_PolidyId) then
   insert into ThTaxPolicy(ThTaxPolicyId,ThTaxPolicyDesc)
   values(Temp_PolidyId,'');
end if;

if not exists(select * from ThTaxProgression where ThTaxPolicyId = Temp_PolidyId and ThTaxProgDate = Temp_EffectiveDate) then
   insert into ThTaxProgression(ThTaxPolicyId,ThTaxProgDate,ThExpensePercent,ThExpenseMax,ThPFMax,ThPFPercent,ThOldAgeAmt,ThOldAgeMinAge,
                                ThTaxpayerAmt,ThSpouseAmt,ThMaxNoOfChild,ThChildAgeLimit,ThChildNoStudyAmt,ThChildStudyAmt,ThParentAmt, 
                                ThParentMinAge,ThInsuranceMax,ThPFExcess,ThResidenceMax,ThCharityMaxPercent)
   values(Temp_PolidyId,Temp_EffectiveDate,50,100000,500000,15,190000,65,60000,60000,0,0,30000,30000,30000,60,100000,0,100000,10);                                                     
end if;

select ThTaxProgSysId into Temp_TaxProgressionId from ThTaxProgression where ThTaxPolicyId = Temp_PolidyId and ThTaxProgDate = Temp_EffectiveDate;
if not exists(select * from ThTaxRate where ThTaxProgSysId = Temp_TaxProgressionId and ThTaxTaxableOver =150000) then
   insert into ThTaxRate(ThTaxProgSysId,ThTaxTaxableOver,ThTaxBaseAmt,ThTaxExcessPercent)
   values(Temp_TaxProgressionId,150000,0,5);
end if;

if not exists(select * from ThTaxRate where ThTaxProgSysId = Temp_TaxProgressionId and ThTaxTaxableOver =300000) then
   insert into ThTaxRate(ThTaxProgSysId,ThTaxTaxableOver,ThTaxBaseAmt,ThTaxExcessPercent)
   values(Temp_TaxProgressionId,300000,7500,10);
end if;

if not exists(select * from ThTaxRate where ThTaxProgSysId = Temp_TaxProgressionId and ThTaxTaxableOver =500000) then
   insert into ThTaxRate(ThTaxProgSysId,ThTaxTaxableOver,ThTaxBaseAmt,ThTaxExcessPercent)
   values(Temp_TaxProgressionId,500000,27500,15);
end if;

if not exists(select * from ThTaxRate where ThTaxProgSysId = Temp_TaxProgressionId and ThTaxTaxableOver =750000) then
   insert into ThTaxRate(ThTaxProgSysId,ThTaxTaxableOver,ThTaxBaseAmt,ThTaxExcessPercent)
   values(Temp_TaxProgressionId,750000,65000,20);
end if;

if not exists(select * from ThTaxRate where ThTaxProgSysId = Temp_TaxProgressionId and ThTaxTaxableOver =1000000) then
   insert into ThTaxRate(ThTaxProgSysId,ThTaxTaxableOver,ThTaxBaseAmt,ThTaxExcessPercent)
   values(Temp_TaxProgressionId,1000000,115000,25);
end if;

if not exists(select * from ThTaxRate where ThTaxProgSysId = Temp_TaxProgressionId and ThTaxTaxableOver =2000000) then
   insert into ThTaxRate(ThTaxProgSysId,ThTaxTaxableOver,ThTaxBaseAmt,ThTaxExcessPercent)
   values(Temp_TaxProgressionId,2000000,365000,30);
end if;

if not exists(select * from ThTaxRate where ThTaxProgSysId = Temp_TaxProgressionId and ThTaxTaxableOver =5000000) then
   insert into ThTaxRate(ThTaxProgSysId,ThTaxTaxableOver,ThTaxBaseAmt,ThTaxExcessPercent)
   values(Temp_TaxProgressionId,5000000,1265000,35);
end if;

end;

commit work;