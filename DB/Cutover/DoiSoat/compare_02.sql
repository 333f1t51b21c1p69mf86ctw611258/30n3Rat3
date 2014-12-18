/* Formatted on 16/12/2014 4:47:29 PM (QP5 v5.215.12089.38647) */
DECLARE
   CURSOR cur_vnp_0412
   IS
        SELECT *
          FROM vnp_view.vnp_0412
      ORDER BY a_number, cdr_start_time;

   c1rec     cur_vnp_0412%ROWTYPE;

   ord_num   PLS_INTEGER;
   anum      VARCHAR2 (31);
BEGIN
   OPEN cur_vnp_0412;

   SELECT 0 INTO ord_num FROM DUAL;

   SELECT 'abc' INTO anum FROM DUAL;

   EXECUTE IMMEDIATE 'truncate table vnp_view.vnp_0412_tmp';

   LOOP
      FETCH cur_vnp_0412 INTO c1rec;

      EXIT WHEN cur_vnp_0412%NOTFOUND;

      IF c1rec.a_number = anum
      THEN
         SELECT ord_num + 1 INTO ord_num FROM DUAL;
      ELSE
         SELECT 1 INTO ord_num FROM DUAL;
      END IF;

      SELECT c1rec.a_number INTO anum FROM DUAL;

      INSERT INTO vnp_0412_tmp (record_id,
                                a_number,
                                b_number,
                                cdr_start_time,
                                duration)
           VALUES (ord_num,
                   c1rec.a_number,
                   c1rec.b_number,
                   c1rec.cdr_start_time,
                   c1rec.duration);
   END LOOP;

   CLOSE cur_vnp_0412;
END;


DECLARE
   CURSOR cur_elc_0412
   IS
        SELECT *
          FROM vnp_view.elc_0412
      ORDER BY a_number, cdr_start_time;

   c1rec     cur_elc_0412%ROWTYPE;

   ord_num   PLS_INTEGER;
   anum      VARCHAR2 (31);
BEGIN
   OPEN cur_elc_0412;

   SELECT 0 INTO ord_num FROM DUAL;

   SELECT 'abc' INTO anum FROM DUAL;

   EXECUTE IMMEDIATE 'truncate table vnp_view.elc_0412_tmp';

   LOOP
      FETCH cur_elc_0412 INTO c1rec;

      EXIT WHEN cur_elc_0412%NOTFOUND;

      IF c1rec.a_number = anum
      THEN
         SELECT ord_num + 1 INTO ord_num FROM DUAL;
      ELSE
         SELECT 1 INTO ord_num FROM DUAL;
      END IF;

      SELECT c1rec.a_number INTO anum FROM DUAL;

      INSERT INTO elc_0412_tmp (record_id,
                                a_number,
                                b_number,
                                cdr_start_time,
                                duration)
           VALUES (ord_num,
                   c1rec.a_number,
                   c1rec.b_number,
                   c1rec.cdr_start_time,
                   c1rec.duration);
   END LOOP;

   CLOSE cur_elc_0412;
END;

DECLARE
   CURSOR cur_vnp_0412_tmp
   IS
        SELECT *
          FROM vnp_view.vnp_0412_tmp
      ORDER BY a_number, cdr_start_time;

   CURSOR cur_tmp (anum VARCHAR2, recid NUMBER)
   IS
      SELECT *
        FROM elc_0412_tmp
       WHERE a_number = anum AND record_id = recid;

   --      CURSOR cur_elc_0412_tmp
   --      IS
   --           SELECT *
   --             FROM vnp_view.elc_0412_tmp
   --         ORDER BY a_number, cdr_start_time;


   cur_rec_vnp   cur_vnp_0412_tmp%ROWTYPE;
   rec_tmp       cur_tmp%ROWTYPE;
   --      cur_rec_elc   cur_elc_0412_tmp%ROWTYPE;

   --      ord_num       PLS_INTEGER;
   --      anum          VARCHAR2 (31);
   --
   --      plus_num      PLS_INTEGER;

   tmp_bnum      VARCHAR2 (31);
BEGIN
   OPEN cur_vnp_0412_tmp;

   --      OPEN cur_elc_0412_tmp;

   --      SELECT 0 INTO ord_num FROM DUAL;
   --
   --      SELECT 'abc' INTO anum FROM DUAL;
   --
   --      SELECT 0 INTO plus_num FROM DUAL;

   LOOP
      FETCH cur_vnp_0412_tmp INTO cur_rec_vnp;

      EXIT WHEN cur_vnp_0412_tmp%NOTFOUND;

      --         SELECT 0 INTO tmp_num FROM DUAL;

      --         SELECT 1
      --           INTO tmp_num
      --           FROM elc_0412_tmp
      --          WHERE     a_number = cur_rec_vnp.a_number
      --                AND record_id = cur_rec_vnp.record_id
      --                AND b_number = cur_rec_vnp.b_number;

      OPEN cur_tmp (cur_rec_vnp.a_number, cur_rec_vnp.record_id);

      FETCH cur_tmp INTO rec_tmp;

      IF    cur_rec_vnp.b_number IS NULL
         OR cur_rec_vnp.b_number != rec_tmp.b_number
      THEN
         UPDATE elc_0412_tmp
            SET record_id = record_id + 1
          WHERE     a_number = cur_rec_vnp.a_number
                AND record_id >= cur_rec_vnp.record_id;
      END IF;

      CLOSE cur_tmp;
   --         LOOP
   --            FETCH cur_vnp_0412 INTO cur_rec_elc;
   --
   --            IF cur_rec_elc.b_number = cur_rec_vnp.b_number
   --            THEN
   --               EXIT;
   --            ELSE
   --               SELECT plus_num + 1 INTO plus_num FROM DUAL;
   --
   --               UPDATE elc_0412_tmp
   --                  SET record_id = record_id + plus_num
   --                WHERE     a_number = cur_rec_elc.a_number
   --                      AND record_id = cur_rec_elc.record_id;
   --            END IF;
   --         END LOOP;
   --
   --         EXIT WHEN cur_vnp_0412%NOTFOUND;
   END LOOP;

   CLOSE cur_vnp_0412_tmp;

   COMMIT;
END;