/* ASQLYEProcessA8A  */

if exists(select * from sys.sysprocedure where proc_name = 'ASQLYEProcessA8A') then
  drop procedure ASQLYEProcessA8A;
end if;

CREATE PROCEDURE "DBA"."ASQLYEProcessA8A"(
in In_PersonalSysID integer,
in In_YEYear integer,
in In_Operation char(20),
in In_OtherBenefits double,
in In_ProcessIR21 char(1))
begin
  declare In_OccupationFrom date;
  declare In_OccupationTo date;
  declare In_OccupationDays integer;
  declare In_ResidenceAddress1 char(30);
  declare In_ResidenceAddress2 char(30);
  declare In_ResidenceAddress3 char(30);
  declare In_TotalBenefitInKind double;
  declare In_Section2Total double;
  declare In_Section3Total double;
  declare In_Section4Total double;
  declare In_ResidenceValue double;
  declare In_NoOfEESharingQtr double;
  declare In_IncidentalBenefits double;
  declare In_OHQStatus char(1);
  declare DayInYear double;
  declare In_TotalSectionDE double;
  /*
  To default the Occupation Dates and residence Address
  */
  if(In_Operation = 'Create') then
    set In_ResidenceAddress1='';
    set In_ResidenceAddress2='';
    set In_ResidenceAddress3='';
    select 0 into In_OccupationDays
  else
    select OccupationFrom,OccupationTo,OccupationDays into In_OccupationFrom,In_OccupationTo,In_OccupationDays from A8A where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear;
    if(In_OccupationFrom = '1899-12-30' or In_OccupationTo = '1899-12-30') then
      set In_OccupationDays=0
    end if
  end if;
  if(In_Operation = 'Create') then
    call InsertNewA8A(In_PersonalSysId,
    In_YEYear,'',
    /*In_FormHeaderMsg*/
    0, /*In_ResidenceValue*/
    In_ResidenceAddress1,
    In_ResidenceAddress2,
    In_ResidenceAddress3,
    0, /*In_ERPaidRent*/
    0, /*In_EEPaidRent*/
    In_OccupationFrom,
    In_OccupationTo,
    In_OccupationDays,
    0, /*In_Section2Total*/
    0, /*In_Section3Total*/
    0, /*In_Section4Total*/
    0, /*In_IncidentalBenefits*/
    0, /*In_PassagesSelf*/
    0, /*In_PassagesWife*/
    0, /*In_PassagesChildren*/
    0, /*In_InterestLoan*/
    0, /*In_LifeInsurance*/
    0, /*In_Holidays*/
    0, /*In_Education*/
    0, /*In_LongService*/
    0, /*In_Clubs*/
    0, /*In_Assets*/
    0, /*In_MotorVehicle*/
    0, /*In_CarBenefit*/
    In_OtherBenefits,'','','','',
    /*In_OtherBenefitsDetails*/
    /*In_OHQStatus*/
    /*In_OHQDetails*/
    /*In_Additional*/
    0, /*In_TotalBenefitInKind*/
    1); /*NoOfEESharingQtr*/
    /*
    To create A8A section 2 Items
    */
    if(In_ProcessIR21 = 'N') then
      call ASQLYECreateA8A_S2S3(In_PersonalSysID,In_YEYear)
    else
      call ASQLYECreateIR21A1_S2S3(In_PersonalSysID,In_YEYear);
      if In_YEYear >2013 then
	    call InsertNewIR21A1S4S5(In_PersonalSysID,In_YEYear,'','1899-12-30','1899-12-30',0,0,'',0,0,0,'','1899-12-30','1899-12-30',0,0,'',0,0,0,0,0,0,0,0,0,0,0);
      end if;
    end if
  else
    update A8A set
      OccupationDays = In_OccupationDays where
      PersonalSysId = In_PersonalSysId and
      YEYear = In_YEYear;
    /*
    For Re-Reprocess Only
    */
    if(In_Operation = 'Reprocess') then
      /*
      No Of EE Sharing Quarter
      */
      select NoOfEESharingQtr into In_NoOfEESharingQtr
        from A8A where
        PersonalSysId = In_PersonalSysId and
        YEYear = In_YEYear;
      if(In_NoOfEESharingQtr < 0) then
        set In_NoOfEESharingQtr=0
      end if;
      if(In_ProcessIR21 = 'N') then
        call ASQLYEReprocessA8A_S2S3(In_PersonalSysID,In_YEYear,In_NoOfEESharingQtr)
      else
        call ASQLYEReprocessIR21A1_S2S3(In_PersonalSysID,In_YEYear,In_NoOfEESharingQtr)
      end if;
      /*
      Update the OtherBenefits value if reprocess
      */
      update A8A set
        OtherBenefits = In_OtherBenefits where
        PersonalSysId = In_PersonalSysId and
        YEYear = In_YEYear;
      commit work
    end if
  end if;
  /*
  Compute Total for Section 2, 3 and 4
  */
  select sum(Sec2Value) into In_Section2Total from A8AS2 where Sec2Selection = 1 and
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  if(In_Section2Total is null) then
    set In_Section2Total=0
  end if;
  select sum(Sec3Value) into In_Section3Total from A8AS3 where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  if(In_Section3Total is null) then
    set In_Section3Total=0
  end if;
  select Round(IncidentalBenefits+
    InterestLoan+
    LifeInsurance+
    Holidays+
    Education+
    LongService+
    Clubs+
    Assets+
    MotorVehicle+
    CarBenefit+
    OtherBenefits,2) into In_Section4Total from A8A where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  if(In_Section4Total is null) then
    set In_Section4Total=0
  end if;
  
  /*
    Compute Total Value of Section D & E for IR21 Appendix 1 Only In_TotalSectionDE
  */
  if(In_ProcessIR21 = 'N' and In_YEYear >2013) then
     select Round(TotalValueofAccommodation+
	    TotalValueofUtilities+
		TotalHotelAccommodation,2) into In_TotalSectionDE from IR21A1S4S5 where
        PersonalSysId = In_PersonalSysId and
        YEYear = In_YEYear;
	if(In_TotalSectionDE is null) then
       set In_TotalSectionDE=0
    end if;
  else
     set In_TotalSectionDE = 0;     
  end if;
  
  /*
  Compute A8A Total Benefits in Kind
  */
  select ResidenceValue,IncidentalBenefits,OHQStatus into In_ResidenceValue,In_IncidentalBenefits,In_OHQStatus from A8A where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  /*
  Default OHQ Status to No if NA when Incidental Benefits is not zero
  */
  if(In_IncidentalBenefits <> 0 and In_OHQStatus = '') then
    set In_OHQStatus='N'
  end if;

  /*
  Update Total
  */
  set In_TotalBenefitInKind=In_ResidenceValue+
    In_Section2Total+In_Section3Total+In_Section4Total+In_TotalSectionDE;
  update A8A set
    OHQStatus = In_OHQStatus,
    TotalBenefitInKind = In_TotalBenefitInKind,
    Section2Total = In_Section2Total,
    Section3Total = In_Section3Total,
    Section4Total = In_Section4Total where
    PersonalSysId = In_PersonalSysId and
    YEYear = In_YEYear;
  commit work;
