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
   --   subsOfferMapId          INT;
   numberOfSubs         INT;
   --   idOfSubscriberVersion   INT;
   idOfAccountVersion   INT;

   n_account_id         PLS_INTEGER;

   v_err_msg            VARCHAR2 (1027);

   subs_no_length       NUMBER (2);
   subs_prefix          VARCHAR2 (1);
BEGIN
-- <Toad_46298927_1> *** DO NOT REMOVE THE AUTO DEBUGGER START/END TAGS
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_1} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_1}[--- 1 ---]');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_1} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_1}[1] in_subscriber_no = ' || in_subscriber_no);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_1}[1] in_product_offer_id = ' || in_product_offer_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_1}[1] idToInsert = ' || idToInsert);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_1}[1] numberOfSubs = ' || numberOfSubs);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_1}[1] idOfAccountVersion = ' || idOfAccountVersion);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_1}[1] n_account_id = ' || n_account_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_1}[1] v_err_msg = ' || v_err_msg);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_1}[1] subs_no_length = ' || subs_no_length);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_1}[1] subs_prefix = ' || subs_prefix);
-- </Toad_46298927_1>

   -- insert subscriber No
   idToInsert := SUBSCRIBER_SEQ.NEXTVAL;
-- <Toad_46298927_2> *** DO NOT REMOVE THE AUTO DEBUGGER START/END TAGS
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_2} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_2}[--- 2 ---]');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_2} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_2}[2] in_subscriber_no = ' || in_subscriber_no);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_2}[2] in_product_offer_id = ' || in_product_offer_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_2}[2] idToInsert = ' || idToInsert);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_2}[2] numberOfSubs = ' || numberOfSubs);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_2}[2] idOfAccountVersion = ' || idOfAccountVersion);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_2}[2] n_account_id = ' || n_account_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_2}[2] v_err_msg = ' || v_err_msg);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_2}[2] subs_no_length = ' || subs_no_length);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_2}[2] subs_prefix = ' || subs_prefix);
-- </Toad_46298927_2>


   --   subsOfferMapId := SUBS_OFFER_MAP_SEQ.NEXTVAL;

   SELECT COUNT (*)
     INTO numberOfSubs
     FROM subscriber
    WHERE subscriber_no LIKE '%' || in_subscriber_no || '%';
-- <Toad_46298927_3> *** DO NOT REMOVE THE AUTO DEBUGGER START/END TAGS
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_3} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_3}[--- 3 ---]');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_3} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_3}[3] in_subscriber_no = ' || in_subscriber_no);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_3}[3] in_product_offer_id = ' || in_product_offer_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_3}[3] idToInsert = ' || idToInsert);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_3}[3] numberOfSubs = ' || numberOfSubs);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_3}[3] idOfAccountVersion = ' || idOfAccountVersion);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_3}[3] n_account_id = ' || n_account_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_3}[3] v_err_msg = ' || v_err_msg);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_3}[3] subs_no_length = ' || subs_no_length);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_3}[3] subs_prefix = ' || subs_prefix);
-- </Toad_46298927_3>


   IF numberOfSubs = 0
   THEN
      --      idOfSubscriberVersion := SUBSCRIBER_VERSION_SEQ.NEXTVAL;
      idOfAccountVersion := ACCOUNT_VERSION_SEQ.NEXTVAL;
-- <Toad_46298927_4> *** DO NOT REMOVE THE AUTO DEBUGGER START/END TAGS
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_4} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_4}[--- 4 ---]');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_4} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_4}[4] in_subscriber_no = ' || in_subscriber_no);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_4}[4] in_product_offer_id = ' || in_product_offer_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_4}[4] idToInsert = ' || idToInsert);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_4}[4] numberOfSubs = ' || numberOfSubs);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_4}[4] idOfAccountVersion = ' || idOfAccountVersion);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_4}[4] n_account_id = ' || n_account_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_4}[4] v_err_msg = ' || v_err_msg);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_4}[4] subs_no_length = ' || subs_no_length);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_4}[4] subs_prefix = ' || subs_prefix);
-- </Toad_46298927_4>


      n_account_id := ACCOUNT_SEQ.NEXTVAL;
-- <Toad_46298927_5> *** DO NOT REMOVE THE AUTO DEBUGGER START/END TAGS
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_5} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_5}[--- 5 ---]');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_5} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_5}[5] in_subscriber_no = ' || in_subscriber_no);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_5}[5] in_product_offer_id = ' || in_product_offer_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_5}[5] idToInsert = ' || idToInsert);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_5}[5] numberOfSubs = ' || numberOfSubs);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_5}[5] idOfAccountVersion = ' || idOfAccountVersion);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_5}[5] n_account_id = ' || n_account_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_5}[5] v_err_msg = ' || v_err_msg);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_5}[5] subs_no_length = ' || subs_no_length);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_5}[5] subs_prefix = ' || subs_prefix);
-- </Toad_46298927_5>


      subs_no_length := LENGTH (in_subscriber_no);
