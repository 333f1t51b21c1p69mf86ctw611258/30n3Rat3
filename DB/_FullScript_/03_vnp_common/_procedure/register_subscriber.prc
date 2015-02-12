/* Formatted on 2/6/2015 9:54:57 AM (QP5 v5.269.14213.34746) */
DROP PROCEDURE VNP_COMMON.REGISTER_SUBSCRIBER;

CREATE OR REPLACE PROCEDURE VNP_COMMON.REGISTER_SUBSCRIBER (
   in_subscriber_no      IN VARCHAR2,
   in_product_offer_id   IN VARCHAR2)
IS
   --
   -------------------------------------------------------------------------------
   --  + 20/11/2014: NguyenTH comment phan subscriber_version vi bang nay da xoa
   -------------------------------------------------------------------------------
   --
   idToInsert           INT;
   subsOfferMapId       INT;
   numberOfSubs         INT;
   --   idOfSubscriberVersion   INT;
   idOfAccountVersion   INT;

   n_account_id         PLS_INTEGER;

   v_err_msg            VARCHAR2 (1027);

   subs_no_length       NUMBER (2);
   subs_prefix          VARCHAR2 (1);
BEGIN
   -- insert subscriber No
   idToInsert := SUBSCRIBER_SEQ.NEXTVAL;

   subsOfferMapId := SUBS_OFFER_MAP_SEQ.NEXTVAL;

   SELECT COUNT (*)
     INTO numberOfSubs
     FROM subscriber
    WHERE subscriber_no LIKE '%' || in_subscriber_no || '%';

   IF numberOfSubs = 0
   THEN
      --      idOfSubscriberVersion := SUBSCRIBER_VERSION_SEQ.NEXTVAL;
      idOfAccountVersion := ACCOUNT_VERSION_SEQ.NEXTVAL;

      n_account_id := ACCOUNT_SEQ.NEXTVAL;

      subs_no_length := LENGTH (in_subscriber_no);
      subs_prefix := SUBSTR (in_subscriber_no, subs_no_length, 1);

      INSERT INTO subscriber (SUBSCRIBER_ID,
                              SUBSCRIBER_NO,
                              RATING_TYPE_ID,
                              data_part)
           VALUES (idToInsert,
                   in_subscriber_no,
                   0,
                   subs_prefix);

      --      INSERT INTO subscriber_version (SUBSCRIBER_VERSION_ID,
      --                                      FROM_DATE,
      --                                      TO_DATE,
      --                                      SUBSCRIBER_ID,
      --                                      CUSTOMER_ID,
      --                                      MODIFIED_DATE,
      --                                      EFFECTIVE_DATE)
      --           VALUES (idOfSubscriberVersion,
      --                   SYSDATE - 60,
      --                   TO_DATE ('19/01/2038 3:14:07', 'dd/mm/yyyy hh24:mi:ss'),
      --                   idToInsert,
      --                   NULL,
      --                   SYSDATE - 60,
      --                   SYSDATE - 60);


      --huongntt: insert  subs_status_map

      INSERT INTO SUBS_STATUS_MAP (SUBSCRIBER_ID,
                                   STATUS_ID,
                                   START_DATE,
                                   END_DATE)
           VALUES (idtoinsert,
                   1,
                   SYSDATE - 60,
                   TO_DATE ('22/12/2017 3:58:31', 'dd/mm/yyyy hh24:mi:ss'));

      --sonph: insert  account, acocunt_version

      INSERT INTO VNP_COMMON.ACCOUNT (ACCOUNT_ID, CURRENCY_ID)
           VALUES (n_account_id, 267);

      INSERT INTO ACCOUNT_VERSION (ACCOUNT_VERSION_ID,
                                   FROM_DATE,
                                   TO_DATE,
                                   SUBSCRIBER_ID,
                                   ACCOUNT_ID,
                                   MODIFIED_DATE,
                                   EFFECTIVE_DATE)
           VALUES (idOfAccountVersion,
                   TO_DATE ('12/02/2011 4:17:41', 'dd/mm/yyyy hh24:mi:ss'),
                   TO_DATE ('12/02/2016 4:17:41', 'dd/mm/yyyy hh24:mi:ss'),
                   idToInsert,
                   n_account_id,
                   TO_DATE ('12/02/2013 4:17:41', 'dd/mm/yyyy hh24:mi:ss'),
                   TO_DATE ('12/02/2012 4:17:41', 'dd/mm/yyyy hh24:mi:ss'));
   ELSE
      SELECT SUBSCRIBER_ID
        INTO idToInsert
        FROM subscriber
       WHERE subscriber_no = in_subscriber_no;
   END IF;


   INSERT INTO SUBS_OFFER_MAP (SUBSCRIBER_ID,
                               FROM_DATE,
                               TO_DATE,
                               PRODUCT_OFFER_ID,
                               SUBS_OFFER_MAP_ID,
                               MODIFIED_DATE)
        VALUES (idToInsert,
                SYSDATE - 60,
                TO_DATE ('22/12/2017 3:58:31', 'dd/mm/yyyy hh24:mi:ss'),
                in_product_offer_id,
                subsOfferMapId,
                SYSDATE - 60);
EXCEPTION
   WHEN OTHERS
   THEN
      v_err_msg :=
         SUBSTR (SQLERRM || CHR (10) || DBMS_UTILITY.format_error_backtrace,
                 1,
                 1023);
      INS_ACT_LOG ('DATABASE',
                   'GET_CP_PIE_CHART_RESULT',
                   'ERROR: ' || v_err_msg,
                   3);
END;
/