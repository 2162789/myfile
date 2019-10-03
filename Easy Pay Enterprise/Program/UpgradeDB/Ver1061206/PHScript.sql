
if exists(select 1 from sys.syscolumns where tname='PhTaxEmployer' and cname='PhERAddress') then
    Alter table DBA.PhTaxEmployer Modify PhERAddress char(150);
end if;

if exists(select * from sys.sysprocedure where proc_name = 'InsertNewPhTaxEmployer') then
    drop procedure InsertNewPhTaxEmployer;
end if;

CREATE PROCEDURE "DBA"."InsertNewPhTaxEmployer"(
in In_PhEmployerId char(20),
in In_PhRegisteredName char(100),
in In_PhERTIN char(30),
in In_PhRDOCode char(20),
in In_PhLineOfBusiness char(30),
in In_PhERCategory char(20),
in In_PhERAddress char(150),
in In_PostalCode char(6),
in In_TelephoneNo char(20),
in In_PhTaxBranch char(4),
in In_PhRegionNo char(4),
out Out_ErrorCode integer)
begin
  if In_PhEmployerId is null then
    set Out_ErrorCode=-1;
    return
  end if;
  if not exists(select* from PhTaxEmployer where PhEmployerId = In_PhEmployerId) then
    insert into PhTaxEmployer(PhEmployerId,
      PhRegisteredName,
      PhERTIN,
      PhRDOCode,
      PhLineOfBusiness,
      PhERCategory,
      PhERAddress,
      PostalCode,
      TelephoneNo,
      PhTaxBranch,
      PhRegionNo) values(
      In_PhEmployerId,
      In_PhRegisteredName,
      In_PhERTIN,
      In_PhRDOCode,
      In_PhLineOfBusiness,
      In_PhERCategory,
      In_PhERAddress,
      In_PostalCode,
      In_TelephoneNo,
      In_PhTaxBranch,
      In_PhRegionNo);
    set Out_ErrorCode=1;
    commit work
  else
    set Out_ErrorCode=-2
  end if
end;

if exists(select * from sys.sysprocedure where proc_name = 'UpdatePhTaxEmployer') then
    drop procedure UpdatePhTaxEmployer;
end if;

CREATE PROCEDURE "DBA"."UpdatePhTaxEmployer"(
in In_PhEmployerId char(20),
in In_PhRegisteredName char(100),
in In_PhERTIN char(30),
in In_PhRDOCode char(20),
in In_PhLineOfBusiness char(30),
in In_ERCategory char(20),
in In_PhERAddress char(150),
in In_PostalCode char(6),
in In_TelephoneNo char(20),
in In_PhTaxBranch char(4),
in In_PhRegionNo char(4),
out Out_ErrorCode integer)
begin
  if exists(select* from PhTaxEmployer where PhEmployerId = In_PhEmployerId) then
    update PhTaxEmployer set
      PhRegisteredName = In_PhRegisteredName,
      PhERTIN = In_PhERTIN,
      PhRDOCode = In_PhRDOCode,
      PhLineOfBusiness = In_PhLineOfBusiness,
      PhERCategory = In_ERCategory,
      PhERAddress = In_PhERAddress,
      PostalCode = In_PostalCode,
      TelephoneNo = In_TelephoneNo,
      PhTaxBranch = In_PhTaxBranch,
      PhRegionNo = In_PhRegionNo where
      PhEmployerId = In_PhEmployerId;
    set Out_ErrorCode=1;
    commit work
  else
    set Out_ErrorCode=-1
  end if
end;


commit work;