-- version 2
CREATE OR REPLACE VIEW TABLESIZES_2_VIEW AS
SELECT SEGMENT_NAME as "Table", SUM(EXTENTS) as "Extents", ((SUM(EXTENTS) - 1) * 1048576 + 65536)/1024/1024 as "Allocated size (MB)"
FROM DBA_SEGMENTS
WHERE OWNER = 'NEWSMAN'
AND SEGMENT_TYPE = 'TABLE'
GROUP BY SEGMENT_NAME;

-- We can not calculate free size in each table because after deletions we have fragmented data!