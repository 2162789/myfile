if exists(select * from sys.syscolumns where tname='CompanyBank' and cname='ComAccountNo') then
    alter table DBA.CompanyBank DELETE PRIMARY KEY;
    alter table DBA.CompanyBank Alter ComAccountNo char(50); 
    alter table DBA.CompanyBank ADD PRIMARY KEY (ComBankCode,ComBankBranchCode,ComAccountNo);   
end if;

if exists(select * from sys.sysprocedure where proc_name = 'GrantTMSViewPermission') then
    drop procedure GrantTMSViewPermission
end if;

CREATE PROCEDURE DBA.GrantTMSViewPermission(In In_UserID char(50))
BEGIN

Declare In_Count int;
Declare TMSLic bit;
Declare SageProdIntegLic bit;

IF EXISTS(select * from licenserecord where functionlist like '%Sage Product Integration%') THEN
set SageProdIntegLic=1;
ELSE
 IF  EXISTS(select * from ProductFeatures WHERE  Function LIKE '%Sage Product Integration%' AND PublishDate <= DATE(NOW()) AND ExpiryDate >=  DATE(NOW()) ) THEN 
  set SageProdIntegLic=1;
 END IF;
END IF;

IF EXISTS(select * from licenserecord where functionlist like '%TMS Vendor%') THEN
set TMSLic=1;
ELSE
 IF  EXISTS(select * from ProductFeatures WHERE  Function LIKE '%TMS Vendor%' AND PublishDate <= DATE(NOW()) AND ExpiryDate >=  DATE(NOW()) ) THEN 
  set TMSLic=1;
 END IF;
END IF;

IF (SageProdIntegLic=1) THEN
  SELECT count(SubRegistryID) into In_Count from subregistry where registryid='SageProdIntegrate';
  IF(In_Count>0) THEN
    ViewListLoop: for ViewListFor as curs dynamic scroll cursor for
    select RegProperty1 as In_View from subregistry where registryid='SageProdIntegrate' do
    EXECUTE IMMEDIATE ('GRANT SELECT  ON ' + In_View  +' TO ' + In_UserID);
    end for
  END IF;
ELSE
  IF (TMSLic=1) THEN
    SELECT count(SubRegistryID) into In_Count from subregistry where registryid='TMS Vendor';
  IF(In_Count>0) THEN
    ViewListLoop: for ViewListFor as cursTMS dynamic scroll cursor for
    select RegProperty1 as In_View from subregistry where registryid='TMS Vendor' do
    EXECUTE IMMEDIATE ('GRANT SELECT  ON ' + In_View  +' TO ' + In_UserID);
    end for
  END IF;
 END IF;
  
END IF;

end;

if exists(select regproperty1  from subregistry where subregistryid='dbcountry' and regproperty1<>'Singapore') then

  if exists(select regproperty1 from subregistry where registryid='SageProdIntegrate' and subregistryid='TMSViewSGTimeSheet') then
    delete from subregistry where registryid='SageProdIntegrate' and subregistryid='TMSViewSGTimeSheet';
  end if;

end if;

if not exists(select * from ePortalVersion where EPE = '1061000') then
  insert into ePortalVersion(EPE,ePortal) values ('1061000','1030000');
end if;

commit work;

