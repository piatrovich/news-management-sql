-- Set A - all athors
-- Set C = A \ B - half of the authors with random ordering
-- Set A \ C - second half of the authors. With random ordering too. 

COLUMN Player_1 FORMAT A75
COLUMN Playre_2 FORMAT A75

WITH left_col AS
(
  SELECT ROWNUM r, AUTHOR_ID, AUTHOR_NAME
  FROM AUTHOR
  WHERE ROWNUM <= (
    SELECT COUNT(*)/2 
    FROM AUTHOR
  )
  ORDER BY SYS.DBMS_RANDOM.RANDOM
)
SELECT group_a.AUTHOR_NAME as Player_1, group_b.AUTHOR_NAME as Player_2
FROM left_col group_a
JOIN 
(
  SELECT ROWNUM r, AUTHOR_ID, AUTHOR_NAME
  FROM AUTHOR
  WHERE AUTHOR_ID NOT IN (
    SELECT AUTHOR_ID 
    FROM left_col
  )
  ORDER BY SYS.DBMS_RANDOM.RANDOM
) group_b
ON group_a.r = group_b.r;
