/* Formatted on 08/03/2014 14:43:37 (QP5 v5.215.12089.38647) */
SELECT t1.INITIAL_AUT_ID AS initialAutId,
       t2.SERVICE_VERSION_ID AS serviceVersionId,
       t6.DISPLAY_VALUE AS applicationIdKey,
       t2.APPLICATION_ID AS applicationId,
       t9.DISPLAY_VALUE AS subTypeIdKey,
       t2.SUB_TYPE_ID AS subTypeId,
       t2.IS_PRERATED AS isPrerated,
       t2.NETWORK_DELAY AS networkDelay,
       t2.GUIDE_TO_PROVIDER AS guideToProvider,
       t14.DISPLAY_VALUE AS pointCategoryKey,
       t2.POINT_CATEGORY AS pointCategory,
       t2.ORIGIN_COUNTRY_DIAL_CODE_REQ AS originCountryDialCodeReq,
       t2.DERIVE_DISTANCE_UNITS AS deriveDistanceUnits,
       t2.DERIVE_ZONE_CLASS AS deriveZoneClass,
       t2.VH_MINOR_THRESHOLD AS vhMinorThreshold,
       t2.DISTANCE_UNITS_INDICATOR AS distanceUnitsIndicator,
       t2.ACCOUNT_DRV AS accountDrv,
       t2.SUBSCRIBER_DRV AS subscriberDrv,
       t2.MARKET_DRV AS marketDrv,
       t2.PROVIDER_CODE_DRV AS providerCodeDrv,
       t2.LOCATION_DRV AS locationDrv,
       t2.LOCATION_RELATION_DRV AS locationRelationDrv,
       t2.POINT_CLASS_ORIGIN_DRV AS pointClassOriginDrv,
       t2.POINT_CLASS_TARGET_DRV AS pointClassTargetDrv,
       t2.JURISDICTION_DRV AS jurisdictionDrv,
       t2.DISTANCE_BAND_ID_DRV AS distanceBandIdDrv,
       t2.ZONE_CLASS_DRV AS zoneClassDrv,
       t2.ACCESS_METHOD_DRV AS accessMethodDrv,
       t2.CAAN_DRV AS caanDrv,
       t2.CALLING_CARD_DRV AS callingCardDrv,
       t2.SPECIAL_FEATURES_DRV AS specialFeaturesDrv,
       t2.CALLING_CIRCLE_DRV AS callingCircleDrv,
       t2.ONLINE_EXTENSIBLE_KEY_DRV AS onlineExtensibleKeyDrv,
       t2.OFFLINE_EXTENSIBLE_KEY_DRV AS offlineExtensibleKeyDrv,
       t2.BILL_CLASS_DRV AS billClassDrv,
       t19.DISPLAY_VALUE AS unitsTypeKey,
       t2.UNIT_TYPE AS unitType,
       t2.USG_CLASS AS usgClass,
       t2.FRIENDS_AND_FAMILY_DRV AS friendsAndFamilyDrv,
       t2.RATE_CLASS_DRV AS rateClassDrv,
       t2.RESERVATION_MAX_AMT AS reservationMaxAmt,
       t2.RESERVATION_MIN_AMT AS reservationMinAmt,
       t2.RESERVATION_MAX_NUM AS reservationMaxNum,
       t2.RESERVATION_LIFETIME AS reservationLifetime,
       t2.RESERVATION_AMT AS reservationAmt,
       t2.ONNET_DRV AS onnetDrv,
       t2.INTRAHIERARCHY_DRV AS intrahierarchyDrv,
       t2.MULTIPLE_FF_DRV AS multipleFfDrv,
       t2.MULTIPLE_FDA_DRV AS multipleFdaDrv,
       t2.MULTIPLE_FOA_DRV AS multipleFoaDrv,
       t3.LANGUAGE_CODE AS languageCode,
       t3.DISPLAY_VALUE AS displayValue,
       t3.DESCRIPTION AS description
  FROM cbs_owner.AUT_INITIAL_KEY t1
       INNER JOIN cbs_owner.AUT_INITIAL_REF t2
          ON t1.INITIAL_AUT_ID = t2.INITIAL_AUT_ID
       INNER JOIN cbs_owner.AUT_INITIAL_VALUES t3
          ON     t2.INITIAL_AUT_ID = t3.INITIAL_AUT_ID
             AND t2.SERVICE_VERSION_ID = t3.SERVICE_VERSION_ID
       LEFT OUTER JOIN cbs_owner.APPLICATION_ID_KEY t4
          ON t2.APPLICATION_ID = t4.APPLICATION_ID
       LEFT OUTER JOIN cbs_owner.APPLICATION_ID_REF t5
          ON     t4.APPLICATION_ID = t5.APPLICATION_ID
             AND t5.SERVICE_VERSION_ID = t2.SERVICE_VERSION_ID
       LEFT OUTER JOIN cbs_owner.APPLICATION_ID_VALUES t6
          ON     t4.APPLICATION_ID = t6.APPLICATION_ID
             AND t6.SERVICE_VERSION_ID = t2.SERVICE_VERSION_ID
             AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
       LEFT OUTER JOIN cbs_owner.SUB_TYPE_ID_KEY t7
          ON t2.SUB_TYPE_ID = t7.SUB_TYPE_ID
       LEFT OUTER JOIN cbs_owner.SUB_TYPE_ID_REF t8
          ON     t7.SUB_TYPE_ID = t8.SUB_TYPE_ID
             AND t8.SERVICE_VERSION_ID = t2.SERVICE_VERSION_ID
       LEFT OUTER JOIN cbs_owner.SUB_TYPE_ID_VALUES t9
          ON     t7.SUB_TYPE_ID = t9.SUB_TYPE_ID
             AND t9.SERVICE_VERSION_ID = t2.SERVICE_VERSION_ID
             AND t9.LANGUAGE_CODE = t3.LANGUAGE_CODE
       LEFT OUTER JOIN cbs_owner.POINT_CATEGORY_KEY t12
          ON t2.POINT_CATEGORY = t12.POINT_CATEGORY
       LEFT OUTER JOIN cbs_owner.POINT_CATEGORY_REF t13
          ON     t12.POINT_CATEGORY = t13.POINT_CATEGORY
             AND t13.SERVICE_VERSION_ID = t2.SERVICE_VERSION_ID
       LEFT OUTER JOIN cbs_owner.POINT_CATEGORY_VALUES t14
          ON     t12.POINT_CATEGORY = t14.POINT_CATEGORY
             AND t14.SERVICE_VERSION_ID = t2.SERVICE_VERSION_ID
             AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
       INNER JOIN cbs_owner.UNITS_TYPE_KEY t17
          ON t2.UNIT_TYPE = t17.UNIT_TYPE
       INNER JOIN cbs_owner.UNITS_TYPE_REF t18
          ON     t17.UNIT_TYPE = t18.UNIT_TYPE
             AND t18.SERVICE_VERSION_ID = t2.SERVICE_VERSION_ID
       INNER JOIN cbs_owner.UNITS_TYPE_VALUES t19
          ON     t17.UNIT_TYPE = t19.UNIT_TYPE
             AND t19.SERVICE_VERSION_ID = t2.SERVICE_VERSION_ID
             AND t19.LANGUAGE_CODE = t3.LANGUAGE_CODE
 WHERE t2.SERVICE_VERSION_ID = 1 AND t3.LANGUAGE_CODE = 1