Read UpgradeDB\Ver1061102\Entity.sql;

if exists (select * from sys.sysprocedure where proc_name = 'FGetBankBNMCode') then
  drop function FGetBankBNMCode
end if;

create function DBA.FGetBankBNMCode(
in In_PaymentBankCode char(20))
returns char(100)
begin
  declare Out_BankBNMCode char(100);
  select Bank.BankString1 into Out_BankBNMCode
    from Bank where Bank.BankId = In_PaymentBankCode;
  return(Out_BankBNMCode)
end;

ALTER VIEW "DBA"."View_TMS_LabelName"
     AS
     SELECT TableName, AttributeName, NewLName AS LabelName FROM LabelName;



if exists(select * from sys.sysprocedure where proc_name = 'ASQLUpdateEmployeeKeyword') then
    drop procedure ASQLUpdateEmployeeKeyword;
end if;

CREATE PROCEDURE "DBA"."ASQLUpdateEmployeeKeyword"()
begin
  declare CustDate1_Id char(100);
  declare CustDate2_Id char(100);
  declare CustDate3_Id char(100);
  
  select NewLName into CustDate1_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate1';
  select NewLName into CustDate2_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate2';
  select NewLName into CustDate3_Id from LabelName where TableName = 'Employee' and AttributeName = 'CustDate3';
 
  
 if exists(select* from RemFunction where
      SysDateTableId = 'Employee' and SysDateAttributeId='CustDate1')  then
    update RemFunction set Funcmessage = 'Employee - ' + CustDate1_Id where
       SysDateTableId = 'Employee' and SysDateAttributeId='CustDate1';
  end if;
   if exists(select* from RemFunction where
      SysDateTableId = 'Employee' and SysDateAttributeId='CustDate2')  then
   update RemFunction set Funcmessage = 'Employee - ' + CustDate2_Id where
       SysDateTableId = 'Employee' and SysDateAttributeId='CustDate2';
  end if;
   if exists(select* from RemFunction where
      SysDateTableId = 'Employee' and SysDateAttributeId='CustDate3')   then
    update RemFunction set Funcmessage = 'Employee - ' + CustDate3_Id where
       SysDateTableId = 'Employee' and SysDateAttributeId='CustDate3';
  end if;


end;


if exists(select * from sys.sysprocedure where proc_name = 'ASQLProcessUpdateLabelName') then
 ALTER PROCEDURE "DBA"."ASQLProcessUpdateLabelName"()
begin
  call ASQLUpdateCareerSubregistry();
  call ASQLUpdateImportFieldNameLabel();
  call ASQLUpdateInterfaceAttributeMappingLabel();
  call ASQLUpdateInterfaceCodeMappingLabel();
  call ASQLUpdateCostBasisSubregistry();
  call ASQLUpdateRPayElementBasisSubregistry();
  call ASQLUpdateItemBasisSubregistry();
  call ASQLUpdateOTBasisSubregistry();
  call ASQLUpdateShiftBasisSubregistry();
  call ASQLUpdateGovtProgBasisSubregistry();
  call ASQLUpdateMClaimBasisSubregistry();
  call ASQLUpdateLeaveBasisSubregistry();
  call ASQLUpdateHRBasisSubregistry();
  call ASQLUpdateEmployeeSystemAttribute();
  call ASQLUpdatePayBasisAnlysKeyword();
  call ASQLUpdateAccrualBasisKeyword();
  call ASQLUpdatePayKeyword();
  call ASQLUpdateCEBasisSubregistry();
  call ASQLUpdateLeaveKeyword();
  call ASQLUpdateInterCorpBasisSubregistry();
  call ASQLUpdateAuditTrialBasisSubregistry();
  call ASQLUpdateAnlysSystemAttribute();
  call ASQLUpdateLabourSurveyBasis();
  call ASQLUpdateEmployeeKeyword();

end;

end if;




/*Keyword Default Data*/

if not exists(select KeywordId from keyword where KeywordId='DayBefore') then 
insert into Keyword (KEYWORDID,KEYWORDDEFAULTNAME,KEYWORDUSERDEFINEDNAME,KEYWORDCATEGORY,KEYWORDPROPERTYSELECTION,KEYWORDFORMULASELECTION,KEYWORDRANGESELECTION,KEYWORDDESC,KEYWORDSUBCATEGORY,KEYWORDSUBPROPERTY,KEYWORDSTAGE,KEYWORDGROUP)
values('DayBefore','Day Before','Day Before','SysReminder',0,0,0,'DayBefore',0,0,0,'');
end if ;

if not exists(select KeywordId from keyword where KeywordId='DayAfter') then 
insert into Keyword (KEYWORDID,KEYWORDDEFAULTNAME,KEYWORDUSERDEFINEDNAME,KEYWORDCATEGORY,KEYWORDPROPERTYSELECTION,KEYWORDFORMULASELECTION,KEYWORDRANGESELECTION,KEYWORDDESC,KEYWORDSUBCATEGORY,KEYWORDSUBPROPERTY,KEYWORDSTAGE,KEYWORDGROUP)
values('DayAfter','Day After','Day After','SysReminder',0,0,0,'DayAfter',0,0,0,'');
end if ;

