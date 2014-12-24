<<<<<<< HEAD
/* Formatted on 19/12/2014 16:21:12 (QP5 v5.227.12220.39754) */
DECLARE
   CURSOR CUR_VNP_0512
   IS
        SELECT *
          FROM VNP_VIEW.VNP_0512
      ORDER BY A_NUMBER, CDR_START_TIME;

   C1REC     CUR_VNP_0512%ROWTYPE;

   ORD_NUM   PLS_INTEGER;
   ANUM      VARCHAR2 (31);
BEGIN
   OPEN CUR_VNP_0512;

   SELECT 0 INTO ORD_NUM FROM DUAL;

   SELECT 'abc' INTO ANUM FROM DUAL;

   EXECUTE IMMEDIATE 'truncate table vnp_view.vnp_0512_tmp';

   LOOP
      FETCH CUR_VNP_0512 INTO C1REC;

      EXIT WHEN CUR_VNP_0512%NOTFOUND;

      IF C1REC.A_NUMBER = ANUM
      THEN
         SELECT ORD_NUM + 1 INTO ORD_NUM FROM DUAL;
      ELSE
         SELECT 1 INTO ORD_NUM FROM DUAL;
      END IF;

      SELECT C1REC.A_NUMBER INTO ANUM FROM DUAL;

      INSERT INTO VNP_0512_TMP (RECORD_ID,
                                A_NUMBER,
                                B_NUMBER,
                                CDR_START_TIME,
                                DURATION)
           VALUES (ORD_NUM,
                   C1REC.A_NUMBER,
                   C1REC.B_NUMBER,
                   C1REC.CDR_START_TIME,
                   C1REC.DURATION);
   END LOOP;

   CLOSE CUR_VNP_0512;
END;


DECLARE
   CURSOR CUR_ELC_0512
   IS
        SELECT *
          FROM VNP_VIEW.ELC_0512 a
         WHERE     a.DURATION > 0
               AND a.ROWID >
                      ANY (SELECT b.ROWID
                             FROM elc_0512 b
                            WHERE     a.a_number = b.a_number
                                  AND (   a.b_number = b.b_number
                                       OR (    a.b_number IS NULL
                                           AND b.b_number IS NULL))
                                  AND A.CDR_START_TIME = B.CDR_START_TIME
                                  AND A.duration = B.duration)
      ORDER BY A_NUMBER, CDR_START_TIME;

   C1REC     CUR_ELC_0512%ROWTYPE;

   ORD_NUM   PLS_INTEGER;
   ANUM      VARCHAR2 (31);
BEGIN
   OPEN CUR_ELC_0512;

   SELECT 0 INTO ORD_NUM FROM DUAL;

   SELECT 'abc' INTO ANUM FROM DUAL;

   EXECUTE IMMEDIATE 'truncate table vnp_view.elc_0512_tmp';

   LOOP
      FETCH CUR_ELC_0512 INTO C1REC;

      EXIT WHEN CUR_ELC_0512%NOTFOUND;

      IF C1REC.A_NUMBER = ANUM
      THEN
         SELECT ORD_NUM + 1 INTO ORD_NUM FROM DUAL;
      ELSE
         SELECT 1 INTO ORD_NUM FROM DUAL;
      END IF;

      SELECT C1REC.A_NUMBER INTO ANUM FROM DUAL;

      INSERT INTO ELC_0512_TMP (RECORD_ID,
                                A_NUMBER,
                                B_NUMBER,
                                CDR_START_TIME,
                                DURATION)
           VALUES (ORD_NUM,
                   C1REC.A_NUMBER,
                   C1REC.B_NUMBER,
                   C1REC.CDR_START_TIME,
                   C1REC.DURATION);
   END LOOP;

   CLOSE CUR_ELC_0512;
END;

DECLARE
   CURSOR CUR_VNP_0512_TMP
   IS
        SELECT *
          FROM VNP_VIEW.VNP_0512_TMP
      ORDER BY A_NUMBER, CDR_START_TIME;

   CURSOR CUR_TMP (ANUM VARCHAR2, RECID NUMBER)
   IS
      SELECT *
        FROM ELC_0512_TMP
       WHERE A_NUMBER = ANUM AND RECORD_ID = RECID;

   --      CURSOR cur_elc_0512_tmp
   --      IS
   --           SELECT *
   --             FROM vnp_view.elc_0512_tmp
   --         ORDER BY a_number, cdr_start_time;


   CUR_REC_VNP   CUR_VNP_0512_TMP%ROWTYPE;
   REC_TMP       CUR_TMP%ROWTYPE;
   --      cur_rec_elc   cur_elc_0512_tmp%ROWTYPE;

   --      ord_num       PLS_INTEGER;
   --      anum          VARCHAR2 (31);
   --
   --      plus_num      PLS_INTEGER;

   TMP_BNUM      VARCHAR2 (31);
