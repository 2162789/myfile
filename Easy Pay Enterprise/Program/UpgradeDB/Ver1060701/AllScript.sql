if exists(select * from sys.sysprocedure where proc_name = 'DeleteApplicant') then
   drop procedure DeleteApplicant
end if;

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
    
    delete from ApplicantAttach where
     ApplicantAttach.ApplicantSysId = In_ApplicantSysId;
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

commit work;

