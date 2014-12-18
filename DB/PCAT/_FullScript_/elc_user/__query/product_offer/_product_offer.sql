/* Formatted on 14/4/2014 11:36:45 (QP5 v5.227.12220.39754) */
-- TEMP
--DROP TABLE product_offer;

SELECT * FROM product_offer;

-- TEMP

CREATE TABLE PRODUCT_OFFER
(
   OFFER_ID                NUMBER (10) NOT NULL,
   OFFER_NAME              VARCHAR2 (240 BYTE) NOT NULL,
   -- OFFER_ABBREVIATION      VARCHAR2 (31 BYTE),
   -- UNBILL                  CHAR (1 BYTE),
   -- B_NUMBER_ENRICH         VARCHAR2 (31 BYTE),
   -- PRODUCT_GROUP_TYPE      VARCHAR2 (31 BYTE),
   -- PARENT_ID               NUMBER (10),
   OFFER_TYPE              VARCHAR2 (31 BYTE),
   RESELLER_VERSION_ID     NUMBER (18) NOT NULL,
   SALES_EFFECTIVE_TIME    DATE NOT NULL,
   SALES_EXPIRATION_TIME   DATE,
   CURRENCY_NAME           VARCHAR2 (240),
   CURRENCY_CODE           NUMBER (6),
   UPSELL_TEMPLATE_ID      NUMBER (10)
   -- ,
   -- IS_INTERNAL NUMBER(1)   DEFAULT 0
);
-- NOTE ***************
-- ALTER TABLE PRODUCT_OFFER
-- ADD (IS_INTERNAL NUMBER(1) DEFAULT 0);

-- ******************** INSERT XONG NHO COMMIT
INSERT INTO product_offer
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
          T2.UPSELL_TEMPLATE_ID
		  -- ,
          -- 0
     FROM cbs_owner.OFFER_KEY t1
          INNER JOIN cbs_owner.OFFER_REF t2 ON t1.OFFER_ID = t2.OFFER_ID
          INNER JOIN
          cbs_owner.OFFER_VALUES t3
             ON     t2.OFFER_ID = t3.OFFER_ID
                AND t3.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.SERVICE_CATEGORY_KEY t45
             ON t2.SERVICE_CATEGORY_ID = t45.SERVICE_CATEGORY_ID
          INNER JOIN
          cbs_owner.SERVICE_CATEGORY_VALUES t46
             ON     t2.SERVICE_CATEGORY_ID = t46.SERVICE_CATEGORY_ID
                AND t46.LANGUAGE_CODE = t3.LANGUAGE_CODE
                AND t46.service_version_id = 1
          -- add currency
          INNER JOIN
          cbs_owner.RATE_CURRENCY_REF t22
             ON     T2.CURRENCY_CODE = t22.CURRENCY_CODE
                AND T22.SERVICE_VERSION_ID = T46.SERVICE_VERSION_ID
          INNER JOIN
          cbs_owner.RATE_CURRENCY_VALUES t23
             ON     t22.CURRENCY_CODE = t23.CURRENCY_CODE
                AND t22.SERVICE_VERSION_ID = t23.SERVICE_VERSION_ID
                AND T23.LANGUAGE_CODE = T3.LANGUAGE_CODE
    WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;

COMMIT;



-- IGNORE *********************
DROP TABLE product_offer;

CREATE TABLE product_offer
AS
   SELECT t1.OFFER_ID AS offer_id,                                 -- offerId,
          t3.DISPLAY_VALUE AS offer_name,                     -- displayValue,
          '~~~' AS offer_abbreviation,
          '0' AS unbill,
          '~~~' AS b_number_enrich,
          '~~~' AS product_group_type,
          999 AS parent_id,
          CASE T2.OFFER_TYPE WHEN 2 THEN 'PO' WHEN 3 THEN 'SO' ELSE 'AO' END
             AS offer_type,
          t2.RESELLER_VERSION_ID,
          T2.SALES_EFFECTIVE_DT AS sales_effective_time,
          T2.SALES_EXPIRATION_DT AS sales_expiration_time,
          T2.UPSELL_TEMPLATE_ID
     FROM cbs_owner.OFFER_KEY t1
          INNER JOIN cbs_owner.OFFER_REF t2 ON t1.OFFER_ID = t2.OFFER_ID
          INNER JOIN
          cbs_owner.OFFER_VALUES t3
             ON     t2.OFFER_ID = t3.OFFER_ID
                AND t3.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.SERVICE_CATEGORY_KEY t45
             ON t2.SERVICE_CATEGORY_ID = t45.SERVICE_CATEGORY_ID
          INNER JOIN
          cbs_owner.SERVICE_CATEGORY_VALUES t46
             ON     t2.SERVICE_CATEGORY_ID = t46.SERVICE_CATEGORY_ID
                AND t46.LANGUAGE_CODE = t3.LANGUAGE_CODE
                AND t46.service_version_id = 1
    WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1 AND 1 = 2;

