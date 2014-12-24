DROP PACKAGE BODY VNP_COMMON.ELC_USER_FILTER_TMP;

CREATE OR REPLACE PACKAGE BODY VNP_COMMON.ELC_USER_FILTER_TMP
AS
   /******************************************************************************
      NAME:       ELC_USER_FILTER_TMP
      PURPOSE:

      REVISIONS:
      Ver        Date        Author           Description
      ---------  ----------  ---------------  ------------------------------------
      1.0        27/03/2014      manucian86       1. Created this package body.
   ******************************************************************************/

   -- DONE
   PROCEDURE GET_RESELLER_VERSIONS
   IS
   BEGIN
      --      EXECUTE IMMEDIATE 'TRUNCATE TABLE RESELLER_VERSION';
      --
      --      INSERT INTO RESELLER_VERSION (RESELLER_VERSION_ID,
      --                                    RESELLER_ID,
      --                                    MAJOR_VERSION_NUM,
      --                                    MINOR_VERSION_NUM,
      --                                    ACTIVE_DATE,
      --                                    INACTIVE_DATE,
      --                                    SERVICE_VERSION_ID,
      --                                    STATUS)
      --         SELECT RESELLER_VERSION_ID,
      --                RESELLER_ID,
      --                MAJOR_VERSION_NUM,
      --                MINOR_VERSION_NUM,
      --                ACTIVE_DATE,
      --                INACTIVE_DATE,
      --                SERVICE_VERSION_ID,
      --                STATUS
      --           FROM cbs_owner.RESELLER_VERSION
      --          WHERE RESELLER_ID = 9 AND (INACTIVE_DATE IS NOT NULL OR STATUS = 3);
      --
      MERGE INTO VNP_COMMON.RESELLER_VERSION A
           USING (SELECT RESELLER_VERSION_ID,
                         RESELLER_ID,
                         MAJOR_VERSION_NUM,
                         MINOR_VERSION_NUM,
                         ACTIVE_DATE,
                         INACTIVE_DATE,
                         SERVICE_VERSION_ID,
                         STATUS
                    FROM cbs_owner.RESELLER_VERSION_VIEW
                   WHERE     RESELLER_ID = 9
                         AND (INACTIVE_DATE IS NOT NULL OR STATUS = 3)) B
              ON (A.RESELLER_VERSION_ID = B.RESELLER_VERSION_ID)
      WHEN NOT MATCHED
      THEN
         INSERT     (RESELLER_VERSION_ID,
                     RESELLER_ID,
                     MAJOR_VERSION_NUM,
                     MINOR_VERSION_NUM,
                     ACTIVE_DATE,
                     INACTIVE_DATE,
                     SERVICE_VERSION_ID,
                     STATUS)
             VALUES (B.RESELLER_VERSION_ID,
                     B.RESELLER_ID,
                     B.MAJOR_VERSION_NUM,
                     B.MINOR_VERSION_NUM,
                     B.ACTIVE_DATE,
                     B.INACTIVE_DATE,
                     B.SERVICE_VERSION_ID,
                     B.STATUS)
      WHEN MATCHED
      THEN
         UPDATE SET A.RESELLER_ID = B.RESELLER_ID,
                    A.MAJOR_VERSION_NUM = B.MAJOR_VERSION_NUM,
                    A.MINOR_VERSION_NUM = B.MINOR_VERSION_NUM,
                    A.ACTIVE_DATE = B.ACTIVE_DATE,
                    A.INACTIVE_DATE = B.INACTIVE_DATE,
                    A.SERVICE_VERSION_ID = B.SERVICE_VERSION_ID,
                    A.STATUS = B.STATUS;
   END;

   -- DONE
   PROCEDURE RUNNING_FIRST
   IS
      CURSOR C_RESELLER_VERSION
      IS
         SELECT *
           FROM RESELLER_VERSION RV
          WHERE RESELLER_ID = 9 AND (INACTIVE_DATE IS NOT NULL OR STATUS = 3);

      r_reseller_version   RESELLER_VERSION%ROWTYPE;
   BEGIN
      ELC_USER_FILTER_TMP.GET_RESELLER_VERSIONS;

      -- NO RESELLER_VERSION ***
      EXECUTE IMMEDIATE 'TRUNCATE TABLE CURRENCY_TYPE';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE UNIT_TYPE';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE ZONE';

      -- NO RESELLER_VERSION ***

      EXECUTE IMMEDIATE 'TRUNCATE TABLE ACCUMULATOR';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE BALANCE';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE DISCOUNT_MODEL';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE OFFER_ACCUMULATOR_MAP';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE OFFER_BALANCE_MAP';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE OFFER_PRIORITY';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE OFFER_RC_AWARD_MAP';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE PRODUCT_OFFER';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE PROMO_PLAN';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE RUM_MAP';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE TARIFF_MODEL';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE TARIFF_PLAN';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE TIME_MAP';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE TIME_MODEL';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE USAGE_ACTIVITY';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE USAGE_ACTIVITY_GROUP';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE USAGE_ACTIVITY_TRANS';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE USAGE_PLAN';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE ZONE_GROUP';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE OFFER_RC_TERM_MAP';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE RC_RATE';


      -- NO RESELLER_VERSION ***
      ELC_USER_FILTER_TMP.FILTER_CURRENCY_TYPE;
      ELC_USER_FILTER_TMP.FILTER_UNIT_TYPE;
      ELC_USER_FILTER_TMP.FILTER_ZONE;

      -- NO RESELLER_VERSION ***

      OPEN c_reseller_version;

      LOOP
         FETCH c_reseller_version INTO r_reseller_version;

         EXIT WHEN c_reseller_version%NOTFOUND;

         ELC_USER_FILTER_TMP.FILTER_ACCUMULATOR (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_BALANCE (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_DISCOUNT_MODEL (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_OFFER_ACCUMULATOR_MAP (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_OFFER_BALANCE_MAP (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_OFFER_PRIORITY (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_OFFER_RC_AWARD_MAP (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_PRODUCT_OFFER (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_PROMO_PLAN (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_RUM_MAP (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_TARIFF_MODEL (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_TARIFF_PLAN (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_TIME_MAP (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_TIME_MODEL (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_USAGE_ACTIVITY (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_USAGE_ACTIVITY_GROUP (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_USAGE_ACTIVITY_TRANS (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_USAGE_PLAN (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_ZONE_GROUP (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_OFFER_RC_TERM_MAP (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_TMP.FILTER_RC_RATE (
            r_reseller_version.reseller_version_id);
      --         DBMS_OUTPUT.PUT_LINE ('test ' || r_reseller_version.reseller_version_id);
      END LOOP;

      COMMIT;

      INS_ACTION_LOG ('RUNNING_FIRST',
                      'ELC_USER_FILTER_TMP',
                      'SUCCESSFUL',
                      2);
   EXCEPTION
      --      WHEN NO_DATA_FOUND
      --      THEN
      --         NULL;
      WHEN OTHERS
      THEN
         ROLLBACK;

         INS_ACTION_LOG (
            'RUNNING_FIRST',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   -- DONE
   PROCEDURE LETS_GO (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      CHANGE_CHANGING_STATUS (1);

      ELC_USER_FILTER_TMP.GET_RESELLER_VERSIONS;

      --
      ELC_USER_FILTER_TMP.FILTER_ACCUMULATOR (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_BALANCE (i_reseller_version_id);
      --      ELC_USER_FILTER_TMP.FILTER_CURRENCY_TYPE (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_DISCOUNT_MODEL (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_OFFER_ACCUMULATOR_MAP (
         i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_OFFER_BALANCE_MAP (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_OFFER_PRIORITY (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_OFFER_RC_AWARD_MAP (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_PRODUCT_OFFER (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_PROMO_PLAN (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_RUM_MAP (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_TARIFF_MODEL (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_TARIFF_PLAN (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_TIME_MAP (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_TIME_MODEL (i_reseller_version_id);
      --      ELC_USER_FILTER_TMP.FILTER_UNIT_TYPE (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_USAGE_ACTIVITY (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_USAGE_ACTIVITY_GROUP (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_USAGE_ACTIVITY_TRANS (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_USAGE_PLAN (i_reseller_version_id);
      --      ELC_USER_FILTER_TMP.FILTER_ZONE (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_ZONE_GROUP (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_OFFER_RC_TERM_MAP (i_reseller_version_id);
      ELC_USER_FILTER_TMP.FILTER_RC_RATE (i_reseller_version_id);

      CHANGE_CHANGING_STATUS (0);

      COMMIT;

      INS_ACTION_LOG (
         'LETS_GO',
         'ELC_USER_FILTER_TMP',
         'LETS_GO ( ' || i_reseller_version_id || ' ) => SUCCESSFUL',
         2);
   EXCEPTION
      --      WHEN NO_DATA_FOUND
      --      THEN
      --         NULL;
      WHEN OTHERS
      THEN
         ROLLBACK;

         CHANGE_CHANGING_STATUS (0);

         INS_ACTION_LOG (
            'LETS_GO',
            'ELC_USER_FILTER_TMP',
               'LETS_GO ( '
            || i_reseller_version_id
            || ' ) => ERROR CODE: '
            || SQLCODE
            || '; DETAIL: '
            || SQLERRM,
            4);
   END;

   -- DONE
   PROCEDURE CHANGE_CHANGING_STATUS (I_CHANGING_STATUS NUMBER)
   IS
   BEGIN
      UPDATE CHANGE_FLAG
         SET IS_CHANGING = I_CHANGING_STATUS;

      COMMIT;
   END;

   FUNCTION GET_CHANGING_STATUS
      RETURN NUMBER
   IS
      N_RESULT        NUMBER (1) := 0;

      CURSOR C_CHANGE_FLAG
      IS
         SELECT IS_CHANGING FROM CHANGE_FLAG;

      R_CHANGE_FLAG   C_CHANGE_FLAG%ROWTYPE;
   BEGIN
      OPEN C_CHANGE_FLAG;

      LOOP
         FETCH C_CHANGE_FLAG INTO R_CHANGE_FLAG;

         EXIT WHEN C_CHANGE_FLAG%NOTFOUND;

         N_RESULT := R_CHANGE_FLAG.IS_CHANGING;
      END LOOP;

      CLOSE C_CHANGE_FLAG;

      RETURN N_RESULT;
   END;

   PROCEDURE START_JOB_FILTER_NEW_PCAT_DATA (i_reseller_version_id NUMBER)
   IS
   BEGIN
      DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE (
         job_name            => '"VNP_COMMON"."JOB_FILTER_NEW_PCAT_DATA"',
         argument_position   => 1,
         argument_value      => i_reseller_version_id);

      -- Run job synchronously.
      DBMS_SCHEDULER.run_job (
         job_name              => '"VNP_COMMON"."JOB_FILTER_NEW_PCAT_DATA"',
         use_current_session   => FALSE);
   END;

   -- NO RESELLER_VERSION *****************************************************
   PROCEDURE FILTER_CURRENCY_TYPE
   IS
   BEGIN
      DELETE VNP_COMMON.CURRENCY_TYPE
       WHERE 1 = 1;

      INSERT INTO VNP_COMMON.CURRENCY_TYPE
         SELECT *
           FROM cbs_owner.CURRENCY_TYPE_VIEW
          WHERE 1 = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_CURRENCY_TYPE',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_UNIT_TYPE
   IS
   BEGIN
      DELETE VNP_COMMON.UNIT_TYPE
       WHERE 1 = 1;

      INSERT INTO VNP_COMMON.UNIT_TYPE
         SELECT *
           FROM cbs_owner.UNIT_TYPE_VIEW
          WHERE 1 = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_UNIT_TYPE',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_ZONE
   IS
   BEGIN
      DELETE VNP_COMMON.ZONE
       WHERE 1 = 1;

      INSERT INTO VNP_COMMON.ZONE
         SELECT *
           FROM cbs_owner.ZONE_VIEW
          WHERE 1 = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_ZONE',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   -- NO RESELLER_VERSION *****************************************************


   PROCEDURE FILTER_ACCUMULATOR (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.ACCUMULATOR
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.ACCUMULATOR
         SELECT *
           FROM cbs_owner.ACCUMULATOR_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_ACCUMULATOR',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_BALANCE (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.BALANCE
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.BALANCE
         SELECT *
           FROM cbs_owner.BALANCE_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_BALANCE',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_DISCOUNT_MODEL (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.DISCOUNT_MODEL
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.DISCOUNT_MODEL
         SELECT *
           FROM cbs_owner.DISCOUNT_MODEL_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_DISCOUNT_MODEL',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_OFFER_ACCUMULATOR_MAP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.OFFER_ACCUMULATOR_MAP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.OFFER_ACCUMULATOR_MAP
         SELECT *
           FROM cbs_owner.OFFER_ACCUMULATOR_MAP_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_OFFER_ACCUMULATOR_MAP',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_OFFER_BALANCE_MAP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.OFFER_BALANCE_MAP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.OFFER_BALANCE_MAP
         SELECT *
           FROM cbs_owner.OFFER_BALANCE_MAP_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_OFFER_BALANCE_MAP',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_OFFER_PRIORITY (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.OFFER_PRIORITY
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.OFFER_PRIORITY
         SELECT *
           FROM cbs_owner.OFFER_PRIORITY_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_OFFER_PRIORITY',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_OFFER_RC_AWARD_MAP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.OFFER_RC_AWARD_MAP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.OFFER_RC_AWARD_MAP
         SELECT *
           FROM cbs_owner.OFFER_RC_AWARD_MAP_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_OFFER_RC_AWARD_MAP',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_PRODUCT_OFFER (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.PRODUCT_OFFER
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.PRODUCT_OFFER (OFFER_ID,
                                            OFFER_NAME,
                                            OFFER_TYPE,
                                            RESELLER_VERSION_ID,
                                            SALES_EFFECTIVE_TIME,
                                            SALES_EXPIRATION_TIME,
                                            CURRENCY_NAME,
                                            CURRENCY_CODE,
                                            UPSELL_TEMPLATE_ID)
         SELECT OFFER_ID,
                OFFER_NAME,
                OFFER_TYPE,
                RESELLER_VERSION_ID,
                SALES_EFFECTIVE_TIME,
                SALES_EXPIRATION_TIME,
                CURRENCY_NAME,
                CURRENCY_CODE,
                UPSELL_TEMPLATE_ID
           FROM cbs_owner.PRODUCT_OFFER_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_PRODUCT_OFFER',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_PROMO_PLAN (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.PROMO_PLAN
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.PROMO_PLAN
         SELECT *
           FROM cbs_owner.PROMO_PLAN_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_PROMO_PLAN',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_RUM_MAP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.RUM_MAP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.RUM_MAP
         SELECT *
           FROM cbs_owner.RUM_MAP_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_RUM_MAP',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_TARIFF_MODEL (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.TARIFF_MODEL
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.TARIFF_MODEL
         SELECT *
           FROM cbs_owner.TARIFF_MODEL_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_TARIFF_MODEL',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_TARIFF_PLAN (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.TARIFF_PLAN
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.TARIFF_PLAN
         SELECT *
           FROM cbs_owner.TARIFF_PLAN_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_TARIFF_PLAN',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_TIME_MAP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.TIME_MAP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.TIME_MAP
         SELECT *
           FROM cbs_owner.TIME_MAP_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_TIME_MAP',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_TIME_MODEL (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.TIME_MODEL
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.TIME_MODEL
         SELECT *
           FROM cbs_owner.TIME_MODEL_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_TIME_MODEL',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_USAGE_ACTIVITY (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.USAGE_ACTIVITY
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.USAGE_ACTIVITY
         SELECT *
           FROM cbs_owner.USAGE_ACTIVITY_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_USAGE_ACTIVITY',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_USAGE_ACTIVITY_GROUP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.USAGE_ACTIVITY_GROUP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.USAGE_ACTIVITY_GROUP
         SELECT *
           FROM cbs_owner.USAGE_ACTIVITY_GROUP_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_USAGE_ACTIVITY_GROUP',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_USAGE_ACTIVITY_TRANS (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.USAGE_ACTIVITY_TRANS
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.USAGE_ACTIVITY_TRANS
         SELECT *
           FROM cbs_owner.USAGE_ACTIVITY_TRANS_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_USAGE_ACTIVITY_TRANS',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_USAGE_PLAN (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.USAGE_PLAN
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.USAGE_PLAN
         SELECT *
           FROM cbs_owner.USAGE_PLAN_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_USAGE_PLAN',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_ZONE_GROUP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.ZONE_GROUP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.ZONE_GROUP
         SELECT *
           FROM cbs_owner.ZONE_GROUP_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_ZONE_GROUP',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_OFFER_RC_TERM_MAP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.OFFER_RC_TERM_MAP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.OFFER_RC_TERM_MAP
         SELECT *
           FROM cbs_owner.OFFER_RC_TERM_MAP_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_OFFER_RC_TERM_MAP',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_RC_RATE (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.RC_RATE
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.RC_RATE
         SELECT *
           FROM cbs_owner.RC_RATE_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_RC_RATE',
            'ELC_USER_FILTER_TMP',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;
END ELC_USER_FILTER_TMP;
/
