CREATE OR REPLACE VIEW AUTHOR_WROTES_VIEW AS
SELECT publisher "Authors"
FROM (
  SELECT chars, publisher
  FROM(
    SELECT LENGTH(FULL_TEXT) as chars, AUTHOR.AUTHOR_NAME as publisher
    FROM NEWS
    JOIN NEWS_AUTHOR ON NEWS.NEWS_ID = NEWS_AUTHOR.NEWS
    JOIN AUTHOR ON NEWS_AUTHOR.AUTHOR = AUTHOR.AUTHOR_ID
  )
)
GROUP BY publisher HAVING SUM(chars) > 50 AND AVG(chars) > 100;

--------------------------------------------------

--SELECT LENGTH(FULL_TEXT) as chars, AUTHOR.AUTHOR_NAME as publisher
--    FROM NEWS
--    JOIN NEWS_AUTHOR ON NEWS.NEWS_ID = NEWS_AUTHOR.NEWS
--    JOIN AUTHOR ON NEWS_AUTHOR.AUTHOR = AUTHOR.AUTHOR_ID;