-- <Toad_46298927_6> *** DO NOT REMOVE THE AUTO DEBUGGER START/END TAGS
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_6} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_6}[--- 6 ---]');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_6} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_6}[6] in_subscriber_no = ' || in_subscriber_no);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_6}[6] in_product_offer_id = ' || in_product_offer_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_6}[6] idToInsert = ' || idToInsert);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_6}[6] numberOfSubs = ' || numberOfSubs);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_6}[6] idOfAccountVersion = ' || idOfAccountVersion);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_6}[6] n_account_id = ' || n_account_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_6}[6] v_err_msg = ' || v_err_msg);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_6}[6] subs_no_length = ' || subs_no_length);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_6}[6] subs_prefix = ' || subs_prefix);
-- </Toad_46298927_6>

      subs_prefix := SUBSTR (in_subscriber_no, subs_no_length, 1);
-- <Toad_46298927_7> *** DO NOT REMOVE THE AUTO DEBUGGER START/END TAGS
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_7} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_7}[--- 7 ---]');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_7} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_7}[7] in_subscriber_no = ' || in_subscriber_no);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_7}[7] in_product_offer_id = ' || in_product_offer_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_7}[7] idToInsert = ' || idToInsert);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_7}[7] numberOfSubs = ' || numberOfSubs);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_7}[7] idOfAccountVersion = ' || idOfAccountVersion);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_7}[7] n_account_id = ' || n_account_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_7}[7] v_err_msg = ' || v_err_msg);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_7}[7] subs_no_length = ' || subs_no_length);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_7}[7] subs_prefix = ' || subs_prefix);
-- </Toad_46298927_7>


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
-- <Toad_46298927_8> *** DO NOT REMOVE THE AUTO DEBUGGER START/END TAGS
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_8} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_8}[--- 8 ---]');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_8} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_8}[8] in_subscriber_no = ' || in_subscriber_no);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_8}[8] in_product_offer_id = ' || in_product_offer_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_8}[8] idToInsert = ' || idToInsert);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_8}[8] numberOfSubs = ' || numberOfSubs);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_8}[8] idOfAccountVersion = ' || idOfAccountVersion);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_8}[8] n_account_id = ' || n_account_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_8}[8] v_err_msg = ' || v_err_msg);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_8}[8] subs_no_length = ' || subs_no_length);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_8}[8] subs_prefix = ' || subs_prefix);
-- </Toad_46298927_8>

   END IF;


   INSERT INTO SUBS_OFFER_MAP (SUBSCRIBER_ID,
                               FROM_DATE,
                               TO_DATE,
                               PRODUCT_OFFER_ID,
                               MODIFIED_DATE)
        VALUES (idToInsert,
                SYSDATE - 60,
                TO_DATE ('22/12/2017 3:58:31', 'dd/mm/yyyy hh24:mi:ss'),
                in_product_offer_id,
                SYSDATE - 60);
EXCEPTION
   WHEN OTHERS
   THEN
      v_err_msg :=
         SUBSTR (SQLERRM || CHR (10) || DBMS_UTILITY.format_error_backtrace,
                 1,
                 1023);
-- <Toad_46298927_9> *** DO NOT REMOVE THE AUTO DEBUGGER START/END TAGS
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_9} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_9}[--- 9 ---]');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_9} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_9}[9] in_subscriber_no = ' || in_subscriber_no);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_9}[9] in_product_offer_id = ' || in_product_offer_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_9}[9] idToInsert = ' || idToInsert);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_9}[9] numberOfSubs = ' || numberOfSubs);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_9}[9] idOfAccountVersion = ' || idOfAccountVersion);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_9}[9] n_account_id = ' || n_account_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_9}[9] v_err_msg = ' || v_err_msg);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_9}[9] subs_no_length = ' || subs_no_length);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_9}[9] subs_prefix = ' || subs_prefix);
-- </Toad_46298927_9>

      INS_ACTION_LOG ('DATABASE',
                      'GET_CP_PIE_CHART_RESULT',
                      'ERROR: ' || v_err_msg,
                      3);
-- <Toad_46298927_10> *** DO NOT REMOVE THE AUTO DEBUGGER START/END TAGS
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_10} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_10}[--- 10 ---]');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_10} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_10}[10] in_subscriber_no = ' || in_subscriber_no);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_10}[10] in_product_offer_id = ' || in_product_offer_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_10}[10] idToInsert = ' || idToInsert);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_10}[10] numberOfSubs = ' || numberOfSubs);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_10}[10] idOfAccountVersion = ' || idOfAccountVersion);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_10}[10] n_account_id = ' || n_account_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_10}[10] v_err_msg = ' || v_err_msg);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_10}[10] subs_no_length = ' || subs_no_length);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_10}[10] subs_prefix = ' || subs_prefix);
-- </Toad_46298927_10>

-- <Toad_46298927_11> *** DO NOT REMOVE THE AUTO DEBUGGER START/END TAGS
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_11} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_11}[--- 11 ---]');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_11} ');
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_11}[11] in_subscriber_no = ' || in_subscriber_no);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_11}[11] in_product_offer_id = ' || in_product_offer_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_11}[11] idToInsert = ' || idToInsert);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_11}[11] numberOfSubs = ' || numberOfSubs);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_11}[11] idOfAccountVersion = ' || idOfAccountVersion);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_11}[11] n_account_id = ' || n_account_id);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_11}[11] v_err_msg = ' || v_err_msg);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_11}[11] subs_no_length = ' || subs_no_length);
DBMS_OUTPUT.PUT_LINE('{Toad_46298927_11}[11] subs_prefix = ' || subs_prefix);
-- </Toad_46298927_11>

END;
/
