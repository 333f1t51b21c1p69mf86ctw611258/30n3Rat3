DROP VIEW PRODUCT_SELECT;

/* Formatted on 12/20/2014 2:52:21 AM (QP5 v5.215.12089.38647) */
CREATE OR REPLACE FORCE VIEW PRODUCT_SELECT
(
   ACCOUNT_VERSION_ID,
   ID,
   OFFER_ID,
   OFFER_NAME,
   SUBSCRIBER_NO,
   DATA_PART,
   RESELLER_VERSION_ID,
   FROM_DATE_TEST,
   FROM_DATE,
   TO_DATE_TEST,
   TO_DATE,
   MODIFIED_DATE_TEST,
   MODIFIED_DATE,
   OFFER_TYPE
)
AS
     SELECT ACCOUNT_VERSION_ID,
            SUBS_OFFER_MAP_ID AS ID,            -- PROD_VIEW_ID_NEXTVAL AS ID,
            PRODUCT_OFFER.OFFER_ID,
            PRODUCT_OFFER.OFFER_NAME,
            SUBSCRIBER_NO,
            SUBSCRIBER.DATA_PART,
            RESELLER_VERSION_ID,                                -- SERVICE_ID,
            SUBS_OFFER_MAP.FROM_DATE AS FROM_DATE_TEST,
              (SUBS_OFFER_MAP.FROM_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
            * 24
            * 60
            * 60
               AS FROM_DATE,
            NVL (SUBS_OFFER_MAP.TO_DATE, TO_DATE ('2030-01-01', 'yyyy-mm-dd'))
               AS TO_DATE_TEST,
              (  NVL (SUBS_OFFER_MAP.TO_DATE,
                      TO_DATE ('2030-01-01', 'yyyy-mm-dd'))
               - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
            * 24
            * 60
            * 60
               AS TO_DATE,
            --         SUBS_OFFER_MAP.TO_DATE AS TO_DATE_TEST,
            --           (SUBS_OFFER_MAP.TO_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
            --         * 24
            --         * 60
            --         * 60
            --            AS TO_DATE,

            SUBS_OFFER_MAP.MODIFIED_DATE AS MODIFIED_DATE_TEST,
              (  SUBS_OFFER_MAP.MODIFIED_DATE
               - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
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
   ORDER BY DECODE (PRODUCT_OFFER.OFFER_TYPE,  'PO', 1,  'SO', 2,  3)
--          INNER JOIN
--          PRODUCT_OFFER
--             ON (PRODUCT_OFFER.PRODUCT_OFFER_ID =
--                    PRODUCT_OFFER_VERSION.PRODUCT_OFFER_ID)
--          INNER JOIN
--          PO_SERVICE_MAP
--             ON (PRODUCT_OFFER.PRODUCT_OFFER_ID =
--                    PO_SERVICE_MAP.PRODUCT_OFFER_ID)
;
