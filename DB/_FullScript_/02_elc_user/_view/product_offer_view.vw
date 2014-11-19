/* Formatted on 17/11/2014 10:55:58 AM (QP5 v5.215.12089.38647) */
DROP VIEW ELC_USER.PRODUCT_OFFER_VIEW;


CREATE OR REPLACE FORCE VIEW ELC_USER.PRODUCT_OFFER_VIEW
(
   OFFER_ID,
   OFFER_NAME,
   OFFER_TYPE,
   RESELLER_VERSION_ID,
   SALES_EFFECTIVE_TIME,
   SALES_EXPIRATION_TIME,
   CURRENCY_NAME,
   CURRENCY_CODE,
   UPSELL_TEMPLATE_ID,
   AUTO_EXPIRATION_DURATION,
   AUTO_EXPIRATION_UNIT
)
AS
   SELECT t1.OFFER_ID AS offer_id,                                 -- offerId,
          t3.DISPLAY_VALUE AS offer_name,                     -- displayValue,
          -- NULL AS offer_abbreviation,
          -- 0 AS unbill,
          -- NULL AS b_number_enrich,
          -- NULL AS product_group_type,
          -- NULL AS parent_id,
          CASE T2.OFFER_TYPE WHEN 2 THEN 'PO' WHEN 3 THEN 'SO' ELSE 'AO' END
             AS offer_type,
          t2.RESELLER_VERSION_ID,
          -- add offer ref
          T2.SALES_EFFECTIVE_DT AS sales_effective_time,
          T2.SALES_EXPIRATION_DT AS sales_expiration_time,
          -- add currency
          t23.DISPLAY_VALUE AS currency_name,
          T2.CURRENCY_CODE,
          T2.UPSELL_TEMPLATE_ID,
          -- ,
          -- 0
          --       T2.AUTO_ACTIVATION,
          --       T2.AUTO_EXPIRATION_DT,
          T2.AUTO_EXPIRATION_DURATION,
          CASE T2.AUTO_EXPIRATION_UNITS
             WHEN 1 THEN 'MINUTES'
             WHEN 2 THEN 'HOURS'
             WHEN 140 THEN 'DAYS'
             WHEN 150 THEN 'WEEKS'
             WHEN 160 THEN 'MONTHS'
             WHEN 180 THEN 'YEARS'
             ELSE 'UNKNOWN'
          END
             AS AUTO_EXPIRATION_UNIT                                      -- ,
     --       T2.AUTO_EXTENSION_CTL
     FROM cbs_owner.OFFER_KEY t1
          INNER JOIN cbs_owner.OFFER_REF t2
             ON t1.OFFER_ID = t2.OFFER_ID
          INNER JOIN cbs_owner.OFFER_VALUES t3
             ON     t2.OFFER_ID = t3.OFFER_ID
                AND t3.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.SERVICE_CATEGORY_KEY t45
             ON t2.SERVICE_CATEGORY_ID = t45.SERVICE_CATEGORY_ID
          INNER JOIN cbs_owner.SERVICE_CATEGORY_VALUES t46
             ON     t2.SERVICE_CATEGORY_ID = t46.SERVICE_CATEGORY_ID
                AND t46.LANGUAGE_CODE = t3.LANGUAGE_CODE
                AND t46.service_version_id = 1
          -- add currency
          INNER JOIN cbs_owner.RATE_CURRENCY_REF t22
             ON     T2.CURRENCY_CODE = t22.CURRENCY_CODE
                AND T22.SERVICE_VERSION_ID = T46.SERVICE_VERSION_ID
          INNER JOIN cbs_owner.RATE_CURRENCY_VALUES t23
             ON     t22.CURRENCY_CODE = t23.CURRENCY_CODE
                AND t22.SERVICE_VERSION_ID = t23.SERVICE_VERSION_ID
                AND T23.LANGUAGE_CODE = T3.LANGUAGE_CODE
    WHERE t3.LANGUAGE_CODE = 1;