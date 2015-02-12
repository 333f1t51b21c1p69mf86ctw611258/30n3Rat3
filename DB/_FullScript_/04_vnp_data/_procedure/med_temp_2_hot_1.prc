DROP PROCEDURE VNP_DATA.MED_TEMP_2_HOT_1;

CREATE OR REPLACE PROCEDURE VNP_DATA.med_temp_2_hot_1 (
   IN_HEADER_ID   IN     VNP_DATA.TEMP_RATED_CDR_1.CDR_RECORD_HEADER_ID%TYPE,
   OUT_RESULT        OUT NUMBER)
IS
   N_EFFECTED_COUNT   PLS_INTEGER;
/******************************************************************************
   NAME: MED_TEMP_2_HOT
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        30/05/2014   manucian86       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     MED_TEMP_2_HOT
      Sysdate:         30/05/2014
      Date and Time:   30/05/2014, 17:10:39, and 30/05/2014 17:10:39
      Username:        manucian86 (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   INSERT /*+ APPEND */ INTO VNP_DATA.HOT_RATED_CDR_1 NOLOGGING(
                                        MAP_ID,
                                       A_NUMBER,
                                       CDR_TYPE,
                                       CREATED_TIME,
                                       CDR_START_TIME,
                                       DATA_PART,
                                       DURATION,
                                       TOTAL_USAGE,
                                       B_NUMBER,
                                       B_ZONE,
                                       NW_GROUP,
                                       SERVICE_FEE,
                                       SERVICE_FEE_ID,
                                       CHARGE_FEE,
                                       CHARGE_FEE_ID,
                                       LAC,
                                       CELL_ID,
                                       SUBSCRIBER_UNBILL,
                                       BU_ID,
                                       OLD_BU_ID,
                                       OFFER_COST,
                                       OFFER_FREE_BLOCK,
                                       INTERNAL_COST,
                                       INTERNAL_FREE_BLOCK,
                                       DIAL_DIGIT,
                                       CDR_RECORD_HEADER_ID,
                                       CDR_SEQUENCE_NUMBER,
                                       LOCATION_NO,
                                       MSC_ID,
                                       UNIT_TYPE_ID,
                                       PRIMARY_OFFER_ID,
                                       DISCOUNT_ITEM_ID,
                                       RERATE_FLAG,
                                       AUT_FINAL_ID,
                                       TARIFF_PLAN_ID,
                                       ERROR_CODE,
                                       PAYMENT_ID,
                                       SUBSCRIBER_NO,
                                       SUBSCRIBER_NO_RESETS,
                                       ACCOUNT_NO,
                                       PARENT_ACCOUNT_NO,
                                       INTL_ID,
                                       INTL_VND,
                                       CDR_CALL_TYPE, QOS)
      SELECT
            map_id_seq.nextval,
             A_NUMBER,
             CDR_TYPE,
             CREATED_TIME,
             CDR_START_TIME,
             TO_NUMBER (SUBSTR (A_NUMBER, LENGTH (A_NUMBER), 1)),
             DURATION,
             TOTAL_USAGE,
             B_NUMBER,
             B_ZONE,
             NW_GROUP,
             SERVICE_FEE,
             SERVICE_FEE_ID,
             CHARGE_FEE,
             CHARGE_FEE_ID,
             LAC,
             CELL_ID,
             SUBSCRIBER_UNBILL,
             BU_ID,
             OLD_BU_ID,
             OFFER_COST,
             OFFER_FREE_BLOCK,
             INTERNAL_COST,
             INTERNAL_FREE_BLOCK,
             DIAL_DIGIT,
             CDR_RECORD_HEADER_ID,
             CDR_SEQUENCE_NUMBER,
             LOCATION_NO,
             MSC_ID,
             UNIT_TYPE_ID,
             PRIMARY_OFFER_ID,
             DISCOUNT_ITEM_ID,
             RERATE_FLAG,
             AUT_FINAL_ID,
             TARIFF_PLAN_ID,
             ERROR_CODE,
             PAYMENT_ID,
             SUBSCRIBER_NO,
             SUBSCRIBER_NO_RESETS,
             ACCOUNT_NO,
             PARENT_ACCOUNT_NO,
             INTL_ID,
             INTL_VND,
             CDR_CALL_TYPE,QOS
        FROM VNP_DATA.TEMP_RATED_CDR_1;
       --WHERE CDR_RECORD_HEADER_ID = IN_HEADER_ID;

   N_EFFECTED_COUNT := SQL%ROWCOUNT;

   COMMIT;

   IF N_EFFECTED_COUNT > 0
   THEN
      OUT_RESULT := 1;
   ELSE
      OUT_RESULT := 0;
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      ROLLBACK;

      OUT_RESULT := 0;
END MED_TEMP_2_HOT_1;
/
