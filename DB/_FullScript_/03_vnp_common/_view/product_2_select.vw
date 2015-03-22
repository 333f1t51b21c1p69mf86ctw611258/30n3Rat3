DROP VIEW VNP_COMMON.PRODUCT_2_SELECT;

/* Formatted on 2/6/2015 9:56:55 AM (QP5 v5.269.14213.34746) */
CREATE OR REPLACE FORCE VIEW VNP_COMMON.PRODUCT_2_SELECT
(
   SUBSCRIBER_ID,
   SUBS_OFFER_MAP_ID,
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
     SELECT SUBSCRIBER.SUBSCRIBER_ID,
            SUBS_OFFER_MAP_ID,                  -- PROD_VIEW_ID_NEXTVAL AS ID,
            PRODUCT_OFFER.OFFER_ID,
            PRODUCT_OFFER.OFFER_NAME,
            SUBSCRIBER_NO,
            SUBSCRIBER.DATA_PART,
            RESELLER_VERSION_ID,                                -- SERVICE_ID,
            --         SUBS_OFFER_MAP.FROM_DATE AS FROM_DATE_TEST,
            CASE
               WHEN TO_NUMBER (TO_CHAR (SOM.FROM_DATE, 'DD')) < EED
               THEN
                  TRUNC (SOM.FROM_DATE, 'MM')
               WHEN     TO_NUMBER (TO_CHAR (SOM.FROM_DATE, 'DD')) >= EED
                    AND EED_TYPE = 1
               THEN
                  TO_DATE (EED || '/' || TO_CHAR (SOM.FROM_DATE, 'MM/YYYY'),
                           'DD/MM/YYYY')
               WHEN     TO_NUMBER (TO_CHAR (SOM.FROM_DATE, 'DD')) >= EED
                    AND EED_TYPE = 2
               THEN
                  TRUNC (ADD_MONTHS (SOM.FROM_DATE, 1), 'MM')
               ELSE                                            -- EED_TYPE = 3
                  SOM.FROM_DATE
            END
               AS FROM_DATE_TEST,
            --           (SUBS_OFFER_MAP.FROM_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
            --         * 24
            --         * 60
            --         * 60
            --            AS FROM_DATE,
            CASE
               WHEN TO_NUMBER (TO_CHAR (SOM.FROM_DATE, 'DD')) < EED
               THEN
                    (  TRUNC (SOM.FROM_DATE, 'MM')
                     - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
                  * 24
                  * 60
                  * 60
               WHEN     TO_NUMBER (TO_CHAR (SOM.FROM_DATE, 'DD')) >= EED
                    AND EED_TYPE = 1
               THEN
                    (  TO_DATE (
                          EED || '/' || TO_CHAR (SOM.FROM_DATE, 'MM/YYYY'),
                          'DD/MM/YYYY')
                     - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
                  * 24
                  * 60
                  * 60
               WHEN     TO_NUMBER (TO_CHAR (SOM.FROM_DATE, 'DD')) >= EED
                    AND EED_TYPE = 2
               THEN
                    (  TRUNC (ADD_MONTHS (SOM.FROM_DATE, 1), 'MM')
                     - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
                  * 24
                  * 60
                  * 60
               ELSE                                            -- EED_TYPE = 3
                    (SOM.FROM_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
                  * 24
                  * 60
                  * 60
            END
               AS FROM_DATE,
            NVL (SOM.TO_DATE, TO_DATE ('2030-01-01', 'yyyy-mm-dd'))
               AS TO_DATE_TEST,
              (  NVL (SOM.TO_DATE, TO_DATE ('2030-01-01', 'yyyy-mm-dd'))
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

            SOM.MODIFIED_DATE AS MODIFIED_DATE_TEST,
              (SOM.MODIFIED_DATE - TO_DATE ('1970-01-01', 'yyyy-mm-dd'))
            * 24
            * 60
            * 60
               AS MODIFIED_DATE,
            PRODUCT_OFFER.OFFER_TYPE
       FROM SUBSCRIBER
            INNER JOIN SUBS_OFFER_MAP SOM
               ON (SUBSCRIBER.SUBSCRIBER_ID = SOM.SUBSCRIBER_ID)
            INNER JOIN PRODUCT_OFFER
               ON (PRODUCT_OFFER.OFFER_ID = SOM.PRODUCT_OFFER_ID)
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
