/* Formatted on 15/12/2014 4:24:02 PM (QP5 v5.215.12089.38647) */
-------------------------------------------------------------
--So luong file tung SLU

  SELECT '5/12/2014' dates, HOST_NAME, COUNT (1) Soluong
    FROM VNP_DATA.CDR_RECORD_HEADER
   WHERE TRUNC (TO_DATE (FILE_LASTUPDATE_TIMESTAMP, 'MM/DD/YYYY HH24:MI:SS')) =
            TO_DATE ('05/12/2014', 'DD/MM/YYYY')
GROUP BY host_name;


SELECT HOST_NAME, SUBSTR (CDR_FILENAME, 6)
  FROM VNP_DATA.CDR_RECORD_HEADER
 WHERE TRUNC (TO_DATE (FILE_LASTUPDATE_TIMESTAMP, 'MM/DD/YYYY HH24:MI:SS')) =
          TO_DATE ('05/12/2014', 'DD/MM/YYYY');

--Chi tiet CDR tung file

SELECT t.*, f.*
  FROM VNP_DATA.HOT_RATED_CDR f,
       (SELECT CDR_RECORD_HEADER_ID,
               SUBSTR (CDR_FILENAME, 6) filename,
               NUMBER_OF_RECORD,
               START_RCD_SEQ,
               END_RCD_SEQ
          FROM VNP_DATA.CDR_RECORD_HEADER
         WHERE TRUNC (
                  TO_DATE (FILE_LASTUPDATE_TIMESTAMP,
                           'MM/DD/YYYY HH24:MI:SS')) =
                  TO_DATE ('05/12/2014', 'DD/MM/YYYY')) t
 WHERE F.CDR_RECORD_HEADER_ID = T.CDR_RECORD_HEADER_ID;

--So sanh so luong CDR

  SELECT t.CDR_RECORD_HEADER_ID,
         filename,
         NUMBER_OF_RECORD,
         START_RCD_SEQ,
         END_RCD_SEQ,
         COUNT (1) NUMBER_CDR_REFORMAT
    FROM VNP_DATA.HOT_RATED_CDR f,
         (SELECT CDR_RECORD_HEADER_ID,
                 SUBSTR (CDR_FILENAME, 6) filename,
                 NUMBER_OF_RECORD,
                 START_RCD_SEQ,
                 END_RCD_SEQ
            FROM VNP_DATA.CDR_RECORD_HEADER
           WHERE TRUNC (
                    TO_DATE (FILE_LASTUPDATE_TIMESTAMP,
                             'MM/DD/YYYY HH24:MI:SS')) =
                    TO_DATE ('05/12/2014', 'DD/MM/YYYY')) t
   WHERE F.CDR_RECORD_HEADER_ID = T.CDR_RECORD_HEADER_ID
GROUP BY t.CDR_RECORD_HEADER_ID,
         filename,
         NUMBER_OF_RECORD,
         START_RCD_SEQ,
         END_RCD_SEQ;

-------------------------------------------------------------
--1. Chuan hoa B_number ELC
--1.1 update b_number= dial_digit

SELECT * FROM vnp_view.elc_0412;

SELECT *
  FROM VNP_VIEW.ELC_0412
 WHERE REGEXP_LIKE (B_NUMBER, '[[:alpha:]]');

--update VNP_VIEW.ELC_0412 set b_number=REGEXP_REPLACE(DIAL_DIGIT ,'84(.*)','\1') where REGEXP_LIKE(B_NUMBER, '[[:alpha:]]');
--loc cac cuoc co B_NUMBER bat dau = #

SELECT *
  FROM VNP_VIEW.ELC_0412
 WHERE b_number LIKE '#%';

SELECT *
  FROM VNP_VIEW.ELC_0412
 WHERE REGEXP_LIKE (b_number, '^0.*');

UPDATE VNP_VIEW.ELC_0412
   SET b_number = REGEXP_REPLACE (b_number, '^0(.*)', '\1');

--delete VNP_VIEW.ELC_0412 where b_number like '#%';--157
--1.2 Luu y lay  total_usage doi voi dich vu SMS, MMS online doi soat voi Comverse

SELECT *
  FROM VNP_VIEW.ELC_0412
 WHERE host_name LIKE 'slu%' AND duration = 0;

--update VNP_VIEW.ELC_0412 set DURATION=1 where host_name like 'slu%' and duration=0

SELECT *
  FROM VNP_VIEW.ELC_0412
 WHERE host_name LIKE 'slu%';

--1.3 Chuan hoa du lieu Comverse

SELECT * FROM VNP_VIEW.COMVERS_0412;

SELECT *
  FROM VNP_VIEW.COMVERS_0412
 WHERE LENGTH (b_number) < 7 AND b_number LIKE '84%';

