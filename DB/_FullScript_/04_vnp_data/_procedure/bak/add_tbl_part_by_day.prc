DROP PROCEDURE VNP_DATA.ADD_TBL_PART_BY_DAY;

CREATE OR REPLACE PROCEDURE VNP_DATA.ADD_TBL_PART_BY_DAY (
   I_TABLE_NAME VARCHAR2)
IS
   /******************************************************************************
        NAME:       ADD_TBL_PART_BY_DAY
        PURPOSE:

        REVISIONS:
        Ver        Date        Author           Description
        ---------  ----------  ---------------  ------------------------------------
        1.0        02/01/2014      manucian86       1. Created this procedure.
     ******************************************************************************/

   v_err_msg                 VARCHAR2 (1023);
   v_max_part                VARCHAR2 (20);
   v_sql                     VARCHAR2 (500);

   d_date                    DATE;
   v_tmp1                    VARCHAR2 (31);
   v_tmp2                    VARCHAR2 (31);
   v_today_add_10            DATE;
   v_partition_name_format   VARCHAR2 (31) := 'yymmdd';
BEGIN
   v_today_add_10 := SYSDATE + 10;

   SELECT SUBSTR (MAX (a.partition_name), 2)
     INTO v_max_part
     FROM user_tab_partitions a
    WHERE table_name = I_TABLE_NAME;

   d_date := TO_DATE (v_max_part, v_partition_name_format);

   WHILE d_date < v_today_add_10
   LOOP
      SELECT TO_CHAR (d_date + 1, v_partition_name_format)
        INTO v_tmp1
        FROM DUAL;

      SELECT TO_CHAR (d_date + 2, 'dd/mm/yyyy') INTO v_tmp2 FROM DUAL;

      v_sql :=
            'alter table '
         || I_TABLE_NAME
         || ' add partition P'
         || v_tmp1
         || ' values less than (to_date('''
         || v_tmp2
         || ''', ''dd/mm/yyyy''))';

      FOR v_index IN 0 .. 9
      LOOP
         v_sql :=
               v_sql + '(SUBPARTITION P'
            || v_tmp1
            || '_'
            || v_index
            || ' VALUES LESS THAN ('
            || (v_index + 1)
            || '))';
      END LOOP;

      EXECUTE IMMEDIATE (v_sql);

      --      DBMS_OUTPUT.put_line (v_sql);

      d_date := d_date + 1;
   END LOOP;

   INS_ACT_LOG ('DATABASE',
                'ADD_TABLE_PARTITION_DAY: ' || I_TABLE_NAME,
                'DONE: ADD_TABLE_PARTITION_DAY: ' || I_TABLE_NAME,
                0);
EXCEPTION
   WHEN OTHERS
   THEN
      v_err_msg :=
         SUBSTR (SQLERRM || CHR (10) || DBMS_UTILITY.format_error_backtrace,
                 1,
                 1023);

      INS_ACT_LOG ('DATABASE',
                   'ADD_TABLE_PARTITION_DAY: ' || I_TABLE_NAME,
                   'ERROR: ' || v_err_msg,
                   3);
END;
/
