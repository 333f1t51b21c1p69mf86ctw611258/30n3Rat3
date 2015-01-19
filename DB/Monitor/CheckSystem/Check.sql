/* Formatted on 4/1/2015 15:57:16 (QP5 v5.215.12089.38647) */
  SELECT *
    FROM ORP_SFTP_FILE
ORDER BY modified_time DESC;

WITH ORDERED
     AS (SELECT sftp_file,
                slu,
                seq,
                status,
                retry,
                modified_time,
                ROW_NUMBER ()
                   OVER (PARTITION BY slu ORDER BY modified_time DESC)
                   AS rn
           FROM orp_sftp_file)
SELECT sftp_file, slu, modified_time
  FROM ORDERED
 WHERE rn = 1;

  SELECT slu, COUNT (*) AS file_count
    FROM orp_sftp_file
   WHERE TRUNC (modified_time, 'DD') = TO_DATE ('31/12/2014', 'dd/mm/yyyy')
GROUP BY slu;

  SELECT slu, COUNT (*) AS file_count
    FROM orp_sftp_file
   WHERE TRUNC (modified_time, 'DD') = TO_DATE ('01/01/2015', 'dd/mm/yyyy')
GROUP BY slu;

  SELECT slu, COUNT (*) AS file_count
    FROM orp_sftp_file
   WHERE TRUNC (modified_time, 'DD') = TO_DATE ('02/01/2015', 'dd/mm/yyyy')
GROUP BY slu;

  SELECT slu, COUNT (*) AS file_count
    FROM orp_sftp_file
   WHERE TRUNC (modified_time, 'DD') = TO_DATE ('03/01/2015', 'dd/mm/yyyy')
GROUP BY slu;

  SELECT slu, COUNT (*) AS file_count
    FROM orp_sftp_file
   WHERE TRUNC (modified_time, 'DD') = TO_DATE ('04/01/2015', 'dd/mm/yyyy')
GROUP BY slu;

SELECT * FROM ORP_SFTP_LASTEST;

  SELECT *
    FROM SFTP_FILE
ORDER BY modified_time;


WITH ORDERED
     AS (SELECT sftp_file,
                slu,
                seq,
                status,
                retry,
                modified_time,
                ROW_NUMBER ()
                   OVER (PARTITION BY slu ORDER BY modified_time DESC)
                   AS rn
           FROM SFTP_FILE)
SELECT sftp_file, slu, modified_time
  FROM ORDERED
 WHERE rn = 1;

  SELECT slu, COUNT (*) AS file_count
    FROM SFTP_FILE
   WHERE TRUNC (modified_time, 'DD') = TO_DATE ('31/12/2014', 'dd/mm/yyyy')
GROUP BY slu;

  SELECT slu, COUNT (*) AS file_count
    FROM SFTP_FILE
   WHERE TRUNC (modified_time, 'DD') = TO_DATE ('01/01/2015', 'dd/mm/yyyy')
GROUP BY slu;

  SELECT slu, COUNT (*) AS file_count
    FROM SFTP_FILE
   WHERE TRUNC (modified_time, 'DD') = TO_DATE ('02/01/2015', 'dd/mm/yyyy')
GROUP BY slu;

  SELECT slu, COUNT (*) AS file_count
    FROM SFTP_FILE
   WHERE TRUNC (modified_time, 'DD') = TO_DATE ('03/01/2015', 'dd/mm/yyyy')
GROUP BY slu;

  SELECT slu, COUNT (*) AS file_count
    FROM SFTP_FILE
   WHERE TRUNC (modified_time, 'DD') = TO_DATE ('04/01/2015', 'dd/mm/yyyy')
GROUP BY slu;

  SELECT *
    FROM action_log
   WHERE log_group = 'ELC_USER_FILTER_2'
ORDER BY created_time DESC;

  SELECT *
    FROM VNP_DATA.CDR_LOG_PROCESS
   WHERE TRUNC (end_time, 'dd') = TRUNC (SYSDATE, 'dd') AND ROWNUM < 10
ORDER BY CDR_LOG_PROCESS_ID DESC;