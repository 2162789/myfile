-- SubRegisty --
Update SubRegistry Set RegProperty1 = 'ESSSyncOption', RegProperty2 = 'Send Holidays and Leave Pattern'
where RegistryId = 'ESS' and SubRegistryId = 'SendHolidaysLvePat';

commit work;