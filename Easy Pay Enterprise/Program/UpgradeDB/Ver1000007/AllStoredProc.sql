if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTrainingUpdateClaimAmount') then
   drop procedure ASQLTrainingUpdateClaimAmount
end if
;

CREATE PROCEDURE "DBA"."ASQLTrainingUpdateClaimAmount"(in In_TrainingBatchId char(20))
begin
  /*
  Get list of Batch Training Cost Record
  */
  TrainCostLoop: for TrainCostFor as TrainCostCur dynamic scroll cursor for
    select Training.TrainingSysId as Out_TrainingSysId,Sum(TrainAmount) as Out_ClaimAmount from
      Training left outer join TrainCostRec where
      TrainingBatchID = In_TrainingBatchId and
      TrainForClaim = 1
      group by Training.TrainingSysId do
    update Training set ClaimAmount = Out_ClaimAmount where TrainingSysId = Out_TrainingSysId;
    commit work end for
end
;

if exists(select 1 from sys.sysprocedure where proc_name = 'ASQLTrainingUpdateCost') then
   drop procedure ASQLTrainingUpdateCost
end if
;

CREATE PROCEDURE "DBA"."ASQLTrainingUpdateCost"(
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
      set Chk_TrainCostTypeId='';
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