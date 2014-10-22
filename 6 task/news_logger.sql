CREATE OR REPLACE TRIGGER NEWS_LOGGER
BEFORE INSERT ON NEWS FOR EACH ROW
DECLARE 
  report VARCHAR2(4000); 
BEGIN

  report := '"TITLE" : "' || :NEW.TITLE || '"';
  
  IF NVL(LENGTH(:NEW.SHORT_TEXT), 0) > 0 THEN
    IF report IS NULL THEN
      report := report || '; ';
    END IF;
    report := report || '"SHORT_TEXT" : "' || :NEW.SHORT_TEXT || '"';
  END IF;
  
  IF NVL(LENGTH(:NEW.FULL_TEXT), 0) > 0 THEN
    IF report IS NULL THEN
      report := report || '; ';
    END IF;
    report := report || '"FULL_TEXT" : "' || :NEW.FULL_TEXT || '"';
  END IF;
  
  INSERT INTO LOGGING (INSERT_TIME, TABLE_NAME, TEXT)
  VALUES(SYSDATE, 'NEWS', report);
END;