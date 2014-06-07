/* Formatted on 11/03/2014 21:58:45 (QP5 v5.215.12089.38647) */
TRUNCATE TABLE product_offer;

SELECT * FROM product_offer;

INSERT INTO PRODUCT_OFFER (PRODUCT_OFFER_ID,
                           PRODUCT_OFFER_NAME,
                           PRODUCT_OFFER_ABBREVIATION,
                           UNBILL,
                           B_NUMBER_ENRICH,
                           PRODUCT_GROUP_TYPE,
                           PARENT_ID,
                           OFFER_TYPE)
   SELECT t1.OFFER_ID AS offerId,
          t3.DISPLAY_VALUE AS displayValue,
          NULL,
          0,
          NULL,
          NULL,
          NULL,
          CASE T2.OFFER_TYPE WHEN 2 THEN 'PO' WHEN 3 THEN 'SO' ELSE 'AO' END
             CASE
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
    WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;


SELECT t1.OFFER_ID AS offerId,
       t3.DISPLAY_VALUE AS displayValue,
       t2.SALES_EFFECTIVE_DT AS salesEffectiveDt,
       t2.IS_SELLABLE AS isSellable,
       t2.IS_GENERALLY_AVAILABLE AS isGenerallyAvailable,
       t2.IS_GLOBAL AS isGlobal,
       t46.DISPLAY_VALUE AS serviceCategoryKey,
       T2.OFFER_TYPE AS offer_type
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
 WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;