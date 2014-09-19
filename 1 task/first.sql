COLUMN author_name FORMAT A50

SELECT AUTHOR.AUTHOR_NAME as author_name, news_count as "Number of news", newsId "News id"
FROM (

    SELECT COUNT(NEWS) as news_count, AUTHOR as author
    FROM NEWS_AUTHOR
    GROUP BY AUTHOR
  as newses,
  (
    SELECT NEWS as newsId
    FROM NEWS_AUTHOR
    JOIN NEWS ON NEWS_AUTHOR_ID = author
  ) average
)
JOIN AUTHOR ON author = AUTHOR.AUTHOR_ID;
