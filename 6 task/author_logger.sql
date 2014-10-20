CREATE OR REPLACE TRIGGER AUTHOR_LOGGER
BEFORE INSERT ON AUTHOR FOR EACH ROW
DECLARE 
  var_description VARCHAR2(4000); 
BEGIN
  var_description := '"AUTHOR_NAME" : "' || :NEW.AUTHOR_NAME || '"';
  INSERT INTO LOGGING (INSERT_TIME, TABLE_NAME, TEXT)
  VALUES(SYSDATE, 'AUTHOR', var_description);
END;