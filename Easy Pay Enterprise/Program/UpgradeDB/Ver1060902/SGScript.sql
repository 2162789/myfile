READ UpgradeDB\Ver1060902\SGStoredProc.sql;
READ UpgradeDB\Ver1060902\CPF_2015Jan.sql;

/* Update labour Market Survey */
update LabSurveySetup set QueryCondition = '(cessationdate >= [QStartDate] and cessationdate<= [QEndDate]) and employee.employeesysid in (select first employeesysid from employee as em where em.PersonalSysId = employee.personalSysId and hiredate <= [QEndDate]  order by em.hiredate desc)'
where LabSurveySetupId <= 100 and LabSurveySetupId >= 21;

update LabSurveySetup 
set QueryCondition = '(cessationdate = ''1899-12-30'' or cessationdate > [QEndDate]) and (hiredate <= [QEndDate])'
where LabSurveySetupId >= 101 and LabSurveySetupId <= 114;

/* Bank Disk */
if not exists(select * from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'ANZ Transactive Cash Asia') then
   insert into BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,IsCustomised )
   values('Salary','ANZ Transactive Cash Asia','RSingBankFormatANZTransactiveCashAsia.dll','InvokeSalaryFormatter',0);
end if;

if not exists(select * from BankSubmitFormat where BankSubmitSubmitForId = 'Salary' and FormatName = 'Mitsubishi (G3 Bulk Payment)') then
   insert into BankSubmitFormat(BankSubmitSubmitForId,FormatName,DllName,FormatterInvoke,IsCustomised )
   values('Salary','Mitsubishi (G3 Bulk Payment)','RSingBankFormatMitsubishiG3BulkPayment.dll','InvokeSalaryFormatter',0);
end if;

/* Update Medisave Additional Amount to 0 instead of NAN*/
PolicyRecLoop: FOR PolicyRec AS DYNAMIC SCROLL CURSOR FOR    
   SELECT PolicyRecSGSPGenId AS OUT_PolicyRecSGSPGenId FROM PolicyRecord 
   WHERE cast(PreviousTaxAmount as char(10)) like '-21474836%'
   ORDER BY PolicyRecSGSPGenId
   DO 
      UPDATE PolicyRecord
	  SET PreviousTaxAmount = 0
	  WHERE PolicyRecSGSPGenId = OUT_PolicyRecSGSPGenId; 
   END FOR;

commit work;