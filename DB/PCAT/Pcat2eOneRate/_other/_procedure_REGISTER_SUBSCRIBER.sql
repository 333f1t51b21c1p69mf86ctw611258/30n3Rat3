/* Formatted on 4/7/2014 4:41:23 PM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE PROCEDURE REGISTER_SUBSCRIBER (
   in_subscriber_no      IN VARCHAR2,
   in_product_offer_id   IN VARCHAR2)
IS
   idToInsert              INT;
   subsOfferMapId          INT;
   numberOfSubs            INT;
   idOfSubscriberVersion   INT;
   idOfAccountVersion      INT;

   v_err_msg               VARCHAR2 (1027);
BEGIN
   -- insert subscriber No
   idToInsert := SUBSCRIBER_SEQ.NEXTVAL;
   subsOfferMapId := SUBS_OFFER_MAP_SEQ.NEXTVAL;
   idOfSubscriberVersion := SUBSCRIBER_VERSION_SEQ.NEXTVAL;
   idOfAccountVersion := ACCOUNT_VERSION_SEQ.NEXTVAL;

   SELECT COUNT (*)
     INTO numberOfSubs
     FROM subscriber
    WHERE subscriber_no LIKE '%' || in_subscriber_no || '%';

   IF numberOfSubs = 0
   THEN
      INSERT INTO subscriber (SUBSCRIBER_ID, SUBSCRIBER_NO, RATING_TYPE_ID)
           VALUES (idToInsert, in_subscriber_no, 0);

      INSERT INTO subscriber_version (SUBSCRIBER_VERSION_ID,
                                      FROM_DATE,
                                      TO_DATE,
                                      SUBSCRIBER_ID,
                                      CUSTOMER_ID,
                                      MODIFIED_DATE,
                                      EFFECTIVE_DATE)
           VALUES (idOfSubscriberVersion,
                   SYSDATE,
                   TO_DATE ('19/01/2038 3:14:07', 'dd/mm/yyyy hh24:mi:ss'),
                   idToInsert,
                   NULL,
                   SYSDATE,
                   SYSDATE);


      --huongntt: insert  subs_status_map

      INSERT INTO SUBS_STATUS_MAP (SUBSCRIBER_ID,
                                   STATUS_ID,
                                   START_DATE,
                                   END_DATE)
           VALUES (idtoinsert,
                   1,
                   SYSDATE,
                   TO_DATE ('22/12/2017 3:58:31', 'dd/mm/yyyy hh24:mi:ss'));

      --sonph: insert  account, acocunt_version

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
                   1,
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
                               MODIFIED_DATE)
        VALUES (idToInsert,
                SYSDATE,
                TO_DATE ('22/12/2017 3:58:31', 'dd/mm/yyyy hh24:mi:ss'),
                in_product_offer_id,
                SYSDATE);
EXCEPTION
   WHEN OTHERS
   THEN
      v_err_msg :=
         SUBSTR (SQLERRM || CHR (10) || DBMS_UTILITY.format_error_backtrace,
                 1,
                 1023);
--         MT_PACKAGE.INSERT_ACTION_LOG ('DATABASE',
--                                       'GET_CP_PIE_CHART_RESULT',
--                                       'ERROR: ' || v_err_msg,
--                                       3);
END;