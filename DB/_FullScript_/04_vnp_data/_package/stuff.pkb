DROP PACKAGE BODY VNP_DATA.STUFF;

CREATE OR REPLACE PACKAGE BODY VNP_DATA.STUFF
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
              FROM HOT_RATED_CDR HOT
                   INNER JOIN RATED_CDR RATED ON (HOT.MAP_ID = RATED.MAP_ID)
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
                AND MAP_ID IN (SELECT MAP_ID
                                 FROM COMPENSATION_CDR);

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

            BEGIN
               VNP_DATA.STUFF.ADD_PART_BY_DAY (
                  'HOT_RATED_CDR',
                  'vnp_data_hrc',
                  'VNP_DATA_HRC',
                  '/u01/app/oracle/oradata/eonerate/vnp_data/',
                  'hot_rated_cdr');
            END;

            BEGIN
               VNP_DATA.STUFF.ADD_PART_BY_DAY ('HOT_RATED_CDR',
                                               'vnp_data_hrc',
                                               'VNP_DATA_HRC',
                                               '+DATA/eonerate/datafile/vnp_data/',
                                               'hot_rated_cdr');
            END;
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
      SELECT SYSDATE + 5
        INTO v_to_date
        FROM DUAL;

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
                  || '.dbf'' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED';

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

      INS_ACT_LOG ('VNP_DATA',
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

         INS_ACT_LOG ('VNP_DATA',
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
      n_time           NUMBER := 5 / (24 * 60);                      -- 2 / 24
      v_trunc_type     VARCHAR2 (5) := 'MI';                           -- 'HH'

      lockhandle       VARCHAR2 (128);
      retcode          NUMBER;
   BEGIN
      DBMS_LOCK.ALLOCATE_UNIQUE ('MOVE_TO_HOT_RATED', lockhandle);

      retcode :=
         DBMS_LOCK.REQUEST (lockhandle,
                            timeout    => 0,
                            lockmode   => DBMS_LOCK.x_mode);

      IF retcode <> 0
      THEN
         raise_application_error (-20000,
                                  'MOVE_TO_HOT_RATED is already running');
      END IF;

      FOR i IN 0 .. 9
      LOOP
         SELECT TRUNC (SYSDATE - n_time, v_trunc_type)
           INTO d_current_time
           FROM DUAL;

         INSERT INTO VNP_DATA.HOT_RATED_CDR (MAP_ID,
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
                                             PAYMENT_ID)
            SELECT MAP_ID_SEQ.NEXTVAL,
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
             WHERE     DATA_PART = i
                   AND CREATED_TIME < d_current_time
                   AND RERATE_FLAG = 13;

         DELETE HOT_RATED_CDR_1
          WHERE     DATA_PART = i
                AND CREATED_TIME < d_current_time
                AND RERATE_FLAG = 13;

         COMMIT;

         --         SYS.DBMS_STATS.GATHER_TABLE_STATS (
         --            OwnName            => 'VNP_DATA',
         --            TabName            => 'HOT_RATED_CDR_1',
         --            Estimate_Percent   => 10,
         --            Method_Opt         => 'FOR ALL COLUMNS SIZE 1',
         --            Degree             => 4,
         --            Cascade            => FALSE,
         --            No_Invalidate      => FALSE);

         INS_ACT_LOG (
            'VNP_DATA',
               'STUFF.MOVE_TO_HOT_RATED FROM HRC_1: < '
            || d_current_time
            || '; DATA_PART: '
            || i,
               'DONE: STUFF.MOVE_TO_HOT_RATED FROM HRC_1: < '
            || d_current_time
            || '; DATA_PART: '
            || i,
            0);
      END LOOP;

      INS_ACT_LOG (
         'VNP_DATA',
         'STUFF.MOVE_TO_HOT_RATED FROM HRC_1: < ' || d_current_time,
         'DONE: STUFF.MOVE_TO_HOT_RATED FROM HRC_1: < ' || d_current_time,
         0);

      --

      FOR i IN 0 .. 9
      LOOP
         SELECT TRUNC (SYSDATE - n_time, v_trunc_type)
           INTO d_current_time
           FROM DUAL;

         INSERT INTO VNP_DATA.HOT_RATED_CDR (MAP_ID,
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
                                             PAYMENT_ID)
            SELECT MAP_ID_SEQ.NEXTVAL,
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
             WHERE     DATA_PART = i
                   AND CREATED_TIME < d_current_time
                   AND RERATE_FLAG = 13;

         DELETE HOT_RATED_CDR_2
          WHERE     DATA_PART = i
                AND CREATED_TIME < d_current_time
                AND RERATE_FLAG = 13;

         COMMIT;

         --         SYS.DBMS_STATS.GATHER_TABLE_STATS (
         --            OwnName            => 'VNP_DATA',
         --            TabName            => 'HOT_RATED_CDR_2',
         --            Estimate_Percent   => 10,
         --            Method_Opt         => 'FOR ALL COLUMNS SIZE 1',
         --            Degree             => 4,
         --            Cascade            => FALSE,
         --            No_Invalidate      => FALSE);

         INS_ACT_LOG (
            'VNP_DATA',
               'STUFF.MOVE_TO_HOT_RATED FROM HRC_2: < '
            || d_current_time
            || '; DATA_PART: '
            || i,
               'DONE: STUFF.MOVE_TO_HOT_RATED FROM HRC_2: < '
            || d_current_time
            || '; DATA_PART: '
            || i,
            0);
      END LOOP;

      INS_ACT_LOG (
         'VNP_DATA',
         'STUFF.MOVE_TO_HOT_RATED FROM HRC_2: < ' || d_current_time,
         'DONE: STUFF.MOVE_TO_HOT_RATED FROM HRC_2: < ' || d_current_time,
         0);

      retcode := DBMS_LOCK.RELEASE (lockhandle);
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;

         v_err_msg :=
            SUBSTR (
               SQLERRM || CHR (10) || DBMS_UTILITY.format_error_backtrace,
               1,
               1023);

         INS_ACT_LOG ('VNP_DATA',
                      'STUFF.MOVE_TO_HOT_RATED: < ' || d_current_time,
                      'ERROR: ' || v_err_msg,
                      3);
   END;

   PROCEDURE MOVE_TO_HOT_RATED_2
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
      n_minus          NUMBER := 5 / (24 * 60);                      -- 2 / 24
      v_trunc_type     VARCHAR2 (5) := 'MI';                           -- 'HH'
   BEGIN
      FOR i IN 0 .. 9
      LOOP
         SELECT TRUNC (SYSDATE - n_minus, v_trunc_type)
           INTO d_current_time
           FROM DUAL;

         INSERT INTO VNP_DATA.HOT_RATED_CDR (MAP_ID,
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
                                             PAYMENT_ID)
            SELECT MAP_ID_SEQ.NEXTVAL,
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
              FROM HOT_RATED_CDR_TEMP1 A
             WHERE     DATA_PART = i
                   AND CREATED_TIME < d_current_time
                   AND RERATE_FLAG = 13;

         DELETE HOT_RATED_CDR_TEMP1
          WHERE     DATA_PART = i
                AND CREATED_TIME < d_current_time
                AND RERATE_FLAG = 13;

         COMMIT;

         INS_ACT_LOG (
            'VNP_DATA',
               'STUFF.MOVE_TO_HOT_RATED FROM HRC_TEMP1: < '
            || d_current_time
            || '; DATA_PART: '
            || i,
               'DONE: STUFF.MOVE_TO_HOT_RATED FROM HRC_TEMP1: < '
            || d_current_time
            || '; DATA_PART: '
            || i,
            0);
      END LOOP;

      INS_ACT_LOG (
         'VNP_DATA',
         'STUFF.MOVE_TO_HOT_RATED FROM HRC_TEMP1: < ' || d_current_time,
         'DONE: STUFF.MOVE_TO_HOT_RATED FROM HRC_TEMP1: < ' || d_current_time,
         0);

      --

      FOR i IN 0 .. 9
      LOOP
         SELECT TRUNC (SYSDATE - n_minus, v_trunc_type)
           INTO d_current_time
           FROM DUAL;

         INSERT INTO VNP_DATA.HOT_RATED_CDR (MAP_ID,
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
                                             PAYMENT_ID)
            SELECT MAP_ID_SEQ.NEXTVAL,
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
              FROM HOT_RATED_CDR_TEMP2 A
             WHERE     DATA_PART = i
                   AND CREATED_TIME < d_current_time
                   AND RERATE_FLAG = 13;

         DELETE HOT_RATED_CDR_TEMP2
          WHERE     DATA_PART = i
                AND CREATED_TIME < d_current_time
                AND RERATE_FLAG = 13;

         COMMIT;

         INS_ACT_LOG (
            'VNP_DATA',
               'STUFF.MOVE_TO_HOT_RATED FROM HRC_TEMP2: < '
            || d_current_time
            || '; DATA_PART: '
            || i,
               'DONE: STUFF.MOVE_TO_HOT_RATED FROM HRC_TEMP2: < '
            || d_current_time
            || '; DATA_PART: '
            || i,
            0);
      END LOOP;

      INS_ACT_LOG (
         'VNP_DATA',
         'STUFF.MOVE_TO_HOT_RATED FROM HRC_TEMP2: < ' || d_current_time,
         'DONE: STUFF.MOVE_TO_HOT_RATED FROM HRC_TEMP2: < ' || d_current_time,
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

         INS_ACT_LOG ('VNP_DATA',
                      'STUFF.MOVE_TO_HOT_RATED_2: < ' || d_current_time,
                      'ERROR: ' || v_err_msg,
                      3);
   END;

   PROCEDURE AGGREGATE_HRC_12
   IS
      /******************************************************************************
           NAME:       AGGREGATE_HRC_12
           PURPOSE:

           REVISIONS:
           Ver        Date        Author           Description
           ---------  ----------  ---------------  ------------------------------------
           1.0        02/01/2014      manucian86       1. Created this procedure.
        ******************************************************************************/

      v_err_msg         VARCHAR2 (1023);

      n_cdr_log_count   PLS_INTEGER := 100;

      n_count           PLS_INTEGER;

      lockhandle        VARCHAR2 (128);
      retcode           NUMBER;
   BEGIN
      DBMS_LOCK.ALLOCATE_UNIQUE ('AGGREGATE_HRC_12', lockhandle);

      retcode :=
         DBMS_LOCK.REQUEST (lockhandle,
                            timeout    => 0,
                            lockmode   => DBMS_LOCK.x_mode);

      IF retcode <> 0
      THEN
         raise_application_error (-20000,
                                  'AGGREGATE_HRC_12 is already running');
      END IF;

      LOOP
         SELECT COUNT (1)
           INTO n_count
           FROM VNP_DATA.CDR_LOG_PROCESS
          WHERE STATUS = 6 AND INSTANCE = 1;

         EXIT WHEN n_count <= 0;

         UPDATE VNP_DATA.CDR_LOG_PROCESS
            SET STATUS = 11
          WHERE CDR_LOG_PROCESS_ID IN (SELECT CDR_LOG_PROCESS_ID
                                         FROM (  SELECT CDR_LOG_PROCESS_ID
                                                   FROM VNP_DATA.CDR_LOG_PROCESS
                                                  WHERE     STATUS = 6
                                                        AND INSTANCE = 1
                                               ORDER BY START_TIME)
                                        WHERE ROWNUM <= n_cdr_log_count);

         FOR i IN 0 .. 9
         LOOP
            MERGE INTO VNP_DATA.hot_aggregated_cdr ag
                 USING (  SELECT COUNT (1) total_cdr,
                                 a_number,
                                 --                              TO_NUMBER (
                                 --                                 SUBSTR (a_number, LENGTH (a_number), 1))
                                 --                                 data_part,
                                 data_part,
                                 TO_CHAR ( (cdr_start_time), 'yyMM') bill_month,
                                 cdr_type,
                                 SUM (total_usage) AS total_usage,
                                 SUM (service_fee) AS service_fee,
                                 SUM (charge_fee) AS charge_fee,
                                 SUM (offer_cost) AS offer_cost,
                                 SUM (offer_free_block) AS offer_free_block,
                                 SUM (internal_cost) AS internal_cost,
                                 SUM (internal_free_block) internal_free_block,
                                 SUM (INTL_VND) INTL_VND,
                                 payment_id
                            FROM VNP_DATA.hot_rated_cdr_1
                           WHERE     data_part = i
                                 AND CDR_RECORD_HEADER_ID IN (SELECT CDR_LOG_PROCESS_ID
                                                                FROM (SELECT CDR_LOG_PROCESS_ID
                                                                        FROM VNP_DATA.CDR_LOG_PROCESS
                                                                       WHERE     STATUS =
                                                                                    11
                                                                             AND INSTANCE =
                                                                                    1))
                        GROUP BY a_number,
                                 data_part,
                                 cdr_type,
                                 TO_CHAR ( (cdr_start_time), 'yyMM'),
                                 payment_id) v
                    ON (    ag.data_part = i
                        AND ag.data_part = v.data_part
                        AND ag.a_number = v.a_number
                        AND ag.bill_month = v.bill_month
                        AND ag.cdr_type = v.cdr_type
                        AND ag.payment_id = v.payment_id)
            WHEN MATCHED
            THEN
               UPDATE SET
                  ag.total_cdr = ag.total_cdr + NVL (v.total_cdr, 0),
                  ag.total_usage = ag.total_usage + NVL (v.total_usage, 0),
                  ag.service_fee = ag.service_fee + NVL (v.service_fee, 0),
                  ag.charge_fee = ag.charge_fee + NVL (v.charge_fee, 0),
                  ag.offer_cost = ag.offer_cost + NVL (v.offer_cost, 0),
                  ag.offer_free_block =
                     ag.offer_free_block + NVL (v.offer_free_block, 0),
                  ag.internal_cost =
                     ag.internal_cost + NVL (v.internal_cost, 0),
                  ag.internal_free_block =
                     ag.internal_free_block + NVL (v.internal_free_block, 0),
                  ag.INTL_VND = ag.INTL_VND + NVL (v.INTL_VND, 0)
            WHEN NOT MATCHED
            THEN
               INSERT     (ag.a_number,
                           ag.data_part,
                           ag.cdr_type,
                           ag.total_cdr,
                           ag.bill_month,
                           ag.total_usage,
                           ag.service_fee,
                           ag.charge_fee,
                           ag.offer_cost,
                           ag.offer_free_block,
                           ag.internal_cost,
                           ag.internal_free_block,
                           ag.INTL_VND,
                           ag.payment_id)
                   VALUES (v.a_number,
                           v.data_part,
                           v.cdr_type,
                           v.total_cdr,
                           v.bill_month,
                           v.total_usage,
                           v.service_fee,
                           v.charge_fee,
                           v.offer_cost,
                           v.offer_free_block,
                           v.internal_cost,
                           v.internal_free_block,
                           v.INTL_VND,
                           v.payment_id);

            INS_ACT_LOG (
               'VNP_DATA',
               'STUFF.AGGREGATE_HRC_12 - HRC_1 - MERGE DATA_PART: ' || i,
                  'DONE: STUFF.AGGREGATE_HRC_12 - HRC_1 - MERGE DATA_PART: '
               || i,
               0);
         END LOOP;

         UPDATE VNP_DATA.CDR_LOG_PROCESS
            SET STATUS = 13
          WHERE CDR_LOG_PROCESS_ID IN (SELECT CDR_LOG_PROCESS_ID
                                         FROM (SELECT CDR_LOG_PROCESS_ID
                                                 FROM VNP_DATA.CDR_LOG_PROCESS
                                                WHERE     STATUS = 11
                                                      AND INSTANCE = 1));

         COMMIT;
      END LOOP;

      INS_ACT_LOG ('VNP_DATA',
                   'STUFF.AGGREGATE_HRC_12 - HRC_1',
                   'DONE: STUFF.AGGREGATE_HRC_12 - HRC_1',
                   0);

      --

      LOOP
         SELECT COUNT (1)
           INTO n_count
           FROM VNP_DATA.CDR_LOG_PROCESS
          WHERE STATUS = 6 AND INSTANCE = 2;

         EXIT WHEN n_count <= 0;

         UPDATE VNP_DATA.CDR_LOG_PROCESS
            SET STATUS = 11
          WHERE CDR_LOG_PROCESS_ID IN (SELECT CDR_LOG_PROCESS_ID
                                         FROM (  SELECT CDR_LOG_PROCESS_ID
                                                   FROM VNP_DATA.CDR_LOG_PROCESS
                                                  WHERE     STATUS = 6
                                                        AND INSTANCE = 2
                                               ORDER BY START_TIME)
                                        WHERE ROWNUM <= n_cdr_log_count);

         FOR i IN 0 .. 9
         LOOP
            MERGE INTO VNP_DATA.hot_aggregated_cdr ag
                 USING (  SELECT COUNT (1) total_cdr,
                                 a_number,
                                 --                              TO_NUMBER (
                                 --                                 SUBSTR (a_number, LENGTH (a_number), 1))
                                 --                                 data_part,
                                 data_part,
                                 TO_CHAR ( (cdr_start_time), 'yyMM') bill_month,
                                 cdr_type,
                                 SUM (total_usage) AS total_usage,
                                 SUM (service_fee) AS service_fee,
                                 SUM (charge_fee) AS charge_fee,
                                 SUM (offer_cost) AS offer_cost,
                                 SUM (offer_free_block) AS offer_free_block,
                                 SUM (internal_cost) AS internal_cost,
                                 SUM (internal_free_block) internal_free_block,
                                 SUM (INTL_VND) INTL_VND,
                                 payment_id
                            FROM VNP_DATA.hot_rated_cdr_2
                           WHERE     data_part = i
                                 AND CDR_RECORD_HEADER_ID IN (SELECT CDR_LOG_PROCESS_ID
                                                                FROM (SELECT CDR_LOG_PROCESS_ID
                                                                        FROM VNP_DATA.CDR_LOG_PROCESS
                                                                       WHERE     STATUS =
                                                                                    11
                                                                             AND INSTANCE =
                                                                                    2))
                        GROUP BY a_number,
                                 data_part,
                                 cdr_type,
                                 TO_CHAR ( (cdr_start_time), 'yyMM'),
                                 payment_id) v
                    ON (    ag.data_part = i
                        AND ag.data_part = v.data_part
                        AND ag.a_number = v.a_number
                        AND ag.bill_month = v.bill_month
                        AND ag.cdr_type = v.cdr_type
                        AND ag.payment_id = v.payment_id)
            WHEN MATCHED
            THEN
               UPDATE SET
                  ag.total_cdr = ag.total_cdr + NVL (v.total_cdr, 0),
                  ag.total_usage = ag.total_usage + NVL (v.total_usage, 0),
                  ag.service_fee = ag.service_fee + NVL (v.service_fee, 0),
                  ag.charge_fee = ag.charge_fee + NVL (v.charge_fee, 0),
                  ag.offer_cost = ag.offer_cost + NVL (v.offer_cost, 0),
                  ag.offer_free_block =
                     ag.offer_free_block + NVL (v.offer_free_block, 0),
                  ag.internal_cost =
                     ag.internal_cost + NVL (v.internal_cost, 0),
                  ag.internal_free_block =
                     ag.internal_free_block + NVL (v.internal_free_block, 0),
                  ag.INTL_VND = ag.INTL_VND + NVL (v.INTL_VND, 0)
            WHEN NOT MATCHED
            THEN
               INSERT     (ag.a_number,
                           ag.data_part,
                           ag.cdr_type,
                           ag.total_cdr,
                           ag.bill_month,
                           ag.total_usage,
                           ag.service_fee,
                           ag.charge_fee,
                           ag.offer_cost,
                           ag.offer_free_block,
                           ag.internal_cost,
                           ag.internal_free_block,
                           ag.INTL_VND,
                           ag.payment_id)
                   VALUES (v.a_number,
                           v.data_part,
                           v.cdr_type,
                           v.total_cdr,
                           v.bill_month,
                           v.total_usage,
                           v.service_fee,
                           v.charge_fee,
                           v.offer_cost,
                           v.offer_free_block,
                           v.internal_cost,
                           v.internal_free_block,
                           v.INTL_VND,
                           v.payment_id);

            INS_ACT_LOG (
               'VNP_DATA',
               'STUFF.AGGREGATE_HRC_12 - HRC_2 - MERGE DATA_PART: ' || i,
                  'DONE: STUFF.AGGREGATE_HRC_12 - HRC_2 - MERGE DATA_PART: '
               || i,
               0);
         END LOOP;

         UPDATE VNP_DATA.CDR_LOG_PROCESS
            SET STATUS = 13
          WHERE CDR_LOG_PROCESS_ID IN (SELECT CDR_LOG_PROCESS_ID
                                         FROM (SELECT CDR_LOG_PROCESS_ID
                                                 FROM VNP_DATA.CDR_LOG_PROCESS
                                                WHERE     STATUS = 11
                                                      AND INSTANCE = 2));

         COMMIT;
      END LOOP;

      INS_ACT_LOG ('VNP_DATA',
                   'STUFF.AGGREGATE_HRC_12 - HRC_2',
                   'DONE: STUFF.AGGREGATE_HRC_12 - HRC_2',
                   0);

      retcode := DBMS_LOCK.RELEASE (lockhandle);
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;

         v_err_msg :=
            SUBSTR (
               SQLERRM || CHR (10) || DBMS_UTILITY.format_error_backtrace,
               1,
               1023);

         INS_ACT_LOG ('VNP_DATA',
                      'STUFF.AGGREGATE_HRC_12',
                      'ERROR: ' || v_err_msg,
                      3);
   END;

   PROCEDURE MOVE_HRC_12_TO_HRC
   IS
      /******************************************************************************
           NAME:       MOVE_HRC_12_TO_HRC
           PURPOSE:

           REVISIONS:
           Ver        Date        Author           Description
           ---------  ----------  ---------------  ------------------------------------
           1.0        02/01/2014      manucian86       1. Created this procedure.
        ******************************************************************************/

      v_err_msg         VARCHAR2 (1023);

      n_cdr_log_count   PLS_INTEGER := 100;

      n_count           PLS_INTEGER;

      lockhandle        VARCHAR2 (128);
      retcode           NUMBER;
   BEGIN
      DBMS_LOCK.ALLOCATE_UNIQUE ('MOVE_HRC_12_TO_HRC', lockhandle);

      retcode :=
         DBMS_LOCK.REQUEST (lockhandle,
                            timeout    => 0,
                            lockmode   => DBMS_LOCK.x_mode);

      IF retcode <> 0
      THEN
         raise_application_error (-20000,
                                  'MOVE_HRC_12_TO_HRC is already running');
      END IF;

      LOOP
         SELECT COUNT (1)
           INTO n_count
           FROM VNP_DATA.CDR_LOG_PROCESS
          WHERE STATUS = 13 AND INSTANCE = 1;

         EXIT WHEN n_count <= 0;

         UPDATE VNP_DATA.CDR_LOG_PROCESS
            SET STATUS = 20
          WHERE CDR_LOG_PROCESS_ID IN (SELECT CDR_LOG_PROCESS_ID
                                         FROM (  SELECT CDR_LOG_PROCESS_ID
                                                   FROM VNP_DATA.CDR_LOG_PROCESS
                                                  WHERE     STATUS = 13
                                                        AND INSTANCE = 1
                                               ORDER BY START_TIME)
                                        WHERE ROWNUM <= n_cdr_log_count);

         FOR i IN 0 .. 9
         LOOP
            INSERT INTO VNP_DATA.HOT_RATED_CDR
               SELECT *
                 FROM HOT_RATED_CDR_1 A
                WHERE     DATA_PART = i
                      AND CDR_RECORD_HEADER_ID IN (SELECT CDR_LOG_PROCESS_ID
                                                     FROM (SELECT CDR_LOG_PROCESS_ID
                                                             FROM VNP_DATA.CDR_LOG_PROCESS
                                                            WHERE     STATUS =
                                                                         20
                                                                  AND INSTANCE =
                                                                         1));

            DELETE HOT_RATED_CDR_1
             WHERE     DATA_PART = i
                   AND CDR_RECORD_HEADER_ID IN (SELECT CDR_LOG_PROCESS_ID
                                                  FROM (SELECT CDR_LOG_PROCESS_ID
                                                          FROM VNP_DATA.CDR_LOG_PROCESS
                                                         WHERE     STATUS =
                                                                      20
                                                               AND INSTANCE =
                                                                      1));

            INS_ACT_LOG (
               'VNP_DATA',
               'STUFF.MOVE_HRC_12_TO_HRC - HRC_1 - DATA_PART: ' || i,
               'DONE: STUFF.MOVE_HRC_12_TO_HRC - HRC_1 - DATA_PART: ' || i,
               0);
         END LOOP;

         UPDATE VNP_DATA.CDR_LOG_PROCESS
            SET STATUS = 21
          WHERE CDR_LOG_PROCESS_ID IN (SELECT CDR_LOG_PROCESS_ID
                                         FROM (SELECT CDR_LOG_PROCESS_ID
                                                 FROM VNP_DATA.CDR_LOG_PROCESS
                                                WHERE     STATUS = 20
                                                      AND INSTANCE = 1));

         COMMIT;
      END LOOP;

      INS_ACT_LOG ('VNP_DATA',
                   'STUFF.MOVE_HRC_12_TO_HRC - HRC_1',
                   'DONE: STUFF.MOVE_HRC_12_TO_HRC - HRC_1',
                   0);

      --

      LOOP
         SELECT COUNT (1)
           INTO n_count
           FROM VNP_DATA.CDR_LOG_PROCESS
          WHERE STATUS = 13 AND INSTANCE = 2;

         EXIT WHEN n_count <= 0;

         UPDATE VNP_DATA.CDR_LOG_PROCESS
            SET STATUS = 20
          WHERE CDR_LOG_PROCESS_ID IN (SELECT CDR_LOG_PROCESS_ID
                                         FROM (  SELECT CDR_LOG_PROCESS_ID
                                                   FROM VNP_DATA.CDR_LOG_PROCESS
                                                  WHERE     STATUS = 13
                                                        AND INSTANCE = 2
                                               ORDER BY START_TIME)
                                        WHERE ROWNUM <= n_cdr_log_count);

         FOR i IN 0 .. 9
         LOOP
            INSERT INTO VNP_DATA.HOT_RATED_CDR
               SELECT *
                 FROM HOT_RATED_CDR_2 A
                WHERE     DATA_PART = i
                      AND CDR_RECORD_HEADER_ID IN (SELECT CDR_LOG_PROCESS_ID
                                                     FROM (SELECT CDR_LOG_PROCESS_ID
                                                             FROM VNP_DATA.CDR_LOG_PROCESS
                                                            WHERE     STATUS =
                                                                         20
                                                                  AND INSTANCE =
                                                                         2));

            DELETE HOT_RATED_CDR_2
             WHERE     DATA_PART = i
                   AND CDR_RECORD_HEADER_ID IN (SELECT CDR_LOG_PROCESS_ID
                                                  FROM (SELECT CDR_LOG_PROCESS_ID
                                                          FROM VNP_DATA.CDR_LOG_PROCESS
                                                         WHERE     STATUS =
                                                                      20
                                                               AND INSTANCE =
                                                                      2));

            INS_ACT_LOG (
               'VNP_DATA',
               'STUFF.MOVE_HRC_12_TO_HRC - HRC_2 - DATA_PART: ' || i,
               'DONE: STUFF.MOVE_HRC_12_TO_HRC - HRC_2 - DATA_PART: ' || i,
               0);
         END LOOP;

         UPDATE VNP_DATA.CDR_LOG_PROCESS
            SET STATUS = 21
          WHERE CDR_LOG_PROCESS_ID IN (SELECT CDR_LOG_PROCESS_ID
                                         FROM (SELECT CDR_LOG_PROCESS_ID
                                                 FROM VNP_DATA.CDR_LOG_PROCESS
                                                WHERE     STATUS = 20
                                                      AND INSTANCE = 2));

         COMMIT;
      END LOOP;

      INS_ACT_LOG ('VNP_DATA',
                   'STUFF.MOVE_HRC_12_TO_HRC - HRC_2',
                   'DONE: STUFF.MOVE_HRC_12_TO_HRC - HRC_2',
                   0);

      retcode := DBMS_LOCK.RELEASE (lockhandle);
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;

         v_err_msg :=
            SUBSTR (
               SQLERRM || CHR (10) || DBMS_UTILITY.format_error_backtrace,
               1,
               1023);

         INS_ACT_LOG ('VNP_DATA',
                      'STUFF.MOVE_HRC_12_TO_HRC',
                      'ERROR: ' || v_err_msg,
                      3);
   END;

   PROCEDURE AGGREGATE_HRC_34
   IS
      /******************************************************************************
           NAME:       AGGREGATE_HRC_34
           PURPOSE:

           REVISIONS:
           Ver        Date        Author           Description
           ---------  ----------  ---------------  ------------------------------------
           1.0        02/01/2014      manucian86       1. Created this procedure.
        ******************************************************************************/

      v_err_msg    VARCHAR2 (1023);

      lockhandle   VARCHAR2 (128);
      retcode      NUMBER;
   BEGIN
      DBMS_LOCK.ALLOCATE_UNIQUE ('AGGREGATE_HRC_34', lockhandle);

      retcode :=
         DBMS_LOCK.REQUEST (lockhandle,
                            timeout    => 0,
                            lockmode   => DBMS_LOCK.x_mode);

      IF retcode <> 0
      THEN
         raise_application_error (-20000,
                                  'AGGREGATE_HRC_34 is already running');
      END IF;

      FOR i IN 0 .. 9
      LOOP
         MERGE INTO VNP_DATA.hot_aggregated_cdr ag
              USING (  SELECT COUNT (1) total_cdr,
                              a_number,
                              TO_NUMBER (
                                 SUBSTR (a_number, LENGTH (a_number), 1))
                                 data_part,
                              TO_CHAR ( (cdr_start_time), 'yyMM') bill_month,
                              cdr_type,
                              SUM (total_usage) AS total_usage,
                              SUM (service_fee) AS service_fee,
                              SUM (charge_fee) AS charge_fee,
                              SUM (offer_cost) AS offer_cost,
                              SUM (offer_free_block) AS offer_free_block,
                              SUM (internal_cost) AS internal_cost,
                              SUM (internal_free_block) internal_free_block,
                              SUM (INTL_VND) INTL_VND,
                              payment_id
                         FROM VNP_DATA.hot_rated_cdr_3
                        WHERE data_part = i AND rerate_flag = 0
                     --                           AND cdr_record_header_id = cdr_record_header_id
                     GROUP BY a_number,
                              cdr_type,
                              TO_CHAR ( (cdr_start_time), 'yyMM'),
                              payment_id) v
                 ON (    ag.data_part = i
                     AND ag.data_part = v.data_part
                     AND ag.a_number = v.a_number
                     AND ag.bill_month = v.bill_month
                     AND ag.cdr_type = v.cdr_type
                     AND ag.payment_id = v.payment_id)
         WHEN MATCHED
         THEN
            UPDATE SET
               ag.total_cdr = ag.total_cdr + NVL (v.total_cdr, 0),
               ag.total_usage = ag.total_usage + NVL (v.total_usage, 0),
               ag.service_fee = ag.service_fee + NVL (v.service_fee, 0),
               ag.charge_fee = ag.charge_fee + NVL (v.charge_fee, 0),
               ag.offer_cost = ag.offer_cost + NVL (v.offer_cost, 0),
               ag.offer_free_block =
                  ag.offer_free_block + NVL (v.offer_free_block, 0),
               ag.internal_cost = ag.internal_cost + NVL (v.internal_cost, 0),
               ag.internal_free_block =
                  ag.internal_free_block + NVL (v.internal_free_block, 0),
               ag.INTL_VND = ag.INTL_VND + NVL (v.INTL_VND, 0)
         WHEN NOT MATCHED
         THEN
            INSERT     (ag.a_number,
                        ag.data_part,
                        ag.cdr_type,
                        ag.total_cdr,
                        ag.bill_month,
                        ag.total_usage,
                        ag.service_fee,
                        ag.charge_fee,
                        ag.offer_cost,
                        ag.offer_free_block,
                        ag.internal_cost,
                        ag.internal_free_block,
                        ag.INTL_VND,
                        ag.payment_id)
                VALUES (v.a_number,
                        v.data_part,
                        v.cdr_type,
                        v.total_cdr,
                        v.bill_month,
                        v.total_usage,
                        v.service_fee,
                        v.charge_fee,
                        v.offer_cost,
                        v.offer_free_block,
                        v.internal_cost,
                        v.internal_free_block,
                        v.INTL_VND,
                        v.payment_id);

         UPDATE hot_rated_cdr_3
            SET rerate_flag = 13
          WHERE data_part = i AND rerate_flag = 0;

         COMMIT;

         INS_ACT_LOG (
            'VNP_DATA',
            'STUFF.AGGREGATE_HRC_34 - HRC_3 - DATA_PART: ' || i,
            'DONE: STUFF.AGGREGATE_HRC_34 - HRC_3 - DATA_PART: ' || i,
            0);
      END LOOP;

      --

      FOR i IN 0 .. 9
      LOOP
         MERGE INTO VNP_DATA.hot_aggregated_cdr ag
              USING (  SELECT COUNT (1) total_cdr,
                              a_number,
                              TO_NUMBER (
                                 SUBSTR (a_number, LENGTH (a_number), 1))
                                 data_part,
                              TO_CHAR ( (cdr_start_time), 'yyMM') bill_month,
                              cdr_type,
                              SUM (total_usage) AS total_usage,
                              SUM (service_fee) AS service_fee,
                              SUM (charge_fee) AS charge_fee,
                              SUM (offer_cost) AS offer_cost,
                              SUM (offer_free_block) AS offer_free_block,
                              SUM (internal_cost) AS internal_cost,
                              SUM (internal_free_block) internal_free_block,
                              SUM (INTL_VND) INTL_VND,
                              payment_id
                         FROM VNP_DATA.hot_rated_cdr_4
                        WHERE data_part = i AND rerate_flag = 0
                     --                           AND cdr_record_header_id = cdr_record_header_id
                     GROUP BY a_number,
                              cdr_type,
                              TO_CHAR ( (cdr_start_time), 'yyMM'),
                              payment_id) v
                 ON (    ag.data_part = i
                     AND ag.data_part = v.data_part
                     AND ag.a_number = v.a_number
                     AND ag.bill_month = v.bill_month
                     AND ag.cdr_type = v.cdr_type
                     AND ag.payment_id = v.payment_id)
         WHEN MATCHED
         THEN
            UPDATE SET
               ag.total_cdr = ag.total_cdr + NVL (v.total_cdr, 0),
               ag.total_usage = ag.total_usage + NVL (v.total_usage, 0),
               ag.service_fee = ag.service_fee + NVL (v.service_fee, 0),
               ag.charge_fee = ag.charge_fee + NVL (v.charge_fee, 0),
               ag.offer_cost = ag.offer_cost + NVL (v.offer_cost, 0),
               ag.offer_free_block =
                  ag.offer_free_block + NVL (v.offer_free_block, 0),
               ag.internal_cost = ag.internal_cost + NVL (v.internal_cost, 0),
               ag.internal_free_block =
                  ag.internal_free_block + NVL (v.internal_free_block, 0),
               ag.INTL_VND = ag.INTL_VND + NVL (v.INTL_VND, 0)
         WHEN NOT MATCHED
         THEN
            INSERT     (ag.a_number,
                        ag.data_part,
                        ag.cdr_type,
                        ag.total_cdr,
                        ag.bill_month,
                        ag.total_usage,
                        ag.service_fee,
                        ag.charge_fee,
                        ag.offer_cost,
                        ag.offer_free_block,
                        ag.internal_cost,
                        ag.internal_free_block,
                        ag.INTL_VND,
                        ag.payment_id)
                VALUES (v.a_number,
                        v.data_part,
                        v.cdr_type,
                        v.total_cdr,
                        v.bill_month,
                        v.total_usage,
                        v.service_fee,
                        v.charge_fee,
                        v.offer_cost,
                        v.offer_free_block,
                        v.internal_cost,
                        v.internal_free_block,
                        v.INTL_VND,
                        v.payment_id);

         UPDATE hot_rated_cdr_4
            SET rerate_flag = 13
          WHERE data_part = i AND rerate_flag = 0;

         COMMIT;

         INS_ACT_LOG (
            'VNP_DATA',
            'STUFF.AGGREGATE_HRC_34 - HRC_4 - DATA_PART: ' || i,
            'DONE: STUFF.AGGREGATE_HRC_34 - HRC_4 - DATA_PART: ' || i,
            0);
      END LOOP;

      retcode := DBMS_LOCK.RELEASE (lockhandle);
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;

         v_err_msg :=
            SUBSTR (
               SQLERRM || CHR (10) || DBMS_UTILITY.format_error_backtrace,
               1,
               1023);

         INS_ACT_LOG ('VNP_DATA',
                      'STUFF.AGGREGATE_HRC_34',
                      'ERROR: ' || v_err_msg,
                      3);
   END;

   PROCEDURE MOVE_HRC_34_TO_HRC
   IS
      /******************************************************************************
           NAME:       MOVE_HRC_34_TO_HRC
           PURPOSE:

           REVISIONS:
           Ver        Date        Author           Description
           ---------  ----------  ---------------  ------------------------------------
           1.0        02/01/2014      manucian86       1. Created this procedure.
        ******************************************************************************/

      v_err_msg    VARCHAR2 (1023);

      lockhandle   VARCHAR2 (128);
      retcode      NUMBER;
   BEGIN
      DBMS_LOCK.ALLOCATE_UNIQUE ('MOVE_HRC_34_TO_HRC', lockhandle);

      retcode :=
         DBMS_LOCK.REQUEST (lockhandle,
                            timeout    => 0,
                            lockmode   => DBMS_LOCK.x_mode);

      IF retcode <> 0
      THEN
         raise_application_error (-20000,
                                  'MOVE_HRC_34_TO_HRC is already running');
      END IF;

      FOR i IN 0 .. 9
      LOOP
         INSERT INTO VNP_DATA.HOT_RATED_CDR (MAP_ID,
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
                                             PAYMENT_ID)
            SELECT MAP_ID_SEQ.NEXTVAL,
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
              FROM HOT_RATED_CDR_3 A
             WHERE DATA_PART = i AND RERATE_FLAG = 13;

         DELETE HOT_RATED_CDR_3
          WHERE DATA_PART = i AND RERATE_FLAG = 13;

         COMMIT;

         INS_ACT_LOG (
            'VNP_DATA',
            'STUFF.MOVE_HRC_34_TO_HRC - HRC_3 - DATA_PART: ' || i,
            'DONE: STUFF.MOVE_HRC_34_TO_HRC - HRC_3 - DATA_PART: ' || i,
            0);
      END LOOP;

      --

      FOR i IN 0 .. 9
      LOOP
         INSERT INTO VNP_DATA.HOT_RATED_CDR (MAP_ID,
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
                                             PAYMENT_ID)
            SELECT MAP_ID_SEQ.NEXTVAL,
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
              FROM HOT_RATED_CDR_4 A
             WHERE DATA_PART = i AND RERATE_FLAG = 13;

         DELETE HOT_RATED_CDR_4
          WHERE DATA_PART = i AND RERATE_FLAG = 13;

         COMMIT;

         INS_ACT_LOG (
            'VNP_DATA',
            'STUFF.MOVE_HRC_34_TO_HRC - HRC_4 - DATA_PART: ' || i,
            'DONE: STUFF.MOVE_HRC_34_TO_HRC - HRC_4 - DATA_PART: ' || i,
            0);
      END LOOP;

      retcode := DBMS_LOCK.RELEASE (lockhandle);
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;

         v_err_msg :=
            SUBSTR (
               SQLERRM || CHR (10) || DBMS_UTILITY.format_error_backtrace,
               1,
               1023);

         INS_ACT_LOG ('VNP_DATA',
                      'STUFF.MOVE_HRC_34_TO_HRC',
                      'ERROR: ' || v_err_msg,
                      3);
   END;

   PROCEDURE MOVE_TEMP1_TO_1
   IS
      CURSOR AAA
      IS
           SELECT CDR_RECORD_HEADER_ID
             FROM (  SELECT CDR_RECORD_HEADER_ID, MIN (CREATED_TIME) CREATED_TIME
                       FROM VNP_DATA.HOT_RATED_CDR_TEMP1
                      WHERE RERATE_FLAG = 10
                   GROUP BY CDR_RECORD_HEADER_ID)
         ORDER BY CREATED_TIME;

      V_ERR_MSG   VARCHAR2 (1023);
      C1REC       AAA%ROWTYPE;
   BEGIN
      OPEN AAA;

      LOOP
         FETCH AAA INTO C1REC;

         EXIT WHEN AAA%NOTFOUND;

         INSERT INTO HOT_RATED_CDR_1
            SELECT *
              FROM HOT_RATED_CDR_TEMP1
             WHERE CDR_RECORD_HEADER_ID = C1REC.CDR_RECORD_HEADER_ID;

         DELETE HOT_RATED_CDR_TEMP1
          WHERE CDR_RECORD_HEADER_ID = C1REC.CDR_RECORD_HEADER_ID;

         COMMIT;
      END LOOP;

      CLOSE AAA;

      INS_ACT_LOG ('VNP_DATA',
                   'STUFF.MOVE_TEMP1_TO_1 FROM HRC_TEMP1',
                   'DONE: STUFF.MOVE_TEMP1_TO_1 FROM HRC_TEMP1',
                   0);
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;

         V_ERR_MSG :=
            SUBSTR (
               SQLERRM || CHR (10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
               1,
               1023);

         INS_ACT_LOG ('VNP_DATA',
                      'STUFF.MOVE_TEMP1_TO_1',
                      'ERROR: ' || V_ERR_MSG,
                      3);
   END;

   PROCEDURE MOVE_TEMP2_TO_2
   IS
      CURSOR BBB
      IS
           SELECT CDR_RECORD_HEADER_ID
             FROM (  SELECT CDR_RECORD_HEADER_ID, MIN (CREATED_TIME) CREATED_TIME
                       FROM VNP_DATA.HOT_RATED_CDR_TEMP2
                      WHERE RERATE_FLAG = 10
                   GROUP BY CDR_RECORD_HEADER_ID)
         ORDER BY CREATED_TIME;

      V_ERR_MSG   VARCHAR2 (1023);
      C1REC       BBB%ROWTYPE;
   BEGIN
      OPEN BBB;

      LOOP
         FETCH BBB INTO C1REC;

         EXIT WHEN BBB%NOTFOUND;

         INSERT INTO HOT_RATED_CDR_2
            SELECT *
              FROM HOT_RATED_CDR_TEMP2
             WHERE CDR_RECORD_HEADER_ID = C1REC.CDR_RECORD_HEADER_ID;

         DELETE HOT_RATED_CDR_TEMP2
          WHERE CDR_RECORD_HEADER_ID = C1REC.CDR_RECORD_HEADER_ID;

         COMMIT;
      END LOOP;

      CLOSE BBB;

      INS_ACT_LOG ('VNP_DATA',
                   'STUFF.MOVE_TEMP2_TO_2 FROM HRC_TEMP1',
                   'DONE: STUFF.MOVE_TEMP2_TO_2 FROM HRC_TEMP1',
                   0);
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;

         V_ERR_MSG :=
            SUBSTR (
               SQLERRM || CHR (10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE,
               1,
               1023);

         INS_ACT_LOG ('VNP_DATA',
                      'STUFF.MOVE_TEMP2_TO_2',
                      'ERROR: ' || V_ERR_MSG,
                      3);
   END;

   PROCEDURE AGGR_MOVE_TO_HOT
   IS
      /******************************************************************************
           NAME:       AGGR_MOVE_TO_HOT
           PURPOSE:

           REVISIONS:
           Ver        Date        Author           Description
           ---------  ----------  ---------------  ------------------------------------
           1.0        02/01/2014      manucian86       1. Created this procedure.
        ******************************************************************************/

      v_err_msg   VARCHAR2 (1023);
   BEGIN
      FOR i IN 0 .. 9
      LOOP
         MERGE INTO VNP_DATA.hot_aggregated_cdr ag
              USING (  SELECT COUNT (1) total_cdr,
                              a_number,
                              TO_NUMBER (
                                 SUBSTR (a_number, LENGTH (a_number), 1))
                                 data_part,
                              TO_CHAR ( (cdr_start_time), 'yyMM') bill_month,
                              cdr_type,
                              SUM (total_usage) AS total_usage,
                              SUM (service_fee) AS service_fee,
                              SUM (charge_fee) AS charge_fee,
                              SUM (offer_cost) AS offer_cost,
                              SUM (offer_free_block) AS offer_free_block,
                              SUM (internal_cost) AS internal_cost,
                              SUM (internal_free_block) internal_free_block,
                              SUM (INTL_VND) INTL_VND,
                              payment_id
                         FROM VNP_DATA.hot_rated_cdr_1
                        WHERE data_part = i AND rerate_flag = 0
                     --                           AND cdr_record_header_id = cdr_record_header_id
                     GROUP BY a_number,
                              cdr_type,
                              TO_CHAR ( (cdr_start_time), 'yyMM'),
                              payment_id) v
                 ON (    ag.data_part = i
                     AND ag.data_part = v.data_part
                     AND ag.a_number = v.a_number
                     AND ag.bill_month = v.bill_month
                     AND ag.cdr_type = v.cdr_type
                     AND ag.payment_id = v.payment_id)
         WHEN MATCHED
         THEN
            UPDATE SET
               ag.total_cdr = ag.total_cdr + NVL (v.total_cdr, 0),
               ag.total_usage = ag.total_usage + NVL (v.total_usage, 0),
               ag.service_fee = ag.service_fee + NVL (v.service_fee, 0),
               ag.charge_fee = ag.charge_fee + NVL (v.charge_fee, 0),
               ag.offer_cost = ag.offer_cost + NVL (v.offer_cost, 0),
               ag.offer_free_block =
                  ag.offer_free_block + NVL (v.offer_free_block, 0),
               ag.internal_cost = ag.internal_cost + NVL (v.internal_cost, 0),
               ag.internal_free_block =
                  ag.internal_free_block + NVL (v.internal_free_block, 0),
               ag.INTL_VND = ag.INTL_VND + NVL (v.INTL_VND, 0)
         WHEN NOT MATCHED
         THEN
            INSERT     (ag.a_number,
                        ag.data_part,
                        ag.cdr_type,
                        ag.total_cdr,
                        ag.bill_month,
                        ag.total_usage,
                        ag.service_fee,
                        ag.charge_fee,
                        ag.offer_cost,
                        ag.offer_free_block,
                        ag.internal_cost,
                        ag.internal_free_block,
                        ag.INTL_VND,
                        ag.payment_id)
                VALUES (v.a_number,
                        v.data_part,
                        v.cdr_type,
                        v.total_cdr,
                        v.bill_month,
                        v.total_usage,
                        v.service_fee,
                        v.charge_fee,
                        v.offer_cost,
                        v.offer_free_block,
                        v.internal_cost,
                        v.internal_free_block,
                        v.INTL_VND,
                        v.payment_id);

         UPDATE hot_rated_cdr_1
            SET rerate_flag = 13
          WHERE data_part = i AND rerate_flag = 0;

         COMMIT;

         INS_ACT_LOG (
            'VNP_DATA',
            'STUFF.AGGR_MOVE_TO_HOT -> AGGREGATE HRC_1; DATA_PART: ' || i,
               'DONE: STUFF.AGGR_MOVE_TO_HOT -> AGGREGATE HRC_1; DATA_PART: '
            || i,
            0);


         INSERT INTO VNP_DATA.HOT_RATED_CDR (MAP_ID,
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
                                             PAYMENT_ID,
                                             SUBSCRIBER_NO,
                                             SUBSCRIBER_NO_RESETS,
                                             ACCOUNT_NO,
                                             PARENT_ACCOUNT_NO,
                                             INTL_VND,
                                             INTL_ID,
                                             CDR_CALL_TYPE,
                                             QOS)
            SELECT MAP_ID_SEQ.NEXTVAL,
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
                   PAYMENT_ID,
                   SUBSCRIBER_NO,
                   SUBSCRIBER_NO_RESETS,
                   ACCOUNT_NO,
                   PARENT_ACCOUNT_NO,
                   INTL_VND,
                   INTL_ID,
                   CDR_CALL_TYPE,
                   QOS
              FROM HOT_RATED_CDR_1 A
             WHERE DATA_PART = i AND RERATE_FLAG = 13;

         DELETE HOT_RATED_CDR_1
          WHERE DATA_PART = i AND RERATE_FLAG = 13;

         COMMIT;

         INS_ACT_LOG (
            'VNP_DATA',
            'STUFF.AGGR_MOVE_TO_HOT -> MOVE HRC_1; DATA_PART: ' || i,
            'DONE: STUFF.AGGR_MOVE_TO_HOT -> MOVE HRC_1; DATA_PART: ' || i,
            0);
      END LOOP;

      INS_ACT_LOG ('VNP_DATA',
                   'STUFF.AGGR_MOVE_TO_HOT -> AGGREGATE, MOVE HRC_1',
                   'DONE: STUFF.AGGR_MOVE_TO_HOT -> AGGREGATE, MOVE HRC_1',
                   0);

      --

      FOR i IN 0 .. 9
      LOOP
         MERGE INTO VNP_DATA.hot_aggregated_cdr ag
              USING (  SELECT COUNT (1) total_cdr,
                              a_number,
                              TO_NUMBER (
                                 SUBSTR (a_number, LENGTH (a_number), 1))
                                 data_part,
                              TO_CHAR ( (cdr_start_time), 'yyMM') bill_month,
                              cdr_type,
                              SUM (total_usage) AS total_usage,
                              SUM (service_fee) AS service_fee,
                              SUM (charge_fee) AS charge_fee,
                              SUM (offer_cost) AS offer_cost,
                              SUM (offer_free_block) AS offer_free_block,
                              SUM (internal_cost) AS internal_cost,
                              SUM (internal_free_block) internal_free_block,
                              SUM (INTL_VND) INTL_VND,
                              payment_id
                         FROM VNP_DATA.hot_rated_cdr_2
                        WHERE data_part = i AND rerate_flag = 0
                     --                           AND cdr_record_header_id = cdr_record_header_id
                     GROUP BY a_number,
                              cdr_type,
                              TO_CHAR ( (cdr_start_time), 'yyMM'),
                              payment_id) v
                 ON (    ag.data_part = i
                     AND ag.data_part = v.data_part
                     AND ag.a_number = v.a_number
                     AND ag.bill_month = v.bill_month
                     AND ag.cdr_type = v.cdr_type
                     AND ag.payment_id = v.payment_id)
         WHEN MATCHED
         THEN
            UPDATE SET
               ag.total_cdr = ag.total_cdr + NVL (v.total_cdr, 0),
               ag.total_usage = ag.total_usage + NVL (v.total_usage, 0),
               ag.service_fee = ag.service_fee + NVL (v.service_fee, 0),
               ag.charge_fee = ag.charge_fee + NVL (v.charge_fee, 0),
               ag.offer_cost = ag.offer_cost + NVL (v.offer_cost, 0),
               ag.offer_free_block =
                  ag.offer_free_block + NVL (v.offer_free_block, 0),
               ag.internal_cost = ag.internal_cost + NVL (v.internal_cost, 0),
               ag.internal_free_block =
                  ag.internal_free_block + NVL (v.internal_free_block, 0),
               ag.INTL_VND = ag.INTL_VND + NVL (v.INTL_VND, 0)
         WHEN NOT MATCHED
         THEN
            INSERT     (ag.a_number,
                        ag.data_part,
                        ag.cdr_type,
                        ag.total_cdr,
                        ag.bill_month,
                        ag.total_usage,
                        ag.service_fee,
                        ag.charge_fee,
                        ag.offer_cost,
                        ag.offer_free_block,
                        ag.internal_cost,
                        ag.internal_free_block,
                        ag.INTL_VND,
                        ag.payment_id)
                VALUES (v.a_number,
                        v.data_part,
                        v.cdr_type,
                        v.total_cdr,
                        v.bill_month,
                        v.total_usage,
                        v.service_fee,
                        v.charge_fee,
                        v.offer_cost,
                        v.offer_free_block,
                        v.internal_cost,
                        v.internal_free_block,
                        v.INTL_VND,
                        v.payment_id);

         UPDATE hot_rated_cdr_2
            SET rerate_flag = 13
          WHERE data_part = i AND rerate_flag = 0;

         COMMIT;

         INS_ACT_LOG (
            'VNP_DATA',
            'STUFF.AGGR_MOVE_TO_HOT -> AGGREGATE HRC_2 - DATA_PART: ' || i,
               'DONE: STUFF.AGGR_MOVE_TO_HOT -> AGGREGATE HRC_2 - DATA_PART: '
            || i,
            0);

         INSERT INTO VNP_DATA.HOT_RATED_CDR (MAP_ID,
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
                                             PAYMENT_ID,
                                             SUBSCRIBER_NO,
                                             SUBSCRIBER_NO_RESETS,
                                             ACCOUNT_NO,
                                             PARENT_ACCOUNT_NO,
                                             INTL_VND,
                                             INTL_ID,
                                             CDR_CALL_TYPE,
                                             QOS)
            SELECT MAP_ID_SEQ.NEXTVAL,
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
                   PAYMENT_ID,
                   SUBSCRIBER_NO,
                   SUBSCRIBER_NO_RESETS,
                   ACCOUNT_NO,
                   PARENT_ACCOUNT_NO,
                   INTL_VND,
                   INTL_ID,
                   CDR_CALL_TYPE,
                   QOS
              FROM HOT_RATED_CDR_2 A
             WHERE DATA_PART = i AND RERATE_FLAG = 13;

         DELETE HOT_RATED_CDR_2
          WHERE DATA_PART = i AND RERATE_FLAG = 13;

         COMMIT;

         INS_ACT_LOG (
            'VNP_DATA',
            'STUFF.AGGR_MOVE_TO_HOT -> MOVE HRC_2; DATA_PART: ' || i,
            'DONE: STUFF.AGGR_MOVE_TO_HOT -> MOVE HRC_2; DATA_PART: ' || i,
            0);
      END LOOP;

      INS_ACT_LOG ('VNP_DATA',
                   'STUFF.AGGR_MOVE_TO_HOT -> AGGREGATE, MOVE HRC_2',
                   'DONE: STUFF.AGGR_MOVE_TO_HOT -> AGGREGATE, MOVE HRC_2',
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

         INS_ACT_LOG ('VNP_DATA',
                      'STUFF.AGGR_MOVE_TO_HOT',
                      'ERROR: ' || v_err_msg,
                      3);
   END;
END STUFF;
/
