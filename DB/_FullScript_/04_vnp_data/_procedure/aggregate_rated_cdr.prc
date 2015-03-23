DROP PROCEDURE VNP_DATA.AGGREGATE_RATED_CDR;

CREATE OR REPLACE PROCEDURE VNP_DATA.AGGREGATE_RATED_CDR
IS
   /******************************************************************************
        NAME:       AGGREGATE_RATED_CDR
        PURPOSE:

        REVISIONS:
        Ver        Date        Author           Description
        ---------  ----------  ---------------  ------------------------------------
        1.0        12/03/2015      manucian86       1. Created this procedure.
     ******************************************************************************/

   TYPE t_ref_cursor IS REF CURSOR;

   v_err_msg      VARCHAR2 (1023);

   lockhandle     VARCHAR2 (128);
   retcode        NUMBER;

   CURSOR aaa (
      START_DATE    VARCHAR2,
      END_DATE      VARCHAR2)
   IS
          SELECT TO_DATE (START_DATE, 'DD/MM/YYYY') + LEVEL - 1 ddate
            FROM DUAL
      CONNECT BY LEVEL <=
                      TO_DATE (END_DATE, 'DD/MM/YYYY')
                    - TO_DATE (START_DATE, 'DD/MM/YYYY');

   c1rec          aaa%ROWTYPE;

   s_month        VARCHAR2 (15);
   s_start_date   VARCHAR2 (15);
   s_end_date     VARCHAR2 (15);
   d_date_tmp     DATE;

   n_day          NUMBER (2);
BEGIN
   DBMS_LOCK.ALLOCATE_UNIQUE ('AGGREGATE_RATED_CDR', lockhandle);

   retcode :=
      DBMS_LOCK.REQUEST (lockhandle,
                         timeout    => 0,
                         lockmode   => DBMS_LOCK.x_mode);

   IF retcode <> 0
   THEN
      raise_application_error (-20000,
                               'AGGREGATE_RATED_CDR is already running');
   END IF;

   SELECT cfg_value
     INTO s_month
     FROM config
    WHERE     cfg_group = 'COOL_AGGREGATED_CDR'
          AND cfg_name = 'AGGR_MONTH'
          AND ROWNUM <= 1;

   SELECT TO_DATE (s_month, 'yyMM') INTO d_date_tmp FROM DUAL;

   SELECT TO_CHAR (d_date_tmp, 'dd/MM/yyyy') INTO s_start_date FROM DUAL;

   SELECT TO_CHAR (ADD_MONTHS (d_date_tmp, 1), 'dd/MM/yyyy')
     INTO s_end_date
     FROM DUAL;

   OPEN aaa (s_start_date, s_end_date);

   LOOP
      FETCH aaa INTO c1rec;

      EXIT WHEN aaa%NOTFOUND;

      -- chi tong hop cac ngay truoc ngay sysdate thoi
      IF c1rec.ddate < TRUNC (SYSDATE)
      THEN
         SELECT TO_NUMBER (TO_CHAR (c1rec.ddate, 'dd')) INTO n_day FROM DUAL;

         FOR i IN 0 .. 9
         LOOP
            UPDATE vnp_data.subs_rerate_ctl
               SET status = 1
             WHERE     TO_NUMBER (SUBSTR (msisdn, -1, LENGTH (msisdn))) = i
                   AND month = s_month
                   AND aggred_day = n_day - 1;

            MERGE INTO VNP_DATA.cool_aggregated_cdr ag
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
                            FROM VNP_DATA.rated_cdr
                           WHERE     TRUNC (cdr_start_time) = c1rec.ddate
                                 AND data_part = i
                                 AND a_number IN --- NOTE: NEN DAY RA BANG TAM
                                                (SELECT msisdn
                                                   FROM subs_rerate_ctl
                                                  WHERE status = 1)
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

            UPDATE subs_rerate_ctl
               SET aggred_day = aggred_day + 1, status = 2
             WHERE status = 1;

            COMMIT;
         END LOOP;

         INS_ACT_LOG (
            'VNP_DATA',
            'STUFF.AGGREGATE_RATED_CDR',
               'DONE: STUFF.AGGREGATE_RATED_CDR - AGGREGATED DAY: '
            || TO_CHAR (c1rec.ddate, 'yyyy-mm-dd'),
            0);
      END IF;
   END LOOP;

   CLOSE aaa;

   retcode := DBMS_LOCK.RELEASE (lockhandle);
EXCEPTION
   WHEN OTHERS
   THEN
      ROLLBACK;

      v_err_msg :=
         SUBSTR (SQLERRM || CHR (10) || DBMS_UTILITY.format_error_backtrace,
                 1,
                 1023);

      INS_ACT_LOG ('VNP_DATA',
                   'STUFF.AGGREGATE_RATED_CDR',
                   'ERROR: ' || v_err_msg,
                   3);

      retcode := DBMS_LOCK.RELEASE (lockhandle);
END;
/
