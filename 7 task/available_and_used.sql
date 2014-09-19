SELECT TABLESPACE_NAME "Tablespace", total "Used megabytes", available - total "Available meagabytes", total * 100 / available "Used %" 
FROM (
  SELECT TABLESPACE_NAME, SUM(BYTES) / 1024 / 1024 as total, SUM(MAXBYTES) / 1024 / 1024 as available
  FROM DBA_DATA_FILES
  GROUP BY TABLESPACE_NAME
);
