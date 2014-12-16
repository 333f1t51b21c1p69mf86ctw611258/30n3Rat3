DROP VIEW CBS_OWNER.OFFER_ACCUMULATOR_MAP_VIEW;

/* Formatted on 10/12/2014 9:02:55 AM (QP5 v5.215.12089.38647) */
CREATE OR REPLACE FORCE VIEW CBS_OWNER.OFFER_ACCUMULATOR_MAP_VIEW
(
   RESELLER_VERSION_ID,
   OFFER_NAME,
   OFFER_ID,
   ACCUMULATOR_NAME,
   ACCUMULATOR_ID
)
AS
   SELECT t1.RESELLER_VERSION_ID,                     -- AS resellerVersionId,
          t4.DISPLAY_VALUE AS offer_name,                         -- offerKey,
          t1.OFFER_ID AS offer_id,                                 -- offerId,
          t7.DISPLAY_VALUE AS accumulator_name,             -- accumulatorKey,
          t1.ACCUMULATOR_ID AS accumulator_id                 -- accumulatorId
     FROM cbs_owner.OFFER_ACCUMULATOR_MAP t1
          INNER JOIN cbs_owner.OFFER_KEY t2
             ON t1.OFFER_ID = t2.OFFER_ID
          INNER JOIN cbs_owner.OFFER_REF t3
             ON     t2.OFFER_ID = t3.OFFER_ID
                AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.OFFER_VALUES t4
             ON     t2.OFFER_ID = t4.OFFER_ID
                AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t4.LANGUAGE_CODE = 1
          INNER JOIN cbs_owner.ACCUMULATOR_KEY t5
             ON t1.ACCUMULATOR_ID = t5.ACCUMULATOR_ID
          INNER JOIN cbs_owner.ACCUMULATOR_REF t6
             ON     t5.ACCUMULATOR_ID = t6.ACCUMULATOR_ID
                AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
          INNER JOIN cbs_owner.ACCUMULATOR_VALUES t7
             ON     t5.ACCUMULATOR_ID = t7.ACCUMULATOR_ID
                AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE;


GRANT SELECT ON CBS_OWNER.OFFER_ACCUMULATOR_MAP_VIEW TO VNP_COMMON;
