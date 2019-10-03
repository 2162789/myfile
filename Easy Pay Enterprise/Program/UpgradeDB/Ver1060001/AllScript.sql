READ UpgradeDB\Ver1060001\RptConfig.sql;
READ UpgradeDB\Ver1060001\KeyWord.sql;

IF NOT EXISTS (SELECT * FROM Registry WHERE RegistryId = 'OracleEBS') THEN
  INSERT INTO Registry VALUES ('OracleEBS','Oracle EBS Segment Field Configuration')
END IF;

IF NOT EXISTS (SELECT * FROM SubRegistry WHERE RegistryId = 'OracleEBS' AND SubRegistryId = 'SegmentConfig') THEN
  INSERT INTO SubRegistry VALUES ('OracleEBS','SegmentConfig',
                                  'FGetCostCentreCodeId(CostCentreId, 1)',
                                  'FGetCostCentreCodeId(CostCentreId, 2)',
                                  'GLCode',
                                  'FGetCostCentreCodeId(CostCentreId, 3)',
                                  'FGetCostCentreCodeId(CostCentreId, 4)',
                                  'FGetCostCentreCodeId(CostCentreId, 5)',
                                  '"000"',
                                  '','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00')
END IF;

If exists(select 1 from sys.sysprocedure where proc_name = 'FGetPhyYearGivenPayYrPeriod' and user_name(creator) = 'DBA') then
   drop function DBA.FGetPhyYearGivenPayYrPeriod
end if;
create function DBA.FGetPhyYearGivenPayYrPeriod(
in In_PayGroupId char(20),
in In_PayYear integer,
in In_PayPeriod integer)
returns integer
begin
  declare PhyYear integer;
  declare PhyMonth integer;
  set PhyMonth = FGetPhyMonthGivenPayYrPeriod(In_PayGroupId, In_PayYear, In_PayPeriod);
  if PhyMonth-In_PayPeriod >= 0 then set PhyYear=In_PayYear
  else set PhyYear=In_PayYear+1
  end if;
  return PhyYear
end;

If exists(select 1 from sys.sysprocedure where proc_name = 'FGetCostCentreCodeId' and user_name(creator) = 'DBA') then
   drop function DBA.FGetCostCentreCodeId
end if;
create function dba.FGetCostCentreCodeId(
in In_CostCentreId char(20),
in In_CodeNo integer)
returns char(20)
begin
  declare Out_CostCentreCodeId char(20);

  case In_CodeNo
    when 1 then
      select CostCentreCode1Id into Out_CostCentreCodeId from CostCentre where CostCentreId = In_CostCentreId;
    when 2 then
      select CostCentreCode2Id into Out_CostCentreCodeId from CostCentre where CostCentreId = In_CostCentreId;
    when 3 then
      select CostCentreCode3Id into Out_CostCentreCodeId from CostCentre where CostCentreId = In_CostCentreId;
    when 4 then
      select CostCentreCode4Id into Out_CostCentreCodeId from CostCentre where CostCentreId = In_CostCentreId;
    when 5 then
      select CostCentreCode5Id into Out_CostCentreCodeId from CostCentre where CostCentreId = In_CostCentreId;
  end case;

  return(Out_CostCentreCodeId);
end;

COMMIT WORK;