/* Formatted on 3/19/2014 8:07:35 AM (QP5 v5.215.12089.38647) */
SELECT t41.DISCOUNT_ITEM_ID AS discountItemId,
       t42.RESELLER_VERSION_ID AS resellerVersionId,
       t46.DISPLAY_VALUE AS rtDiscountKey,
       t42.RT_DISCOUNT_ID AS rtDiscountId,
       t49.DISPLAY_VALUE AS autFinalKey,
       t42.AUT_ID AS autId,
       t52.DISPLAY_VALUE AS autGroupKey,
       t42.AUT_GROUP_ID AS autGroupId,
       t42.IS_DEFAULT AS isDefault,
       t42.IS_INTERNAL AS isInternal,
       t43.LANGUAGE_CODE AS languageCode,
       t43.DISPLAY_VALUE AS displayValue,
       t43.DESCRIPTION AS description
  FROM RT_DISCOUNT_ITEM_KEY t41
       INNER JOIN RT_DISCOUNT_ITEM_REF t42
          ON t41.DISCOUNT_ITEM_ID = t42.DISCOUNT_ITEM_ID
       INNER JOIN RT_DISCOUNT_ITEM_VALUES t43
          ON     t42.DISCOUNT_ITEM_ID = t43.DISCOUNT_ITEM_ID
             AND t42.RESELLER_VERSION_ID = t43.RESELLER_VERSION_ID
       INNER JOIN RT_DISCOUNT_KEY t44
          ON t42.RT_DISCOUNT_ID = t44.RT_DISCOUNT_ID
       INNER JOIN RT_DISCOUNT_REF t45
          ON     t44.RT_DISCOUNT_ID = t45.RT_DISCOUNT_ID
             AND t45.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
       INNER JOIN RT_DISCOUNT_VALUES t46
          ON     t44.RT_DISCOUNT_ID = t46.RT_DISCOUNT_ID
             AND t46.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
             AND t46.LANGUAGE_CODE = t43.LANGUAGE_CODE
       LEFT OUTER JOIN AUT_FINAL_KEY t47
          ON t42.AUT_ID = t47.AUT_ID
       LEFT OUTER JOIN AUT_FINAL_REF t48
          ON     t47.AUT_ID = t48.AUT_ID
             AND t48.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
       LEFT OUTER JOIN AUT_FINAL_VALUES t49
          ON     t47.AUT_ID = t49.AUT_ID
             AND t49.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
             AND t49.LANGUAGE_CODE = t43.LANGUAGE_CODE
       LEFT OUTER JOIN AUT_GROUP_KEY t50
          ON t42.AUT_GROUP_ID = t50.AUT_GROUP_ID
       LEFT OUTER JOIN AUT_GROUP_REF t51
          ON     t50.AUT_GROUP_ID = t51.AUT_GROUP_ID
             AND t51.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
       LEFT OUTER JOIN AUT_GROUP_VALUES t52
          ON     t50.AUT_GROUP_ID = t52.AUT_GROUP_ID
             AND t52.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
             AND t52.LANGUAGE_CODE = t43.LANGUAGE_CODE
 WHERE t42.RESELLER_VERSION_ID = 2 AND t43.LANGUAGE_CODE = 1;