if not exists(select KeywordId from keyword where KeywordId='WeekBefore') then 
insert into Keyword (KEYWORDID,KEYWORDDEFAULTNAME,KEYWORDUSERDEFINEDNAME,KEYWORDCATEGORY,KEYWORDPROPERTYSELECTION,KEYWORDFORMULASELECTION,KEYWORDRANGESELECTION,KEYWORDDESC,KEYWORDSUBCATEGORY,KEYWORDSUBPROPERTY,KEYWORDSTAGE,KEYWORDGROUP)
values('WeekBefore','Week Before','Week Before','SysReminder',0,0,0,'WeekBefore',0,0,0,'');
end if ;

if not exists(select KeywordId from keyword where KeywordId='WeekAfter') then 
insert into Keyword (KEYWORDID,KEYWORDDEFAULTNAME,KEYWORDUSERDEFINEDNAME,KEYWORDCATEGORY,KEYWORDPROPERTYSELECTION,KEYWORDFORMULASELECTION,KEYWORDRANGESELECTION,KEYWORDDESC,KEYWORDSUBCATEGORY,KEYWORDSUBPROPERTY,KEYWORDSTAGE,KEYWORDGROUP)
values('WeekAfter','Week After','Week After','SysReminder',0,0,0,'WeekAfter',0,0,0,'');
end if ;

if not exists(select KeywordId from keyword where KeywordId='MonthBefore') then 
insert into Keyword (KEYWORDID,KEYWORDDEFAULTNAME,KEYWORDUSERDEFINEDNAME,KEYWORDCATEGORY,KEYWORDPROPERTYSELECTION,KEYWORDFORMULASELECTION,KEYWORDRANGESELECTION,KEYWORDDESC,KEYWORDSUBCATEGORY,KEYWORDSUBPROPERTY,KEYWORDSTAGE,KEYWORDGROUP)
values('MonthBefore','Month Before','Month Before','SysReminder',0,0,0,'MonthBefore',0,0,0,'');
end if ;

if not exists(select KeywordId from keyword where KeywordId='MonthAfter') then 
insert into Keyword (KEYWORDID,KEYWORDDEFAULTNAME,KEYWORDUSERDEFINEDNAME,KEYWORDCATEGORY,KEYWORDPROPERTYSELECTION,KEYWORDFORMULASELECTION,KEYWORDRANGESELECTION,KEYWORDDESC,KEYWORDSUBCATEGORY,KEYWORDSUBPROPERTY,KEYWORDSTAGE,KEYWORDGROUP)
values('MonthAfter','Month After','Month After','SysReminder',0,0,0,'MonthAfter',0,0,0,'');
end if ;

if not exists(select KeywordId from keyword where KeywordId='YearBefore') then 
insert into Keyword (KEYWORDID,KEYWORDDEFAULTNAME,KEYWORDUSERDEFINEDNAME,KEYWORDCATEGORY,KEYWORDPROPERTYSELECTION,KEYWORDFORMULASELECTION,KEYWORDRANGESELECTION,KEYWORDDESC,KEYWORDSUBCATEGORY,KEYWORDSUBPROPERTY,KEYWORDSTAGE,KEYWORDGROUP)
values('YearBefore','Year Before','Year Before','SysReminder',0,0,0,'YearBefore',0,0,0,'');
end if ;

if not exists(select KeywordId from keyword where KeywordId='YearAfter') then 
insert into Keyword (KEYWORDID,KEYWORDDEFAULTNAME,KEYWORDUSERDEFINEDNAME,KEYWORDCATEGORY,KEYWORDPROPERTYSELECTION,KEYWORDFORMULASELECTION,KEYWORDRANGESELECTION,KEYWORDDESC,KEYWORDSUBCATEGORY,KEYWORDSUBPROPERTY,KEYWORDSTAGE,KEYWORDGROUP)
values('YearAfter','Year After','Year After','SysReminder',0,0,0,'YearAfter',0,0,0,'');
end if ;

/*RemFunction Default Data*/

if not exists(select RemFunctionId from RemFunction where RemFunctionId='EmpeeCustomDate1') then 
insert into RemFunction (REMFUNCTIONID,TASKCATEGORYID,ISCUSTOMISED,DLLNAME,FUNCMESSAGE,SYSDATETABLEID,SYSDATEATTRIBUTEID,SYSDATESQLJOIN,SYSDATESQLCOND,PARAMNAMEU1,PARAMNAMEU2,PARAMNAMEU3,
PARAMNAMEU4,PARAMNAMEU5,FUNCKEYATTRIBUTEID1,FUNCKEYATTRIBUTEID2,FUNCKEYATTRIBUTEID3,FUNCKEYATTRIBUTEID4,FUNCKEYATTRIBUTEID5,FUNCKEYWORD1,FUNCKEYWORD2,FUNCKEYWORD3,FUNCKEYWORD4,FUNCKEYWORD5)
values('EmpeeCustomDate1','Core','1','VsBTaskReminder','Custom Date 1','Employee','CustDate1','Employee E','','','','','','','E.EmployeeSysID','','','','','EmployeeName','EmployeeID','CustDate1','','');
end if ;

