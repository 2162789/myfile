Update RebateItem 
Set RebateProperty=''
Where RebateId='Educ Med Insurance';

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='MalBIKCar')) then
Insert into SubRegistry Values('MalBIKProperty','MalBIKCar','Car','TP2','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='MalBIKDriver')) then
Insert into SubRegistry Values('MalBIKProperty','MalBIKDriver','Driver','TP2','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='MalBIKUtility')) then
Insert into SubRegistry Values('MalBIKProperty','MalBIKUtility','Utility','TP2','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='MalBIKFurniture')) then
Insert into SubRegistry Values('MalBIKProperty','MalBIKFurniture','Semi-Furnished','TP2','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='MalBIKFullKitchenEq')) then
Insert into SubRegistry Values('MalBIKProperty','MalBIKFullKitchenEq','Fully furnished Kitchen Equipment','TP2','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='MalBIKFittings')) then
Insert into SubRegistry Values('MalBIKProperty','MalBIKFittings','Furniture and Fittings','TP2','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='MalBIKKitchenEquip')) then
Insert into SubRegistry Values('MalBIKProperty','MalBIKKitchenEquip','Kitchen Equipment','TP2','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='MalBIKEntertainment')) then
Insert into SubRegistry Values('MalBIKProperty','MalBIKEntertainment','Entertainment and Recreation','TP2','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='MalBIKGardener')) then
Insert into SubRegistry Values('MalBIKProperty','MalBIKGardener','Gardener','TP2','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='MalBIKServant')) then
Insert into SubRegistry Values('MalBIKProperty','MalBIKServant','Servant','TP2','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='MalBIKClubMembership')) then
Insert into SubRegistry Values('MalBIKProperty','MalBIKClubMembership','Recreational Club Membership','TP2','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='MalBIKOthers')) then
Insert into SubRegistry Values('MalBIKProperty','MalBIKOthers','Others BIK','TP2','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='MalBIKAccom')) then
Insert into SubRegistry Values('MalBIKProperty','MalBIKAccom','Living Accommodation','TP2','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='LvePassageCode')) then
Insert into SubRegistry Values('MalBIKProperty','LvePassageCode','Leave Passage Code','Rebate','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='LvePassageOverCode')) then
Insert into SubRegistry Values('MalBIKProperty','LvePassageOverCode','Leave Passage Overseas Code','Rebate','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='OffPetrolCode')) then
Insert into SubRegistry Values('MalBIKProperty','OffPetrolCode','Official Petrol Code','Rebate','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='NonOffPetrolCode')) then
Insert into SubRegistry Values('MalBIKProperty','NonOffPetrolCode','Non Official Petrol Code','Rebate','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='PerquisitesCode')) then
Insert into SubRegistry Values('MalBIKProperty','PerquisitesCode','Perquisites Code','Rebate','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

if (not Exists(Select SubRegistryId From SubRegistry Where RegistryId = 'MalBIKProperty' And SubRegistryId='ChildCareCode')) then
Insert into SubRegistry Values('MalBIKProperty','ChildCareCode','Child Care Code','Rebate','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00');
end if;

commit work;