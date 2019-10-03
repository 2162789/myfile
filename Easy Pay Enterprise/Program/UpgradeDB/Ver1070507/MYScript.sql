if exists (select 1 from LicenseRecord where NumKey5 = 0) then
  update RptCompItemConfig join RptCompConfig on RptCompItemConfig.RptCompSysId = RptCompConfig.RptCompSysId
  set RptCompItemConfig.ItemValue = 0 where RptCompConfig.SysRptCompName = 'CalendarOption_RadioGroup';
end if;

commit work;