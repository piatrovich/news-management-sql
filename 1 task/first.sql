CREATE OR REPLACE VIEW NEWS_VIEW AS
SELECT author_name as "Author name", news_count as "Number of news", average_comments as "Average number of comments", TAG_NAME as "Most popular tag"
FROM
(
  (
    (
      (
        SELECT AUTHOR as author_id, COUNT(NEWS) as news_count
        FROM NEWS_AUTHOR
        GROUP BY AUTHOR
      )
      JOIN
      (
        SELECT AUTHOR_NAME as author_name, AUTHOR, AVG(comments_count) AS average_comments
        FROM
        (
          SELECT AUTHOR_NAME, AUTHOR, COUNT(comments.NEWS_NEWS_ID) AS comments_count
          FROM NEWS_AUTHOR
          JOIN COMMENTS ON NEWS_AUTHOR.NEWS = COMMENTS.NEWS_NEWS_ID
          JOIN AUTHOR ON NEWS_AUTHOR.AUTHOR = AUTHOR.AUTHOR_ID
          GROUP BY AUTHOR, NEWS_AUTHOR.NEWS, AUTHOR_NAME
        )
        GROUP BY AUTHOR, AUTHOR_NAME
      ) ON AUTHOR = author_id
    )
    JOIN
    (
    SELECT DISTINCT AUTHOR AS tag_author, FIRST_VALUE(tag_id) OVER(PARTITION BY Author) tag_id
    FROM
    (
      SELECT AUTHOR, TAG as tag_id, COUNT(TAG) AS tag_count
      FROM NEWS_AUTHOR                           
      JOIN NEWS_TAG
      ON NEWS_AUTHOR.NEWS = NEWS_TAG.NEWS
      GROUP BY TAG, author
      ORDER BY NEWS_AUTHOR.AUTHOR, tag_count DESC
    )
    ORDER BY tag_author
    ) ON author_id = tag_author
  )
  JOIN
  (
    SELECT TAG_NAME, TAG_ID as id_tag
    FROM TAG
  ) ON tag_id = id_tag
);