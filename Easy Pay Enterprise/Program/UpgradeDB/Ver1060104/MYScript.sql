Update (select * from Personal join MalTaxDetails on Personal.PersonalSysId  = MalTaxDetails.PersonalSysId
where MaritalStatusCode in ('Divorced','Widow','Widower','Separated') And MalTaxSpouseWorking = 0) as Temp
Set MalTaxSpouseWorking  =1;

commit work;