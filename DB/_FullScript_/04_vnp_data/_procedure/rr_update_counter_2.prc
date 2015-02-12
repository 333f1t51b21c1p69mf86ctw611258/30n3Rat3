DROP PROCEDURE VNP_DATA.RR_UPDATE_COUNTER_2;

CREATE OR REPLACE PROCEDURE VNP_DATA.RR_UPDATE_COUNTER_2 (
   IN_BAL_GRP      IN NUMBER,
   IN_COUNTER      IN NUMBER,
   IN_REC_ID       IN NUMBER,
   IN_VALID_FROM   IN NUMBER,
   IN_VALID_TO     IN NUMBER,
   IN_CUR_BAL      IN NUMBER)
IS
   rowExist     NUMBER := 0;
   currentBal   NUMBER := 0;
   newBal       NUMBER := 0;
BEGIN
   rowExist := 0;
   currentBal := 0;
   newBal := 0;

   -- BAL_GROUP_ID, COUNTER_ID, RECORD_ID,
   -- VALID_FROM, VALID_TO, CURRENT_BAL

   -- BAL_GROUP_ID = ACCOUNT_VERSION_ID
   BEGIN
      SELECT COUNT (*)
        INTO rowExist
        FROM VNP_DATA.BALANCE_COUNTER
       WHERE     BAL_GROUP_ID = IN_BAL_GRP
             AND COUNTER_ID = IN_COUNTER
             AND VALID_FROM = IN_VALID_FROM;
   EXCEPTION
      WHEN OTHERS
      THEN
         rowExist := 0;
   END;

   IF rowExist = 0
   THEN
      INSERT INTO VNP_DATA.BALANCE_COUNTER (BAL_GROUP_ID,
                                   COUNTER_ID,
                                   RECORD_ID,
                                   VALID_FROM,
                                   VALID_TO,
                                   CURRENT_BAL)
           VALUES (IN_BAL_GRP,
                   IN_COUNTER,
                   IN_REC_ID,
                   IN_VALID_FROM,
                   IN_VALID_TO,
                   IN_CUR_BAL);
   ELSE
      SELECT CURRENT_BAL
        INTO currentBal
        FROM VNP_DATA.BALANCE_COUNTER
       WHERE     BAL_GROUP_ID = IN_BAL_GRP
             AND COUNTER_ID = IN_COUNTER
             AND VALID_FROM = IN_VALID_FROM;

      --      newBal := currentBal + IN_CUR_BAL;

      UPDATE VNP_DATA.BALANCE_COUNTER
         SET CURRENT_BAL = IN_CUR_BAL                                -- newBal
       WHERE     BAL_GROUP_ID = IN_BAL_GRP
             AND COUNTER_ID = IN_COUNTER
             AND VALID_FROM = IN_VALID_FROM;
   END IF;

   COMMIT;
END;
/


GRANT EXECUTE ON VNP_DATA.RR_UPDATE_COUNTER_2 TO VNP_COMMON;