end;

/* InsertNewIR21A1S4S5 */


if exists(select * from sys.sysprocedure where proc_name = 'InsertNewIR21A1S4S5') then
  drop procedure InsertNewIR21A1S4S5;
end if;

CREATE PROCEDURE "DBA"."InsertNewIR21A1S4S5"(  
In In_PersonalSysId integer,
In In_YEYear integer,
In In_ResidenceAddress1 char(100), 
In In_Address1OccupationFrom date, 
In In_Address1OccupationTo date, 
In In_Address1OccupationDays integer, 
In In_Address1AnnualValue double, 
In In_Address1FurnishedStatus char(20), 
In In_Address1FurnitureFittingsValue double, 
In In_Address1PaidByEmployer double, 
In In_Address1ResidenceValue double, 
In In_ResidenceAddress2 char(100), 
In In_Address2OccupationFrom date, 
In In_Address2OccupationTo date, 
In In_Address2OccupationDays integer, 
In In_Address2AnnualValue double, 
In In_Address2FurnishedStatus char(20), 
In In_Address2FurnitureFittingsValue double, 
In In_Address2PaidByEmployer double, 
In In_Address2ResidenceValue double, 
In In_Address12PaidByEmployee double, 
In In_PUBTelPagerValue double, 
In In_Driver double, 
In In_ServantGardener double, 
In In_HotelAccommodation double, 
In In_TotalValueofAccommodation double, 
In In_TotalHotelAccommodation double, 
In In_TotalValueofUtilities double 
)
BEGIN
  if not exists(select* from IR21A1S4S5 where
      IR21A1S4S5.PersonalSysId = In_PersonalSysId and
      IR21A1S4S5.YEYear = In_YEYear) then
    insert into IR21A1S4S5(PersonalSysId,
      YEYear,
      ResidenceAddress1,
      Address1OccupationFrom, 
      Address1OccupationTo, 
      Address1OccupationDays, 
      Address1AnnualValue, 
      Address1FurnishedStatus, 
      Address1FurnitureFittingsValue, 
      Address1PaidByEmployer, 
      Address1ResidenceValue, 
      ResidenceAddress2, 
      Address2OccupationFrom, 
      Address2OccupationTo, 
      Address2OccupationDays , 
      Address2AnnualValue, 
      Address2FurnishedStatus,  
      Address2FurnitureFittingsValue, 
      Address2PaidByEmployer, 
      Address2ResidenceValue, 
      Address12PaidByEmployee, 
      PUBTelPagerValue, 
      Driver, 
      ServantGardener, 
      HotelAccommodation, 
      TotalValueofAccommodation, 
      TotalHotelAccommodation, 
      TotalValueofUtilities  ) values(
      In_PersonalSysId,
      In_YEYear,
      In_ResidenceAddress1, 
      In_Address1OccupationFrom, 
      In_Address1OccupationTo, 
      In_Address1OccupationDays, 
      In_Address1AnnualValue, 
      In_Address1FurnishedStatus, 
      In_Address1FurnitureFittingsValue, 
      In_Address1PaidByEmployer, 
      In_Address1ResidenceValue, 
      In_ResidenceAddress2, 
      In_Address2OccupationFrom, 
      In_Address2OccupationTo, 
      In_Address2OccupationDays, 
      In_Address2AnnualValue, 
      In_Address2FurnishedStatus, 
      In_Address2FurnitureFittingsValue, 
      In_Address2PaidByEmployer, 
      In_Address2ResidenceValue, 
      In_Address12PaidByEmployee, 
      In_PUBTelPagerValue, 
      In_Driver, 
      In_ServantGardener, 
      In_HotelAccommodation, 
      In_TotalValueofAccommodation, 
      In_TotalHotelAccommodation, 
      In_TotalValueofUtilities);
    commit work;
  end if;
