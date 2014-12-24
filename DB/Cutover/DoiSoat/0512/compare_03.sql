/* Formatted on 20/12/2014 12:40:36 AM (QP5 v5.215.12089.38647) */
  SELECT *
    FROM VNP_0512_TMP
ORDER BY A_NUMBER, RECORD_ID;

  SELECT *
    FROM ELC_0512_TMP
ORDER BY A_NUMBER, RECORD_ID;

SELECT * FROM D_V_E_0512;

SELECT COUNT (1) FROM VNP_0512_TMP;

SELECT COUNT (1)
  FROM ELC_0512_TMP
 WHERE b_number IS NULL;

SELECT COUNT (1) FROM D_V_E_0512;

DROP TABLE D_V_E_0512;

CREATE TABLE D_V_E_0512
AS
     SELECT V.A_NUMBER,
            V.B_NUMBER VNP_B_NUMBER,
            E.B_NUMBER ELC_B_NUMBER,
            V.CDR_START_TIME VNP_START_TIME,
            E.CDR_START_TIME ELC_START_TIME,
            (V.CDR_START_TIME - E.CDR_START_TIME) * 60 * 60 * 24 TIME_DELTA,
            V.DURATION VNP_DURATION,
            E.DURATION ELC_DURATION,
            V.RECORD_ID VNP_RECORD_ID,
            E.RECORD_ID ELC_RECORD_ID
       FROM    VNP_0512_TMP V
            FULL OUTER JOIN
               ELC_0512_TMP E
            ON (V.A_NUMBER = E.A_NUMBER AND V.RECORD_ID = E.RECORD_ID)
   ORDER BY V.A_NUMBER, V.RECORD_ID;

SELECT COUNT (*)
  FROM D_V_E_0512
 WHERE elc_b_number IS NULL;

-- filter1: Loc DURATION > |TIME_DELTA|

DROP TABLE D_V_E_0512_FIL1;

CREATE TABLE D_V_E_0512_FIL1
AS
   SELECT *
     FROM D_V_E_0512
    WHERE NOT (    ABS (TIME_DELTA) < VNP_DURATION
               AND ABS (TIME_DELTA) < ELC_DURATION);

DROP TABLE D_V_E_0512_FIL2;

CREATE TABLE D_V_E_0512_FIL2
AS
   SELECT *
     FROM D_V_E_0512_FIL1
    WHERE NOT (    VNP_B_NUMBER = ELC_B_NUMBER
               AND ABS (TIME_DELTA) < 100
               AND ABS (VNP_DURATION - ELC_DURATION) <= 1);

DROP TABLE D_V_E_0512_FIL3;

CREATE TABLE D_V_E_0512_FIL3
AS
   SELECT *
     FROM D_V_E_0512_FIL2
    --     FROM (SELECT * FROM D_V_E_0512_FIL2
    --           MINUS
    --           SELECT *
    --             FROM D_V_E_0512_FIL2
    --            WHERE ELC_B_NUMBER IS NULL)
    WHERE NOT (    VNP_B_NUMBER = ELC_B_NUMBER
               AND VNP_DURATION = ELC_DURATION
               AND VNP_RECORD_ID = ELC_RECORD_ID);

DROP TABLE D_V_E_0512_FIL4;

CREATE TABLE D_V_E_0512_FIL4
AS
   SELECT *
     FROM D_V_E_0512_FIL3
    WHERE NOT (    VNP_B_NUMBER = ELC_B_NUMBER
               AND ABS (VNP_DURATION - ELC_DURATION) <= 1
               AND VNP_RECORD_ID = ELC_RECORD_ID);

SELECT * FROM D_V_E_0512_FIL4;

  SELECT *
    FROM D_V_E_0512_FIL4
ORDER BY a_number,
         vnp_b_number,
         elc_b_number,
         vnp_start_time,
         elc_start_time;

SELECT *
  FROM D_V_E_0512_FIL2
 WHERE ELC_B_NUMBER IS NULL;

SELECT * FROM VNP_0512_TMP;

SELECT *
  FROM ELC_0512_TMP
 WHERE B_NUMBER IS NULL;                                                                                                                                                                                                                                                                       --and duration != 0;