--Loc du lieu co dau 84, cat bo 86

SELECT *
  FROM VNP_VIEW.COMVERS_0412
 WHERE REGEXP_LIKE (B_number, '^84(.*)');

--update VNP_VIEW.COMVERS_0412 set b_number=REGEXP_REPLACE(B_number ,'^84(.*)','\1')

--1.4 move khoi du lieu so B-number start #

SELECT *
  FROM VNP_VIEW.COMVERS_0412
 WHERE REGEXP_LIKE (b_number, '^#');

--delete VNP_VIEW.COMVERS_0412 where  REGEXP_LIKE (b_number,'^#')--15

--1.5 Kiem tra cuoc trung lap cua Comverse

  SELECT *
    FROM VNP_VIEW.COMVERS_0412
   WHERE    A_NUMBER
         || B_NUMBER
         ||   (CDR_START_TIME - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
            * 24
            * 60
            * 60
         || Duration IN
            (  SELECT SEE_STR
                 FROM (SELECT    A2.A_NUMBER
                              || A2.B_NUMBER
                              ||   (  a2.CDR_START_TIME
                                    - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
                                 * 24
                                 * 60
                                 * 60
                              || a2.Duration
                                 SEE_STR
                         FROM VNP_VIEW.COMVERS_0412 A2)
             GROUP BY SEE_STR
               HAVING COUNT (*) > 1)
ORDER BY A_NUMBER, b_number, CDR_START_TIME;

--1.6 Kiem tra cuoc trung lap ELCOM

SELECT *
  FROM VNP_VIEW.ELC_0412
 WHERE     host_name LIKE 'slu%'
       AND    A_NUMBER
           || B_NUMBER
           ||   (CDR_START_TIME - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
              * 24
              * 60
              * 60
           || Duration IN
              (  SELECT SEE_STR
                   FROM (SELECT    A2.A_NUMBER
                                || A2.B_NUMBER
                                ||   (  a2.CDR_START_TIME
                                      - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
                                   * 24
                                   * 60
                                   * 60
                                || a2.Duration
                                   SEE_STR
                           FROM VNP_VIEW.ELC_0412 A2
                          WHERE host_name LIKE 'slu%')
               GROUP BY SEE_STR
                 HAVING COUNT (*) > 1);


--2. So sanh so cuoc lech giua ELCOM vs Comverse

SELECT *
  FROM VNP_VIEW.ELC_0412
 WHERE host_name LIKE 'slu%';                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               --21714

SELECT COUNT (*) FROM VNP_VIEW.ELC_0412;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        --

SELECT * FROM VNP_VIEW.ELC_0412;

SELECT COUNT (*)
  FROM VNP_VIEW.ELC_0412
 WHERE HOST_NAME LIKE 'slu%';                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          --29453

SELECT COUNT (*) FROM VNP_VIEW.COMVERS_0412;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    --29895

SELECT * FROM VNP_VIEW.COMVERS_0412;

-- @NGUYENTH: CDR_START_TIME: LAY MIN, MAX TRONG NGAY 04/12/2014

SELECT MIN (CDR_START_TIME), MAX (CDR_START_TIME) FROM ELC_0412;

SELECT MIN (COMVERS_0412.CDR_START_TIME), MAX (COMVERS_0412.CDR_START_TIME)
  FROM COMVERS_0412;

--3. Cuoc lech giua 2 ben ELCOM vs COMVERSE
--3.1 Co trong ELC nhung khong co trong Comverse --3755

SELECT    A1.A_NUMBER
       || A1.B_NUMBER
       ||   (a1.CDR_START_TIME - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
          * 24
          * 60
          * 60
       || a1.Duration
  FROM VNP_VIEW.ELC_0412 A1
MINUS
SELECT    A2.A_NUMBER
       || A2.B_NUMBER
       ||   (a2.CDR_START_TIME - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
          * 24
          * 60
          * 60
       || a2.Duration
  FROM VNP_VIEW.COMVERS_0412 A2;

-- @NGUYENTH:CDR RECORD: ELCOM CO, COMVERSE KHONG CO
-- SO CHU: 3676

SELECT COUNT (1)
  FROM (SELECT E.A_NUMBER,
               E.B_NUMBER,
                 (E.CDR_START_TIME - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
               * 24
               * 60
               * 60
                  AS CDR_START_TIME,
               E.DURATION
          FROM VNP_VIEW.ELC_0412 E
        MINUS
        SELECT C.A_NUMBER,
               C.B_NUMBER,
                 (C.CDR_START_TIME - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
               * 24
               * 60
               * 60
                  AS CDR_START_TIME,
               C.DURATION
          FROM VNP_VIEW.COMVERS_0412 C);

--Co trong Comverse nhung khong co trong ELC--4200

SELECT    A1.A_NUMBER
       || A1.B_NUMBER
       ||   (a1.CDR_START_TIME - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
          * 24
          * 60
          * 60
       || a1.Duration
  FROM VNP_VIEW.COMVERS_0412 A1
MINUS
SELECT    A2.A_NUMBER
       || A2.B_NUMBER
       ||   (a2.CDR_START_TIME - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
          * 24
          * 60
          * 60
       || a2.Duration
  FROM VNP_VIEW.ELC_0412 A2
 WHERE host_name LIKE 'slu%';

-- @NGUYENTH:CDR RECORD: COMVERSE CO, ELCOM KHONG CO
-- SO CHU: 4121

SELECT COUNT (*)
  FROM (SELECT C.A_NUMBER,
               C.B_NUMBER,
                 (C.CDR_START_TIME - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
               * 24
               * 60
               * 60
                  AS CDR_START_TIME,
               C.DURATION
          FROM VNP_VIEW.COMVERS_0412 C
        MINUS
        SELECT E.A_NUMBER,
               E.B_NUMBER,
                 (E.CDR_START_TIME - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
               * 24
               * 60
               * 60
                  AS CDR_START_TIME,
               E.DURATION
          FROM VNP_VIEW.ELC_0412 E);

--
--Chi tiet cuoc lech

SELECT *
  FROM VNP_VIEW.ELC_0412 a1
 WHERE        A1.A_NUMBER
           || A1.B_NUMBER
           ||   (a1.CDR_START_TIME - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
              * 24
              * 60
              * 60
           || a1.Duration IN
              (SELECT    A1.A_NUMBER
                      || A1.B_NUMBER
                      ||   (  a1.CDR_START_TIME
                            - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
                         * 24
                         * 60
                         * 60
                      || a1.Duration
                 FROM VNP_VIEW.ELC_0412 A1
                WHERE host_name LIKE 'slu%'
               MINUS
               SELECT    A2.A_NUMBER
                      || A2.B_NUMBER
                      ||   (  a2.CDR_START_TIME
                            - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
                         * 24
                         * 60
                         * 60
                      || a2.Duration
                 FROM VNP_VIEW.COMVERS_0412 A2)
       AND host_name LIKE 'slu%';

-- @NGUYENTH: CUOC LECH: ELCOM CO, COMVERSE KHONG CO

CREATE TABLE DEVIATION_E_C_0412
AS
   SELECT E1.*
     FROM    VNP_VIEW.ELC_0412 E1
          INNER JOIN
             (SELECT E.A_NUMBER,
                     E.B_NUMBER,
                       (  E.CDR_START_TIME
                        - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
                     * 24
                     * 60
                     * 60
                        AS CDR_START_TIME,
                     E.DURATION
                FROM VNP_VIEW.ELC_0412 E
              MINUS
              SELECT C.A_NUMBER,
                     C.B_NUMBER,
                       (  C.CDR_START_TIME
                        - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
                     * 24
                     * 60
                     * 60
                        AS CDR_START_TIME,
                     C.DURATION
                FROM VNP_VIEW.COMVERS_0412 C) T
          ON (    E1.A_NUMBER = T.A_NUMBER
              AND E1.B_NUMBER = T.B_NUMBER
              AND   (E1.CDR_START_TIME - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
                  * 24
                  * 60
                  * 60 = T.CDR_START_TIME
              AND E1.DURATION = T.DURATION);

--
--3889
--Kiem tra CDR tren file goc


--3.2 Co trong Comverse nhung khong co ELC -- 3281

SELECT *
  FROM VNP_VIEW.COMVERS_0412 a1
 WHERE    A1.A_NUMBER
       || A1.B_NUMBER
       ||   (a1.CDR_START_TIME - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
          * 24
          * 60
          * 60
       || a1.Duration IN
          (SELECT    A2.A_NUMBER
                  || A2.B_NUMBER
                  ||   (  a2.CDR_START_TIME
                        - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
                     * 24
                     * 60
                     * 60
                  || a2.Duration
             FROM VNP_VIEW.COMVERS_0412 A2
           MINUS
           SELECT    A1.A_NUMBER
                  || A1.B_NUMBER
                  ||   (  a1.CDR_START_TIME
                        - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
                     * 24
                     * 60
                     * 60
                  || a1.Duration
             FROM VNP_VIEW.ELC_0412 A1
            WHERE host_name LIKE 'slu%');

-- @NGUYENTH: CUOC LECH: COMVERSE CO, ELCOM KHONG CO

--CREATE TABLE DEVIATION_C_E_0412
--AS

INSERT INTO DEVIATION_C_E_0412 (A_NUMBER,
                                B_NUMBER,
                                CDR_START_TIME,
                                DURATION)
   SELECT C1.A_NUMBER,
          C1.B_NUMBER,
          C1.CDR_START_TIME,
          C1.DURATION
     FROM    COMVERS_0412 C1
          INNER JOIN
             (SELECT C.A_NUMBER,
                     C.B_NUMBER,
                       (  C.CDR_START_TIME
                        - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
                     * 24
                     * 60
                     * 60
                        AS CDR_START_TIME,
                     C.DURATION
                FROM VNP_VIEW.COMVERS_0412 C
              MINUS
              SELECT E.A_NUMBER,
                     E.B_NUMBER,
                       (  E.CDR_START_TIME
                        - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
                     * 24
                     * 60
                     * 60
                        AS CDR_START_TIME,
                     E.DURATION
                FROM VNP_VIEW.ELC_0412 E) T
          ON (    C1.A_NUMBER = T.A_NUMBER
              AND C1.B_NUMBER = T.B_NUMBER
              AND   (C1.CDR_START_TIME - TO_DATE ('01/01/1970', 'DD/MM/YYYY'))
                  * 24
                  * 60
                  * 60 = T.CDR_START_TIME
              AND C1.DURATION = T.DURATION);

--T?o b?ng l?ch Co trong Comverse nhung khong co trong ELC--3281

CREATE TABLE VNP_VIEW.LECH_COMVERSE_ELCOM_0412_01
AS
   SELECT A1.A_NUMBER,
          A1.B_NUMBER,
          a1.CDR_START_TIME,
          a1.Duration
     FROM VNP_VIEW.COMVERS_0412 A1
   MINUS
   SELECT A2.A_NUMBER,
          A2.B_NUMBER,
          a2.CDR_START_TIME,
          a2.Duration
     FROM VNP_VIEW.ELC_0412 A2
    WHERE A2.host_name LIKE 'slu%';

CREATE TABLE VNP_VIEW.LECH_ELCOM_COMVERSE_0412
AS
   SELECT A1.A_NUMBER,
          A1.B_NUMBER,
          a1.CDR_START_TIME,
          a1.Duration
     FROM VNP_VIEW.ELC_0412 A1
   MINUS
   SELECT A2.A_NUMBER,
          A2.B_NUMBER,
          a2.CDR_START_TIME,
          a2.Duration
     FROM VNP_VIEW.COMVERS_0412 A2;

--T?o b?ng l?ch Co trong Comverse nhung khong co trong ELC--3281

SELECT *
  FROM COMVERS_0412
 WHERE a_number = '84913886058' AND b_number = '932802325';

SELECT *
  FROM vnp_data.hot_rated_cdr
 WHERE a_number = '84913886058' AND b_number LIKE '%932802325';


SELECT * FROM vnp_ELCOM_0412;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                -- tìm cu?c l?ch bên elcom có comverse không có

SELECT A1.A_NUMBER, A1.B_NUMBER, a1.Duration
  FROM VNP_VIEW.LECH_ELCOM_COMVERSE_0412 A1
MINUS
SELECT A2.A_NUMBER, A2.B_NUMBER, a2.Duration
  FROM VNP_VIEW.LECH_COMVERSE_ELCOM_0412_01 A2;

SELECT A1.A_NUMBER, A1.B_NUMBER, a1.Duration
  FROM VNP_VIEW.LECH_COMVERSE_ELCOM_0412_01 A1
MINUS
SELECT A2.A_NUMBER, A2.B_NUMBER, a2.Duration
  FROM VNP_VIEW.LECH_ELCOM_COMVERSE_0412 A2;

-- @NGUYENTH: LOC TRUNG EC & CE THEO A_NUMBER, B_NUMBER, DURATION

SELECT COUNT (1)
  FROM (SELECT EC.A_NUMBER,
               EC.B_NUMBER,
               EC.CDR_START_TIME EC_START_TIME,
               CE.CDR_START_TIME CE_START_TIME
          FROM    DEVIATION_E_C_0412 EC
               INNER JOIN
                  DEVIATION_C_E_0412 CE
               ON (    EC.A_NUMBER = CE.A_NUMBER
                   AND EC.B_NUMBER = CE.B_NUMBER
                   AND EC.DURATION = CE.DURATION));

SELECT COUNT (1)
  FROM DEVIATION_E_C_0412 EC;

SELECT COUNT (1)
  FROM DEVIATION_C_E_0412 CE;

SELECT COUNT (1)
  FROM    DEVIATION_E_C_0412 EC
       INNER JOIN
          DEVIATION_C_E_0412 CE
       ON (    EC.A_NUMBER = CE.A_NUMBER
           AND EC.B_NUMBER = CE.B_NUMBER
           AND EC.DURATION = CE.DURATION);