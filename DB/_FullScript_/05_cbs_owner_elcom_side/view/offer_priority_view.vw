DROP VIEW CBS_OWNER.OFFER_PRIORITY_VIEW;

/* Formatted on 10/12/2014 9:02:56 AM (QP5 v5.215.12089.38647) */
CREATE OR REPLACE FORCE VIEW CBS_OWNER.OFFER_PRIORITY_VIEW
(
   OFFER_ID,
   OFFER_NAME,
   UPSELL_TEMPLATE_NAME,
   UPSELL_TEMPLATE_ID,
   RESELLER_VERSION_ID,
   UPSELL_TMP_DESC,
   UPSELL_TEMPLATE_MAP_ID,
   BUNDLE_NAME,
   BUNDLE_ID,
   UPSELL_TMP_OFFER_NAME,
   UPSELL_TMP_OFFER_ID,
   TARIFF_PRIORITY,
   RC_PRIORITY,
   DISCOUNT_PRIORITY,
   BALANCE_PRIORITY,
   DISPLAY_PRIORITY
)
AS
   SELECT T1.OFFER_ID,
          -- *** add offer
          T43.DISPLAY_VALUE AS offer_name,
          -- ### add offer
          t3.DISPLAY_VALUE AS upsell_template_name,                   -- name,
          t1.UPSELL_TEMPLATE_ID,                       -- AS upsellTemplateId,
          t1.RESELLER_VERSION_ID,                     -- AS resellerVersionId,
          --       t3.LANGUAGE_CODE AS languageCode,
          t3.DESCRIPTION AS upsell_tmp_desc,                   -- description,
          -- add upsell template map
          t21.UPSELL_TEMPLATE_MAP_ID,               -- AS upsellTemplateMapId,
          --       t21.RESELLER_VERSION_ID AS resellerVersionId,
          --       t24.DISPLAY_VALUE AS upsellTemplateKey,
          --       t21.UPSELL_TEMPLATE_ID AS upsellTemplateId,
          t27.DISPLAY_VALUE AS bundle_name,                      -- bundleKey,
          t21.BUNDLE_ID,                                       -- AS bundleId,
          t30.DISPLAY_VALUE AS upsell_tmp_offer_name,             -- offerKey,
          t21.OFFER_ID AS upsell_tmp_offer_id,                     -- offerId,
          t21.TARIFF_PRIORITY,                           -- AS tariffPriority,
          t21.RC_PRIORITY,                                   -- AS rcPriority,
          t21.DISCOUNT_PRIORITY,                       -- AS discountPriority,
          t21.BALANCE_PRIORITY,                         -- AS balancePriority,
          t21.DISPLAY_PRIORITY                           -- AS displayPriority
     FROM cbs_owner.OFFER_REF t1
          -- *** add offer
          INNER JOIN cbs_owner.OFFER_VALUES t43
             ON     t1.OFFER_ID = t43.OFFER_ID
                AND t43.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          -- ### add offer
          INNER JOIN cbs_owner.UPSELL_TEMPLATE_REF t2
             ON     t2.UPSELL_TEMPLATE_ID = t1.UPSELL_TEMPLATE_ID
                AND t2.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.UPSELL_TEMPLATE_VALUES t3
             ON     t2.UPSELL_TEMPLATE_ID = t3.UPSELL_TEMPLATE_ID
                AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
          -- add upsell template map
          INNER JOIN cbs_owner.UPSELL_TEMPLATE_MAP t21
             ON     T3.UPSELL_TEMPLATE_ID = T21.UPSELL_TEMPLATE_ID
                AND t21.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.UPSELL_TEMPLATE_KEY t22
             ON t21.UPSELL_TEMPLATE_ID = t22.UPSELL_TEMPLATE_ID
          INNER JOIN cbs_owner.UPSELL_TEMPLATE_REF t23
             ON     t22.UPSELL_TEMPLATE_ID = t23.UPSELL_TEMPLATE_ID
                AND t23.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.UPSELL_TEMPLATE_VALUES t24
             ON     t22.UPSELL_TEMPLATE_ID = t24.UPSELL_TEMPLATE_ID
                AND t24.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                AND t24.LANGUAGE_CODE = t3.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.BUNDLE_KEY t25
             ON t21.BUNDLE_ID = t25.BUNDLE_ID
          LEFT OUTER JOIN cbs_owner.BUNDLE_REF t26
             ON     t25.BUNDLE_ID = t26.BUNDLE_ID
                AND t26.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.BUNDLE_VALUES t27
             ON     t25.BUNDLE_ID = t27.BUNDLE_ID
                AND t27.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                AND t27.LANGUAGE_CODE = t24.LANGUAGE_CODE
          LEFT OUTER JOIN cbs_owner.OFFER_KEY t28
             ON t21.OFFER_ID = t28.OFFER_ID
          LEFT OUTER JOIN cbs_owner.OFFER_REF t29
             ON     t28.OFFER_ID = t29.OFFER_ID
                AND t29.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
          LEFT OUTER JOIN cbs_owner.OFFER_VALUES t30
             ON     t28.OFFER_ID = t30.OFFER_ID
                AND t30.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                AND t30.LANGUAGE_CODE = t24.LANGUAGE_CODE
    WHERE t3.LANGUAGE_CODE = 1;


GRANT SELECT ON CBS_OWNER.OFFER_PRIORITY_VIEW TO VNP_COMMON;
