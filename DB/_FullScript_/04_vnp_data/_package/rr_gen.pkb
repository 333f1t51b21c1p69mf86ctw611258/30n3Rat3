DROP PACKAGE BODY VNP_DATA.RR_GEN;

CREATE OR REPLACE PACKAGE BODY VNP_DATA.RR_GEN
AS
   /******************************************************************************
      NAME:       RR_GEN
      PURPOSE:

      REVISIONS:
      Ver        Date        Author           Description
      ---------  ----------  ---------------  ------------------------------------
      1.0        02/01/2014      manucian86       1. Created this package body.
   ******************************************************************************/

   PROCEDURE GEN_HOT_RATED_CDR
   IS
      N_SUBS_COUNT   NUMBER (3);
   BEGIN
      SELECT COUNT (*) INTO N_SUBS_COUNT FROM VNP_COMMON.TMP_SUBSCRIBER;

      INSERT INTO VNP_DATA.HOT_RATED_CDR_5 (A_NUMBER,
                                            CDR_TYPE,
                                            CREATED_TIME,
                                            CDR_START_TIME,
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
                                            RERATE_FLAG,
                                            CALL_TYPE_ID,
                                            PAYMENT_ITEM_ID,
                                            MSC_ID)
         SELECT A_NUMBER,
                CDR_TYPE,
                CREATED_TIME,
                CDR_START_TIME,
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
                RERATE_FLAG,
                CALL_TYPE_ID,
                PAYMENT_ITEM_ID,
                MSC_ID
           FROM VNP_DATA.HOT_RATED_CDR;

      UPDATE VNP_DATA.HOT_RATED_CDR_5
         SET TMP_A_NUMBER = ROUND (DBMS_RANDOM.VALUE (1, N_SUBS_COUNT));

      UPDATE VNP_DATA.HOT_RATED_CDR_5
         SET TMP_CDR_START_TIME = ROUND (DBMS_RANDOM.VALUE (1, 90));

      UPDATE VNP_DATA.HOT_RATED_CDR_5 HRC
         SET A_NUMBER =
                (SELECT SUBSCRIBER_NO
                   FROM VNP_COMMON.TMP_SUBSCRIBER TS
                  WHERE HRC.TMP_A_NUMBER = TS.SUBSCRIBER_NUM),
             CDR_START_TIME =
                TO_DATE (
                      TO_CHAR (SYSDATE - TMP_CDR_START_TIME, 'DD/MM/YYYY')
                   || ' '
                   || TO_CHAR (CDR_START_TIME, 'HH24:MI:SS'),
                   'DD/MM/YYYY HH24:MI:SS');

      INS_ACT_LOG ('DATABASE',
                   'GEN_HOT_RATED_CDR',
                   'DONE: GEN_HOT_RATED_CDR',
                   0);

      COMMIT;
   END;
END;
/
