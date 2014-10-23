-- Testing tag logger
INSERT INTO TAG (TAG_NAME) 
VALUES ('John Galt');

-- Testing tag logger
INSERT INTO AUTHOR (AUTHOR_NAME) 
VALUES ('Oliver Gierke');

-- Testing comment logger
INSERT INTO COMMENTS (TEXT, CREATION_DATE, NEWS_NEWS_ID) 
VALUES ('Who is John Galt?', SYSDATE, 390);

-- Testing news logger
INSERT INTO NEWS (FULL_TEXT, CREATION_DATE, TITLE) 
VALUES ('Full news text', SYSDATE, 'News title');

INSERT INTO NEWS (SHORT_TEXT, FULL_TEXT, CREATION_DATE, MODIFICATION_DATE, TITLE) 
VALUES ('', 'Full news text 2', SYSDATE, SYSDATE, 'News title 2');

INSERT INTO NEWS (SHORT_TEXT, FULL_TEXT, CREATION_DATE, TITLE) 
VALUES ('Short news text', 'Full news text 3', SYSDATE, 'News title 3');