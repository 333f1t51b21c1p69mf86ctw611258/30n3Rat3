DROP PACKAGE BODY ELC_USER_FILTER_2;

CREATE OR REPLACE PACKAGE BODY            ELC_USER_FILTER_2
AS
   /******************************************************************************
      NAME:       ELC_USER_FILTER_2
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
      --           FROM CBS_OWNER.RESELLER_VERSION
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
                    FROM CBS_OWNER.RESELLER_VERSION_VIEW
                   WHERE RESELLER_ID = 9 AND STATUS = 3) B
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
      ELC_USER_FILTER_2.GET_RESELLER_VERSIONS;

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

      EXECUTE IMMEDIATE 'TRUNCATE TABLE BALANCE_EI';

      OPEN c_reseller_version;

      LOOP
         FETCH c_reseller_version INTO r_reseller_version;

         EXIT WHEN c_reseller_version%NOTFOUND;

         ELC_USER_FILTER_2.FILTER_2_CURRENCY_TYPE (
            r_reseller_version.service_version_id);
         ELC_USER_FILTER_2.FILTER_2_UNIT_TYPE (
            r_reseller_version.service_version_id);
         ELC_USER_FILTER_2.FILTER_2_ZONE (
            r_reseller_version.service_version_id);

         ELC_USER_FILTER_2.FILTER_2_ACCUMULATOR (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_BALANCE (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_DISCOUNT_MODEL (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_OFFER_ACCUMULATOR_MAP (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_OFFER_BALANCE_MAP (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_OFFER_PRIORITY (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_OFFER_RC_AWARD_MAP (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_PRODUCT_OFFER (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_PROMO_PLAN (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_RUM_MAP (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_TARIFF_MODEL (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_TARIFF_PLAN (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_TIME_MAP (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_TIME_MODEL (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_USAGE_ACTIVITY (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_USAGE_ACTIVITY_GROUP (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_USAGE_ACTIVITY_TRANS (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_USAGE_PLAN (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_ZONE_GROUP (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_OFFER_RC_TERM_MAP (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_RC_RATE (
            r_reseller_version.reseller_version_id);
         ELC_USER_FILTER_2.FILTER_2_BALANCE_EI (
            r_reseller_version.reseller_version_id);
      --         DBMS_OUTPUT.PUT_LINE ('test ' || r_reseller_version.reseller_version_id);
      END LOOP;

      COMMIT;

      INS_ACTION_LOG ('RUNNING_FIRST',
                      'ELC_USER_FILTER_2',
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
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;



   -- DONE
   PROCEDURE LETS_GO (I_RESELLER_VERSION_ID IN NUMBER)
   IS
      CURSOR C_RESELLER_VERSION
      IS
         SELECT *
           FROM RESELLER_VERSION RV
          WHERE     RESELLER_ID = 9
                AND STATUS = 3
                AND RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      r_reseller_version   RESELLER_VERSION%ROWTYPE;
   BEGIN
      CHANGE_CHANGING_STATUS (1);

      ELC_USER_FILTER_2.GET_RESELLER_VERSIONS;

      OPEN c_reseller_version;

      FETCH c_reseller_version INTO r_reseller_version;

      --
      ELC_USER_FILTER_2.FILTER_2_ACCUMULATOR (i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_BALANCE (i_reseller_version_id);
      --
      ELC_USER_FILTER_2.FILTER_2_CURRENCY_TYPE (
         r_reseller_version.service_version_id);
      --
      ELC_USER_FILTER_2.FILTER_2_DISCOUNT_MODEL (i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_OFFER_ACCUMULATOR_MAP (
         i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_OFFER_BALANCE_MAP (i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_OFFER_PRIORITY (i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_OFFER_RC_AWARD_MAP (i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_PRODUCT_OFFER (i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_PROMO_PLAN (i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_RUM_MAP (i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_TARIFF_MODEL (i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_TARIFF_PLAN (i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_TIME_MAP (i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_TIME_MODEL (i_reseller_version_id);
      --
      ELC_USER_FILTER_2.FILTER_2_UNIT_TYPE (
         r_reseller_version.service_version_id);
      --
      ELC_USER_FILTER_2.FILTER_2_USAGE_ACTIVITY (i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_USAGE_ACTIVITY_GROUP (i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_USAGE_ACTIVITY_TRANS (i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_USAGE_PLAN (i_reseller_version_id);
      --
      ELC_USER_FILTER_2.FILTER_2_ZONE (r_reseller_version.service_version_id);
      --
      ELC_USER_FILTER_2.FILTER_2_ZONE_GROUP (i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_OFFER_RC_TERM_MAP (i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_RC_RATE (i_reseller_version_id);
      ELC_USER_FILTER_2.FILTER_2_BALANCE_EI (i_reseller_version_id);

      CHANGE_CHANGING_STATUS (0);

      COMMIT;

      CLOSE c_reseller_version;

      INS_ACTION_LOG (
         'LETS_GO',
         'ELC_USER_FILTER_2',
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
            'ELC_USER_FILTER_2',
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
      --      DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE (
      --         job_name            => '"VNP_COMMON"."JOB_FILTER_NEW_PCAT_DATA_2"',
      --         argument_position   => 1,
      --         argument_value      => i_reseller_version_id);
      --
      --      -- Run job synchronously.
      --      DBMS_SCHEDULER.run_job (
      --         job_name              => '"VNP_COMMON"."JOB_FILTER_NEW_PCAT_DATA_2"',
      --         use_current_session   => FALSE);

      ELC_USER_FILTER_2.LETS_GO (i_reseller_version_id);
   END;

   PROCEDURE FILTER_2_CURRENCY_TYPE (i_service_version_id NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.CURRENCY_TYPE
       WHERE SERVICE_VERSION_ID = i_service_version_id;

      INSERT INTO VNP_COMMON.CURRENCY_TYPE
         SELECT *
           FROM CBS_OWNER.CURRENCY_TYPE_VIEW
          WHERE SERVICE_VERSION_ID = i_service_version_id;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_CURRENCY_TYPE',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_2_UNIT_TYPE (i_service_version_id NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.UNIT_TYPE
       WHERE SERVICE_VERSION_ID = i_service_version_id;

      INSERT INTO VNP_COMMON.UNIT_TYPE
         SELECT *
           FROM CBS_OWNER.UNIT_TYPE_VIEW
          WHERE SERVICE_VERSION_ID = i_service_version_id;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_UNIT_TYPE',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_2_ZONE (i_service_version_id NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.ZONE
       WHERE SERVICE_VERSION_ID = i_service_version_id;

      INSERT INTO VNP_COMMON.ZONE
         SELECT *
           FROM CBS_OWNER.ZONE_VIEW
          WHERE SERVICE_VERSION_ID = i_service_version_id;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_ZONE',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;



   PROCEDURE FILTER_2_ACCUMULATOR (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.ACCUMULATOR
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.ACCUMULATOR
         SELECT *
           FROM CBS_OWNER.ACCUMULATOR_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_ACCUMULATOR',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_2_BALANCE (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.BALANCE
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.BALANCE
         SELECT *
           FROM CBS_OWNER.BALANCE_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_BALANCE',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_2_DISCOUNT_MODEL (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.DISCOUNT_MODEL
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.DISCOUNT_MODEL
         SELECT *
           FROM CBS_OWNER.DISCOUNT_MODEL_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_DISCOUNT_MODEL',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_2_OFFER_ACCUMULATOR_MAP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.OFFER_ACCUMULATOR_MAP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.OFFER_ACCUMULATOR_MAP
         SELECT *
           FROM CBS_OWNER.OFFER_ACCUMULATOR_MAP_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_OFFER_ACCUMULATOR_MAP',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_2_OFFER_BALANCE_MAP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.OFFER_BALANCE_MAP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.OFFER_BALANCE_MAP
         SELECT *
           FROM CBS_OWNER.OFFER_BALANCE_MAP_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_OFFER_BALANCE_MAP',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_2_OFFER_PRIORITY (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.OFFER_PRIORITY
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.OFFER_PRIORITY
         SELECT *
           FROM CBS_OWNER.OFFER_PRIORITY_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_OFFER_PRIORITY',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_2_OFFER_RC_AWARD_MAP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.OFFER_RC_AWARD_MAP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.OFFER_RC_AWARD_MAP
         SELECT *
           FROM CBS_OWNER.OFFER_RC_AWARD_MAP_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_OFFER_RC_AWARD_MAP',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_2_PRODUCT_OFFER (I_RESELLER_VERSION_ID IN NUMBER)
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
                                            UPSELL_TEMPLATE_ID,
                                            AUTO_EXPIRATION_DURATION,
                                            AUTO_EXPIRATION_UNIT)
         SELECT OFFER_ID,
                OFFER_NAME,
                OFFER_TYPE,
                RESELLER_VERSION_ID,
                SALES_EFFECTIVE_TIME,
                SALES_EXPIRATION_TIME,
                CURRENCY_NAME,
                CURRENCY_CODE,
                UPSELL_TEMPLATE_ID,
                AUTO_EXPIRATION_DURATION,
                AUTO_EXPIRATION_UNIT
           FROM CBS_OWNER.PRODUCT_OFFER_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_PRODUCT_OFFER',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_2_PROMO_PLAN (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.PROMO_PLAN
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.PROMO_PLAN
         SELECT *
           FROM CBS_OWNER.PROMO_PLAN_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_PROMO_PLAN',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_2_RUM_MAP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.RUM_MAP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.RUM_MAP
         SELECT *
           FROM CBS_OWNER.RUM_MAP_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_RUM_MAP',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_2_TARIFF_MODEL (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.TARIFF_MODEL
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.TARIFF_MODEL
         SELECT *
           FROM CBS_OWNER.TARIFF_MODEL_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_TARIFF_MODEL',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_2_TARIFF_PLAN (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.TARIFF_PLAN
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.TARIFF_PLAN
         SELECT *
           FROM CBS_OWNER.TARIFF_PLAN_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_TARIFF_PLAN',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_2_TIME_MAP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.TIME_MAP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.TIME_MAP
         SELECT *
           FROM CBS_OWNER.TIME_MAP_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_TIME_MAP',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_2_TIME_MODEL (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.TIME_MODEL
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.TIME_MODEL
         SELECT *
           FROM CBS_OWNER.TIME_MODEL_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_TIME_MODEL',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_2_USAGE_ACTIVITY (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.USAGE_ACTIVITY
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.USAGE_ACTIVITY
         SELECT *
           FROM CBS_OWNER.USAGE_ACTIVITY_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_USAGE_ACTIVITY',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_2_USAGE_ACTIVITY_GROUP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.USAGE_ACTIVITY_GROUP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.USAGE_ACTIVITY_GROUP
         SELECT *
           FROM CBS_OWNER.USAGE_ACTIVITY_GROUP_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_USAGE_ACTIVITY_GROUP',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_2_USAGE_ACTIVITY_TRANS (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.USAGE_ACTIVITY_TRANS
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.USAGE_ACTIVITY_TRANS
         SELECT *
           FROM CBS_OWNER.USAGE_ACTIVITY_TRANS_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_USAGE_ACTIVITY_TRANS',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_2_USAGE_PLAN (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.USAGE_PLAN
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.USAGE_PLAN
         SELECT *
           FROM CBS_OWNER.USAGE_PLAN_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_USAGE_PLAN',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_2_ZONE_GROUP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.ZONE_GROUP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.ZONE_GROUP
         SELECT *
           FROM CBS_OWNER.ZONE_GROUP_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_ZONE_GROUP',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_2_OFFER_RC_TERM_MAP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.OFFER_RC_TERM_MAP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.OFFER_RC_TERM_MAP
         SELECT *
           FROM CBS_OWNER.OFFER_RC_TERM_MAP_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_OFFER_RC_TERM_MAP',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_2_RC_RATE (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.RC_RATE
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.RC_RATE
         SELECT *
           FROM CBS_OWNER.RC_RATE_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_RC_RATE',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_2_BALANCE_EI (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE VNP_COMMON.BALANCE_EI
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO VNP_COMMON.BALANCE_EI
         SELECT *
           FROM CBS_OWNER.BALANCE_EI_VIEW
          WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_BALANCE_EI',
            'ELC_USER_FILTER_2',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;
END ELC_USER_FILTER_2;

/

GRANT EXECUTE ON ELC_USER_FILTER_2 TO CBS_OWNER;