if not exists(select RemFunctionId from RemFunction where RemFunctionId='EmpeeCustomDate2') then 
insert into RemFunction (REMFUNCTIONID,TASKCATEGORYID,ISCUSTOMISED,DLLNAME,FUNCMESSAGE,SYSDATETABLEID,SYSDATEATTRIBUTEID,SYSDATESQLJOIN,SYSDATESQLCOND,PARAMNAMEU1,PARAMNAMEU2,PARAMNAMEU3,
PARAMNAMEU4,PARAMNAMEU5,FUNCKEYATTRIBUTEID1,FUNCKEYATTRIBUTEID2,FUNCKEYATTRIBUTEID3,FUNCKEYATTRIBUTEID4,FUNCKEYATTRIBUTEID5,FUNCKEYWORD1,FUNCKEYWORD2,FUNCKEYWORD3,FUNCKEYWORD4,FUNCKEYWORD5)
values('EmpeeCustomDate2','Core','1','VsBTaskReminder','Custom Date 2','Employee','CustDate2','Employee E','','','','','','','E.EmployeeSysID','','','','','EmployeeName','EmployeeID','CustDate2','','');
end if ;

if not exists(select RemFunctionId from RemFunction where RemFunctionId='EmpeeCustomDate3') then 
insert into RemFunction (REMFUNCTIONID,TASKCATEGORYID,ISCUSTOMISED,DLLNAME,FUNCMESSAGE,SYSDATETABLEID,SYSDATEATTRIBUTEID,SYSDATESQLJOIN,SYSDATESQLCOND,PARAMNAMEU1,PARAMNAMEU2,PARAMNAMEU3,
PARAMNAMEU4,PARAMNAMEU5,FUNCKEYATTRIBUTEID1,FUNCKEYATTRIBUTEID2,FUNCKEYATTRIBUTEID3,FUNCKEYATTRIBUTEID4,FUNCKEYATTRIBUTEID5,FUNCKEYWORD1,FUNCKEYWORD2,FUNCKEYWORD3,FUNCKEYWORD4,FUNCKEYWORD5)
values('EmpeeCustomDate3','Core','1','VsBTaskReminder','Custom Date 3','Employee','CustDate3','Employee E','','','','','','','E.EmployeeSysID','','','','','EmployeeName','EmployeeID','CustDate3','','');
end if ;

/*RemDetailStmpl  Default Data*/

if not exists(select REMFUNCTIONID from RemDetailStmpl where REMFUNCTIONID='EmpeeCustomDate1') then 
insert into RemDetailStmpl (REMFUNCTIONID,REMDETAILSTMPLORDER,DETAILS)
values('EmpeeCustomDate1','1','<K1> (<K2>), due on <K3>');
end if ;

if not exists(select REMFUNCTIONID from RemDetailStmpl where REMFUNCTIONID='EmpeeCustomDate2') then 
insert into RemDetailStmpl (REMFUNCTIONID,REMDETAILSTMPLORDER,DETAILS)
values('EmpeeCustomDate2','1','<K1> (<K2>), due on <K3>');
end if ;

if not exists(select REMFUNCTIONID from RemDetailStmpl where REMFUNCTIONID='EmpeeCustomDate3') then 
insert into RemDetailStmpl (REMFUNCTIONID,REMDETAILSTMPLORDER,DETAILS)
values('EmpeeCustomDate3','1','<K1> (<K2>), due on <K3>');
end if ;

if exists(select * from sys.sysprocedure where proc_name = 'DeleteCostingDetails') then
    drop procedure DeleteCostingDetails
end if;

CREATE PROCEDURE DBA.DeleteCostingDetails(
in In_EmployeeSysId integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from CostingDetails where CostingDetails.EmployeeSysId = In_EmployeeSysId) then
    set Out_ErrorCode=-1; // EmployeeSysId not exist
    return
  else
    // deleting CostProgression
    for CostProgressionFor as Cur_CostProgSysId dynamic scroll cursor for
      select CostProgSysId from
        CostProgression where
        CostProgression.EmployeeSysId = In_EmployeeSysId do
      call DeleteCostProgression(CostProgSysId) end for;
    // deleting CostPeriod
    for CostPeriodFor as Cur_CostPeriodSysId dynamic scroll cursor for
      select CostPeriod.CostPeriodSysId,CostSubPeriod from
        CostPeriod left join CostSubPeriod where
        EmployeeSysId = In_EmployeeSysId order by
        CostPeriod.CostPeriodSysId asc,CostSubPeriod asc do
      call ASQLDeleteCostSubPeriod(CostPeriodSysId,CostSubPeriod) end for;
    delete from CostingDetails where CostingDetails.EmployeeSysId = In_EmployeeSysId;
    commit work
  end if;
  if exists(select* from CostingDetails where CostingDetails.EmployeeSysId = In_EmployeeSysId) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end;

commit work;