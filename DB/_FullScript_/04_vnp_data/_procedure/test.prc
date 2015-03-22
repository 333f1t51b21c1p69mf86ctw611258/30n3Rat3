DROP PROCEDURE VNP_DATA.TEST;

CREATE OR REPLACE PROCEDURE VNP_DATA.test
IS
   i                      PLS_INTEGER;

   TYPE t_ref_cursor IS REF CURSOR;

   c_compensation_sum     t_ref_cursor;

   TYPE t_r_compensation_sum IS RECORD
   (
      A_NUMBER                    VNP_DATA.HOT_AGGREGATED_CDR.A_NUMBER%TYPE,
      AUT_FINAL_ID                VNP_DATA.HOT_AGGREGATED_CDR.AUT_FINAL_ID%TYPE,
      SERVICE_FEE                 VNP_DATA.HOT_AGGREGATED_CDR.SERVICE_FEE%TYPE,
      CHARGE_FEE                  VNP_DATA.HOT_AGGREGATED_CDR.CHARGE_FEE%TYPE,
      OFFER_COST                  VNP_DATA.HOT_AGGREGATED_CDR.OFFER_COST%TYPE,
      OFFER_FREE_BLOCK            VNP_DATA.HOT_AGGREGATED_CDR.OFFER_FREE_BLOCK%TYPE,
      INTERNAL_COST               VNP_DATA.HOT_AGGREGATED_CDR.INTERNAL_COST%TYPE,
      INTERNAL_FREE_BLOCK         VNP_DATA.HOT_AGGREGATED_CDR.INTERNAL_FREE_BLOCK%TYPE,
      RATED_SERVICE_FEE           VNP_DATA.HOT_AGGREGATED_CDR.SERVICE_FEE%TYPE,
      RATED_CHARGE_FEE            VNP_DATA.HOT_AGGREGATED_CDR.CHARGE_FEE%TYPE,
      RATED_OFFER_COST            VNP_DATA.HOT_AGGREGATED_CDR.OFFER_COST%TYPE,
      RATED_OFFER_FREE_BLOCK      VNP_DATA.HOT_AGGREGATED_CDR.OFFER_FREE_BLOCK%TYPE,
      RATED_INTERNAL_COST         VNP_DATA.HOT_AGGREGATED_CDR.INTERNAL_COST%TYPE,
      RATED_INTERNAL_FREE_BLOCK   VNP_DATA.HOT_AGGREGATED_CDR.INTERNAL_FREE_BLOCK%TYPE
   );

   rec                    t_r_compensation_sum;

   TYPE T_TBL_COMPENSATION_SUM IS TABLE OF t_r_compensation_sum;

   TBL_COMPENSATION_SUM   T_TBL_COMPENSATION_SUM;
BEGIN
   INSERT INTO VNP_DATA.COMPENSATION_CDR (MAP_ID,
                                          A_NUMBER,
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
      SELECT HOT.MAP_ID,
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
             RATED.INTERNAL_FREE_BLOCK AS RATED_INTERNAL_FREE_BLOCK       -- ,
        --               RATED.RERATE_FLAG
        FROM HOT_RATED_CDR HOT
             INNER JOIN RATED_CDR RATED ON (HOT.MAP_ID = RATED.MAP_ID)
       WHERE     HOT.DATA_PART = 1
             AND RATED.DATA_PART = 1
             AND RATED.RERATE_FLAG = 51
             AND HOT.CDR_START_TIME >= TO_DATE ('01/05/2014', 'dd/MM/yyyy')
             AND HOT.CDR_START_TIME < TO_DATE ('01/06/2014', 'dd/MM/yyyy');

   OPEN C_COMPENSATION_SUM FOR
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

   LOOP
      FETCH C_COMPENSATION_SUM
         BULK COLLECT INTO TBL_COMPENSATION_SUM
         LIMIT 100;

      EXIT WHEN TBL_COMPENSATION_SUM.COUNT = 0;

      FOR i IN TBL_COMPENSATION_SUM.FIRST .. TBL_COMPENSATION_SUM.LAST
      LOOP
         DBMS_OUTPUT.put_line (
               TBL_COMPENSATION_SUM (i).A_NUMBER
            || ','
            || TBL_COMPENSATION_SUM (i).AUT_FINAL_ID);
      END LOOP;
   END LOOP;
END test;
/
