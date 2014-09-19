COLUMN TAGS_COLUMN FORMAT A100

SELECT newsId as "News id", LENGTH(tags) as "Tags length", tags as TAGS_COLUMN, TITLE "News title"
FROM(
  SELECT NEWS as newsId, TO_CLOB(RTRIM(XMLAGG(XMLELEMENT(col, CONCAT(TAG.TAG_NAME, ','))).extract('/COL/text()'))) as tags
  FROM NEWS_TAG
  JOIN TAG ON NEWS_TAG.TAG = TAG.TAG_ID
  GROUP BY NEWS
  )
JOIN NEWS ON newsId = NEWS_ID 
ORDER BY newsId;

--------------------------------------------------
-- Solution with limitations
--COLUMN tags FORMAT A120

--SELECT NEWS_ID "Id", LISTAGG(TAG.TAG_NAME, ',') WITHIN GROUP (ORDER BY NEWS.NEWS_ID) as tags
--FROM NEWS
--JOIN NEWS_TAG ON NEWS.NEWS_ID = NEWS_TAG.NEWS
--JOIN TAG ON NEWS_TAG.TAG = TAG.TAG_ID
--GROUP BY NEWS_ID;
