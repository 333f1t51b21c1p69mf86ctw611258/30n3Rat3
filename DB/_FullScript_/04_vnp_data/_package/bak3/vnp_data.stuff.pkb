DROP PACKAGE BODY STUFF;

CREATE OR REPLACE PACKAGE BODY          STUFF
AS
   /******************************************************************************
      NAME:       STUFF
      PURPOSE:

      REVISIONS:
      Ver        Date        Author           Description
      ---------  ----------  ---------------  ------------------------------------
      1.0        6/6/2014      manucian86       1. Created this package body.
   ******************************************************************************/

   PROCEDURE COMPENSATE (IN_MONTH VARCHAR2, IN_YEAR VARCHAR2)
   IS
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

      i                      PLS_INTEGER;
      j                      PLS_INTEGER;
      t_start_time           DATE;
      t_end_time             DATE;
      v_time                 VARCHAR2 (4);
      n_input                PLS_INTEGER := 0;
      n_tmp                  PLS_INTEGER := 0;

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

      TYPE T_TBL_COMPENSATION_SUM IS TABLE OF t_r_compensation_sum;

      TBL_COMPENSATION_SUM   T_TBL_COMPENSATION_SUM;
   --
   --      CURSOR C_COMPENSATION_SUM
   --      IS
   --           SELECT A_NUMBER,
   --                  AUT_FINAL_ID,
   --                  SUM (SERVICE_FEE) AS SERVICE_FEE,
   --                  SUM (CHARGE_FEE) AS CHARGE_FEE,
   --                  SUM (OFFER_COST) AS OFFER_COST,
   --                  SUM (OFFER_FREE_BLOCK) AS OFFER_FREE_BLOCK,
   --                  SUM (INTERNAL_COST) AS INTERNAL_COST,
   --                  SUM (INTERNAL_FREE_BLOCK) AS INTERNAL_FREE_BLOCK,
   --                  SUM (RATED_SERVICE_FEE) AS RATED_SERVICE_FEE,
   --                  SUM (RATED_CHARGE_FEE) AS RATED_CHARGE_FEE,
   --                  SUM (RATED_OFFER_COST) AS RATED_OFFER_COST,
   --                  SUM (RATED_OFFER_FREE_BLOCK) AS RATED_OFFER_FREE_BLOCK,
   --                  SUM (RATED_INTERNAL_COST) AS RATED_INTERNAL_COST,
   --                  SUM (RATED_INTERNAL_FREE_BLOCK) AS RATED_INTERNAL_FREE_BLOCK
   --             FROM VNP_DATA.COMPENSATION_CDR
   --         GROUP BY A_NUMBER, AUT_FINAL_ID;
   --
   --      TYPE T_TBL_COMPENSATION_SUM IS TABLE OF C_COMPENSATION_SUM%ROWTYPE;
   --
   --      TBL_COMPENSATION_SUM   T_TBL_COMPENSATION_SUM;
   --
   --   CURSOR C_COMPENSATION_CDR
   --   IS
   --      SELECT MAP_ID FROM VNP_DATA.COMPENSATION_CDR;
   --
   --   TYPE T_TBL_COMPENSATION_CDR IS TABLE OF C_COMPENSATION_CDR%ROWTYPE;
   --
   --   TBL_COMPENSATION_CDR   T_TBL_COMPENSATION_CDR;
   --
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
   --      t_start_time    DATE,
   --      t_end_time      DATE)
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
   --               AND HOT.CDR_START_TIME >= t_start_time
   --               AND HOT.CDR_START_TIME < t_end_time
   --      GROUP BY HOT.A_NUMBER, HOT.AUT_FINAL_ID;
   --
   --   R_CUR_ITEM     C_HOT_AND_RATED%ROWTYPE;
   --
   --   TYPE TBL_HOT_AND_RATED IS TABLE OF R_CUR_ITEM;

   BEGIN
      SELECT TO_DATE ('01/' || IN_MONTH || '/' || IN_YEAR, 'DD/MM/YYYY')
        INTO t_start_time
        FROM DUAL;



      SELECT ADD_MONTHS (t_start_time, 1) INTO t_end_time FROM DUAL;



      SELECT TO_CHAR (t_start_time, 'YYMM') INTO v_time FROM DUAL;



      FOR i IN 0 .. 9
      LOOP
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
                   RATED.INTERNAL_FREE_BLOCK AS RATED_INTERNAL_FREE_BLOCK -- ,
              --               RATED.RERATE_FLAG
              FROM    HOT_RATED_CDR HOT
                   INNER JOIN
                      RATED_CDR RATED
                   ON (HOT.MAP_ID = RATED.MAP_ID)
             WHERE     HOT.DATA_PART = i
                   AND RATED.DATA_PART = i
                   AND RATED.RERATE_FLAG = 50
                   AND HOT.CDR_START_TIME >= t_start_time
                   AND HOT.CDR_START_TIME < t_end_time;

         SELECT COUNT (1) INTO n_tmp FROM VNP_DATA.COMPENSATION_CDR;



         n_input := n_input + n_tmp;

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
                     SUM (RATED_INTERNAL_FREE_BLOCK)
                        AS RATED_INTERNAL_FREE_BLOCK
                FROM VNP_DATA.COMPENSATION_CDR
            GROUP BY A_NUMBER, AUT_FINAL_ID;

         LOOP
            FETCH C_COMPENSATION_SUM
            BULK COLLECT INTO TBL_COMPENSATION_SUM
            LIMIT 1000;

            EXIT WHEN TBL_COMPENSATION_SUM.COUNT = 0;

            FORALL j
                IN TBL_COMPENSATION_SUM.FIRST .. TBL_COMPENSATION_SUM.LAST
               UPDATE VNP_DATA.HOT_AGGREGATED_CDR
                  SET SERVICE_FEE =
                           SERVICE_FEE
                         - TBL_COMPENSATION_SUM (j).SERVICE_FEE
                         + TBL_COMPENSATION_SUM (j).RATED_SERVICE_FEE,
                      CHARGE_FEE =
                           CHARGE_FEE
                         - TBL_COMPENSATION_SUM (j).CHARGE_FEE
                         + TBL_COMPENSATION_SUM (j).RATED_CHARGE_FEE,
                      OFFER_COST =
                           OFFER_COST
                         - TBL_COMPENSATION_SUM (j).OFFER_COST
                         + TBL_COMPENSATION_SUM (j).RATED_OFFER_COST,
                      OFFER_FREE_BLOCK =
                           OFFER_FREE_BLOCK
                         - TBL_COMPENSATION_SUM (j).OFFER_FREE_BLOCK
                         + TBL_COMPENSATION_SUM (j).RATED_OFFER_FREE_BLOCK,
                      INTERNAL_COST =
                           INTERNAL_COST
                         - TBL_COMPENSATION_SUM (j).INTERNAL_COST
                         + TBL_COMPENSATION_SUM (j).RATED_INTERNAL_COST,
                      INTERNAL_FREE_BLOCK =
                           INTERNAL_FREE_BLOCK
                         - TBL_COMPENSATION_SUM (j).INTERNAL_FREE_BLOCK
                         + TBL_COMPENSATION_SUM (j).RATED_INTERNAL_FREE_BLOCK
                WHERE     DATA_PART = i
                      AND A_NUMBER = TBL_COMPENSATION_SUM (j).A_NUMBER
                      AND AUT_FINAL_ID =
                             TBL_COMPENSATION_SUM (j).AUT_FINAL_ID
                      AND BILL_MONTH = v_time;
         --
         --         FOR j IN TBL_COMPENSATION_SUM.FIRST .. TBL_COMPENSATION_SUM.LAST
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
         END LOOP;

         CLOSE C_COMPENSATION_SUM;

         UPDATE RATED_CDR
            SET RERATE_FLAG = 51
          WHERE     DATA_PART = i
                AND MAP_ID IN (SELECT MAP_ID FROM COMPENSATION_CDR);

         --      OPEN C_COMPENSATION_CDR;
         --
         --      LOOP
         --         FETCH C_COMPENSATION_CDR
         --            BULK COLLECT INTO TBL_COMPENSATION_CDR
         --            LIMIT 1000;
         --
         --         EXIT WHEN C_COMPENSATION_CDR%NOTFOUND;
         --
         --         FORALL j IN TBL_COMPENSATION_CDR.FIRST .. TBL_COMPENSATION_CDR.LAST
         --            UPDATE RATED_CDR
         --               SET RERATE_FLAG = 50
         --             WHERE MAP_ID = TBL_COMPENSATION_CDR (j).MAP_ID;
         --      END LOOP;
         --
         --      CLOSE C_COMPENSATION_CDR;

         COMMIT;
      --
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

      END LOOP;

      INS_ACT_LOG (
         'STUFF PACKAGE',
         'COMPENSATE',
            'DONE: COMPENSATE: '
         || IN_MONTH
         || '/'
         || IN_YEAR
         || ' with input: '
         || n_input,
         0);
   EXCEPTION
      --   WHEN NO_DATA_FOUND
      --   THEN
      --      NULL;
      WHEN OTHERS
      THEN
         ROLLBACK;

         RAISE;
   END;

   PROCEDURE COMPENSATE_THIS_MONTH
   IS
      v_err_msg   VARCHAR2 (1023);

      V_MONTH     VARCHAR2 (2);
      V_YEAR      VARCHAR2 (4);
   BEGIN
      SELECT TO_CHAR (SYSDATE, 'MM') INTO V_MONTH FROM DUAL;



      SELECT TO_CHAR (SYSDATE, 'YYYY') INTO V_YEAR FROM DUAL;



      COMPENSATE (V_MONTH, V_YEAR);
   EXCEPTION
      --   WHEN NO_DATA_FOUND
      --   THEN
      --      NULL;
      WHEN OTHERS
      THEN
         v_err_msg :=
            SUBSTR (
               SQLERRM || CHR (10) || DBMS_UTILITY.format_error_backtrace,
               1,
               1023);

         INS_ACT_LOG ('STUFF PACKAGE',
                      'COMPENSATE_THIS_MONTH',
                      'ERROR: ' || v_err_msg,
                      3);
   END;

   PROCEDURE COMPENSATE_PREVIOUS_MONTH
   IS
      v_err_msg   VARCHAR2 (1023);

      V_MONTH     VARCHAR2 (2);
      V_YEAR      VARCHAR2 (4);
   BEGIN
      SELECT TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'MM') INTO V_MONTH FROM DUAL;



      SELECT TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'YYYY') INTO V_YEAR FROM DUAL;



      COMPENSATE (V_MONTH, V_YEAR);
   EXCEPTION
      --   WHEN NO_DATA_FOUND
      --   THEN
      --      NULL;
      WHEN OTHERS
      THEN
         v_err_msg :=
            SUBSTR (
               SQLERRM || CHR (10) || DBMS_UTILITY.format_error_backtrace,
               1,
               1023);

         INS_ACT_LOG ('STUFF PACKAGE',
                      'COMPENSATE_PREVIOUS_MONTH',
                      'ERROR: ' || v_err_msg,
                      3);
   END;

   PROCEDURE ADD_PART_BY_DAY (I_TABLE_NAME          VARCHAR2,
                              I_TABLESPACE_NAME     VARCHAR2,
                              I_PARTITION_PREFIX    VARCHAR2,
                              I_DATAFILE_DIR        VARCHAR2,
                              I_DATAFILE_PREFIX     VARCHAR2)
   IS
      /******************************************************************************
           NAME:       ADD_PART_BY_DAY
           PURPOSE:

           REVISIONS:
           Ver        Date        Author           Description
           ---------  ----------  ---------------  ------------------------------------
           1.0        02/01/2014      manucian86       1. Created this procedure.

           I_PARTITION_PREFIX   = 'VNP_DATA_HRC'
           I_DATAFILE_DIR       = '/u01/app/oracle/oradata/eonerate/vnp_data'
           I_DATAFILE_PREFIX    = 'hot_rated_cdr'
        ******************************************************************************/

      v_err_msg                 VARCHAR2 (1023);
      v_max_part                VARCHAR2 (20);
      v_sql                     VARCHAR2 (1023);

      d_date                    DATE;
      v_tmp1                    VARCHAR2 (31);
      v_tmp2                    VARCHAR2 (31);
      v_to_date                 DATE;
      v_partition_name_format   VARCHAR2 (31) := 'yyMMdd';
   BEGIN
      v_to_date := SYSDATE + 2;

      SELECT SUBSTR (MAX (a.partition_name), 2)
        INTO v_max_part
        FROM user_tab_partitions a
       WHERE table_name = I_TABLE_NAME;



      d_date := TO_DATE (v_max_part, v_partition_name_format);

      -- d_date := d_date + 1;

      WHILE d_date < v_to_date
      LOOP
         SELECT TO_CHAR (d_date + 1, v_partition_name_format)
           INTO v_tmp1
           FROM DUAL;



         SELECT TO_CHAR (d_date + 2, v_partition_name_format)
           INTO v_tmp2
           FROM DUAL;



         --      SELECT TO_CHAR (d_date + 2, 'dd/mm/yyyy') INTO v_tmp2 FROM DUAL;

         FOR v_index IN 0 .. 9
         LOOP
            DECLARE
               TablespaceExistsExcep   EXCEPTION;
               PRAGMA EXCEPTION_INIT (TablespaceExistsExcep, -1543);
            BEGIN
               v_sql :=
                     'CREATE TABLESPACE '
                  || I_PARTITION_PREFIX
                  || '_P'
                  || v_tmp1
                  || '_'
                  || v_index
                  || ' DATAFILE '''
                  || I_DATAFILE_DIR
                  || I_DATAFILE_PREFIX
                  || '_P'
                  || v_tmp1
                  || '_'
                  || v_index
                  || '_1.dbf'' SIZE 1100M AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED, '''
                  || I_DATAFILE_DIR
                  || I_DATAFILE_PREFIX
                  || '_P'
                  || v_tmp1
                  || '_'
                  || v_index
                  || '_2.dbf'' SIZE 1100M AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED, '''
                  || I_DATAFILE_DIR
                  || I_DATAFILE_PREFIX
                  || '_P'
                  || v_tmp1
                  || '_'
                  || v_index
                  || '_3.dbf'' SIZE 1100M AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED, '''
                  || I_DATAFILE_DIR
                  || I_DATAFILE_PREFIX
                  || '_P'
                  || v_tmp1
                  || '_'
                  || v_index
                  || '_4.dbf'' SIZE 1100M AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED';

               EXECUTE IMMEDIATE (v_sql);
            EXCEPTION
               WHEN TablespaceExistsExcep
               THEN
                  --                  DBMS_OUTPUT.PUT_LINE ('Do something here....');
                  NULL;
            END;
         END LOOP;

         v_sql :=
               'ALTER TABLE '
            || I_TABLE_NAME
            || ' ADD PARTITION P'
            || v_tmp1
            || ' VALUES LESS THAN (TO_DATE(''20'
            || v_tmp2
            || ''',''yyyyMMdd''))'
            || ' TABLESPACE '
            || I_TABLESPACE_NAME
            || ' (';

         FOR v_index IN 0 .. 9
         LOOP
            v_sql :=
                  v_sql
               || 'SUBPARTITION P'
               || v_tmp1
               || '_'
               || v_index
               || ' VALUES LESS THAN ('
               || (v_index + 1)
               || ') TABLESPACE '
               || I_TABLESPACE_NAME
               || '_P'
               || v_tmp1
               || '_'
               || v_index;

            IF v_index <> 9
            THEN
               v_sql := v_sql || ', ';
            END IF;
         END LOOP;

         v_sql := v_sql || ')';

         EXECUTE IMMEDIATE (v_sql);

         --      DBMS_OUTPUT.put_line (v_sql);

         d_date := d_date + 1;
      END LOOP;

      INS_ACT_LOG ('DATABASE',
                   'ADD_PART_BY_DAY: ' || I_TABLE_NAME,
                   'DONE: ADD_PART_BY_DAY: ' || I_TABLE_NAME,
                   0);
   EXCEPTION
      WHEN OTHERS
      THEN
         v_err_msg :=
            SUBSTR (
               SQLERRM || CHR (10) || DBMS_UTILITY.format_error_backtrace,
               1,
               1023);

         INS_ACT_LOG ('DATABASE',
                      'ADD_PART_BY_DAY: ' || I_TABLE_NAME,
                      'ERROR: ' || v_err_msg,
                      3);
   END;


   PROCEDURE MOVE_TO_HOT_RATED
   IS
      /******************************************************************************
           NAME:       MOVE_TO_HOT_RATED
           PURPOSE:

           REVISIONS:
           Ver        Date        Author           Description
           ---------  ----------  ---------------  ------------------------------------
           1.0        02/01/2014      manucian86       1. Created this procedure.
        ******************************************************************************/

      v_err_msg        VARCHAR2 (1023);
      d_current_time   DATE;
      n_minus          NUMBER := 2 / 24;
   BEGIN
      FOR i IN 0 .. 9
      LOOP
         SELECT TRUNC (SYSDATE - n_minus, 'HH') INTO d_current_time FROM DUAL;

         INSERT /*+ APPEND */
               INTO  VNP_DATA.HOT_RATED_CDR_DEV (MAP_ID,
                                                 A_NUMBER,
                                                 CDR_TYPE,
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
                                                 PRIMARY_ONER_ID,
                                                 DISCOUNT_ITEM_ID,
                                                 BALANCE_CHANGE,
                                                 RERATE_FLAG,
                                                 AUT_FINAL_ID,
                                                 TARIFF_PLAN_ID,
                                                 ERROR_CODE,
                                                 PAYMENT_ID)
            SELECT /*+ PARALLEL(A 4)
                    USE_HASH(A) ORDERED */
                  MAP_ID_SEQ.NEXTVAL,
                   A_NUMBER,
                   CDR_TYPE,
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
                   BALANCE_CHANGE,
                   RERATE_FLAG,
                   AUT_FINAL_ID,
                   TARIFF_PLAN_ID,
                   ERROR_CODE,
                   PAYMENT_ID
              FROM HOT_RATED_CDR_1 A
             WHERE DATA_PART = i AND CREATED_TIME < d_current_time;

         DELETE HOT_RATED_CDR_1
          WHERE DATA_PART = i AND CREATED_TIME < d_current_time;

         COMMIT;
      END LOOP;

      INS_ACT_LOG (
         'DATABASE',
         'STUFF.MOVE_TO_HOT_RATED FROM HRC_1: < ' || d_current_time,
         'DONE: STUFF.MOVE_TO_HOT_RATED FROM HRC_1: < ' || d_current_time,
         0);

      --

      FOR i IN 0 .. 9
      LOOP
         SELECT TRUNC (SYSDATE - n_minus, 'HH') INTO d_current_time FROM DUAL;

         INSERT /*+ APPEND */
               INTO  VNP_DATA.HOT_RATED_CDR_DEV (MAP_ID,
                                                 A_NUMBER,
                                                 CDR_TYPE,
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
                                                 PRIMARY_ONER_ID,
                                                 DISCOUNT_ITEM_ID,
                                                 BALANCE_CHANGE,
                                                 RERATE_FLAG,
                                                 AUT_FINAL_ID,
                                                 TARIFF_PLAN_ID,
                                                 ERROR_CODE,
                                                 PAYMENT_ID)
            SELECT /*+ PARALLEL(A 4)
                    USE_HASH(A) ORDERED */
                  MAP_ID_SEQ.NEXTVAL,
                   A_NUMBER,
                   CDR_TYPE,
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
                   BALANCE_CHANGE,
                   RERATE_FLAG,
                   AUT_FINAL_ID,
                   TARIFF_PLAN_ID,
                   ERROR_CODE,
                   PAYMENT_ID
              FROM HOT_RATED_CDR_2 A
             WHERE DATA_PART = i AND CREATED_TIME < d_current_time;

         DELETE HOT_RATED_CDR_2
          WHERE DATA_PART = i AND CREATED_TIME < d_current_time;

         COMMIT;
      END LOOP;

      INS_ACT_LOG (
         'DATABASE',
         'STUFF.MOVE_TO_HOT_RATED FROM HRC_2: < ' || d_current_time,
         'DONE: STUFF.MOVE_TO_HOT_RATED FROM HRC_2: < ' || d_current_time,
         0);
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;

         v_err_msg :=
            SUBSTR (
               SQLERRM || CHR (10) || DBMS_UTILITY.format_error_backtrace,
               1,
               1023);

         INS_ACT_LOG ('DATABASE',
                      'STUFF.MOVE_TO_HOT_RATED: < ' || d_current_time,
                      'ERROR: ' || v_err_msg,
                      3);
   END;
END STUFF;

/
