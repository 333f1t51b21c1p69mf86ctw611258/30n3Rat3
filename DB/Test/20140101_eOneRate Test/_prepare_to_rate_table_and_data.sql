/* Formatted on 23/04/2014 17:25:54 (QP5 v5.227.12220.39754) */
CREATE TABLE hot_rated_cdr_86
AS
   SELECT * FROM truongdh_hot_rated_cdr;

CREATE TABLE hot_rated_cdr_86_bak
AS
     SELECT *
       FROM hot_rated_cdr_86
   ORDER BY cdr_start_time;

DROP TABLE hot_rated_cdr_86;

CREATE TABLE hot_rated_cdr_86
AS
   SELECT * FROM hot_rated_cdr_86_bak;

UPDATE hot_rated_cdr_86
   SET a_number = '0084914251186';

UPDATE hot_rated_cdr_86
   SET b_number = '0084984251186';

UPDATE hot_rated_cdr_86
   SET b_number = NULL
 WHERE cdr_type = 7;

UPDATE hot_rated_cdr_86
   SET aut_final_id = 30225
 WHERE cdr_type = 1;


CREATE TABLE rated_cdr_86
AS
   SELECT * FROM truongdh_hot_rated_cdr;


SELECT *
  FROM pcat_filter.subscriber
 WHERE subscriber_id = 950284;

INSERT
  INTO PCAT_FILTER.SUBSCRIBER (SUBSCRIBER_ID, SUBSCRIBER_NO, RATING_TYPE_ID)
VALUES (950284, '0084914251186', 0);

UPDATE PCAT_FILTER.SUBSCRIBER
   SET subscriber_id = 950284
 WHERE subscriber_no = '0084914251186';

INSERT INTO PCAT_FILTER.ACCOUNT_VERSION (ACCOUNT_VERSION_ID,
                                         FROM_DATE,
                                         TO_DATE,
                                         SUBSCRIBER_ID,
                                         ACCOUNT_ID,
                                         MODIFIED_DATE,
                                         EFFECTIVE_DATE)
     VALUES (111,
             SYSDATE - 50,
             SYSDATE + 360,
             950284,
             1,
             SYSDATE - 50,
             SYSDATE - 50);

INSERT INTO PCAT_FILTER.SUBS_OFFER_MAP (SUBSCRIBER_ID,
                                        FROM_DATE,
                                        TO_DATE,
                                        PRODUCT_OFFER_ID,
                                        SUBS_OFFER_MAP_ID,
                                        MODIFIED_DATE)
     VALUES (950284,
             SYSDATE - 50,
             SYSDATE + 360,
             51004293,
             1,
             SYSDATE - 50);

INSERT INTO PCAT_FILTER.SUBS_OFFER_MAP (SUBSCRIBER_ID,
                                        FROM_DATE,
                                        TO_DATE,
                                        PRODUCT_OFFER_ID,
                                        SUBS_OFFER_MAP_ID,
                                        MODIFIED_DATE)
     VALUES (950284,
             SYSDATE - 50,
             SYSDATE + 360,
             51004321,
             1,
             SYSDATE - 50);


INSERT INTO PCAT_FILTER.SUBSCRIBER_VERSION (SUBSCRIBER_VERSION_ID,
                                            FROM_DATE,
                                            TO_DATE,
                                            SUBSCRIBER_ID,
                                            CUSTOMER_ID,
                                            MODIFIED_DATE,
                                            EFFECTIVE_DATE)
     VALUES (1,
             SYSDATE - 50,
             SYSDATE + 360,
             950284,
             1,
             SYSDATE - 50,
             SYSDATE + 360);


COMMIT;