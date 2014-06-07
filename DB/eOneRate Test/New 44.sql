/* Formatted on 29/05/2014 11:49:09 (QP5 v5.227.12220.39754) */
SELECT * FROM rated_cdr_dev;

SELECT * FROM hot_rated_cdr_dev;

SELECT COUNT (*) FROM VNP_DATA.HOT_RATED_CDR_DEV;

SELECT COUNT (*)
  FROM VNP_DATA.HOT_RATED_CDR_DEV
 WHERE     DATA_PART = 140512
       AND (   SUB_PART = 0
            OR SUB_PART = 1
            OR SUB_PART = 2
            OR SUB_PART = 3
            OR SUB_PART = 4
            OR SUB_PART = 5
            OR SUB_PART = 6
            OR SUB_PART = 7
            OR SUB_PART = 8
            OR SUB_PART = 9)
       AND RERATE_FLAG = 0;


SELECT IDS
  FROM (  SELECT ROWID IDS
            FROM VNP_DATA.HOT_RATED_CDR_DEV
           WHERE RERATE_FLAG = 0
        ORDER BY CDR_START_TIME)
 WHERE     DATA_PART = 140512
       AND (   SUB_PART = 0
            OR SUB_PART = 1
            OR SUB_PART = 2
            OR SUB_PART = 3
            OR SUB_PART = 4
            OR SUB_PART = 5
            OR SUB_PART = 6
            OR SUB_PART = 7
            OR SUB_PART = 8
            OR SUB_PART = 9)
       AND ROWNUM BETWEEN 1 AND 10000