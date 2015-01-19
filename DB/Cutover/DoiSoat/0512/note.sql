/* Formatted on 20/12/2014 12:24:47 AM (QP5 v5.215.12089.38647) */
  SELECT NW_GROUP
    FROM VNP_0512
GROUP BY NW_GROUP;

SELECT COUNT (*) FROM ELC_0512;

-- ELC: (s1) Cac cuoc goi khong xac dinh tg ket thuc cuoc goi

SELECT *
  FROM VNP_VIEW.ELC_0512
 WHERE DURATION <= 0 AND NW_GROUP != 'GPR';

-- ELC: (s2) B_NUMBER = NULL => DURATION = 0 AND NW_GROUP = 'GPR'
SELECT COUNT (*)
  FROM VNP_VIEW.ELC_0512
 WHERE B_NUMBER IS NULL;

-- <=>
SELECT COUNT (*)
  FROM VNP_VIEW.ELC_0512
 WHERE B_NUMBER IS NULL AND DURATION <= 0 AND NW_GROUP = 'GPR';

-- ELC: So cac record co DURATION < 0 (= s1 + s2)
SELECT COUNT (*)
  FROM VNP_VIEW.ELC_0512
 WHERE DURATION <= 0;


SELECT COUNT (*)
  FROM (SELECT *
          FROM VNP_VIEW.ELC_0512
         WHERE ROWID IN (  SELECT MIN (ROWID)
                             FROM VNP_VIEW.ELC_0512
                         GROUP BY A_NUMBER,
                                  B_NUMBER,
                                  CDR_START_TIME,
                                  DURATION))
 WHERE B_NUMBER IS NULL;