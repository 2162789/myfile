if not exists(select * from ePortalVersion where EPE = '1061200') then
  insert into ePortalVersion(EPE,ePortal) values ('1061200','1030000');
end if;

IF EXISTS(Select CustomAttributeId from CustomAttribute where CustomQueryID='EmploymentEmp' and CustomAttributeId='CessationDate') THEN
   DELETE From CustomAttribute where CustomQueryID='EmploymentEmp' and CustomAttributeId='CessationDate';
END IF;
Insert Into CustomAttribute (QUERYFOLDERID,CUSTOMQUERYID,CUSTOMTABLEID,CUSTOMATTRIBUTEID,PHYSICALNAME,ATTRIBUTEDESC,ATTRIBUTETYPE,ATTRIBUTEFORMULA,GROUPBYPOSITION,SORTBYPOSITION,SORTBYTYPE)
Values ('Employment Letter','EmploymentEmp','EmploymentEmp','CessationDate','CessationDate','Cessation Date','Calculated','case when Length(FGetInvalidDate(CessationDate))>0 then dateformat(FGetInvalidDate(CessationDate),''dd Mmm yyyy'')  end',0,0,0);

update SubRegistry set RegProperty6 = '' where RegistryId = 'System' and SubRegistryId = 'DBVersion';

commit work;