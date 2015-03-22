/* Formatted on 28/12/2014 21:44:53 (QP5 v5.215.12089.38647) */
INSERT INTO VNP_COMMON.ACCOUNT_VERSION_GOT
   SELECT AV.ACCOUNT_VERSION_ID,
          5,
          'CORRECTED: Cac Subs co 1 PO, >= 1 SO ALO; dang ky SO trong thang => Test truong hop truoc ngay 16, sau ngay 16'
     FROM    VNP_COMMON.ACCOUNT_VERSION@PROD_VNP_VIEW AV
          INNER JOIN
             (  SELECT SUBSCRIBER_ID
                  FROM VNP_COMMON.SUBS_OFFER_MAP@PROD_VNP_VIEW SOM,
                       VNP_COMMON.PRODUCT_OFFER@PROD_VNP_VIEW PO
                 WHERE     SOM.PRODUCT_OFFER_ID = PO.OFFER_ID
                       AND PO.RESELLER_VERSION_ID = 9
                       AND (   (    UPPER (OFFER_NAME) LIKE '%ALO%'
                                AND PO.OFFER_TYPE = 'SO'
                                AND SOM.FROM_DATE > TRUNC (SYSDATE, 'MM'))
                            OR (    PO.OFFER_TYPE = 'PO'
                                AND SOM.FROM_DATE < TRUNC (SYSDATE, 'MM')))
              GROUP BY SUBSCRIBER_ID
                HAVING COUNT (1) >= 2) T
          ON (AV.SUBSCRIBER_ID = T.SUBSCRIBER_ID)
    WHERE                         --              SYSDATE - 100 > AV.FROM_DATE
              --          AND (AV.TO_DATE IS NULL OR SYSDATE + 100 < AV.TO_DATE)
              --          AND
              ROWNUM <= 5
          AND AV.ACCOUNT_VERSION_ID NOT IN
                 (SELECT ACCOUNT_VERSION_ID FROM ACCOUNT_VERSION_GOT);

INSERT INTO VNP_COMMON.ACCOUNT_VERSION
   SELECT AV.*
     FROM    VNP_COMMON.ACCOUNT_VERSION@PROD_VNP_VIEW AV
          INNER JOIN
             VNP_COMMON.ACCOUNT_VERSION_GOT AVG
          ON (AV.ACCOUNT_VERSION_ID = AVG.ACCOUNT_VERSION_ID)
    WHERE AVG.TEST_NUM = 5;

INSERT INTO VNP_COMMON.SUBSCRIBER
   SELECT S.*
     FROM VNP_COMMON.SUBSCRIBER@PROD_VNP_VIEW S
          INNER JOIN VNP_COMMON.ACCOUNT_VERSION AV
             ON (S.SUBSCRIBER_ID = AV.SUBSCRIBER_ID)
          INNER JOIN VNP_COMMON.ACCOUNT_VERSION_GOT AVG
             ON (AV.ACCOUNT_VERSION_ID = AVG.ACCOUNT_VERSION_ID)
    WHERE AVG.TEST_NUM = 5;

INSERT INTO VNP_COMMON.ACCOUNT
   SELECT A.*
     FROM VNP_COMMON.ACCOUNT@PROD_VNP_VIEW A
          INNER JOIN VNP_COMMON.ACCOUNT_VERSION AV
             ON (A.ACCOUNT_ID = AV.ACCOUNT_ID)
          INNER JOIN VNP_COMMON.ACCOUNT_VERSION_GOT AVG
             ON (AV.ACCOUNT_VERSION_ID = AVG.ACCOUNT_VERSION_ID)
    WHERE AVG.TEST_NUM = 5;

INSERT INTO VNP_COMMON.SUBS_OFFER_MAP
   SELECT SOM.*
     FROM VNP_COMMON.SUBS_OFFER_MAP@PROD_VNP_VIEW SOM
          INNER JOIN VNP_COMMON.SUBSCRIBER S
             ON (SOM.SUBSCRIBER_ID = S.SUBSCRIBER_ID)
          INNER JOIN VNP_COMMON.ACCOUNT_VERSION AV
             ON (S.SUBSCRIBER_ID = AV.SUBSCRIBER_ID)
          INNER JOIN VNP_COMMON.ACCOUNT_VERSION_GOT AVG
             ON (AV.ACCOUNT_VERSION_ID = AVG.ACCOUNT_VERSION_ID)
    WHERE AVG.TEST_NUM = 5;

