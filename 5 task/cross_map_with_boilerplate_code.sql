COLUMN GROUP_A FORMAT A80
COLUMN GROUP_B FORMAT A80

WITH all_authors AS
(
SELECT ROWNUM r, AUTHOR_ID, AUTHOR_NAME 
  FROM (
    SELECT AUTHOR_ID, AUTHOR_NAME
    FROM AUTHOR
    ORDER BY SYS.DBMS_RANDOM.RANDOM
  )
)
SELECT left_col.AUTHOR_NAME as GROUP_A, right_col.AUTHOR_NAME as GROUP_B
FROM (
  SELECT ROWNUM r, AUTHOR_NAME
  FROM all_authors
  WHERE all_authors.r <=(
    SELECT MAX(bearing)
      FROM
      (
        SELECT all_authors.r as bearing
        FROM all_authors
        WHERE ROWNUM <= (SELECT COUNT(*)/2 FROM all_authors)
      )
  )
) left_col,
(
  SELECT ROWNUM r, AUTHOR_NAME
  FROM all_authors
  WHERE all_authors.r >(
    SELECT MAX(bearing)
      FROM
      (
        SELECT all_authors.r as bearing
        FROM all_authors
        WHERE ROWNUM <= (SELECT COUNT(*)/2 FROM all_authors)
      )
  )
) right_col
WHERE left_col.r = right_col.r;