CREATE OR REPLACE TRIGGER TAG_LOGGER
BEFORE INSERT ON TAG FOR EACH ROW
DECLARE 
  var_description VARCHAR2(4000); 
BEGIN
  var_description := '"TAG_NAME" : "' || :NEW.TAG_NAME || '"';
  INSERT INTO LOGGING (INSERT_TIME, TABLE_NAME, TEXT)
  VALUES(SYSDATE, 'TAG', var_description);
END;