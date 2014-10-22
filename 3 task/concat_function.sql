CREATE OR REPLACE FUNCTION CONCAT_TAGS 
(
  NEWS_ID IN NUMBER, 
  SEPARATOR IN VARCHAR2 DEFAULT ';' 
) RETURN VARCHAR2 IS tags VARCHAR2(4000 CHAR);
BEGIN
   FOR tag_set IN (
      SELECT TAG.TAG_NAME as tag
      FROM NEWS_TAG
      JOIN TAG ON NEWS_TAG.TAG = TAG.TAG_ID
      WHERE NEWS_TAG.NEWS = NEWS_ID
   )
      LOOP 
          IF NVL(LENGTH(tags), 0) + LENGTH(tag_set.tag) + LENGTH(SEPARATOR) + 3 <= 50
          THEN
            tags := tags || tag_set.tag || SEPARATOR;
          ELSE
            tags := tags || '...';
            RETURN tags;
          END IF;
      END LOOP; 
  RETURN tags;
END CONCAT_TAGS;