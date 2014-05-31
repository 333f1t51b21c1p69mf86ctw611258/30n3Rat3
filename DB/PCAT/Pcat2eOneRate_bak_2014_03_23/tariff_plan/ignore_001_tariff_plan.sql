/* Formatted on 22/3/2014 15:49:29 (QP5 v5.215.12089.38647) */
SELECT t1.TARIFF_PLAN_ID AS tariffPlanId,
       t2.RESELLER_VERSION_ID AS resellerVersionId,
       t2.TARIFF_PLAN_TYPE AS tariffPlanType,
       t2.REPRICE_PRERATED AS repricePrerated,
       t2.UNIT_TYPE AS unitType,
       t2.GRACE_AMT AS graceAmt,
       t2.NO_BILL AS noBill,
       t2.MAINTAIN_TARIFF AS maintainTariff,
       t2.SINGLE_TARIFF_CHG_PRIORITY AS singleTariffChgPriority,
       t2.DISCOUNT_ELIGIBLE AS discountEligible,
       t2.UNIT_CREDIT_ELIGIBLE AS unitCreditEligible,
       t2.USG_CLASS AS usgClass,
       t2.UNITS_INDICATOR AS unitsIndicator,
       t2.DURATION_FLAG AS durationFlag,
       t2.KEEP_RUNNING_TOTAL AS keepRunningTotal,
       t2.USE_RATE_CLASS AS useRateClass,
       t2.USE_BILL_CLASS AS useBillClass,
       t2.USE_JURISDICTION AS useJurisdiction,
       t2.USE_POINT_CLASS_ORIGIN AS usePointClassOrigin,
       t2.USE_POINT_CLASS_TARGET AS usePointClassTarget,
       t2.USE_PROVIDER_CLASS AS useProviderClass,
       t2.USE_TIME_TYPE AS useTimeType,
       t2.USE_USAGE_PLAN_ID AS useUsagePlanId,
       t2.USE_EQUIP_TYPE_CODE AS useEquipTypeCode,
       t2.USE_EQUIP_CLASS_CODE AS useEquipClassCode,
       t2.USE_CLASS_OF_SERVICE_CODE AS useClassOfServiceCode,
       t2.USE_DISTANCE_BAND_ID AS useDistanceBandId,
       t2.USE_OFFER_ID AS useOfferId,
       t2.USE_ZONE_CLASS AS useZoneClass,
       t2.TIME_TYPE_ROUNDING AS timeTypeRounding,
       t2.RATE_MINIMUM_DURATION AS rateMinimumDuration,
       t2.MIN_BILLING_UNITS AS minBillingUnits,
       t2.MOBILE_CALL_DIRECTION AS mobileCallDirection,
       t2.CONSOLIDATE_USAGE AS consolidateUsage,
       t2.BILL_AGGR_LEVEL AS billAggrLevel,
       t2.CHARGE_RATE_ID AS chargeRateId,
       t3.LANGUAGE_CODE AS languageCode,
       t3.DISPLAY_VALUE AS displayValue,
       t3.DESCRIPTION AS description
  FROM TARIFF_PLAN_KEY t1
       INNER JOIN TARIFF_PLAN_REF t2
          ON t1.TARIFF_PLAN_ID = t2.TARIFF_PLAN_ID
       INNER JOIN TARIFF_PLAN_VALUES t3
          ON     t2.TARIFF_PLAN_ID = t3.TARIFF_PLAN_ID
             AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
 WHERE t2.RESELLER_VERSION_ID = 2 AND t3.LANGUAGE_CODE = 1;