BEGIN
   OPEN CUR_VNP_0512_TMP;

   --      OPEN cur_elc_0512_tmp;

   --      SELECT 0 INTO ord_num FROM DUAL;
   --
   --      SELECT 'abc' INTO anum FROM DUAL;
   --
   --      SELECT 0 INTO plus_num FROM DUAL;

   LOOP
      FETCH CUR_VNP_0512_TMP INTO CUR_REC_VNP;

      EXIT WHEN CUR_VNP_0512_TMP%NOTFOUND;

      --         SELECT 0 INTO tmp_num FROM DUAL;

      --         SELECT 1
      --           INTO tmp_num
      --           FROM elc_0512_tmp
      --          WHERE     a_number = cur_rec_vnp.a_number
      --                AND record_id = cur_rec_vnp.record_id
      --                AND b_number = cur_rec_vnp.b_number;

      OPEN CUR_TMP (CUR_REC_VNP.A_NUMBER, CUR_REC_VNP.RECORD_ID);

      FETCH CUR_TMP INTO REC_TMP;

      IF    CUR_REC_VNP.B_NUMBER IS NULL
         OR CUR_REC_VNP.B_NUMBER != REC_TMP.B_NUMBER
      THEN
         UPDATE ELC_0512_TMP
            SET RECORD_ID = RECORD_ID + 1
          WHERE     A_NUMBER = CUR_REC_VNP.A_NUMBER
                AND RECORD_ID >= CUR_REC_VNP.RECORD_ID;
      END IF;

      CLOSE CUR_TMP;
   --         LOOP
   --            FETCH cur_vnp_0512 INTO cur_rec_elc;
   --
   --            IF cur_rec_elc.b_number = cur_rec_vnp.b_number
   --            THEN
   --               EXIT;
   --            ELSE
   --               SELECT plus_num + 1 INTO plus_num FROM DUAL;
   --
   --               UPDATE elc_0512_tmp
   --                  SET record_id = record_id + plus_num
   --                WHERE     a_number = cur_rec_elc.a_number
   --                      AND record_id = cur_rec_elc.record_id;
   --            END IF;
   --         END LOOP;
   --
   --         EXIT WHEN cur_vnp_0512%NOTFOUND;
   END LOOP;

   CLOSE CUR_VNP_0512_TMP;

   COMMIT;
=======
/* Formatted on 20/12/2014 12:03:37 AM (QP5 v5.215.12089.38647) */
DECLARE
   CURSOR CUR_VNP_0512
   IS
        SELECT *
          FROM VNP_VIEW.VNP_0512
      ORDER BY A_NUMBER, CDR_START_TIME;

   C1REC     CUR_VNP_0512%ROWTYPE;

   ORD_NUM   PLS_INTEGER;
   ANUM      VARCHAR2 (31);
BEGIN
   OPEN CUR_VNP_0512;

   SELECT 0 INTO ORD_NUM FROM DUAL;

   SELECT 'abc' INTO ANUM FROM DUAL;

   EXECUTE IMMEDIATE 'truncate table vnp_view.vnp_0512_tmp';

   LOOP
      FETCH CUR_VNP_0512 INTO C1REC;

      EXIT WHEN CUR_VNP_0512%NOTFOUND;

      IF C1REC.A_NUMBER = ANUM
      THEN
         SELECT ORD_NUM + 1 INTO ORD_NUM FROM DUAL;
      ELSE
         SELECT 1 INTO ORD_NUM FROM DUAL;
      END IF;

      SELECT C1REC.A_NUMBER INTO ANUM FROM DUAL;

      INSERT INTO VNP_0512_TMP (RECORD_ID,
                                A_NUMBER,
                                B_NUMBER,
                                CDR_START_TIME,
                                DURATION)
           VALUES (ORD_NUM,
                   C1REC.A_NUMBER,
                   C1REC.B_NUMBER,
                   C1REC.CDR_START_TIME,
                   C1REC.DURATION);
   END LOOP;

   CLOSE CUR_VNP_0512;
END;


DECLARE
   CURSOR CUR_ELC_0512
   IS
        SELECT *
          FROM VNP_VIEW.ELC_0512
         WHERE     DURATION > 0
               AND ROWID IN (  SELECT MIN (ROWID)
                                 FROM VNP_VIEW.ELC_0512
                             GROUP BY a_number,
                                      b_number,
                                      cdr_start_time,
                                      duration)
      ORDER BY A_NUMBER, CDR_START_TIME;

   C1REC     CUR_ELC_0512%ROWTYPE;

   ORD_NUM   PLS_INTEGER;
   ANUM      VARCHAR2 (31);