END;

/* UpdateIR21A1S4S5 */

if exists(select * from sys.sysprocedure where proc_name = 'UpdateIR21A1S4S5') then
  drop procedure UpdateIR21A1S4S5;
end if;

CREATE PROCEDURE "DBA"."UpdateIR21A1S4S5"(
In In_PersonalSysId integer,
In In_YEYear integer,
In In_ResidenceAddress1 char(100), 
In In_Address1OccupationFrom date, 
In In_Address1OccupationTo date, 
In In_Address1OccupationDays integer, 
In In_Address1AnnualValue double, 
In In_Address1FurnishedStatus char(20), 
In In_Address1FurnitureFittingsValue double, 
In In_Address1PaidByEmployer double, 
In In_Address1ResidenceValue double, 
In In_ResidenceAddress2 char(100), 
In In_Address2OccupationFrom date, 
In In_Address2OccupationTo date, 
In In_Address2OccupationDays integer, 
In In_Address2AnnualValue double, 
In In_Address2FurnishedStatus char(20), 
In In_Address2FurnitureFittingsValue double, 
In In_Address2PaidByEmployer double, 
In In_Address2ResidenceValue double, 
In In_Address12PaidByEmployee double, 
In In_PUBTelPagerValue double, 
In In_Driver double, 
In In_ServantGardener double, 
In In_HotelAccommodation double, 
In In_TotalValueofAccommodation double, 
In In_TotalHotelAccommodation double, 
In In_TotalValueofUtilities double,
OUT Out_ErrorCode integer)
BEGIN
      if exists(select * from IR21A1S4S5 Where PersonalSysId = In_PersonalSysId And YEYear = In_YEYear) Then
	    Update IR21A1S4S5 Set
         ResidenceAddress1 =  In_ResidenceAddress1, 
         Address1OccupationFrom = In_Address1OccupationFrom, 
         Address1OccupationTo = In_Address1OccupationTo,  
         Address1OccupationDays = In_Address1OccupationDays,  
         Address1AnnualValue = In_Address1AnnualValue,  
         Address1FurnishedStatus = In_Address1FurnishedStatus, 
         Address1FurnitureFittingsValue = In_Address1FurnitureFittingsValue, 
         Address1PaidByEmployer = In_Address1PaidByEmployer, 
         Address1ResidenceValue = In_Address1ResidenceValue, 
         ResidenceAddress2 = In_ResidenceAddress2, 
         Address2OccupationFrom = In_Address2OccupationFrom, 
         Address2OccupationTo = In_Address2OccupationTo,  
         Address2OccupationDays = In_Address2OccupationDays,  
         Address2AnnualValue = In_Address2AnnualValue, 
         Address2FurnishedStatus = In_Address2FurnishedStatus, 
         Address2FurnitureFittingsValue = In_Address2FurnitureFittingsValue, 
         Address2PaidByEmployer = In_Address2PaidByEmployer,  
         Address2ResidenceValue = In_Address2ResidenceValue, 
         Address12PaidByEmployee = In_Address12PaidByEmployee, 
         PUBTelPagerValue = In_PUBTelPagerValue,  
         Driver = In_Driver, 
         ServantGardener = In_ServantGardener, 
         HotelAccommodation = In_HotelAccommodation,  
         TotalValueofAccommodation = In_TotalValueofAccommodation, 
         TotalHotelAccommodation = In_TotalHotelAccommodation,  
         TotalValueofUtilities = In_TotalValueofUtilities 
         Where PersonalSysId = In_PersonalSysId And YEYear = In_YEYear;
         commit work;
         set Out_ErrorCode=1;
         update A8A set LastChangedDateTime = now(*) where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear;
      else
         set Out_ErrorCode=0;
      end if;
