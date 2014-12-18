/* Formatted on 14/4/2014 00:48:20 (QP5 v5.227.12220.39754) */
SELECT t21.UPSELL_TEMPLATE_MAP_ID AS upsellTemplateMapId,
       t21.RESELLER_VERSION_ID AS resellerVersionId,
       t24.DISPLAY_VALUE AS upsellTemplateKey,
       t21.UPSELL_TEMPLATE_ID AS upsellTemplateId,
       t27.DISPLAY_VALUE AS bundleKey,
       t21.BUNDLE_ID AS bundleId,
       t30.DISPLAY_VALUE AS offerKey,
       t21.OFFER_ID AS offerId,
       t21.TARIFF_PRIORITY AS tariffPriority,
       t21.RC_PRIORITY AS rcPriority,
       t21.DISCOUNT_PRIORITY AS discountPriority,
       t21.BALANCE_PRIORITY AS balancePriority,
       t21.DISPLAY_PRIORITY AS displayPriority
  FROM cbs_owner.UPSELL_TEMPLATE_MAP t21
       INNER JOIN cbs_owner.UPSELL_TEMPLATE_KEY t22
          ON t21.UPSELL_TEMPLATE_ID = t22.UPSELL_TEMPLATE_ID
       INNER JOIN
       cbs_owner.UPSELL_TEMPLATE_REF t23
          ON     t22.UPSELL_TEMPLATE_ID = t23.UPSELL_TEMPLATE_ID
             AND t23.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
       INNER JOIN
       cbs_owner.UPSELL_TEMPLATE_VALUES t24
          ON     t22.UPSELL_TEMPLATE_ID = t24.UPSELL_TEMPLATE_ID
             AND t24.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
             AND t24.LANGUAGE_CODE = 1
       LEFT OUTER JOIN cbs_owner.BUNDLE_KEY t25
          ON t21.BUNDLE_ID = t25.BUNDLE_ID
       LEFT OUTER JOIN
       cbs_owner.BUNDLE_REF t26
          ON     t25.BUNDLE_ID = t26.BUNDLE_ID
             AND t26.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
       LEFT OUTER JOIN
       cbs_owner.BUNDLE_VALUES t27
          ON     t25.BUNDLE_ID = t27.BUNDLE_ID
             AND t27.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
             AND t27.LANGUAGE_CODE = t24.LANGUAGE_CODE
       LEFT OUTER JOIN cbs_owner.OFFER_KEY t28 ON t21.OFFER_ID = t28.OFFER_ID
       LEFT OUTER JOIN
       cbs_owner.OFFER_REF t29
          ON     t28.OFFER_ID = t29.OFFER_ID
             AND t29.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
       LEFT OUTER JOIN
       cbs_owner.OFFER_VALUES t30
          ON     t28.OFFER_ID = t30.OFFER_ID
             AND t30.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
             AND t30.LANGUAGE_CODE = t24.LANGUAGE_CODE
 WHERE t21.RESELLER_VERSION_ID = 2;