if exists(select 1 from sys.sysprocedure where proc_name = 'DeleteIR8SC') then
   drop procedure DeleteIR8SC
end if
;

CREATE PROCEDURE "DBA"."DeleteIR8SC"(
in In_PersonalSysId integer,
in In_Year integer,
in In_RefundSysId integer)
begin
  if exists(select* from IR8SC where
      IR8SC.PersonalSysId = In_PersonalSysId and
      IR8SC.YEYear = In_Year and
      IR8SC.RefundSysId = In_RefundSysId) then
    delete from IR8SC where
      IR8SC.PersonalSysId = In_PersonalSysId and
      IR8SC.YEYear = In_Year and
      IR8SC.RefundSysId = In_RefundSysId;

    begin
        declare cnt integer;
        set cnt = 1;
        ResetIR8SCLoop: for ResetIR8SC as curs dynamic scroll cursor for
            select RefundSysId as tmp_RefundSysId from IR8SC where
              YEYear = In_Year and PersonalSysId = In_PersonalSysId order by
              PersonalSysId asc,RefundSysId asc do
                update IR8SC set RefundSysId = cnt where 
                    YEYear = In_Year and 
                    PersonalSysId = In_PersonalSysId and
                    RefundSysId = tmp_RefundSysId;
                set cnt = cnt + 1;
        end for;
    end;

    commit work
  end if
end
;

commit work;