END;

/* DeleteIR21A1S4S5 */


if exists(select * from sys.sysprocedure where proc_name = 'DeleteIR21A1S4S5') then
  drop procedure DeleteIR21A1S4S5;
end if;

CREATE PROCEDURE "DBA"."DeleteIR21A1S4S5"(
In In_PersonalSysId integer,
In In_YEYear integer,
OUT Out_ErrorCode integer
)
BEGIN
	if exists(select * from IR21A1S4S5 where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear) then
       delete from IR21A1S4S5 where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear; 
	   if exists(select * from IR21A1S4S5 where PersonalSysId = In_PersonalSysId and YEYear = In_YEYear) then
         set Out_ErrorCode = 0;
       else
         set Out_ErrorCode =1;
       end if;
     else
         set Out_ErrorCode = 0;
     end if;
END;


/* DeleteA8A */

if exists(select * from sys.sysprocedure where proc_name = 'DeleteA8A') then
  drop procedure DeleteA8A;
end if;

CREATE PROCEDURE "DBA"."DeleteA8A"(
in In_PersonalSysId integer,
in In_YEYear integer)
begin
  if exists(select* from A8A where
      A8A.PersonalSysId = In_PersonalSysId and
      A8A.YEYear = In_YEYear) then
    delete from A8AS2 where
      A8AS2.PersonalSysId = In_PersonalSysId and
      A8AS2.YEYear = In_YEYear;
    delete from A8AS3 where
      A8AS3.PersonalSysId = In_PersonalSysId and
      A8AS3.YEYear = In_YEYear;
    delete from IR21A1S4S5 where
      IR21A1S4S5.PersonalSysId = In_PersonalSysId and
      IR21A1S4S5.YEYear = In_YEYear;      
    delete from A8A where
      A8A.PersonalSysId = In_PersonalSysId and
      A8A.YEYear = In_YEYear;
    commit work;
  end if;
end;

commit work;