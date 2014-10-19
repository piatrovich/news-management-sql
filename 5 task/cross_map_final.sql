CREATE OR REPLACE VIEW CROSS_MAP_VIEW AS
WITH all_authors AS
(
SELECT ROWNUM r, AUTHOR_ID, AUTHOR_NAME 
  FROM (
    SELECT AUTHOR_ID, AUTHOR_NAME
    FROM AUTHOR
    ORDER BY SYS.DBMS_RANDOM.RANDOM
  )
), bearing as (
  SELECT MAX(bearing_element)
      FROM
      (
        SELECT all_authors.r as bearing_element
        FROM all_authors
        WHERE ROWNUM <= (
          SELECT COUNT(*)/2 
          FROM all_authors
          )
      )
)
SELECT left_col.AUTHOR_NAME as GROUP_A, right_col.AUTHOR_NAME as GROUP_B
FROM (
  SELECT ROWNUM r, AUTHOR_NAME
  FROM all_authors
  WHERE all_authors.r <= (SELECT * FROM bearing)
) left_col,
(
  SELECT ROWNUM r, AUTHOR_NAME
  FROM all_authors
  WHERE all_authors.r > (SELECT * FROM bearing)
) right_col
WHERE left_col.r = right_col.r;