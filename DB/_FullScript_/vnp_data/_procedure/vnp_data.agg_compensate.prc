DROP PROCEDURE VNP_DATA.AGG_COMPENSATE;

CREATE OR REPLACE PROCEDURE VNP_DATA.AGG_COMPENSATE (IN_MONTH NUMBER, IN_YEAR NUMBER)
IS
   i                      PLS_INTEGER;
   j                      PLS_INTEGER;
   T_START_TIME           DATE;
   T_END_TIME             DATE;

   v_err_msg              VARCHAR2 (1023);

   CURSOR C_COMPENSATION_CDR
   IS
        SELECT A_NUMBER,
               AUT_FINAL_ID,
               SUM (SERVICE_FEE) AS SERVICE_FEE,
               SUM (CHARGE_FEE) AS CHARGE_FEE,
               SUM (OFFER_COST) AS OFFER_COST,
               SUM (OFFER_FREE_BLOCK) AS OFFER_FREE_BLOCK,
               SUM (INTERNAL_COST) AS INTERNAL_COST,
               SUM (INTERNAL_FREE_BLOCK) AS INTERNAL_FREE_BLOCK,
               SUM (RATED_SERVICE_FEE) AS RATED_SERVICE_FEE,
               SUM (RATED_CHARGE_FEE) AS RATED_CHARGE_FEE,
               SUM (RATED_OFFER_COST) AS RATED_OFFER_COST,
               SUM (RATED_OFFER_FREE_BLOCK) AS RATED_OFFER_FREE_BLOCK,
               SUM (RATED_INTERNAL_COST) AS RATED_INTERNAL_COST,
               SUM (RATED_INTERNAL_FREE_BLOCK) AS RATED_INTERNAL_FREE_BLOCK
          FROM VNP_DATA.COMPENSATION_CDR 
      GROUP BY A_NUMBER, AUT_FINAL_ID;

   TYPE T_TBL_COMPENSATION_CDR IS TABLE OF C_COMPENSATION_CDR%ROWTYPE;

   TBL_COMPENSATION_CDR   T_TBL_COMPENSATION_CDR;
--   CURSOR C_HOT_AGGREGATED (N_PART HOT_AGGREGATED_CDR.DATA_PART%TYPE)
--   IS
--        SELECT A_NUMBER,
--               DATA_PART,
--               CDR_TYPE,
--               AUT_FINAL_ID,
--               BILL_MONTH                                                 -- ,
--          --             TOTAL_CDR,
--          --             TOTAL_USAGE,
--          --             SERVICE_FEE,
--          --             CHARGE_FEE,
--          --             OFFER_COST,
--          --             OFFER_FREE_BLOCK,
--          --             INTERNAL_COST,
--          --             INTERNAL_FREE_BLOCK
--          FROM VNP_DATA.HOT_AGGREGATED_CDR
--         WHERE DATA_PART = N_PART AND BILL_MONTH = IN_BILL_MONTH
--      ORDER BY AUT_FINAL_ID;

--   CURSOR C_HOT_AND_RATED (
--      N_PART          HOT_RATED_CDR.DATA_PART%TYPE,
--      T_START_TIME    DATE,
--      T_END_TIME      DATE)
--   IS
--        SELECT                                                  -- HOT.MAP_ID,
--              HOT.A_NUMBER,
--               --               HOT.DATA_PART,
--               --               HOT.CDR_START_TIME,
--               HOT.AUT_FINAL_ID,
--               HOT.SERVICE_FEE AS SERVICE_FEE,
--               HOT.CHARGE_FEE AS CHARGE_FEE,
--               HOT.OFFER_COST AS OFFER_COST,
--               HOT.OFFER_FREE_BLOCK AS OFFER_FREE_BLOCK,
--               HOT.INTERNAL_COST AS INTERNAL_COST,
--               HOT.INTERNAL_FREE_BLOCK AS INTERNAL_FEE_BLOCK,
--               RATED.SERVICE_FEE AS RATED_SERVICE_FEE,
--               RATED.CHARGE_FEE AS RATED_CHARGE_FEE,
--               RATED.OFFER_COST AS RATED_OFFER_COST,
--               RATED.OFFER_FREE_BLOCK AS RATED_OFFER_COST,
--               RATED.INTERNAL_COST AS RATED_INTERNAL_COST,
--               RATED.INTERNAL_FREE_BLOCK AS RATED_INTERNAL_FREE_BLOCK     -- ,
--          --               RATED.RERATE_FLAG
--          FROM HOT_RATED_CDR HOT
--               INNER JOIN RATED_CDR RATED ON (HOT.MAP_ID = RATED.MAP_ID)
--         WHERE     HOT.DATA_PART = N_PART
--               AND RATED.DATA_PART = N_PART
--               AND RATED.RERATE_FLAG = 5
--               AND HOT.CDR_START_TIME >= T_START_TIME
--               AND HOT.CDR_START_TIME < T_END_TIME
--      GROUP BY HOT.A_NUMBER, HOT.AUT_FINAL_ID;
--
--   R_CUR_ITEM     C_HOT_AND_RATED%ROWTYPE;
--
--   TYPE TBL_HOT_AND_RATED IS TABLE OF R_CUR_ITEM;

