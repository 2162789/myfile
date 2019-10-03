/*==============================================================*/
/* Table: iContractProgression                                    */
/*==============================================================*/
if not exists(select * from sys.syscolumns where tname = 'iContractProgression' and cname = 'ContractCurrent') then
   alter table iContractProgression add ContractCurrent smallint;
end if;

commit work;