INSERT INTO VNP_DATA.HOT_RATED_CDR
   SELECT HRC.*
     FROM VNP_COMMON.SUBSCRIBER S
          INNER JOIN VNP_DATA.TEST_HOT_RATED_CDR_25@PROD_VNP_DATA HRC
             ON (S.SUBSCRIBER_NO = HRC.A_NUMBER)
          INNER JOIN VNP_COMMON.ACCOUNT_VERSION AV
             ON (S.SUBSCRIBER_ID = AV.SUBSCRIBER_ID)
          INNER JOIN VNP_COMMON.ACCOUNT_VERSION_GOT AVG
             ON (AV.ACCOUNT_VERSION_ID = AVG.ACCOUNT_VERSION_ID)
    WHERE AVG.TEST_NUM = 5;

INSERT INTO VNP_DATA.HOT_RATED_CDR
   SELECT HRC.*
     FROM VNP_COMMON.SUBSCRIBER S
          INNER JOIN VNP_DATA.TEST_HOT_RATED_CDR_26@PROD_VNP_DATA HRC
             ON (S.SUBSCRIBER_NO = HRC.A_NUMBER)
          INNER JOIN VNP_COMMON.ACCOUNT_VERSION AV
             ON (S.SUBSCRIBER_ID = AV.SUBSCRIBER_ID)
          INNER JOIN VNP_COMMON.ACCOUNT_VERSION_GOT AVG
             ON (AV.ACCOUNT_VERSION_ID = AVG.ACCOUNT_VERSION_ID)
    WHERE AVG.TEST_NUM = 5;

INSERT INTO VNP_DATA.HOT_RATED_CDR
   SELECT HRC.*
     FROM VNP_COMMON.SUBSCRIBER S
          INNER JOIN VNP_DATA.TEST_HOT_RATED_CDR_27@PROD_VNP_DATA HRC
             ON (S.SUBSCRIBER_NO = HRC.A_NUMBER)
          INNER JOIN VNP_COMMON.ACCOUNT_VERSION AV
             ON (S.SUBSCRIBER_ID = AV.SUBSCRIBER_ID)
          INNER JOIN VNP_COMMON.ACCOUNT_VERSION_GOT AVG
             ON (AV.ACCOUNT_VERSION_ID = AVG.ACCOUNT_VERSION_ID)
    WHERE AVG.TEST_NUM = 5;
    
INSERT INTO VNP_DATA.HOT_RATED_CDR
   SELECT HRC.*
     FROM VNP_COMMON.SUBSCRIBER S
          INNER JOIN VNP_DATA.TEST_HOT_RATED_CDR_28@PROD_VNP_DATA HRC
             ON (S.SUBSCRIBER_NO = HRC.A_NUMBER)
          INNER JOIN VNP_COMMON.ACCOUNT_VERSION AV
             ON (S.SUBSCRIBER_ID = AV.SUBSCRIBER_ID)
          INNER JOIN VNP_COMMON.ACCOUNT_VERSION_GOT AVG
             ON (AV.ACCOUNT_VERSION_ID = AVG.ACCOUNT_VERSION_ID)
    WHERE AVG.TEST_NUM = 5;

COMMIT;

UPDATE product_offer
   SET from_first = 16
 WHERE offer_name LIKE '%ALO%';

SELECT *
  FROM PRODUCT_OFFER
 WHERE offer_name LIKE '%ALO%';



UPDATE vnp_data.hot_rated_cdr
   SET cdr_start_time = cdr_start_time + 7
 WHERE a_number IN (SELECT subscriber_no
                      FROM VNP_COMMON.SUBSCRIBER S
                           INNER JOIN VNP_COMMON.ACCOUNT_VERSION AV
                              ON (S.SUBSCRIBER_ID = AV.SUBSCRIBER_ID)
                           INNER JOIN VNP_COMMON.ACCOUNT_VERSION_GOT AVG
                              ON (AV.ACCOUNT_VERSION_ID =
                                     AVG.ACCOUNT_VERSION_ID)
                     WHERE AVG.TEST_NUM = 5);


SELECT *
  FROM product_select
 WHERE     RESELLER_VERSION_ID = 8
       AND account_version_id IN (SELECT account_version_id
                                    FROM account_version_got
                                   WHERE TEST_NUM = 5);