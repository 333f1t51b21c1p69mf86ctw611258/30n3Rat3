/* Formatted on 08/12/2014 4:39:37 AM (QP5 v5.215.12089.38647) */
SELECT '0512', COUNT (1)
  FROM hot_rated_cdr
 WHERE     cdr_start_time <
              TO_DATE ('06/12/2014 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
       AND cdr_start_time >
              TO_DATE ('05/12/2014 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
UNION ALL
SELECT '0612', COUNT (1)
  FROM hot_rated_cdr
 WHERE     cdr_start_time <
              TO_DATE ('07/12/2014 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
       AND cdr_start_time >
              TO_DATE ('06/12/2014 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
UNION ALL
SELECT '0712', COUNT (1)
  FROM hot_rated_cdr
 WHERE     cdr_start_time <
              TO_DATE ('08/12/2014 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
       AND cdr_start_time >
              TO_DATE ('07/12/2014 00:00:00', 'dd/mm/yyyy hh24:mi:ss');