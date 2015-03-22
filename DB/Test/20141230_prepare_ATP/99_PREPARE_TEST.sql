/* Formatted on 29/12/2014 10:51:57 (QP5 v5.215.12089.38647) */
TRUNCATE TABLE VNP_DATA.RATED_CDR;

SELECT COUNT (1) FROM vnp_data.rated_cdr;

UPDATE vnp_data.hot_rated_cdr
   SET RERATE_FLAG = 0
 WHERE a_number IN (SELECT subscriber_no
                      FROM VNP_COMMON.SUBSCRIBER S
                           INNER JOIN VNP_COMMON.ACCOUNT_VERSION AV
                              ON (S.SUBSCRIBER_ID = AV.SUBSCRIBER_ID)
                           INNER JOIN VNP_COMMON.ACCOUNT_VERSION_GOT AVG
                              ON (AV.ACCOUNT_VERSION_ID =
                                     AVG.ACCOUNT_VERSION_ID)
                     WHERE AVG.TEST_NUM = 2);

SELECT *
  FROM vnp_data.rated_cdr
 WHERE a_number IN (SELECT subscriber_no
                      FROM VNP_COMMON.SUBSCRIBER S
                           INNER JOIN VNP_COMMON.ACCOUNT_VERSION AV
                              ON (S.SUBSCRIBER_ID = AV.SUBSCRIBER_ID)
                           INNER JOIN VNP_COMMON.ACCOUNT_VERSION_GOT AVG
                              ON (AV.ACCOUNT_VERSION_ID =
                                     AVG.ACCOUNT_VERSION_ID)
                     WHERE AVG.TEST_NUM = 1);

SELECT *
  FROM vnp_data.rated_cdr
 WHERE a_number IN (SELECT subscriber_no
                      FROM VNP_COMMON.SUBSCRIBER S
                           INNER JOIN VNP_COMMON.ACCOUNT_VERSION AV
                              ON (S.SUBSCRIBER_ID = AV.SUBSCRIBER_ID)
                           INNER JOIN VNP_COMMON.ACCOUNT_VERSION_GOT AVG
                              ON (AV.ACCOUNT_VERSION_ID =
                                     AVG.ACCOUNT_VERSION_ID)
                     WHERE AVG.TEST_NUM = 1);

SELECT T1.MAP_ID,
       T1.A_NUMBER,
       T1.B_NUMBER,
       T1.DURATION,
       T1.TOTAL_USAGE
  FROM    (SELECT *
             FROM vnp_data.HOT_rated_cdr
            WHERE a_number IN (SELECT subscriber_no
                                 FROM VNP_COMMON.SUBSCRIBER S
                                      INNER JOIN VNP_COMMON.ACCOUNT_VERSION AV
                                         ON (S.SUBSCRIBER_ID =
                                                AV.SUBSCRIBER_ID)
                                      INNER JOIN VNP_COMMON.ACCOUNT_VERSION_GOT AVG
                                         ON (AV.ACCOUNT_VERSION_ID =
                                                AVG.ACCOUNT_VERSION_ID)
                                WHERE AVG.TEST_NUM = 1)) T1
       INNER JOIN
          (SELECT *
             FROM vnp_data.rated_cdr
            WHERE a_number IN (SELECT subscriber_no
                                 FROM VNP_COMMON.SUBSCRIBER S
                                      INNER JOIN VNP_COMMON.ACCOUNT_VERSION AV
                                         ON (S.SUBSCRIBER_ID =
                                                AV.SUBSCRIBER_ID)
                                      INNER JOIN VNP_COMMON.ACCOUNT_VERSION_GOT AVG
                                         ON (AV.ACCOUNT_VERSION_ID =
                                                AVG.ACCOUNT_VERSION_ID)
                                WHERE AVG.TEST_NUM = 1)) T2
       ON (T1.MAP_ID = T2.MAP_ID);