/******************************************************************************
   NAME:       AGG_COMPENSATE
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        5/6/2014   manucian86       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     AGG_COMPENSATE
      Sysdate:         5/6/2014
      Date and Time:   5/6/2014, 09:08:23, and 5/6/2014 09:08:23
      Username:        manucian86 (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   SELECT TO_DATE ('01/' || IN_MONTH || '/' || IN_YEAR)
     INTO T_START_TIME
     FROM DUAL;

   SELECT ADD_MONTHS (T_START_TIME, 1) INTO T_END_TIME FROM DUAL;

   FOR i IN 0 .. 9
   LOOP
      INSERT INTO VNP_DATA.COMPENSATION_CDR (A_NUMBER,
                                             AUT_FINAL_ID,
                                             SERVICE_FEE,
                                             CHARGE_FEE,
                                             OFFER_COST,
                                             OFFER_FREE_BLOCK,
                                             INTERNAL_COST,
                                             INTERNAL_FREE_BLOCK,
                                             RATED_SERVICE_FEE,
                                             RATED_CHARGE_FEE,
                                             RATED_OFFER_COST,
                                             RATED_OFFER_FREE_BLOCK,
                                             RATED_INTERNAL_COST,
                                             RATED_INTERNAL_FREE_BLOCK)
         SELECT                                                 -- HOT.MAP_ID,
               HOT.A_NUMBER,
                --               HOT.DATA_PART,
                --               HOT.CDR_START_TIME,
                HOT.AUT_FINAL_ID,
                HOT.SERVICE_FEE AS SERVICE_FEE,
                HOT.CHARGE_FEE AS CHARGE_FEE,
                HOT.OFFER_COST AS OFFER_COST,
                HOT.OFFER_FREE_BLOCK AS OFFER_FREE_BLOCK,
                HOT.INTERNAL_COST AS INTERNAL_COST,
                HOT.INTERNAL_FREE_BLOCK AS INTERNAL_FEE_BLOCK,
                RATED.SERVICE_FEE AS RATED_SERVICE_FEE,
                RATED.CHARGE_FEE AS RATED_CHARGE_FEE,
                RATED.OFFER_COST AS RATED_OFFER_COST,
                RATED.OFFER_FREE_BLOCK AS RATED_OFFER_FREE_BLOCK,
                RATED.INTERNAL_COST AS RATED_INTERNAL_COST,
                RATED.INTERNAL_FREE_BLOCK AS RATED_INTERNAL_FREE_BLOCK    -- ,
           --               RATED.RERATE_FLAG
           FROM HOT_RATED_CDR HOT
                INNER JOIN RATED_CDR RATED ON (HOT.MAP_ID = RATED.MAP_ID)
          WHERE     HOT.DATA_PART = i
                AND RATED.DATA_PART = i
                AND RATED.RERATE_FLAG = 5
                AND HOT.CDR_START_TIME >= T_START_TIME
                AND HOT.CDR_START_TIME < T_END_TIME;

      OPEN C_COMPENSATION_CDR;

      LOOP
         FETCH C_COMPENSATION_CDR
            BULK COLLECT INTO TBL_COMPENSATION_CDR
            LIMIT 1000;

         FORALL j IN TBL_COMPENSATION_CDR.FIRST .. TBL_COMPENSATION_CDR.LAST
            UPDATE VNP_DATA.HOT_AGGREGATED_CDR
               SET SERVICE_FEE =
                        SERVICE_FEE
                      - TBL_COMPENSATION_CDR (j).SERVICE_FEE
                      + TBL_COMPENSATION_CDR (j).RATED_SERVICE_FEE,
                   CHARGE_FEE =
                        CHARGE_FEE
                      - TBL_COMPENSATION_CDR (j).CHARGE_FEE
                      + TBL_COMPENSATION_CDR (j).RATED_CHARGE_FEE,
                   OFFER_COST =
                        OFFER_COST
                      - TBL_COMPENSATION_CDR (j).OFFER_COST
                      + TBL_COMPENSATION_CDR (j).RATED_OFFER_COST,
                   OFFER_FREE_BLOCK =
                        OFFER_FREE_BLOCK
                      - TBL_COMPENSATION_CDR (j).OFFER_FREE_BLOCK
                      + TBL_COMPENSATION_CDR (j).RATED_OFFER_FREE_BLOCK,
                   INTERNAL_COST =
                        INTERNAL_COST
                      - TBL_COMPENSATION_CDR (j).INTERNAL_COST
                      + TBL_COMPENSATION_CDR (j).RATED_INTERNAL_COST,
                   INTERNAL_FREE_BLOCK =
                        INTERNAL_FREE_BLOCK
                      - TBL_COMPENSATION_CDR (j).INTERNAL_FREE_BLOCK
                      + TBL_COMPENSATION_CDR (j).RATED_INTERNAL_FREE_BLOCK
             WHERE     A_NUMBER = TBL_COMPENSATION_CDR (j).A_NUMBER
                   AND AUT_FINAL_ID = TBL_COMPENSATION_CDR (j).AUT_FINAL_ID;

         --         FOR j IN TBL_COMPENSATION_CDR.FIRST .. TBL_COMPENSATION_CDR.LAST
         --         LOOP
         --            UPDATE VNP_DATA.HOT_AGGREGATED_CDR
         --               SET A_NUMBER = :A_NUMBER,
         --                   DATA_PART = :DATA_PART,
         --                   CDR_TYPE = :CDR_TYPE,
         --                   AUT_FINAL_ID = :AUT_FINAL_ID,
         --                   BILL_MONTH = :BILL_MONTH,
         --                   TOTAL_CDR = :TOTAL_CDR,
         --                   TOTAL_USAGE = :TOTAL_USAGE,
         --                   SERVICE_FEE = :SERVICE_FEE,
         --                   CHARGE_FEE = :CHARGE_FEE,
         --                   OFFER_COST = :OFFER_COST,
         --                   OFFER_FREE_BLOCK = :OFFER_FREE_BLOCK,
         --                   INTERNAL_COST = :INTERNAL_COST,
         --                   INTERNAL_FREE_BLOCK = :INTERNAL_FREE_BLOCK;
         --         END LOOP;

         EXIT WHEN C_COMPENSATION_CDR%NOTFOUND;
      END LOOP;

      CLOSE C_COMPENSATION_CDR;

      --        SELECT A_NUMBER,
      --               AUT_FINAL_ID,
      --               SUM (SERVICE_FEE) AS SERVICE_FEE,
      --               SUM (CHARGE_FEE) AS CHARGE_FEE,
      --               SUM (OFFER_COST) AS OFFER_COST,
      --               SUM (OFFER_FREE_BLOCK) AS OFFER_FREE_BLOCK,
      --               SUM (INTERNAL_COST) AS INTERNAL_COST,
      --               SUM (INTERNAL_FREE_BLOCK) AS INTERNAL_FREE_BLOCK,
      --               SUM (RATED_SERVICE_FEE) AS RATED_SERVICE_FEE,
      --               SUM (RATED_CHARGE_FEE) AS RATED_CHARGE_FEE,
      --               SUM (RATED_OFFER_COST) AS RATED_OFFER_COST,
      --               SUM (RATED_OFFER_FREE_BLOCK) AS RATED_OFFER_FREE_BLOCK,
      --               SUM (RATED_INTERNAL_COST) AS RATED_INTERNAL_COST,
      --               SUM (RATED_INTERNAL_FREE_BLOCK) AS RATED_INTERNAL_FREE_BLOCK
      --          FROM VNP_DATA.COMPENSATION_CDR
      --      GROUP BY A_NUMBER, AUT_FINAL_ID;

      --      OPEN C_HOT_AGGREGATED (i);
      --
      --      OPEN C_HOT_AND_RATED (i);

      --      LOOP
      --         FETCH C_HOT_AND_RATED
      --            BULK COLLECT INTO TBL_HOT_AND_RATED
      --            LIMIT 1000;
      --
      --         EXIT WHEN C_HOT_AND_RATED%NOTFOUND;
      --      END LOOP;

      --      FOR i IN TBL_HOT_AND_RATED.FIRST .. TBL_HOT_AND_RATED.LAST
      --      LOOP
      --         --        if TBL_HOT_AND_RATED(i).SERVICE_FEE != TBL_HOT_AND_RATED(i).SERVICE_FEE THEN
      --         --
      --         --        END IF;
      --
      --
      --
      --         END LOOP;

      --      CLOSE C_HOT_AND_RATED;

      COMMIT;
   END LOOP;
EXCEPTION
   --   WHEN NO_DATA_FOUND
   --   THEN
   --      NULL;
   WHEN OTHERS
   THEN
      ROLLBACK;

      v_err_msg :=
         SUBSTR (SQLERRM || CHR (10) || DBMS_UTILITY.format_error_backtrace,
                 1,
                 1023);

      INS_ACT_LOG ('DATABASE',
                   'AGG_COMPENSATE',
                   'ERROR: ' || v_err_msg,
                   3);
END AGG_COMPENSATE;
/
