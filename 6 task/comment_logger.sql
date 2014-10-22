CREATE OR REPLACE TRIGGER COMMENT_LOGGER
BEFORE INSERT ON COMMENTS FOR EACH ROW
DECLARE 
  var_description VARCHAR2(4000); 
BEGIN

  IF LENGTH(:NEW.TEXT) > 0 THEN
    var_description := '"TEXT" : "' || :NEW.TEXT || '"';
  END IF;
  
  IF :NEW.CREATION_DATE != NULL THEN
    IF NVL(LENGTH(var_description), 0) > 0 THEN
      var_description := var_description || ';';    
    END IF;
    var_description := '; "CREATION_DATE" : "' || :NEW.CREATION_DATE || '"';
  END IF;
  
  var_description := '; "NEWS_ID" : "' || :NEW.NEWS_NEWS_ID || '"';
  
  INSERT INTO LOGGING (INSERT_TIME, TABLE_NAME, TEXT)
  VALUES(SYSDATE, 'TAG', var_description);
END;