BEGIN
   OPEN CUR_ELC_0512;

   SELECT 0 INTO ORD_NUM FROM DUAL;

   SELECT 'abc' INTO ANUM FROM DUAL;

   EXECUTE IMMEDIATE 'truncate table vnp_view.elc_0512_tmp';

   LOOP
      FETCH CUR_ELC_0512 INTO C1REC;

      EXIT WHEN CUR_ELC_0512%NOTFOUND;

      IF C1REC.A_NUMBER = ANUM
      THEN
         SELECT ORD_NUM + 1 INTO ORD_NUM FROM DUAL;
      ELSE
         SELECT 1 INTO ORD_NUM FROM DUAL;
      END IF;

      SELECT C1REC.A_NUMBER INTO ANUM FROM DUAL;

      INSERT INTO ELC_0512_TMP (RECORD_ID,
                                A_NUMBER,
                                B_NUMBER,
                                CDR_START_TIME,
                                DURATION)
           VALUES (ORD_NUM,
                   C1REC.A_NUMBER,
                   C1REC.B_NUMBER,
                   C1REC.CDR_START_TIME,
                   C1REC.DURATION);
   END LOOP;

   CLOSE CUR_ELC_0512;
END;

DECLARE
   CURSOR CUR_VNP_0512_TMP
   IS
        SELECT *
          FROM VNP_VIEW.VNP_0512_TMP
      ORDER BY A_NUMBER, CDR_START_TIME;

   CURSOR CUR_TMP (ANUM VARCHAR2, RECID NUMBER)
   IS
      SELECT *
        FROM ELC_0512_TMP
       WHERE A_NUMBER = ANUM AND RECORD_ID = RECID;

   --      CURSOR cur_elc_0512_tmp
   --      IS
   --           SELECT *
   --             FROM vnp_view.elc_0512_tmp
   --         ORDER BY a_number, cdr_start_time;


   CUR_REC_VNP   CUR_VNP_0512_TMP%ROWTYPE;
   REC_TMP       CUR_TMP%ROWTYPE;
   --      cur_rec_elc   cur_elc_0512_tmp%ROWTYPE;

   --      ord_num       PLS_INTEGER;
   --      anum          VARCHAR2 (31);
   --
   --      plus_num      PLS_INTEGER;

   TMP_BNUM      VARCHAR2 (31);
BEGIN
   OPEN CUR_VNP_0512_TMP;

   --      OPEN cur_elc_0512_tmp;

   --      SELECT 0 INTO ord_num FROM DUAL;
   --
   --      SELECT 'abc' INTO anum FROM DUAL;
   --
   --      SELECT 0 INTO plus_num FROM DUAL;

   LOOP
      FETCH CUR_VNP_0512_TMP INTO CUR_REC_VNP;

      EXIT WHEN CUR_VNP_0512_TMP%NOTFOUND;

      --         SELECT 0 INTO tmp_num FROM DUAL;

      --         SELECT 1
      --           INTO tmp_num
      --           FROM elc_0512_tmp
      --          WHERE     a_number = cur_rec_vnp.a_number
      --                AND record_id = cur_rec_vnp.record_id
      --                AND b_number = cur_rec_vnp.b_number;

      OPEN CUR_TMP (CUR_REC_VNP.A_NUMBER, CUR_REC_VNP.RECORD_ID);

      FETCH CUR_TMP INTO REC_TMP;

      IF    CUR_REC_VNP.B_NUMBER IS NULL
         OR CUR_REC_VNP.B_NUMBER != REC_TMP.B_NUMBER
      THEN
         UPDATE ELC_0512_TMP
            SET RECORD_ID = RECORD_ID + 1
          WHERE     A_NUMBER = CUR_REC_VNP.A_NUMBER
                AND RECORD_ID >= CUR_REC_VNP.RECORD_ID;
      END IF;

      CLOSE CUR_TMP;
   --         LOOP
   --            FETCH cur_vnp_0512 INTO cur_rec_elc;
   --
   --            IF cur_rec_elc.b_number = cur_rec_vnp.b_number
   --            THEN
   --               EXIT;
   --            ELSE
   --               SELECT plus_num + 1 INTO plus_num FROM DUAL;
   --
   --               UPDATE elc_0512_tmp
   --                  SET record_id = record_id + plus_num
   --                WHERE     a_number = cur_rec_elc.a_number
   --                      AND record_id = cur_rec_elc.record_id;
   --            END IF;
   --         END LOOP;
   --
   --         EXIT WHEN cur_vnp_0512%NOTFOUND;
   END LOOP;

   CLOSE CUR_VNP_0512_TMP;

   COMMIT;
>>>>>>> a99a9ae55538d7e20a97b9b1b56f818ceb06300d
END;