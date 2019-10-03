if(FGetDBCOuntry(*) != 'Singapore') then 
	delete from CustViewItem;
	delete from CustViewObjTbl;
	delete from CustViewObj;
end if;

commit work;