IF NOT EXISTS(SELECT * FROM SubRegistry WHERE RegistryId = 'EmpeeOtherInfo' AND SubRegistryId = 'INB2MPFEELSPSP') THEN 
   INSERT INTO SubRegistry VALUES ('EmpeeOtherInfo','INB2MPFEELSPSP','INB2 MPF Employee entitlement LSP/SP','Numeric','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00')
END IF;
   
IF NOT EXISTS(SELECT * FROM SubRegistry WHERE RegistryId = 'EmpeeOtherInfo' AND SubRegistryId = 'INB2MPFERLSPSP') THEN 
   INSERT INTO SubRegistry VALUES ('EmpeeOtherInfo','INB2MPFERLSPSP','INB2 MPF LSP/SP paid or to be paid to employee by employer','Numeric','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00')
END IF;
   
IF NOT EXISTS(SELECT * FROM SubRegistry WHERE RegistryId = 'EmpeeOtherInfo' AND SubRegistryId = 'INB2MPFLSPSP') THEN 
   INSERT INTO SubRegistry VALUES ('EmpeeOtherInfo','INB2MPFLSPSP','INB2 MPF LSP/SP type','String','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00')
END IF;
   
IF NOT EXISTS(SELECT * FROM SubRegistry WHERE RegistryId = 'EmpeeOtherInfo' AND SubRegistryId = 'INB2MPFMemberType') THEN 
   INSERT INTO SubRegistry VALUES ('EmpeeOtherInfo','INB2MPFMemberType','INB2 MPF Member Type','String','','','','','','','','',0,0,'',0,'','','1899-12-30','1899-12-30 00:00:00')
END IF;

COMMIT WORK;