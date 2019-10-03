create procedure dba.ASQLApprUpdateBasicRate(
in In_EmployeeSysId integer,
in In_AppraisalSysId integer)
begin
  declare Out_TotalWage double;
  declare In_AppraisalDate date;
  declare In_ApprBRProgDate date;
  declare In_ApprPayAdjust smallint;
  declare In_ApprAdjustType smallint;
  declare In_AppraisalTypeId char(20);
  declare In_ApprCareerMovement smallint;
  declare In_BRProgressionCode char(20);
  declare In_BRProgCareerId char(20);
  declare In_BRProgRemarks char(100);
  declare In_ApprBRAdjust double;
  declare In_ApprMVCAdjust double;
  declare In_ApprNWCAdjust double;
  declare In_BRProgNewBasicRate double;
  declare In_MVCNewRate double;
  declare In_NWCNewRate double;
  declare In_BRProgPrevBasicRate double;
  declare In_MVCPrevRate double;
  declare In_NWCPrevRate double;
  declare In_BRProgIncrementAmt double;
  declare In_MVCIncrementAmt double;
  declare In_NWCIncrementAmt double;
  declare In_BRProgPercentage double;
  declare In_MVCPercentage double;
  declare In_NWCPercentage double;
  declare Out_ShortstringAttr char(20);
  declare In_BRProgNextIncDate date;
  /*
  Appraisal Record        
  */
  select AppraisalDate,
    ApprBRProgDate,
    ApprPayAdjust,
    ApprAdjustType,
    ApprBRAdjust,
    ApprMVCAdjust,
    ApprNWCAdjust,
    ApprCareerMovement,
    AppraisalTypeId into In_AppraisalDate,
    In_ApprBRProgDate,
    In_ApprPayAdjust,
    In_ApprAdjustType,
    In_ApprBRAdjust,
    In_ApprMVCAdjust,
    In_ApprNWCAdjust,
    In_ApprCareerMovement,
    In_AppraisalTypeId from Appraisal where AppraisalSysId = In_AppraisalSysId;
  /*
  Specify the Progression Code and Career ID
  */
  case In_ApprCareerMovement
  when 0 then
    set In_BRProgCareerId=''
  when 1 then
    set In_BRProgCareerId='Increment'
  when 2 then
    set In_BRProgCareerId='Demotion'
  when 3 then
    set In_BRProgCareerId='Transfer'
  end case
  ;
  case In_ApprPayAdjust
  when 1 then
    set In_BRProgressionCode='Increment'
  when 2 then
    set In_BRProgressionCode='Decrement'
  end case
  ;
  select ShortstringAttr into Out_ShortstringAttr from SubRegistry where SubRegistryId = 'DateFormat' and RegistryId = 'System';
  case Out_ShortstringAttr when 'dd-mm-yyyy' then
    set In_BRProgRemarks=In_AppraisalTypeId+' Appraisal on '+convert(char(20),In_AppraisalDate,103) when 'mm-dd-yyyy' then
    set In_BRProgRemarks=In_AppraisalTypeId+' Appraisal on '+convert(char(20),In_AppraisalDate,101) when 'yyyy-mm-dd' then
    set In_BRProgRemarks=In_AppraisalTypeId+' Appraisal on '+convert(char(20),In_AppraisalDate,111)
  end case
  ;
  /*
  Get the nearest Basic Rate and Policy Progression record before Progression Date
  */
  select top 1 BRProgNewBasicRate into In_BRProgPrevBasicRate from BasicRateProgression where
    EmployeeSysId = In_EmployeeSysId and
    BRProgDate < In_ApprBRProgDate order by BRProgDate desc;
  select top 1 MVCNewRate,NWCNewRate into In_MVCPrevRate,In_NWCPrevRate from PolicyProgression where
    EmployeeSysId = In_EmployeeSysId and
    BRProgDate < In_ApprBRProgDate order by BRProgDate desc;
  set Out_TotalWage=In_BRProgPrevBasicRate+In_MVCPrevRate+In_NWCPrevRate;
  set In_BRProgNextIncDate=dateadd(year,1,In_ApprBRProgDate);
  /*
  Create for Percentage
  */
  if(In_ApprAdjustType = 0) then
    set In_BRProgIncrementAmt=Round(Out_TotalWage*In_ApprBRAdjust/100,2);
    set In_MVCIncrementAmt=Round(Out_TotalWage*In_ApprMVCAdjust/100,2);
    set In_NWCIncrementAmt=Round(Out_TotalWage*In_ApprNWCAdjust/100,2);
    set In_BRProgNewBasicRate=In_BRProgIncrementAmt+In_BRProgPrevBasicRate;
    set In_MVCNewRate=In_MVCIncrementAmt+In_MVCPrevRate;
    set In_NWCNewRate=In_NWCIncrementAmt+In_NWCPrevRate;
    /*
    Create Basic Rate Progression record   
    */
    if(not exists(select* from BasicRateProgression where EmployeeSysId = In_EmployeeSysId and
        BRProgDate = In_ApprBRProgDate)) then
      call InsertNewBasicRateProgression(In_EmployeeSysId,
      In_ApprBRProgDate,
      In_BRProgRemarks,
      In_ApprBRProgDate,'',
      In_BRProgNewBasicRate,
      In_ApprBRAdjust, /* In_BRProgPercentage */
      In_BRProgressionCode,
      In_BRProgCareerId,
      In_BRProgPrevBasicRate,
      In_BRProgIncrementAmt,'',
      /*In_BRProgPayGroup*/
      0,In_BRProgNextIncDate,''); /*In_BRProgCurrent*/
      call InsertNewPolicyProgression(
      In_EmployeeSysId,
      In_ApprBRProgDate,
      In_NWCPrevRate,
      In_NWCIncrementAmt,
      In_ApprNWCAdjust,
      In_NWCNewRate,
      In_MVCPrevRate,
      In_MVCIncrementAmt,
      In_ApprMVCAdjust,
      In_MVCNewRate)
    else
      /*
      Update Existing Basic Rate Progression record   
      */
      update BasicRateProgression set
        BRProgNewBasicRate = In_BRProgNewBasicRate,
        BRProgPercentage = In_ApprBRAdjust,
        BRProgIncrementAmt = In_BRProgIncrementAmt where
        EmployeeSysId = In_EmployeeSysId and BRProgDate = In_ApprBRProgDate;
      update PolicyProgression set
        NWCIncrementAmt = In_NWCIncrementAmt,
        NWCPercentage = In_ApprNWCAdjust,
        NWCNewRate = In_NWCNewRate,
        MVCIncrementAmt = In_MVCIncrementAmt,
        MVCPercentage = In_ApprMVCAdjust,
        MVCNewRate = In_MVCNewRate where
        EmployeeSysId = In_EmployeeSysId and BRProgDate = In_ApprBRProgDate
    end if
  else
    /*
    Create for Amount Increment
    */
    set In_BRProgNewBasicRate=Round(In_BRProgPrevBasicRate+In_ApprBRAdjust,2);
    set In_MVCNewRate=Round(In_MVCPrevRate+In_ApprMVCAdjust,2);
    set In_NWCNewRate=Round(In_NWCPrevRate+In_ApprNWCAdjust,2);
    set In_BRProgPercentage=Round((In_ApprBRAdjust/Out_TotalWage)*100,2);
    set In_MVCPercentage=Round((In_ApprMVCAdjust/Out_TotalWage)*100,2);
    set In_NWCPercentage=Round((In_ApprNWCAdjust/Out_TotalWage)*100,2);
    /*
    Create Basic Rate Progression record   
    */
    if(not exists(select* from BasicRateProgression where EmployeeSysId = In_EmployeeSysId and
        BRProgDate = In_ApprBRProgDate)) then
      call InsertNewBasicRateProgression(In_EmployeeSysId,
      In_ApprBRProgDate,
      In_BRProgRemarks,
      In_ApprBRProgDate,'',
      In_BRProgNewBasicRate,
      In_BRProgPercentage,
      In_BRProgressionCode,
      In_BRProgCareerId,
      In_BRProgPrevBasicRate,
      In_ApprBRAdjust,'', /* In_BRProgIncrementAmt */
      /*In_BRProgPayGroup*/
      0,
      In_BRProgNextIncDate,''); /*In_BRProgCurrent*/
      call InsertNewPolicyProgression(
      In_EmployeeSysId,
      In_ApprBRProgDate,
      In_NWCPrevRate,
      In_ApprNWCAdjust,
      In_NWCPercentage,
      In_NWCNewRate,
      In_MVCPrevRate,
      In_ApprMVCAdjust,
      In_MVCPercentage,
      In_MVCNewRate)
    else
      /*
      Update Existing Basic Rate Progression record   
      */
      update BasicRateProgression set
        BRProgNewBasicRate = In_BRProgNewBasicRate,
        BRProgPercentage = In_BRProgPercentage,
        BRProgIncrementAmt = In_ApprBRAdjust where
        EmployeeSysId = In_EmployeeSysId and BRProgDate = In_ApprBRProgDate;
      update PolicyProgression set
        NWCIncrementAmt = In_ApprNWCAdjust,
        NWCPercentage = In_NWCPercentage,
        NWCNewRate = In_NWCNewRate,
        MVCIncrementAmt = In_ApprMVCAdjust,
        MVCPercentage = In_MVCPercentage,
        MVCNewRate = In_MVCNewRate where
        EmployeeSysId = In_EmployeeSysId and BRProgDate = In_ApprBRProgDate
    end if
  end if;
  commit work
end
;

create procedure DBA.ASQLApprUpdateCareer(
in In_EmployeeSysId integer,
in In_AppraisalSysId integer)
begin
  declare In_ApprCareerEffectDate date;
  declare In_ApprCareerMovement smallint;
  declare In_AppraisalTypeId char(20);
  declare In_CareerCode char(20);
  declare In_CareerRemarks char(100);
  declare In_AppraisalDate date;
  declare Out_CareerNewValue char(100);
  declare Out_ShortstringAttr char(20);
  /*
  Appraisal Record        
  */
  select AppraisalDate,ApprCareerEffectDate,ApprCareerMovement,AppraisalTypeId into In_AppraisalDate,In_ApprCareerEffectDate,
    In_ApprCareerMovement,
    In_AppraisalTypeId from Appraisal where AppraisalSysId = In_AppraisalSysId;
  /*
  Specify the Career Code
  */
  case In_ApprCareerMovement
  when 1 then
    set In_CareerCode='Promotion'
  when 2 then
    set In_CareerCode='Demotion'
  when 3 then
    set In_CareerCode='Transfer'
  end case
  ;
  select ShortstringAttr into Out_ShortstringAttr from SubRegistry where SubRegistryId = 'DateFormat' and RegistryId = 'System';
  case Out_ShortstringAttr when 'dd-mm-yyyy' then
    set In_CareerRemarks=In_AppraisalTypeId+' Appraisal on '+convert(char(20),In_AppraisalDate,103) when 'mm-dd-yyyy' then
    set In_CareerRemarks=In_AppraisalTypeId+' Appraisal on '+convert(char(20),In_AppraisalDate,101) when 'yyyy-mm-dd' then
    set In_CareerRemarks=In_AppraisalTypeId+' Appraisal on '+convert(char(20),In_AppraisalDate,111)
  end case
  ; /*
  Update Existing Career Progression record   
  */
  if(exists(select* from CareerProgression where EmployeeSysId = In_EmployeeSysId and
      CareerEffectiveDate = In_ApprCareerEffectDate)) then
    update CareerProgression set
      CareerRemarks = In_CareerRemarks,
      CareerCareerId = In_CareerCode where
      EmployeeSysId = In_EmployeeSysId and
      CareerEffectiveDate = In_ApprCareerEffectDate
  else
    /*
    Insert Career Progression record and create its Career Attributes  
    */
    call InsertNewCareerProgression(In_EmployeeSysId,
    In_ApprCareerEffectDate,
    In_CareerRemarks,'',
    In_CareerCode,0);
    CareerAttribute: for CareerAttributeFor as CareerAttributeCurs dynamic scroll cursor for
      select SubRegistryId as Out_SubRegistryId from SubRegistry where RegistryId = 'CareerAttribute' and
        ShortStringAttr <> '' do
      select first CareerNewValue into Out_CareerNewValue from CareerAttribute where
        CareerEffectiveDate <= In_ApprCareerEffectDate and
        EmployeeSysId = In_EmployeeSysId and
        CareerAttributeId = Out_SubRegistryId order by CareerEffectiveDate desc;
      if(Out_CareerNewValue is null) then
        set Out_CareerNewValue=''
      end if;
      call InsertNewCareerAttribute(In_EmployeeSysId,In_ApprCareerEffectDate,Out_SubRegistryId,Out_CareerNewValue) end for
  end if;
  commit work
end
;

create procedure DBA.ASQLFormDsnDateDefault(
in In_FormId char(20),
in In_FormSecSysId integer,
in In_FormFieldId char(20),
inout Out_Date date)
begin
  select DateValue into Out_Date from FormControlProperty where
    FormSecSysId = In_FormSecSysId and
    FormId = In_FormId and
    FormFieldId = In_FormFieldId;
  if Out_Date is null then set Out_Date='1899-12-30'
  end if
end
;

create procedure DBA.ASQLFormDsnDeleteApprStruc(
in In_FormSecSysId integer)
begin
  declare In_FormId char(20);
  select FormId into In_FormId from FormSection where FormSecSysId = In_FormSecSysId;
  if(not exists(select* from Appraisal where Appraisal.FormId = In_FormId)) then
    /*
    To list out all the children of this section
    */
    DeleteFormSection: for DeleteFormSectionFor as DeleteFormSectionCurs dynamic scroll cursor for
      select FormSecSysId as Out_FormSecSysId from
        FormSection where
        FormId = In_FormId and
        FormParentSysId = In_FormSecSysId do
      /*
      Check this section has child sections
      */
      if(exists(select* from FormSection where
          FormId = In_FormId and
          FormParentSysId = Out_FormSecSysId)) then
        call ASQLFormDsnDeleteApprStruc(Out_FormSecSysId)
      else
        /*
        Delete this child section
        */
        delete from FormCtrlItem where
          FormId = In_FormId and
          FormSecSysId = Out_FormSecSysId;
        delete from FormControlProperty where
          FormId = In_FormId and
          FormSecSysId = Out_FormSecSysId;
        delete from FormPoint where
          FormId = In_FormId and
          FormSecSysId = Out_FormSecSysId;
        delete from FormLayout where
          FormId = In_FormId and
          FormSecSysId = Out_FormSecSysId;
        delete from FormSection where
          FormId = In_FormId and
          FormSecSysId = Out_FormSecSysId
      end if end for;
    /*
    Delete this section
    */
    delete from FormCtrlItem where
      FormId = In_FormId and
      FormSecSysId = In_FormSecSysId;
    delete from FormControlProperty where
      FormId = In_FormId and
      FormSecSysId = In_FormSecSysId;
    delete from FormPoint where
      FormId = In_FormId and
      FormSecSysId = In_FormSecSysId;
    delete from FormLayout where
      FormId = In_FormId and
      FormSecSysId = In_FormSecSysId;
    delete from FormSection where
      FormId = In_FormId and
      FormSecSysId = In_FormSecSysId;
    commit work
  end if
end
;

create procedure DBA.ASQLFormDsnIntegerDefault(
in In_FormId char(20),
in In_FormSecSysId integer,
in In_FormFieldId char(20),
inout Out_Integer integer)
begin
  declare Out_FormControlClassName char(50);
  select FormControlClassName into Out_FormControlClassName from FormControlProperty join FormRegisterControl where
    FormControlProperty.FormSecSysId = In_FormSecSysId and
    FormControlProperty.FormId = In_FormId and
    FormControlProperty.FormFieldId = In_FormFieldId;
  if Out_FormControlClassName = 'TDBCheckBox' then
    select BooleanValue into Out_Integer from FormControlProperty where
      FormSecSysId = In_FormSecSysId and
      FormId = In_FormId and
      FormFieldId = In_FormFieldId
  else
    select IntegerValue into Out_Integer from FormControlProperty where
      FormSecSysId = In_FormSecSysId and
      FormId = In_FormId and
      FormFieldId = In_FormFieldId
  end if;
  if Out_Integer is null then set Out_Integer=0
  end if
end
;

create procedure DBA.ASQLFormDsnNumericDefault(
in In_FormId char(20),
in In_FormSecSysId integer,
in In_FormFieldId char(20),
inout Out_Numeric double)
begin
  select NumericValue into Out_Numeric from FormControlProperty where
    FormSecSysId = In_FormSecSysId and
    FormId = In_FormId and
    FormFieldId = In_FormFieldId;
  if Out_Numeric is null then set Out_Numeric=0
  end if
end
;

create procedure DBA.ASQLFormDsnSecTotalFullWt(
in In_FormSecSysId integer,
inout In_TotalFullWt double)
begin
  declare In_FormId char(20);
  declare tmpTotalFullWt double;
  select FormId into In_FormId from FormSection where FormSecSysId = In_FormSecSysId;
  /*
  To list out all the children of this section
  */
  if(not exists(select* from FormSection where
      FormId = In_FormId and
      FormParentSysId = In_FormSecSysId)) then
    select Sum(FormMaxPoint) into In_TotalFullWt from FormPoint where
      FormId = In_FormId and
      FormSecSysId = In_FormSecSysId;
    if(In_TotalFullWt is null) then set In_TotalFullWt=0
    end if
  else
    FormSection: for FormSectionFor as FormSectionCurs dynamic scroll cursor for
      select FormSecSysId as Out_FormSecSysId from
        FormSection where
        FormId = In_FormId and
        FormParentSysId = In_FormSecSysId do
      /*
      Check this section has child sections
      */
      set tmpTotalFullWt=0;
      if(exists(select* from FormSection where
          FormId = In_FormId and
          FormParentSysId = Out_FormSecSysId)) then
        call ASQLFormDsnSecTotalFullWt(Out_FormSecSysId,tmpTotalFullWt)
      else
        select Sum(FormMaxPoint) into tmpTotalFullWt from FormPoint where
          FormId = In_FormId and
          FormSecSysId = Out_FormSecSysId;
        if(tmpTotalFullWt is null) then set tmpTotalFullWt=0
        end if
      end if;
      set In_TotalFullWt=In_TotalFullWt+tmpTotalFullWt end for
  end if
end
;

create procedure DBA.ASQLFormDsnStringDefault(
in In_FormId char(20),
in In_FormSecSysId integer,
in In_FormFieldId char(20),
inout Out_String char(200))
begin
  select StringValue into Out_String from FormControlProperty where
    FormSecSysId = In_FormSecSysId and
    FormId = In_FormId and
    FormFieldId = In_FormFieldId;
  if Out_String is null then set Out_String=''
  end if
end
;

create procedure DBA.ASQLFormDsnUpdateApprStruc(
in In_AppraisalSysId integer)
begin
  declare In_FormId char(20);
  declare Out_FreeNumeric1 double;
  declare Out_FreeNumeric2 double;
  declare Out_FreeNumeric3 double;
  declare Out_FreeNumeric4 double;
  declare Out_FreeNumeric5 double;
  declare Out_FreeWt1 double;
  declare Out_FreeWt2 double;
  declare Out_FreeWt3 double;
  declare Out_FreeWt4 double;
  declare Out_FreeWt5 double;
  declare Out_FreeString1 char(200);
  declare Out_FreeString2 char(200);
  declare Out_FreeString3 char(200);
  declare Out_FreeString4 char(200);
  declare Out_FreeString5 char(200);
  declare Out_FreeDate1 date;
  declare Out_FreeDate2 date;
  declare Out_FreeDate3 date;
  declare Out_FreeDate4 date;
  declare Out_FreeDate5 date;
  declare Out_FreeInteger1 integer;
  declare Out_FreeInteger2 integer;
  declare Out_FreeInteger3 integer;
  declare Out_FreeInteger4 integer;
  declare Out_FreeInteger5 integer;
  /*
  Get the Form ID
  */
  select FormId into In_FormId from Appraisal where AppraisalSysId = In_AppraisalSysId;
  /*
  Delete Away Appraisal Point records not in this Form ID.
  */
  delete from AppraisalPoint where
    AppraisalSysId = In_AppraisalSysId and
    not ApprPointSysId = 
    any(select FormPointSysId from FormPoint where FormId = In_FormId and
      FormSecSysId = ApprSecSysId);
  /*
  Delete Away Appraisal Section records not in this Form ID.
  */
  delete from ApprSection where
    AppraisalSysId = In_AppraisalSysId and
    not ApprSecSysId = 
    any(select FormSecSysId from FormSection where FormId = In_FormId);
  /*
  Create Appraisal Section records not in this Appraisal. 
  */
  InsertFormSection: for InsertFormSectionFor as InsertFormSectionCurs dynamic scroll cursor for
    select FormSecSysId as Out_FormSecSysId,
      FormParentSysId as Out_FormParentSysId from FormSection where
      FormId = In_FormId and
      not FormSecSysId = any(select ApprSecSysId from ApprSection where
        AppraisalSysId = In_AppraisalSysId and
        ApprSecSysId = Out_FormSecSysId) do
    insert into ApprSection(AppraisalSysId,ApprSecSysId,ApprSecParentSysId,SubTotal) values(
      In_AppraisalSysId,Out_FormSecSysId,Out_FormParentSysId,0) end for;
  /*
  Create Appraisal Point records not in this Appraisal.
  */
  InsertFormPoint: for InsertFormPointFor as InsertFormPointCurs dynamic scroll cursor for
    select FormPointSysId as Out_FormPointSysId,
      FormSecSysId as Out_FormSecSysId from
      FormPoint where
      FormId = In_FormId and
      not FormPointSysId = any(select ApprPointSysId from AppraisalPoint where
        AppraisalSysId = In_AppraisalSysId and
        ApprPointSysId = Out_FormPointSysId and
        ApprSecSysId = Out_FormSecSysId) do
    /*
    Get default value for Appraisal Point attributes
    */
    call ASQLFormDsnNumericDefault(In_FormId,Out_FormSecSysId,'FreeNumeric1',Out_FreeNumeric1);
    call ASQLFormDsnNumericDefault(In_FormId,Out_FormSecSysId,'FreeNumeric2',Out_FreeNumeric2);
    call ASQLFormDsnNumericDefault(In_FormId,Out_FormSecSysId,'FreeNumeric3',Out_FreeNumeric3);
    call ASQLFormDsnNumericDefault(In_FormId,Out_FormSecSysId,'FreeNumeric4',Out_FreeNumeric4);
    call ASQLFormDsnNumericDefault(In_FormId,Out_FormSecSysId,'FreeNumeric5',Out_FreeNumeric5);
    call ASQLFormDsnNumericDefault(In_FormId,Out_FormSecSysId,'FreeWt1',Out_FreeWt1);
    call ASQLFormDsnNumericDefault(In_FormId,Out_FormSecSysId,'FreeWt2',Out_FreeWt2);
    call ASQLFormDsnNumericDefault(In_FormId,Out_FormSecSysId,'FreeWt3',Out_FreeWt3);
    call ASQLFormDsnNumericDefault(In_FormId,Out_FormSecSysId,'FreeWt4',Out_FreeWt4);
    call ASQLFormDsnNumericDefault(In_FormId,Out_FormSecSysId,'FreeWt5',Out_FreeWt5);
    call ASQLFormDsnStringDefault(In_FormId,Out_FormSecSysId,'FreeString1',Out_FreeString1);
    call ASQLFormDsnStringDefault(In_FormId,Out_FormSecSysId,'FreeString2',Out_FreeString2);
    call ASQLFormDsnStringDefault(In_FormId,Out_FormSecSysId,'FreeString3',Out_FreeString3);
    call ASQLFormDsnStringDefault(In_FormId,Out_FormSecSysId,'FreeString4',Out_FreeString4);
    call ASQLFormDsnStringDefault(In_FormId,Out_FormSecSysId,'FreeString5',Out_FreeString5);
    call ASQLFormDsnDateDefault(In_FormId,Out_FormSecSysId,'FreeDate1',Out_FreeDate1);
    call ASQLFormDsnDateDefault(In_FormId,Out_FormSecSysId,'FreeDate2',Out_FreeDate2);
    call ASQLFormDsnDateDefault(In_FormId,Out_FormSecSysId,'FreeDate3',Out_FreeDate3);
    call ASQLFormDsnDateDefault(In_FormId,Out_FormSecSysId,'FreeDate4',Out_FreeDate4);
    call ASQLFormDsnDateDefault(In_FormId,Out_FormSecSysId,'FreeDate5',Out_FreeDate5);
    call ASQLFormDsnIntegerDefault(In_FormId,Out_FormSecSysId,'FreeInteger1',Out_FreeInteger1);
    call ASQLFormDsnIntegerDefault(In_FormId,Out_FormSecSysId,'FreeInteger2',Out_FreeInteger2);
    call ASQLFormDsnIntegerDefault(In_FormId,Out_FormSecSysId,'FreeInteger3',Out_FreeInteger3);
    call ASQLFormDsnIntegerDefault(In_FormId,Out_FormSecSysId,'FreeInteger4',Out_FreeInteger4);
    call ASQLFormDsnIntegerDefault(In_FormId,Out_FormSecSysId,'FreeInteger5',Out_FreeInteger5);
    insert into AppraisalPoint(AppraisalSysId,
      ApprSecSysId,
      ApprPointSysId,
      FreeNumeric1,
      FreeNumeric2,
      FreeNumeric3,
      FreeNumeric4,
      FreeNumeric5,
      FreeWt1,
      FreeWt2,
      FreeWt3,
      FreeWt4,
      FreeWt5,
      FreeString1,
      FreeString2,
      FreeString3,
      FreeString4,
      FreeString5,
      FreeDate1,
      FreeDate2,
      FreeDate3,
      FreeDate4,
      FreeDate5,
      FreeInteger1,
      FreeInteger2,
      FreeInteger3,
      FreeInteger4,
      FreeInteger5,
      SubTotal) values(
      In_AppraisalSysId,
      Out_FormSecSysId,
      Out_FormPointSysId,
      Out_FreeNumeric1,
      Out_FreeNumeric2,
      Out_FreeNumeric3,
      Out_FreeNumeric4,
      Out_FreeNumeric5,
      Out_FreeWt1,
      Out_FreeWt2,
      Out_FreeWt3,
      Out_FreeWt4,
      Out_FreeWt5,
      Out_FreeString1,
      Out_FreeString2,
      Out_FreeString3,
      Out_FreeString4,
      Out_FreeString5,
      Out_FreeDate1,
      Out_FreeDate2,
      Out_FreeDate3,
      Out_FreeDate4,
      Out_FreeDate5,
      Out_FreeInteger1,
      Out_FreeInteger2,
      Out_FreeInteger3,
      Out_FreeInteger4,
      Out_FreeInteger5,0) end for;
  commit work
end
;

create procedure DBA.ASQLItemBatchAssign(
in In_PersonalSysId integer,
in In_ItemBatchId char(20),
out Out_ErrorCode integer)
begin
  declare Out_ItemAssignItemSysId integer;
  ItemBAssignSysIdLoop: for ItemBAssignSysIdIdFor as Cur_ItemBAssignSysId dynamic scroll cursor for
    select distinct ItemBAssignSysId as Get_ItemBAssignSysId,
      ItemId as Get_ItemId,
      AssignQty as Get_AssignQty,
      AssignUnitAmt as Get_AssignUnitAmt,
      Remarks as Get_Remarks,
      ExpiryDate as Get_ExpiryDate,
      IsOnLoan as Get_IsOnLoan,
      WaivedDate as Get_WaivedDate,
      NextIssueDate as Get_NextIssueDate,
      EffectiveDate as Get_EffectiveDate,
      IssueDate as Get_IssueDate,
      IssueByEmpeeSysId as Get_IssueByEmpeeSysId from
      ItemBAssgn where
      ItemBAssgn.ItemBatchId = In_ItemBatchId do
    select max(ItemAssignItemSysId) into Out_ItemAssignItemSysId from ItemAssignItem;
    if(Out_ItemAssignItemSysId is null) then
      set Out_ItemAssignItemSysId=0
    end if;
    if not exists(select* from ItemAssignItem where
        ItemAssignItemSysId = Out_ItemAssignItemSysId+1) then
      insert into ItemAssignItem(ItemAssignItemSysId,
        ItemId,
        PersonalSysId,
        AssignQty,
        AssignUnitAmt,
        Remarks,
        SerialNo,
        BarCode,
        ExpiryDate,
        IsOnLoan,
        WaivedDate,
        NextIssueDate,
        EffectiveDate,
        IssueDate,
        ePortalIssueEmpeeSysId,
        ePortalStatus) values(Out_ItemAssignItemSysId+1,
        Get_ItemId,
        In_PersonalSysId,
        Get_AssignQty,
        Get_AssignUnitAmt,
        Get_Remarks,'','',
        Get_ExpiryDate,
        Get_IsOnLoan,
        Get_WaivedDate,
        Get_NextIssueDate,
        Get_EffectiveDate,
        Get_IssueDate,
        Get_IssueByEmpeeSysId,
        0);
      commit work;
      if not exists(select* from ItemAssignItem where
          ItemAssignItemSysId = Out_ItemAssignItemSysId+1) then
        set Out_ItemAssignItemSysId=null;
        set Out_ErrorCode=0
      else
        set Out_ItemAssignItemSysId=Out_ItemAssignItemSysId+1;
        set Out_ErrorCode=1;
        ItemBAssignAttrSysIdLoop: for ItemBAssignAttrSysIdFor as Cur_ItemBAssignAttrSysId dynamic scroll cursor for
          select ItemBAssignAttrSysId as Get_ItemBAssignAttrSysId,
            ItemAttrNameId as Get_ItemAttrNameId,
            ItemAttrType as Get_ItemAttrType,
            ItemAttrStrValue as Get_ItemAttrStrValue,
            ItemAttrNumValue as Get_ItemAttrNumValue,
            ItemAttrDateValue as Get_ItemAttrDateValue from
            ItemBAssignAttr where
            ItemBAssignSysId = Get_ItemBAssignSysId do
          insert into ItemAssignAttr(ItemAssignAttrSysId,
            ItemAssignItemSysId,
            ItemAttrNameId,
            ItemAttrType,ItemAttrStrValue,ItemAttrNumValue,ItemAttrDateValue) values(
            (select max(ItemAssignAttrSysId) from ItemAssignAttr)+1,
            Out_ItemAssignItemSysId,Get_ItemAttrNameId,
            Get_ItemAttrType,
            Get_ItemAttrStrValue,
            Get_ItemAttrNumValue,
            Get_ItemAttrDateValue);
          commit work end for
      end if
    else
      set Out_ItemAssignItemSysId=null;
      set Out_ErrorCode=0
    end if;
    commit work end for
end
;

create procedure DBA.ASQLMedClaimRangeBasis(
in In_PersonalSysId integer,
in In_MedClaimPolicyId char(20),
in In_ProcessDate date,
out Out_String char(20),
out Out_Value double)
begin
  declare Out_MedClaimPolicyBasis char(20);
  declare Out_DateOfBirth date;
  declare Out_HireDate date;
  declare Out_PreviousSvcYear double;
  declare Out_EmployeeSysId integer;
  set Out_String=0;
  set Out_Value=0;
  select MedClaimPolicyBasis into Out_MedClaimPolicyBasis from MClaimPolicy where
    MedClaimPolicyId = In_MedClaimPolicyId;
  select first EmployeeSysId into Out_EmployeeSysId from Employee where
    PersonalSysId = In_PersonalSysId order by HireDate desc;
  if Out_EmployeeSysId is null then set Out_EmployeeSysId=0
  end if;
  case Out_MedClaimPolicyBasis when 'ServiceYear' then
    /*
    Get the latest Employment Record's Service Year
    */
    select HireDate,PreviousSvcYear into Out_HireDate,Out_PreviousSvcYear from Employee where
      PersonalSysId = In_PersonalSysId and
      EmployeeSysId = Out_EmployeeSysId;
    select Round(cast(Months(Out_HireDate,In_ProcessDate) as double)/12,2)+Out_PreviousSvcYear into Out_Value when 'Age' then
    /*
    Get the latest Personal Record's Age
    */
    select DateOfBirth into Out_DateOfBirth from Personal where
      PersonalSysId = In_PersonalSysId;
    select Round(cast(Months(Out_DateOfBirth,In_ProcessDate) as double)/12,2) into Out_Value when 'Department' then
    /*
    Get the latest Employment Record's Department
    */
    select first CareerNewValue into Out_String from CareerAttribute where EmployeeSysId = Out_EmployeeSysId and
      CareerEffectiveDate <= In_ProcessDate and
      CareerAttributeId = 'CareerDepartment' order by CareerEffectiveDate desc when 'Branch' then
    /*
    Get the latest Employment Record's Branch
    */
    select first CareerNewValue into Out_String from CareerAttribute where EmployeeSysId = Out_EmployeeSysId and
      CareerEffectiveDate <= In_ProcessDate and
      CareerAttributeId = 'CareerBranch' order by CareerEffectiveDate desc when 'Category' then
    /*
    Get the latest Employment Record's Category
    */
    select first CareerNewValue into Out_String from CareerAttribute where EmployeeSysId = Out_EmployeeSysId and
      CareerEffectiveDate <= In_ProcessDate and
      CareerAttributeId = 'CareerCategory' order by CareerEffectiveDate desc when 'Section' then
    /*
    Get the latest Employment Record's Section
    */
    select first CareerNewValue into Out_String from CareerAttribute where EmployeeSysId = Out_EmployeeSysId and
      CareerEffectiveDate <= In_ProcessDate and
      CareerAttributeId = 'CareerSection' order by CareerEffectiveDate desc when 'Gender' then
    /*
    Get the latest Personal Record's Gender
    */
    select GenderCodeName into Out_String from Personal join GenderCode on(Gender = GenderCodeId) where
      PersonalSysId = In_PersonalSysId when 'MaritalStatus' then
    /*
    Get the latest Employment Record's Marital Status
    */
    select MaritalStatusCode into Out_String from Personal where
      PersonalSysId = In_PersonalSysId
  end case
end
;

create procedure dba.ASQLRecruitInterviewerPostProcess(
in In_RecruitInterviewerSysId integer,
in In_RecruitCode char(20),
out Out_ErrorCode integer)
begin
  declare RecruitInterviewerSysId_toChange integer;
  set Out_ErrorCode=1; // No warning
  // if the posted query is a new record
  if In_RecruitInterviewerSysId = 0 then
    select max(RecruitInterviewerSysId) into In_RecruitInterviewerSysId from RecruitInterviewer
  end if;
  for RecruitInterviewerCheck as Cur_InterviewOrder dynamic scroll cursor for
    select InterviewOrder as Get_InterviewOrder from RecruitInterviewer where RecruitCode = In_RecruitCode do
    if not exists(select* from RecruitInterviewer where RecruitCode = In_RecruitCode and InterviewOrder = Get_InterviewOrder and KeyInterviewer = 1) then
      select max(RecruitInterviewerSysId) into RecruitInterviewerSysId_toChange from RecruitInterviewer where RecruitCode = In_RecruitCode and InterviewOrder = Get_InterviewOrder;
      update RecruitInterviewer set KeyInterviewer = 1 where
        RecruitInterviewerSysId = RecruitInterviewerSysId_toChange;
      commit work;
      set Out_ErrorCode=-1 // WARNING: no keyinterviewer for this intervieworder; action: last record in this intervieworder is set to be keyinterviewer
    end if;
    if(select count(RecruitInterviewerSysId) from RecruitInterviewer where RecruitCode = In_RecruitCode and InterviewOrder = Get_InterviewOrder and KeyInterviewer = 1) > 1 then
      update RecruitInterviewer set KeyInterviewer = 0 where
        RecruitCode = In_RecruitCode and InterviewOrder = Get_InterviewOrder and
        RecruitInterviewerSysId <> In_RecruitInterviewerSysId;
      commit work;
      set Out_ErrorCode=-2 // WARNING: more than one keyinterviewer in a single intervieworder; action: set other keyinterviewer to 0
    end if end for
end
;

create procedure dba.ASQLRecruitInterviewerPreProcess(
in In_RecruitInterviewerSysId integer,
in In_RecruitCode char(20),
in In_ePortalEmployeeSysId integer,
in In_InterviewOrder integer,
in In_KeyInterviewer smallint,
out Out_ErrorCode integer)
begin
  if not exists(select* from RecruitPosition where RecruitCode = In_RecruitCode) then
    set Out_ErrorCode=-1; // ERROR: RecruitCode not exist in RecruitPosition (no parent to begin with)
    return
  elseif exists(select* from RecruitInterviewer where RecruitInterviewerSysId <> In_RecruitInterviewerSysId and RecruitCode = In_RecruitCode and ePortalEmployeeSysId = In_ePortalEmployeeSysId and InterviewOrder = In_InterviewOrder) then
    set Out_ErrorCode=-2; // ERROR: duplicate ePortalEmployeeSysId for the same InterviewOrder
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure DBA.ASQLTrainingDeleteNotInBatch(
in In_TrainingBatchId char(20))
begin
  DeleteTrainingLoop: for DeleteTrainingFor as curs dynamic scroll cursor for
    select TrainingSysId as Out_TrainingSysId from Training where
      TrainingBatchID = In_TrainingBatchId and
      not PersonalSysId = 
      any(select TrainPersonalSysId as PersonalSysId from TrainingPersonnel where TrainingBatchID = In_TrainingBatchId) do
    /*
    To update the Appraisal Training Record 
    */
    UpdateAppraisalLoop: for UpdateAppraisalFor as Appraisalcurs dynamic scroll cursor for
      select AppraisalSysId as Out_AppraisalSysId,
        ApprTrainingSysId as Out_ApprTrainingSysId from
        Training join ApprTraining where
        TrainingBatchID = In_TrainingBatchId and
        not PersonalSysId = 
        any(select TrainPersonalSysId as PersonalSysId from TrainingPersonnel where TrainingBatchID = In_TrainingBatchId) do
      update ApprTraining set
        TrainingSysId = null where
        AppraisalSysId = Out_AppraisalSysId and
        ApprTrainingSysId = Out_ApprTrainingSysId;
      commit work end for;
    call DeleteTraining(Out_TrainingSysId) end for
end
;

create procedure DBA.ASQLTrainingLinkAppraisal(
in In_TrainingBatchId char(20))
begin
  declare Out_TrainingSysId integer;
  UpdateAppraisalLoop: for UpdateAppraisalFor as curs dynamic scroll cursor for
    select TrainAppraisalSysId as Out_TrainAppraisalSysId,
      TrainApprTrainingSysId as Out_TrainApprTrainingSysId,
      TrainPersonalSysId as Out_PersonalSysId from
      TrainingPersonnel where
      TrainingBatchID = In_TrainingBatchId and
      TrainAppraisalSysId > 0 do
    select TrainingSysId into Out_TrainingSysId from Training where
      Training.TrainingBatchID = In_TrainingBatchId and PersonalSysId = Out_PersonalSysId;
    update ApprTraining set
      TrainingSysId = Out_TrainingSysId where
      AppraisalSysId = Out_TrainAppraisalSysId and
      ApprTrainingSysId = Out_TrainApprTrainingSysId;
    commit work end for
end
;

create procedure DBA.ASQLTrainingSysTotalCost(
in In_TrainingBatchId char(20))
begin
  declare Out_TotalTrainAmount double;
  declare Out_TotalTaxAmount double;
  /*
  Get list of Personnel in this Batch
  */
  TrainingPersonnelLoop: for TrainingPersonnelFor as TrainingPersonnelCur dynamic scroll cursor for
    select TrainingSysId as Out_TrainingSysId from Training where
      TrainingBatchId = In_TrainingBatchId do
    /*
    Sum the Training Amount and Tax Amount
    */
    select Sum(TrainAmount),Sum(TrainTaxAmount) into Out_TotalTrainAmount,Out_TotalTaxAmount from
      Training join TrainCostRec where
      TrainingBatchId = In_TrainingBatchId and
      Training.TrainingSysId = Out_TrainingSysId;
    /*
    Update to Training Record
    */
    if(Out_TotalTrainAmount is null) then
      set Out_TotalTrainAmount=0
    end if;
    if(Out_TotalTaxAmount is null) then
      set Out_TotalTaxAmount=0
    end if;
    update Training set
      TotalTrainingFee = Out_TotalTrainAmount,
      TotalTaxAmount = Out_TotalTaxAmount where
      TrainingSysId = Out_TrainingSysId end for;
  commit work
end
;

create procedure DBA.ASQLTrainingUpdateCost(
in In_TrainingBatchId char(20))
begin
  declare NoOfPersonnal integer;
  declare Out_TrainingSysId integer;
  declare Chk_TrainCostTypeId char(20);
  declare Each_TrainAmount double;
  declare Bal_TrainAmount double;
  declare Each_TrainTaxAmount double;
  declare Bal_TrainTaxAmount double;
  declare PersonalCnt integer;
  declare Out_TrainForClaim integer;
  /*
  Count the number of personnel records
  */
  select Count(*) into NoOfPersonnal from TrainingPersonnel where
    TrainingBatchID = In_TrainingBatchId;
  if(NoOfPersonnal = 0 or NoOfPersonnal is null) then return
  end if;
  /*
  Get list of Batch Training Cost Record
  */
  TrainBatchCostLoop: for TrainBatchCostFor as TrainBatchCostCur dynamic scroll cursor for
    select TrainingBatchID as Out_TrainingBatchID,
      TrainCostTypeId as Out_TrainCostTypeId,
      TrainAmount as Out_TrainAmount,
      TrainTaxAmount as Out_TrainTaxAmount from
      TrainBatchCostRec where
      TrainingBatchID = In_TrainingBatchId do
    /*
    Compute the Amount
    */
    set Each_TrainAmount="Truncate"(Out_TrainAmount/NoOfPersonnal,0);
    set Bal_TrainAmount=Round(Out_TrainAmount-(Each_TrainAmount*(NoOfPersonnal-1)),2);
    set Each_TrainTaxAmount="Truncate"(Out_TrainTaxAmount/NoOfPersonnal,0);
    set Bal_TrainTaxAmount=Round(Out_TrainTaxAmount-(Each_TrainTaxAmount*(NoOfPersonnal-1)),2);
    set PersonalCnt=0;
    /*
    Get list of Personnal in this Batch
    */
    TrainingPersonnelLoop: for TrainingPersonnelFor as TrainingPersonnelCur dynamic scroll cursor for
      select TrainPersonalSysId from
        TrainingPersonnel where
        TrainingBatchID = In_TrainingBatchId do
      /*
      Locate for the Personal Training Cost Record
      */
      select TrainingSysId into Out_TrainingSysId from Training where
        TrainingBatchID = In_TrainingBatchId and
        PersonalSysId = TrainPersonalSysId;
      select TrainCostTypeId into Chk_TrainCostTypeId from Training left outer join TrainCostRec where
        TrainingBatchID = In_TrainingBatchId and
        PersonalSysId = TrainPersonalSysId and
        TrainCostTypeId = Out_TrainCostTypeId;
      select TrainForClaim into Out_TrainForClaim from TrainingBatch left outer join TrainBatchCostRec where
        TrainingBatch.TrainingBatchID = In_TrainingBatchId and
        TrainCostTypeId = Out_TrainCostTypeId;
      /*
      Insert if not found
      */
      if(Chk_TrainCostTypeId is null or Chk_TrainCostTypeId = '') then
        /*
        Create Training Record
        */
        if(PersonalCnt = NoOfPersonnal-1) then
          insert into TrainCostRec(TrainingSysId,
            TrainCostTypeId,
            TrainAmount,
            TrainTaxAmount,
            TrainForClaim) values(
            Out_TrainingSysId,
            Out_TrainCostTypeId,
            Bal_TrainAmount,
            Bal_TrainTaxAmount,
            Out_TrainForClaim)
        else
          insert into TrainCostRec(TrainingSysId,
            TrainCostTypeId,
            TrainAmount,
            TrainTaxAmount,
            TrainForClaim) values(
            Out_TrainingSysId,
            Out_TrainCostTypeId,
            Each_TrainAmount,
            Each_TrainTaxAmount,
            Out_TrainForClaim)
        end if
      else /*
        Update Training Record
        */
        if(PersonalCnt = NoOfPersonnal-1) then
          update TrainCostRec set
            TrainAmount = Bal_TrainAmount,
            TrainTaxAmount = Bal_TrainTaxAmount,
            TrainForClaim = Out_TrainForClaim where
            TrainCostTypeId = Out_TrainCostTypeId and
            TrainingSysId = Out_TrainingSysId
        else
          update TrainCostRec set
            TrainAmount = Each_TrainAmount,
            TrainTaxAmount = Each_TrainTaxAmount,
            TrainForClaim = Out_TrainForClaim where
            TrainCostTypeId = Out_TrainCostTypeId and
            TrainingSysId = Out_TrainingSysId
        end if
      end if;
      set PersonalCnt=PersonalCnt+1 end for end for
end
;

create procedure dba.ASQLUpdateEmpeeCompeEdu(
in In_CompetencySysId integer,
out Out_ErrorCode integer)
begin
  declare Out_CompetencyDate date;
  declare Out_PersonalSysId integer;
  if exists(select* from Competency where CompetencySysId = In_CompetencySysId) then
    select CompetencyDate,PersonalSysId into Out_CompetencyDate,Out_PersonalSysId from Competency left outer join Employee on Competency.EmployeeSysId = Employee.EmployeeSysId where CompetencySysId = In_CompetencySysId;
    //
    // Education Level
    //
    EduLoop: for EduFor as EduCurs dynamic scroll cursor for
      select distinct EduLevelId as Out_EduLevelId from EducationRec join Education where PersonalSysId = Out_PersonalSysId do
      if not exists(select* from CompeEduLevel where CompetencySysId = In_CompetencySysId and EduLevelId = Out_EduLevelId) then
        insert into CompeEduLevel(CompetencySysId,
          EduLevelId,
          CMatch) values(
          In_CompetencySysId,
          Out_EduLevelId,
          0);
        commit work
      end if end for;
    set Out_ErrorCode=1;
    //
    // Education Major/Minor
    //
    EduMajorLoop: for EduMajorFor as EduMajorCurs dynamic scroll cursor for
      select distinct FieldMajorId as Out_FieldMajorId from EducationRec join EduMajor where PersonalSysId = Out_PersonalSysId do
      if not exists(select* from CompeFieldMajor where CompetencySysId = In_CompetencySysId and FieldMajorId = Out_FieldMajorId) then
        insert into CompeFieldMajor(CompetencySysId,
          FieldMajorId,
          CMatch) values(
          In_CompetencySysId,
          Out_FieldMajorId,
          0);
        commit work
      end if end for;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.ASQLUpdateEmpeeCompeRespon(
in In_CompetencySysId integer,
out Out_ErrorCode integer)
begin
  declare Out_CompetencyDate date;
  declare Out_EmployeeSysId integer;
  if exists(select* from Competency where CompetencySysId = In_CompetencySysId) then
    select CompetencyDate,EmployeeSysId into Out_CompetencyDate,Out_EmployeeSysId from Competency where CompetencySysId = In_CompetencySysId;
    JobResponLoop: for JobResponFor as JobResponCurs dynamic scroll cursor for
      select distinct ResponsibilityId as Out_ResponsibilityId from JobRespon where EmployeeSysId = Out_EmployeeSysId and
        (JobRespon.ExpiryDate = '1899-12-30' or JobRespon.ExpiryDate is null or(JobRespon.ExpiryDate > Out_CompetencyDate and JobRespon.JobResponEffectiveDate <= Out_CompetencyDate)) do
      if not exists(select* from CompeRespon where CompetencySysId = In_CompetencySysId and ResponsibilityId = Out_ResponsibilityId) then
        insert into CompeRespon(CompetencySysId,
          ResponsibilityId,
          CMatch) values(
          In_CompetencySysId,
          Out_ResponsibilityId,
          0);
        commit work
      end if end for;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.ASQLUpdateEmpeeCompeSkill(
in In_CompetencySysId integer,
out Out_ErrorCode integer)
begin
  declare Out_CompetencyDate date;
  declare Out_PersonalSysId integer;
  if exists(select* from Competency where CompetencySysId = In_CompetencySysId) then
    select CompetencyDate,PersonalSysId into Out_CompetencyDate,Out_PersonalSysId from Competency left outer join Employee on Competency.EmployeeSysId = Employee.EmployeeSysId where CompetencySysId = In_CompetencySysId;
    SkillLoop: for SkillFor as SkillCurs dynamic scroll cursor for
      select distinct SkillCode as Out_SkillCode from SkillLevel where PersonalSysId = Out_PersonalSysId and
        (SkillLevel.SkillExpiryDate = '1899-12-30' or SkillLevel.SkillExpiryDate is null or(SkillLevel.SkillExpiryDate > Out_CompetencyDate and SkillLevel.SkillEffectiveDate <= Out_CompetencyDate)) do
      if not exists(select* from CompeSkill where CompetencySysId = In_CompetencySysId and SkillCode = Out_SkillCode) then
        insert into CompeSkill(CompetencySysId,
          SkillCode,
          CMatch) values(
          In_CompetencySysId,
          Out_SkillCode,
          0);
        commit work
      end if end for;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteActionTaken(
in In_ActionTakenId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from ActionTaken where ActionTakenId = In_ActionTakenId) then
    if not exists(select* from AwardDisc where ActionTakenId = In_ActionTakenId) then
      delete from ActionTaken where ActionTakenId = In_ActionTakenId;
      commit work
    end if;
    if exists(select* from ActionTaken where ActionTakenId = In_ActionTakenId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteApplicant(
in In_ApplicantSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from Applicant where ApplicantSysId = In_ApplicantSysId) then
    /*
    Delete Interviewer
    */
    InterviewScheduleLoop: for InterviewScheduleFor as InterviewScheduleCurs dynamic scroll cursor for
      select InterviewSchSysId as Out_InterviewSchSysId from InterviewSchedule where
        InterviewSchedule.ApplicantSysId = In_ApplicantSysId do
      delete from Interviewer where
        Interviewer.InterviewSchSysId = Out_InterviewSchSysId end for;
    delete from InterviewSchedule where
      InterviewSchedule.ApplicantSysId = In_ApplicantSysId;
    commit work;
    delete from Applicant where
      Applicant.ApplicantSysId = In_ApplicantSysId;
    commit work;
    if exists(select* from Applicant where ApplicantSysId = In_ApplicantSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteApplicantAttach(
in In_ApplicantSysId integer,
in In_ApplicantAttachSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from ApplicantAttach where
      ApplicantAttach.ApplicantSysId = In_ApplicantSysId and
      ApplicantAttach.ApplicantAttachSysId = In_ApplicantAttachSysId) then
    delete from ApplicantAttach where
      ApplicantAttach.ApplicantSysId = In_ApplicantSysId and
      ApplicantAttach.ApplicantAttachSysId = In_ApplicantAttachSysId;
    commit work;
    if exists(select* from ApplicantAttach where
        ApplicantAttach.ApplicantSysId = In_ApplicantSysId and
        ApplicantAttach.ApplicantAttachSysId = In_ApplicantAttachSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteAppraisal(
in In_AppraisalSysId integer)
begin
  if exists(select* from AppraisalPoint where
      AppraisalSysId = In_AppraisalSysId) then
    delete from AppraisalPoint where
      AppraisalSysId = In_AppraisalSysId
  end if;
  if exists(select* from ApprSection where
      AppraisalSysId = In_AppraisalSysId) then
    delete from ApprSection where
      AppraisalSysId = In_AppraisalSysId
  end if;
  if exists(select* from AppraisalHistory where
      AppraisalSysId = In_AppraisalSysId) then
    delete from AppraisalHistory where
      AppraisalSysId = In_AppraisalSysId
  end if;
  if exists(select* from ApprTraining where
      AppraisalSysId = In_AppraisalSysId) then
    delete from ApprTraining where
      AppraisalSysId = In_AppraisalSysId
  end if;
  if exists(select* from Appraisers where
      AppraisalSysId = In_AppraisalSysId) then
    delete from Appraisers where
      AppraisalSysId = In_AppraisalSysId
  end if;
  if exists(select* from Appraisal where
      AppraisalSysId = In_AppraisalSysId) then
    delete from Appraisal where
      AppraisalSysId = In_AppraisalSysId
  end if;
  commit work
end
;

create procedure dba.DeleteAppraisalDetail(
in In_PersonalSysId integer,
in In_AppraisalDate date,
in In_ApprCategoryId char(20),
in In_ApprQuestionSysId integer)
begin
  if exists(select* from AppraisalDetail where
      AppraisalDetail.PersonalSysId = In_PersonalSysId and
      AppraisalDetail.AppraisalDate = In_AppraisalDate and
      AppraisalDetail.ApprCategoryId = In_ApprCategoryId and
      AppraisalDetail.ApprQuestionSysId = In_ApprQuestionSysId) then
    delete from AppraisalDetail where
      AppraisalDetail.PersonalSysId = In_PersonalSysId and
      AppraisalDetail.AppraisalDate = In_AppraisalDate and
      AppraisalDetail.ApprCategoryId = In_ApprCategoryId and
      AppraisalDetail.ApprQuestionSysId = In_ApprQuestionSysId;
    commit work
  end if
end
;

create procedure dba.DeleteAppraisalDetailByPersysIdAndDate(
in In_PersonalSysId integer,
in In_AppraisalDate date)
begin
  if exists(select* from AppraisalDetail where
      AppraisalDetail.PersonalSysId = In_PersonalSysId and
      AppraisalDetail.AppraisalDate = In_AppraisalDate) then
    delete from AppraisalDetail where
      AppraisalDetail.PersonalSysId = In_PersonalSysId and
      AppraisalDetail.AppraisalDate = In_AppraisalDate;
    commit work
  end if
end
;

create procedure dba.DeleteAppraisalGrade(
in In_ApprPtSystemId char(20),
in In_GradeCode char(20))
begin
  if exists(select* from AppraisalGrade where
      AppraisalGrade.ApprPtSystemId = In_ApprPtSystemId and
      AppraisalGrade.GradeCode = In_GradeCode) then
    delete from AppraisalGrade where
      AppraisalGrade.ApprPtSystemId = In_ApprPtSystemId and
      AppraisalGrade.GradeCode = In_GradeCode;
    commit work
  end if
end
;

create procedure dba.DeleteAppraisalGradeByPtSysId(
in In_ApprPtSystemId char(20))
begin
  if exists(select* from AppraisalGrade where
      AppraisalGrade.ApprPtSystemId = In_ApprPtSystemId) then
    delete from AppraisalGrade where
      AppraisalGrade.ApprPtSystemId = In_ApprPtSystemId;
    commit work
  end if
end
;

create procedure dba.DeleteAppraisalHistory(
in In_AppraisalSysId integer)
begin
  if exists(select* from AppraisalHistory where
      AppraisalSysId = In_AppraisalSysId) then
    delete from AppraisalHistory where
      AppraisalSysId = In_AppraisalSysId;
    commit work
  end if
end
;

create procedure dba.DeleteAppraisalType(
in In_AppraisalTypeId char(20))
begin
  if exists(select* from AppraisalType where AppraisalType.AppraisalTypeId = In_AppraisalTypeId) then
    if not exists(select* from Appraisal where AppraisalTypeId = In_AppraisalTypeId) then
      delete from AppraisalType where
        AppraisalType.AppraisalTypeId = In_AppraisalTypeId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteApprCategory(
in In_ApprCategoryId char(20))
begin
  if exists(select* from ApprQuestion where
      ApprQuestion.ApprCategoryId = In_ApprCategoryId) then
    delete from ApprQuestion where
      ApprQuestion.ApprCategoryId = In_ApprCategoryId
  end if;
  if exists(select* from ApprCategory where
      ApprCategory.ApprCategoryId = In_ApprCategoryId) then
    delete from ApprCategory where
      ApprCategory.ApprCategoryId = In_ApprCategoryId
  end if;
  commit work
end
;

create procedure dba.DeleteApprPtSystem(
in In_ApprPtSystemId char(20))
begin
  if exists(select* from AppraisalGrade where
      AppraisalGrade.ApprPtSystemId = In_ApprPtSystemId) then
    delete from AppraisalGrade where
      AppraisalGrade.ApprPtSystemId = In_ApprPtSystemId
  end if;
  if exists(select* from ApprPtSystem where
      ApprPtSystem.ApprPtSystemId = In_ApprPtSystemId) then
    delete from ApprPtSystem where
      ApprPtSystem.ApprPtSystemId = In_ApprPtSystemId
  end if;
  commit work
end
;

create procedure dba.DeleteApprTemplate(
in In_ApprTmpId char(20))
begin
  if exists(select* from AppraisalTmpRec where
      AppraisalTmpRec.ApprTmpId = In_ApprTmpId) then
    delete from AppraisalTmpRec where
      AppraisalTmpRec.ApprTmpId = In_ApprTmpId
  end if;
  if exists(select* from ApprTemplate where
      ApprTemplate.ApprTmpId = In_ApprTmpId) then
    delete from ApprTemplate where
      ApprTemplate.ApprTmpId = In_ApprTmpId
  end if;
  commit work
end
;

create procedure dba.DeleteApprTraining(
in In_AppraisalSysId integer,
in In_ApprTrainingSysId integer)
begin
  if exists(select* from ApprTraining where
      AppraisalSysId = In_AppraisalSysId and
      ApprTrainingSysId = In_ApprTrainingSysId) then
    delete from ApprTraining where
      AppraisalSysId = In_AppraisalSysId and
      ApprTrainingSysId = In_ApprTrainingSysId
  end if;
  commit work
end
;

create procedure dba.DeleteAreaSpecialised(
in In_AreaSpecialised char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from AreaSpecialised where AreaSpecialised = In_AreaSpecialised) then
    if not exists(select* from Specialised where AreaSpecialised = In_AreaSpecialised) then
      delete from AreaSpecialised where AreaSpecialised = In_AreaSpecialised;
      commit work
    end if;
    if exists(select* from AreaSpecialised where AreaSpecialised = In_AreaSpecialised) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteAwardCode(
in In_AwardDiscCode char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from AwardCode where AwardDiscCode = In_AwardDiscCode) then
    if not exists(select* from AwardDisc where AwardDiscCode = In_AwardDiscCode) then
      delete from AwardCode where AwardDiscCode = In_AwardDiscCode;
      commit work
    end if;
    if exists(select* from AwardCode where AwardDiscCode = In_AwardDiscCode) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteAwardDisc(
in In_AwardDiscSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from AwardDisc where AwardDiscSysId = In_AwardDiscSysId) then
    delete from AwardDiscAttach where
      AwardDiscAttach.AwardDiscSysId = In_AwardDiscSysId;
    commit work;
    delete from AwardDisc where
      AwardDisc.AwardDiscSysId = In_AwardDiscSysId;
    commit work;
    if exists(select* from AwardDisc where AwardDiscSysId = In_AwardDiscSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteAwardDiscAttach(
in In_AwardDiscSysId integer,
in In_AwardDiscAttachSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from AwardDiscAttach where
      AwardDiscAttach.AwardDiscSysId = In_AwardDiscSysId and
      AwardDiscAttach.AwardDiscAttachSysId = In_AwardDiscAttachSysId) then
    delete from AwardDiscAttach where
      AwardDiscAttach.AwardDiscSysId = In_AwardDiscSysId and
      AwardDiscAttach.AwardDiscAttachSysId = In_AwardDiscAttachSysId;
    commit work;
    if exists(select* from AwardDiscAttach where
        AwardDiscAttach.AwardDiscSysId = In_AwardDiscSysId and
        AwardDiscAttach.AwardDiscAttachSysId = In_AwardDiscAttachSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteBond(
in In_BondSysId integer)
begin
  update Training set
    BondSysId = null where
    BondSysId = In_BondSysId;
  if exists(select* from BondAttachment where
      BondSysId = In_BondSysId) then
    delete from BondAttachment where
      BondSysId = In_BondSysId
  end if;
  if exists(select* from Bond where
      BondSysId = In_BondSysId) then
    delete from Bond where
      BondSysId = In_BondSysId
  end if;
  commit work
end
;

create procedure dba.DeleteBondAttachment(
in In_BondSysId integer,
in In_BondAttachSysId integer)
begin
  if exists(select* from BondAttachment where
      BondSysId = In_BondSysId and
      BondAttachSysId = In_BondAttachSysId) then
    delete from BondAttachment where
      BondSysId = In_BondSysId and
      BondAttachSysId = In_BondAttachSysId;
    commit work
  end if
end
;

create procedure dba.DeleteCompetency(
in In_CompetencySysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from Competency where CompetencySysId = In_CompetencySysId) then
    /* 
    Delete CompeSkill, CompeRespon, CompeEduLevel, CompeFieldMajor, CompeFields
    */
    delete from CompeSkill where
      CompeSkill.CompetencySysId = In_CompetencySysId;
    commit work;
    delete from CompeRespon where
      CompeRespon.CompetencySysId = In_CompetencySysId;
    commit work;
    delete from CompeEduLevel where
      CompeEduLevel.CompetencySysId = In_CompetencySysId;
    commit work;
    delete from CompeFieldMajor where
      CompeFieldMajor.CompetencySysId = In_CompetencySysId;
    commit work;
    delete from CompeFields where
      CompeFields.CompetencySysId = In_CompetencySysId;
    commit work;
    delete from Competency where
      Competency.CompetencySysId = In_CompetencySysId;
    commit work;
    if exists(select* from Competency where CompetencySysId = In_CompetencySysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteContractCategory(
in In_ContractCategoryId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from ContractCategory where ContractCategoryId = In_ContractCategoryId) then
    if not exists(select* from Organisation where ContractCategoryId = In_ContractCategoryId) then
      delete from ContractCategory where ContractCategoryId = In_ContractCategoryId;
      commit work
    end if;
    if exists(select* from ContractCategory where ContractCategoryId = In_ContractCategoryId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteCourse(
in In_CourseCode char(20))
begin
  if exists(select* from Course where Course.CourseCode = In_CourseCode) then
    if(not exists(select* from CourseSchedule where CourseSchedule.CourseCode = In_CourseCode)) then
      call DeleteCourseGradeByCourseCode(In_CourseCode);
      call DeleteCourseAttachmentByCourseCode(In_CourseCode);
      delete from CourseSkill where
        CourseSkill.CourseCode = In_CourseCode;
      delete from Course where
        Course.CourseCode = In_CourseCode;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteCourseAttachment(
in In_CourseCode char(20),
in In_CourseAttachSysId integer)
begin
  if exists(select* from CourseAttachment where
      CourseAttachment.CourseCode = In_CourseCode and
      CourseAttachment.CourseAttachSysID = In_CourseAttachSysId) then
    delete from CourseAttachment where
      CourseAttachment.CourseCode = In_CourseCode and
      CourseAttachment.CourseAttachSysID = In_CourseAttachSysId;
    commit work
  end if
end
;

create procedure dba.DeleteCourseAttachmentByCourseCode(
in In_CourseCode char(20))
begin
  if exists(select* from CourseAttachment where
      CourseAttachment.CourseCode = In_CourseCode) then
    delete from CourseAttachment where
      CourseAttachment.CourseCode = In_CourseCode;
    commit work
  end if
end
;

create procedure dba.DeleteCourseCategory(
in In_CourseCategoryId char(20))
begin
  if exists(select* from CourseCategory where
      CourseCategoryId = In_CourseCategoryId) then
    if not exists(select* from Course where CourseCategoryId = In_CourseCategoryId) then
      delete from CourseCategory where
        CourseCategoryId = In_CourseCategoryId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteCourseContact(
in In_CourseCode char(20),
in In_CourseScheduleSysId integer,
in In_CourseContactSysId integer)
begin
  if exists(select* from CourseContact where CourseContact.CourseCode = In_CourseCode and
      CourseContact.CourseScheduleSysId = In_CourseScheduleSysId and
      CourseContact.CourseContactSysId = In_CourseContactSysId) then
    delete from CourseContact where CourseContact.CourseCode = In_CourseCode and
      CourseContact.CourseScheduleSysId = In_CourseScheduleSysId and
      CourseContact.CourseContactSysId = In_CourseContactSysId;
    commit work
  end if
end
;

create procedure dba.DeleteCourseContactByKeys(
in In_CourseCode char(20),
in In_CourseScheduleSysId integer)
begin
  if exists(select* from CourseContact where CourseContact.CourseCode = In_CourseCode and
      CourseContact.CourseScheduleSysId = In_CourseScheduleSysId) then
    delete from CourseContact where CourseContact.CourseCode = In_CourseCode and
      CourseContact.CourseScheduleSysId = In_CourseScheduleSysId;
    commit work
  end if
end
;

create procedure dba.DeleteCourseFamily(
in In_CourseFamilyId char(20))
begin
  if exists(select* from CourseFamily where
      CourseFamilyId = In_CourseFamilyId) then
    if not exists(select* from Course where CourseFamilyId = In_CourseFamilyId) then
      delete from CourseFamily where
        CourseFamilyId = In_CourseFamilyId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteCourseGrade(
in In_CourseCode char(20),
in In_GradeCode char(20))
begin
  if exists(select* from CourseGrade where
      CourseGrade.CourseCode = In_CourseCode and
      CourseGrade.GradeCode = In_GradeCode) then
    delete from CourseGrade where
      CourseGrade.CourseCode = In_CourseCode and
      CourseGrade.GradeCode = In_GradeCode;
    commit work
  end if
end
;

create procedure dba.DeleteCourseGradeByCourseCode(
in In_CourseCode char(20))
begin
  if exists(select* from CourseGrade where
      CourseGrade.CourseCode = In_CourseCode) then
    delete from CourseGrade where
      CourseGrade.CourseCode = In_CourseCode;
    commit work
  end if
end
;

create procedure dba.DeleteCourseRole(
in In_CourseRoleId char(20))
begin
  if exists(select* from CourseRole where CourseRole.CourseRoleId = In_CourseRoleId) then
    if not exists(select* from CourseContact where CourseRoleId = In_CourseRoleId) then
      delete from CourseRole where
        CourseRole.CourseRoleId = In_CourseRoleId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteCourseSchedule(
in In_CourseCode char(20),
in In_CourseScheduleSysID integer)
begin
  if exists(select* from CourseSchedule where
      CourseSchedule.CourseCode = In_CourseCode and
      CourseSchedule.CourseScheduleSysID = In_CourseScheduleSysID) then
    if((not exists(select* from Training where Training.CourseCode = In_CourseCode and
        Training.CourseScheduleSysID = In_CourseScheduleSysID))) then
      call DeleteCourseContactByKeys(In_CourseCode,In_CourseScheduleSysID);
      delete from CourseSchedule where
        CourseSchedule.CourseCode = In_CourseCode and
        CourseSchedule.CourseScheduleSysID = In_CourseScheduleSysID;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteCourseScheduleByCourseCode(
in In_CourseCode char(20))
begin
  if exists(select* from CourseSchedule where
      CourseSchedule.CourseCode = In_CourseCode) then
    delete from CourseSchedule where
      CourseSchedule.CourseCode = In_CourseCode;
    commit work
  end if
end
;

create procedure dba.DeleteCourseSkillType(
in In_CourseSkillTypeId char(20))
begin
  if exists(select* from CourseSkillType where CourseSkillType.CourseSkillTypeId = In_CourseSkillTypeId) then
    if(not exists(select* from Skill where CourseSkillTypeId = In_CourseSkillTypeId) and
      not exists(select* from course where CourseSkillTypeId = In_CourseSkillTypeId)) then
      delete from CourseSkillType where
        CourseSkillType.CourseSkillTypeId = In_CourseSkillTypeId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteEduAttachment(
in In_EduRecId integer,
in In_EduAttachSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from EduAttachment where
      EduAttachment.EduRecId = In_EduRecId and
      EduAttachment.EduAttachSysId = In_EduAttachSysId) then
    delete from EduAttachment where
      EduAttachment.EduRecId = In_EduRecId and
      EduAttachment.EduAttachSysId = In_EduAttachSysId;
    commit work;
    if exists(select* from EduAttachment where
        EduAttachment.EduRecId = In_EduRecId and
        EduAttachment.EduAttachSysId = In_EduAttachSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteEducationRec(
in In_EduRecId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from EducationRec where
      EducationRec.EduRecId = In_EduRecId) then
    if exists(select* from EduAttachment where
        EduAttachment.EduRecId = In_EduRecId) then
      delete from EduAttachment where EduAttachment.EduRecId = In_EduRecId
    end if;
    if exists(select* from EduMajor where
        EduMajor.EduRecId = In_EduRecId) then
      delete from EduMajor where EduMajor.EduRecId = In_EduRecId
    end if;
    delete from EducationRec where
      EducationRec.EduRecId = In_EduRecId;
    commit work;
    if exists(select* from EducationRec where
        EducationRec.EduRecId = In_EduRecId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteExitIntAttach(
in In_PersonalSysId integer,
in In_TenderDate date,
in In_ExitIntAttachSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from ExitIntAttach where
      ExitIntAttach.PersonalSysId = In_PersonalSysId and
      ExitIntAttach.TenderDate = In_TenderDate and
      ExitIntAttach.ExitIntAttachSysId = In_ExitIntAttachSysId) then
    delete from ExitIntAttach where
      ExitIntAttach.PersonalSysId = In_PersonalSysId and
      ExitIntAttach.TenderDate = In_TenderDate and
      ExitIntAttach.ExitIntAttachSysId = In_ExitIntAttachSysId;
    commit work;
    if exists(select* from ExitIntAttach where
        ExitIntAttach.PersonalSysId = In_PersonalSysId and
        ExitIntAttach.TenderDate = In_TenderDate and
        ExitIntAttach.ExitIntAttachSysId = In_ExitIntAttachSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteExitInterview(
in In_PersonalSysId integer,
in In_TenderDate date,
out Out_ErrorCode integer)
begin
  if exists(select* from ExitInterview where PersonalSysId = In_PersonalSysId and
      TenderDate = In_TenderDate) then
    delete from ExitIntAttach where
      ExitIntAttach.PersonalSysId = In_PersonalSysId and
      ExitIntAttach.TenderDate = In_TenderDate;
    commit work;
    delete from ExitIntDetails where
      ExitIntDetails.PersonalSysId = In_PersonalSysId and
      ExitIntDetails.TenderDate = In_TenderDate;
    commit work;
    delete from ExitInterview where
      ExitInterview.PersonalSysId = In_PersonalSysId and
      ExitInterview.TenderDate = In_TenderDate;
    commit work;
    if exists(select* from ExitInterview where PersonalSysId = In_PersonalSysId and
        TenderDate = In_TenderDate) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteFamily(
in In_FamilySysId integer,
out Out_ErrorCode integer)
begin
  declare Del_EmergencyContactOrder integer;
  declare Del_PersonalSysId integer;
  if exists(select* from Family where FamilySysId = In_FamilySysId) then
    select EmergencyContactOrder,PersonalSysId into Del_EmergencyContactOrder,Del_PersonalSysId from Family where FamilySysId = In_FamilySysId;
    delete from FamilyAttachment where
      FamilyAttachment.FamilySysId = In_FamilySysId;
    commit work;
    delete from FamilyEduRec where
      FamilyEduRec.FamilySysId = In_FamilySysId;
    commit work;
    delete from Family where
      Family.FamilySysId = In_FamilySysId;
    commit work;
    if exists(select* from Family where FamilySysId = In_FamilySysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1;
      /* Reorder EmergencyContactOrder*/
      FamilySysIdLoop: for FamilySysIdFor as Cur_FamilySysId dynamic scroll cursor for
        select Family.EmergencyContactOrder as Get_EmergencyContactOrder,Family.FamilySysId as Get_FamilySysId from
          Family where
          Family.PersonalSysId = Del_PersonalSysId and
          Family.EmergencyContactOrder > Del_EmergencyContactOrder do
        update Family set
          Family.EmergencyContactOrder = (Get_EmergencyContactOrder-1) where
          Family.FamilySysId = Get_FamilySysId;
        commit work end for
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteFamilyAttachment(
in In_FamilySysId integer,
in In_FamilyAttachSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from FamilyAttachment where
      FamilyAttachment.FamilySysId = In_FamilySysId and
      FamilyAttachment.FamilyAttachSysId = In_FamilyAttachSysId) then
    delete from FamilyAttachment where
      FamilyAttachment.FamilySysId = In_FamilySysId and
      FamilyAttachment.FamilyAttachSysId = In_FamilyAttachSysId;
    commit work;
    if exists(select* from FamilyAttachment where
        FamilyAttachment.FamilySysId = In_FamilySysId and
        FamilyAttachment.FamilyAttachSysId = In_FamilyAttachSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteFamilyEduRec(
in In_FamilyEduRecId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from FamilyEduRec where
      FamilyEduRec.FamilyEduRecId = In_FamilyEduRecId) then
    delete from FamilyEducRec where
      FamilyEducRec.FamilyEduRecId = In_FamilyEduRecId;
    commit work;
    if exists(select* from FamilyEduRec where
        FamilyEduRec.FamilyEduRecId = In_FamilyEduRecId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteForm(
in In_FormId char(20))
begin
  if(exists(select* from Form where Form.FormId = In_FormId)) then
    // Check for existing Appraisal Records
    if(not exists(select* from Appraisal where Appraisal.FormId = In_FormId)) then
      DeleteForm: for DeleteFormFor as DeleteFormCurs dynamic scroll cursor for
        select FormSecSysId as Out_FormSecSysId from
          FormSection where
          FormId = In_FormId and
          FormParentSysId = 0 do
        call ASQLFormDsnDeleteApprStruc(Out_FormSecSysId) end for;
      delete from Form where Form.FormId = In_FormId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteFormControlProperty(
in In_FormId char(20),
in In_FormSecSysId integer,
in In_FormControlId char(50))
begin
  if exists(select* from FormControlProperty where FormControlProperty.FormId = In_FormId and
      FormControlProperty.FormSecSysId = In_FormSecSysId and
      FormControlProperty.FormControlId = In_FormControlId) then
    if exists(select* from FormCtrlItem where FormCtrlItem.FormId = In_FormId and
        FormCtrlItem.FormSecSysId = In_FormSecSysId and
        FormCtrlItem.FormControlId = In_FormControlId) then
      delete from FormCtrlItem where
        FormCtrlItem.FormId = In_FormId and
        FormCtrlItem.FormSecSysId = In_FormSecSysId and
        FormCtrlItem.FormControlId = In_FormControlId
    end if;
    delete from FormControlProperty where
      FormControlProperty.FormId = In_FormId and
      FormControlProperty.FormSecSysId = In_FormSecSysId and
      FormControlProperty.FormControlId = In_FormControlId;
    commit work
  end if
end
;

create procedure dba.DeleteFormPoint(
in In_FormId char(20),
in In_FormSecSysId integer,
in In_FormPointSysId integer)
begin
  if exists(select* from FormPoint where FormPoint.FormId = In_FormId and
      FormPoint.FormSecSysId = In_FormSecSysId and
      FormPoint.FormPointSysId = In_FormPointSysId) then
    delete from FormPoint where
      FormPoint.FormId = In_FormId and
      FormPoint.FormSecSysId = In_FormSecSysId and
      FormPoint.FormPointSysId = In_FormPointSysId;
    commit work
  end if
end
;

create procedure dba.DeleteGovernmentGrant(
in In_GovernmentGrantId char(20))
begin
  if exists(select* from GovernmentGrant where
      GovernmentGrantId = In_GovernmentGrantId) then
    if(not exists(select* from Training where GovernmentGrantId = In_GovernmentGrantId) and
      not exists(select* from Trainingbatch where GovernmentGrantId = In_GovernmentGrantId)) then
      delete from GovernmentGrant where
        GovernmentGrantId = In_GovernmentGrantId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteGrade(
in In_GradeCode char(20))
begin
  if exists(select* from Grade where Grade.GradeCode = In_GradeCode) then
    if(not exists(select* from Training where GradeCode = In_GradeCode) and
      not exists(select* from AppraisalGrade where GradeCode = In_GradeCode) and
      not exists(select* from Appraisal where GradeCode = In_GradeCode) and
      not exists(select* from skilllevel where GradeCode = In_GradeCode) and
      not exists(select* from skillGrade where GradeCode = In_GradeCode) and
      not exists(select* from courseGrade where GradeCode = In_GradeCode)) then
      delete from Grade where
        Grade.GradeCode = In_GradeCode;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteHRDetails(
in In_PersonalSysId integer)
begin
  declare Out_ErrorCode integer;
  if exists(select* from HRDetails where PersonalSysId = In_PersonalSysId) then
    /*
    Delete Appraisal
    */
    AppraisalLoop: for AppraisalFor as AppraisalCurs dynamic scroll cursor for
      select AppraisalSysId as Out_AppraisalSysId from Appraisal where
        Appraisal.PersonalSysId = In_PersonalSysId do
      call DeleteAppraisal(Out_AppraisalSysId) end for;
    /*
    Delete Training
    */
    TrainingLoop: for TrainingFor as TrainingCurs dynamic scroll cursor for
      select TrainingSysId as Out_TrainingSysId from Training where
        Training.PersonalSysId = In_PersonalSysId do
      call DeleteTraining(Out_TrainingSysId) end for;
    /*
    Delete Bond
    */
    BondLoop: for BondFor as BondCurs dynamic scroll cursor for
      select BondSysId as Out_BondSysId from Bond where
        Bond.PersonalSysId = In_PersonalSysId do
      call DeleteBond(Out_BondSysId) end for;
    /*
    Delete Education
    */
    EduLoop: for EduFor as EduCurs dynamic scroll cursor for
      select EduRecId as Out_EduRecId from EducationRec where
        EducationRec.PersonalSysId = In_PersonalSysId do
      call DeleteEducationRec(Out_EduRecId,Out_ErrorCode) end for;
    /*
    Delete Family
    */
    EduLoop: for FamilyFor as FamilyCurs dynamic scroll cursor for
      select FamilySysId as Out_FamilySysId from Family where
        Family.PersonalSysId = In_PersonalSysId do
      call DeleteFamily(Out_FamilySysId,Out_ErrorCode) end for;
    /*
    Delete Award/Discipline
    */
    AwardDiscLoop: for AwardDiscFor as AwardDiscCurs dynamic scroll cursor for
      select AwardDiscSysId as Out_AwardDiscSysId from AwardDisc where
        AwardDisc.PersonalSysId = In_PersonalSysId do
      call DeleteAwardDisc(Out_AwardDiscSysId,Out_ErrorCode) end for;
    /*
    Delete Job History
    */
    JobHisLoop: for JobHisFor as JobHisCurs dynamic scroll cursor for
      select EmployedDate as Out_EmployedDate from JobHistory where
        JobHistory.PersonalSysId = In_PersonalSysId do
      call DeleteJobHistory(In_PersonalSysId,Out_EmployedDate,Out_ErrorCode) end for;
    /*
    Delete Medical History
    */
    MediHisLoop: for MediHisFor as MediHisCurs dynamic scroll cursor for
      select IllnessId as Out_IllnessId from MediHistory where
        MediHistory.PersonalSysId = In_PersonalSysId do
      call DeleteMediHistory(Out_IllnessId,In_PersonalSysId,Out_ErrorCode) end for;
    /*
    Delete Item Assign
    */
    ItemAssignLoop: for ItemAssignFor as ItemAssignCurs dynamic scroll cursor for
      select ItemAssignItemSysId as Out_ItemAssignItemSysId from ItemAssignItem where
        ItemAssignItem.PersonalSysId = In_PersonalSysId do
      call DeleteItemAssignItem(Out_ItemAssignItemSysId,Out_ErrorCode) end for;
    /*
    Delete Membership
    */
    MemshipLoop: for MemshipFor as MemshipCurs dynamic scroll cursor for
      select MemSysId as Out_MemSysId from Memship where
        Memship.PersonalSysId = In_PersonalSysId do
      call DeleteMemship(Out_MemSysId,Out_ErrorCode) end for;
    /*
    Delete HRTest
    */
    HRTestLoop: for HRTestFor as HRTestCurs dynamic scroll cursor for
      select HRTestSysId as Out_HRTestSysId from HRTest where
        HRTest.PersonalSysId = In_PersonalSysId do
      call DeleteHRTestRecord(Out_HRTestSysId,Out_ErrorCode) end for;
    /*
    Delete ExitInterview
    */
    ExitInterviewLoop: for ExitInterviewFor as ExitInterviewCurs dynamic scroll cursor for
      select TenderDate as Out_TenderDate from ExitInterview where
        ExitInterview.PersonalSysId = In_PersonalSysId do
      call DeleteExitInterview(In_PersonalSysId,Out_TenderDate,Out_ErrorCode) end for;
    /*
    Delete Recruitment
    */
    RecruitLoop: for RecruitFor as RecruitCurs dynamic scroll cursor for
      select ApplicantSysId as Out_ApplicantSysId from Applicant where
        Applicant.PersonalSysId = In_PersonalSysId do
      call DeleteApplicant(Out_ApplicantSysId,Out_ErrorCode) end for;
    /*
    Delete Medical Examination
    */
    MediExLoop: for MediExFor as MediExCurs dynamic scroll cursor for
      select MedExRecSysId as Out_MedExRecSysId from MedExRec where
        MedExRec.PersonalSysId = In_PersonalSysId do
      call DeleteMedExRec(Out_MedExRecSysId,Out_ErrorCode) end for;
    call DeleteMedClaimByPersonalSysId(In_PersonalSysId);
    delete from MClaimPolicyFolder where PersonalSysId = In_PersonalSysId;
    delete from SkillLevel where PersonalSysId = In_PersonalSysId;
    delete from CWorker where PersonalSysId = In_PersonalSysId;
    delete from HRDetails where HRDetails.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.DeleteHRFormula(
in In_HRFormulaId char(20))
begin
  if exists(select* from HRFormulaRange where
      HRFormulaRangeId = 1 and HRFormulaId = In_HRFormulaId) then
    delete from HRFormulaRange where
      HRFormulaRangeId = 1 and HRFormulaId = In_HRFormulaId
  end if;
  if exists(select* from HRFormula where
      HRFormulaId = In_HRFormulaId) then
    delete from HRFormula where
      HRFormulaId = In_HRFormulaId
  end if;
  commit work
end
;

create procedure dba.DeleteHRFormulaRange(
in In_HRFormulaRangeId integer,
in In_HRFormulaId char(20))
begin
  if exists(select* from HRFormulaRange where
      HRFormulaRangeId = In_HRFormulaRangeId and HRFormulaId = In_HRFormulaId) then
    delete from HRFormulaRange where
      HRFormulaRangeId = In_HRFormulaRangeId and HRFormulaId = In_HRFormulaId;
    commit work
  end if
end
;

create procedure dba.DeleteHRKeyword(
in In_HRKeywordId char(20))
begin
  if exists(select* from HRKeyword where
      HRKeywordId = In_HRKeywordId) then
    delete from HRKeyword where
      HRKeywordId = In_HRKeywordId;
    commit work
  end if
end
;

create procedure dba.DeleteHRProjectAllAttach(
in In_ProjectId char(20),
out ErrorCode integer)
begin
  if exists(select* from ProjAttachment where
      ProjectId = In_ProjectId) then
    delete from ProjAttachment where
      ProjectId = In_ProjectId;
    commit work
  end if
end
;

create procedure dba.DeleteHRProjectAllTeam(
in In_ProjectId char(20),
out ErrorCode integer)
begin
  if exists(select* from ProjContractWorker where
      ProjectId = In_ProjectId) then
    delete from ProjContractWorker where
      ProjectId = In_ProjectId;
    commit work
  end if
end
;

create procedure dba.DeleteHRProjectRecord(
in In_ProjectId char(20),
out ErrorCode integer)
begin
  if exists(select* from Project where
      ProjectId = In_ProjectId) then
    call DeleteHRProjectAllAttach(In_ProjectId,ErrorCode);
    commit work;
    delete from ProjCostRec where ProjectId = In_ProjectId;
    commit work;
    call DeleteHRProjectAllTeam(In_ProjectId,ErrorCode);
    commit work;
    delete from Project where
      ProjectId = In_ProjectId;
    commit work;
    set ErrorCode=1
  end if
end
;

create procedure dba.DeleteHRProjectSingleAttach(
in In_ProjectId char(20),
in In_ProjAttachSysId integer,
out ErrorCode integer)
begin
  if exists(select* from ProjAttachment where
      ProjectId = In_ProjectId and
      ProjAttachSysId = In_ProjAttachSysId) then
    delete from ProjAttachment where
      ProjectId = In_ProjectId and
      ProjAttachSysId = In_ProjAttachSysId;
    commit work;
    set ErrorCode=1
  end if
end
;

create procedure dba.DeleteHRProjectSingleWorker(
in In_ProjContractWorkerSysId integer,
out ErrorCode integer)
begin
  if exists(select* from ProjContractWorker where
      ProjContractWorkerSysId = In_ProjContractWorkerSysId) then
    delete from ProjContractWorker where
      ProjContractWorkerSysId = In_ProjContractWorkerSysId;
    commit work;
    set ErrorCode=1
  end if
end
;

create procedure dba.DeleteHRTestAllAttach(
in In_HRTestSysId integer,
out ErrorCode integer)
begin
  if exists(select* from HRTestAttach where
      HRTestSysId = In_HRTestSysId) then
    delete from HRTestAttach where
      HRTestSysId = In_HRTestSysId;
    commit work;
    set ErrorCode=1
  end if
end
;

create procedure dba.DeleteHRTestRecord(
in In_HRTestSysId integer,
out ErrorCode integer)
begin
  if exists(select* from HRTest where
      HRTestSysId = In_HRTestSysId) then
    call DeleteHRTestAllAttach(In_HRTestSysId,ErrorCode);
    commit work;
    delete from HRTest where
      HRTestSysId = In_HRTestSysId;
    commit work;
    set ErrorCode=1
  end if
end
;

create procedure dba.DeleteHRTestSingleAttach(
in In_HRTestSysId integer,
in In_HRTestAttachSysId integer,
out ErrorCode integer)
begin
  if exists(select* from HRTestAttach where
      HRTestSysId = In_HRTestSysId and
      HRTestAttachSysId = In_HRTestAttachSysId) then
    delete from HRTestAttach where
      HRTestSysId = In_HRTestSysId and
      HRTestAttachSysId = In_HRTestAttachSysId;
    commit work;
    set ErrorCode=1
  end if
end
;

create procedure dba.DeleteIllness(
in In_IllnessId char(50))
begin
  if exists(select* from Illness where
      Illness.IllnessId = In_IllnessId) then
    if not exists(select* from MedClaim where
        MedClaim.IllnessId = In_IllnessId) then
      if not exists(select* from MediHistory where
          MediHistory.IllnessId = In_IllnessId) then
        delete from Illness where
          Illness.IllnessId = In_IllnessId;
        commit work
      end if
    end if
  end if
end
;

create procedure dba.DeleteInterviewer(
in In_InterviewerSysId integer,
in In_InterviewSchSysId integer,
in In_KeyInterviewer smallint,
out Out_ErrorCode integer)
begin
  declare Out_InterviewerSysId integer;
  if exists(select* from Interviewer where InterviewerSysId = In_InterviewerSysId) then
    if In_KeyInterviewer = 1 then
      if exists(select* from Interviewer where InterviewSchSysId = In_InterviewSchSysId and InterviewerSysId <> In_InterviewerSysId) then
        select max(InterviewerSysId) into Out_InterviewerSysId from Interviewer where InterviewSchSysId = In_InterviewSchSysId and InterviewerSysId <> In_InterviewerSysId;
        update Interviewer set KeyInterviewer = 1 where InterviewerSysId = Out_InterviewerSysId;
        commit work
      end if
    end if;
    delete from Interviewer where
      Interviewer.InterviewerSysId = In_InterviewerSysId;
    commit work;
    if exists(select* from Interviewer where InterviewerSysId = In_InterviewerSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteInterviewSchedule(
in In_InterviewSchSysId integer,
out Out_ErrorCode integer)
begin
  declare Del_InterviewOrder integer;
  declare Del_ApplicantSysId integer;
  if exists(select* from InterviewSchedule where InterviewSchSysId = In_InterviewSchSysId) then
    select InterviewOrder,ApplicantSysId into Del_InterviewOrder,Del_ApplicantSysId from InterviewSchedule where InterviewSchSysId = In_InterviewSchSysId;
    delete from Interviewer where
      Interviewer.InterviewSchSysId = In_InterviewSchSysId;
    commit work;
    delete from InterviewSchedule where
      InterviewSchedule.InterviewSchSysId = In_InterviewSchSysId;
    commit work;
    if exists(select* from InterviewSchedule where InterviewSchSysId = In_InterviewSchSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1;
      /* Reorder InterviewOrder*/
      InterviewSchSysIdLoop: for InterviewSchSysIdFor as Cur_InterviewSchSysId dynamic scroll cursor for
        select InterviewSchedule.InterviewOrder as Get_InterviewOrder,InterviewSchedule.InterviewSchSysId as Get_InterviewSchSysId from
          InterviewSchedule where
          InterviewSchedule.ApplicantSysId = Del_ApplicantSysId and
          InterviewSchedule.InterviewOrder > Del_InterviewOrder do
        update InterviewSchedule set
          InterviewSchedule.InterviewOrder = (Get_InterviewOrder-1) where
          InterviewSchedule.InterviewSchSysId = Get_InterviewSchSysId;
        commit work end for
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteItem(
in In_ItemId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from Item where ItemId = In_ItemId) then
    if exists(select* from ItemAssignItem where ItemId = In_ItemId) then
      set Out_ErrorCode=-1;
      return
    end if;
    if exists(select* from ItemBAssgn where ItemId = In_ItemId) then
      set Out_ErrorCode=-1;
      return
    end if;
    delete from ItemAttrValue where ItemId = In_ItemId;
    delete from Item where ItemId = In_ItemId;
    commit work;
    if exists(select* from Item where ItemId = In_ItemId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteItemAssignItem(
in In_ItemAssignItemSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from ItemAssignItem where ItemAssignItemSysId = In_ItemAssignItemSysId) then
    delete from ItemAssignAttr where ItemAssignItemSysId = In_ItemAssignItemSysId;
    delete from ItemAssignItem where ItemAssignItemSysId = In_ItemAssignItemSysId;
    commit work;
    if exists(select* from ItemAssignItem where ItemAssignItemSysId = In_ItemAssignItemSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteItemAttrName(
in In_ItemAttrNameId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from ItemAttrName where ItemAttrNameId = In_ItemAttrNameId) then
    if(not exists(select* from ItemAttrValue where ItemAttrNameId = In_ItemAttrNameId) and
      not exists(select* from ItemAssignAttr where ItemAttrNameId = In_ItemAttrNameId) and
      not exists(select* from ItemBAssignAttr where ItemAttrNameId = In_ItemAttrNameId)) then
      delete from ItemAttrName where ItemAttrName.ItemAttrNameId = In_ItemAttrNameId;
      commit work
    end if;
    if exists(select* from ItemAttrName where ItemAttrNameId = In_ItemAttrNameId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteItemAttrValue(
in In_ItemAttrValueSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from ItemAttrValue where ItemAttrValueSysId = In_ItemAttrValueSysId) then
    if exists(select* from ItemAssignItem where ItemId = (select ItemId from ItemAttrValue where ItemAttrValueSysId = In_ItemAttrValueSysId)) then
      if(select ItemAttrType from ItemAttrValue where ItemAttrValueSysId = In_ItemAttrValueSysId) <> 'ItemAttrTypeStr' then
        set Out_ErrorCode=-1;
        return
      end if
    end if;
    if exists(select* from ItemBAssgn where ItemId = (select ItemId from ItemAttrValue where ItemAttrValueSysId = In_ItemAttrValueSysId)) then
      if(select ItemAttrType from ItemAttrValue where ItemAttrValueSysId = In_ItemAttrValueSysId) <> 'ItemAttrTypeStr' then
        set Out_ErrorCode=-1;
        return
      end if
    end if;
    if
      exists(select* from
        ItemAttrValue,ItemAssignAttr where
        ItemAttrValue.ItemAttrNameId = ItemAssignAttr.ItemAttrNameId and
        ItemAttrValue.ItemAttrType = ItemAssignAttr.ItemAttrType and
        ItemAttrValue.ItemAttrStrValue = ItemAssignAttr.ItemAttrStrValue and
        ItemAttrValue.ItemId = (select ItemId from ItemAssignItem where ItemAssignItemSysID = ItemAssignAttr.ItemAssignItemSysID) and
        ItemAttrValueSysId = In_ItemAttrValueSysId) then
      set Out_ErrorCode=-1;
      return
    end if;
    if
      exists(select* from
        ItemAttrValue,ItemBAssignAttr where
        ItemAttrValue.ItemAttrNameId = ItemBAssignAttr.ItemAttrNameId and
        ItemAttrValue.ItemAttrType = ItemBAssignAttr.ItemAttrType and
        ItemAttrValue.ItemAttrStrValue = ItemBAssignAttr.ItemAttrStrValue and
        ItemAttrValue.ItemId = (select ItemId from ItemBAssgn where ItemBAssignSysID = ItemBAssignAttr.ItemBAssignSysID) and
        ItemAttrValueSysId = In_ItemAttrValueSysId) then
      set Out_ErrorCode=-1;
      return
    end if;
    delete from ItemAttrValue where ItemAttrValueSysId = In_ItemAttrValueSysId;
    commit work;
    if exists(select* from ItemAttrValue where ItemAttrValueSysId = In_ItemAttrValueSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteItemBAssgn(
in In_ItemBAssignSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from ItemBAssgn where ItemBAssignSysId = In_ItemBAssignSysId) then
    delete from ItemBAssignAttr where ItemBAssignSysId = In_ItemBAssignSysId;
    delete from ItemBAssgn where ItemBAssignSysId = In_ItemBAssignSysId;
    commit work;
    if exists(select* from ItemBAssgn where ItemBAssignSysId = In_ItemBAssignSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteItemBatch(
in In_ItemBatchId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from ItemBatch where ItemBatchId = In_ItemBatchId) then
    /*
    if exists(select* from ItemBAssgn where ItemBatchId = In_ItemBatchId) then
    set Out_ErrorCode=-1;
    return
    end if;*/
    ItemBAssignSysIdLoop: for ItemBAssignSysIdFor as Cur_ItemBAssignSysId dynamic scroll cursor for
      select distinct ItemBAssgn.ItemBAssignSysId as Get_ItemBAssignSysId from
        ItemBAssgn where
        ItemBAssgn.ItemBatchId = In_ItemBatchId do
      call DeleteItemBAssgn(Get_ItemBAssignSysId,0);
      commit work end for;
    delete from ItemBatch where ItemBatchId = In_ItemBatchId;
    commit work;
    if exists(select* from ItemBatch where ItemBatchId = In_ItemBatchId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteItemType(
in In_ItemTypeId char(20))
begin
  if exists(select* from ItemType where
      ItemTypeId = In_ItemTypeId) then
    if not exists(select* from Item where ItemTypeId = In_ItemTypeId) then
      delete from ItemType where
        ItemTypeId = In_ItemTypeId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteJobAdAttach(
in In_RecruitCode char(20),
in In_JobAdAttachSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from JobAdAttach where
      JobAdAttach.RecruitCode = In_RecruitCode and
      JobAdAttach.JobAdAttachSysId = In_JobAdAttachSysId) then
    delete from JobAdAttach where
      JobAdAttach.RecruitCode = In_RecruitCode and
      JobAdAttach.JobAdAttachSysId = In_JobAdAttachSysId;
    commit work;
    if exists(select* from JobAdAttach where
        JobAdAttach.RecruitCode = In_RecruitCode and
        JobAdAttach.JobAdAttachSysId = In_JobAdAttachSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteJobGrade(
in In_JobGrade char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from JobGrade where JobGrade = In_JobGrade) then
    if not exists(select* from JobHistory where JobGrade = In_JobGrade) then
      delete from JobGrade where JobGrade = In_JobGrade;
      commit work
    end if;
    if exists(select* from JobGrade where JobGrade = In_JobGrade) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteJobHistory(
in In_PersonalSysId integer,
in In_EmployedDate date,
out Out_ErrorCode integer)
begin
  if exists(select* from JobHistory where PersonalSysId = In_PersonalSysId and
      EmployedDate = In_EmployedDate) then
    delete from JobHisRespon where
      JobHisRespon.PersonalSysId = In_PersonalSysId and JobHisRespon.EmployedDate = In_EmployedDate;
    commit work;
    delete from JobHistory where
      JobHistory.PersonalSysId = In_PersonalSysId and JobHistory.EmployedDate = In_EmployedDate;
    commit work;
    if exists(select* from JobHistory where PersonalSysId = In_PersonalSysId and
        EmployedDate = In_EmployedDate) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteJobOpenTo(
in In_JobOpenToId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from JobOpenTo where JobOpenToId = In_JobOpenToId) then
    if(not exists(select* from RecruitPosOpenTo where JobOpenToId = In_JobOpenToId)) then
      delete from JobOpenTo where JobOpenTo.JobOpenToId = In_JobOpenToId;
      commit work
    end if;
    if exists(select* from JobOpenTo where JobOpenToId = In_JobOpenToId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteJobResponsibility(
in In_ResponsibilityId char(20),
in In_EmployeeSysId integer,
in In_JobResponEffectiveDate date,
out Out_ErrorCode integer)
begin
  if not exists(select* from JobRespon where JobRespon.ResponsibilityId = In_ResponsibilityId and JobRespon.EmployeeSysId = In_EmployeeSysId and JobRespon.JobResponEffectiveDate = In_JobResponEffectiveDate) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    delete from JobRespon where
      JobRespon.ResponsibilityId = In_ResponsibilityId and
      JobRespon.EmployeeSysId = In_EmployeeSysId and
      JobRespon.JobResponEffectiveDate = In_JobResponEffectiveDate;
    commit work
  end if;
  if exists(select* from JobRespon where JobRespon.ResponsibilityId = In_ResponsibilityId and JobRespon.EmployeeSysId = In_EmployeeSysId and JobRespon.JobResponEffectiveDate = In_JobResponEffectiveDate) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.DeleteMClaimAttachment(
in In_MedClaimAttachSysId integer)
begin
  if exists(select* from MClaimAttachment where
      MClaimAttachment.MedClaimAttachSysId = In_MedClaimAttachSysId) then
    delete from MClaimAttachment where
      MClaimAttachment.MedClaimAttachSysId = In_MedClaimAttachSysId;
    commit work
  end if
end
;

create procedure dba.DeleteMClaimPolicy(
in In_MedClaimPolicyId char(20))
begin
  if exists(select* from MClaimCycle where
      MClaimCycle.MedClaimPolicyId = In_MedClaimPolicyId) then
    delete from MClaimCycle where
      MClaimCycle.MedClaimPolicyId = In_MedClaimPolicyId
  end if;
  if exists(select* from MClaimPolicyRec where
      MClaimPolicyRec.MedClaimPolicyId = In_MedClaimPolicyId) then
    delete from MClaimPolicyRec where
      MClaimPolicyRec.MedClaimPolicyId = In_MedClaimPolicyId
  end if;
  if exists(select* from MClaimPolicy where
      MClaimPolicy.MedClaimPolicyId = In_MedClaimPolicyId) then
    delete from MClaimPolicy where
      MClaimPolicy.MedClaimPolicyId = In_MedClaimPolicyId
  end if;
  commit work
end
;

create procedure dba.DeleteMClaimPolicyRec(
in In_MedClaimPolicySysId integer)
begin
  if exists(select* from MClaimPolicyRec where
      MClaimPolicyRec.MedClaimPolicySysId = In_MedClaimPolicySysId) then
    delete from MClaimPolicyRec where
      MClaimPolicyRec.MedClaimPolicySysId = In_MedClaimPolicySysId;
    commit work
  end if
end
;

create procedure dba.DeleteMClaimReason(
in In_MedClaimReasonId char(50))
begin
  if exists(select* from MClaimReason where
      MClaimReason.MedClaimReasonId = In_MedClaimReasonId) then
    if not exists(select* from MedClaim where
        MedClaim.MedClaimReasonId = In_MedClaimReasonId) then
      delete from MClaimReason where
        MClaimReason.MedClaimReasonId = In_MedClaimReasonId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteMClaimType(
in In_MedClaimTypeId char(20))
begin
  if exists(select* from MClaimTypeRange where
      MClaimTypeRange.MedClaimTypeId = In_MedClaimTypeId) then
    delete from MClaimTypeRange where
      MClaimTypeRange.MedClaimTypeId = In_MedClaimTypeId
  end if;
  if exists(select* from MClaimType where
      MClaimType.MedClaimTypeId = In_MedClaimTypeId) then
    delete from MClaimType where
      MClaimType.MedClaimTypeId = In_MedClaimTypeId
  end if;
  commit work
end
;

create procedure dba.DeleteMClaimTypeRange(
in In_MedClaimTypeSysId integer,
in In_MedClaimTypeId char(20))
begin
  if exists(select* from MClaimTypeRange where
      MClaimTypeRange.MedClaimTypeSysId = In_MedClaimTypeSysId and MClaimTypeRange.MedClaimTypeId = In_MedClaimTypeId) then
    delete from MClaimTypeRange where
      MClaimTypeRange.MedClaimTypeSysId = In_MedClaimTypeSysId and MClaimTypeRange.MedClaimTypeId = In_MedClaimTypeId;
    commit work
  end if
end
;

create procedure dba.DeleteMedClaim(
in In_MedClaimSysId integer)
begin
  if exists(select* from MedClaim where
      MedClaim.MedClaimSysId = In_MedClaimSysId) then
    delete from MedClaimHistory where
      MedClaimSysId = In_MedClaimSysId;
    delete from MClaimAttachment where
      MedClaimSysId = In_MedClaimSysId;
    delete from MedClaim where
      MedClaimSysId = In_MedClaimSysId;
    commit work
  end if
end
;

create procedure dba.DeleteMedClaimByPersonalSysId(
in In_PersonalSysId integer)
begin
  DeleteMedClaimLoop: for DeleteMedClaimFor as curs dynamic scroll cursor for
    select MedClaimSysId from MedClaim where PersonalSysId = In_PersonalSysId do
    call DeleteMedClaim(MedClaimSysId) end for;
  commit work
end
;

create procedure dba.DeleteMedClaimHistory(
in In_MedClaimSysId integer)
begin
  if exists(select* from MedClaimHistory where
      MedClaimHistory.MedClaimSysId = In_MedClaimSysId) then
    delete from MedClaimHistory where
      MedClaimHistory.MedClaimSysId = In_MedClaimSysId;
    commit work
  end if
end
;

create procedure dba.DeleteMedExDetType(
in In_MedExDetTypeId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from MedExDetType where MedExDetTypeId = In_MedExDetTypeId) then
    if not exists(select* from MedExDet where MedExDetTypeId = In_MedExDetTypeId) then
      delete from MedExDetType where MedExDetTypeId = In_MedExDetTypeId;
      commit work
    end if;
    if exists(select* from MedExDetType where MedExDetTypeId = In_MedExDetTypeId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteMedExRec(
in In_MedExRecSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MedExRec where
      MedExRec.MedExRecSysId = In_MedExRecSysId) then
    if exists(select* from MedExDet where
        MedExDet.MedExRecSysId = In_MedExRecSysId) then
      delete from MedExDet where MedExDet.MedExRecSysId = In_MedExRecSysId
    end if;
    if exists(select* from ReviewAttachment where
        ReviewAttachment.MedExRecSysId = In_MedExRecSysId) then
      delete from ReviewAttachment where ReviewAttachment.MedExRecSysId = In_MedExRecSysId
    end if;
    delete from MedExRec where
      MedExRec.MedExRecSysId = In_MedExRecSysId;
    commit work;
    if exists(select* from MedExRec where
        MedExRec.MedExRecSysId = In_MedExRecSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteMedia(
in In_MediaId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from Media where MediaId = In_MediaId) then
    if(not exists(select* from JobAdvertise where MediaId = In_MediaId) and
      not exists(select* from Applicant where MediaId = In_MediaId)) then
      delete from Media where Media.MediaId = In_MediaId;
      commit work
    end if;
    if exists(select* from Media where MediaId = In_MediaId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteMediHistory(
in In_IllnessId char(50),
in In_PersonalSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MediHistory where IllnessId = In_IllnessId and PersonalSysId = In_PersonalSysId) then
    delete from MediHistoryAttach where
      MediHistoryAttach.IllnessId = In_IllnessId and MediHistoryAttach.PersonalSysId = In_PersonalSysId;
    commit work;
    delete from MediHistory where
      MediHistory.IllnessId = In_IllnessId and MediHistory.PersonalSysId = In_PersonalSysId;
    commit work;
    if exists(select* from MediHistory where IllnessId = In_IllnessId and PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteMediHistoryAttach(
in In_IllnessId char(50),
in In_PersonalSysId integer,
in In_MediHistoryAttachSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from MediHistoryAttach where
      MediHistoryAttach.IllnessId = In_IllnessId and
      MediHistoryAttach.PersonalSysId = In_PersonalSysId and
      MediHistoryAttach.MediHistoryAttachSysId = In_MediHistoryAttachSysId) then
    delete from MediHistoryAttach where
      MediHistoryAttach.IllnessId = In_IllnessId and
      MediHistoryAttach.PersonalSysId = In_PersonalSysId and
      MediHistoryAttach.MediHistoryAttachSysId = In_MediHistoryAttachSysId;
    commit work;
    if exists(select* from MediHistoryAttach where
        MediHistoryAttach.IllnessId = In_IllnessId and
        MediHistoryAttach.PersonalSysId = In_PersonalSysId and
        MediHistoryAttach.MediHistoryAttachSysId = In_MediHistoryAttachSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteMembershipCode(
in In_OrganisationCode char(20),
in In_MembershipCode char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from MembershipCode where OrganisationCode = In_OrganisationCode and
      MembershipCode = In_MembershipCode) then
    if not exists(select* from Memship where MembershipCode = In_MembershipCode) then
      delete from MembershipCode where OrganisationCode = In_OrganisationCode and
        MembershipCode = In_MembershipCode;
      commit work
    end if;
    if exists(select* from MembershipCode where OrganisationCode = In_OrganisationCode and
        MembershipCode = In_MembershipCode) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteMemship(
in In_MemSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from Memship where MemSysId = In_MemSysId) then
    delete from Memship where
      Memship.MemSysId = In_MemSysId;
    commit work;
    if exists(select* from Memship where MemSysId = In_MemSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteOffenceType(
in In_OffenceType char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from OffenceType where OffenceType = In_OffenceType) then
    if not exists(select* from AwardDisc where OffenceType = In_OffenceType) then
      delete from OffenceType where OffenceType = In_OffenceType;
      commit work
    end if;
    if exists(select* from OffenceType where OffenceType = In_OffenceType) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteOrganisation(
in In_OrganisationCode char(20))
begin
  if exists(select* from Organisation where Organisation.OrganisationCode = In_OrganisationCode) then
    if(not exists(select* from Venue where Venue.OrganisationCode = In_OrganisationCode) and
      not exists(select* from CourseSchedule where CourseSchedule.OrganisationCode = In_OrganisationCode) and
      not exists(select* from MedExDet where MedExDet.OrganisationCode = In_OrganisationCode) and
      not exists(select* from JobAdvertise where JobAdvertise.OrganisationCode = In_OrganisationCode) and
      not exists(select* from MembershipCode where MembershipCode.OrganisationCode = In_OrganisationCode) and
      not exists(select* from Item where Item.OrganisationCode = In_OrganisationCode) and
      not exists(select* from JobAdvertise where JobAdvertise.OrganisationCode = In_OrganisationCode) and
      not exists(select* from MedClaim where MedClaim.Vendor = In_OrganisationCode) and not exists(select* from MedClaim where MedClaim.HospitalClinic = In_OrganisationCode)) then
      delete from CWorker where CWorker.OrganisationCode = In_OrganisationCode;
      delete from Specialised where Specialised.OrganisationCode = In_OrganisationCode;
      delete from Organisation where Organisation.OrganisationCode = In_OrganisationCode;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteOrganisationIndustry(
in In_OrgIndustryId char(20))
begin
  if exists(select* from OrganisationIndustry where
      OrganisationIndustry.OrgIndustryId = In_OrgIndustryId) then
    delete from OrganisationIndustry where
      OrganisationIndustry.OrgIndustryId = In_OrgIndustryId;
    commit work
  end if
end
;

create procedure dba.DeleteOrganisationType(
in In_OrgIndustryId char(20),
in In_OrgTypeId char(20))
begin
  if exists(select* from OrganisationType where
      OrganisationType.OrgIndustryId = In_OrgIndustryId and
      OrganisationType.OrgTypeId = In_OrgTypeId) then
    if not exists(select* from Organisation where
        Organisation.OrgIndustryId = In_OrgIndustryId and
        Organisation.OrgTypeId = In_OrgTypeId) then
      delete from OrganisationType where
        OrganisationType.OrgIndustryId = In_OrgIndustryId and
        OrganisationType.OrgTypeId = In_OrgTypeId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteOrganiser(
in In_OrganisationCode char(20),
in In_OrgIndustryId char(20))
begin
  if exists(select* from Organiser where Organiser.OrganisationCode = In_OrganisationCode and
      Organiser.OrgIndustryId = In_OrgIndustryId) then
    delete from Organiser where Organiser.OrganisationCode = In_OrganisationCode and
      Organiser.OrgIndustryId = In_OrgIndustryId;
    commit work
  end if
end
;

create procedure dba.DeleteOrgCWorker(
in In_OrganisationCode char(20),
in In_PersonalSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from CWorker where
      CWorker.OrganisationCode = In_OrganisationCode and
      CWorker.PersonalSysId = In_PersonalSysId) then
    delete from CWorker where
      CWorker.OrganisationCode = In_OrganisationCode and
      CWorker.PersonalSysId = In_PersonalSysId;
    commit work;
    if exists(select* from CWorker where
        CWorker.OrganisationCode = In_OrganisationCode and
        CWorker.PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteProjCostType(
in In_ProjectCostTypeId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from ProjCostType where ProjectCostTypeId = In_ProjectCostTypeId) then
    if not exists(select* from ProjCostRec where ProjectCostTypeId = In_ProjectCostTypeId) then
      delete from ProjCostType where ProjectCostTypeId = In_ProjectCostTypeId;
      commit work
    end if;
    if exists(select* from ProjCostType where ProjectCostTypeId = In_ProjectCostTypeId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteRecruitPosition(
in In_RecruitCode char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from RecruitPosition where RecruitCode = In_RecruitCode) then
    delete from JobAdAttach where
      JobAdAttach.RecruitCode = In_RecruitCode;
    commit work;
    delete from RecruitPosOpenTo where
      RecruitPosOpenTo.RecruitCode = In_RecruitCode;
    commit work;
    delete from RecruitInterviewer where
      RecruitInterviewer.RecruitCode = In_RecruitCode;
    commit work;
    delete from JobAdvertise where
      JobAdvertise.RecruitCode = In_RecruitCode;
    commit work;
    /*
    Delete Applicant
    */
    ApplicantLoop: for ApplicantFor as ApplicantCurs dynamic scroll cursor for
      select ApplicantSysId as Out_ApplicantSysId from Applicant where
        Applicant.RecruitCode = In_RecruitCode do
      call DeleteApplicant(Out_ApplicantSysId,Out_ErrorCode) end for;
    delete from RecruitPosition where
      RecruitPosition.RecruitCode = In_RecruitCode;
    commit work;
    if exists(select* from RecruitPosition where RecruitCode = In_RecruitCode) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteReviewAttachment(
in In_MedExRecSysId integer,
in In_ReviewAttachSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from ReviewAttachment where
      ReviewAttachment.MedExRecSysId = In_MedExRecSysId and
      ReviewAttachment.ReviewAttachSysId = In_ReviewAttachSysId) then
    delete from ReviewAttachment where
      ReviewAttachment.MedExRecSysId = In_MedExRecSysId and
      ReviewAttachment.ReviewAttachSysId = In_ReviewAttachSysId;
    commit work;
    if exists(select* from ReviewAttachment where
        ReviewAttachment.MedExRecSysId = In_MedExRecSysId and
        ReviewAttachment.ReviewAttachSysId = In_ReviewAttachSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteReviewType(
in In_ReviewTypeId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from ReviewType where ReviewTypeId = In_ReviewTypeId) then
    if not exists(select* from MedExRec where ReviewTypeId = In_ReviewTypeId) then
      delete from ReviewType where ReviewTypeId = In_ReviewTypeId;
      commit work
    end if;
    if exists(select* from ReviewType where ReviewTypeId = In_ReviewTypeId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteSkill(
in In_SkillCode char(20))
begin
  if exists(select* from Skill where Skill.SkillCode = In_SkillCode) then
    if(not exists(select* from CourseSkill where CourseSkill.SkillCode = In_SkillCode) and
      not exists(select* from SkillLevel where SkillLevel.SkillCode = In_SkillCode)) then
      call DeleteSkillGradeBySkillCode(In_SkillCode);
      delete from Skill where
        Skill.SkillCode = In_SkillCode;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteSkillGrade(
in In_SkillCode char(20),
in In_GradeCode char(20))
begin
  if exists(select* from SkillGrade where
      SkillGrade.SkillCode = In_SkillCode and
      SkillGrade.GradeCode = In_GradeCode) then
    delete from SkillGrade where
      SkillGrade.SkillCode = In_SkillCode and
      SkillGrade.GradeCode = In_GradeCode;
    commit work
  end if
end
;

create procedure dba.DeleteSkillGradeBySkillCode(
in In_SkillCode char(20))
begin
  if exists(select* from SkillGrade where
      SkillGrade.SkillCode = In_SkillCode) then
    delete from SkillGrade where
      SkillGrade.SkillCode = In_SkillCode;
    commit work
  end if
end
;

create procedure dba.DeleteSkillLevel(
in In_PersonalSysId integer,
in In_SkillCode char(20),
in In_SkillEffectiveDate date)
begin
  if exists(select* from SkillLevel where
      SkillLevel.PersonalSysId = In_PersonalSysId and
      SkillLevel.SkillCode = In_SkillCode and
      SkillLevel.SkillEffectiveDate = In_SkillEffectiveDate) then
    delete from SkillLevel where
      SkillLevel.PersonalSysId = In_PersonalSysId and
      SkillLevel.SkillCode = In_SkillCode and
      SkillLevel.SkillEffectiveDate = In_SkillEffectiveDate;
    commit work
  end if
end
;

create procedure dba.DeleteSkillLevelByPersonalSysID(
in In_PersonalSysId integer)
begin
  if exists(select* from SkillLevel where
      SkillLevel.PersonalSysId = In_PersonalSysId) then
    delete from SkillLevel where
      SkillLevel.PersonalSysId = In_PersonalSysId;
    commit work
  end if
end
;

create procedure dba.DeleteSponsorGrant(
in In_SponsorGrantCode char(20))
begin
  if exists(select* from SponsorGrant where SponsorGrant.SponsorGrantCode = In_SponsorGrantCode) then
    delete from SponsorGrant where
      SponsorGrant.SponsorGrantCode = In_SponsorGrantCode;
    commit work
  end if
end
;

create procedure dba.DeleteSponsorship(
in In_SponsorshipCode char(20))
begin
  if exists(select* from Sponsorship where SponsorshipCode = In_SponsorshipCode) then
    if(not exists(select* from Training where SponsorshipCode = In_SponsorshipCode) and
      not exists(select* from Trainingbatch where SponsorshipCode = In_SponsorshipCode)) then
      delete from Sponsorship where
        SponsorshipCode = In_SponsorshipCode;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteSuccession(
in In_EmployeeSysId integer,
in In_ScessorEmployeeId integer,
in In_ScessType char(20),
out Out_ErrorCode integer)
begin
  declare CurrentSuccessionOrder integer;
  if not exists(select* from Succession where EmployeeSysId = In_EmployeeSysId and ScessorEmployeeId = In_ScessorEmployeeId and ScessType = In_ScessType) then
    set Out_ErrorCode=-1; // Record not exist
    return
  else
    // get the succession order
    select ScessOrder into CurrentSuccessionOrder from Succession where EmployeeSysId = In_EmployeeSysId and ScessorEmployeeId = In_ScessorEmployeeId and ScessType = In_ScessType;
    // delete current record
    delete from Succession where
      EmployeeSysId = In_EmployeeSysId and
      ScessorEmployeeId = In_ScessorEmployeeId and
      ScessType = In_ScessType;
    // update succession orders
    // for all succession order > this with same type and empsysid
    //    update succession set successionorder = its succession order-1 where ....
    for OrderUpdate as Cur_ScessOrder dynamic scroll cursor for
      select ScessOrder as Get_ScessOrder,ScessorEmployeeId as Get_ScessorEmployeeId from Succession where
        EmployeeSysId = In_EmployeeSysId and
        ScessType = In_ScessType and
        ScessOrder > CurrentSuccessionOrder do
      update Succession set ScessOrder = Get_ScessOrder-1 where
        EmployeeSysId = In_EmployeeSysId and
        ScessType = In_ScessType and
        ScessorEmployeeId = Get_ScessorEmployeeId end for;
    commit work
  end if;
  if exists(select* from Succession where EmployeeSysId = In_EmployeeSysId and ScessorEmployeeId = In_ScessorEmployeeId and ScessType = In_ScessType) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.DeleteTest(
in In_TestId char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from Test where TestId = In_TestId) then
    if not exists(select* from HRTest where TestId = In_TestId) then
      delete from Test where TestId = In_TestId;
      commit work
    end if;
    if exists(select* from Test where TestId = In_TestId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.DeleteTrainCostType(
in In_TrainCostTypeId char(20))
begin
  if exists(select* from TrainCostType where TrainCostType.TrainCostTypeId = In_TrainCostTypeId) then
    if(not exists(select* from Traincostrec where TrainCostTypeId = In_TrainCostTypeId) and
      not exists(select* from Trainbatchcostrec where TrainCostTypeId = In_TrainCostTypeId)) then
      delete from TrainCostType where
        TrainCostType.TrainCostTypeId = In_TrainCostTypeId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteTraining(
in In_TrainingSysID integer)
begin
  if exists(select* from Training where
      Training.TrainingSysID = In_TrainingSysID) then
    delete from TrainCostRec where
      TrainCostRec.TrainingSysID = In_TrainingSysID;
    delete from TrainingHistory where
      TrainingHistory.TrainingSysID = In_TrainingSysID;
    delete from TrainingAttachment where
      TrainingAttachment.TrainingSysID = In_TrainingSysID;
    delete from Training where
      Training.TrainingSysID = In_TrainingSysID;
    commit work
  end if
end
;

create procedure dba.DeleteTrainingAttachment(
in In_TrainingSysId integer,
in In_TrainAttachDate timestamp)
begin
  if exists(select* from TrainingAttachment where
      TrainingAttachment.TrainingSysId = In_TrainingSysId and
      TrainingAttachment.TrainAttachDate = In_TrainAttachDate) then
    delete from TrainingAttachment where
      TrainingAttachment.TrainingSysId = In_TrainingSysId and
      TrainingAttachment.TrainAttachDate = In_TrainAttachDate;
    commit work
  end if
end
;

create procedure dba.DeleteTrainingAttachmentByKeys(
in In_PersonalSysId integer,
in In_CourseCode char(20),
in In_CourseScheduleSysId integer)
begin
  if exists(select* from TrainingAttachment where
      TrainingAttachment.PersonalSysId = In_PersonalSysId and
      TrainingAttachment.CourseCode = In_CourseCode and
      TrainingAttachment.CourseScheduleSysId = In_CourseScheduleSysId) then
    delete from TrainingAttachment where
      TrainingAttachment.PersonalSysId = In_PersonalSysId and
      TrainingAttachment.CourseCode = In_CourseCode and
      TrainingAttachment.CourseScheduleSysId = In_CourseScheduleSysId;
    commit work
  end if
end
;

create procedure dba.DeleteTrainingBatch(
in In_TrainingBatchId char(20))
begin
  if exists(select* from TrainBatchCostRec where
      TrainingBatchId = In_TrainingBatchId) then
    delete from TrainBatchCostRec where
      TrainingBatchId = In_TrainingBatchId
  end if;
  if exists(select* from TrainingPersonnel where
      TrainingBatchId = In_TrainingBatchId) then
    delete from TrainingPersonnel where
      TrainingBatchId = In_TrainingBatchId
  end if;
  if exists(select* from TrainingBatch where
      TrainingBatchId = In_TrainingBatchId) then
    delete from TrainingBatch where
      TrainingBatchId = In_TrainingBatchId
  end if;
  commit work
end
;

create procedure dba.DeleteTrainingHistory(
in In_TrainingSysId integer)
begin
  if exists(select* from TrainingHistory where TrainingHistory.TrainingSysId = In_TrainingSysId) then
    delete from TrainingHistory where
      TrainingHistory.TrainingSysId = In_TrainingSysId;
    commit work
  end if
end
;

create procedure DBA.DeleteTrainingPersonnel(
in In_TrainingBatchId char(20),
in In_TrainPersonalSysId integer)
begin
  if exists(select* from TrainingPersonnel where TrainingBatchId = In_TrainingBatchId and
      TrainPersonalSysId = In_TrainPersonalSysId) then
    delete from TrainingPersonnel where
      TrainingBatchId = In_TrainingBatchId and
      TrainPersonalSysId = In_TrainPersonalSysId;
    commit work
  end if
end
;

create procedure DBA.DeleteTrainingPersonnelByBatchID(
in In_TrainingBatchId char(20))
begin
  if exists(select* from TrainingPersonnel where TrainingBatchId = In_TrainingBatchId) then
    delete from TrainingPersonnel where
      TrainingBatchId = In_TrainingBatchId;
    commit work
  end if
end
;

create procedure dba.DeleteTrainingType(
in In_TrainingTypeId char(20))
begin
  if exists(select* from TrainingType where TrainingType.TrainingTypeId = In_TrainingTypeId) then
    if not exists(select* from courseschedule where TrainingTypeId = In_TrainingTypeId) then
      delete from TrainingType where
        TrainingType.TrainingTypeId = In_TrainingTypeId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteTreatmentType(
in In_TreatmentTypeId char(20))
begin
  if exists(select* from TreatmentType where
      TreatmentType.TreatmentTypeId = In_TreatmentTypeId) then
    if not exists(select* from MedClaim where
        MedClaim.TreatmentTypeId = In_TreatmentTypeId) then
      delete from TreatmentType where
        TreatmentType.TreatmentTypeId = In_TreatmentTypeId;
      commit work
    end if
  end if
end
;

create procedure dba.DeleteVenue(
in In_VenueCode char(20))
begin
  if exists(select* from Venue where Venue.VenueCode = In_VenueCode) then
    if(not exists(select* from CourseSchedule where CourseSchedule.VenueCode = In_VenueCode) and
      not exists(select* from Project where Project.VenueCode = In_VenueCode)) then
      delete from Venue where
        Venue.VenueCode = In_VenueCode;
      commit work
    end if
  end if
end
;

create function dba.FCheckContractProgAvail(
in In_EmployeeSysId integer,
in In_StartDate date,
in In_EndDate date)
returns smallint
begin
  declare RefDate date;
  if In_StartDate > In_EndDate then
    set RefDate=In_EndDate;
    set In_EndDate=In_StartDate;
    set In_StartDate=In_RefDate
  else
    set RefDate=In_StartDate
  end if;
  while RefDate <= In_EndDate loop
    if not exists(select* from ContractProgression where EmployeeSysId = In_EmployeeSysId and
        ((ContractStartDate < RefDate and ContractEndDate > RefDate) or ContractStartDate = RefDate or ContractEndDate = RefDate)) then
      return 0
    end if;
    select DateAdd(day,1,RefDate) into RefDate
  end loop;
  return 1
end
;

create function DBA.FDecodeHRFormula(
in In_HRFormulaId char(20))
returns char(255)
begin
  declare cont integer;
  declare In_String char(255);
  select Formula into In_String from HRFormulaRange where HRFormulaId = In_HRFormulaId;
  select Upper(In_String) into In_String;
  set cont=1;
  // K10
  while cont = 1 loop
    if(select PATINDEX('%K10%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K10%',In_String)),3,(select FGetHRKeyWordUserDefinedName(keywords10) from Leaverange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K1
  while cont = 1 loop
    if(select PATINDEX('%K1%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K1%',In_String)),2,(select FGetHRKeyWordUserDefinedName(keywords1) from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K2
  while cont = 1 loop
    if(select PATINDEX('%K2%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K2%',In_String)),2,(select FGetHRKeyWordUserDefinedName(keywords2) from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K3
  while cont = 1 loop
    if(select PATINDEX('%K3%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K3%',In_String)),2,(select FGetHRKeyWordUserDefinedName(keywords3) from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K4
  while cont = 1 loop
    if(select PATINDEX('%K4%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K4%',In_String)),2,(select FGetHRKeyWordUserDefinedName(keywords4) from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K5
  while cont = 1 loop
    if(select PATINDEX('%K5%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K5%',In_String)),2,(select FGetHRKeyWordUserDefinedName(keywords5) from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K6
  while cont = 1 loop
    if(select PATINDEX('%K6%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K6%',In_String)),2,(select FGetHRKeyWordUserDefinedName(keywords6) from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K7
  while cont = 1 loop
    if(select PATINDEX('%K7%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K7%',In_String)),2,(select FGetHRKeyWordUserDefinedName(keywords7) from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K8
  while cont = 1 loop
    if(select PATINDEX('%K8%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K8%',In_String)),2,(select FGetHRKeyWordUserDefinedName(keywords8) from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // K9
  while cont = 1 loop
    if(select PATINDEX('%K9%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%K9%',In_String)),2,(select FGetHRKeyWordUserDefinedName(keywords9) from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // U1
  while cont = 1 loop
    if(select PATINDEX('%U1%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%U1%',In_String)),2,(select UserDef1 from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // U2
  while cont = 1 loop
    if(select PATINDEX('%U2%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%U2%',In_String)),2,(select UserDef2 from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // U3
  while cont = 1 loop
    if(select PATINDEX('%U3%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%U3%',In_String)),2,(select UserDef3 from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // U4
  while cont = 1 loop
    if(select PATINDEX('%U4%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%U4%',In_String)),2,(select UserDef4 from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // U5
  while cont = 1 loop
    if(select PATINDEX('%U5%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%U5%',In_String)),2,(select UserDef5 from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // C1
  while cont = 1 loop
    if(select PATINDEX('%C1%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%C1%',In_String)),2,(select Constant1 from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // C2
  while cont = 1 loop
    if(select PATINDEX('%C2%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%C2%',In_String)),2,(select Constant2 from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // C3
  while cont = 1 loop
    if(select PATINDEX('%C3%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%C3%',In_String)),2,(select Constant3 from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // C4
  while cont = 1 loop
    if(select PATINDEX('%C4%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%C4%',In_String)),2,(select Constant4 from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  set cont=1;
  // C5
  while cont = 1 loop
    if(select PATINDEX('%C5%',In_String)) > 0 then
      select STUFF(In_String,(select PATINDEX('%C5%',In_String)),2,(select Constant5 from HRFormulaRange where HRFormulaId = In_HRFormulaId)) into In_String
    else
      set cont=0
    end if
  end loop;
  return(In_String)
end
;

create function DBA.FGetActualServiceYear(
in In_PersonalSysId integer)
returns double
begin
  declare Out_EmpeeExpYear double;
  if exists(select* from Employee where Employee.PersonalSysId = In_PersonalSysId) then
    select SUM(FGetYearsDiff(HireDate,CessationDate)) into Out_EmpeeExpYear from Employee where Employee.PersonalSysId = In_PersonalSysId
  else
    set Out_EmpeeExpYear=0
  end if;
  return Out_EmpeeExpYear
end
;

create function DBA.FGetCourseRefNo(
in In_CourseCode char(20))
returns char(50)
begin
  declare Out_CourseRefNo char(50);
  select CourseRefNo into Out_CourseRefNo from Course where
    Course.CourseCode = In_CourseCode;
  return Out_CourseRefNo
end
;

create function DBA.FGetCourseStartDate(
in In_CourseCode char(20),
in In_CourseScheduleSysId integer)
returns date
begin
  declare Out_CourseStartDate date;
  select CourseStartDate into Out_CourseStartDate from CourseSchedule where
    CourseSchedule.CourseCode = In_CourseCode and
    CourseSchedule.CourseScheduleSysId = In_CourseScheduleSysId;
  return Out_CourseStartDate
end
;

create function DBA.FGetEmpPositionDescByEmployeeID(
in In_EmployeeId char(30))
returns char(80)
begin
  declare Out_PositionId char(20);
  declare Out_PositionDesc char(80);
  select Employee.PositionId into Out_PositionId
    from Employee where
    Employee.EmployeeId = In_EmployeeId;
  select PositionCode.PositionDesc into Out_PositionDesc
    from PositionCode where PositionId = Out_PositionId;
  return(Out_PositionDesc)
end
;

create function DBA.FGetFormDsnApprMatch(
in In_AppraisalSysId integer)
returns integer
begin
  declare In_FormId char(20);
  /*
  Get the Form ID
  */
  select FormId into In_FormId from Appraisal where AppraisalSysId = In_AppraisalSysId;
  if exists(select FormSecSysId from FormSection where
      FormId = In_FormId and
      not FormSecSysId = any(select ApprSecSysId from ApprSection where
        AppraisalSysId = In_AppraisalSysId and
        ApprSecSysId = FormSecSysId)) then return 0
  end if;
  if exists(select FormSecSysId,FormPointSysId from
      FormPoint where
      FormId = In_FormId and
      not FormPointSysId = any(select ApprPointSysId from AppraisalPoint where
        AppraisalSysId = In_AppraisalSysId and
        ApprPointSysId = FormPointSysId and
        ApprSecSysId = FormSecSysId)) then return 0
  end if;
  return 1
end
;

create function dba.FGetHRKeyWordUserDefinedName(
in In_HRKeyWordId char(20))
returns char(100)
begin
  declare Out_HRKeyWordUserDefinedName char(100);
  select HRKeyWordUserDefinedName into Out_HRKeyWordUserDefinedName from HRkeyword where
    HRKeyWordId = In_HRKeyWordId;
  if(Out_HRKeyWordUserDefinedName is null or Out_HRKeyWordUserDefinedName = '') then
    return(In_HRKeyWordId)
  else return(Out_HRKeyWordUserDefinedName)
  end if
end
;

create function dba.FGetHRRangeBasisDesc(
in In_SubRegistryId char(20))
returns char(100)
begin
  declare Out_RangeBasisDesc char(100);
  select RegProperty2 into Out_RangeBasisDesc from SubRegistry where
    RegistryId = 'HRRangeBasis' and SubRegistryId = In_SubRegistryId;
  if(Out_RangeBasisDesc is null or Out_RangeBasisDesc = '') then
    return(In_SubRegistryId)
  else return(Out_RangeBasisDesc)
  end if
end
;

create function DBA.FGetJobHisExperienceYear(
in In_PersonalSysId integer)
returns double
begin
  declare Out_ExpYear double;
  if exists(select* from JobHistory where JobHistory.PersonalSysId = In_PersonalSysId) then
    select SUM(FGetYearsDiff(EmployedDate,CessationDate)) into Out_ExpYear from JobHistory where JobHistory.PersonalSysId = In_PersonalSysId
  else
    set Out_ExpYear=0
  end if;
  return Out_ExpYear
end
;

create function DBA.FGetMClaimCycleLimitPerPolicy(
in In_MedClaimPolicyId char(20),
in In_ProcessDate date)
returns double
begin
  declare Out_LimitPerPolicy double;
  select first LimitPerPolicy into Out_LimitPerPolicy from MClaimCycle where
    MedClaimPolicyId = In_MedClaimPolicyId and
    (In_ProcessDate >= MedClaimCycleStart and In_ProcessDate <= MedClaimCycleEnd) order by MedClaimCycleSysId;
  if Out_LimitPerPolicy is null then
    set Out_LimitPerPolicy=0
  end if;
  return(Out_LimitPerPolicy)
end
;

create function DBA.FGetMClaimCycleMedClaimCycleEnd(
in In_MedClaimPolicyId char(20),
in In_ProcessDate date)
returns date
begin
  declare Out_MedClaimCycleEnd date;
  select first MedClaimCycleEnd into Out_MedClaimCycleEnd from MClaimCycle where
    MedClaimPolicyId = In_MedClaimPolicyId and
    (In_ProcessDate >= MedClaimCycleStart and In_ProcessDate <= MedClaimCycleEnd) order by MedClaimCycleSysId;
  return(Out_MedClaimCycleEnd)
end
;

create function DBA.FGetMClaimCycleMedClaimCycleStart(
in In_MedClaimPolicyId char(20),
in In_ProcessDate date)
returns date
begin
  declare Out_MedClaimCycleStart date;
  select first MedClaimCycleStart into Out_MedClaimCycleStart from MClaimCycle where
    MedClaimPolicyId = In_MedClaimPolicyId and
    (In_ProcessDate >= MedClaimCycleStart and In_ProcessDate <= MedClaimCycleEnd) order by MedClaimCycleSysId;
  return(Out_MedClaimCycleStart)
end
;

create function dba.FGetMedClaimCycleAccAmt(
in In_PersonalSysId integer,
in In_MedClaimPolicyId char(20),
in In_MedClaimTypeId char(20),
in In_ProcessDate date)
returns double
begin
  declare Out_MedClaimCycleStart date;
  declare Out_MedClaimCycleEnd date;
  declare Out_ReimburseAmt double;
  declare Out_MedClaimDateBasis smallint;
  /*
  To extract the Policy's Cycle date range
  */
  select first MedClaimCycleStart,MedClaimCycleEnd into Out_MedClaimCycleStart,
    Out_MedClaimCycleEnd from MClaimPolicy join MClaimCycle where
    MClaimPolicy.MedClaimPolicyId = In_MedClaimPolicyId and
    In_ProcessDate between MedClaimCycleStart and MedClaimCycleEnd order by MedClaimCycleStart desc;
  if(Out_MedClaimCycleStart is null) then return 0
  end if;
  /*
  To get the Date Basis
  */
  select MedClaimDateBasis into Out_MedClaimDateBasis from MClaimPolicy where MClaimPolicy.MedClaimPolicyId = In_MedClaimPolicyId;
  /*
  To get the Accumulated Reimburse amount within date range
  */
  if(Out_MedClaimDateBasis = 0) then
    select Sum(ReimburseAmt) into Out_ReimburseAmt
      from MedClaim join MedClaimHistory where
      MedClaimTypeId = In_MedClaimTypeId and
      PersonalSysId = In_PersonalSysId and
      SubmissionDate between Out_MedClaimCycleStart and Out_MedClaimCycleEnd and
      MedClaimAppr = 1
  else
    select Sum(ReimburseAmt) into Out_ReimburseAmt
      from MedClaim join MedClaimHistory where
      MedClaimTypeId = In_MedClaimTypeId and
      PersonalSysId = In_PersonalSysId and
      MedReceiptDate between Out_MedClaimCycleStart and Out_MedClaimCycleEnd and
      MedClaimAppr = 1
  end if;
  if(Out_ReimburseAmt is null) then return 0
  end if;
  return Out_ReimburseAmt
end
;

create function dba.FGetMedClaimPolicyAccAmt(
in In_PersonalSysId integer,
in In_MedClaimPolicyId char(20),
in In_ProcessDate date)
returns double
begin
  declare Out_MedClaimCycleStart date;
  declare Out_MedClaimCycleEnd date;
  declare Out_ReimburseAmt double;
  declare Out_MedClaimDateBasis smallint;
  /*
  To extract the Policy's Cycle date range
  */
  select first MedClaimCycleStart,MedClaimCycleEnd into Out_MedClaimCycleStart,
    Out_MedClaimCycleEnd from MClaimPolicy join MClaimCycle where
    MClaimPolicy.MedClaimPolicyId = In_MedClaimPolicyId and
    In_ProcessDate between MedClaimCycleStart and MedClaimCycleEnd order by MedClaimCycleStart desc;
  if(Out_MedClaimCycleStart is null) then return 0
  end if;
  /*
  To get the Date Basis
  */
  select MedClaimDateBasis into Out_MedClaimDateBasis from MClaimPolicy where MClaimPolicy.MedClaimPolicyId = In_MedClaimPolicyId;
  /*
  To get the Accumulated Reimburse amount within date range
  */
  if(Out_MedClaimDateBasis = 0) then
    select Sum(ReimburseAmt) into Out_ReimburseAmt
      from MedClaim join MedClaimHistory where
      MedClaimTypeId = any(select distinct MedClaimTypeId from MClaimPolicyRec where
        MedClaimPolicyId = In_MedClaimPolicyId) and
      PersonalSysId = In_PersonalSysId and
      SubmissionDate between Out_MedClaimCycleStart and Out_MedClaimCycleEnd and
      MedClaimAppr = 1
  else
    select Sum(ReimburseAmt) into Out_ReimburseAmt
      from MedClaim join MedClaimHistory where
      MedClaimTypeId = any(select distinct MedClaimTypeId from MClaimPolicyRec where
        MedClaimPolicyId = In_MedClaimPolicyId) and
      PersonalSysId = In_PersonalSysId and
      MedReceiptDate between Out_MedClaimCycleStart and Out_MedClaimCycleEnd and
      MedClaimAppr = 1
  end if;
  if(Out_ReimburseAmt is null) then return 0
  end if;
  return Out_ReimburseAmt
end
;

create function DBA.FGetNextExitIntDetSysId(
in In_PersonalSysId integer,
in In_TenderDate date)
returns integer
begin
  declare Out_ExitIntDetSysId integer;
  select Max(ExitIntDetSysId) into Out_ExitIntDetSysId from ExitIntDetails where
    PersonalSysId = In_PersonalSysId and
    TenderDate = In_TenderDate;
  if Out_ExitIntDetSysId is null then
    set Out_ExitIntDetSysId=1
  else
    set Out_ExitIntDetSysId=Out_ExitIntDetSysId+1
  end if;
  return Out_ExitIntDetSysId
end
;

create function DBA.FGetOrganisationName(
in In_OrganisationCode char(20))
returns char(100)
begin
  declare Out_OrganisationName char(100);
  select OrganisationName into Out_OrganisationName from Organisation where Organisation.OrganisationCode = In_OrganisationCode;
  return Out_OrganisationName
end
;

create function DBA.FGetSystemColumnType(
in In_TableName char(100),
in In_ColumnName char(100))
returns char(20)
begin
  declare Out_ColumnType char(20);
  select ColType into Out_ColumnType from View_SysColumns where tname = In_TableName and cname = In_ColumnName;
  return Out_ColumnType
end
;

create function DBA.FGetTrainForClaimByCostType(
in In_TrainCostTypeId char(20))
returns integer
begin
  declare Out_Claimable integer;
  select TrainForClaim into Out_Claimable
    from TrainCostType where
    TrainCostTypeId = In_TrainCostTypeId;
  return(Out_Claimable)
end
;

create function DBA.FGetVenueDesc(
in In_VenueCode char(20))
returns char(100)
begin
  declare Out_VenueDesc char(100);
  select VenueDesc into Out_VenueDesc from Venue where Venue.VenueCode = In_VenueCode;
  return Out_VenueDesc
end
;

create function DBA.FGetYearsDiff(
in In_StartDate date,
in In_EndDate date)
returns double
begin
  declare Out_YearsDiff double;
  if(FGetDateFormat(In_StartDate) = '') then return 0
  end if;
  if(FGetDateFormat(In_EndDate) = '') then set In_EndDate=GetDate(*)
  end if;
  set Out_YearsDiff=round(cast(Months(In_StartDate,In_EndDate) as double)/12,2);
  if(Out_YearsDiff < 0) then set Out_YearsDiff=0
  end if;
  return Out_YearsDiff
end
;

create procedure dba.InsertNewActionTaken(
in In_ActionTakenId char(20),
in In_ActionTakenDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from ActionTaken where ActionTakenId = In_ActionTakenId) then
    insert into ActionTaken(ActionTakenId,ActionTakenDesc) values(
      In_ActionTakenId,In_ActionTakenDesc);
    commit work;
    if not exists(select* from ActionTaken where ActionTakenId = In_ActionTakenId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewApplicant(
in In_PersonalSysId integer,
in In_RecruitCode char(20),
in In_MediaId char(20),
in In_AppDateSubmitted date,
in In_AppExpectedSalary double,
in In_AppAvailability date,
in In_Recommended integer,
in In_RecommendedBy char(20),
in In_Remarks char(100),
out Out_ApplicantSysId integer,
out Out_ErrorCode integer)
begin
  if In_PersonalSysId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_RecruitCode is null then set Out_ErrorCode=-2;
    return
  end if;
  if FGetInvalidDate(In_AppDateSubmitted) = '' then set Out_ErrorCode=-3;
    return
  end if;
  if not exists(select* from Applicant where PersonalSysId = In_PersonalSysId and RecruitCode = In_RecruitCode and AppDateSubmitted = In_AppDateSubmitted) then
    insert into Applicant(PersonalSysId,
      RecruitCode,
      MediaId,
      AppDateSubmitted,
      AppExpectedSalary,
      AppAvailability,
      Recommended,
      RecommendedBy,
      Remarks) values(
      In_PersonalSysId,
      In_RecruitCode,
      In_MediaId,
      In_AppDateSubmitted,
      In_AppExpectedSalary,
      In_AppAvailability,
      In_Recommended,
      In_RecommendedBy,
      In_Remarks);
    commit work;
    if not exists(select* from Applicant where PersonalSysId = In_PersonalSysId and RecruitCode = In_RecruitCode and AppDateSubmitted = In_AppDateSubmitted) then
      set Out_ErrorCode=0
    else
      select max(ApplicantSysId) into Out_ApplicantSysId from Applicant where PersonalSysId = In_PersonalSysId and RecruitCode = In_RecruitCode and AppDateSubmitted = In_AppDateSubmitted;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewApplicantAttach(
in In_ApplicantSysId integer,
in In_AttachFileType char(20),
in In_AttachRemarks char(100),
in In_AttachDate date,
out Out_ApplicantAttachSysId integer,
out Out_ErrorCode integer)
begin
  select max(ApplicantAttachSysId) into Out_ApplicantAttachSysId from ApplicantAttach where
    ApplicantAttach.ApplicantSysId = In_ApplicantSysId;
  if(Out_ApplicantAttachSysId is null) then
    set Out_ApplicantAttachSysId=1
  else
    set Out_ApplicantAttachSysId=Out_ApplicantAttachSysId+1
  end if;
  if not exists(select* from ApplicantAttach where
      ApplicantAttach.ApplicantSysId = In_ApplicantSysId and
      ApplicantAttach.ApplicantAttachSysId = Out_ApplicantAttachSysId) then
    insert into ApplicantAttach(ApplicantSysId,
      ApplicantAttachSysId,
      AttachFileType,
      AttachRemarks,
      AttachDate) values(In_ApplicantSysId,
      Out_ApplicantAttachSysId,
      In_AttachFileType,
      In_AttachRemarks,
      In_AttachDate);
    commit work;
    if not exists(select* from ApplicantAttach where
        ApplicantAttach.ApplicantSysId = In_ApplicantSysId and
        ApplicantAttach.ApplicantAttachSysId = Out_ApplicantAttachSysId) then
      set Out_ApplicantAttachSysId=null;
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ApplicantAttachSysId=null;
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewAppraisal(
in In_AppraisalTypeId char(20),
in In_ApprPtSystemId char(20),
in In_FormId char(20),
in In_GradeCode char(20),
in In_PersonalSysId integer,
in In_AppraisalDate date,
in In_AppraisalSvcFrom date,
in In_AppraisalSvcTo date,
in In_AppraisalNext date,
in In_AppraisalRemarks char(100),
in In_AppraisalPerformance double,
in In_AppraisalStatus char(20),
in In_ApprBonusProcess integer,
in In_ApprBonusFactor double,
in In_ApprObjectivePercent double,
in In_ApprCareerMovement integer,
in In_ApprCareerEffectDate date,
in In_ApprPayAdjust integer,
in In_ApprBRProgDate date,
in In_ApprAdjustType integer,
in In_ApprBRAdjust double,
in In_ApprMVCAdjust double,
in In_ApprNWCAdjust double,
out Out_AppraisalSysId integer)
begin
  select Max(AppraisalSysId) into Out_AppraisalSysId from Appraisal;
  if(Out_AppraisalSysId is null) then set Out_AppraisalSysId=1
  else set Out_AppraisalSysId=Out_AppraisalSysId+1
  end if;
  insert into Appraisal(AppraisalSysId,AppraisalTypeId,
    ApprPtSystemId,
    FormId,
    GradeCode,
    PersonalSysId,
    AppraisalDate,
    AppraisalSvcFrom,
    AppraisalSvcTo,
    AppraisalNext,
    AppraisalRemarks,
    AppraisalPerformance,
    AppraisalStatus,
    ApprBonusProcess,
    ApprBonusFactor,
    ApprObjectivePercent,
    ApprCareerMovement,
    ApprCareerEffectDate,
    ApprPayAdjust,
    ApprBRProgDate,
    ApprAdjustType,
    ApprBRAdjust,
    ApprMVCAdjust,
    ApprNWCAdjust) values(Out_AppraisalSysId,
    In_AppraisalTypeId,
    In_ApprPtSystemId,
    In_FormId,
    In_GradeCode,
    In_PersonalSysId,
    In_AppraisalDate,
    In_AppraisalSvcFrom,
    In_AppraisalSvcTo,
    In_AppraisalNext,
    In_AppraisalRemarks,
    In_AppraisalPerformance,
    In_AppraisalStatus,
    In_ApprBonusProcess,
    In_ApprBonusFactor,
    In_ApprObjectivePercent,
    In_ApprCareerMovement,
    In_ApprCareerEffectDate,
    In_ApprPayAdjust,
    In_ApprBRProgDate,
    In_ApprAdjustType,
    In_ApprBRAdjust,
    In_ApprMVCAdjust,
    In_ApprNWCAdjust);
  commit work
end
;

create procedure dba.InsertNewAppraisalDetail(
in In_PersonalSysId integer,
in In_AppraisalDate date,
in In_ApprCategoryId char(20),
in In_ApprQuestionSysId integer,
in In_AppraisalPt double,
in In_AppraisalComment char(200))
begin
  insert into AppraisalDetail(PersonalSysId,AppraisalDate,ApprCategoryId,ApprQuestionSysId,AppraisalPt,AppraisalComment) values(
    In_PersonalSysId,In_AppraisalDate,In_ApprCategoryId,In_ApprQuestionSysId,In_AppraisalPt,In_AppraisalComment);
  commit work
end
;

create procedure dba.InsertNewAppraisalGrade(
in In_ApprPtSystemId char(20),
in In_GradeCode char(20),
in In_AppraisalPtFrom double,
in In_AppraisalPtTo double,
in In_ApprBonusFactor double,
in In_ApprPayAdjust integer,
in In_ApprBRAdjust double,
in In_ApprMVCAdjust double,
in In_ApprNWCAdjust double)
begin
  insert into AppraisalGrade(ApprPtSystemId,GradeCode,AppraisalPtFrom,AppraisalPtTo,ApprBonusFactor,ApprPayAdjust,ApprBRAdjust,ApprMVCAdjust,ApprNWCAdjust) values(
    In_ApprPtSystemId,In_GradeCode,In_AppraisalPtFrom,In_AppraisalPtTo,In_ApprBonusFactor,In_ApprPayAdjust,In_ApprBRAdjust,In_ApprMVCAdjust,In_ApprNWCAdjust);
  commit work
end
;

create procedure dba.InsertNewAppraisalHistory(
in In_AppraisalSysId integer,
in In_HisBasicRate double,
in In_HisBranchId char(20),
in In_HisCategoryId char(20),
in In_HisDepartmentId char(20),
in In_HisEducationId char(20),
in In_HisMVC double,
in In_HisNWC double,
in In_HisPositionId char(20),
in In_HisSectionId char(20),
in In_HisSupervisorId char(30))
begin
  if not exists(select* from AppraisalHistory where AppraisalSysId = In_AppraisalSysId) then
    insert into AppraisalHistory(AppraisalSysId,HisBasicRate,HisBranchId,HisCategoryId,HisDepartmentId,HisEducationId,HisMVC,HisNWC,HisPositionId,HisSectionId,HisSupervisorId) values(
      In_AppraisalSysId,In_HisBasicRate,In_HisBranchId,In_HisCategoryId,In_HisDepartmentId,In_HisEducationId,In_HisMVC,In_HisNWC,In_HisPositionId,In_HisSectionId,In_HisSupervisorId);
    commit work
  end if
end
;

create procedure dba.InsertNewAppraisalType(
in In_AppraisalTypeId char(20),
in In_AppraisalTypeDesc char(100))
begin
  if not exists(select* from AppraisalType where AppraisalType.AppraisalTypeId = In_AppraisalTypeId) then
    insert into AppraisalType(AppraisalTypeId,
      AppraisalTypeDesc) values(
      In_AppraisalTypeId,
      In_AppraisalTypeDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewApprCategory(
in In_ApprCategoryId char(20),
in In_ApprCategoryDesc char(100))
begin
  insert into ApprCategory(ApprCategoryId,ApprCategoryDesc) values(
    In_ApprCategoryId,In_ApprCategoryDesc);
  commit work
end
;

create procedure dba.InsertNewApprPtSystem(
in In_ApprPtSystemId char(20),
in In_ApprPtSystemDesc char(100),
in In_ApprAdjustType integer)
begin
  insert into ApprPtSystem(ApprPtSystemId,ApprPtSystemDesc,ApprAdjustType) values(
    In_ApprPtSystemId,In_ApprPtSystemDesc,In_ApprAdjustType);
  commit work
end
;

create procedure dba.InsertNewApprTemplate(
in In_ApprTmpId char(20),
in In_ApprTmpRemarks char(100),
in In_ApprTmpDesc char(100))
begin
  insert into ApprTemplate(ApprTmpId,ApprTmpRemarks,ApprTmpDesc) values(
    In_ApprTmpId,In_ApprTmpRemarks,In_ApprTmpDesc);
  commit work
end
;

create procedure dba.InsertNewApprTraining(
in In_AppraisalSysId integer,
in In_ApprAquiredDate date,
in In_ApprTrainingComment char(200),
in In_CourseCode char(20),
in In_SkillCode char(20),
in In_TrainingSysId integer,
out Out_ApprTrainingSysId integer)
begin
  select Max(ApprTrainingSysId) into Out_ApprTrainingSysId from ApprTraining;
  if(Out_ApprTrainingSysId is null) then set Out_ApprTrainingSysId=1
  else set Out_ApprTrainingSysId=Out_ApprTrainingSysId+1
  end if;
  insert into ApprTraining(AppraisalSysId,
    ApprAquiredDate,
    ApprTrainingComment,
    CourseCode,
    SkillCode,
    TrainingSysId,
    ApprTrainingSysId) values(In_AppraisalSysId,
    In_ApprAquiredDate,
    In_ApprTrainingComment,
    In_CourseCode,
    In_SkillCode,
    In_TrainingSysId,
    Out_ApprTrainingSysId);
  commit work
end
;

create procedure dba.InsertNewAreaSpecialised(
in In_AreaSpecialised char(20),
in In_AreaSpecialisedDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from AreaSpecialised where AreaSpecialised = In_AreaSpecialised) then
    insert into AreaSpecialised(AreaSpecialised,AreaSpecialisedDesc) values(
      In_AreaSpecialised,In_AreaSpecialisedDesc);
    commit work;
    if not exists(select* from AreaSpecialised where AreaSpecialised = In_AreaSpecialised) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewAwardCode(
in In_AwardDiscCode char(20),
in In_AwardDiscDesc char(100),
in In_IsDiscipline integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from AwardCode where AwardDiscCode = In_AwardDiscCode) then
    insert into AwardCode(AwardDiscCode,AwardDiscDesc,IsDiscipline) values(
      In_AwardDiscCode,In_AwardDiscDesc,In_IsDiscipline);
    commit work;
    if not exists(select* from AwardCode where AwardDiscCode = In_AwardDiscCode) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewAwardDisc(
in In_PersonalSysId integer,
in In_AwardDiscCode char(20),
in In_ActionTakenId char(20),
in In_OffenceType char(20),
in In_AwardDiscDate date,
in In_AwardAmount double,
in In_PayrollDate date,
in In_PayrollEmployeeSysId integer,
in In_PayrollPayElementId char(20),
in In_PayrollYear integer,
in In_PayrollPeriod integer,
in In_PayrollSubPeriod integer,
in In_PayrollProcessDate date,
in In_ReferenceNo char(20),
in In_Remarks char(100),
in In_FollowUpDate date,
in In_OffenceDate date,
out Out_ErrorCode integer)
begin
  if In_PersonalSysId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_AwardDiscCode is null then set Out_ErrorCode=-2;
    return
  end if;
  if In_AwardDiscDate = '1899-12-30' then set Out_ErrorCode=-3;
    return
  end if;
  if not exists(select* from AwardDisc where PersonalSysId = In_PersonalSysId and AwardDiscCode = In_AwardDiscCode and
      AwardDiscDate = In_AwardDiscDate) then
    insert into AwardDisc(PersonalSysId,
      AwardDiscCode,
      ActionTakenId,
      OffenceType,
      AwardDiscDate,
      AwardAmount,
      PayrollDate,
      PayrollEmployeeSysId,
      PayrollPayElementId,
      PayrollYear,
      PayrollPeriod,
      PayrollSubPeriod,
      PayrollProcessDate,
      ReferenceNo,
      Remarks,
      FollowUpDate,
      OffenceDate) values(
      In_PersonalSysId,
      In_AwardDiscCode,
      In_ActionTakenId,
      In_OffenceType,
      In_AwardDiscDate,
      In_AwardAmount,
      In_PayrollDate,
      In_PayrollEmployeeSysId,
      In_PayrollPayElementId,
      In_PayrollYear,
      In_PayrollPeriod,
      In_PayrollSubPeriod,
      In_PayrollProcessDate,
      In_ReferenceNo,
      In_Remarks,
      In_FollowUpDate,
      In_OffenceDate);
    commit work;
    if not exists(select* from AwardDisc where PersonalSysId = In_PersonalSysId and AwardDiscCode = In_AwardDiscCode and
        AwardDiscDate = In_AwardDiscDate) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewAwardDiscAttach(
in In_AwardDiscSysId integer,
in In_AttachFileType char(20),
in In_AttachRemarks char(100),
out Out_AwardDiscAttachSysId integer,
out Out_ErrorCode integer)
begin
  select max(AwardDiscAttachSysId) into Out_AwardDiscAttachSysId from AwardDiscAttach where
    AwardDiscAttach.AwardDiscSysId = In_AwardDiscSysId;
  if(Out_AwardDiscAttachSysId is null) then
    set Out_AwardDiscAttachSysId=1
  else
    set Out_AwardDiscAttachSysId=Out_AwardDiscAttachSysId+1
  end if;
  if not exists(select* from AwardDiscAttach where
      AwardDiscAttach.AwardDiscSysId = In_AwardDiscSysId and
      AwardDiscAttach.AwardDiscAttachSysId = Out_AwardDiscAttachSysId) then
    insert into AwardDiscAttach(AwardDiscSysId,
      AwardDiscAttachSysId,
      AttachFileType,
      AttachRemarks) values(In_AwardDiscSysId,
      Out_AwardDiscAttachSysId,
      In_AttachFileType,
      In_AttachRemarks);
    commit work;
    if not exists(select* from AwardDiscAttach where
        AwardDiscAttach.AwardDiscSysId = In_AwardDiscSysId and
        AwardDiscAttach.AwardDiscAttachSysId = Out_AwardDiscAttachSysId) then
      set Out_AwardDiscAttachSysId=null;
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_AwardDiscAttachSysId=null;
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewBond(
in In_EffectiveDate date,
in In_EndDate date,
in In_BondDuration double,
in In_BondUnit char(20),
in In_BondRefNo char(20),
in In_BondDesc char(100),
in In_PersonalSysId integer,
out Out_BondSysId integer)
begin
  select Max(BondSysId) into Out_BondSysId from Bond;
  if(Out_BondSysId is null) then set Out_BondSysId=1
  else set Out_BondSysId=Out_BondSysId+1
  end if;
  insert into Bond(BondSysId,
    EffectiveDate,
    EndDate,
    BondDuration,
    BondUnit,
    BondRefNo,
    BondDesc,
    PersonalSysId) values(Out_BondSysId,
    In_EffectiveDate,
    In_EndDate,
    In_BondDuration,
    In_BondUnit,
    In_BondRefNo,
    In_BondDesc,
    In_PersonalSysId);
  commit work
end
;

create procedure dba.InsertNewBondAttachment(
in In_BondSysId integer,
in In_AttachRemarks char(100),
in In_AttachFileType char(20),
out Out_BondAttachSysId integer)
begin
  select Max(BondAttachSysId) into Out_BondAttachSysId from BondAttachment;
  if(Out_BondAttachSysId is null) then set Out_BondAttachSysId=1
  else set Out_BondAttachSysId=Out_BondAttachSysId+1
  end if;
  insert into BondAttachment(BondSysId,
    BondAttachSysId,
    AttachRemarks,
    AttachFileType) values(
    In_BondSysId,
    Out_BondAttachSysId,
    In_AttachRemarks,
    In_AttachFileType);
  commit work
end
;

create procedure dba.InsertNewCompetency(
in In_PositionId char(20),
in In_CompetencyDate date,
in In_Remarks char(100),
in In_CFieldsStrIsAND integer,
in In_CFieldsNumIsAND integer,
in In_CFieldMajorIsAND integer,
in In_CEduLevelIsAND integer,
in In_CResponIsAND integer,
in In_CSkillIsAND integer,
in In_EmployeeSysId integer,
out Out_CompetencySysId integer,
out Out_ErrorCode integer)
begin
  if In_PositionId is null and In_EmployeeSysId <= 0 then set Out_ErrorCode=-1;
    return
  end if;
  if FGetInvalidDate(In_CompetencyDate) = '' then set Out_ErrorCode=-2;
    return
  end if;
  if In_EmployeeSysId > 0 then
    if not exists(select* from Competency where EmployeeSysId = In_EmployeeSysId and CompetencyDate = In_CompetencyDate) then
      insert into Competency(PositionId,
        CompetencyDate,
        Remarks,
        CFieldsStrIsAND,
        CFieldsNumIsAND,
        CFieldMajorIsAND,
        CEduLevelIsAND,
        CResponIsAND,
        CSkillIsAND,
        EmployeeSysId) values(
        In_PositionId,
        In_CompetencyDate,
        In_Remarks,
        In_CFieldsStrIsAND,
        In_CFieldsNumIsAND,
        In_CFieldMajorIsAND,
        In_CEduLevelIsAND,
        In_CResponIsAND,
        In_CSkillIsAND,
        In_EmployeeSysId);
      commit work;
      if not exists(select* from Competency where EmployeeSysId = In_EmployeeSysId and CompetencyDate = In_CompetencyDate) then
        set Out_ErrorCode=0
      else
        select max(CompetencySysId) into Out_CompetencySysId from Competency where EmployeeSysId = In_EmployeeSysId and CompetencyDate = In_CompetencyDate;
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=0
    end if
  else
    if not exists(select* from Competency where PositionId = In_PositionId and CompetencyDate = In_CompetencyDate) then
      insert into Competency(PositionId,
        CompetencyDate,
        Remarks,
        CFieldsStrIsAND,
        CFieldsNumIsAND,
        CFieldMajorIsAND,
        CEduLevelIsAND,
        CResponIsAND,
        CSkillIsAND) values(
        In_PositionId,
        In_CompetencyDate,
        In_Remarks,
        In_CFieldsStrIsAND,
        In_CFieldsNumIsAND,
        In_CFieldMajorIsAND,
        In_CEduLevelIsAND,
        In_CResponIsAND,
        In_CSkillIsAND);
      commit work;
      if not exists(select* from Competency where PositionId = In_PositionId and CompetencyDate = In_CompetencyDate) then
        set Out_ErrorCode=0
      else
        select max(CompetencySysId) into Out_CompetencySysId from Competency where PositionId = In_PositionId and CompetencyDate = In_CompetencyDate;
        set Out_ErrorCode=1
      end if
    else
      set Out_ErrorCode=0
    end if
  end if
end
;

create procedure dba.InsertNewContractCategory(
in In_ContractCategoryId char(20),
in In_ContractCategoryDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from ContractCategory where ContractCategoryId = In_ContractCategoryId) then
    insert into ContractCategory(ContractCategoryId,ContractCategoryDesc) values(
      In_ContractCategoryId,In_ContractCategoryDesc);
    commit work;
    if not exists(select* from ContractCategory where ContractCategoryId = In_ContractCategoryId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewCourse(
in In_CourseCode char(20),
in In_CourseSkillTypeId char(20),
in In_CourseActive smallint,
in In_CourseDesc char(100),
in In_CourseTitle char(100),
in In_CourseRefNo char(50),
in In_CourseLevel integer,
in In_CourseBondDuration double,
in In_CourseBondUnit char(20),
in In_CourseFamilyId char(20),
in In_CourseCategoryId char(20),
in In_CourseLanguage char(20))
begin
  if not exists(select* from Course where Course.CourseCode = In_CourseCode) then
    insert into Course(CourseCode,
      CourseSkillTypeId,
      CourseActive,
      CourseDesc,
      CourseTitle,
      CourseRefNo,
      CourseLevel,
      CourseBondDuration,
      CourseBondUnit,
      CourseFamilyId,
      CourseCategoryId,
      CourseLanguage) values(In_CourseCode,
      In_CourseSkillTypeId,
      In_CourseActive,
      In_CourseDesc,
      In_CourseTitle,
      In_CourseRefNo,
      In_CourseLevel,
      In_CourseBondDuration,
      In_CourseBondUnit,
      In_CourseFamilyId,
      In_CourseCategoryId,
      In_CourseLanguage);
    commit work
  end if
end
;

create procedure dba.InsertNewCourseAttachment(
in In_CourseCode char(20),
in In_CourseAttachRemarks char(100),
in In_CourseAttachFileType char(20),
out Out_CourseAttachSysId integer)
begin
  select max(CourseAttachSysID) into Out_CourseAttachSysId from CourseAttachment where
    CourseAttachment.CourseCode = In_CourseCode;
  if Out_CourseAttachSysId is null then set Out_CourseAttachSysId=0
  end if;
  if not exists(select* from CourseAttachment where
      CourseAttachment.CourseCode = In_CourseCode and
      CourseAttachment.CourseAttachSysID = Out_CourseAttachSysId+1) then
    insert into CourseAttachment(CourseCode,CourseAttachSysID,CourseAttachRemarks,CourseAttachFileType) values(
      In_CourseCode,(Out_CourseAttachSysId+1),In_CourseAttachRemarks,In_CourseAttachFileType);
    commit work;
    if not exists(select* from CourseAttachment where CourseAttachment.CourseCode = In_CourseCode and
        CourseAttachment.CourseAttachSysID = Out_CourseAttachSysId+1) then set Out_CourseAttachSysId=null
    else set Out_CourseAttachSysId=Out_CourseAttachSysId+1
    end if
  end if
end
;

create procedure dba.InsertNewCourseCategory(
in In_CourseCategoryId char(20),
in In_CourseCatDesc char(100))
begin
  if not exists(select* from CourseCategory where CourseCategoryId = In_CourseCategoryId) then
    insert into CourseCategory(CourseCategoryId,CourseCatDesc) values(
      In_CourseCategoryId,In_CourseCatDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewCourseContact(
in In_CourseCode char(20),
in In_CourseScheduleSysId integer,
in In_ContactPerson char(50),
in In_ContactRole char(20),
in In_ContactNo1 char(20),
in In_ContactNo2 char(20),
in In_ContactEmail char(100),
in In_ContactFax char(20),
out Out_CourseContactSysId integer)
begin
  select max(CourseContactSysId) into Out_CourseContactSysId from CourseContact where
    CourseContact.CourseCode = In_CourseCode and
    CourseContact.CourseScheduleSysId = In_CourseScheduleSysId;
  if Out_CourseContactSysId is null then set Out_CourseContactSysId=0
  end if;
  if not exists(select* from CourseContact where CourseContact.CourseCode = In_CourseCode and
      CourseContact.CourseScheduleSysId = In_CourseScheduleSysId and
      CourseSchedule.CourseContactSysId = Out_CourseContactSysId+1) then
    insert into CourseContact(CourseCode,
      CourseScheduleSysID,
      CourseContactSysId,
      CourseRoleId,
      ContactPerson,
      ContactNo1,
      ContactNo2,
      ContactFax,
      ContactEmail) values(
      In_CourseCode,
      In_CourseScheduleSysId(
      Out_CourseContactSysId+1),
      In_ContactRole,
      In_ContactPerson,
      In_ContactNo1,
      In_ContactNo2,
      In_ContactFax,
      In_ContactEmail);
    commit work;
    if not exists(select* from CourseContact where CourseContact.CourseCode = In_CourseCode and
        CourseContact.CourseScheduleSysId = In_CourseScheduleSysId and
        CourseSchedule.CourseContactSysId = Out_CourseContactSysId+1) then set Out_CourseContactSysId=null
    else set Out_CourseContactSysId=Out_CourseContactSysId+1
    end if
  end if
end
;

create procedure dba.InsertNewCourseFamily(
in In_CourseFamilyId char(20),
in In_CourseFamilyDesc char(100))
begin
  if not exists(select* from CourseFamily where CourseFamilyId = In_CourseFamilyId) then
    insert into CourseFamily(CourseFamilyId,CourseFamilyDesc) values(
      In_CourseFamilyId,In_CourseFamilyDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewCourseGrade(
in In_CourseCode char(20),
in In_GradeCode char(20),
in In_CourseResultFrom double,
in In_CourseResultTo double)
begin
  if not exists(select* from CourseGrade where
      CourseGrade.CourseCode = In_CourseCode and
      CourseGrade.GradeCode = In_GradeCode) then
    insert into CourseGrade(CourseCode,
      GradeCode,
      CourseResultFrom,
      CourseResultTo) values(
      In_CourseCode,
      In_GradeCode,
      In_CourseResultFrom,
      In_CourseResultTo);
    commit work
  end if
end
;

create procedure dba.InsertNewCourseRole(
in In_CourseRoleId char(20),
in In_CourseRoleDesc char(100))
begin
  if not exists(select* from CourseRole where CourseRole.CourseRoleId = In_CourseRoleId) then
    insert into CourseRole(CourseRoleId,CourseRoleDesc) values(
      In_CourseRoleId,In_CourseRoleDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewCourseSchedule(
in In_CourseCode char(20),
in In_TrainingTypeId char(20),
in In_OrganisationCode char(20),
in In_VenueCode char(20),
in In_CourseStartDate date,
in In_CourseStartTime time,
in In_CourseEndDate date,
in In_CourseEndTime time,
in In_CourseDuration double,
in In_CourseUnit char(20),
in In_CourseFee double,
in In_CourseRemarks char(100),
out Out_CourseScheduleSysID integer)
begin
  select max(distinct CourseScheduleSysID) into Out_CourseScheduleSysID from CourseSchedule where
    CourseSchedule.CourseCode = In_CourseCode;
  if Out_CourseScheduleSysID is null then set Out_CourseScheduleSysID=0
  end if;
  if not exists(select* from CourseSchedule where
      CourseSchedule.CourseCode = In_CourseCode and
      CourseSchedule.CourseScheduleSysID = Out_CourseScheduleSysID+1) then
    insert into CourseSchedule(CourseCode,
      CourseScheduleSysID,
      TrainingTypeID,
      OrganisationCode,
      VenueCode,
      CourseStartDate,
      CourseStartTime,
      CourseEndDate,
      CourseEndTime,
      CourseDuration,
      CourseUnit,
      CourseFee,
      CourseRemarks) values(
      In_CourseCode,
      (Out_CourseScheduleSysID+1),
      In_TrainingTypeId,
      In_OrganisationCode,
      In_VenueCode,
      In_CourseStartDate,
      In_CourseStartTime,
      In_CourseEndDate,
      In_CourseEndTime,
      In_CourseDuration,
      In_CourseUnit,
      In_CourseFee,
      In_CourseRemarks);
    commit work;
    if not exists(select* from CourseSchedule where CourseSchedule.CourseCode = In_CourseCode and
        CourseSchedule.CourseScheduleSysID = Out_CourseScheduleSysID+1) then set Out_CourseScheduleSysID=null
    else set Out_CourseScheduleSysID=Out_CourseScheduleSysID+1
    end if
  end if
end
;

create procedure dba.InsertNewCourseSkillType(
in In_CourseSkillTypeId char(20),
in In_CourseSkillTypeDesc char(100))
begin
  if not exists(select* from CourseSkillType where CourseSkillType.CourseSkillTypeId = In_CourseSkillTypeId) then
    insert into CourseSkillType(CourseSkillTypeId,
      CourseSkillTypeDesc) values(
      In_CourseSkillTypeId,
      In_CourseSkillTypeDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewEduAttachment(
in In_EduRecId integer,
in In_AttachFileType char(20),
in In_AttachRemarks char(100),
out Out_EduAttachSysId integer,
out Out_ErrorCode integer)
begin
  select max(EduAttachSysId) into Out_EduAttachSysId from EduAttachment where
    EduAttachment.EduRecId = In_EduRecId;
  if(Out_EduAttachSysId is null) then
    set Out_EduAttachSysId=0
  end if;
  if not exists(select* from EduAttachment where
      EduAttachment.EduRecId = In_EduRecId and
      EduAttachment.EduAttachSysId = Out_EduAttachSysId+1) then
    insert into EduAttachment(EduRecId,
      EduAttachSysId,
      AttachFileType,
      AttachRemarks) values(In_EduRecId,
      Out_EduAttachSysId+1,
      In_AttachFileType,
      In_AttachRemarks);
    commit work;
    if not exists(select* from EduAttachment where
        EduAttachment.EduRecId = In_EduRecId and
        EduAttachment.EduAttachSysId = Out_EduAttachSysId+1) then
      set Out_EduAttachSysId=null;
      set Out_ErrorCode=0
    else
      set Out_EduAttachSysId=Out_EduAttachSysId+1;
      set Out_ErrorCode=1
    end if
  else
    set Out_EduAttachSysId=null;
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewEducationRec(
in In_EducationId char(20),
in In_PersonalSysId integer,
in In_EduStartDate date,
in In_EduEndDate date,
in In_EduInstitution char(100),
in In_EduHighest smallint,
in In_EduResult integer,
out Out_EduRecId integer,
out Out_ErrorCode integer)
begin
  declare Out_EducationRecord integer;
  if(FGetInvalidDate(In_EduStartDate) <> '' and FGetInvalidDate(In_EduEndDate) <> '') then
    if(In_EduStartDate < In_EduEndDate) then
      set Out_ErrorCode=1
    else
      set Out_ErrorCode=-1
    end if
  else
    set Out_ErrorCode=1
  end if;
  if(In_EducationId <> '') then
    if(Out_ErrorCode = 1) then
      if not exists(select* from EducationRec where PersonalSysId = In_PersonalSysId and
          EducationId = In_EducationId and EduStartDate = In_EduStartDate and EduEndDate = In_EduEndDate and
          EduInsitution = In_EduInstitution and EduHighest = In_EduHighest and EduResult = In_EduResult) then
        if(In_EduHighest = 1) then
          update EducationRec set EduHighest = 0 where
            PersonalSysId = In_PersonalSysId and EduHighest = 1
        end if;
        select count(*) into Out_EducationRecord from EducationRec where
          PersonalSysId = In_PersonalSysId and EduHighest = 1;
        if(Out_EducationRecord = 0) then set In_EduHighest=1
        end if;
        insert into EducationRec(EducationId,
          PersonalSysId,
          EduStartDate,
          EduEndDate,
          EduInsitution,
          EduHighest,
          EduResult) values(
          In_EducationId,
          In_PersonalSysId,
          In_EduStartDate,
          In_EduEndDate,
          In_EduInstitution,
          In_EduHighest,
          In_EduResult);
        if(In_EduHighest = 1) then
          if exists(select* from Employee where
              PersonalSysId = In_PersonalSysId and
              FGetInvalidDate(cessationdate) = '') then
            update Employee set
              HighestEduCode = In_EducationId where
              PersonalSysId = In_PersonalSysId and
              FGetInvalidDate(cessationdate) = ''
          end if
        end if;
        commit work;
        if not exists(select* from EducationRec where PersonalSysId = In_PersonalSysId and
            EducationId = In_EducationId and EduStartDate = In_EduStartDate and EduEndDate = In_EduEndDate and
            EduInsitution = In_EduInstitution and EduHighest = In_EduHighest and EduResult = In_EduResult) then
          set Out_ErrorCode=0
        else
          select MAX(EduRecId) into Out_EduRecId from EducationRec where PersonalSysId = In_PersonalSysId;
          set Out_ErrorCode=1
        end if
      else
        set Out_ErrorCode=0
      end if
    end if
  else
    set Out_ErrorCode=-2
  end if
end
;

create procedure dba.InsertNewExitIntAttach(
in In_PersonalSysId integer,
in In_TenderDate date,
in In_AttachFileType char(20),
in In_Remarks char(100),
out Out_ExitIntAttachSysId integer,
out Out_ErrorCode integer)
begin
  select max(ExitIntAttachSysId) into Out_ExitIntAttachSysId from ExitIntAttach where
    ExitIntAttach.PersonalSysId = In_PersonalSysId and
    ExitIntAttach.TenderDate = In_TenderDate;
  if(Out_ExitIntAttachSysId is null) then
    set Out_ExitIntAttachSysId=1
  else
    set Out_ExitIntAttachSysId=Out_ExitIntAttachSysId+1
  end if;
  if not exists(select* from ExitIntAttach where
      ExitIntAttach.PersonalSysId = In_PersonalSysId and
      ExitIntAttach.TenderDate = In_TenderDate and
      ExitIntAttach.ExitIntAttachSysId = Out_ExitIntAttachSysId) then
    insert into ExitIntAttach(PersonalSysId,
      TenderDate,
      ExitIntAttachSysId,
      AttachFileType,
      Remarks) values(In_PersonalSysId,
      In_TenderDate,
      Out_ExitIntAttachSysId,
      In_AttachFileType,
      In_Remarks);
    commit work;
    if not exists(select* from ExitIntAttach where
        ExitIntAttach.PersonalSysId = In_PersonalSysId and
        ExitIntAttach.TenderDate = In_TenderDate and
        ExitIntAttach.ExitIntAttachSysId = Out_ExitIntAttachSysId) then
      set Out_ExitIntAttachSysId=null;
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ExitIntAttachSysId=null;
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewExitInterview(
in In_PersonalSysId integer,
in In_TenderDate date,
in In_TenderNoticePeriod integer,
in In_TenderNoticeUnit char(10),
in In_WithdrawnResign smallint,
in In_WithdrawnResignDate date,
in In_NoReEmploy smallint,
in In_Reason char(100),
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if In_PersonalSysId is null then set Out_ErrorCode=-1;
    return
  end if;
  if FGetInvalidDate(In_TenderDate) = '' then set Out_ErrorCode=-2;
    return
  end if;
  if not exists(select* from ExitInterview where PersonalSysId = In_PersonalSysId and
      TenderDate = In_TenderDate) then
    insert into ExitInterview(PersonalSysId,
      TenderDate,
      TenderNoticePeriod,
      TenderNoticeUnit,
      WithdrawnResign,
      WithdrawnResignDate,
      NoReEmploy,
      Reason,
      Remarks) values(
      In_PersonalSysId,
      In_TenderDate,
      In_TenderNoticePeriod,
      In_TenderNoticeUnit,
      In_WithdrawnResign,
      In_WithdrawnResignDate,
      In_NoReEmploy,
      In_Reason,
      In_Remarks);
    commit work;
    if not exists(select* from ExitInterview where PersonalSysId = In_PersonalSysId and
        TenderDate = In_TenderDate) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewFamily(
in In_OccupationId char(20),
in In_RelationshipId char(20),
in In_PersonalSysId integer,
in In_IdentityTypeId char(20),
in In_PersonName char(150),
in In_Gender char(1),
in In_IdentityNo char(20),
in In_DOB date,
in In_ContactNo1 char(20),
in In_ContactNo2 char(20),
in In_ContactEmail char(100),
in In_ContactAddress char(140),
in In_Country char(20),
in In_State char(20),
in In_City char(20),
in In_PostalCode char(20),
in In_FamilyCompanyName char(100),
in In_IsHandicapped smallint,
in In_ResidenceTypeId char(20),
in In_FamilyMaritalStatusCode char(20),
in In_PassportIssue char(20),
in In_IdentityCheckDigit char(5),
in In_UseChildcareFirstYear smallint,
out Out_FamilySysId integer,
out Out_ErrorCode integer)
begin
  declare Out_EmergencyContactOrder integer;
  if In_PersonalSysId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_PersonName is null then set Out_ErrorCode=-2;
    return
  end if;
  if In_RelationshipId is null then set Out_ErrorCode=-3;
    return
  end if;
  if In_ResidenceTypeId is null then set Out_ErrorCode=-4;
    return
  end if;
  if(In_RelationshipId = 'Son' or In_RelationshipId = 'Daughter') and FGetDateFormat(In_DOB) = '' then set Out_ErrorCode=-5;
    return
  end if;
  select max(EmergencyContactOrder) into Out_EmergencyContactOrder from Family where
    Family.PersonalSysId = In_PersonalSysId;
  if(Out_EmergencyContactOrder is null) then
    set Out_EmergencyContactOrder=1
  else
    set Out_EmergencyContactOrder=Out_EmergencyContactOrder+1
  end if;
  if not exists(select* from Family where PersonalSysId = In_PersonalSysId and
      PersonName = In_PersonName and RelationshipId = In_RelationshipId) then
    insert into Family(OccupationId,
      RelationshipId,
      PersonalSysId,
      IdentityTypeId,
      PersonName,
      Gender,
      IdentityNo,
      DOB,
      ContactNo1,
      ContactNo2,
      ContactEmail,
      ContactAddress,
      Country,
      State,
      City,
      PostalCode,
      EmergencyContactOrder,
      FamilyCompanyName,
      IsHandicapped,
      ResidenceTypeId,
      FamilyMaritalStatusCode,
      PassportIssue,
      IdentityCheckDigit,
      UseChildcareFirstYear) values(
      In_OccupationId,
      In_RelationshipId,
      In_PersonalSysId,
      In_IdentityTypeId,
      In_PersonName,
      In_Gender,
      In_IdentityNo,
      In_DOB,
      In_ContactNo1,
      In_ContactNo2,
      In_ContactEmail,
      In_ContactAddress,
      In_Country,
      In_State,
      In_City,
      In_PostalCode,
      Out_EmergencyContactOrder,
      In_FamilyCompanyName,
      In_IsHandicapped,
      In_ResidenceTypeId,
      In_FamilyMaritalStatusCode,
      In_PassportIssue,
      In_IdentityCheckDigit,
      In_UseChildcareFirstYear);
    commit work;
    if not exists(select* from Family where PersonalSysId = In_PersonalSysId and
        EmergencyContactOrder = Out_EmergencyContactOrder) then
      set Out_ErrorCode=0
    else
      select max(FamilySysId) into Out_FamilySysId from Family where PersonalSysId = In_PersonalSysId and
        EmergencyContactOrder = Out_EmergencyContactOrder;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewFamilyAttachment(
in In_FamilySysId integer,
in In_AttachFileType char(20),
in In_Remarks char(100),
out Out_FamilyAttachSysId integer,
out Out_ErrorCode integer)
begin
  select max(FamilyAttachSysId) into Out_FamilyAttachSysId from FamilyAttachment where
    FamilyAttachment.FamilySysId = In_FamilySysId;
  if(Out_FamilyAttachSysId is null) then
    set Out_FamilyAttachSysId=1
  else
    set Out_FamilyAttachSysId=Out_FamilyAttachSysId+1
  end if;
  if not exists(select* from FamilyAttachment where
      FamilyAttachment.FamilySysId = In_FamilySysId and
      FamilyAttachment.FamilyAttachSysId = Out_FamilyAttachSysId) then
    insert into FamilyAttachment(FamilySysId,
      FamilyAttachSysId,
      AttachFileType,
      Remarks) values(In_FamilySysId,
      Out_FamilyAttachSysId,
      In_AttachFileType,
      In_Remarks);
    commit work;
    if not exists(select* from FamilyAttachment where
        FamilyAttachment.FamilySysId = In_FamilySysId and
        FamilyAttachment.FamilyAttachSysId = Out_FamilyAttachSysId) then
      set Out_FamilyAttachSysId=null;
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_FamilyAttachSysId=null;
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewFamilyEduRec(
in In_FamilySysId integer,
in In_EducationId char(20),
in In_EduStartDate date,
in In_EduEndDate date,
in In_EduInstitution char(100),
in In_EduHighest smallint,
in In_EduResult double,
in In_EduLocal smallint,
out Out_FamilyEduRecId integer,
out Out_ErrorCode integer)
begin
  declare Out_EducationRecord integer;
  if In_EducationId is null then set Out_ErrorCode=-1;
    return
  end if;
  if FGetInvalidDate(In_EduStartDate) = '' then set Out_ErrorCode=-2;
    return
  end if;
  if FGetInvalidDate(In_EduEndDate) = '' then set Out_ErrorCode=-3;
    return
  end if;
  if(In_EduEndDate < In_EduStartDate) then set Out_ErrorCode=-4;
    return
  end if;
  if not exists(select* from FamilyEduRec where FamilySysId = In_FamilySysId and
      EducationId = In_EducationId and EduStartDate = In_EduStartDate and EduEndDate = In_EduEndDate and
      EduInsitution = In_EduInstitution and EduHighest = In_EduHighest and EduResult = In_EduResult and
      EduLocal = In_EduLocal) then
    if(In_EduHighest = 1) then
      update FamilyEduRec set EduHighest = 0 where
        FamilySysId = In_FamilySysId and EduHighest = 1
    end if;
    select count(*) into Out_EducationRecord from FamilyEduRec where
      FamilySysId = In_FamilySysId and EduHighest = 1;
    if(Out_EducationRecord = 0) then set In_EduHighest=1
    end if;
    insert into FamilyEduRec(FamilySysId,
      EducationId,
      EduStartDate,
      EduEndDate,
      EduInsitution,
      EduHighest,
      EduResult,
      EduLocal) values(
      In_FamilySysId,
      In_EducationId,
      In_EduStartDate,
      In_EduEndDate,
      In_EduInstitution,
      In_EduHighest,
      In_EduResult,
      In_EduLocal);
    commit work;
    select MAX(FamilyEduRecId) into Out_FamilyEduRecId from FamilyEduRec where FamilySysId = In_FamilySysId;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewForm(
in In_FormId char(20),
in In_NoSectionLevel integer,
in In_FormAppearIn char(20),
in In_HRFormulaId char(20),
in In_FormDesc char(100),
in In_FormRemarks char(100),
in In_FormIsStandard integer)
begin
  if not exists(select* from Form where Form.FormId = In_FormId) then
    insert into Form(FormId,HRFormulaId,FormRemarks,FormDesc,FormAppearIn,NoSectionLevel,FormIsStandard) values(
      In_FormId,In_HRFormulaId,In_FormRemarks,In_FormDesc,In_FormAppearIn,In_NoSectionLevel,In_FormIsStandard);
    commit work
  end if
end
;

create procedure dba.InsertNewFormControlProperty(
in In_FormId char(20),
in In_FormSecSysId integer,
in In_FormControlId char(50),
in In_FormFieldId char(20),
in In_CtrlOrder integer,
in In_CtrlVisible integer,
in In_CtrlShowCaption integer,
in In_CtrlCaption char(100),
in In_AppraiserOrder integer,
in In_DateValue date,
in In_BooleanValue integer,
in In_IntegerValue integer,
in In_NumericValue double,
in In_StringValue char(100))
begin
  if not exists(select* from FormControlProperty where FormControlProperty.FormId = In_FormId and
      FormControlProperty.FormSecSysId = In_FormSecSysId and
      FormControlProperty.FormControlId = In_FormControlId) then
    insert into FormControlProperty(FormId,
      FormSecSysId,
      FormControlId,
      FormFieldId,
      CtrlOrder,
      CtrlVisible,
      CtrlCaption,
      CtrlShowCaption,
      DateValue,
      BooleanValue,
      IntegerValue,
      NumericValue,
      StringValue,
      AppraiserOrder) values(In_FormId,
      In_FormSecSysId,
      In_FormControlId,
      In_FormFieldId,
      In_CtrlOrder,
      In_CtrlVisible,
      In_CtrlCaption,
      In_CtrlShowCaption,
      In_DateValue,
      In_BooleanValue,
      In_IntegerValue,
      In_NumericValue,
      In_StringValue,
      In_AppraiserOrder);
    commit work
  end if
end
;

create procedure dba.InsertNewFormPoint(
in In_FormId char(20),
in In_FormSecSysId integer,
in In_HRFormulaId char(20),
in In_FormPointOrder integer,
in In_FormPointLabel char(200),
in In_FormPointDesc char(100),
in In_FormMinPoint double,
in In_FormMaxPoint double,
out Out_FormPointSysId integer)
begin
  select max(FormPointSysId) into Out_FormPointSysId from FormPoint where
    FormPoint.FormId = In_FormId and
    FormPoint.FormSecSysId = In_FormSecSysId;
  if Out_FormPointSysId is null then set Out_FormPointSysId=0
  end if;
  if not exists(select* from FormPoint where
      FormPoint.FormId = In_FormId and
      FormPoint.FormSecSysId = In_FormSecSysId and
      FormPoint.FormPointSysId = Out_FormPointSysId+1) then
    insert into FormPoint(FormId,
      FormSecSysId,
      FormPointSysId,
      HRFormulaId,
      FormPointOrder,
      FormPointLabel,
      FormPointDesc,
      FormMinPoint,
      FormMaxPoint) values(
      In_FormId,
      In_FormSecSysId,
      (Out_FormPointSysId+1),
      In_HRFormulaId,
      In_FormPointOrder,
      In_FormPointLabel,
      In_FormPointDesc,
      In_FormMinPoint,
      In_FormMaxPoint);
    commit work;
    if not exists(select* from FormPoint where FormPoint.FormId = In_FormId and
        FormPoint.FormSecSysId = In_FormSecSysId and
        FormPoint.FormPointSysId = Out_FormPointSysId+1) then set Out_FormPointSysId=null
    else set Out_FormPointSysId=Out_FormPointSysId+1
    end if
  end if
end
;

create procedure dba.InsertNewGovernmentGrant(
in In_GovernmentGrantId char(20),
in In_GovernmentGrantDesc char(100))
begin
  if not exists(select* from GovernmentGrant where GovernmentGrantId = In_GovernmentGrantId) then
    insert into GovernmentGrant(GovernmentGrantId,GovernmentGrantDesc) values(
      In_GovernmentGrantId,In_GovernmentGrantDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewGrade(
in In_GradeCode char(20),
in In_GradeDesc char(100))
begin
  if not exists(select* from Grade where Grade.GradeCode = In_GradeCode) then
    insert into Grade(GradeCode,
      GradeDesc) values(
      In_GradeCode,
      In_GradeDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewHRFormula(
in In_HRFormulaId char(20),
in In_HRFormulaActive integer,
in In_HRFormulaCategory char(20),
in In_HRFormulaDesc char(100),
in In_HRFormulaSubCategory char(20),
in In_HRFormulaType char(20))
begin
  if not exists(select* from HRFormula where HRFormulaId = In_HRFormulaId) then
    insert into HRFormula(HrFormulaId,HRFormulaActive,HRFormulaCategory,HRFormulaDesc,HRFormulaSubCategory,HRFormulaType) values(
      In_HRFormulaId,In_HRFormulaActive,In_HRFormulaCategory,In_HRFormulaDesc,In_HRFormulaSubCategory,In_HRFormulaType);
    commit work
  end if
end
;

create procedure dba.InsertNewHRFormulaRange(
in In_HRFormulaRangeId integer,
in In_HRFormulaId char(20),
in In_Formula char(255),
in In_Maximum double,
in In_Minimum double,
in In_Constant1 double,
in In_Constant2 double,
in In_Constant3 double,
in In_Constant4 double,
in In_Constant5 double,
in In_Keywords1 char(20),
in In_Keywords2 char(20),
in In_Keywords3 char(20),
in In_Keywords4 char(20),
in In_Keywords5 char(20),
in In_Keywords6 char(20),
in In_Keywords7 char(20),
in In_Keywords8 char(20),
in In_Keywords9 char(20),
in In_Keywords10 char(20),
in In_UserDef1 char(20),
in In_UserDef2 char(20),
in In_UserDef3 char(20),
in In_UserDef4 char(20),
in In_UserDef5 char(20))
begin
  if not exists(select* from HRFormulaRange where HRFormulaRangeId = In_HRFormulaRangeId and HRFormulaId = In_HRFormulaId) then
    insert into HRFormulaRange(HRFormulaRangeId,HRFormulaId,Formula,Maximum,Minimum,Constant1,Constant2,Constant3,Constant4,Constant5,Keywords1,Keywords2,Keywords3,Keywords4,Keywords5,Keywords6,Keywords7,Keywords8,Keywords9,Keywords10,UserDef1,UserDef2,UserDef3,UserDef4,UserDef5) values(
      In_HRFormulaRangeId,In_HRFormulaId,In_Formula,In_Maximum,In_Minimum,In_Constant1,In_Constant2,In_Constant3,In_Constant4,In_Constant5,In_Keywords1,In_Keywords2,In_Keywords3,In_Keywords4,In_Keywords5,In_Keywords6,In_Keywords7,In_Keywords8,In_Keywords9,In_Keywords10,In_UserDef1,In_UserDef2,In_UserDef3,In_UserDef4,In_UserDef5);
    commit work
  end if
end
;

create procedure dba.InsertNewHRKeyword(
in In_HRKeywordId char(20),
in In_HRKeywordUserDefinedName char(100),
in In_HRKeywordDesc char(100),
in In_HRKeywordCategory char(20))
begin
  insert into HRKeyword(HRKeywordId,HRKeywordUserDefinedName,HRKeywordDesc,HRKeywordCategory) values(
    In_HRKeywordId,In_HRKeywordUserDefinedName,In_HRKeywordDesc,In_HRKeywordCategory);
  commit work
end
;

create procedure dba.InsertNewHRProject(
in In_ProjectId char(20),
in In_VenueCode char(20),
in In_ProjectName char(100),
in In_ProjectRefNo char(50),
in In_ProjectJobNo char(20),
in In_ProjectStartDate date,
in In_ProjectEndDate date,
in In_ProjectRemarks char(100),
out Out_Code integer)
begin
  if In_ProjectId is null then set Out_Code=-1;
    return
  end if;
  if In_VenueCode is null then set Out_Code=-2;
    return
  end if;
  if In_ProjectStartDate is not null and In_ProjectEndDate is not null and In_ProjectStartDate > In_ProjectEndDate then set Out_Code=-4;
    return
  end if;
  if not exists(select* from Project where ProjectId = In_ProjectId) then
    insert into Project(ProjectId,
      VenueCode,
      ProjectName,
      ProjectRefNo,
      ProjectJobNo,
      ProjectStartDate,
      ProjectEndDate,
      ProjectRemarks) values(
      In_ProjectId,
      In_VenueCode,
      In_ProjectName,
      In_ProjectRefNo,
      In_ProjectJobNo,
      In_ProjectStartDate,
      In_ProjectEndDate,
      In_ProjectRemarks);
    commit work;
    set Out_Code=1
  else
    set Out_Code=-3;
    return
  end if
end
;

create procedure dba.InsertNewHRProjectAttach(
in In_ProjectId char(20),
in In_AttachFileType char(20),
in In_AttachRemarks char(100),
out Out_Code integer)
begin
  declare MaxSysId integer;
  if exists(select* from ProjAttachment) then
    select max(ProjAttachSysId) into MaxSysId from ProjAttachment;
    set Out_Code=MaxSysId+1
  else
    set Out_Code=1
  end if;
  if In_ProjectId is null then set Out_Code=-1;
    return
  end if;
  if not exists(select* from ProjAttachment where ProjectId = In_ProjectId and
      AttachFileType = In_AttachFileType and
      AttachRemarks = In_AttachRemarks) then
    insert into ProjAttachment(ProjectId,
      ProjAttachSysId,
      AttachFileType,
      AttachRemarks) values(
      In_ProjectId,
      Out_Code,
      In_AttachFileType,
      In_AttachRemarks);
    commit work
  else
    set Out_Code=-2;
    return
  end if
end
;

create procedure dba.InsertNewHRProjectWorker(
in In_PositionId char(20),
in In_ProjectId char(20),
in In_PersonalSysId integer,
in In_ProjAttachFromDate date,
in In_ProjAttachToDate date,
in In_ProjAttachRemarks char(100),
out Out_Code integer)
begin
  declare MaxSysId integer;
  if exists(select* from ProjContractWorker) then
    select max(ProjContractWorkerSysId) into MaxSysId from ProjContractWorker;
    set Out_Code=MaxSysId+1
  else
    set Out_Code=1
  end if;
  if In_PositionId is null then set Out_Code=-1;
    return
  end if;
  if In_ProjectId is null then set Out_Code=-2;
    return
  end if;
  if In_PersonalSysId is null then set Out_Code=-3;
    return
  end if;
  if In_ProjAttachFromDate is not null and In_ProjAttachToDate is not null and In_ProjAttachFromDate > In_ProjAttachToDate then set Out_Code=-5;
    return
  end if;
  insert into ProjContractWorker(ProjContractWorkerSysId,
    PositionId,
    ProjectId,
    PersonalSysId,
    ProjAttachFromDate,
    ProjAttachToDate,
    ProjAttachRemarks) values(Out_Code,
    In_PositionId,
    In_ProjectId,
    In_PersonalSysId,
    In_ProjAttachFromDate,
    In_ProjAttachToDate,
    In_ProjAttachRemarks);
  commit work
end
;

create procedure dba.InsertNewHRTestAttach(
in In_HRTestSysId integer,
in In_AttachFileType char(20),
in In_AttachmentRemarks char(100),
out OutCode integer)
begin
  declare max_attachsysid integer;
  if exists(select* from HRTestAttach) then
    select max(HRTestAttachSysId) into max_attachsysid from HRTestAttach;
    set OutCode=max_attachsysid+1
  else
    set OutCode=1
  end if;
  if In_HRTestSysId is null then set OutCode=-1;
    return
  end if;
  if not exists(select* from HRTestAttach where HRTestSysId = In_HRTestSysId and
      AttachFileType = In_AttachFileType and
      AttachRemarks = In_AttachmentRemarks) then
    insert into HRTestAttach(HRTestSysId,HRTestAttachSysId,AttachFileType,AttachRemarks) values(
      In_HRTestSysId,OutCode,In_AttachFileType,In_AttachmentRemarks);
    commit work
  else
    set OutCode=-2;
    return
  end if
end
;

create procedure dba.InsertNewHRTestRecord(
in In_TestId char(20),
in In_PersonalSysId integer,
in In_HRTestDate date,
in In_TheoryResult double,
in In_PraticalResult double,
in In_OverallResult double,
in In_HRTestFee double,
in In_AttendancePercent double,
in In_Remarks char(100),
out Out_Code integer)
begin
  declare Max_TestSysId integer;
  if exists(select* from HRTest) then
    select Max(HRTest.HRTestSysId) into Max_TestSysId from HRTest;
    set Out_Code=Max_TestSysId+1
  else
    set Out_Code=1
  end if;
  if In_TestId is null then set Out_Code=-1;
    return
  end if;
  if In_PersonalSysId is null then set Out_Code=-2;
    return
  end if;
  if In_HRTestDate is null then set Out_Code=-3;
    return
  end if;
  if not exists(select* from HRTest where TestId = In_TestId and
      PersonalSysId = In_PersonalSysId and
      HRTestDate = In_HRTestDate) then
    insert into HRTest(HRTestSysId,
      TestId,
      PersonalSysId,
      HRTestDate,
      TheoryResult,
      PraticalResult,
      OverallResult,
      HRTestFee,
      AttendancePercent,
      Remarks) values(Out_Code,
      In_TestId,
      In_PersonalSysId,
      In_HRTestDate,
      In_TheoryResult,
      In_PraticalResult,
      In_OverallResult,
      In_HRTestFee,
      In_AttendancePercent,
      In_Remarks);
    commit work
  else
    set Out_Code=-4;
    return
  end if
end
;

create procedure dba.InsertNewIllness(
in In_IllnessId char(50),
in In_IllnessDesc char(100))
begin
  if not exists(select* from Illness where Illness.IllnessId = In_IllnessId) then
    insert into Illness(IllnessId,IllnessDesc) values(
      In_IllnessId,In_IllnessDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewInterviewer(
in In_InterviewSchSysId integer,
in In_ePortalEmployeeSysId integer,
in In_InterviewerName char(100),
in In_InterviewerPosition char(50),
in In_Remarks char(100),
in In_KeyInterviewer smallint,
out Out_InterviewerSysId integer,
out Out_ErrorCode integer)
begin
  if In_InterviewSchSysId is null then set Out_Code=-1;
    return
  end if;
  if In_InterviewerName is null then set Out_Code=-2;
    return
  end if;
  if(In_KeyInterviewer = 1) then
    update Interviewer set KeyInterviewer = 0 where
      InterviewSchSysId = In_InterviewSchSysId and KeyInterviewer = 1
  else
    if not exists(select* from Interviewer where
        Interviewer.InterviewSchSysId = In_InterviewSchSysId and KeyInterviewer = 1) then
      set In_KeyInterviewer=1
    end if
  end if;
  insert into Interviewer(InterviewSchSysId,
    ePortalEmployeeSysId,
    InterviewerName,
    InterviewerPosition,
    Remarks,
    KeyInterviewer) values(
    In_InterviewSchSysId,
    In_ePortalEmployeeSysId,
    In_InterviewerName,
    In_InterviewerPosition,
    In_Remarks,
    In_KeyInterviewer);
  commit work;
  select MAX(InterviewerSysId) into Out_InterviewerSysId from Interviewer where InterviewSchSysId = In_InterviewSchSysId;
  set Out_ErrorCode=1
end
;

create procedure dba.InsertNewInterviewSchedule(
in In_RecruitCode char(20),
in In_ApplicantSysId integer,
in In_InterviewDate date,
in In_InterviewTime time,
in In_InterviewRemarks char(100),
in In_InterviewLoc char(20),
in In_RecruitAction char(20),
in In_ApplicantResponse char(20),
in In_ApplicantRespDate date,
out Out_InterviewSchSysId integer,
out Out_ErrorCode integer)
begin
  declare Out_InterviewOrder integer;
  declare Out_ApplicantResponse char(20);
  declare Out_RecruitAction char(20);
  declare Out_InterviewDate date;
  if In_ApplicantSysId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_RecruitAction is null then set Out_ErrorCode=-2;
    return
  end if;
  if In_ApplicantResponse is null then set Out_ErrorCode=-3;
    return
  end if;
  //================================
  //if FGetInvalidDate(In_ApplicantDateTime) = '' then
  //  set In_ApplicantDateTime=null
  //end if;
  //================================
  // Get last InterviewOrder
  select max(InterviewOrder) into Out_InterviewOrder from InterviewSchedule where
    InterviewSchedule.ApplicantSysId = In_ApplicantSysId;
  if(Out_InterviewOrder is null) then
    set Out_InterviewOrder=1
  else
    set Out_InterviewOrder=Out_InterviewOrder+1;
    // Update last InterviewSchedule  
    select InterviewSchSysId,ApplicantResponse,RecruitAction,InterviewDate into Out_InterviewSchSysId,Out_ApplicantResponse,Out_RecruitAction,Out_InterviewDate from InterviewSchedule where
      InterviewSchedule.ApplicantSysId = In_ApplicantSysId and InterviewOrder = (Out_InterviewOrder-1);
    if FGetInvalidDate(Out_InterviewDate) = '' then set Out_ErrorCode=-4;
      return
    end if
  end if;
  if(Out_ApplicantResponse = 'RecruitRespAccept' and(Out_RecruitAction = 'RecruitWaitInterview' or Out_RecruitAction = 'RecruitComplete')) then
    update InterviewSchedule set RecruitAction = 'RecruitComplete' where
      InterviewSchedule.InterviewSchSysId = Out_InterviewSchSysId;
    commit work
  end if; //else set Out_ErrorCode=-4;
  //return
  // Insert New InterviewSchedule 
  if not exists(select* from InterviewSchedule where ApplicantSysId = In_ApplicantSysId and
      InterviewOrder = Out_InterviewOrder) then
    insert into InterviewSchedule(ApplicantSysId,
      InterviewDate,
      InterviewTime,
      InterviewRemarks,
      InterviewLoc,
      RecruitAction,
      ApplicantResponse,
      ApplicantRespDate,
      InterviewOrder) values(
      In_ApplicantSysId,
      In_InterviewDate,
      In_InterviewTime,
      In_InterviewRemarks,
      In_InterviewLoc,
      In_RecruitAction,
      In_ApplicantResponse,
      In_ApplicantRespDate,
      Out_InterviewOrder);
    commit work;
    if not exists(select* from InterviewSchedule where ApplicantSysId = In_ApplicantSysId and
        InterviewOrder = Out_InterviewOrder) then
      set Out_ErrorCode=0
    else
      select MAX(InterviewSchSysId) into Out_InterviewSchSysId from InterviewSchedule where ApplicantSysId = In_ApplicantSysId;
      /*
      Insert default Interviewer
      */
      InterviewerLoop: for InterviewerFor as InterviewerCurs dynamic scroll cursor for
        select ePortalEmployeeSysId as Out_ePortalEmployeeSysId,InterviewerName as Out_InterviewerName,
          InterviewerPosition as Out_InterviewerPosition,KeyInterviewer as Out_KeyInterviewer from RecruitInterviewer where
          RecruitInterviewer.RecruitCode = In_RecruitCode and RecruitInterviewer.InterviewOrder = Out_InterviewOrder do
        insert into Interviewer(InterviewSchSysId,
          ePortalEmployeeSysId,
          InterviewerName,
          InterviewerPosition,
          Remarks,KeyInterviewer) values(
          Out_InterviewSchSysId,
          Out_ePortalEmployeeSysId,
          Out_InterviewerName,
          Out_InterviewerPosition,'',Out_KeyInterviewer);
        commit work end for;
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewItem(
in In_ItemId char(20),
in In_ItemTypeId char(20),
in In_OrganisationCode char(20),
in In_ItemName char(100),
in In_PerUnitMeasure char(20),
in In_Remarks char(100),
in In_UnitAmt double,
in In_DefAssignQty integer,
in In_ModelNo char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from Item where ItemId = In_ItemId) then
    insert into Item(ItemId,
      ItemTypeId,
      OrganisationCode,
      ItemName,
      PerUnitMeasure,
      Remarks,
      UnitAmt,
      DefAssignQty,
      ModelNo) values(In_ItemId,
      In_ItemTypeId,
      In_OrganisationCode,
      In_ItemName,
      In_PerUnitMeasure,
      In_Remarks,
      In_UnitAmt,
      In_DefAssignQty,
      In_ModelNo);
    commit work;
    if not exists(select* from Item where ItemId = In_ItemId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.InsertNewItemAssignItem(
in In_ItemId char(20),
in In_PersonalSysId integer,
in In_AssignQty integer,
in In_AssignUnitAmt double,
in In_Remarks char(100),
in In_SerialNo char(20),
in In_BarCode char(20),
in In_ExpiryDate date,
in In_ReturnDate date,
in In_IsOnLoan smallint,
in In_WaivedDate date,
in In_NextIssueDate date,
in In_EffectiveDate date,
in In_IssueDate date,
in In_ePortalIssueEmpeeSysId integer,
in In_ePortalStatus char(20),
out Out_ItemAssignItemSysId integer,
out Out_ErrorCode integer)
begin
  declare Get_ItemAttrStrValue char(20);
  declare Get_ItemAttrNumValue integer;
  declare Get_ItemAttrDateValue date;
  select max(ItemAssignItemSysId) into Out_ItemAssignItemSysId from ItemAssignItem;
  if(Out_ItemAssignItemSysId is null) then
    set Out_ItemAssignItemSysId=0
  end if;
  if not exists(select* from ItemAssignItem where
      ItemAssignItemSysId = Out_ItemAssignItemSysId+1) then
    insert into ItemAssignItem(ItemAssignItemSysId,
      ItemId,
      PersonalSysId,
      AssignQty,
      AssignUnitAmt,
      Remarks,
      SerialNo,
      BarCode,
      ExpiryDate,
      ReturnDate,
      IsOnLoan,
      WaivedDate,
      NextIssueDate,
      EffectiveDate,
      IssueDate,
      ePortalIssueEmpeeSysId,
      ePortalStatus) values(Out_ItemAssignItemSysId+1,
      In_ItemId,
      In_PersonalSysId,
      In_AssignQty,
      In_AssignUnitAmt,
      In_Remarks,
      In_SerialNo,
      In_BarCode,
      In_ExpiryDate,
      In_ReturnDate,
      In_IsOnLoan,
      In_WaivedDate,
      In_NextIssueDate,
      In_EffectiveDate,
      In_IssueDate,
      In_ePortalIssueEmpeeSysId,
      In_ePortalStatus);
    commit work;
    if not exists(select* from ItemAssignItem where
        ItemAssignItemSysId = Out_ItemAssignItemSysId+1) then
      set Out_ItemAssignItemSysId=null;
      set Out_ErrorCode=0
    else
      set Out_ItemAssignItemSysId=Out_ItemAssignItemSysId+1;
      set Out_ErrorCode=1;
      ItemAttrNameIdLoop: for ItemAttrNameIdFor as Cur_ItemAttrNameId dynamic scroll cursor for
        select distinct ItemAttrValue.ItemAttrNameId as Get_ItemAttrNameId,ItemAttrValue.ItemAttrType as Get_ItemAttrType from
          ItemAttrValue where
          ItemAttrValue.ItemId = In_ItemId do
        set Get_ItemAttrStrValue='';
        set Get_ItemAttrNumValue=0;
        set Get_ItemAttrDateValue=null;
        if(Get_ItemAttrType = 'ItemAttrTypeStr') then
          select first ItemAttrStrValue into Get_ItemAttrStrValue from
            ItemAttrValue where
            ItemAttrValue.ItemId = In_ItemId and ItemAttrValue.ItemAttrNameId = Get_ItemAttrNameId order by ItemAttrStrValue asc
        elseif(Get_ItemAttrType = 'ItemAttrTypeNum') then
          select ItemAttrNumValue into Get_ItemAttrNumValue from
            ItemAttrValue where
            ItemAttrValue.ItemId = In_ItemId and ItemAttrValue.ItemAttrNameId = Get_ItemAttrNameId
        elseif(Get_ItemAttrType = 'ItemAttrTypeDate') then
          select ItemAttrDateValue into Get_ItemAttrDateValue from
            ItemAttrValue where
            ItemAttrValue.ItemId = In_ItemId and ItemAttrValue.ItemAttrNameId = Get_ItemAttrNameId
        end if;
        insert into ItemAssignAttr(ItemAssignAttrSysId,
          ItemAssignItemSysId,
          ItemAttrNameId,
          ItemAttrType,ItemAttrStrValue,ItemAttrNumValue,ItemAttrDateValue) values((select max(ItemAssignAttrSysId) from ItemAssignAttr)+1,Out_ItemAssignItemSysId,Get_ItemAttrNameId,Get_ItemAttrType,Get_ItemAttrStrValue,Get_ItemAttrNumValue,Get_ItemAttrDateValue);
        commit work end for
    end if
  else
    set Out_ItemAssignItemSysId=null;
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewItemAttrName(
in In_ItemAttrNameId char(20),
in In_ItemAttrNameDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from ItemAttrName where ItemAttrName.ItemAttrNameId = In_ItemAttrNameId) then
    insert into ItemAttrName(ItemAttrNameId,ItemAttrNameDesc) values(
      In_ItemAttrNameId,In_ItemAttrNameDesc);
    commit work;
    if not exists(select* from ItemAttrName where ItemAttrName.ItemAttrNameId = In_ItemAttrNameId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewItemAttrValue(
in In_ItemAttrNameId char(20),
in In_ItemId char(20),
in In_ItemAttrType char(20),
in In_ItemAttrStrValue char(20),
in In_ItemAttrNumValue double,
in In_ItemAttrDateValue date,
out Out_ItemAttrValueSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from ItemAttrValue where ItemId = In_ItemId and ItemAttrNameId = In_ItemAttrNameId and ItemAttrType = 'ItemAttrTypeStr') then
    if(In_ItemAttrType <> 'ItemAttrTypeStr') then
      set Out_ErrorCode=-2;
      return
    end if
  else if exists(select* from ItemAttrValue where ItemId = In_ItemId and ItemAttrNameId = In_ItemAttrNameId) then
      set Out_ErrorCode=-2;
      return
    end if
  end if;
  if exists(select* from ItemAttrValue where ItemId = In_ItemId and ItemAttrNameId = In_ItemAttrNameId and ItemAttrType = 'ItemAttrTypeStr' and ItemAttrStrValue = In_ItemAttrStrValue) then
    set Out_ErrorCode=-3;
    return
  end if;
  select max(ItemAttrValueSysId) into Out_ItemAttrValueSysId from ItemAttrValue;
  if(Out_ItemAttrValueSysId is null) then
    set Out_ItemAttrValueSysId=0
  end if;
  if not exists(select* from ItemAttrValue where
      ItemAttrValueSysId = Out_ItemAttrValueSysId+1) then
    insert into ItemAttrValue(ItemAttrValueSysId,
      ItemAttrNameId,
      ItemId,
      ItemAttrType,
      ItemAttrStrValue,
      ItemAttrNumValue,
      ItemAttrDateValue) values(Out_ItemAttrValueSysId+1,
      In_ItemAttrNameId,
      In_ItemId,
      In_ItemAttrType,
      In_ItemAttrStrValue,
      In_ItemAttrNumValue,
      In_ItemAttrDateValue);
    commit work;
    if not exists(select* from ItemAttrValue where
        ItemAttrValueSysId = Out_ItemAttrValueSysId+1) then
      set Out_ItemAttrValueSysId=null;
      set Out_ErrorCode=0
    else
      set Out_ItemAttrValueSysId=Out_ItemAttrValueSysId+1;
      set Out_ErrorCode=1;
      ItemBAssignSysIdLoop: for ItemBAssignSysIdFor as Cur_ItemBAssignSysId dynamic scroll cursor for
        select distinct ItemBAssgn.ItemBAssignSysId as Get_ItemBAssignSysId from
          ItemBAssgn where
          ItemBAssgn.ItemId = In_ItemId do
        insert into ItemBAssignAttr(ItemBAssignAttrSysId,
          ItemBAssignSysId,
          ItemAttrNameId,
          ItemAttrType,ItemAttrStrValue,ItemAttrNumValue,ItemAttrDateValue) values((select max(ItemBAssignAttrSysId) from ItemBAssignAttr)+1,Get_ItemBAssignSysId,In_ItemAttrNameId,In_ItemAttrType,In_ItemAttrStrValue,In_ItemAttrNumValue,In_ItemAttrDateValue);
        commit work end for
    end if
  else
    set Out_ItemAttrValueSysId=null;
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewItemBAssgn(
in In_ItemId char(20),
in In_ItemBatchId char(20),
in In_AssignQty integer,
in In_AssignUnitAmt double,
in In_Remarks char(100),
in In_ExpiryDate date,
in In_IsOnLoan smallint,
in In_WaivedDate date,
in In_NextIssueDate date,
in In_EffectiveDate date,
in In_IssueDate date,
in In_IssueByEmpeeSysId integer,
out Out_ItemBAssignSysId integer,
out Out_ErrorCode integer)
begin
  declare Get_ItemAttrStrValue char(20);
  declare Get_ItemAttrNumValue integer;
  declare Get_ItemAttrDateValue date;
  select max(ItemBAssignSysId) into Out_ItemBAssignSysId from ItemBAssgn;
  if(Out_ItemBAssignSysId is null) then
    set Out_ItemBAssignSysId=0
  end if;
  if not exists(select* from ItemBAssgn where
      ItemBAssignSysId = Out_ItemBAssignSysId+1) then
    insert into ItemBAssgn(ItemBAssignSysId,
      ItemId,
      ItemBatchId,
      AssignQty,
      AssignUnitAmt,
      Remarks,
      ExpiryDate,
      IsOnLoan,
      WaivedDate,
      NextIssueDate,
      EffectiveDate,
      IssueDate,
      IssueByEmpeeSysId) values(Out_ItemBAssignSysId+1,
      In_ItemId,
      In_ItemBatchId,
      In_AssignQty,
      In_AssignUnitAmt,
      In_Remarks,
      In_ExpiryDate,
      In_IsOnLoan,
      In_WaivedDate,
      In_NextIssueDate,
      In_EffectiveDate,
      In_IssueDate,
      IssueByEmpeeSysId);
    commit work;
    if not exists(select* from ItemBAssgn where
        ItemBAssignSysId = Out_ItemBAssignSysId+1) then
      set Out_ItemBAssignSysId=null;
      set Out_ErrorCode=0
    else
      set Out_ItemBAssignSysId=Out_ItemBAssignSysId+1;
      set Out_ErrorCode=1;
      ItemAttrNameIdLoop: for ItemAttrNameIdFor as Cur_ItemAttrNameId dynamic scroll cursor for
        select distinct ItemAttrValue.ItemAttrNameId as Get_ItemAttrNameId,ItemAttrValue.ItemAttrType as Get_ItemAttrType from
          ItemAttrValue where
          ItemAttrValue.ItemId = In_ItemId do
        set Get_ItemAttrStrValue='';
        set Get_ItemAttrNumValue=0;
        set Get_ItemAttrDateValue=null;
        if(Get_ItemAttrType = 'ItemAttrTypeStr') then
          select first ItemAttrStrValue into Get_ItemAttrStrValue from
            ItemAttrValue where
            ItemAttrValue.ItemId = In_ItemId and ItemAttrValue.ItemAttrNameId = Get_ItemAttrNameId order by ItemAttrStrValue asc
        elseif(Get_ItemAttrType = 'ItemAttrTypeNum') then
          select ItemAttrNumValue into Get_ItemAttrNumValue from
            ItemAttrValue where
            ItemAttrValue.ItemId = In_ItemId and ItemAttrValue.ItemAttrNameId = Get_ItemAttrNameId
        elseif(Get_ItemAttrType = 'ItemAttrTypeDate') then
          select ItemAttrDateValue into Get_ItemAttrDateValue from
            ItemAttrValue where
            ItemAttrValue.ItemId = In_ItemId and ItemAttrValue.ItemAttrNameId = Get_ItemAttrNameId
        end if;
        insert into ItemBAssignAttr(ItemBAssignAttrSysId,
          ItemBAssignSysId,
          ItemAttrNameId,
          ItemAttrType,ItemAttrStrValue,ItemAttrNumValue,ItemAttrDateValue) values((select max(ItemBAssignAttrSysId) from ItemBAssignAttr)+1,Out_ItemBAssignSysId,Get_ItemAttrNameId,Get_ItemAttrType,Get_ItemAttrStrValue,Get_ItemAttrNumValue,Get_ItemAttrDateValue);
        commit work end for
    end if
  else
    set Out_ItemBAssignSysId=null;
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewItemBatch(
in In_ItemBatchId char(20),
in In_ItemBatchDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from ItemBatch where ItemBatch.ItemBatchId = In_ItemBatchId) then
    insert into ItemBatch(ItemBatchId,
      ItemBatchDesc) values(
      In_ItemBatchId,
      In_ItemBatchDesc);
    if not exists(select* from ItemBatch where ItemBatch.ItemBatchId = In_ItemBatchId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=-1
  end if
end
;

create procedure dba.InsertNewItemType(
in In_ItemTypeId char(20),
in In_ItemTypeDesc char(100))
begin
  if not exists(select* from ItemType where ItemTypeId = In_ItemTypeId) then
    insert into ItemType(ItemTypeId,ItemTypeDesc) values(
      In_ItemTypeId,In_ItemTypeDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewJobAdAttach(
in In_RecruitCode char(20),
in In_AttachFileType char(20),
in In_AttachDate date,
in In_AttachRemarks char(100),
out Out_JobAdAttachSysId integer,
out Out_ErrorCode integer)
begin
  select max(distinct JobAdAttachSysId) into Out_JobAdAttachSysId from JobAdAttach where
    JobAdAttach.RecruitCode = In_RecruitCode;
  if(Out_JobAdAttachSysId is null) then
    set Out_JobAdAttachSysId=1
  else
    set Out_JobAdAttachSysId=Out_JobAdAttachSysId+1
  end if;
  if not exists(select* from JobAdAttach where
      JobAdAttach.RecruitCode = In_RecruitCode and
      JobAdAttach.JobAdAttachSysId = Out_JobAdAttachSysId) then
    insert into JobAdAttach(RecruitCode,
      JobAdAttachSysId,
      AttachFileType,
      AttachDate,
      AttachRemarks) values(In_RecruitCode,
      Out_JobAdAttachSysId,
      In_AttachFileType,
      In_AttachDate,
      In_AttachRemarks);
    commit work;
    if not exists(select* from JobAdAttach where
        JobAdAttach.RecruitCode = In_RecruitCode and
        JobAdAttach.JobAdAttachSysId = Out_JobAdAttachSysId) then
      set Out_JobAdAttachSysId=null;
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_JobAdAttachSysId=null;
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewJobGrade(
in In_JobGrade char(20),
in In_JobGradeDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from JobGrade where JobGrade = In_JobGrade) then
    insert into JobGrade(JobGrade,JobGradeDesc) values(
      In_JobGrade,In_JobGradeDesc);
    commit work;
    if not exists(select* from JobGrade where JobGrade = In_JobGrade) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewJobHistory(
in In_PersonalSysId integer,
in In_EmployedDate date,
in In_EmploymentTypeId char(20),
in In_OrgIndustryId char(20),
in In_OrgTypeId char(20),
in In_CessationDate date,
in In_CompanyName char(100),
in In_JobTitle char(50),
in In_StartSalary double,
in In_EndSalary double,
in In_SalaryType char(20),
in In_ReasonLeaving char(100),
in In_JobGrade char(20),
in In_IsNS integer,
out Out_ErrorCode integer)
begin
  if FGetInvalidDate(In_EmployedDate) = '' then set Out_ErrorCode=-1;
    return
  end if;
  // if FGetInvalidDate(In_CessationDate) = '' then set Out_ErrorCode=-2;
  // return
  // end if;
  if FGetInvalidDate(In_CessationDate) <> '' then
    if(In_CessationDate < In_EmployedDate) then set Out_ErrorCode=-3;
      return
    end if
  end if;
  if In_CompanyName is null then set Out_ErrorCode=-4;
    return
  end if;
  if In_JobTitle is null then set Out_ErrorCode=-5;
    return
  end if;
  if not exists(select* from JobHistory where PersonalSysId = In_PersonalSysId and
      EmployedDate = In_EmployedDate) then
    insert into JobHistory(PersonalSysId,
      EmployedDate,
      EmploymentTypeId,
      OrgIndustryId,
      OrgTypeId,
      CessationDate,
      CompanyName,
      JobTitle,
      StartSalary,
      EndSalary,
      SalaryType,
      ReasonLeaving,
      JobGrade,
      IsNS) values(
      In_PersonalSysId,
      In_EmployedDate,
      In_EmploymentTypeId,
      In_OrgIndustryId,
      In_OrgTypeId,
      In_CessationDate,
      In_CompanyName,
      In_JobTitle,
      In_StartSalary,
      In_EndSalary,
      In_SalaryType,
      In_ReasonLeaving,
      In_JobGrade,
      In_IsNS);
    commit work;
    if not exists(select* from JobHistory where PersonalSysId = In_PersonalSysId and
        EmployedDate = In_EmployedDate) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewJobOpenTo(
in In_JobOpenToId char(20),
in In_JobOpenToDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from JobOpenTo where JobOpenTo.JobOpenToId = In_JobOpenToId) then
    insert into JobOpenTo(JobOpenToId,JobOpenToDesc) values(
      In_JobOpenToId,In_JobOpenToDesc);
    commit work;
    if not exists(select* from JobOpenTo where JobOpenTo.JobOpenToId = In_JobOpenToId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewJobResponsibility(
in In_ResponsibilityId char(20),
in In_EmployeeSysId integer,
in In_JobResponEffectiveDate date,
in In_ExpiryDate date,
in In_FreqPercent integer,
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from JobRespon where JobRespon.ResponsibilityId = In_ResponsibilityId and JobRespon.EmployeeSysId = In_EmployeeSysId and JobRespon.JobResponEffectiveDate = In_JobResponEffectiveDate) then
    set Out_ErrorCode=-1; // Record exists
    return
  elseif not In_ResponsibilityId = any(select ResponsibilityId from Responsibility) then
    set Out_ErrorCode=-2; // ResponsibilityId not exist
    return
  elseif not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-3; // EmployeeSysId not exist
    return
  elseif In_ExpiryDate < In_JobResponEffectiveDate then
    set Out_ErrorCode=-4; // Invalid date range
    return
  elseif In_FreqPercent < 0 or In_FreqPercent > 100 then
    set Out_ErrorCode=-5; // Invalid FreqPercent
    return
  else
    insert into JobRespon(ResponsibilityId,EmployeeSysId,JobResponEffectiveDate,ExpiryDate,FreqPercent,Remarks) values(
      In_ResponsibilityId,In_EmployeeSysId,In_JobResponEffectiveDate,In_ExpiryDate,In_FreqPercent,In_Remarks);
    commit work
  end if;
  if not exists(select* from JobRespon where JobRespon.ResponsibilityId = In_ResponsibilityId and JobRespon.EmployeeSysId = In_EmployeeSysId and JobRespon.JobResponEffectiveDate = In_JobResponEffectiveDate) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.InsertNewMClaimAttachment(
in In_MedClaimFileType char(20),
in In_MedClaimSysId integer,
in In_Remarks char(200),
out Out_MedClaimAttachSysId integer)
begin
  select max(MedClaimAttachSysId) into Out_MedClaimAttachSysId from MClaimAttachment;
  if Out_MedClaimAttachSysId is null then set Out_MedClaimAttachSysId=0
  end if;
  if not exists(select* from MClaimAttachment where
      MClaimAttachment.MedClaimAttachSysId = Out_MedClaimAttachSysId+1) then
    insert into MClaimAttachment(MedClaimAttachSysId,MedClaimFileType,MedClaimSysId,Remarks) values(
      (Out_MedClaimAttachSysId+1),In_MedClaimFileType,In_MedClaimSysId,In_Remarks);
    commit work;
    if not exists(select* from MClaimAttachment where MClaimAttachment.MedClaimAttachSysId = Out_MedClaimAttachSysId+1) then set Out_MedClaimAttachSysId=null
    else set Out_MedClaimAttachSysId=Out_MedClaimAttachSysId+1
    end if
  end if
end
;

create procedure dba.InsertNewMClaimPolicy(
in In_MedClaimPolicyId char(20),
in In_MedClaimPolicyDesc char(100),
in In_MedClaimPolicyBasis char(20),
in In_MedClaimDateBasis integer)
begin
  if not exists(select* from MClaimPolicy where MClaimPolicy.MedClaimPolicyId = In_MedClaimPolicyId) then
    insert into MClaimPolicy(MedClaimPolicyId,MedClaimPolicyDesc,MedClaimPolicyBasis,MedClaimDateBasis) values(
      In_MedClaimPolicyId,In_MedClaimPolicyDesc,In_MedClaimPolicyBasis,In_MedClaimDateBasis);
    commit work
  end if
end
;

create procedure dba.InsertNewMClaimReason(
in In_MedClaimReasonId char(50),
in In_MedClaimReasonDesc char(100))
begin
  if not exists(select* from MClaimReason where MClaimReason.MedClaimReasonId = In_MedClaimReasonId) then
    insert into MClaimReason(MedClaimReasonId,MedClaimReasonDesc) values(
      In_MedClaimReasonId,In_MedClaimReasonDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewMClaimType(
in In_MedClaimTypeId char(20),
in In_MedClaimTypeDesc char(100),
in In_MedClaimRangeBasis char(20),
in In_LimitPerCycle double,
in In_PayrollPayElementId char(20),
in In_MedClaimFunctionId char(20),
in In_SubjNoPerPolicy smallint,
in In_ProrateMethod char(20),
in In_ProrateHire smallint,
in In_ProrateCessation smallint,
in In_LimitPerCycleType char(20),
in In_LimitPerCycleKeyword char(20))
begin
  if not exists(select* from MClaimType where MClaimType.MedClaimTypeId = In_MedClaimTypeId) then
    insert into MClaimType(MedClaimTypeId,
      MedClaimTypeDesc,
      MedClaimRangeBasis,
      LimitPerCycle,
      PayrollPayElementId,
      MedClaimFunctionId,
      SubjNoPerPolicy,
      ProrateMethod,
      ProrateHire,
      ProrateCessation,
      LimitPerCycleType,
      LimitPerCycleKeyword) values(
      In_MedClaimTypeId,
      In_MedClaimTypeDesc,
      In_MedClaimRangeBasis,
      In_LimitPerCycle,
      In_PayrollPayElementId,
      In_MedClaimFunctionId,
      In_SubjNoPerPolicy,
      In_ProrateMethod,
      In_ProrateHire,
      In_ProrateCessation,
      In_LimitPerCycleType,
      In_LimitPerCycleKeyword);
    commit work
  end if
end
;

create procedure dba.InsertNewMClaimTypeRange(
in In_MedClaimTypeId char(20),
in In_MedClaimStringMatch char(20),
in In_MedClaimRangeFrom double,
in In_MedClaimRangeTo double,
in In_CoPaymentType integer,
in In_CoPaymentAmtPercent double,
in In_LimitPerClaim double,
out Out_MedClaimTypeSysId integer)
begin
  select Max(MedClaimTypeSysId) into Out_MedClaimTypeSysId from MClaimTypeRange;
  if(Out_MedClaimTypeSysId is null) then set Out_MedClaimTypeSysId=1
  else set Out_MedClaimTypeSysId=Out_MedClaimTypeSysId+1
  end if;
  insert into MClaimTypeRange(MedClaimTypeSysId,MedClaimTypeId,MedClaimStringMatch,MedClaimRangeFrom,MedClaimRangeTo,CoPaymentType,CoPaymentAmtPercent,LimitPerClaim) values(
    Out_MedClaimTypeSysId,In_MedClaimTypeId,In_MedClaimStringMatch,In_MedClaimRangeFrom,In_MedClaimRangeTo,In_CoPaymentType,In_CoPaymentAmtPercent,In_LimitPerClaim);
  commit work
end
;

create procedure dba.InsertNewMedClaim(
in In_MedClaimTypeId char(20),
in In_MedClaimReasonId char(20),
in In_PersonalSysId integer,
in In_IllnessId char(50),
in In_TreatmentTypeId char(20),
in In_SubmissionDate date,
in In_MedClaimNo char(20),
in In_MedReceiptDate date,
in In_ClaimAmount double,
in In_ReimburseAmt double,
in In_MedClaimAppr smallint,
in In_PayrollDate date,
in In_MedClaimPaid smallint,
in In_PayrollProcessDate date,
in In_PayrollEmployeeSysId integer,
in In_PayrollYear integer,
in In_PayrollPeriod integer,
in In_PayrollSubPeriod integer,
in In_VendorBilled smallint,
in In_Vendor char(20),
in In_VendorAmount double,
in In_UseMedSaveClaim smallint,
in In_InsuranceClaim smallint,
in In_InsuranceRefNo char(50),
in In_HospitalClinic char(20),
in In_TreatmentFrom date,
in In_TreatmentTo date,
in In_TreatmentLength double,
in In_ePortalStatus char(20),
in In_MedExRecSysId integer,
in In_Remarks char(200),
out Out_MedClaimSysId integer)
begin
  select max(MedClaimSysId) into Out_MedClaimSysId from MedClaim;
  if Out_MedClaimSysId is null then set Out_MedClaimSysId=0
  end if;
  if not exists(select* from MedClaim where
      MedClaim.MedClaimSysId = Out_MedClaimSysId+1) then
    insert into MedClaim(MedClaimSysId,
      MedClaimTypeId,
      MedClaimReasonId,
      PersonalSysId,
      IllnessId,
      TreatmentTypeId,
      SubmissionDate,
      MedClaimNo,
      MedReceiptDate,
      ClaimAmount,
      ReimburseAmt,
      MedClaimAppr,
      PayrollDate,
      MedClaimPaid,
      PayrollProcessDate,
      PayrollEmployeeSysId,
      PayrollYear,
      PayrollPeriod,
      PayrollSubPeriod,
      VendorBilled,
      Vendor,
      VendorAmount,
      UseMedSaveClaim,
      InsuranceClaim,
      InsuranceRefNo,
      HospitalClinic,
      TreatmentFrom,
      TreatmentTo,
      TreatmentLength,
      MedExRecSysId,
      Remarks,
      ePortalStatus) values(
      (Out_MedClaimSysId+1),
      In_MedClaimTypeId,
      In_MedClaimReasonId,
      In_PersonalSysId,
      In_IllnessId,
      In_TreatmentTypeId,
      In_SubmissionDate,
      In_MedClaimNo,
      In_MedReceiptDate,
      In_ClaimAmount,
      In_ReimburseAmt,
      In_MedClaimAppr,
      In_PayrollDate,
      In_MedClaimPaid,
      In_PayrollProcessDate,
      In_PayrollEmployeeSysId,
      In_PayrollYear,
      In_PayrollPeriod,
      In_PayrollSubPeriod,
      In_VendorBilled,
      In_Vendor,
      In_VendorAmount,
      In_UseMedSaveClaim,
      In_InsuranceClaim,
      In_InsuranceRefNo,
      In_HospitalClinic,
      In_TreatmentFrom,
      In_TreatmentTo,
      In_TreatmentLength,
      In_MedExRecSysId,
      In_Remarks,
      In_ePortalStatus);
    commit work;
    if not exists(select* from MedClaim where MedClaim.MedClaimSysId = Out_MedClaimSysId+1) then set Out_MedClaimSysId=null
    else set Out_MedClaimSysId=Out_MedClaimSysId+1
    end if
  end if
end
;

create procedure dba.InsertNewMedClaimHistory(
in In_MedClaimSysId integer,
in In_MClaimPolicyId char(20),
in In_MClaimPolicyBasisValue char(20),
in In_MClaimTypeBasisValue char(20),
in In_MedClaimCycleStart date,
in In_MedClaimCycleEnd date,
in In_LimitPerClaim double,
in In_LimitPerCycle double,
in In_LimitPerPolicy double,
in In_NoLimitPerPolicy integer,
in In_CoPaymentType integer,
in In_CoPaymentAmtPercent double,
in In_MedClaimCompanyPay double,
in In_MedClaimEmployeePay double)
begin
  if not exists(select* from MedClaimHistory where MedClaimSysId = In_MedClaimSysId) then
    insert into MedClaimHistory(MedClaimSysId,
      MClaimPolicyId,
      MClaimPolicyBasisValue,
      MClaimTypeBasisValue,
      MedClaimCycleStart,
      MedClaimCycleEnd,
      LimitPerClaim,
      LimitPerCycle,
      LimitPerPolicy,
      NoLimitPerPolicy,
      CoPaymentType,
      CoPaymentAmtPercent,MedClaimCompanyPay,MedClaimEmployeePay) values(
      In_MedClaimSysId,
      In_MClaimPolicyId,
      In_MClaimPolicyBasisValue,
      In_MClaimTypeBasisValue,
      In_MedClaimCycleStart,
      In_MedClaimCycleEnd,
      In_LimitPerClaim,
      In_LimitPerCycle,
      In_LimitPerPolicy,
      In_NoLimitPerPolicy,
      In_CoPaymentType,
      In_CoPaymentAmtPercent,
      In_MedClaimCompanyPay,
      In_MedClaimEmployeePay);
    commit work
  end if
end
;

create procedure dba.InsertNewMedExDetType(
in In_MedExDetTypeId char(20),
in In_MedExDetTypeDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from MedExDetType where MedExDetTypeId = In_MedExDetTypeId) then
    insert into MedExDetType(MedExDetTypeId,MedExDetTypeDesc) values(
      In_MedExDetTypeId,In_MedExDetTypeDesc);
    commit work;
    if not exists(select* from MedExDetType where MedExDetTypeId = In_MedExDetTypeId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewMedExRec(
in In_ReviewTypeId char(20),
in In_PersonalSysId integer,
in In_ReceiptNo char(20),
in In_ReceiptDate date,
in In_ePortalStatus char(20),
in In_ePortalEmployeeSysId integer,
in In_ReviewDate date,
in In_ReviewFee double,
in In_Remarks char(100),
in In_FollowUpDate date,
out Out_MedExRecSysId integer,
out Out_ErrorCode integer)
begin
  declare MedRecId integer;
  select MAX(MedExRecSysId) into MedRecId from MedExRec where PersonalSysId = In_PersonalSysId;
  if MedRecId is null then set MedRecId=0
  end if;
  if not exists(select* from MedExRec where ReviewTypeId = In_ReviewTypeId and PersonalSysId = In_PersonalSysId and
      ReceiptNo = In_ReceiptNo and ReceiptDate = In_ReceiptDate and ePortalStatus = In_ePortalStatus and
      ePortalEmployeeSysId = In_ePortalEmployeeSysId and ReviewDate = In_ReviewDate and ReviewFee = In_ReviewFee and
      Remarks = In_Remarks and FollowUpDate = In_FollowUpDate) then
    insert into MedExRec(ReviewTypeId,
      PersonalSysId,
      ReceiptNo,
      ReceiptDate,
      ePortalStatus,
      ePortalEmployeeSysId,
      ReviewDate,
      ReviewFee,
      Remarks,
      FollowUpDate) values(
      In_ReviewTypeId,
      In_PersonalSysId,
      In_ReceiptNo,
      In_ReceiptDate,
      In_ePortalStatus,
      In_ePortalEmployeeSysId,
      In_ReviewDate,
      In_ReviewFee,
      In_Remarks,
      In_FollowUpDate);
    commit work;
    select MAX(MedExRecSysId) into Out_MedExRecSysId from MedExRec where PersonalSysId = In_PersonalSysId;
    if Out_MedExRecSysId is null then set Out_MedExRecSysId=0
    end if;
    if MedRecId = Out_MedExRecSysId then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewMedia(
in In_MediaId char(20),
in In_MediaDesc char(100),
in In_MediaLang char(20),
out Out_ErrorCode integer)
begin
  if not exists(select* from Media where Media.MediaId = In_MediaId) then
    insert into Media(MediaId,MediaDesc,MediaLang) values(
      In_MediaId,In_MediaDesc,In_MediaLang);
    commit work;
    if not exists(select* from Media where Media.MediaId = In_MediaId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewMediHistory(
in In_IllnessId char(50),
in In_PersonalSysId integer,
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if In_PersonalSysId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_IllnessId is null then set Out_ErrorCode=-2;
    return
  end if;
  if not exists(select* from MediHistory where IllnessId = In_IllnessId and PersonalSysId = In_PersonalSysId) then
    insert into MediHistory(IllnessId,
      PersonalSysId,
      Remarks) values(
      In_IllnessId,
      In_PersonalSysId,
      In_Remarks);
    commit work;
    if not exists(select* from MediHistory where IllnessId = In_IllnessId and PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewMediHistoryAttach(
in In_IllnessId char(50),
in In_PersonalSysId integer,
in In_AttachFileType char(20),
in In_AttachRemarks char(100),
out Out_MediHistoryAttachSysId integer,
out Out_ErrorCode integer)
begin
  select max(MediHistoryAttachSysId) into Out_MediHistoryAttachSysId from MediHistoryAttach where
    MediHistoryAttach.IllnessId = In_IllnessId and MediHistoryAttach.PersonalSysId = In_PersonalSysId;
  if(Out_MediHistoryAttachSysId is null) then
    set Out_MediHistoryAttachSysId=1
  else
    set Out_MediHistoryAttachSysId=Out_MediHistoryAttachSysId+1
  end if;
  if not exists(select* from MediHistoryAttach where
      MediHistoryAttach.IllnessId = In_IllnessId and MediHistoryAttach.PersonalSysId = In_PersonalSysId and
      MediHistoryAttach.MediHistoryAttachSysId = Out_MediHistoryAttachSysId) then
    insert into MediHistoryAttach(IllnessId,
      PersonalSysId,
      MediHistoryAttachSysId,
      AttachFileType,
      AttachRemarks) values(In_IllnessId,
      In_PersonalSysId,
      Out_MediHistoryAttachSysId,
      In_AttachFileType,
      In_AttachRemarks);
    commit work;
    if not exists(select* from MediHistoryAttach where
        MediHistoryAttach.IllnessId = In_IllnessId and MediHistoryAttach.PersonalSysId = In_PersonalSysId and
        MediHistoryAttach.MediHistoryAttachSysId = Out_MediHistoryAttachSysId) then
      set Out_MediHistoryAttachSysId=null;
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_MediHistoryAttachSysId=null;
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewMembershipCode(
in In_OrganisationCode char(20),
in In_MembershipCode char(20),
in In_MembershipDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from MembershipCode where OrganisationCode = In_OrganisationCode and
      MembershipCode = In_MembershipCode) then
    insert into MembershipCode(OrganisationCode,MembershipCode,MembershipDesc) values(
      In_OrganisationCode,In_MembershipCode,In_MembershipDesc);
    commit work;
    if not exists(select* from MembershipCode where OrganisationCode = In_OrganisationCode and
        MembershipCode = In_MembershipCode) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewMemship(
in In_PersonalSysId integer,
in In_OrganisationCode char(20),
in In_MembershipCode char(20),
in In_MemId char(20),
in In_MemEnrollDate date,
in In_MemExpiryDate date,
in In_MemFee double,
in In_PayrollDate date,
in In_PayrollEmployeeSysId integer,
in In_PayrollPayElement char(20),
in In_PayrollYear integer,
in In_PayrollPeriod integer,
in In_PayrollSubPeriod integer,
in In_PayrollProcessDate date,
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if In_PersonalSysId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_OrganisationCode is null then set Out_ErrorCode=-2;
    return
  end if;
  if not exists(select* from MembershipCode where OrganisationCode = In_OrganisationCode) then set Out_ErrorCode=-3;
    return
  end if;
  if In_MembershipCode is null then set Out_ErrorCode=-4;
    return
  end if;
  if not exists(select* from MembershipCode where MembershipCode = In_MembershipCode) then set Out_ErrorCode=-5;
    return
  end if;
  if not exists(select* from MembershipCode where MembershipCode = In_MembershipCode and
      OrganisationCode = In_OrganisationCode) then set Out_ErrorCode=-6;
    return
  end if;
  if FGetInvalidDate(In_MemEnrollDate) = '' then set Out_ErrorCode=-7;
    return
  end if;
  if(FGetInvalidDate(In_MemExpiryDate) <> '') and(In_MemExpiryDate < In_MemEnrollDate) then set Out_ErrorCode=-8;
    return
  end if;
  if not exists(select* from Memship where PersonalSysId = In_PersonalSysId and
      OrganisationCode = In_OrganisationCode and
      MembershipCode = In_MembershipCode and
      MemEnrollDate = In_MemEnrollDate and
      MemExpiryDate = In_MemExpiryDate) then
    insert into Memship(PersonalSysId,
      OrganisationCode,
      MembershipCode,
      MemId,
      MemEnrollDate,
      MemExpiryDate,
      MemFee,
      PayrollDate,
      PayrollEmployeeSysId,
      PayrollPayElement,
      PayrollYear,
      PayrollPeriod,
      PayrollSubPeriod,
      PayrollProcessDate,
      Remarks) values(
      In_PersonalSysId,
      In_OrganisationCode,
      In_MembershipCode,
      In_MemId,
      In_MemEnrollDate,
      In_MemExpiryDate,
      In_MemFee,
      In_PayrollDate,
      In_PayrollEmployeeSysId,
      In_PayrollPayElement,
      In_PayrollYear,
      In_PayrollPeriod,
      In_PayrollSubPeriod,
      In_PayrollProcessDate,
      In_Remarks);
    commit work;
    if not exists(select* from Memship where PersonalSysId = In_PersonalSysId and
        OrganisationCode = In_OrganisationCode and
        MembershipCode = In_MembershipCode and
        MemEnrollDate = In_MemEnrollDate and
        MemExpiryDate = In_MemExpiryDate) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewOffenceType(
in In_OffenceType char(20),
in In_OffenceTypeDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from OffenceType where OffenceType = In_OffenceType) then
    insert into OffenceType(OffenceType,OffenceTypeDesc) values(
      In_OffenceType,In_OffenceTypeDesc);
    commit work;
    if not exists(select* from OffenceType where OffenceType = In_OffenceType) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewOrganisation(
in In_OrganisationCode char(20),
in In_OrgIndustryId char(20),
in In_OrgTypeId char(20),
in In_OrganisationName char(100),
in In_OrganisationRefNo char(20),
in In_OrganisationURL char(100),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_Country char(20),
in In_City char(20),
in In_State char(20),
in In_PCode char(20),
in In_ContactNo1 char(20),
in In_ContactNo2 char(20),
in In_ContactEmail char(100),
in In_ContactFax char(20),
in In_IsMedicalVendor smallint,
in In_IsTrainingOrganiser smallint,
in In_IsMembership smallint,
in In_IsSupplier smallint,
in In_IsContractor smallint,
in In_ContractorCode char(20),
in In_ContractCategoryId char(20))
begin
  if not exists(select* from Organisation where Organisation.OrganisationCode = In_OrganisationCode) then
    insert into Organisation(OrganisationCode,
      OrgIndustryId,
      OrgTypeId,
      OrganisationName,
      OrganisationRefNo,
      OrganisationURL,
      Address1,
      Address2,
      Address3,
      Country,
      City,
      State,
      PCode,
      ContactNo1,
      ContactNo2,
      ContactEmail,
      ContactFax,
      IsMedicalVendor,
      IsTrainingOrganiser,
      IsMembership,
      IsSupplier,
      IsContractor,
      ContractorCode,
      ContractCategoryId) values(
      In_OrganisationCode,
      In_OrgIndustryId,
      In_OrgTypeId,
      In_OrganisationName,
      In_OrganisationRefNo,
      In_OrganisationURL,
      In_Address1,
      In_Address2,
      In_Address3,
      In_Country,
      In_City,
      In_State,
      In_PCode,
      In_ContactNo1,
      In_ContactNo2,
      In_ContactEmail,
      In_ContactFax,
      In_IsMedicalVendor,
      In_IsTrainingOrganiser,
      In_IsMembership,
      In_IsSupplier,
      In_IsContractor,
      In_ContractorCode,
      In_ContractCategoryId);
    commit work
  end if
end
;

create procedure dba.InsertNewOrganisationIndustry(
in In_OrgIndustryId char(20),
in In_OrgIndustryDesc char(100))
begin
  if not exists(select* from OrganisationIndustry where
      OrganisationIndustry.OrgIndustryId = In_OrgIndustryId) then
    insert into OrganisationIndustry(OrgIndustryId,
      OrgIndustryDesc) values(
      In_OrgIndustryId,
      In_OrgIndustryDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewOrganisationType(
in In_OrgIndustryId char(20),
in In_OrgTypeId char(20),
in In_OrgTypeDesc char(100))
begin
  if not exists(select* from OrganisationType where
      OrganisationType.OrgIndustryId = In_OrgIndustryId and
      OrganisationType.OrgTypeId = In_OrgTypeId) then
    insert into OrganisationType(OrgIndustryId,OrgTypeId,
      OrgTypeDesc) values(
      In_OrgIndustryId,
      In_OrgTypeId,
      In_OrgTypeDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewOrganiser(
in In_OrganisationCode char(20),
in In_OrgIndustryId char(20),
in In_OrganisationName char(100),
in In_OrganisationRefNo char(20),
in In_OrganisationURL char(100),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_ContactNo1 char(20),
in In_ContactNo2 char(20),
in In_ContactEmail char(100),
in In_ContactFax char(20),
in In_IsMedicalVendor smallint,
in In_IsTrainingOrganiser smallint)
begin
  if not exists(select* from Organiser where Organiser.OrganisationCode = In_OrganisationCode and
      Organiser.OrgIndustryId = In_OrgIndustryId) then
    insert into Organiser(OrganisationCode,
      OrgIndustryId,
      OrganisationName,
      OrganisationRefNo,
      OrganisationURL,
      Address1,
      Address2,
      Address3,
      ContactNo1,
      ContactNo2,
      ContactEmail,
      ContactFax,
      IsMedicalVendor,
      IsTrainingOrganiser) values(
      In_OrganisationCode,
      In_OrgIndustryId,
      In_OrganisationName,
      In_OrganisationRefNo,
      In_OrganisationURL,
      In_Address1,
      In_Address2,
      In_Address3,
      In_ContactNo1,
      In_ContactNo2,
      In_ContactEmail,
      In_ContactFax,
      In_IsMedicalVendor,
      In_IsTrainingOrganiser);
    commit work
  end if
end
;

create procedure dba.InsertNewOrgCWorker(
in In_OrganisationCode char(20),
in In_PersonalSysId integer,
in In_OtherId char(20),
in In_WorkerDesignation char(50),
out Out_ErrorCode integer)
begin
  if In_PersonalSysId is null or In_PersonalSysId = 0 then set Out_ErrorCode=-1;
    return
  end if;
  if not exists(select* from CWorker where
      CWorker.OrganisationCode = In_OrganisationCode and
      CWorker.PersonalSysId = In_PersonalSysId) then
    insert into CWorker(OrganisationCode,
      PersonalSysId,
      OtherId,
      WorkerDesignation) values(In_OrganisationCode,
      In_PersonalSysId,
      In_OtherId,
      In_WorkerDesignation);
    commit work;
    if not exists(select* from CWorker where
        CWorker.OrganisationCode = In_OrganisationCode and
        CWorker.PersonalSysId = In_PersonalSysId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewProjCostType(
in In_ProjectCostTypeId char(20),
in In_ProjectCostDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from ProjCostType where ProjectCostTypeId = In_ProjectCostTypeId) then
    insert into ProjCostType(ProjectCostTypeId,ProjectCostDesc) values(
      In_ProjectCostTypeId,In_ProjectCostDesc);
    commit work;
    if not exists(select* from ProjCostType where ProjectCostTypeId = In_ProjectCostTypeId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewRecruitPosition(
in In_RecruitCode char(20),
in In_PositionId char(20),
in In_CategoryId char(20),
in In_DepartmentId char(20),
in In_RecruitDesc char(100),
in In_Vacancy integer,
in In_ExpMinSalary double,
in In_ExpMaxSalary double,
in In_PosAdvertiseAs char(100),
in In_StartDate date,
in In_Remarks char(100),
in In_PersonInCharge char(100),
in In_EndDate date,
out Out_ErrorCode integer)
begin
  if In_RecruitCode is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_PositionId is null then set Out_ErrorCode=-2;
    return
  end if;
  if FGetInvalidDate(In_StartDate) = '' then set Out_ErrorCode=-3;
    return
  end if;
  if not exists(select* from RecruitPosition where RecruitCode = In_RecruitCode) then
    insert into RecruitPosition(RecruitCode,
      PositionId,
      CategoryId,
      DepartmentId,
      RecruitDesc,
      Vacancy,
      ExpMinSalary,
      ExpMaxSalary,
      PosAdvertiseAs,
      StartDate,
      Remarks,
      PersonInCharge,
      EndDate) values(In_RecruitCode,
      In_PositionId,
      In_CategoryId,
      In_DepartmentId,
      In_RecruitDesc,
      In_Vacancy,
      In_ExpMinSalary,
      In_ExpMaxSalary,
      In_PosAdvertiseAs,
      In_StartDate,
      In_Remarks,
      In_PersonInCharge,
      In_EndDate);
    commit work;
    if not exists(select* from RecruitPosition where RecruitCode = In_RecruitCode) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewReviewAttachment(
in In_MedExRecSysId integer,
in In_AttachDate date,
in In_AttachFileType char(20),
in In_Remarks char(100),
in In_IsMediExamResult integer,
out Out_ReviewAttachSysId integer,
out Out_ErrorCode integer)
begin
  select max(ReviewAttachSysId) into Out_ReviewAttachSysId from ReviewAttachment where
    ReviewAttachment.MedExRecSysId = In_MedExRecSysId;
  if(Out_ReviewAttachSysId is null) then
    set Out_ReviewAttachSysId=0
  end if;
  if not exists(select* from ReviewAttachment where
      ReviewAttachment.MedExRecSysId = In_MedExRecSysId and
      ReviewAttachment.ReviewAttachSysId = Out_ReviewAttachSysId+1) then
    insert into ReviewAttachment(MedExRecSysId,
      ReviewAttachSysId,
      AttachDate,
      AttachFileType,
      Remarks,
      IsMediExamResult) values(In_MedExRecSysId,
      Out_ReviewAttachSysId+1,
      In_AttachDate,
      In_AttachFileType,
      In_Remarks,
      In_IsMediExamResult);
    commit work;
    if not exists(select* from ReviewAttachment where
        ReviewAttachment.MedExRecSysId = In_MedExRecSysId and
        ReviewAttachment.ReviewAttachSysId = Out_ReviewAttachSysId+1) then
      set Out_ReviewAttachSysId=null;
      set Out_ErrorCode=0
    else
      set Out_ReviewAttachSysId=Out_ReviewAttachSysId+1;
      set Out_ErrorCode=1
    end if
  else
    set Out_ReviewAttachSysId=null;
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewReviewType(
in In_ReviewTypeId char(20),
in In_ReviewTypeDesc char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from ReviewType where ReviewTypeId = In_ReviewTypeId) then
    insert into ReviewType(ReviewTypeId,ReviewTypeDesc) values(
      In_ReviewTypeId,In_ReviewTypeDesc);
    commit work;
    if not exists(select* from ReviewType where ReviewTypeId = In_ReviewTypeId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewSkill(
in In_SkillCode char(20),
in In_CourseSkillTypeId char(20),
in In_SkillDesc char(100))
begin
  if not exists(select* from Skill where Skill.SkillCode = In_SkillCode) then
    insert into Skill(SkillCode,
      CourseSkillTypeId,
      SkillDesc) values(In_SkillCode,
      In_CourseSkillTypeId,
      In_SkillDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewSkillGrade(
in In_SkillCode char(20),
in In_GradeCode char(20),
in In_SkillProfFrom double,
in In_SkillProfTo double)
begin
  if not exists(select* from SkillGrade where
      SkillGrade.SkillCode = In_SkillCode and
      SkillGrade.GradeCode = In_GradeCode) then
    insert into SkillGrade(SkillCode,
      GradeCode,
      SkillProfFrom,
      SkillProfTo) values(
      In_SkillCode,
      In_GradeCode,
      In_SkillProfFrom,
      In_SkillProfTo);
    commit work
  end if
end
;

create procedure dba.InsertNewSkillLevel(
in In_PersonalSysId integer,
in In_SkillCode char(20),
in In_SkillEffectiveDate date,
in In_GradeCode char(20),
in In_SkillProficiency double,
in In_SkillExpiryDate date,
in In_SkillRemarks char(100))
begin
  if not exists(select* from SkillLevel where
      SkillLevel.PersonalSysId = In_PersonalSysId and
      SkillLevel.SkillCode = In_SkillCode and
      SkillLevel.SkillEffectiveDate = In_SkillEffectiveDate) then
    insert into SkillLevel(PersonalSysId,
      SkillCode,
      SkillEffectiveDate,
      GradeCode,
      SkillProficiency,
      SkillExpiryDate,
      SkillRemarks) values(
      In_PersonalSysId,
      In_SkillCode,
      In_SkillEffectiveDate,
      In_GradeCode,
      In_SkillProficiency,
      In_SkillExpiryDate,
      In_SkillRemarks);
    commit work
  end if
end
;

create procedure dba.InsertNewSponsorGrant(
in In_SponsorGrantCode char(20),
in In_SponsorGrantDesc char(100))
begin
  if not exists(select* from SponsorGrant where SponsorGrant.SponsorGrantCode = In_SponsorGrantCode) then
    insert into SponsorGrant(SponsorGrantCode,
      SponsorGrantDesc) values(
      In_SponsorGrantCode,
      In_SponsorGrantDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewSponsorship(
in In_SponsorshipCode char(20),
in In_SponsorshipDesc char(100))
begin
  if not exists(select* from Sponsorship where SponsorshipCode = In_SponsorshipCode) then
    insert into Sponsorship(SponsorshipCode,
      SponsorshipDesc) values(
      In_SponsorshipCode,
      In_SponsorshipDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewSuccession(
in In_EmployeeSysId integer,
in In_ScessorEmployeeId integer,
in In_ScessType char(20),
in In_ReadyDate date,
in In_SelectedDate date,
in In_IsPotential smallint,
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  declare NewSuccessionOrder integer;
  if exists(select* from Succession where EmployeeSysId = In_EmployeeSysId and ScessorEmployeeId = In_ScessorEmployeeId and ScessType = In_ScessType) then
    set Out_ErrorCode=-1; // Record exists
    return
  elseif not In_ScessorEmployeeId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-2; // ScessorEmployeeId not exist
    return
  elseif not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-3; // EmployeeSysId not exist
    return
  else
    select max(distinct ScessOrder) into NewSuccessionOrder from Succession where
      EmployeeSysId = In_EmployeeSysId and
      ScessType = In_ScessType;
    if(NewSuccessionOrder is null) then
      set NewSuccessionOrder=1
    else
      set NewSuccessionOrder=NewSuccessionOrder+1
    end if;
    insert into Succession(EmployeeSysId,ScessorEmployeeId,ScessType,ScessOrder,ReadyDate,SelectedDate,IsPotential,Remarks) values(
      In_EmployeeSysId,In_ScessorEmployeeId,In_ScessType,NewSuccessionOrder,In_ReadyDate,In_SelectedDate,In_IsPotential,In_Remarks);
    commit work
  end if;
  if not exists(select* from Succession where EmployeeSysId = In_EmployeeSysId and ScessorEmployeeId = In_ScessorEmployeeId and ScessType = In_ScessType) then
    set Out_ErrorCode=0; // System error
    return
  else
    set Out_ErrorCode=1 // Successful
  end if
end
;

create procedure dba.InsertNewTest(
in In_TestId char(20),
in In_TestDesc char(100),
in In_PracticalTest integer,
in In_TheoryTest integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from Test where TestId = In_TestId) then
    insert into Test(TestId,TestDesc,PracticalTest,TheoryTest) values(
      In_TestId,In_TestDesc,In_PracticalTest,In_TheoryTest);
    commit work;
    if not exists(select* from Test where TestId = In_TestId) then
      set Out_ErrorCode=0
    else
      set Out_ErrorCode=1
    end if
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.InsertNewTrainCostType(
in In_TrainCostTypeId char(20),
in In_TrainCostTypeDesc char(100),
in In_TrainForClaim integer)
begin
  if not exists(select* from TrainCostType where TrainCostType.TrainCostTypeId = In_TrainCostTypeId) then
    insert into TrainCostType(TrainCostTypeId,TrainCostTypeDesc,TrainForClaim) values(
      In_TrainCostTypeId,In_TrainCostTypeDesc,In_TrainForClaim);
    commit work
  end if
end
;

create procedure dba.InsertNewTraining(
in In_PersonalSysId integer,
in In_CourseCode char(20),
in In_CourseScheduleSysId integer,
in In_SubmissionDate date,
in In_TrainingBatchId char(20),
in In_SponsorShipCode char(20),
in In_GradeCode char(20),
in In_Approve smallint,
in In_CourseResult double,
in In_AttendancePercent double,
in In_TrainingRemarks char(100),
in In_TotalTrainingFee double,
in In_TotalTaxAmount double,
in In_SponsorType integer,
in In_SponsorValue double,
in In_SponsorReceived date,
in In_GovGrantType integer,
in In_GovGrantValue double,
in In_GovGrantReceived date,
in In_ClaimAmount double,
in In_ClaimAdvance double,
in In_ClaimApprove smallint,
in In_PayrollDate date,
in In_PayrollEmployeeSysId integer,
in In_PayrollProcessDate date,
in In_PayrollYear integer,
in In_PayrollPeriod integer,
in In_PayrollSubPeriod integer,
in In_PayrollPayElementId char(20),
in In_TrainingPaid smallint,
in In_GovernmentGrantId char(20),
in In_ePortalStatus char(20),
in In_ePortalEmployeeSysId integer,
in In_BondSysId integer,
out Out_TrainingSysId integer)
begin
  declare In_ePortalNominateEmpSysId integer;
  set Out_TrainingSysId=0;
  if(In_CourseScheduleSysId is null and In_CourseCode is null) then
    if exists(select* from Training where
        Training.PersonalSysId = In_PersonalSysId and
        Training.CourseCode is null and
        Training.CourseScheduleSysId is null and
        Training.SubmissionDate = In_SubmissionDate) then return
    end if
  elseif(In_CourseScheduleSysId is null) then
    if exists(select* from Training where
        Training.PersonalSysId = In_PersonalSysId and
        Training.CourseCode = In_CourseCode and
        Training.CourseScheduleSysId is null and
        Training.SubmissionDate = In_SubmissionDate) then return
    end if
  elseif(In_CourseCode is null) then
    if exists(select* from Training where
        Training.PersonalSysId = In_PersonalSysId and
        Training.CourseCode is null and
        Training.CourseScheduleSysId = In_CourseScheduleSysId and
        Training.SubmissionDate = In_SubmissionDate) then return
    end if
  else
    if exists(select* from Training where
        Training.PersonalSysId = In_PersonalSysId and
        Training.CourseCode = In_CourseCode and
        Training.CourseScheduleSysId = In_CourseScheduleSysId and
        Training.SubmissionDate = In_SubmissionDate) then return
    end if
  end if;
  if(In_BondSysId = 0) then set In_BondSysId=null
  end if;
  if(In_ePortalStatus = 'TrainNominate') then set In_ePortalNominateEmpSysId=In_ePortalEmployeeSysId
  end if;
  insert into Training(PersonalSysId,
    CourseCode,
    CourseScheduleSysId,
    SubmissionDate,
    TrainingBatchId,
    SponsorShipCode,
    GradeCode,
    Approve,
    CourseResult,
    AttendancePercent,
    TrainingRemarks,
    TotalTrainingFee,
    TotalTaxAmount,
    SponsorType,
    SponsorValue,
    SponsorReceived,
    GovGrantType,
    GovGrantValue,
    GovGrantReceived,
    ClaimAmount,
    ClaimAdvance,
    ClaimApprove,
    PayrollDate,
    PayrollEmployeeSysId,
    PayrollProcessDate,
    PayrollYear,
    PayrollPeriod,
    PayrollSubPeriod,
    PayrollPayElementId,
    TrainingPaid,
    GovernmentGrantId,
    ePortalStatus,
    ePortalEmployeeSysId,
    ePortalNominateEmpSysId,
    BondSysId) values(
    In_PersonalSysId,
    In_CourseCode,
    In_CourseScheduleSysId,
    In_SubmissionDate,
    In_TrainingBatchId,
    In_SponsorShipCode,
    In_GradeCode,
    In_Approve,
    In_CourseResult,
    In_AttendancePercent,
    In_TrainingRemarks,
    In_TotalTrainingFee,
    In_TotalTaxAmount,
    In_SponsorType,
    In_SponsorValue,
    In_SponsorReceived,
    In_GovGrantType,
    In_GovGrantValue,
    In_GovGrantReceived,
    In_ClaimAmount,
    In_ClaimAdvance,
    In_ClaimApprove,
    In_PayrollDate,
    In_PayrollEmployeeSysId,
    In_PayrollProcessDate,
    In_PayrollYear,
    In_PayrollPeriod,
    In_PayrollSubPeriod,
    In_PayrollPayElementId,
    In_TrainingPaid,
    In_GovernmentGrantId,
    In_ePortalStatus,
    In_ePortalEmployeeSysId,
    In_ePortalNominateEmpSysId,
    In_BondSysId);
  commit work;
  if(In_CourseScheduleSysId is null and In_CourseCode is null) then
    select TrainingSysId into Out_TrainingSysId from Training where
      Training.PersonalSysId = In_PersonalSysId and
      Training.CourseCode is null and
      Training.CourseScheduleSysId is null and
      Training.SubmissionDate = In_SubmissionDate
  elseif(In_CourseScheduleSysId is null) then
    select TrainingSysId into Out_TrainingSysId from Training where
      Training.PersonalSysId = In_PersonalSysId and
      Training.CourseCode = In_CourseCode and
      Training.CourseScheduleSysId is null and
      Training.SubmissionDate = In_SubmissionDate
  elseif(In_CourseCode is null) then
    select TrainingSysId into Out_TrainingSysId from Training where
      Training.PersonalSysId = In_PersonalSysId and
      Training.CourseCode is null and
      Training.CourseScheduleSysId = In_CourseScheduleSysId and
      Training.SubmissionDate = In_SubmissionDate
  else
    select TrainingSysId into Out_TrainingSysId from Training where
      Training.PersonalSysId = In_PersonalSysId and
      Training.CourseCode = In_CourseCode and
      Training.CourseScheduleSysId = In_CourseScheduleSysId and
      Training.SubmissionDate = In_SubmissionDate
  end if;
  if Out_TrainingSysId is null then set Out_TrainingSysId=0
  end if;
  if(In_CourseScheduleSysId is not null and Out_TrainingSysId <> 0 and In_ePortalStatus = 'TrainAccepted' and In_Approve = 1 and
    not exists(select* from TrainCostRec where TrainingSysId = Out_TrainingSysId and TrainCostTypeId = 'Course Fee')) then
    insert into TrainCostRec(TrainingSysId,TrainCostTypeId,TrainAmount,TrainTaxAmount,TrainForClaim) values(
      Out_TrainingSysID,'Course Fee',
      (select CourseFee from CourseSchedule where CourseScheduleSysId = In_CourseScheduleSysId and CourseCode = In_CourseCode),
      0,(select TrainForClaim from TrainCostType where TrainCostTypeId = 'Course Fee'));
    commit work
  end if
end
;

create procedure dba.InsertNewTrainingAttachment(
in In_TrainingSysId integer,
in In_TrainAttachDate timestamp,
in In_TrainAttachRemarks char(100),
in In_TrainAttachFileType char(20))
begin
  if not exists(select* from TrainingAttachment where
      TrainingAttachment.TrainingSysId = In_TrainingSysId and
      TrainingAttachment.TrainAttachDate = In_TrainAttachDate) then
    insert into TrainingAttachment(TrainingSysId,
      TrainAttachDate,
      TrainAttachRemarks,
      TrainAttachFileType) values(
      In_TrainingSysId,
      In_TrainAttachDate,
      In_TrainAttachRemarks,
      In_TrainAttachFileType);
    commit work
  end if
end
;

create procedure dba.InsertNewTrainingBatch(
in In_TrainingBatchId char(20),
in In_Approve integer,
in In_CourseCode char(20),
in In_CourseScheduleSysId integer,
in In_LastModified timestamp,
in In_PayrollDate date,
in In_PayrollPayElementId char(20),
in In_SponsorShipCode char(20),
in In_SponsorType integer,
in In_SponsorValue double,
in In_SubmissionDate date,
in In_TrainingBatchDesc char(100),
in In_TrainingRemarks char(100),
in In_TotalTrainingFee double,
in In_TotalTaxAmount double,
in In_ClaimApprove integer,
in In_TrainTaxComputation integer,
in In_TrainingPaid integer,
in In_SponsorReceived date,
in In_GovernmentGrantId char(20),
in In_GovGrantType integer,
in In_GovGrantValue double,
in In_GovGrantReceived date)
begin
  if not exists(select* from TrainingBatch where
      TrainingBatchId = In_TrainingBatchId) then
    insert into TrainingBatch(TrainingBatchId,
      Approve,
      CourseCode,
      CourseScheduleSysId,
      LastModified,
      PayrollDate,
      PayrollPayElementId,
      SponsorShipCode,
      SponsorType,
      SponsorValue,
      SubmissionDate,
      TrainingBatchDesc,
      TrainingRemarks,
      TotalTrainingFee,
      TotalTaxAmount,
      ClaimApprove,
      TrainTaxComputation,
      TrainingPaid,
      SponsorReceived,
      GovernmentGrantId,
      GovGrantType,
      GovGrantValue,
      GovGrantReceived) values(
      In_TrainingBatchId,
      In_Approve,
      In_CourseCode,
      In_CourseScheduleSysId,
      In_LastModified,
      In_PayrollDate,
      In_PayrollPayElementId,
      In_SponsorShipCode,
      In_SponsorType,
      In_SponsorValue,
      In_SubmissionDate,
      In_TrainingBatchDesc,
      In_TrainingRemarks,
      In_TotalTrainingFee,
      In_TotalTaxAmount,
      In_ClaimApprove,
      In_TrainTaxComputation,
      In_TrainingPaid,
      In_SponsorReceived,
      In_GovernmentGrantId,
      In_GovGrantType,
      In_GovGrantValue,
      In_GovGrantReceived);
    commit work
  end if
end
;

create procedure dba.InsertNewTrainingHistory(
in In_TrainingSysId integer,
in In_HisServiceYr double,
in In_HisEducationId char(20),
in In_HisBranchId char(20),
in In_HisCategoryId char(20),
in In_HisDepartmentId char(20),
in In_HisPositionId char(20),
in In_HisSectionId char(20),
in In_HisSupervisorId char(30))
begin
  if not exists(select* from TrainingHistory where TrainingHistory.TrainingSysId = In_TrainingSysId) then
    insert into TrainingHistory(TrainingSysId,
      HisServiceYr,
      HisEducationId,
      HisBranchId,
      HisCategoryId,
      HisDepartmentId,
      HisPositionId,
      HisSectionId,
      HisSupervisorId) values(In_TrainingSysId,
      In_HisServiceYr,
      In_HisEducationId,
      In_HisBranchId,
      In_HisCategoryId,
      In_HisDepartmentId,
      In_HisPositionId,
      In_HisSectionId,
      In_HisSupervisorId);
    commit work
  end if
end
;

create procedure dba.InsertNewTrainingPersonnel(
in In_TrainingBatchId char(20),
in In_TrainPersonalSysId integer,
in In_TrainAppraisalSysId integer,
in In_TrainApprTrainingSysId integer)
begin
  if not exists(select* from TrainingPersonnel where TrainingBatchId = In_TrainingBatchId and
      TrainPersonalSysId = In_TrainPersonalSysId) then
    insert into TrainingPersonnel(TrainingBatchId,TrainPersonalSysId,TrainAppraisalSysId,TrainApprTrainingSysId) values(
      In_TrainingBatchId,In_TrainPersonalSysId,In_TrainAppraisalSysId,In_TrainApprTrainingSysId);
    commit work
  end if
end
;

create procedure dba.InsertNewTrainingType(
in In_TrainingTypeId char(20),
in In_TrainingTypeDesc char(100))
begin
  if not exists(select* from TrainingType where TrainingType.TrainingTypeId = In_TrainingTypeId) then
    insert into TrainingType(TrainingTypeId,
      TrainingTypeDesc) values(
      In_TrainingTypeId,
      In_TrainingTypeDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewTreatmentType(
in In_TreatmentTypeId char(20),
in In_TreatmentDesc char(100))
begin
  if not exists(select* from TreatmentType where TreatmentType.TreatmentTypeId = In_TreatmentTypeId) then
    insert into TreatmentType(TreatmentTypeId,TreatmentDesc) values(
      In_TreatmentTypeId,In_TreatmentDesc);
    commit work
  end if
end
;

create procedure dba.InsertNewVenue(
in In_VenueCode char(20),
in In_OrganisationCode char(20),
in In_VenueDesc char(100),
in In_ForTraining smallint,
in In_ForEvent smallint,
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_VenueURL char(100),
in In_ContactNo1 char(40),
in In_ContactNo2 char(40),
in In_ContactFax char(40),
in In_ForProject smallint)
begin
  if not exists(select* from Venue where Venue.VenueCode = In_VenueCode) then
    insert into Venue(VenueCode,
      OrganisationCode,
      VenueDesc,
      ForTraining,
      ForEvent,
      Address1,
      Address2,
      Address3,
      VenueURL,
      ContactNo1,
      ContactNo2,
      ContactFax,
      ForProject) values(
      In_VenueCode,
      In_OrganisationCode,
      In_VenueDesc,
      In_ForTraining,
      In_ForEvent,
      In_Address1,
      In_Address2,
      In_Address3,
      In_VenueURL,
      In_ContactNo1,
      In_ContactNo2,
      In_ContactFax,
      In_ForProject);
    commit work
  end if
end
;

create function DBA.IsMedClaimTypeEligible(
in In_PersonalSysId integer,
in In_MedClaimPolicyId char(20),
in In_MedClaimTypeId char(20),
in In_ProcessDate date)
returns integer
begin
  declare Out_MedClaimPolicyBasis char(20);
  declare Out_String char(20);
  declare Out_Value double;
  declare Out_RangeType char(20);
  select MedClaimPolicyBasis into Out_MedClaimPolicyBasis from MClaimPolicy where
    MedClaimPolicyId = In_MedClaimPolicyId;
  /*
  Call Procedure to find matching value;
  */
  call ASQLMedClaimRangeBasis(In_PersonalSysId,In_MedClaimPolicyId,In_ProcessDate,Out_String,Out_Value);
  /*
  Check Sub Registry for String or Value
  */
  select RegProperty1 into Out_RangeType from SubRegistry where
    SubRegistryId = Out_MedClaimPolicyBasis and RegistryId = 'HRRangeBasis';
  case Out_RangeType when 'Value' then
    if exists(select* from MClaimPolicyRec where
        MedClaimPolicyId = In_MedClaimPolicyId and
        MedClaimTypeId = In_MedClaimTypeId and
        Out_Value between MedClaimPolicyFrom and MedClaimPolicyTo) then return 1
    else
      return 0
    end if when 'String' then
    if exists(select* from MClaimPolicyRec where
        MedClaimPolicyId = In_MedClaimPolicyId and
        MedClaimTypeId = In_MedClaimTypeId and
        (MedClaimStringMatch = Out_String or MedClaimStringMatch = '???')) then return 1
    else
      return 0
    end if
  else
    return 0
  end case
end
;

create procedure dba.UpdateActionTaken(
in In_ActionTakenId char(20),
in In_ActionTakenDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from ActionTaken where ActionTakenId = In_ActionTakenId) then
    update ActionTaken set ActionTakenDesc = In_ActionTakenDesc where
      ActionTakenId = In_ActionTakenId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateApplicant(
in In_ApplicantSysId integer,
in In_PersonalSysId integer,
in In_RecruitCode char(20),
in In_MediaId char(20),
in In_AppDateSubmitted date,
in In_AppExpectedSalary double,
in In_AppAvailability date,
in In_Recommended integer,
in In_RecommendedBy char(20),
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from Applicant where
      Applicant.ApplicantSysId = In_ApplicantSysId) then
    if In_PersonalSysId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_RecruitCode is null then set Out_ErrorCode=-2;
      return
    end if;
    if FGetInvalidDate(In_AppDateSubmitted) = '' then set Out_ErrorCode=-3;
      return
    end if;
    update Applicant set
      Applicant.PersonalSysId = In_PersonalSysId,
      Applicant.RecruitCode = In_RecruitCode,
      Applicant.MediaId = In_MediaId,
      Applicant.AppDateSubmitted = In_AppDateSubmitted,
      Applicant.AppExpectedSalary = In_AppExpectedSalary,
      Applicant.AppAvailability = In_AppAvailability,
      Applicant.Recommended = In_Recommended,
      Applicant.RecommendedBy = In_RecommendedBy,
      Applicant.Remarks = In_Remarks where
      Applicant.ApplicantSysId = In_ApplicantSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateApplicantAttach(
in In_ApplicantSysId integer,
in In_ApplicantAttachSysId integer,
in In_AttachFileType char(20),
in In_AttachRemarks char(100),
in In_AttachDate date,
out Out_ErrorCode integer)
begin
  if exists(select* from ApplicantAttach where
      ApplicantAttach.ApplicantSysId = In_ApplicantSysId and
      ApplicantAttach.ApplicantAttachSysId = In_ApplicantAttachSysId) then
    update ApplicantAttach set AttachFileType = In_AttachFileType,
      AttachRemarks = In_AttachRemarks,AttachDate = In_AttachDate where
      ApplicantAttach.ApplicantSysId = In_ApplicantSysId and
      ApplicantAttach.ApplicantAttachSysId = In_ApplicantAttachSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateAppraisal(
in In_AppraisalSysId integer,
in In_AppraisalTypeId char(20),
in In_ApprPtSystemId char(20),
in In_FormId char(20),
in In_GradeCode char(20),
in In_PersonalSysId integer,
in In_AppraisalDate date,
in In_AppraisalSvcFrom date,
in In_AppraisalSvcTo date,
in In_AppraisalNext date,
in In_AppraisalRemarks char(100),
in In_AppraisalPerformance double,
in In_AppraisalStatus char(20),
in In_ApprBonusProcess integer,
in In_ApprBonusFactor double,
in In_ApprObjectivePercent double,
in In_ApprCareerMovement integer,
in In_ApprCareerEffectDate date,
in In_ApprPayAdjust integer,
in In_ApprBRProgDate date,
in In_ApprAdjustType integer,
in In_ApprBRAdjust double,
in In_ApprMVCAdjust double,
in In_ApprNWCAdjust double)
begin
  if exists(select* from Appraisal where
      AppraisalSysId = In_AppraisalSysId) then
    update Appraisal set
      AppraisalTypeId = In_AppraisalTypeId,
      ApprPtSystemId = In_ApprPtSystemId,
      FormId = In_FormId,
      GradeCode = In_GradeCode,
      PersonalSysId = In_PersonalSysId,
      AppraisalDate = In_AppraisalDate,
      AppraisalSvcFrom = In_AppraisalSvcFrom,
      AppraisalSvcTo = In_AppraisalSvcTo,
      AppraisalNext = In_AppraisalNext,
      AppraisalRemarks = In_AppraisalRemarks,
      AppraisalPerformance = In_AppraisalPerformance,
      AppraisalStatus = In_AppraisalStatus,
      ApprBonusProcess = In_ApprBonusProcess,
      ApprBonusFactor = In_ApprBonusFactor,
      ApprObjectivePercent = In_ApprObjectivePercent,
      ApprCareerMovement = In_ApprCareerMovement,
      ApprCareerEffectDate = In_ApprCareerEffectDate,
      ApprPayAdjust = In_ApprPayAdjust,
      ApprBRProgDate = In_ApprBRProgDate,
      ApprAdjustType = In_ApprAdjustType,
      ApprBRAdjust = In_ApprBRAdjust,
      ApprMVCAdjust = In_ApprMVCAdjust,
      ApprNWCAdjust = In_ApprNWCAdjust where
      AppraisalSysId = In_AppraisalSysId;
    commit work
  end if
end
;

create procedure dba.UpdateAppraisalDetail(
in In_PersonalSysId integer,
in In_AppraisalDate date,
in In_ApprCategoryId char(20),
in In_ApprQuestionSysId integer,
in In_AppraisalPt double,
in In_AppraisalComment char(200))
begin
  if exists(select* from AppraisalDetail where
      AppraisalDetail.PersonalSysId = In_PersonalSysId and
      AppraisalDetail.AppraisalDate = In_AppraisalDate and
      AppraisalDetail.ApprCategoryId = In_ApprCategoryId and
      AppraisalDetail.ApprQuestionSysId = In_ApprQuestionSysId) then
    update Appraisal set
      AppraisalDetail.AppraisalPt = In_AppraisalPt,
      AppraisalDetail.AppraisalComment = In_AppraisalComment where
      AppraisalDetail.PersonalSysId = In_PersonalSysId and
      AppraisalDetail.AppraisalDate = In_AppraisalDate and
      AppraisalDetail.ApprCategoryId = In_ApprCategoryId and
      AppraisalDetail.ApprQuestionSysId = In_ApprQuestionSysId;
    commit work
  end if
end
;

create procedure dba.UpdateAppraisalGrade(
in In_ApprPtSystemId char(20),
in In_GradeCode char(20),
in In_AppraisalPtFrom double,
in In_AppraisalPtTo double,
in In_ApprBonusFactor double,
in In_ApprPayAdjust integer,
in In_ApprBRAdjust double,
in In_ApprMVCAdjust double,
in In_ApprNWCAdjust double)
begin
  if exists(select* from AppraisalGrade where
      AppraisalGrade.ApprPtSystemId = In_ApprPtSystemId and
      AppraisalGrade.GradeCode = In_GradeCode) then
    update AppraisalGrade set
      AppraisalGrade.AppraisalPtFrom = In_AppraisalPtFrom,
      AppraisalGrade.AppraisalPtTo = In_AppraisalPtTo,
      AppraisalGrade.ApprBonusFactor = In_ApprBonusFactor,
      AppraisalGrade.ApprPayAdjust = In_ApprPayAdjust,
      AppraisalGrade.ApprBRAdjust = In_ApprBRAdjust,
      AppraisalGrade.ApprMVCAdjust = In_ApprMVCAdjust,
      AppraisalGrade.ApprNWCAdjust = In_ApprNWCAdjust where
      AppraisalGrade.ApprPtSystemId = In_ApprPtSystemId and
      AppraisalGrade.GradeCode = In_GradeCode;
    commit work
  end if
end
;

create procedure dba.UpdateAppraisalHistory(
in In_AppraisalSysId integer,
in In_HisBasicRate double,
in In_HisBranchId char(20),
in In_HisCategoryId char(20),
in In_HisDepartmentId char(20),
in In_HisEducationId char(20),
in In_HisMVC double,
in In_HisNWC double,
in In_HisPositionId char(20),
in In_HisSectionId char(20),
in In_HisSupervisorId char(30))
begin
  if exists(select* from AppraisalHistory where
      AppraisalSysId = In_AppraisalSysId) then
    update Appraisalhistory set
      HisBasicRate = In_HisBasicRate,
      HisBranchId = In_HisBranchId,
      HisCategoryId = In_HisCategoryId,
      HisDepartmentId = In_HisDepartmentId,
      HisEducationId = In_HisEducationId,
      HisMVC = In_HisMVC,
      HisNWC = In_HisNWC,
      HisPositionId = In_HisPositionId,
      HisSectionId = In_HisSectionId,
      HisSupervisorId = In_HisSupervisorId where
      AppraisalSysId = In_AppraisalSysId;
    commit work
  end if
end
;

create procedure dba.UpdateAppraisalTmpRecSortCatOrder(
in In_ApprTmpId char(20))
begin
  declare CategoryOrder integer;
  set CategoryOrder=0;
  ProjectSequenceLoop: for SortCategoryOrder as ProcessSortCategoryOrder dynamic scroll cursor for
    select* from AppraisalTmpRec where ApprTmpId = In_ApprTmpId order by ApprCategoryOrder asc do
    set CategoryOrder=CategoryOrder+1;
    update AppraisalTmpRec set
      ApprCategoryOrder = CategoryOrder where current of ProcessSortCategoryOrder end for;
  commit work
end
;

create procedure dba.UpdateAppraisalType(
in In_AppraisalTypeId char(20),
in In_AppraisalTypeDesc char(100))
begin
  if exists(select* from AppraisalType where AppraisalType.AppraisalTypeId = In_AppraisalTypeId) then
    update AppraisalType set
      AppraisalTypeDesc = In_AppraisalTypeDesc where
      AppraisalType.AppraisalTypeId = In_AppraisalTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateApprCategory(
in In_ApprCategoryId char(20),
in In_ApprCategoryDesc char(100))
begin
  if exists(select* from ApprCategory where
      ApprCategory.ApprCategoryId = In_ApprCategoryId) then
    update ApprCategory set
      ApprCategory.ApprCategoryDesc = In_ApprCategoryDesc where
      ApprCategory.ApprCategoryId = In_ApprCategoryId;
    commit work
  end if
end
;

create procedure dba.UpdateApprPtSystem(
in In_ApprPtSystemId char(20),
in In_ApprPtSystemDesc char(100),
in In_ApprAdjustType integer)
begin
  if exists(select* from ApprPtSystem where
      ApprPtSystem.ApprPtSystemId = In_ApprPtSystemId) then
    update ApprPtSystem set
      ApprPtSystem.ApprPtSystemDesc = In_ApprPtSystemDesc,
      ApprPtSystem.ApprAdjustType = In_ApprAdjustType where
      ApprPtSystem.ApprPtSystemId = In_ApprPtSystemId;
    commit work
  end if
end
;

create procedure dba.UpdateApprQuestionSortQuestionNo(
in In_ApprCategoryId char(20))
begin
  declare QuestionNo integer;
  set QuestionNo=0;
  ProjectSequenceLoop: for SortQuestionNo as ProcessSortQuestionNo dynamic scroll cursor for
    select* from ApprQuestion where ApprCategoryId = In_ApprCategoryId order by ApprQuestionNo asc do
    set QuestionNo=QuestionNo+1;
    update ApprQuestion set
      ApprQuestionNo = QuestionNo where current of ProcessSortQuestionNo end for;
  commit work
end
;

create procedure dba.UpdateApprTemplate(
in In_ApprTmpId char(20),
in In_ApprTmpRemarks char(100),
in In_ApprTmpDesc char(100))
begin
  if exists(select* from ApprTemplate where
      ApprTemplate.ApprTmpId = In_ApprTmpId) then
    update ApprTemplate set
      ApprTemplate.ApprTmpRemarks = In_ApprTmpRemarks,
      ApprTemplate.ApprTmpDesc = In_ApprTmpDesc where
      ApprTemplate.ApprTmpId = In_ApprTmpId;
    commit work
  end if
end
;

create procedure dba.UpdateApprTraining(
in In_AppraisalSysId integer,
in In_ApprTrainingSysId integer,
in In_ApprAquiredDate date,
in In_ApprTrainingComment char(200),
in In_CourseCode char(20),
in In_SkillCode char(20),
in In_TrainingSysId integer)
begin
  if exists(select* from ApprTraining where
      AppraisalSysId = In_AppraisalSysId and ApprTrainingSysId = In_ApprTrainingSysId) then
    update ApprTraining set
      ApprAquiredDate = In_ApprAquiredDate,
      ApprTrainingComment = In_ApprTrainingComment,
      CourseCode = In_CourseCode,
      SkillCode = In_SkillCode,
      TrainingSysId = In_TrainingSysId where
      AppraisalSysId = In_AppraisalSysId and ApprTrainingSysId = In_ApprTrainingSysId;
    commit work
  end if
end
;

create procedure dba.UpdateAreaSpecialised(
in In_AreaSpecialised char(20),
in In_AreaSpecialisedDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from AreaSpecialised where AreaSpecialised = In_AreaSpecialised) then
    update AreaSpecialised set AreaSpecialisedDesc = In_AreaSpecialisedDesc where
      AreaSpecialised = In_AreaSpecialised;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateAwardCode(
in In_AwardDiscCode char(20),
in In_AwardDiscDesc char(100),
in In_IsDiscipline integer,
out Out_ErrorCode integer)
begin
  if exists(select* from AwardCode where AwardDiscCode = In_AwardDiscCode) then
    update AwardCode set AwardDiscDesc = In_AwardDiscDesc,
      IsDiscipline = In_IsDiscipline where
      AwardDiscCode = In_AwardDiscCode;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateAwardDisc(
in In_AwardDiscSysId integer,
in In_PersonalSysId integer,
in In_AwardDiscCode char(20),
in In_ActionTakenId char(20),
in In_OffenceType char(20),
in In_AwardDiscDate date,
in In_AwardAmount double,
in In_PayrollDate date,
in In_PayrollEmployeeSysId integer,
in In_PayrollPayElementId char(20),
in In_PayrollYear integer,
in In_PayrollPeriod integer,
in In_PayrollSubPeriod integer,
in In_PayrollProcessDate date,
in In_ReferenceNo char(20),
in In_Remarks char(100),
in In_FollowUpDate date,
in In_OffenceDate date,
out Out_ErrorCode integer)
begin
  if exists(select* from AwardDisc where
      AwardDisc.AwardDiscSysId = In_AwardDiscSysId) then
    update AwardDisc set
      AwardDisc.PersonalSysId = In_PersonalSysId,
      AwardDisc.AwardDiscCode = In_AwardDiscCode,
      AwardDisc.ActionTakenId = In_ActionTakenId,
      AwardDisc.OffenceType = In_OffenceType,
      AwardDisc.AwardDiscDate = In_AwardDiscDate,
      AwardDisc.AwardAmount = In_AwardAmount,
      AwardDisc.PayrollDate = In_PayrollDate,
      AwardDisc.PayrollEmployeeSysId = In_PayrollEmployeeSysId,
      AwardDisc.PayrollPayElementId = In_PayrollPayElementId,
      AwardDisc.PayrollYear = In_PayrollYear,
      AwardDisc.PayrollPeriod = In_PayrollPeriod,
      AwardDisc.PayrollSubPeriod = In_PayrollSubPeriod,
      AwardDisc.PayrollProcessDate = In_PayrollProcessDate,
      AwardDisc.ReferenceNo = In_ReferenceNo,
      AwardDisc.Remarks = In_Remarks,
      AwardDisc.FollowUpDate = In_FollowUpDate,
      AwardDisc.OffenceDate = In_OffenceDate where
      AwardDisc.AwardDiscSysId = In_AwardDiscSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateAwardDiscAttach(
in In_AwardDiscSysId integer,
in In_AwardDiscAttachSysId integer,
in In_AttachFileType char(20),
in In_AttachRemarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from AwardDiscAttach where
      AwardDiscAttach.AwardDiscSysId = In_AwardDiscSysId and
      AwardDiscAttach.AwardDiscAttachSysId = In_AwardDiscAttachSysId) then
    update AwardDiscAttach set AttachFileType = In_AttachFileType,
      AttachRemarks = In_AttachRemarks where
      AwardDiscAttach.AwardDiscSysId = In_AwardDiscSysId and
      AwardDiscAttach.AwardDiscAttachSysId = In_AwardDiscAttachSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateBond(
in In_BondSysId integer,
in In_EffectiveDate date,
in In_EndDate date,
in In_BondDuration double,
in In_BondUnit char(20),
in In_BondRefNo char(20),
in In_BondDesc char(100),
in In_PersonalSysId integer)
begin
  if exists(select* from Bond where
      BondSysId = In_BondSysId) then
    update Bond set
      EffectiveDate = In_EffectiveDate,
      EndDate = In_EndDate,
      BondDuration = In_BondDuration,
      BondUnit = In_BondUnit,
      BondRefNo = In_BondRefNo,
      BondDesc = In_BondDesc,
      PersonalSysId = In_PersonalSysId where
      BondSysId = In_BondSysId;
    commit work
  end if
end
;

create procedure dba.UpdateBondAttachment(
in In_BondSysId integer,
in In_BondAttachSysId integer,
in In_AttachRemarks char(100),
in In_AttachFileType char(20))
begin
  if exists(select* from BondAttachment where
      BondSysId = In_BondSysId and
      BondAttachSysId = In_BondAttachSysId) then
    update BondAttachment set
      AttachRemarks = In_AttachRemarks,
      AttachFileType = In_AttachFileType where
      BondSysId = In_BondSysId and
      BondAttachSysId = In_BondAttachSysId;
    commit work
  end if
end
;

create procedure dba.UpdateCompetency(
in In_CompetencySysId integer,
in In_PositionId char(20),
in In_CompetencyDate date,
in In_Remarks char(100),
in In_CFieldsStrIsAND integer,
in In_CFieldsNumIsAND integer,
in In_CFieldMajorIsAND integer,
in In_CEduLevelIsAND integer,
in In_CResponIsAND integer,
in In_CSkillIsAND integer,
in In_EmployeeSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from Competency where
      Competency.CompetencySysId = In_CompetencySysId) then
    if In_PositionId is null and In_EmployeeSysId <= 0 then set Out_ErrorCode=-1;
      return
    end if;
    if FGetInvalidDate(In_CompetencyDate) = '' then set Out_ErrorCode=-2;
      return
    end if;
    if In_EmployeeSysId > 0 then
      update Competency set
        Competency.PositionId = In_PositionId,
        Competency.CompetencyDate = In_CompetencyDate,
        Competency.Remarks = In_Remarks,
        Competency.CFieldsStrIsAND = In_CFieldsStrIsAND,
        Competency.CFieldsNumIsAND = In_CFieldsNumIsAND,
        Competency.CFieldMajorIsAND = In_CFieldMajorIsAND,
        Competency.CEduLevelIsAND = In_CEduLevelIsAND,
        Competency.CResponIsAND = In_CResponIsAND,
        Competency.CSkillIsAND = In_CSkillIsAND,
        Competency.EmployeeSysId = In_EmployeeSysId where
        Competency.CompetencySysId = In_CompetencySysId
    else
      update Competency set
        Competency.PositionId = In_PositionId,
        Competency.CompetencyDate = In_CompetencyDate,
        Competency.Remarks = In_Remarks,
        Competency.CFieldsStrIsAND = In_CFieldsStrIsAND,
        Competency.CFieldsNumIsAND = In_CFieldsNumIsAND,
        Competency.CFieldMajorIsAND = In_CFieldMajorIsAND,
        Competency.CEduLevelIsAND = In_CEduLevelIsAND,
        Competency.CResponIsAND = In_CResponIsAND,
        Competency.CSkillIsAND = In_CSkillIsAND where
        Competency.CompetencySysId = In_CompetencySysId
    end if;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateContractCategory(
in In_ContractCategoryId char(20),
in In_ContractCategoryDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from ContractCategory where ContractCategoryId = In_ContractCategoryId) then
    update ContractCategory set ContractCategoryDesc = In_ContractCategoryDesc where
      ContractCategoryId = In_ContractCategoryId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateCourse(
in In_CourseCode char(20),
in In_CourseSkillTypeId char(20),
in In_CourseActive smallint,
in In_CourseDesc char(100),
in In_CourseTitle char(100),
in In_CourseRefNo char(50),
in In_CourseLevel integer,
in In_CourseBondDuration double,
in In_CourseBondUnit char(20),
in In_CourseFamilyId char(20),
in In_CourseCategoryId char(20),
in In_CourseLanguage char(20))
begin
  if exists(select* from Course where Course.CourseCode = In_CourseCode) then
    update Course set
      CourseSkillTypeId = In_CourseSkillTypeId,
      CourseActive = In_CourseActive,
      CourseDesc = In_CourseDesc,
      CourseTitle = In_CourseTitle,
      CourseRefNo = In_CourseRefNo,
      CourseLevel = In_CourseLevel,
      CourseBondDuration = In_CourseBondDuration,
      CourseBondUnit = In_CourseBondUnit,
      CourseFamilyId = In_CourseFamilyId,
      CourseCategoryId = In_CourseCategoryId,
      CourseLanguage = In_CourseLanguage where
      Course.CourseCode = In_CourseCode;
    commit work
  end if
end
;

create procedure dba.UpdateCourseAttachment(
in In_CourseCode char(20),
in In_CourseAttachSysId integer,
in In_CourseAttachRemarks char(100),
in In_CourseAttachFileType char(20))
begin
  if exists(select* from CourseAttachment where
      CourseAttachment.CourseCode = In_CourseCode and
      CourseAttachment.CourseAttachSysID = In_CourseAttachSysId) then
    update CourseAttachment set
      CourseAttachRemarks = In_CourseAttachRemarks,
      CourseAttachFileType = In_CourseAttachFileType where
      CourseAttachment.CourseCode = In_CourseCode and
      CourseAttachment.CourseAttachSysID = In_CourseAttachSysId;
    commit work
  end if
end
;

create procedure dba.UpdateCourseCategory(
in In_CourseCategoryId char(20),
in In_CourseCatDesc char(100))
begin
  if exists(select* from CourseCategory where CourseCategoryId = In_CourseCategoryId) then
    update CourseCategory set
      CourseCatDesc = In_CourseCatDesc where
      CourseCategoryId = In_CourseCategoryId;
    commit work
  end if
end
;

create procedure dba.UpdateCourseContact(
in In_CourseCode char(20),
in In_CourseScheduleSysId integer,
in In_CourseContactSysId integer,
in In_ContactPerson char(50),
in In_ContactRole char(20),
in In_ContactNo1 char(20),
in In_ContactNo2 char(20),
in In_ContactEmail char(100),
in In_ContactFax char(20))
begin
  if exists(select* from CourseContact where CourseContact.CourseCode = In_CourseCode and
      CourseContact.CourseScheduleSysId = In_CourseScheduleSysId and
      CourseContact.CourseContactSysId = In_CourseContactSysId) then
    update CourseContact set
      CourseContact.ContactPerson = In_ContactPerson,
      CourseContact.CourseRoleId = In_ContactRole,
      CourseContact.ContactNo1 = In_ContactNo1,
      CourseContact.ContactNo2 = In_ContactNo2,
      CourseContact.ContactEmail = In_ContactEmail,
      CourseContact.ContactFax = In_ContactFax where CourseContact.CourseCode = In_CourseCode and
      CourseContact.CourseScheduleSysId = In_CourseScheduleSysId and
      CourseContact.CourseContactSysId = In_CourseContactSysId;
    commit work
  end if
end
;

create procedure dba.UpdateCourseFamily(
in In_CourseFamilyId char(20),
in In_CourseFamilyDesc char(100))
begin
  if exists(select* from CourseFamily where CourseFamilyId = In_CourseFamilyId) then
    update CourseFamily set
      CourseFamilyDesc = In_CourseFamilyDesc where
      CourseFamilyId = In_CourseFamilyId;
    commit work
  end if
end
;

create procedure dba.UpdateCourseGrade(
in In_CourseCode char(20),
in In_GradeCode char(20),
in In_CourseResultFrom double,
in In_CourseResultTo double)
begin
  if exists(select* from CourseGrade where
      CourseGrade.CourseCode = In_CourseCode and
      CourseGrade.GradeCode = In_GradeCode) then
    update CourseGrade set
      CourseResultFrom = In_CourseResultFrom,
      CourseResultTo = In_CourseResultTo where
      CourseGrade.CourseCode = In_CourseCode and
      CourseGrade.GradeCode = In_GradeCode;
    commit work
  end if
end
;

create procedure dba.UpdateCourseRole(
in In_CourseRoleId char(20),
in In_CourseRoleDesc char(100))
begin
  if exists(select* from CourseRole where CourseRole.CourseRoleId = In_CourseRoleId) then
    update CourseRole set
      CourseRole.CourseRoleDesc = In_CourseRoleDesc where
      CourseRole.CourseRoleId = In_CourseRoleId;
    commit work
  end if
end
;

create procedure dba.UpdateCourseSchedule(
in In_CourseCode char(20),
in In_CourseScheduleSysID integer,
in In_TrainingTypeID char(20),
in In_OrganisationCode char(20),
in In_VenueCode char(20),
in In_CourseStartDate date,
in In_CourseStartTime time,
in In_CourseEndDate date,
in In_CourseEndTime time,
in In_CourseDuration double,
in In_CourseUnit char(20),
in In_CourseFee double,
in In_CourseRemarks char(100))
begin
  if exists(select* from CourseSchedule where
      CourseSchedule.CourseCode = In_CourseCode and
      CourseSchedule.CourseScheduleSysID = In_CourseScheduleSysID) then
    update CourseSchedule set
      TrainingTypeID = In_TrainingTypeID,
      OrganisationCode = In_OrganisationCode,
      VenueCode = In_VenueCode,
      CourseStartDate = In_CourseStartDate,
      CourseStartTime = In_CourseStartTime,
      CourseEndDate = In_CourseEndDate,
      CourseEndTime = In_CourseEndTime,
      CourseDuration = In_CourseDuration,
      CourseUnit = In_CourseUnit,
      CourseFee = In_CourseFee,
      CourseRemarks = In_CourseRemarks where
      CourseSchedule.CourseCode = In_CourseCode and
      CourseSchedule.CourseScheduleSysID = In_CourseScheduleSysID;
    commit work
  end if
end
;

create procedure dba.UpdateCourseSkillType(
in In_CourseSkillTypeId char(20),
in In_CourseSkillTypeDesc char(100))
begin
  if exists(select* from CourseSkillType where CourseSkillType.CourseSkillTypeId = In_CourseSkillTypeId) then
    update CourseSkillType set
      CourseSkillTypeDesc = In_CourseSkillTypeDesc where
      CourseSkillType.CourseSkillTypeId = In_CourseSkillTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateEduAttachment(
in In_EduRecId integer,
in In_EduAttachSysId integer,
in In_AttachFileType char(20),
in In_AttachRemarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from EduAttachment where
      EduAttachment.EduRecId = In_EduRecId and
      EduAttachment.EduAttachSysId = In_EduAttachSysId) then
    update EduAttachment set AttachFileType = In_AttachFileType,
      AttachRemarks = In_AttachRemarks where
      EduAttachment.EduRecId = In_EduRecId and
      EduAttachment.EduAttachSysId = In_EduAttachSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateEducationRec(
in In_EduRecId integer,
in In_EducationId char(20),
in In_PersonalSysId integer,
in In_EduStartDate date,
in In_EduEndDate date,
in In_EduInstitution char(100),
in In_EduHighest smallint,
in In_EduResult integer,
out Out_ErrorCode integer)
begin
  if(FGetInvalidDate(In_EduStartDate) <> '' and FGetInvalidDate(In_EduEndDate) <> '') then
    if(In_EduStartDate < In_EduEndDate) then
      set Out_ErrorCode=1
    else
      set Out_ErrorCode=-1
    end if
  else
    set Out_ErrorCode=1
  end if;
  if(In_EducationId <> '') then
    if(Out_ErrorCode = 1) then
      if exists(select* from EducationRec where
          EducationRec.EduRecId = In_EduRecId) then
        if(In_EduHighest = 1) then
          update EducationRec set EducationRec.EduHighest = 0 where
            EducationRec.EduHighest = 1 and
            EducationRec.PersonalSysId = In_PersonalSysId
        end if;
        update EducationRec set
          EducationRec.EducationId = In_EducationId,
          EducationRec.PersonalSysId = In_PersonalSysId,
          EducationRec.EduStartDate = In_EduStartDate,
          EducationRec.EduEndDate = In_EduEndDate,
          EducationRec.EduInsitution = In_EduInstitution,
          EducationRec.EduHighest = In_EduHighest,
          EducationRec.EduResult = In_EduResult where
          EducationRec.EduRecId = In_EduRecId;
        if(In_EduHighest = 1) then
          if exists(select* from Employee where
              PersonalSysId = In_PersonalSysId and
              FGetInvalidDate(cessationdate) = '') then
            update Employee set
              HighestEduCode = In_EducationId where
              PersonalSysId = In_PersonalSysId and
              FGetInvalidDate(cessationdate) = ''
          end if
        end if;
        commit work;
        set Out_ErrorCode=1
      else
        set Out_ErrorCode=0
      end if
    end if
  else
    set Out_ErrorCode=-2
  end if
end
;

create procedure dba.UpdateExitIntAttach(
in In_PersonalSysId integer,
in In_TenderDate date,
in In_ExitIntAttachSysId integer,
in In_AttachFileType char(20),
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from ExitIntAttach where
      ExitIntAttach.PersonalSysId = In_PersonalSysId and
      ExitIntAttach.TenderDate = In_TenderDate and
      ExitIntAttach.ExitIntAttachSysId = In_ExitIntAttachSysId) then
    update ExitIntAttach set AttachFileType = In_AttachFileType,
      Remarks = In_Remarks where
      ExitIntAttach.PersonalSysId = In_PersonalSysId and
      ExitIntAttach.TenderDate = In_TenderDate and
      ExitIntAttach.ExitIntAttachSysId = In_ExitIntAttachSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateExitInterview(
in In_PersonalSysId integer,
in In_TenderDate date,
in In_TenderNoticePeriod integer,
in In_TenderNoticeUnit char(10),
in In_WithdrawnResign smallint,
in In_WithdrawnResignDate date,
in In_NoReEmploy smallint,
in In_Reason char(100),
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from ExitInterview where
      ExitInterview.PersonalSysId = In_PersonalSysId and
      ExitInterview.TenderDate = In_TenderDate) then
    update ExitInterview set
      TenderNoticePeriod = In_TenderNoticePeriod,
      TenderNoticeUnit = In_TenderNoticeUnit,
      WithdrawnResign = In_WithdrawnResign,
      WithdrawnResignDate = In_WithdrawnResignDate,
      NoReEmploy = In_NoReEmploy,
      Reason = In_Reason,
      Remarks = In_Remarks where
      ExitInterview.PersonalSysId = In_PersonalSysId and
      ExitInterview.TenderDate = In_TenderDate;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateFamily(
in In_FamilySysId integer,
in In_OccupationId char(20),
in In_RelationshipId char(20),
in In_PersonalSysId integer,
in In_IdentityTypeId char(20),
in In_PersonName char(150),
in In_Gender char(1),
in In_IdentityNo char(20),
in In_DOB date,
in In_ContactNo1 char(20),
in In_ContactNo2 char(20),
in In_ContactEmail char(100),
in In_ContactAddress char(140),
in In_Country char(20),
in In_State char(20),
in In_City char(20),
in In_PostalCode char(20),
in In_EmergencyContactOrder integer,
in In_FamilyCompanyName char(100),
in In_IsHandicapped smallint,
in In_ResidenceTypeId char(20),
in In_FamilyMaritalStatusCode char(20),
in In_PassportIssue char(20),
in In_IdentityCheckDigit char(5),
in In_UseChildcareFirstYear smallint,
out Out_ErrorCode integer)
begin
  if exists(select* from Family where
      Family.FamilySysId = In_FamilySysId) then
    if In_PersonalSysId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_PersonName is null then set Out_ErrorCode=-2;
      return
    end if;
    if In_RelationshipId is null then set Out_ErrorCode=-3;
      return
    end if;
    if In_ResidenceTypeId is null then set Out_ErrorCode=-4;
      return
    end if;
    if(In_RelationshipId = 'Son' or In_RelationshipId = 'Daughter') and FGetDateFormat(In_DOB) = '' then set Out_ErrorCode=-5;
      return
    end if;
    update Family set
      Family.OccupationId = In_OccupationId,
      Family.RelationshipId = In_RelationshipId,
      Family.PersonalSysId = In_PersonalSysId,
      Family.IdentityTypeId = In_IdentityTypeId,
      Family.PersonName = In_PersonName,
      Family.Gender = In_Gender,
      Family.IdentityNo = In_IdentityNo,
      Family.DOB = In_DOB,
      Family.ContactNo1 = In_ContactNo1,
      Family.ContactNo2 = In_ContactNo2,
      Family.ContactEmail = In_ContactEmail,
      Family.ContactAddress = In_ContactAddress,
      Family.Country = In_Country,
      Family.State = In_State,
      Family.City = In_City,
      Family.PostalCode = In_PostalCode,
      Family.EmergencyContactOrder = In_EmergencyContactOrder,
      Family.FamilyCompanyName = In_FamilyCompanyName,
      Family.IsHandicapped = In_IsHandicapped,
      Family.ResidenceTypeId = In_ResidenceTypeId,
      Family.FamilyMaritalStatusCode = In_FamilyMaritalStatusCode,
      Family.PassportIssue = In_PassportIssue,
      Family.IdentityCheckDigit = In_IdentityCheckDigit,
      Family.UseChildcareFirstYear = In_UseChildcareFirstYear where
      Family.FamilySysId = In_FamilySysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateFamilyAttachment(
in In_FamilySysId integer,
in In_FamilyAttachSysId integer,
in In_AttachFileType char(20),
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from FamilyAttachment where
      FamilyAttachment.FamilySysId = In_FamilySysId and
      FamilyAttachment.FamilyAttachSysId = In_FamilyAttachSysId) then
    update FamilyAttachment set AttachFileType = In_AttachFileType,
      Remarks = In_Remarks where
      FamilyAttachment.FamilySysId = In_FamilySysId and
      FamilyAttachment.FamilyAttachSysId = In_FamilyAttachSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateFamilyEduRec(
in In_FamilyEduRecId integer,
in In_FamilySysId integer,
in In_EducationId char(20),
in In_EduStartDate date,
in In_EduEndDate date,
in In_EduInstitution char(100),
in In_EduHighest smallint,
in In_EduResult double,
in In_EduLocal smallint,
out Out_ErrorCode integer)
begin
  if In_EducationId is null then set Out_ErrorCode=-1;
    return
  end if;
  if FGetInvalidDate(In_EduStartDate) = '' then set Out_ErrorCode=-2;
    return
  end if;
  if FGetInvalidDate(In_EduEndDate) = '' then set Out_ErrorCode=-3;
    return
  end if;
  if(In_EduEndDate < In_EduStartDate) then set Out_ErrorCode=-4;
    return
  end if;
  if exists(select* from FamilyEduRec where
      FamilyEduRec.FamilyEduRecId = In_FamilyEduRecId) then
    if(In_EduHighest = 1) then
      update FamilyEduRec set FamilyEduRec.EduHighest = 0 where
        FamilyEduRec.EduHighest = 1 and
        FamilyEduRec.FamilySysId = In_FamilySysId
    end if;
    update FamilyEduRec set
      FamilyEduRec.FamilySysId = In_FamilySysId,
      FamilyEduRec.EducationId = In_EducationId,
      FamilyEduRec.EduStartDate = In_EduStartDate,
      FamilyEduRec.EduEndDate = In_EduEndDate,
      FamilyEduRec.EduInsitution = In_EduInstitution,
      FamilyEduRec.EduHighest = In_EduHighest,
      FamilyEduRec.EduResult = In_EduResult,
      FamilyEduRec.EduLocal = In_EduLocal where
      FamilyEduRec.EduRecId = In_EduRecId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateForm(
in In_FormId char(20),
in In_NoSectionLevel integer,
in In_FormAppearIn char(20),
in In_HRFormulaId char(20),
in In_FormDesc char(100),
in In_FormRemarks char(100),
in In_FormIsStandard integer)
begin
  if exists(select* from Form where Form.FormId = In_FormId) then
    update Form set
      HRFormulaId = In_HRFormulaId,
      FormRemarks = In_FormRemarks,
      FormDesc = In_FormDesc,
      FormAppearIn = In_FormAppearIn,
      NoSectionLevel = In_NoSectionLevel,
      FormIsStandard = In_FormIsStandard where
      Form.FormId = In_FormId;
    commit work
  end if
end
;

create procedure dba.UpdateFormControlProperty(
in In_FormId char(20),
in In_FormSecSysId integer,
in In_FormControlId char(50),
in In_FormFieldId char(20),
in In_CtrlOrder integer,
in In_CtrlVisible integer,
in In_CtrlShowCaption integer,
in In_CtrlCaption char(100),
in In_AppraiserOrder integer,
in In_DateValue date,
in In_BooleanValue integer,
in In_IntegerValue integer,
in In_NumericValue double,
in In_StringValue char(100))
begin
  if exists(select* from FormControlProperty where FormControlProperty.FormId = In_FormId and
      FormControlProperty.FormSecSysId = In_FormSecSysId and
      FormControlProperty.FormControlId = In_FormControlId) then
    update FormControlProperty set
      FormFieldId = In_FormFieldId,
      CtrlOrder = In_CtrlOrder,
      CtrlVisible = In_CtrlVisible,
      CtrlCaption = In_CtrlCaption,
      CtrlShowCaption = In_CtrlShowCaption,
      DateValue = In_DateValue,
      BooleanValue = In_BooleanValue,
      IntegerValue = In_IntegerValue,
      NumericValue = In_NumericValue,
      StringValue = In_StringValue,
      AppraiserOrder = In_AppraiserOrder where
      FormControlProperty.FormId = In_FormId and
      FormControlProperty.FormSecSysId = In_FormSecSysId and
      FormControlProperty.FormControlId = In_FormControlId;
    commit work
  end if
end
;

create procedure dba.UpdateFormPoint(
in In_FormId char(20),
in In_FormSecSysId integer,
in In_FormPointSysId integer,
in In_HRFormulaId char(20),
in In_FormPointOrder integer,
in In_FormPointLabel char(200),
in In_FormPointDesc char(100),
in In_FormMinPoint double,
in In_FormMaxPoint double)
begin
  if exists(select* from FormPoint where FormPoint.FormId = In_FormId and
      FormPoint.FormSecSysId = In_FormSecSysId and
      FormPoint.FormPointSysId = In_FormPointSysId) then
    update FormPoint set
      HRFormulaId = In_HRFormulaId,
      FormPointOrder = In_FormPointOrder,
      FormPointLabel = In_FormPointLabel,
      FormPointDesc = In_FormPointDesc,
      FormMinPoint = In_FormMinPoint,
      FormMaxPoint = In_FormMaxPoint where
      FormPoint.FormId = In_FormId and
      FormPoint.FormSecSysId = In_FormSecSysId and
      FormPoint.FormPointSysId = In_FormPointSysId;
    commit work
  end if
end
;

create procedure dba.UpdateGovernmentGrant(
in In_GovernmentGrantId char(20),
in In_GovernmentGrantDesc char(100))
begin
  if exists(select* from GovernmentGrant where GovernmentGrantId = In_GovernmentGrantId) then
    update GovernmentGrant set
      GovernmentGrantDesc = In_GovernmentGrantDesc where
      GovernmentGrantId = In_GovernmentGrantId;
    commit work
  end if
end
;

create procedure dba.UpdateGrade(
in In_GradeCode char(20),
in In_GradeDesc char(100))
begin
  if exists(select* from Grade where Grade.GradeCode = In_GradeCode) then
    update Grade set
      GradeDesc = In_GradeDesc where
      Grade.GradeCode = In_GradeCode;
    commit work
  end if
end
;

create procedure dba.UpdateHRFormula(
in In_HRFormulaId char(20),
in In_HRFormulaActive integer,
in In_HRFormulaCategory char(20),
in In_HRFormulaDesc char(100),
in In_HRFormulaSubCategory char(20),
in In_HRFormulaType char(20))
begin
  if exists(select* from HRFormula where
      HRFormulaId = In_HRFormulaId) then
    update HRFormula set
      HRFormulaActive = In_HRFormulaActive,
      HRFormulaCategory = In_HRFormulaCategory,
      HRFormulaDesc = In_HRFormulaDesc,
      HRFormulaSubCategory = In_HRFormulaSubCategory,
      HRFormulaType = In_HRFormulaType where
      HRFormulaId = In_HRFormulaId;
    commit work
  end if
end
;

create procedure dba.UpdateHRFormulaRange(
in In_HRFormulaRangeId integer,
in In_HRFormulaId char(20),
in In_Formula char(255),
in In_Maximum double,
in In_Minimum double,
in In_Constant1 double,
in In_Constant2 double,
in In_Constant3 double,
in In_Constant4 double,
in In_Constant5 double,
in In_Keywords1 char(20),
in In_Keywords2 char(20),
in In_Keywords3 char(20),
in In_Keywords4 char(20),
in In_Keywords5 char(20),
in In_Keywords6 char(20),
in In_Keywords7 char(20),
in In_Keywords8 char(20),
in In_Keywords9 char(20),
in In_Keywords10 char(20),
in In_UserDef1 char(20),
in In_UserDef2 char(20),
in In_UserDef3 char(20),
in In_UserDef4 char(20),
in In_UserDef5 char(20))
begin
  if exists(select* from HRFormulaRange where
      HRFormulaRangeId = In_HRFormulaRangeId and HRFormulaId = In_HRFormulaId) then
    update HRFormulaRange set
      Formula = In_Formula,
      Maximum = In_Maximum,
      Minimum = In_Minimum,
      Constant1 = In_Constant1,
      Constant2 = In_Constant2,
      Constant3 = In_Constant3,
      Constant4 = In_Constant4,
      Constant5 = In_Constant5,
      Keywords1 = In_Keywords1,
      Keywords2 = In_Keywords2,
      Keywords3 = In_Keywords3,
      Keywords4 = In_Keywords4,
      Keywords5 = In_Keywords5,
      Keywords6 = In_Keywords6,
      Keywords7 = In_Keywords7,
      Keywords8 = In_Keywords8,
      Keywords9 = In_Keywords9,
      Keywords10 = In_Keywords10,
      UserDef1 = In_UserDef1,
      UserDef2 = In_UserDef2,
      UserDef3 = In_UserDef3,
      UserDef4 = In_UserDef4,
      UserDef5 = In_UserDef5 where
      HRFormulaRangeId = In_HRFormulaRangeId and HRFormulaId = In_HRFormulaId;
    commit work
  end if
end
;

create procedure dba.UpdateHRKeyword(
in In_HRKeywordId char(20),
in In_HRKeywordUserDefinedName char(100),
in In_HRKeywordDesc char(100),
in In_HRKeywordCategory char(20))
begin
  if exists(select* from HRKeyword where
      HRKeywordId = In_HRKeywordId) then
    update HRKeyword set
      HRKeywordUserDefinedName = In_HRKeywordUserDefinedName,
      HRKeywordDesc = In_HRKeywordDesc where
      HRKeywordCategory = In_HRKeywordCategory and
      HRKeywordId = In_HRKeywordId;
    commit work
  end if
end
;

create procedure dba.UpdateHRProjectAttach(
in In_ProjectId char(20),
in In_ProjAttachSysId integer,
in In_AttachFileType char(20),
in In_AttachRemarks char(100),
out Out_Code integer)
begin
  if In_ProjectId is null then set Out_Code=-1;
    return
  end if;
  if In_ProjAttachSysId is null then set Out_Code=-2;
    return
  end if;
  if exists(select* from ProjAttachment where ProjectId = In_ProjectId and
      ProjAttachSysId = In_ProjAttachSysId) then
    update ProjAttachment set
      AttachFileType = In_AttachFileType,
      AttachRemarks = In_AttachRemarks where
      ProjectId = In_ProjectId and
      ProjAttachSysId = In_ProjAttachSysId;
    commit work;
    set Out_Code=1
  end if
end
;

create procedure dba.UpdateHRProjectRecord(
in In_ProjectId char(20),
in In_VenueCode char(20),
in In_ProjectName char(100),
in In_ProjectRefNo char(50),
in In_ProjectJobNo char(20),
in In_ProjectStartDate date,
in In_ProjectEndDate date,
in In_ProjectRemarks char(100),
out Out_Code integer)
begin
  if In_ProjectId is null then set Out_Code=-1;
    return
  end if;
  if In_VenueCode is null then set Out_Code=-2;
    return
  end if;
  if In_ProjectStartDate is not null and In_ProjectEndDate is not null and In_ProjectStartDate > In_ProjectEndDate then set Out_Code=-4;
    return
  end if;
  if exists(select* from Project where ProjectId = In_ProjectId) then
    update Project set
      VenueCode = In_VenueCode,
      ProjectName = In_ProjectName,
      ProjectRefNo = In_ProjectRefNo,
      ProjectJobNo = In_ProjectJobNo,
      ProjectStartDate = In_ProjectStartDate,
      ProjectEndDate = In_ProjectEndDate,
      ProjectRemarks = In_ProjectRemarks where ProjectId = In_ProjectId;
    commit work;
    set Out_Code=1
  else
    set Out_Code=-3
  end if
end
;

create procedure dba.UpdateHRProjectWorker(
in In_SysId integer,
in In_PositionId char(20),
in In_ProjectId char(20),
in In_PersonalSysId integer,
in In_ProjAttachFromDate date,
in In_ProjAttachToDate date,
in In_ProjAttachRemarks char(100),
out Out_Code integer)
begin
  if In_ProjAttachFromDate is not null and In_ProjAttachToDate is not null and In_ProjAttachFromDate > In_ProjAttachToDate then set Out_Code=-4;
    return
  end if;
  if In_PositionId is null then
    set Out_Code=-1;
    return
  end if;
  if exists(select* from ProjContractWorker where ProjContractWorkerSysId = In_SysId) then
    update ProjContractWorker set
      ProjectId = In_ProjectId,
      PersonalSysId = In_PersonalSysId,
      PositionId = In_PositionId,
      ProjAttachFromDate = In_ProjAttachFromDate,
      ProjAttachToDate = In_ProjAttachToDate,
      ProjAttachRemarks = In_ProjAttachRemarks where ProjContractWorkerSysId = In_SysId;
    commit work;
    set Out_Code=1
  else
    set Out_Code=-5;
    return
  end if
end
;

create procedure dba.UpdateHRTestAttachRecord(
in In_HRTestSysId integer,
in In_HRTestAttachSysId integer,
in In_AttachFileType char(20),
in In_AttachRemarks char(100),
out ErrorCode integer)
begin
  if exists(select* from HRTestAttach where
      HRTestSysId = In_HRTestSysId and
      HRTestAttachSysId = In_HRTestAttachSysId) then
    update HRTestAttach set
      AttachFileType = In_AttachFileType,
      AttachRemarks = In_AttachRemarks where
      HRTestSysId = In_HRTestSysId and
      HRTestAttachSysId = In_HRTestAttachSysId;
    commit work;
    set ErrorCode=1
  end if
end
;

create procedure dba.UpdateHRTestRecord(
in In_HRTestSysId integer,
in In_TestId char(20),
in In_PersonalSysId integer,
in In_HRTestDate date,
in In_TheoryResult double,
in In_PraticalResult double,
in In_OverallResult double,
in In_HRTestFee double,
in In_AttendancePercent double,
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if In_TestId is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_PersonalSysId is null then set Out_ErrorCode=-2;
    return
  end if;
  if In_HRTestDate = '1899-12-30' then set Out_ErrorCode=-3;
    return
  end if;
  if exists(select* from HRTest where HRTestSysId = In_HRTestSysId) then
    update HRTest set
      TestId = In_TestId,
      PersonalSysId = In_PersonalSysId,
      HRTestDate = In_HRTestDate,
      TheoryResult = In_TheoryResult,
      PraticalResult = In_PraticalResult,
      OverallResult = In_OverallResult,
      HRTestFee = In_HRTestFee,
      AttendancePercent = In_AttendancePercent,
      Remarks = In_Remarks where HRTestSysId = In_HRTestSysId;
    commit work;
    set Out_ErrorCode=1
  end if
end
;

create procedure dba.UpdateIllness(
in In_IllnessId char(50),
in In_IllnessDesc char(100))
begin
  if exists(select* from Illness where Illness.IllnessId = In_IllnessId) then
    update Illness set
      Illness.IllnessDesc = In_IllnessDesc where
      Illness.IllnessId = In_IllnessId;
    commit work
  end if
end
;

create procedure dba.UpdateInterviewer(
in In_InterviewerSysId integer,
in In_InterviewSchSysId integer,
in In_ePortalEmployeeSysId integer,
in In_InterviewerName char(100),
in In_InterviewerPosition char(50),
in In_Remarks char(100),
in In_KeyInterviewer smallint,
out Out_ErrorCode integer)
begin
  if exists(select* from Interviewer where
      Interviewer.InterviewerSysId = In_InterviewerSysId) then
    if In_InterviewSchSysId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_InterviewerName is null then set Out_ErrorCode=-2;
      return
    end if;
    if(In_KeyInterviewer = 1) then
      update Interviewer set KeyInterviewer = 0 where
        InterviewSchSysId = In_InterviewSchSysId and KeyInterviewer = 1
    else
      if not exists(select* from Interviewer where
          Interviewer.InterviewSchSysId = In_InterviewSchSysId and KeyInterviewer = 1) then
        set In_KeyInterviewer=1
      end if
    end if;
    update Interviewer set
      Interviewer.InterviewSchSysId = In_InterviewSchSysId,
      Interviewer.ePortalEmployeeSysId = In_ePortalEmployeeSysId,
      Interviewer.InterviewerName = In_InterviewerName,
      Interviewer.InterviewerPosition = In_InterviewerPosition,
      Interviewer.Remarks = In_Remarks,
      Interviewer.KeyInterviewer = In_KeyInterviewer where
      Interviewer.InterviewerSysId = In_InterviewerSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateInterviewSchedule(
in In_InterviewSchSysId integer,
in In_ApplicantSysId integer,
in In_InterviewDate date,
in In_InterviewTime time,
in In_InterviewRemarks char(100),
in In_InterviewLoc char(20),
in In_RecruitAction char(20),
in In_ApplicantResponse char(20),
in In_InterviewOrder integer,
in In_ApplicantRespDate date,
out Out_ErrorCode integer)
begin
  if exists(select* from InterviewSchedule where
      InterviewSchedule.InterviewSchSysId = In_InterviewSchSysId) then
    if In_ApplicantSysId is null then set Out_ErrorCode=-1;
      return
    end if;
    if In_RecruitAction is null then set Out_ErrorCode=-2;
      return
    end if;
    if In_ApplicantResponse is null then set Out_ErrorCode=-3;
      return
    end if;
    update InterviewSchedule set
      InterviewSchedule.InterviewSchSysId = In_InterviewSchSysId,
      InterviewSchedule.ApplicantSysId = In_ApplicantSysId,
      InterviewSchedule.InterviewDate = In_InterviewDate,
      InterviewSchedule.InterviewTime = In_InterviewTime,
      InterviewSchedule.InterviewRemarks = In_InterviewRemarks,
      InterviewSchedule.InterviewLoc = In_InterviewLoc,
      InterviewSchedule.RecruitAction = In_RecruitAction,
      InterviewSchedule.ApplicantResponse = In_ApplicantResponse,
      InterviewSchedule.InterviewOrder = In_InterviewOrder,
      InterviewSchedule.ApplicantRespDate = In_ApplicantRespDate where
      InterviewSchedule.InterviewSchSysId = In_InterviewSchSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateInterviewScheduleCommand(
in In_RecruitCode char(20),
in In_InterviewSchSysId integer,
in In_ApplicantSysId integer,
in In_CommandType char(20),
out Out_ErrorCode integer)
begin
  declare Out_Error integer;
  declare Out_InterviewSchSysId integer;
  declare Out_InterviewDate date;
  declare Out_InterviewTime time;
  declare Out_InterviewRemarks char(100);
  declare Out_InterviewLoc char(20);
  declare Out_RecruitAction char(20);
  declare Out_ApplicantResponse char(20);
  declare Out_InterviewOrder integer;
  if In_RecruitCode is null then set Out_ErrorCode=-11;
    return
  end if;
  if In_ApplicantSysId is null or In_ApplicantSysId = 0 then set Out_ErrorCode=-12;
    return
  end if;
  if In_CommandType is null then set Out_ErrorCode=-13;
    return
  end if;
  if In_CommandType = 'RecruitNewShortlist' then
    if In_InterviewSchSysId is not null then
      select ApplicantResponse into Out_ApplicantResponse from InterviewSchedule where
        InterviewSchedule.InterviewSchSysId = In_InterviewSchSysId;
      if Out_ApplicantResponse = 'RecruitRespReject' then
        set Out_ErrorCode=-14;
        return
      end if
    end if;
    call InsertNewInterviewSchedule(In_RecruitCode,In_ApplicantSysId,null,null,null,null,'RecruitShortlist','RecruitRespWaitRely',null,Out_InterviewSchSysId,Out_Error);
    set Out_ErrorCode=Out_Error
  else
    if exists(select* from InterviewSchedule where
        InterviewSchedule.InterviewSchSysId = In_InterviewSchSysId) then
      select InterviewDate,InterviewTime,InterviewRemarks,InterviewLoc,RecruitAction,ApplicantResponse,InterviewOrder into Out_InterviewDate,
        Out_InterviewTime,Out_InterviewRemarks,Out_InterviewLoc,Out_RecruitAction,Out_ApplicantResponse,Out_InterviewOrder from
        InterviewSchedule where InterviewSchedule.InterviewSchSysId = In_InterviewSchSysId;
      case In_CommandType when 'RecruitShortlist' then
        call UpdateInterviewSchedule(In_InterviewSchSysId,In_ApplicantSysId,Out_InterviewDate,Out_InterviewTime,Out_InterviewRemarks,Out_InterviewLoc,'RecruitShortlist','RecruitRespWaitRely',Out_InterviewOrder,null,Out_Error) when 'RecruitOffer' then
        call UpdateInterviewSchedule(In_InterviewSchSysId,In_ApplicantSysId,Out_InterviewDate,Out_InterviewTime,Out_InterviewRemarks,Out_InterviewLoc,'RecruitOffer','RecruitRespWaitRely',Out_InterviewOrder,null,Out_Error) when 'RecruitReject' then
        call UpdateInterviewSchedule(In_InterviewSchSysId,In_ApplicantSysId,Out_InterviewDate,Out_InterviewTime,Out_InterviewRemarks,Out_InterviewLoc,'RecruitReject','RecruitRespNotify',Out_InterviewOrder,null,Out_Error) when 'RecruitKIV' then
        call UpdateInterviewSchedule(In_InterviewSchSysId,In_ApplicantSysId,Out_InterviewDate,Out_InterviewTime,Out_InterviewRemarks,Out_InterviewLoc,'RecruitKIV',Out_ApplicantResponse,Out_InterviewOrder,null,Out_Error) when 'RecruitRespAccept' then
        if Out_RecruitAction = 'RecruitShortlist' then
          call UpdateInterviewSchedule(In_InterviewSchSysId,In_ApplicantSysId,Out_InterviewDate,Out_InterviewTime,Out_InterviewRemarks,Out_InterviewLoc,'RecruitWaitInterview','RecruitRespAccept',Out_InterviewOrder,today(*),Out_Error)
        else
          if Out_RecruitAction = 'RecruitOffer' then
            call UpdateInterviewSchedule(In_InterviewSchSysId,In_ApplicantSysId,Out_InterviewDate,Out_InterviewTime,Out_InterviewRemarks,Out_InterviewLoc,Out_RecruitAction,'RecruitRespAccept',Out_InterviewOrder,today(*),Out_Error)
          else
            set Out_ErrorCode=-14
          end if
        end if when 'RecruitRespReject' then
        call UpdateInterviewSchedule(In_InterviewSchSysId,In_ApplicantSysId,Out_InterviewDate,Out_InterviewTime,Out_InterviewRemarks,Out_InterviewLoc,Out_RecruitAction,'RecruitRespReject',Out_InterviewOrder,today(*),Out_Error) when 'RecruitRespKIV' then
        call UpdateInterviewSchedule(In_InterviewSchSysId,In_ApplicantSysId,Out_InterviewDate,Out_InterviewTime,Out_InterviewRemarks,Out_InterviewLoc,Out_RecruitAction,'RecruitRespKIV',Out_InterviewOrder,today(*),Out_Error)
      end case
      ;
      set Out_ErrorCode=Out_Error
    else
      set Out_ErrorCode=0
    end if
  end if
end
;

create procedure dba.UpdateItem(
in In_ItemId char(20),
in In_ItemTypeId char(20),
in In_OrganisationCode char(20),
in In_ItemName char(100),
in In_PerUnitMeasure char(20),
in In_Remarks char(100),
in In_UnitAmt double,
in In_DefAssignQty integer,
in In_ModelNo char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from Item where ItemId = In_ItemId) then
    update Item set
      ItemTypeId = In_ItemTypeId,
      OrganisationCode = In_OrganisationCode,
      ItemName = In_ItemName,
      PerUnitMeasure = In_PerUnitMeasure,
      Remarks = In_Remarks,
      UnitAmt = In_UnitAmt,
      DefAssignQty = In_DefAssignQty,
      ModelNo = In_ModelNo where
      ItemId = In_ItemId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateItemAssignItem(
in In_ItemAssignItemSysId integer,
in In_ItemId char(20),
in In_PersonalSysId integer,
in In_AssignQty integer,
in In_AssignUnitAmt double,
in In_Remarks char(100),
in In_SerialNo char(20),
in In_BarCode char(20),
in In_ExpiryDate date,
in In_ReturnDate date,
in In_IsOnLoan smallint,
in In_WaivedDate date,
in In_NextIssueDate date,
in In_EffectiveDate date,
in In_IssueDate date,
in In_ePortalIssueEmpeeSysId integer,
in In_ePortalStatus char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from ItemAssignItem where
      ItemAssignItemSysId = In_ItemAssignItemSysId) then
    update ItemAssignItem set
      ItemId = In_ItemId,
      PersonalSysId = In_PersonalSysId,
      AssignQty = In_AssignQty,
      AssignUnitAmt = In_AssignUnitAmt,
      Remarks = In_Remarks,
      SerialNo = In_SerialNo,
      BarCode = In_BarCode,
      ExpiryDate = In_ExpiryDate,
      ReturnDate = In_ReturnDate,
      IsOnLoan = In_IsOnLoan,
      WaivedDate = In_WaivedDate,
      NextIssueDate = In_NextIssueDate,
      EffectiveDate = In_EffectiveDate,
      IssueDate = In_IssueDate,
      ePortalIssueEmpeeSysId = In_ePortalIssueEmpeeSysId,
      ePortalStatus = In_ePortalStatus where
      ItemAssignItemSysId = In_ItemAssignItemSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateItemAttrName(
in In_ItemAttrNameId char(20),
in In_ItemAttrNameDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from ItemAttrName where ItemAttrName.ItemAttrNameId = In_ItemAttrNameId) then
    update ItemAttrName set ItemAttrNameDesc = In_ItemAttrNameDesc where
      ItemAttrNameId = In_ItemAttrNameId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateItemAttrValue(
in In_ItemAttrValueSysId integer,
in In_ItemAttrNameId char(20),
in In_ItemId char(20),
in In_ItemAttrType char(20),
in In_ItemAttrStrValue char(20),
in In_ItemAttrNumValue double,
in In_ItemAttrDateValue date,
out Out_ErrorCode integer)
begin
  if exists(select* from ItemAttrValue where ItemId = In_ItemId and ItemAttrNameId = In_ItemAttrNameId and ItemAttrType = 'ItemAttrTypeStr' and ItemAttrStrValue = In_ItemAttrStrValue) then
    set Out_ErrorCode=-3;
    return
  end if;
  if exists(select* from ItemAttrValue where ItemId = In_ItemId and
      ItemAttrValueSysId = In_ItemAttrValueSysId) then
    update ItemAttrValue set
      ItemAttrNameId = In_ItemAttrNameId,
      ItemId = In_ItemId,
      ItemAttrType = In_ItemAttrType,
      ItemAttrStrValue = In_ItemAttrStrValue,
      ItemAttrNumValue = In_ItemAttrNumValue,
      ItemAttrDateValue = In_ItemAttrDateValue where
      ItemId = In_ItemId and
      ItemAttrValueSysId = In_ItemAttrValueSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateItemBAssgn(
in In_ItemBAssignSysId integer,
in In_ItemId char(20),
in In_ItemBatchId char(20),
in In_AssignQty integer,
in In_AssignUnitAmt double,
in In_Remarks char(100),
in In_ExpiryDate date,
in In_IsOnLoan smallint,
in In_WaivedDate date,
in In_NextIssueDate date,
in In_EffectiveDate date,
in In_IssueDate date,
in In_IssueByEmpeeSysId integer,
out Out_ErrorCode integer)
begin
  if exists(select* from ItemBAssgn where
      ItemBAssignSysId = In_ItemBAssignSysId) then
    update ItemBAssgn set
      ItemId = In_ItemId,
      ItemBatchId = In_ItemBatchId,
      AssignQty = In_AssignQty,
      AssignUnitAmt = In_AssignUnitAmt,
      Remarks = In_Remarks,
      ExpiryDate = In_ExpiryDate,
      IsOnLoan = In_IsOnLoan,
      WaivedDate = In_WaivedDate,
      NextIssueDate = In_NextIssueDate,
      EffectiveDate = In_EffectiveDate,
      IssueDate = In_IssueDate,
      IssueByEmpeeSysId = In_IssueByEmpeeSysId where
      ItemBAssignSysId = In_ItemBAssignSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateItemBatch(
in In_ItemBatchId char(20),
in In_ItemBatchDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from ItemBatch where ItemBatchId = In_ItemBatchId) then
    update ItemBatch set
      ItemBatchDesc = In_ItemBatchDesc where
      ItemBatchId = In_ItemBatchId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateItemType(
in In_ItemTypeId char(20),
in In_ItemTypeDesc char(100))
begin
  if exists(select* from ItemType where ItemTypeId = In_ItemTypeId) then
    update ItemType set
      ItemTypeDesc = In_ItemTypeDesc where
      ItemTypeId = In_ItemTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateJobAdAttach(
in In_RecruitCode char(20),
in In_JobAdAttachSysId integer,
in In_AttachFileType char(20),
in In_AttachDate date,
in In_AttachRemarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from JobAdAttach where
      JobAdAttach.RecruitCode = In_RecruitCode and
      JobAdAttach.JobAdAttachSysId = In_JobAdAttachSysId) then
    update JobAdAttach set AttachFileType = In_AttachFileType,
      AttachDate = In_AttachDate,
      AttachRemarks = In_AttachRemarks where
      JobAdAttach.RecruitCode = In_RecruitCode and
      JobAdAttach.JobAdAttachSysId = In_JobAdAttachSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateJobGrade(
in In_JobGrade char(20),
in In_JobGradeDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from JobGrade where JobGrade = In_JobGrade) then
    update JobGrade set JobGradeDesc = In_JobGradeDesc where
      JobGrade = In_JobGrade;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateJobHistory(
in In_PersonalSysId integer,
in In_EmployedDate date,
in In_EmploymentTypeId char(20),
in In_OrgIndustryId char(20),
in In_OrgTypeId char(20),
in In_CessationDate date,
in In_CompanyName char(100),
in In_JobTitle char(50),
in In_StartSalary double,
in In_EndSalary double,
in In_SalaryType char(20),
in In_ReasonLeaving char(100),
in In_JobGrade char(20),
in In_IsNS integer,
out Out_ErrorCode integer)
begin
  if exists(select* from JobHistory where
      JobHistory.PersonalSysId = In_PersonalSysId and JobHistory.EmployedDate = In_EmployedDate) then
    if FGetInvalidDate(In_EmployedDate) = '' then set Out_ErrorCode=-1;
      return
    end if;
    // if FGetInvalidDate(In_CessationDate) = '' then set Out_ErrorCode=-2;
    // return
    // end if;
    if FGetInvalidDate(In_CessationDate) <> '' then
      if(In_CessationDate < In_EmployedDate) then set Out_ErrorCode=-3;
        return
      end if
    end if;
    if In_CompanyName is null then set Out_ErrorCode=-4;
      return
    end if;
    if In_JobTitle is null then set Out_ErrorCode=-5;
      return
    end if;
    update JobHistory set
      JobHistory.EmploymentTypeId = In_EmploymentTypeId,
      JobHistory.OrgIndustryId = In_OrgIndustryId,
      JobHistory.OrgTypeId = In_OrgTypeId,
      JobHistory.CessationDate = In_CessationDate,
      JobHistory.CompanyName = In_CompanyName,
      JobHistory.JobTitle = In_JobTitle,
      JobHistory.StartSalary = In_StartSalary,
      JobHistory.EndSalary = In_EndSalary,
      JobHistory.SalaryType = In_SalaryType,
      JobHistory.ReasonLeaving = In_ReasonLeaving,
      JobHistory.JobGrade = In_JobGrade,
      JobHistory.IsNS = In_IsNS where
      JobHistory.PersonalSysId = In_PersonalSysId and JobHistory.EmployedDate = In_EmployedDate;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateJobOpenTo(
in In_JobOpenToId char(20),
in In_JobOpenToDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from JobOpenTo where JobOpenTo.JobOpenToId = In_JobOpenToId) then
    update JobOpenTo set JobOpenToDesc = In_JobOpenToDesc where
      JobOpenToId = In_JobOpenToId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateJobResponsibility(
in In_ResponsibilityId char(20),
in In_EmployeeSysId integer,
in In_JobResponEffectiveDate date,
in In_ExpiryDate date,
in In_FreqPercent integer,
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if not exists(select* from JobRespon where JobRespon.ResponsibilityId = In_ResponsibilityId and JobRespon.EmployeeSysId = In_EmployeeSysId and JobRespon.JobResponEffectiveDate = In_JobResponEffectiveDate) then
    set Out_ErrorCode=-1; // Record not exist
    return
  elseif In_ExpiryDate < In_JobResponEffectiveDate then
    set Out_ErrorCode=-2; // Invalid date range
    return
  elseif In_FreqPercent < 0 or In_FreqPercent > 100 then
    set Out_ErrorCode=-3; // Invalid FreqPercent
    return
  else
    update JobRespon set
      JobRespon.ExpiryDate = In_ExpiryDate,
      JobRespon.FreqPercent = In_FreqPercent,
      JobRespon.Remarks = In_Remarks where
      JobRespon.ResponsibilityId = In_ResponsibilityId and
      JobRespon.EmployeeSysId = In_EmployeeSysId and
      JobRespon.JobResponEffectiveDate = In_JobResponEffectiveDate;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;

create procedure dba.UpdateMClaimAttachment(
in In_MedClaimAttachSysId integer,
in In_MedClaimFileType char(20),
in In_MedClaimSysId integer,
in In_Remarks char(200))
begin
  if exists(select* from MClaimAttachment where
      MClaimAttachment.MedClaimAttachSysId = In_MedClaimAttachSysId) then
    update MClaimAttachment set
      MClaimAttachment.MedClaimFileType = In_MedClaimFileType,
      MClaimAttachment.MedClaimSysId = In_MedClaimSysId,
      MClaimAttachment.Remarks = In_Remarks where
      MClaimAttachment.MedClaimAttachSysId = In_MedClaimAttachSysId;
    commit work
  end if
end
;

create procedure dba.UpdateMClaimPolicy(
in In_MedClaimPolicyId char(20),
in In_MedClaimPolicyDesc char(100),
in In_MedClaimPolicyBasis char(20),
in In_MedClaimDateBasis integer)
begin
  if exists(select* from MClaimPolicy where MClaimPolicy.MedClaimPolicyId = In_MedClaimPolicyId) then
    update MClaimPolicy set
      MClaimPolicy.MedClaimPolicyDesc = In_MedClaimPolicyDesc,
      MClaimPolicy.MedClaimPolicyBasis = In_MedClaimPolicyBasis,
      MClaimPolicy.MedClaimDateBasis = In_MedClaimDateBasis where
      MClaimPolicy.MedClaimPolicyId = In_MedClaimPolicyId;
    commit work
  end if
end
;

create procedure dba.UpdateMClaimReason(
in In_MedClaimReasonId char(50),
in In_MedClaimReasonDesc char(100))
begin
  if exists(select* from MClaimReason where MClaimReason.MedClaimReasonId = In_MedClaimReasonId) then
    update MClaimReason set
      MClaimReason.MedClaimReasonDesc = In_MedClaimReasonDesc where
      MClaimReason.MedClaimReasonId = In_MedClaimReasonId;
    commit work
  end if
end
;

create procedure dba.UpdateMClaimType(
in In_MedClaimTypeId char(20),
in In_MedClaimTypeDesc char(100),
in In_MedClaimRangeBasis char(20),
in In_LimitPerCycle double,
in In_PayrollPayElementId char(20),
in In_MedClaimFunctionId char(20),
in In_SubjNoPerPolicy smallint,
in In_ProrateMethod char(20),
in In_ProrateHire smallint,
in In_ProrateCessation smallint,
in In_LimitPerCycleType char(20),
in In_LimitPerCycleKeyword char(20))
begin
  if exists(select* from MClaimType where MClaimType.MedClaimTypeId = In_MedClaimTypeId) then
    update MClaimType set
      MClaimType.MedClaimTypeDesc = In_MedClaimTypeDesc,
      MClaimType.MedClaimRangeBasis = In_MedClaimRangeBasis,
      MClaimType.LimitPerCycle = In_LimitPerCycle,
      MClaimType.PayrollPayElementId = In_PayrollPayElementId,
      MClaimType.MedClaimFunctionId = In_MedClaimFunctionId,
      MClaimType.SubjNoPerPolicy = In_SubjNoPerPolicy,
      MClaimType.ProrateMethod = In_ProrateMethod,
      MClaimType.ProrateHire = In_ProrateHire,
      MClaimType.ProrateCessation = In_ProrateCessation,
      MClaimType.LimitPerCycleType = In_LimitPerCycleType,
      MClaimType.LimitPerCycleKeyword = In_LimitPerCycleKeyword where
      MClaimType.MedClaimTypeId = In_MedClaimTypeId;
    commit work
  end if
end
;
create procedure dba.UpdateMClaimTypeRange(
in In_MedClaimTypeSysId integer,
in In_MedClaimTypeId char(20),
in In_MedClaimStringMatch char(20),
in In_MedClaimRangeFrom double,
in In_MedClaimRangeTo double,
in In_CoPaymentType integer,
in In_CoPaymentAmtPercent double,
in In_LimitPerClaim double)
begin
  if exists(select* from MClaimTypeRange where MClaimTypeRange.MedClaimTypeSysId = In_MedClaimTypeSysId and MClaimTypeRange.MedClaimTypeId = In_MedClaimTypeId) then
    update MClaimTypeRange set
      MClaimTypeRange.MedClaimTypeId = In_MedClaimTypeId,
      MClaimTypeRange.MedClaimStringMatch = In_MedClaimStringMatch,
      MClaimTypeRange.MedClaimRangeFrom = In_MedClaimRangeFrom,
      MClaimTypeRange.MedClaimRangeTo = In_MedClaimRangeTo,
      MClaimTypeRange.CoPaymentType = In_CoPaymentType,
      MClaimTypeRange.CoPaymentAmtPercent = In_CoPaymentAmtPercent,
      MClaimTypeRange.LimitPerClaim = In_LimitPerClaim where
      MClaimTypeRange.MedClaimTypeSysId = In_MedClaimTypeSysId and MClaimTypeRange.MedClaimTypeId = In_MedClaimTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateMedClaim(
in In_MedClaimSysId integer,
in In_MedClaimTypeId char(20),
in In_MedClaimReasonId char(20),
in In_PersonalSysId integer,
in In_IllnessId char(50),
in In_TreatmentTypeId char(20),
in In_SubmissionDate date,
in In_MedClaimNo char(20),
in In_MedReceiptDate date,
in In_ClaimAmount double,
in In_ReimburseAmt double,
in In_MedClaimAppr smallint,
in In_PayrollDate date,
in In_MedClaimPaid smallint,
in In_PayrollProcessDate date,
in In_PayrollEmployeeSysId integer,
in In_PayrollYear integer,
in In_PayrollPeriod integer,
in In_PayrollSubPeriod integer,
in In_VendorBilled smallint,
in In_Vendor char(20),
in In_VendorAmount double,
in In_UseMedSaveClaim smallint,
in In_InsuranceClaim smallint,
in In_InsuranceRefNo char(50),
in In_HospitalClinic char(20),
in In_TreatmentFrom date,
in In_TreatmentTo date,
in In_TreatmentLength double,
in In_ePortalStatus char(20),
in In_MedExRecSysId integer,
in In_Remarks char(200))
begin
  if exists(select* from MedClaim where MedClaim.MedClaimSysId = In_MedClaimSysId) then
    update MedClaim set
      MedClaimTypeId = In_MedClaimTypeId,
      MedClaimReasonId = In_MedClaimReasonId,
      PersonalSysId = In_PersonalSysId,
      IllnessId = In_IllnessId,
      TreatmentTypeId = In_TreatmentTypeId,
      SubmissionDate = In_SubmissionDate,
      MedClaimNo = In_MedClaimNo,
      MedReceiptDate = In_MedReceiptDate,
      ClaimAmount = In_ClaimAmount,
      ReimburseAmt = In_ReimburseAmt,
      MedClaimAppr = In_MedClaimAppr,
      PayrollDate = In_PayrollDate,
      MedClaimPaid = In_MedClaimPaid,
      PayrollProcessDate = In_PayrollProcessDate,
      PayrollEmployeeSysId = In_PayrollEmployeeSysId,
      PayrollYear = In_PayrollYear,
      PayrollPeriod = In_PayrollPeriod,
      PayrollSubPeriod = In_PayrollSubPeriod,
      VendorBilled = In_VendorBilled,
      Vendor = In_Vendor,
      VendorAmount = In_VendorAmount,
      UseMedSaveClaim = In_UseMedSaveClaim,
      InsuranceClaim = In_InsuranceClaim,
      InsuranceRefNo = In_InsuranceRefNo,
      HospitalClinic = In_HospitalClinic,
      TreatmentFrom = In_TreatmentFrom,
      TreatmentTo = In_TreatmentTo,
      TreatmentLength = In_TreatmentLength,
      Remarks = In_Remarks,
      MedExRecSysId = In_MedExRecSysId,
      ePortalStatus = In_ePortalStatus where
      MedClaim.MedClaimSysId = In_MedClaimSysId;
    commit work
  end if
end
;

create procedure dba.UpdateMedClaimHistory(
in In_MedClaimSysId integer,
in In_MClaimPolicyId char(20),
in In_MClaimPolicyBasisValue char(20),
in In_MClaimTypeBasisValue char(20),
in In_MedClaimCycleStart date,
in In_MedClaimCycleEnd date,
in In_LimitPerClaim double,
in In_LimitPerCycle double,
in In_LimitPerPolicy double,
in In_NoLimitPerPolicy integer,
in In_CoPaymentType integer,
in In_CoPaymentAmtPercent double,
in In_MedClaimCompanyPay double,
in In_MedClaimEmployeePay double)
begin
  if exists(select* from MedClaimHistory where MedClaimHistory.MedClaimSysId = In_MedClaimSysId) then
    update MedClaimHistory set
      MedClaimHistory.MClaimPolicyId = In_MClaimPolicyId,
      MedClaimHistory.MClaimPolicyBasisValue = In_MClaimPolicyBasisValue,
      MedClaimHistory.MClaimTypeBasisValue = In_MClaimTypeBasisValue,
      MedClaimHistory.MedClaimCycleStart = In_MedClaimCycleStart,
      MedClaimHistory.MedClaimCycleEnd = In_MedClaimCycleEnd,
      MedClaimHistory.LimitPerClaim = In_LimitPerClaim,
      MedClaimHistory.LimitPerCycle = In_LimitPerCycle,
      MedClaimHistory.LimitPerPolicy = In_LimitPerPolicy,
      MedClaimHistory.NoLimitPerPolicy = In_NoLimitPerPolicy,
      MedClaimHistory.CoPaymentType = In_CoPaymentType,
      MedClaimHistory.CoPaymentAmtPercent = In_CoPaymentAmtPercent,
      MedClaimHistory.MedClaimCompanyPay = In_MedClaimCompanyPay,
      MedClaimHistory.MedClaimEmployeePay = In_MedClaimEmployeePay where
      MedClaimHistory.MedClaimSysId = In_MedClaimSysId;
    commit work
  end if
end
;

create procedure dba.UpdateMedExDetType(
in In_MedExDetTypeId char(20),
in In_MedExDetTypeDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from MedExDetType where MedExDetTypeId = In_MedExDetTypeId) then
    update MedExDetType set MedExDetTypeDesc = In_MedExDetTypeDesc where
      MedExDetTypeId = In_MedExDetTypeId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateMedExRec(
in In_MedExRecSysId integer,
in In_ReviewTypeId char(20),
in In_PersonalSysId integer,
in In_ReceiptNo char(20),
in In_ReceiptDate date,
in In_ePortalStatus char(20),
in In_ePortalEmployeeSysId integer,
in In_ReviewDate date,
in In_ReviewFee double,
in In_Remarks char(100),
in In_FollowUpDate date,
out Out_ErrorCode integer)
begin
  if exists(select* from MedExRec where MedExRec.MedExRecSysId = In_MedExRecSysId) then
    update MedExRec set
      MedExRec.ReviewTypeId = In_ReviewTypeId,
      MedExRec.PersonalSysId = In_PersonalSysId,
      MedExRec.ReceiptNo = In_ReceiptNo,
      MedExRec.ReceiptDate = In_ReceiptDate,
      MedExRec.ePortalStatus = In_ePortalStatus,
      MedExRec.ePortalEmployeeSysId = In_ePortalEmployeeSysId,
      MedExRec.ReviewDate = In_ReviewDate,
      MedExRec.ReviewFee = In_ReviewFee,
      MedExRec.Remarks = In_Remarks,
      MedExRec.FollowUpDate = In_FollowUpDate where
      MedExRec.MedExRecSysId = In_MedExRecSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateMedia(
in In_MediaId char(20),
in In_MediaDesc char(100),
in In_MediaLang char(20),
out Out_ErrorCode integer)
begin
  if exists(select* from Media where Media.MediaId = In_MediaId) then
    update Media set MediaDesc = In_MediaDesc,MediaLang = In_MediaLang where
      MediaId = In_MediaId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateMediHistory(
in In_IllnessId char(50),
in In_PersonalSysId integer,
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from MediHistory where
      MediHistory.IllnessId = In_IllnessId and MediHistory.PersonalSysId = In_PersonalSysId) then
    update MediHistory set
      MediHistory.Remarks = In_Remarks where
      MediHistory.IllnessId = In_IllnessId and MediHistory.PersonalSysId = In_PersonalSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateMediHistoryAttach(
in In_IllnessId char(50),
in In_PersonalSysId integer,
in In_MediHistoryAttachSysId integer,
in In_AttachFileType char(20),
in In_AttachRemarks char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from MediHistoryAttach where
      MediHistoryAttach.IllnessId = In_IllnessId and
      MediHistoryAttach.PersonalSysId = In_PersonalSysId and
      MediHistoryAttach.MediHistoryAttachSysId = In_MediHistoryAttachSysId) then
    update MediHistoryAttach set AttachFileType = In_AttachFileType,
      AttachRemarks = In_AttachRemarks where
      MediHistoryAttach.IllnessId = In_IllnessId and
      MediHistoryAttach.PersonalSysId = In_PersonalSysId and
      MediHistoryAttach.MediHistoryAttachSysId = In_MediHistoryAttachSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateMembershipCode(
in In_OrganisationCode char(20),
in In_MembershipCode char(20),
in In_MembershipDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from MembershipCode where OrganisationCode = In_OrganisationCode and
      MembershipCode = In_MembershipCode) then
    update MembershipCode set
      MembershipDesc = In_MembershipDesc where
      OrganisationCode = In_OrganisationCode and
      MembershipCode = In_MembershipCode;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateMemship(
in In_MemSysId integer,
in In_PersonalSysId integer,
in In_OrganisationCode char(20),
in In_MembershipCode char(20),
in In_MemId char(20),
in In_MemEnrollDate date,
in In_MemExpiryDate date,
in In_MemFee double,
in In_PayrollDate date,
in In_PayrollEmployeeSysId integer,
in In_PayrollPayElement char(20),
in In_PayrollYear integer,
in In_PayrollPeriod integer,
in In_PayrollSubPeriod integer,
in In_PayrollProcessDate date,
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  if FGetInvalidDate(In_MemEnrollDate) = '' then set Out_ErrorCode=-1;
    return
  end if;
  if(FGetInvalidDate(In_MemExpiryDate) <> '') and(In_MemExpiryDate < In_MemEnrollDate) then set Out_ErrorCode=-2;
    return
  end if;
  if exists(select* from Memship where
      Memship.MemSysId = In_MemSysId) then
    update Memship set
      Memship.PersonalSysId = In_PersonalSysId,
      Memship.OrganisationCode = In_OrganisationCode,
      Memship.MembershipCode = In_MembershipCode,
      Memship.MemId = In_MemId,
      Memship.MemEnrollDate = In_MemEnrollDate,
      Memship.MemExpiryDate = In_MemExpiryDate,
      Memship.MemFee = In_MemFee,
      Memship.PayrollDate = In_PayrollDate,
      Memship.PayrollEmployeeSysId = In_PayrollEmployeeSysId,
      Memship.PayrollPayElement = In_PayrollPayElement,
      Memship.PayrollYear = In_PayrollYear,
      Memship.PayrollPeriod = In_PayrollPeriod,
      Memship.PayrollSubPeriod = In_PayrollSubPeriod,
      Memship.PayrollProcessDate = In_PayrollProcessDate,
      Memship.Remarks = In_Remarks where
      Memship.MemSysId = In_MemSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateOffenceType(
in In_OffenceType char(20),
in In_OffenceTypeDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from OffenceType where OffenceType = In_OffenceType) then
    update OffenceType set OffenceTypeDesc = In_OffenceTypeDesc where
      OffenceType = In_OffenceType;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateOrganisation(
in In_OrganisationCode char(20),
in In_OrgIndustryId char(20),
in In_OrgTypeId char(20),
in In_OrganisationName char(100),
in In_OrganisationRefNo char(20),
in In_OrganisationURL char(100),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_Country char(20),
in In_City char(20),
in In_State char(20),
in In_PCode char(20),
in In_ContactNo1 char(20),
in In_ContactNo2 char(20),
in In_ContactEmail char(100),
in In_ContactFax char(20),
in In_IsMedicalVendor smallint,
in In_IsTrainingOrganiser smallint,
in In_IsMembership smallint,
in In_IsSupplier smallint,
in In_IsContractor smallint,
in In_ContractorCode char(20),
in In_ContractCategoryId char(20))
begin
  if exists(select* from Organisation where Organisation.OrganisationCode = In_OrganisationCode) then
    update Organisation set
      OrgIndustryId = In_OrgIndustryId,
      OrgTypeId = In_OrgTypeId,
      OrganisationName = In_OrganisationName,
      OrganisationRefNo = In_OrganisationRefNo,
      OrganisationURL = In_OrganisationURL,
      Address1 = In_Address1,
      Address2 = In_Address2,
      Address3 = In_Address3,
      Country = In_Country,
      City = In_City,
      State = In_State,
      PCode = In_PCode,
      ContactNo1 = In_ContactNo1,
      ContactNo2 = In_ContactNo2,
      ContactEmail = In_ContactEmail,
      ContactFax = In_ContactFax,
      IsMedicalVendor = In_IsMedicalVendor,
      IsTrainingOrganiser = In_IsTrainingOrganiser,
      IsMembership = In_IsMembership,
      IsSupplier = In_IsSupplier,
      IsContractor = In_IsContractor,
      ContractorCode = In_ContractorCode,
      ContractCategoryId = In_ContractCategoryId where Organisation.OrganisationCode = In_OrganisationCode;
    commit work
  end if
end
;

create procedure dba.UpdateOrganisationIndustry(
in In_OrgIndustryId char(20),
in In_OrgIndustryDesc char(100))
begin
  if exists(select* from OrganisationIndustry where
      OrganisationIndustry.OrgIndustryId = In_OrgIndustryId) then
    update OrganisationIndustry set
      OrgIndustryDesc = In_OrgIndustryDesc where
      OrganisationIndustry.OrgIndustryId = In_OrgIndustryId;
    commit work
  end if
end
;

create procedure dba.UpdateOrganisationType(
in In_OrgIndustryId char(20),
in In_OrgTypeId char(20),
in In_OrgTypeDesc char(100))
begin
  if exists(select* from OrganisationType where
      OrganisationType.OrgIndustryId = In_OrgIndustryId and
      OrganisationType.OrgTypeId = In_OrgTypeId) then
    update OrganisationType set
      OrgTypeDesc = In_OrgTypeDesc where
      OrganisationType.OrgIndustryId = In_OrgIndustryId and
      OrganisationType.OrgTypeId = In_OrgTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateOrganiser(
in In_OrganisationCode char(20),
in In_OrgIndustryId char(20),
in In_OrganisationName char(100),
in In_OrganisationRefNo char(20),
in In_OrganisationURL char(100),
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_ContactNo1 char(20),
in In_ContactNo2 char(20),
in In_ContactEmail char(100),
in In_ContactFax char(20),
in In_IsMedicalVendor smallint,
in In_IsTrainingOrganiser smallint)
begin
  if exists(select* from Organiser where Organiser.OrganisationCode = In_OrganisationCode and
      Organiser.OrgIndustryId = In_OrgIndustryId) then
    update Organiser set
      OrganisationName = In_OrganisationName,
      OrganisationRefNo = In_OrganisationRefNo,
      OrganisationURL = In_OrganisationURL,
      Address1 = In_Address1,
      Address2 = In_Address2,
      Address3 = In_Address3,
      ContactNo1 = In_ContactNo1,
      ContactNo2 = In_ContactNo2,
      ContactEmail = In_ContactEmail,
      ContactFax = In_ContactFax,
      IsMedicalVendor = In_IsMedicalVendor,
      IsTrainingOrganiser = In_IsTrainingOrganiser where Organiser.OrganisationCode = In_OrganisationCode and
      Organiser.OrgIndustryId = In_OrgIndustryId;
    commit work
  end if
end
;

create procedure dba.UpdateOrgCWorker(
in In_OrganisationCode char(20),
in In_PersonalSysId integer,
in In_OtherId char(20),
in In_WorkerDesignation char(50),
out Out_ErrorCode integer)
begin
  if In_PersonalSysId is null or In_PersonalSysId = 0 then set Out_ErrorCode=-1;
    return
  end if;
  if exists(select* from CWorker where
      CWorker.OrganisationCode = In_OrganisationCode and
      CWorker.PersonalSysId = In_PersonalSysId) then
    update CWorker set
      CWorker.OtherId = In_OtherId,
      CWorker.WorkerDesignation = In_WorkerDesignation where
      CWorker.OrganisationCode = In_OrganisationCode and
      CWorker.PersonalSysId = In_PersonalSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateProjCostType(
in In_ProjectCostTypeId char(20),
in In_ProjectCostDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from ProjCostType where ProjectCostTypeId = In_ProjectCostTypeId) then
    update ProjCostType set ProjectCostDesc = In_ProjectCostDesc where
      ProjectCostTypeId = In_ProjectCostTypeId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateRecruitPosition(
in In_RecruitCode char(20),
in In_PositionId char(20),
in In_CategoryId char(20),
in In_DepartmentId char(20),
in In_RecruitDesc char(100),
in In_Vacancy integer,
in In_ExpMinSalary double,
in In_ExpMaxSalary double,
in In_PosAdvertiseAs char(100),
in In_StartDate date,
in In_Remarks char(100),
in In_PersonInCharge char(100),
in In_EndDate date,
out Out_ErrorCode integer)
begin
  if In_RecruitCode is null then set Out_ErrorCode=-1;
    return
  end if;
  if In_PositionId is null then set Out_ErrorCode=-2;
    return
  end if;
  if FGetInvalidDate(In_StartDate) = '' then set Out_ErrorCode=-3;
    return
  end if;
  if exists(select* from RecruitPosition where RecruitCode = In_RecruitCode) then
    update RecruitPosition set
      RecruitPosition.RecruitCode = In_RecruitCode,
      RecruitPosition.PositionId = In_PositionId,
      RecruitPosition.CategoryId = In_CategoryId,
      RecruitPosition.DepartmentId = In_DepartmentId,
      RecruitPosition.RecruitDesc = In_RecruitDesc,
      RecruitPosition.Vacancy = In_Vacancy,
      RecruitPosition.ExpMinSalary = In_ExpMinSalary,
      RecruitPosition.ExpMaxSalary = In_ExpMaxSalary,
      RecruitPosition.PosAdvertiseAs = In_PosAdvertiseAs,
      RecruitPosition.StartDate = In_StartDate,
      RecruitPosition.Remarks = In_Remarks,
      RecruitPosition.PersonInCharge = In_PersonInCharge,
      RecruitPosition.EndDate = In_EndDate where
      RecruitPosition.RecruitCode = In_RecruitCode;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateReviewAttachment(
in In_MedExRecSysId integer,
in In_ReviewAttachSysId integer,
in In_AttachDate date,
in In_AttachFileType char(20),
in In_Remarks char(100),
in In_IsMediExamResult integer,
out Out_ErrorCode integer)
begin
  if exists(select* from ReviewAttachment where
      ReviewAttachment.MedExRecSysId = In_MedExRecSysId and
      ReviewAttachment.ReviewAttachSysId = In_ReviewAttachSysId) then
    update ReviewAttachment set AttachDate = In_AttachDate,
      AttachFileType = In_AttachFileType,
      Remarks = In_Remarks,
      IsMediExamResult = In_IsMediExamResult where
      ReviewAttachment.MedExRecSysId = In_MedExRecSysId and
      ReviewAttachment.ReviewAttachSysId = In_ReviewAttachSysId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateReviewType(
in In_ReviewTypeId char(20),
in In_ReviewTypeDesc char(100),
out Out_ErrorCode integer)
begin
  if exists(select* from ReviewType where ReviewTypeId = In_ReviewTypeId) then
    update ReviewType set ReviewTypeDesc = In_ReviewTypeDesc where
      ReviewTypeId = In_ReviewTypeId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateSkill(
in In_SkillCode char(20),
in In_CourseSkillTypeId char(20),
in In_SkillDesc char(100))
begin
  if exists(select* from Skill where Skill.SkillCode = In_SkillCode) then
    update Skill set
      CourseSkillTypeId = In_CourseSkillTypeId,
      SkillDesc = In_SkillDesc where
      Skill.SkillCode = In_SkillCode;
    commit work
  end if
end
;

create procedure dba.UpdateSkillGrade(
in In_SkillCode char(20),
in In_GradeCode char(20),
in In_SkillProfFrom double,
in In_SkillProfTo double)
begin
  if exists(select* from SkillGrade where
      SkillGrade.SkillCode = In_SkillCode and
      SkillGrade.GradeCode = In_GradeCode) then
    update SkillGrade set
      SkillProfFrom = In_SkillProfFrom,
      SkillProfTo = In_SkillProfTo where
      SkillGrade.SkillCode = In_SkillCode and
      SkillGrade.GradeCode = In_GradeCode;
    commit work
  end if
end
;

create procedure dba.UpdateSkillLevel(
in In_PersonalSysId integer,
in In_SkillCode char(20),
in In_SkillEffectiveDate date,
in In_GradeCode char(20),
in In_SkillProficiency double,
in In_SkillExpiryDate date,
in In_SkillRemarks char(100))
begin
  if exists(select* from SkillLevel where
      SkillLevel.PersonalSysId = In_PersonalSysId and
      SkillLevel.SkillCode = In_SkillCode and
      SkillLevel.SkillEffectiveDate = In_SkillEffectiveDate) then
    update SkillLevel set
      GradeCode = In_GradeCode,
      SkillProficiency = In_SkillProficiency,
      SkillExpiryDate = In_SkillExpiryDate,
      SkillRemarks = In_SkillRemarks where
      SkillLevel.PersonalSysId = In_PersonalSysId and
      SkillLevel.SkillCode = In_SkillCode and
      SkillLevel.SkillEffectiveDate = In_SkillEffectiveDate;
    commit work
  end if
end
;

create procedure dba.UpdateSponsorGrant(
in In_SponsorGrantCode char(20),
in In_SponsorGrantDesc char(100))
begin
  if exists(select* from SponsorGrant where SponsorGrant.SponsorGrantCode = In_SponsorGrantCode) then
    update SponsorGrant set
      SponsorGrantDesc = In_SponsorGrantDesc where
      SponsorGrant.SponsorGrantCode = In_SponsorGrantCode;
    commit work
  end if
end
;

create procedure dba.UpdateSponsorship(
in In_SponsorshipCode char(20),
in In_SponsorshipDesc char(100))
begin
  if exists(select* from Sponsorship where SponsorshipCode = In_SponsorshipCode) then
    update Sponsorship set
      SponsorshipDesc = In_SponsorshipDesc where
      SponsorshipCode = In_SponsorshipCode;
    commit work
  end if
end
;

create procedure dba.UpdateSuccession(
in In_EmployeeSysId integer,
in In_ScessorEmployeeId integer,
in In_ScessType char(20),
in In_ReadyDate date,
in In_SelectedDate date,
in In_IsPotential smallint,
in In_Remarks char(100),
out Out_ErrorCode integer)
begin
  declare NewSuccessionOrder integer;
  if not exists(select* from Succession where EmployeeSysId = In_EmployeeSysId and ScessorEmployeeId = In_ScessorEmployeeId and ScessType = In_ScessType) then
    set Out_ErrorCode=-1; // Record not exists
    return
  elseif not In_ScessorEmployeeId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-2; // ScessorEmployeeId not exist
    return
  elseif not In_EmployeeSysId = any(select EmployeeSysId from Employee) then
    set Out_ErrorCode=-3; // EmployeeSysId not exist
    return
  else
    update Succession set
      ReadyDate = In_ReadyDate,
      SelectedDate = In_SelectedDate,
      IsPotential = In_IsPotential,
      Remarks = In_Remarks where
      EmployeeSysId = In_EmployeeSysId and
      ScessorEmployeeId = In_ScessorEmployeeId and
      ScessType = In_ScessType;
    commit work
  end if;
  set Out_ErrorCode=1 // Successful
end
;

create procedure dba.UpdateTest(
in In_TestId char(20),
in In_TestDesc char(100),
in In_PracticalTest integer,
in In_TheoryTest integer,
out Out_ErrorCode integer)
begin
  if exists(select* from Test where TestId = In_TestId) then
    update Test set TestDesc = In_TestDesc,
      PracticalTest = In_PracticalTest,
      TheoryTest = In_TheoryTest where
      TestId = In_TestId;
    commit work;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create procedure dba.UpdateTrainCostType(
in In_TrainCostTypeId char(20),
in In_TrainCostTypeDesc char(100),
in In_TrainForClaim integer)
begin
  if exists(select* from TrainCostType where TrainCostType.TrainCostTypeId = In_TrainCostTypeId) then
    update TrainCostType set
      TrainCostType.TrainCostTypeDesc = In_TrainCostTypeDesc,
      TrainCostType.TrainForClaim = In_TrainForClaim where
      TrainCostType.TrainCostTypeId = In_TrainCostTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateTraining(
in In_TrainingSysID integer,
in In_PersonalSysId integer,
in In_CourseCode char(20),
in In_CourseScheduleSysId integer,
in In_SubmissionDate date,
in In_TrainingBatchId char(20),
in In_SponsorShipCode char(20),
in In_GradeCode char(20),
in In_Approve smallint,
in In_CourseResult double,
in In_AttendancePercent double,
in In_TrainingRemarks char(100),
in In_TotalTrainingFee double,
in In_TotalTaxAmount double,
in In_SponsorType integer,
in In_SponsorValue double,
in In_SponsorReceived date,
in In_GovGrantType integer,
in In_GovGrantValue double,
in In_GovGrantReceived date,
in In_ClaimAmount double,
in In_ClaimAdvance double,
in In_ClaimApprove smallint,
in In_PayrollDate date,
in In_PayrollEmployeeSysId integer,
in In_PayrollProcessDate date,
in In_PayrollYear integer,
in In_PayrollPeriod integer,
in In_PayrollSubPeriod integer,
in In_PayrollPayElementId char(20),
in In_TrainingPaid smallint,
in In_GovernmentGrantId char(20),
in In_ePortalStatus char(20),
in In_ePortalEmployeeSysId integer,
in In_BondSysId integer)
begin
  declare In_ePortalNominateEmpSysId integer;
  if exists(select* from Training where
      Training.TrainingSysID = In_TrainingSysID) then
    if(In_BondSysId = 0) then set In_BondSysId=null
    end if;
    if(In_ePortalStatus = 'TrainNominate') then set In_ePortalNominateEmpSysId=In_ePortalEmployeeSysId
    else
      select ePortalNominateEmpSysId into In_ePortalNominateEmpSysId from Training where Training.TrainingSysID = In_TrainingSysID
    end if;
    update Training set
      PersonalSysId = In_PersonalSysId,
      CourseCode = In_CourseCode,
      CourseScheduleSysId = In_CourseScheduleSysId,
      SubmissionDate = In_SubmissionDate,
      TrainingBatchId = In_TrainingBatchId,
      SponsorShipCode = In_SponsorShipCode,
      GradeCode = In_GradeCode,
      Approve = In_Approve,
      CourseResult = In_CourseResult,
      AttendancePercent = In_AttendancePercent,
      TrainingRemarks = In_TrainingRemarks,
      TotalTrainingFee = In_TotalTrainingFee,
      TotalTaxAmount = In_TotalTaxAmount,
      SponsorType = In_SponsorType,
      SponsorValue = In_SponsorValue,
      SponsorReceived = In_SponsorReceived,
      GovGrantType = In_GovGrantType,
      GovGrantValue = In_GovGrantValue,
      GovGrantReceived = In_GovGrantReceived,
      ClaimAmount = In_ClaimAmount,
      ClaimAdvance = In_ClaimAdvance,
      ClaimApprove = In_ClaimApprove,
      PayrollDate = In_PayrollDate,
      PayrollEmployeeSysId = In_PayrollEmployeeSysId,
      PayrollProcessDate = In_PayrollProcessDate,
      PayrollYear = In_PayrollYear,
      PayrollPeriod = In_PayrollPeriod,
      PayrollSubPeriod = In_PayrollSubPeriod,
      PayrollPayElementId = In_PayrollPayElementId,
      TrainingPaid = In_TrainingPaid,
      GovernmentGrantId = In_GovernmentGrantId,
      ePortalStatus = In_ePortalStatus,
      ePortalEmployeeSysId = In_ePortalEmployeeSysId,
      ePortalNominateEmpSysId = In_ePortalNominateEmpSysId,
      BondSysId = In_BondSysId where
      Training.TrainingSysID = In_TrainingSysID;
    commit work;
    if(In_ePortalStatus = 'TrainAccepted' and In_Approve = 1 and
      not exists(select* from TrainCostRec where TrainingSysId = In_TrainingSysID and TrainCostTypeId = 'Course Fee')) then
      insert into TrainCostRec(TrainingSysId,TrainCostTypeId,TrainAmount,TrainTaxAmount,TrainForClaim) values(
        In_TrainingSysID,'Course Fee',
        (select CourseFee from CourseSchedule where CourseScheduleSysId = In_CourseScheduleSysId and CourseCode = In_CourseCode),
        0,(select TrainForClaim from TrainCostType where TrainCostTypeId = 'Course Fee'));
      commit work
    end if
  end if
end
;

create procedure dba.UpdateTrainingAttachment(
in In_TrainingSysId integer,
in In_TrainAttachDate timestamp,
in In_TrainAttachRemarks char(100),
in In_TrainAttachFileType char(20))
begin
  if exists(select* from TrainingAttachment where
      TrainingAttachment.TrainingSysId = In_TrainingSysId and
      TrainingAttachment.TrainAttachDate = In_TrainAttachDate) then
    update TrainingAttachment set
      TrainAttachRemarks = In_TrainAttachRemarks,
      TrainAttachFileType = In_TrainAttachFileType where
      TrainingAttachment.TrainingSysId = In_TrainingSysId and
      TrainingAttachment.TrainAttachDate = In_TrainAttachDate;
    commit work
  end if
end
;

create procedure dba.UpdateTrainingBatch(
in In_TrainingBatchId char(20),
in In_Approve integer,
in In_CourseCode char(20),
in In_CourseScheduleSysId integer,
in In_LastModified timestamp,
in In_PayrollDate date,
in In_PayrollPayElementId char(20),
in In_SponsorShipCode char(20),
in In_SponsorType integer,
in In_SponsorValue double,
in In_SubmissionDate date,
in In_TrainingBatchDesc char(100),
in In_TrainingRemarks char(100),
in In_TotalTrainingFee double,
in In_TotalTaxAmount double,
in In_ClaimApprove integer,
in In_TrainTaxComputation integer,
in In_TrainingPaid integer,
in In_SponsorReceived date,
in In_GovernmentGrantId char(20),
in In_GovGrantType integer,
in In_GovGrantValue double,
in In_GovGrantReceived date)
begin
  if exists(select* from TrainingBatch where TrainingBatchId = In_TrainingBatchId) then
    update TrainingBatch set
      Approve = In_Approve,
      CourseCode = In_CourseCode,
      CourseScheduleSysId = In_CourseScheduleSysId,
      LastModified = In_LastModified,
      PayrollDate = In_PayrollDate,
      PayrollPayElementId = In_PayrollPayElementId,
      SponsorShipCode = In_SponsorShipCode,
      SponsorType = In_SponsorType,
      SponsorValue = In_SponsorValue,
      SubmissionDate = In_SubmissionDate,
      TrainingBatchDesc = In_TrainingBatchDesc,
      TrainingRemarks = In_TrainingRemarks,
      TotalTrainingFee = In_TotalTrainingFee,
      TotalTaxAmount = In_TotalTaxAmount,
      ClaimApprove = In_ClaimApprove,
      TrainTaxComputation = In_TrainTaxComputation,
      TrainingPaid = In_TrainingPaid,
      SponsorReceived = In_SponsorReceived,
      GovernmentGrantId = In_GovernmentGrantId,
      GovGrantType = In_GovGrantType,
      GovGrantValue = In_GovGrantValue,
      GovGrantReceived = In_GovGrantReceived where
      TrainingBatchId = In_TrainingBatchId;
    commit work
  end if
end
;

create procedure dba.UpdateTrainingHistory(
in In_TrainingSysId integer,
in In_HisServiceYr double,
in In_HisEducationId char(20),
in In_HisBranchId char(20),
in In_HisCategoryId char(20),
in In_HisDepartmentId char(20),
in In_HisPositionId char(20),
in In_HisSectionId char(20),
in In_HisSupervisorId char(30))
begin
  if exists(select* from TrainingHistory where TrainingHistory.TrainingSysId = In_TrainingSysId) then
    update TrainingHistory set
      HisServiceYr = In_HisServiceYr,
      HisEducationId = In_HisEducationId,
      HisBranchId = In_HisBranchId,
      HisCategoryId = In_HisCategoryId,
      HisDepartmentId = In_HisDepartmentId,
      HisPositionId = In_HisPositionId,
      HisSectionId = In_HisSectionId,
      HisSupervisorId = In_HisSupervisorId where
      TrainingHistory.TrainingSysId = In_TrainingSysId;
    commit work
  end if
end
;

create procedure dba.UpdateTrainingPersonnel(
in In_TrainingBatchId char(20),
in In_TrainPersonalSysId integer,
in In_TrainAppraisalSysId integer,
in In_TrainApprTrainingSysId integer)
begin
  if exists(select* from TrainingPersonnel where TrainingBatchId = In_TrainingBatchId and
      TrainPersonalSysId = In_TrainPersonalSysId) then
    update TrainingBatch set
      TrainAppraisalSysId = In_TrainAppraisalSysId,
      TrainApprTrainingSysId = In_TrainApprTrainingSysId where
      TrainingBatchId = In_TrainingBatchId and
      TrainPersonalSysId = In_TrainPersonalSysId;
    commit work
  end if
end
;

create procedure dba.UpdateTrainingType(
in In_TrainingTypeId char(20),
in In_TrainingTypeDesc char(100))
begin
  if exists(select* from TrainingType where TrainingType.TrainingTypeId = In_TrainingTypeId) then
    update TrainingType set
      TrainingTypeDesc = In_TrainingTypeDesc where
      TrainingType.TrainingTypeId = In_TrainingTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateTreatmentType(
in In_TreatmentTypeId char(20),
in In_TreatmentDesc char(100))
begin
  if exists(select* from TreatmentType where TreatmentType.TreatmentTypeId = In_TreatmentTypeId) then
    update TreatmentType set
      TreatmentType.TreatmentDesc = In_TreatmentDesc where
      TreatmentType.TreatmentTypeId = In_TreatmentTypeId;
    commit work
  end if
end
;

create procedure dba.UpdateVenue(
in In_VenueCode char(20),
in In_OrganisationCode char(20),
in In_VenueDesc char(100),
in In_ForTraining smallint,
in In_ForEvent smallint,
in In_Address1 char(40),
in In_Address2 char(40),
in In_Address3 char(40),
in In_VenueURL char(100),
in In_ContactNo1 char(40),
in In_ContactNo2 char(40),
in In_ContactFax char(40),
in In_ForProject smallint)
begin
  if exists(select* from Venue where Venue.VenueCode = In_VenueCode) then
    update Venue set
      OrganisationCode = In_OrganisationCode,
      VenueDesc = In_VenueDesc,
      ForTraining = In_ForTraining,
      ForEvent = In_ForEvent,
      ForProject = In_ForProject,
      Address1 = In_Address1,
      Address2 = In_Address2,
      Address3 = In_Address3,
      VenueURL = In_VenueURL,
      ContactNo1 = In_ContactNo1,
      ContactNo2 = In_ContactNo2,
      ContactFax = In_ContactFax where
      Venue.VenueCode = In_VenueCode;
    commit work
  end if
end
;

create function dba.FGetMedClaimPolicyAccNo(
in In_PersonalSysId integer,
in In_MedClaimPolicyId char(20),
in In_ProcessDate date)
returns integer
begin
  declare Out_MedClaimCycleStart date;
  declare Out_MedClaimCycleEnd date;
  declare Out_NoOfRecord integer;
  declare Out_MedClaimDateBasis smallint;
  /*
  To extract the Policy's Cycle date range
  */
  select first MedClaimCycleStart,MedClaimCycleEnd into Out_MedClaimCycleStart,
    Out_MedClaimCycleEnd from MClaimPolicy join MClaimCycle where
    MClaimPolicy.MedClaimPolicyId = In_MedClaimPolicyId and
    In_ProcessDate between MedClaimCycleStart and MedClaimCycleEnd order by MedClaimCycleStart desc;
  if(Out_MedClaimCycleStart is null) then return 0
  end if;
  /*
  To get the Date Basis
  */
  select MedClaimDateBasis into Out_MedClaimDateBasis from MClaimPolicy where MClaimPolicy.MedClaimPolicyId = In_MedClaimPolicyId;
  /*
  To get the Accumulated No within date range
  */
  if(Out_MedClaimDateBasis = 0) then
    select Count(*) into Out_NoOfRecord
      from MedClaim join MedClaimHistory where
      MedClaim.MedClaimTypeId = any(select distinct MClaimPolicyRec.MedClaimTypeId from MClaimPolicyRec join MClaimType where
        MedClaimPolicyId = In_MedClaimPolicyId and
        SubjNoPerPolicy = 1) and
      PersonalSysId = In_PersonalSysId and
      ReimburseAmt > 0 and
      SubmissionDate between Out_MedClaimCycleStart and Out_MedClaimCycleEnd and
      MedClaimAppr = 1
  else
    select Count(*) into Out_NoOfRecord
      from MedClaim join MedClaimHistory where
      MedClaim.MedClaimTypeId = any(select distinct MClaimPolicyRec.MedClaimTypeId from MClaimPolicyRec join MClaimType where
        MedClaimPolicyId = In_MedClaimPolicyId and
        SubjNoPerPolicy = 1) and
      PersonalSysId = In_PersonalSysId and
      ReimburseAmt > 0 and
      MedReceiptDate between Out_MedClaimCycleStart and Out_MedClaimCycleEnd and
      MedClaimAppr = 1
  end if;
  if(Out_NoOfRecord is null) then return 0
  end if;
  return Out_NoOfRecord
end
;

create procedure DBA.ASQLCopyRecruitPosition(
in In_RecruitCode char(20),
in In_NewRecruitCode char(20),
in In_CopyAdvDetails integer,
in In_CopyPosOpenTo integer,
in In_CopyInterviewer integer,
in In_CopyAttachment integer,
out Out_ErrorCode integer)
begin
  if not exists(select* from RecruitPosition where RecruitCode = In_RecruitCode) then
    set Out_ErrorCode=-1;
    return
  end if;
  if In_NewRecruitCode = '' then
    set Out_ErrorCode=-2;
    return
  end if;
  if not exists(select* from RecruitPosition where RecruitCode = In_NewRecruitCode) then
    CopyRecruitPositionLoop: for CopyRecruitPositionFor as CopyRecruitPositionCurs dynamic scroll cursor for
      select PositionId as In_PositionId,CategoryId as In_CategoryId,
        DepartmentId as In_DepartmentId,RecruitDesc as In_RecruitDesc,
        Vacancy as In_Vacancy,ExpMinSalary as In_ExpMinSalary,
        ExpMaxSalary as In_ExpMaxSalary,PosAdvertiseAs as In_PosAdvertiseAs,
        StartDate as In_StartDate,Remarks as In_Remarks,
        PersonInCharge as In_PersonInCharge,EndDate as In_EndDate from RecruitPosition where RecruitCode = In_RecruitCode do
      call InsertNewRecruitPosition(In_NewRecruitCode,In_PositionId,In_CategoryId,In_DepartmentId,In_RecruitDesc,In_Vacancy,In_ExpMinSalary,In_ExpMaxSalary,In_PosAdvertiseAs,In_StartDate,In_Remarks,In_PersonInCharge,In_EndDate,Out_ErrorCode);
      if not exists(select* from RecruitPosition where RecruitCode = In_NewRecruitCode) then
        set Out_ErrorCode=0;
        return
      else
        //
        // Copy Job Advertise details
        // 
        if In_CopyAdvDetails = 1 then
          insert into JobAdvertise(RecruitCode,AdvertiseDate,MediaId,OrganisationCode,Cost,AdvertiseCloseDate,Remarks,ReferenceNo)
            select In_NewRecruitCode,AdvertiseDate,MediaId,OrganisationCode,Cost,AdvertiseCloseDate,Remarks,ReferenceNo from JobAdvertise where
              RecruitCode = In_RecruitCode
        end if;
        //
        // Copy Recruit Position Open To
        // 
        if In_CopyPosOpenTo = 1 then
          insert into RecruitPosOpenTo(RecruitCode,JobOpenToCode,PublishToEPortal)
            select In_NewRecruitCode,JobOpenToCode,PublishToEPortal from RecruitPosOpenTo where
              RecruitCode = In_RecruitCode
        end if;
        //
        // Copy Recruit Inteviewer
        //
        if In_CopyInterviewer = 1 then
          insert into RecruitInterviewer(RecruitCode,InterviewOrder,ePortalEmployeeSysId,InterviewerName,InterviewerPosition,KeyInterviewer)
            select In_NewRecruitCode,InterviewOrder,ePortalEmployeeSysId,InterviewerName,InterviewerPosition,KeyInterviewer from RecruitInterviewer where
              RecruitCode = In_RecruitCode
        end if;
        //
        // Copy Attachment
        // 
        if In_CopyAttachment = 1 then
          insert into JobAdAttach(JobAdAttachSysId,RecruitCode,AttachFileType,AttachmentObject,AttachRemarks,AttachDate)
            select JobAdAttachSysId,In_NewRecruitCode,AttachFileType,AttachmentObject,AttachRemarks,AttachDate from JobAdAttach where
              RecruitCode = In_RecruitCode
        end if
      end if end for;
    set Out_ErrorCode=1
  else
    set Out_ErrorCode=0
  end if
end
;

create function DBA.FGetCourseDurationConv(
in In_CourseDuration double,
in In_CourseUnit char(20),
in In_NewUnit char(20))
returns double
begin
  declare Out_NewDuration double;
  set Out_NewDuration=0;
  //
  // Convert to Hours
  //
  if In_NewUnit = 'Hours' then
    if In_CourseUnit = 'Days' then
      select(DoubleAttr*In_CourseDuration) into Out_NewDuration from SubRegistry where RegistryId = 'HRCourseDurationConv' and SubRegistryId = 'CourseDyToHr' order by
        RegProperty2 asc,RegProperty1 asc
    end if;
    if In_CourseUnit = 'Weeks' then
      select(DoubleAttr*In_CourseDuration) into Out_NewDuration from SubRegistry where RegistryId = 'HRCourseDurationConv' and SubRegistryId = 'CourseWkToHr' order by
        RegProperty2 asc,RegProperty1 asc
    end if;
    if In_CourseUnit = 'Months' then
      select(DoubleAttr*In_CourseDuration) into Out_NewDuration from SubRegistry where RegistryId = 'HRCourseDurationConv' and SubRegistryId = 'CourseMthToHr' order by
        RegProperty2 asc,RegProperty1 asc
    end if;
    if In_CourseUnit = 'Years' then
      select(DoubleAttr*In_CourseDuration) into Out_NewDuration from SubRegistry where RegistryId = 'HRCourseDurationConv' and SubRegistryId = 'CourseYrToHr' order by
        RegProperty2 asc,RegProperty1 asc
    end if
  end if;
  return Out_NewDuration
end
;

create function DBA.FGetMClaimEmployeeLimitPerCycle( 
in In_EmployeeSysId integer,
in In_MedClaimTypeId char(20),
in In_MedClaimCycleStart date,
in In_MedClaimCycleEnd date)
returns double
begin
  declare StartDate date;
  declare EndDate date;
  declare EmpLimitPerCycle double;
  declare In_LimitPerCycle double;
  declare In_LimitPerCycleType char(20);
  declare In_LimitPerCycleKeyword char(20);
  declare In_ProrateMethod char(20);
  declare In_ProrateHire smallint;
  declare In_ProrateCessation smallint;
  declare In_HasShiftRotation smallint;
  declare In_EmpCalDays double;
  declare In_CycleCalDays double;
  //================================================================
  // 
  // Compute Employee Limit Per Cycle
  //
  //================================================================
  if exists(select* from MClaimType where MedClaimTypeId = In_MedClaimTypeId) then
    select LimitPerCycle,LimitPerCycleType,LimitPerCycleKeyword,ProrateMethod,ProrateHire,ProrateCessation into In_LimitPerCycle,
      In_LimitPerCycleType,In_LimitPerCycleKeyword,In_ProrateMethod,In_ProrateHire,In_ProrateCessation from MClaimType where MedClaimTypeId = In_MedClaimTypeId;
    //
    // LimitPerCycleType = 'Fixed', EmpLimitPerCycle = LimitPerCycle
    //
    if In_LimitPerCycleType = 'MedClaimFixed' then
      set EmpLimitPerCycle=In_LimitPerCycle
    end if;
    //
    // LimitPerCycleType = 'Factor', LimitPerCycleKeyword = 'TotalWage', EmpLimitPerCycle = LimitPerCycle * FGetEmployeeCurrentTotalWage('EmployeeSysId')
    //
    if In_LimitPerCycleType = 'MedClaimFactor' then
      if In_LimitPerCycleKeyword = 'MedClaimTotalWage' then
        set EmpLimitPerCycle=In_LimitPerCycle*FGetEmployeeCurrentTotalWage(In_EmployeeSysId)
      end if;
      if In_LimitPerCycleKeyword = 'MedClaimBasicRate' then
        select(CurrentBasicRate*In_LimitPerCycle) into EmpLimitPerCycle from PayEmployee where
          EmployeeSysId = In_EmployeeSysId
      end if
    end if;
    //
    // LimitPerCycleType = 'Custom', LimitPerCycleKeyword, EmpLimitPerCycle = FGetEmpKeyWord('EmployeeSysId')
    //
    if In_LimitPerCycleType = 'MedClaimCustom' then
      if In_LimitPerCycleKeyword = 'MedClaimCustom1' then
        set EmpLimitPerCycle=FGetMClaimEmployeeLimitPerCycleCustom1(In_EmployeeSysId,In_MedClaimTypeId,In_MedClaimCycleStart,In_MedClaimCycleEnd)
      end if
    end if;
    //================================================================
    //
    // Check Proration Required, ProrateHire=1 or ProrateCessation=1, Set Employee start date and end date
    //
    //================================================================
    if In_ProrateMethod <> 'MedClaimProNone' then
      set StartDate=null;
      set EndDate=null;
      if In_ProrateHire = 1 then
        if exists(select* from Employee where EmployeeSysId = In_EmployeeSysId and HireDate between In_MedClaimCycleStart and In_MedClaimCycleEnd) then
          select HireDate into StartDate from Employee where EmployeeSysId = In_EmployeeSysId;
          set EndDate=In_MedClaimCycleEnd
        end if
      end if;
      if In_ProrateCessation = 1 then
        if exists(select* from Employee where EmployeeSysId = In_EmployeeSysId and CessationDate between In_MedClaimCycleStart and In_MedClaimCycleEnd) then
          select CessationDate into EndDate from Employee where EmployeeSysId = In_EmployeeSysId;
          if StartDate is null then
            set StartDate=In_MedClaimCycleStart
          end if
        end if
      end if;
      //================================================================
      //
      // Prorate Employee Limit Per Cycle
      //
      //================================================================
      if StartDate is not null and EndDate is not null then
        if In_ProrateMethod = 'MedClaimProWCalenDay' then
          //
          // For Prorate Method by Working Calendar Days :
          // Check is it a Shift employee : LeaveEmployee.HasShiftRotation =1
          //
          select HasShiftRotation into In_HasShiftRotation from LeaveEmployee where EmployeeSysId = In_EmployeeSysId;
          if In_HasShiftRotation = 1 then
            //
            // Get Shift Employee Prorated Days
            //
            select Sum(Pattern) into In_EmpCalDays from
              (select ShiftCalendarDate,WTCalendarId as DayWTCalendarId,
                (select LveCalendarId from WTCalendar where WTCalendarId = DayWTCalendarId) as DayCalendar,
                (select WKCalenDayWKPattern from CalendarDay where CalendarIdCode = DayCalendar and CalendarDate = ShiftCalendarDate) as Pattern from
                ShiftCalendar where EmployeeSysId = In_EmployeeSysId and ShiftCalendarDate between StartDate and EndDate) as MyShiftPattern;
            //
            // Get Cycle Shift Employee Working Days
            //
            select Sum(Pattern) into In_CycleCalDays from
              (select ShiftCalendarDate,WTCalendarId as DayWTCalendarId,
                (select LveCalendarId from WTCalendar where WTCalendarId = DayWTCalendarId) as DayCalendar,
                (select WKCalenDayWKPattern from CalendarDay where CalendarIdCode = DayCalendar and CalendarDate = ShiftCalendarDate) as Pattern from
                ShiftCalendar where EmployeeSysId = In_EmployeeSysId and ShiftCalendarDate between In_MedClaimCycleStart and In_MedClaimCycleEnd) as MyShiftPattern
          else
            //
            // Get Working Employee Prorated Days
            //
            select sum(WKCalenDayWKPattern) into In_EmpCalDays from CalendarDay where
              CalendarIdCode = (select CalendarId from EmpeeWkCalen where EmployeeSysId = In_EmployeeSysId) and
              CalendarDate between StartDate and EndDate;
            //
            // Get Cycle Employee Working Days
            //
            select sum(WKCalenDayWKPattern) into In_CycleCalDays from CalendarDay where
              CalendarIdCode = (select CalendarId from EmpeeWkCalen where EmployeeSysId = In_EmployeeSysId) and
              CalendarDate between In_MedClaimCycleStart and In_MedClaimCycleEnd
          end if;
          //
          // Compute Prorated Employee Limit Per Cycle = ProrateDays/TotalCycleDays * EmpLimitPerCycle
          //
          set EmpLimitPerCycle=(In_EmpCalDays/In_CycleCalDays)*EmpLimitPerCycle
        else
          if In_ProrateMethod = 'MedClaimProCalenDay' then
            //
            // For Prorate Method by Calendar Days :
            // Compute Prorated Employee Limit Per Cycle = ProrateDays/TotalCycleDays * EmpLimitPerCycle
            //
            set EmpLimitPerCycle=(cast(DateDiff(day,StartDate,EndDate)+1 as MONEY)/cast(DateDiff(day,In_MedClaimCycleStart,In_MedClaimCycleEnd)+1 as MONEY))*EmpLimitPerCycle
          end if
        end if
      end if
    end if
  end if;
  if EmpLimitPerCycle is null then
    set EmpLimitPerCycle=0
  end if;
  return EmpLimitPerCycle
end
;


