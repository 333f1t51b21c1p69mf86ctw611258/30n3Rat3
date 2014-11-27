/* Formatted on 26/11/2014 3:14:20 PM (QP5 v5.215.12089.38647) */
SELECT *
  FROM subscriber
 WHERE subscriber_no = '841247494428';

SELECT *
  FROM subscriber
 WHERE subscriber_no = '84914251186';

UPDATE vnp_data.hot_rated_cdr_dev
   SET a_number = '84914251186'
 WHERE a_number = '841247494428';

-- subscriber_id = 1923404

SELECT som.*, po.*
  FROM subs_offer_map som, product_offer po
 WHERE subscriber_id = 1923430 AND SOM.PRODUCT_OFFER_ID = PO.OFFER_ID;


SELECT *
  FROM product_offer
 WHERE offer_name = 'PO_Mobile_Postpaid_Standard';

-- offer_id  = 51004284

SELECT *
  FROM product_offer
 WHERE offer_name = 'SO_Mobile_Postpaid_Alo1 - 2500 phut_26';

-- offer_id = 51004657

SELECT *
  FROM product_offer
 WHERE offer_name = 'SO_Mobile_Postpaid_Goi phu 300SMS noi mang_450';

-- offer_id = 51004508

-- alias

SELECT ACCOUNT_VERSION_ID,
       SUBSCRIBER_NO AS ALIAS,
       ACCOUNT_ID,
       SUBSCRIBER_NO SUBSCRIBER_NO,
       ACCOUNT_VERSION.FROM_DATE AS FROM_DATE_TEST,
         (ACCOUNT_VERSION.FROM_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
       * 24
       * 60
       * 60
          AS FROM_DATE,
       ACCOUNT_VERSION.TO_DATE AS TO_DATE_TEST,
         (ACCOUNT_VERSION.TO_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
       * 24
       * 60
       * 60
          AS TO_DATE,
       ACCOUNT_VERSION.MODIFIED_DATE AS MODIFIED_DATE_TEST,
         (  ACCOUNT_VERSION.MODIFIED_DATE
          - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
       * 24
       * 60
       * 60
          AS MODIFIED_DATE
  FROM    SUBSCRIBER
       INNER JOIN
          ACCOUNT_VERSION
       ON (SUBSCRIBER.SUBSCRIBER_ID = ACCOUNT_VERSION.SUBSCRIBER_ID)
 WHERE subscriber_no = 84914251186;


-- AuditSegment

SELECT ACCOUNT_VERSION_ID,
       ACCOUNT_ID,
       NULL MSN,
       ACCOUNT_VERSION.EFFECTIVE_DATE AS EFFECTIVE_DATE_TEST,
         (  ACCOUNT_VERSION.EFFECTIVE_DATE
          - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
       * 24
       * 60
       * 60
          AS EFFECTIVE_DATE,
       ACCOUNT_VERSION.FROM_DATE AS FROM_DATE_TEST,
         (ACCOUNT_VERSION.FROM_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
       * 24
       * 60
       * 60
          AS FROM_DATE,
       ACCOUNT_VERSION.TO_DATE AS TO_DATE_TEST,
         (ACCOUNT_VERSION.TO_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
       * 24
       * 60
       * 60
          AS TO_DATE,
       ACCOUNT_VERSION.MODIFIED_DATE AS MODIFIED_DATE_TEST,
         (  ACCOUNT_VERSION.MODIFIED_DATE
          - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
       * 24
       * 60
       * 60
          AS MODIFIED_DATE
  FROM ACCOUNT_VERSION
 WHERE account_version_id = 1940723;

-- product

  SELECT ACCOUNT_VERSION_ID,
         SUBS_OFFER_MAP_ID AS ID,               -- PROD_VIEW_ID_NEXTVAL AS ID,
         PRODUCT_OFFER.OFFER_ID,
         PRODUCT_OFFER.OFFER_NAME,
         SUBSCRIBER_NO,
         RESELLER_VERSION_ID,                                   -- SERVICE_ID,
         SUBS_OFFER_MAP.FROM_DATE AS FROM_DATE_TEST,
           (SUBS_OFFER_MAP.FROM_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
         * 24
         * 60
         * 60
            AS FROM_DATE,
         SUBS_OFFER_MAP.TO_DATE AS TO_DATE_TEST,
           (SUBS_OFFER_MAP.TO_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
         * 24
         * 60
         * 60
            AS TO_DATE,
         SUBS_OFFER_MAP.MODIFIED_DATE AS MODIFIED_DATE_TEST,
           (SUBS_OFFER_MAP.MODIFIED_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
         * 24
         * 60
         * 60
            AS MODIFIED_DATE,
         PRODUCT_OFFER.OFFER_TYPE
    FROM SUBSCRIBER
         INNER JOIN SUBS_OFFER_MAP
            ON (SUBSCRIBER.SUBSCRIBER_ID = SUBS_OFFER_MAP.SUBSCRIBER_ID)
         INNER JOIN ACCOUNT_VERSION
            ON (SUBSCRIBER.SUBSCRIBER_ID = ACCOUNT_VERSION.SUBSCRIBER_ID)
         INNER JOIN PRODUCT_OFFER
            ON (PRODUCT_OFFER.OFFER_ID = SUBS_OFFER_MAP.PRODUCT_OFFER_ID)
   WHERE account_version_id = 1940723
ORDER BY DECODE (PRODUCT_OFFER.OFFER_TYPE,  'PO', 1,  'SO', 2,  3);

SELECT SYSDATE FROM DUAL;