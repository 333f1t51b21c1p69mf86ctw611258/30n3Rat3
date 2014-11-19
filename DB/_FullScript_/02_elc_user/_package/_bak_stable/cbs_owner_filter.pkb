DROP PACKAGE BODY ELC_USER.CBS_OWNER_FILTER;

CREATE OR REPLACE PACKAGE BODY ELC_USER.CBS_OWNER_FILTER
AS
   /******************************************************************************
      NAME:       cbs_owner_filter
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
      MERGE INTO ELC_USER.RESELLER_VERSION A
           USING (SELECT RESELLER_VERSION_ID,
                         RESELLER_ID,
                         MAJOR_VERSION_NUM,
                         MINOR_VERSION_NUM,
                         ACTIVE_DATE,
                         INACTIVE_DATE,
                         SERVICE_VERSION_ID,
                         STATUS
                    FROM CBS_OWNER.RESELLER_VERSION_TMP
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
      CBS_OWNER_FILTER.GET_RESELLER_VERSIONS;

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


      -- NO RESELLER_VERSION ***
      CBS_OWNER_FILTER.FILTER_CURRENCY_TYPE;
      CBS_OWNER_FILTER.FILTER_UNIT_TYPE;
      CBS_OWNER_FILTER.FILTER_ZONE;

      -- NO RESELLER_VERSION ***

      OPEN c_reseller_version;

      LOOP
         FETCH c_reseller_version INTO r_reseller_version;

         EXIT WHEN c_reseller_version%NOTFOUND;

         CBS_OWNER_FILTER.FILTER_ACCUMULATOR (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_BALANCE (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_DISCOUNT_MODEL (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_OFFER_ACCUMULATOR_MAP (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_OFFER_BALANCE_MAP (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_OFFER_PRIORITY (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_OFFER_RC_AWARD_MAP (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_PRODUCT_OFFER (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_PROMO_PLAN (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_RUM_MAP (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_TARIFF_MODEL (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_TARIFF_PLAN (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_TIME_MAP (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_TIME_MODEL (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_USAGE_ACTIVITY (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_USAGE_ACTIVITY_GROUP (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_USAGE_ACTIVITY_TRANS (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_USAGE_PLAN (
            r_reseller_version.reseller_version_id);
         CBS_OWNER_FILTER.FILTER_ZONE_GROUP (
            r_reseller_version.reseller_version_id);
      --         DBMS_OUTPUT.PUT_LINE ('test ' || r_reseller_version.reseller_version_id);
      END LOOP;

      COMMIT;

      INS_ACTION_LOG ('RUNNING_FIRST',
                      'CBS_OWNER_FILTER',
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
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   -- DONE
   PROCEDURE LETS_GO (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      CHANGE_CHANGING_STATUS (1);

      CBS_OWNER_FILTER.GET_RESELLER_VERSIONS;

      --
      CBS_OWNER_FILTER.FILTER_ACCUMULATOR (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_BALANCE (i_reseller_version_id);
      --      CBS_OWNER_FILTER.FILTER_CURRENCY_TYPE (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_DISCOUNT_MODEL (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_OFFER_ACCUMULATOR_MAP (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_OFFER_BALANCE_MAP (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_OFFER_PRIORITY (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_OFFER_RC_AWARD_MAP (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_PRODUCT_OFFER (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_PROMO_PLAN (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_RUM_MAP (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_TARIFF_MODEL (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_TARIFF_PLAN (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_TIME_MAP (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_TIME_MODEL (i_reseller_version_id);
      --      CBS_OWNER_FILTER.FILTER_UNIT_TYPE (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_USAGE_ACTIVITY (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_USAGE_ACTIVITY_GROUP (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_USAGE_ACTIVITY_TRANS (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_USAGE_PLAN (i_reseller_version_id);
      --      CBS_OWNER_FILTER.FILTER_ZONE (i_reseller_version_id);
      CBS_OWNER_FILTER.FILTER_ZONE_GROUP (i_reseller_version_id);

      CHANGE_CHANGING_STATUS (0);

      COMMIT;

      EXECUTE IMMEDIATE
            'CALL VNP_COMMON.ELC_USER_FILTER.LETS_GO@EONERATE_VNP_COMMON ('
         || i_reseller_version_id
         || ')';

      INS_ACTION_LOG (
         'LETS_GO',
         'CBS_OWNER_FILTER',
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
            'CBS_OWNER_FILTER',
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
         job_name            => '"ELC_USER"."JOB_FILTER_NEW_PCAT_DATA"',
         argument_position   => 1,
         argument_value      => i_reseller_version_id);

      -- Run job synchronously.
      DBMS_SCHEDULER.run_job (
         job_name              => '"ELC_USER"."JOB_FILTER_NEW_PCAT_DATA"',
         use_current_session   => FALSE);
   END;

   -- NO RESELLER_VERSION *****************************************************
   PROCEDURE FILTER_CURRENCY_TYPE
   IS
   BEGIN
      DELETE ELC_USER.CURRENCY_TYPE
       WHERE 1 = 1;

      INSERT INTO ELC_USER.CURRENCY_TYPE (CURRENCY_CODE,
                                          CURRENCY_NAME,
                                          TYPE_NAME,
                                          TYPE_ID,
                                          ACTIVE_DATE,
                                          INACTIVE_DATE,
                                          ROUNDING_FACTOR,
                                          ISO_CODE,
                                          ISO_NUMBER,
                                          DESCRIPTION)
         SELECT t1.CURRENCY_CODE AS currency_code,
                t3.DISPLAY_VALUE AS currency_name,
                t5.DISPLAY_VALUE AS type_name,
                t2.CURRENCY_TYPE AS type_id,
                t2.ACTIVE_DATE AS active_Date,
                t2.INACTIVE_DATE AS inactive_Date,
                t2.ROUNDING_FACTOR AS rounding_Factor,
                --          t2.IS_DEFAULT AS is_Default,
                --          t2.IS_INTERNAL AS is_Internal,
                t2.ISO_CODE AS iso_Code,
                t2.ISO_NUMBER AS iso_Number,
                t3.DESCRIPTION AS description
           FROM cbs_owner.RATE_CURRENCY_KEY t1
                INNER JOIN cbs_owner.RATE_CURRENCY_REF t2
                   ON t1.CURRENCY_CODE = t2.CURRENCY_CODE
                INNER JOIN
                cbs_owner.RATE_CURRENCY_VALUES t3
                   ON     t2.CURRENCY_CODE = t3.CURRENCY_CODE
                      AND t2.SERVICE_VERSION_ID = t3.SERVICE_VERSION_ID
                INNER JOIN cbs_owner.CURRENCY_TYPE_REF t4
                   ON t2.CURRENCY_TYPE = t4.CURRENCY_TYPE
                INNER JOIN
                cbs_owner.CURRENCY_TYPE_VALUES t5
                   ON     t4.CURRENCY_TYPE = t5.CURRENCY_TYPE
                      AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t6
                   ON     t6.enumeration_key = LOWER ('ROUNDING_METHOD')
                      AND t6.VALUE = t2.ROUNDING_METHOD
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t7
                   ON     t7.enumeration_key = t6.enumeration_key
                      AND t7.VALUE = t6.VALUE
                      AND t7.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE t2.SERVICE_VERSION_ID = 1 AND t3.LANGUAGE_CODE = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_CURRENCY_TYPE',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_UNIT_TYPE
   IS
   BEGIN
      DELETE ELC_USER.UNIT_TYPE
       WHERE 1 = 1;

      INSERT INTO ELC_USER.UNIT_TYPE (TYPE_ID, TYPE_NAME, DESCRIPTION)
         SELECT t1.UNIT_TYPE AS type_id,                          -- unitType,
                --       t2.SERVICE_VERSION_ID AS serviceVersionId,
                --       t2.IS_USAGE AS isUsage,
                --       t2.IS_RC AS isRc,
                --       t2.IS_DEFAULT AS isDefault,
                --       t2.IS_INTERNAL AS isInternal,
                --       t2.UNIT_CODE AS unitCode,
                --       t3.LANGUAGE_CODE AS languageCode,
                t3.DISPLAY_VALUE AS type_name,                -- displayValue,
                t3.DESCRIPTION AS description
           FROM cbs_owner.UNITS_TYPE_KEY t1
                INNER JOIN cbs_owner.UNITS_TYPE_REF t2
                   ON t1.UNIT_TYPE = t2.UNIT_TYPE
                INNER JOIN
                cbs_owner.UNITS_TYPE_VALUES t3
                   ON     t2.UNIT_TYPE = t3.UNIT_TYPE
                      AND t2.SERVICE_VERSION_ID = t3.SERVICE_VERSION_ID
          WHERE t2.SERVICE_VERSION_ID = 1 AND t3.LANGUAGE_CODE = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_UNIT_TYPE',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_ZONE
   IS
   BEGIN
      DELETE ELC_USER.ZONE
       WHERE 1 = 1;

      INSERT INTO ELC_USER.ZONE (ZONE_ID,
                                 LI,
                                 ZONE_NAME,
                                 PART_OF,
                                 TIME_ZONE_NAME,
                                 TIME_ZONE_ID,
                                 HIERARCHY_NAME,
                                 HIERARCHY_ID,
                                 TRANSLATION_ID,
                                 GLT_NUMBER)
         SELECT t1.GLOBAL_LOCATION_ID AS zone_id,         -- globalLocationId,
                T1.LI,
                t1.LOCATION AS zone_name,                         -- location,
                --       t1.SERVICE_VERSION_ID AS serviceVersionId,
                --       t1.LI AS li,
                t1.PART_OF AS part_of,                              -- partOf,
                t4.DISPLAY_VALUE AS time_zone_name,            -- timezoneKey,
                t1.TIMEZONE AS time_zone_id,                      -- timezone,
                --       t1.SORT_BY AS sortBy,
                --       t1.GLL_LEVEL AS gllLevel,
                --       t1.IS_FA_ELIGIBLE AS isFaEligible,
                t7.DISPLAY_VALUE AS hierarchy_name,   -- locationHierarchyKey,
                t1.HIERARCHY_LEVEL_ID AS hierarchy_id,    -- hierarchyLevelId,
                -- add translation
                t21.GLOBAL_TRANSLATION_ID AS translation_id, -- globalTranslationId,
                t21.GLT_NUMBER AS glt_number                -- , -- gltNumber,
           --       t23.DISPLAY_VALUE AS TYPE,
           --       t21.SERVICE_VERSION_ID AS serviceVersionId,
           --       t21.LOCATION AS location,
           --       t25.DISPLAY_VALUE AS oppsQueryType,
           --       t27.DISPLAY_VALUE AS tppsQueryType
           FROM cbs_owner.GLOBAL_LOCATION t1
                LEFT OUTER JOIN cbs_owner.TIMEZONE_KEY t2
                   ON t1.TIMEZONE = t2.TIMEZONE
                LEFT OUTER JOIN
                cbs_owner.TIMEZONE_REF t3
                   ON     t2.TIMEZONE = t3.TIMEZONE
                      AND t3.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.TIMEZONE_VALUES t4
                   ON     t2.TIMEZONE = t4.TIMEZONE
                      AND t4.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
                      AND t4.LANGUAGE_CODE = 1
                LEFT OUTER JOIN cbs_owner.LOCATION_HIERARCHY_KEY t5
                   ON t1.HIERARCHY_LEVEL_ID = t5.HIERARCHY_LEVEL_ID
                LEFT OUTER JOIN
                cbs_owner.LOCATION_HIERARCHY_REF t6
                   ON     t5.HIERARCHY_LEVEL_ID = t6.HIERARCHY_LEVEL_ID
                      AND t6.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.LOCATION_HIERARCHY_VALUES t7
                   ON     t5.HIERARCHY_LEVEL_ID = t7.HIERARCHY_LEVEL_ID
                      AND t7.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
                      AND t7.LANGUAGE_CODE = 1
                -- add translation
                INNER JOIN
                cbs_owner.GLOBAL_TRANSLATION t21
                   ON     T21.LOCATION = T1.LOCATION
                      AND T21.SERVICE_VERSION_ID = T1.SERVICE_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t22
                   ON     t22.enumeration_key = LOWER ('TYPE')
                      AND t22.VALUE = t21.TYPE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t23
                   ON     t23.enumeration_key = t22.enumeration_key
                      AND t23.VALUE = t22.VALUE
                      AND t23.LANGUAGE_CODE = 1
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t24
                   ON     t24.enumeration_key = LOWER ('OPPS_QUERY_TYPE')
                      AND t24.VALUE = t21.OPPS_QUERY_TYPE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t25
                   ON     t25.enumeration_key = t24.enumeration_key
                      AND t25.VALUE = t24.VALUE
                      AND t25.LANGUAGE_CODE = 1
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t26
                   ON     t26.enumeration_key = LOWER ('TPPS_QUERY_TYPE')
                      AND t26.VALUE = t21.TPPS_QUERY_TYPE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t27
                   ON     t27.enumeration_key = t26.enumeration_key
                      AND t27.VALUE = t26.VALUE
                      AND t27.LANGUAGE_CODE = 1
          WHERE t1.SERVICE_VERSION_ID = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_ZONE',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   -- NO RESELLER_VERSION *****************************************************


   PROCEDURE FILTER_ACCUMULATOR (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.ACCUMULATOR
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO ELC_USER.ACCUMULATOR (ACCUMULATOR_ID,
                                        ACCUMULATOR_NAME,
                                        RESELLER_VERSION_ID,
                                        UNIT_TYPE_NAME,
                                        UNIT_TYPE_ID,
                                        PERIOD_ID,
                                        PERIOD_NAME,
                                        RESET_POINT,
                                        TYPE_ID,
                                        TYPE_NAME,
                                        COUNT_TYPE_ID,
                                        COUNT_TYPE_NAME,
                                        DESCRIPTION)
         SELECT t1.ACCUMULATOR_ID AS accumulator_id,         -- accumulatorId,
                t3.DISPLAY_VALUE AS accumulator_name,         -- displayValue,
                t2.RESELLER_VERSION_ID AS reseller_version_id, -- resellerVersionId,
                --    t5.SERVICE_VERSION_ID as serviceVersionId,
                t6.DISPLAY_VALUE AS unit_type_name,           -- unitsTypeKey,
                t2.UNIT_TYPE AS unit_type_id,                     -- unitType,
                T7.FIELD_NAME || '_' || T7.INTEGER_VALUE AS period_id,
                t8.DISPLAY_VALUE AS period_name,
                t2.RESET_POINT AS reset_point,
                -- resetPoint,
                t9.ENUMERATION_KEY || '_' || t9.VALUE AS type_id,
                t10.DISPLAY_VALUE AS type_name,            -- accumulatorType,
                T11.ENUMERATION_KEY || '_' || T11.VALUE AS count_type_id,
                t12.DISPLAY_VALUE AS count_type_name,            -- countType,
                --    t14.DISPLAY_VALUE as accQualifyType,
                --    t3.LANGUAGE_CODE as languageCode,
                t3.DESCRIPTION AS description
           FROM cbs_owner.ACCUMULATOR_KEY t1
                INNER JOIN cbs_owner.ACCUMULATOR_REF t2
                   ON t1.ACCUMULATOR_ID = t2.ACCUMULATOR_ID
                INNER JOIN
                cbs_owner.ACCUMULATOR_VALUES t3
                   ON     t2.ACCUMULATOR_ID = t3.ACCUMULATOR_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                INNER JOIN cbs_owner.UNITS_TYPE_KEY t4
                   ON t2.UNIT_TYPE = t4.UNIT_TYPE
                INNER JOIN
                cbs_owner.UNITS_TYPE_REF t5
                   ON     t4.UNIT_TYPE = t5.UNIT_TYPE
                      AND t5.SERVICE_VERSION_ID = 1
                INNER JOIN
                cbs_owner.UNITS_TYPE_VALUES t6
                   ON     t4.UNIT_TYPE = t6.UNIT_TYPE
                      AND t6.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                      AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_REF t7
                   ON     t7.table_name = 'ACCUMULATOR_REF'
                      AND t7.field_name = LOWER ('PERIOD')
                      AND t7.integer_value = t2.PERIOD
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_VALUES t8
                   ON     t8.table_name = t7.table_name
                      AND t8.field_name = t7.field_name
                      AND t8.integer_value = t7.integer_value
                      AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t9
                   ON     t9.enumeration_key = LOWER ('ACCUMULATOR_TYPE')
                      AND t9.VALUE = t2.ACCUMULATOR_TYPE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t10
                   ON     t10.enumeration_key = t9.enumeration_key
                      AND t10.VALUE = t9.VALUE
                      AND t10.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t11
                   ON     t11.enumeration_key = LOWER ('COUNT_TYPE')
                      AND t11.VALUE = t2.COUNT_TYPE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t12
                   ON     t12.enumeration_key = t11.enumeration_key
                      AND t12.VALUE = t11.VALUE
                      AND t12.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t13
                   ON     t13.enumeration_key = LOWER ('ACC_QUALIFY_TYPE')
                      AND t13.VALUE = t2.ACC_QUALIFY_TYPE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t14
                   ON     t14.enumeration_key = t13.enumeration_key
                      AND t14.VALUE = t13.VALUE
                      AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = i_reseller_version_id
                AND t3.LANGUAGE_CODE = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_ACCUMULATOR',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_BALANCE (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.BALANCE
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;


      INSERT INTO ELC_USER.BALANCE (BALANCE_ID,
                                    RESELLER_VERSION_ID,
                                    UNIT_TYPE_NAME,
                                    UNIT_TYPE_ID,
                                    BALANCE_NAME,
                                    DESCRIPTION)
         SELECT t1.BALANCE_ID AS balance_id,                     -- balanceId,
                t2.RESELLER_VERSION_ID AS reseller_version_id, -- resellerVersionId,
                --       t5.SERVICE_VERSION_ID AS serviceVersionId,
                t6.DISPLAY_VALUE AS unit_type_name,           -- unitsTypeKey,
                t2.UNIT_TYPE AS unit_type_id,                     -- unitType,
                --       t8.DISPLAY_VALUE AS anncTypePromptRef,
                --       t2.ANNC_TYPE_ID AS anncTypeId,
                --       t2.IS_EXT_EXPOSABLE AS isExtExposable,
                --       t2.IS_INTERNAL AS isInternal,
                --       t2.IS_DEFAULT AS isDefault,
                --       t3.LANGUAGE_CODE AS languageCode,
                t3.DISPLAY_VALUE AS balance_name,             -- displayValue,
                t3.DESCRIPTION AS description
           FROM cbs_owner.BALANCE_KEY t1
                INNER JOIN cbs_owner.BALANCE_REF t2
                   ON t1.BALANCE_ID = t2.BALANCE_ID
                INNER JOIN
                cbs_owner.BALANCE_VALUES t3
                   ON     t2.BALANCE_ID = t3.BALANCE_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                INNER JOIN cbs_owner.UNITS_TYPE_KEY t4
                   ON t2.UNIT_TYPE = t4.UNIT_TYPE
                INNER JOIN
                cbs_owner.UNITS_TYPE_REF t5
                   ON     t4.UNIT_TYPE = t5.UNIT_TYPE
                      AND t5.SERVICE_VERSION_ID = 1
                INNER JOIN
                cbs_owner.UNITS_TYPE_VALUES t6
                   ON     t4.UNIT_TYPE = t6.UNIT_TYPE
                      AND t6.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                      AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.ANNC_TYPE_PROMPT_REF t7
                   ON t2.ANNC_TYPE_ID = t7.ANNC_TYPE_ID
                LEFT OUTER JOIN
                cbs_owner.ANNC_TYPE_PROMPT_VALUES t8
                   ON     t7.ANNC_TYPE_ID = t8.ANNC_TYPE_ID
                      AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_BALANCE',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_DISCOUNT_MODEL (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.DISCOUNT_MODEL
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;


      INSERT INTO ELC_USER.DISCOUNT_MODEL (DISCOUNT_ITEM_ID,
                                           DISCOUNT_ITEM_NAME,
                                           RESELLER_VERSION_ID,
                                           DISCOUNT_NAME,
                                           DISCOUNT_ID,
                                           UA_NAME,
                                           UA_ID,
                                           UA_GROUP_NAME,
                                           UA_GROUP_ID,
                                           ITEM_DESC,
                                           ACCUMULATOR_NAME,
                                           ACCUMULATOR_ID,
                                           DISCOUNT_TYPE_ID,
                                           DISCOUNT_TYPE_NAME,
                                           CURRENCY_NAME,
                                           CURRENCY_CODE,
                                           DISCOUNT_DESC,
                                           AWARD_ID,
                                           AWARD_NAME,
                                           THRESHOLD,
                                           AMOUNT,
                                           AWARD_DESC)
         SELECT t41.DISCOUNT_ITEM_ID AS discount_item_id,   -- discountItemId,
                t43.DISPLAY_VALUE AS discount_item_name,      -- displayValue,
                t42.RESELLER_VERSION_ID,              -- AS resellerVersionId,
                t46.DISPLAY_VALUE AS discount_name,          -- rtDiscountKey,
                t42.RT_DISCOUNT_ID AS discount_id,            -- rtDiscountId,
                t49.DISPLAY_VALUE AS ua_name,                  -- autFinalKey,
                t42.AUT_ID AS ua_id,                                 -- autId,
                t52.DISPLAY_VALUE AS ua_group_name,            -- autGroupKey,
                t42.AUT_GROUP_ID AS ua_group_id,                -- autGroupId,
                --       t42.IS_DEFAULT AS isDefault,
                --       t42.IS_INTERNAL AS isInternal,
                --       t43.LANGUAGE_CODE AS languageCode,

                t43.DESCRIPTION AS item_desc,                  -- description,
                -- {{{ add discount
                --       t44.RT_DISCOUNT_ID AS discount_id,
                --       t46.DISPLAY_VALUE AS discount_name,
                --       t45.RESELLER_VERSION_ID AS resellerVersionId,
                t6.DISPLAY_VALUE AS accumulator_name, -- accumulatorKeyByAccumulatorId,
                t45.ACCUMULATOR_ID AS accumulator_id,        -- accumulatorId,
                T7.ENUMERATION_KEY || '_' || T7.VALUE AS discount_type_id,
                t8.DISPLAY_VALUE AS discount_type_name,       -- discountType,
                --       t10.SERVICE_VERSION_ID AS serviceVersionId,
                --       t10.ISO_CODE AS currencyIsoCode,
                --       t10.IMPLIED_DECIMAL AS currencyImpliedDecimal,
                t11.DISPLAY_VALUE AS currency_name,        -- rateCurrencyKey,
                t45.CURRENCY_CODE AS currency_code,           -- currencyCode,
                --       t14.DISPLAY_VALUE AS accumulatorKeyByAddonAccId1,
                --       t45.ADDON_ACC_ID1 AS addonAccId1,
                --       t17.DISPLAY_VALUE AS accumulatorKeyByAddonAccId2,
                --       t45.ADDON_ACC_ID2 AS addonAccId2,
                --       t20.DISPLAY_VALUE AS accumulatorKeyByAddonAccId3,
                --       t45.ADDON_ACC_ID3 AS addonAccId3,
                --       t23.DISPLAY_VALUE AS accumulatorKeyByAddonAccId4,
                --       t45.ADDON_ACC_ID4 AS addonAccId4,
                --       t45.RESET_FLAG AS resetFlag,
                --       t45.IS_DEFAULT AS isDefault,
                --       t45.IS_INTERNAL AS isInternal,
                --       t46.LANGUAGE_CODE AS languageCode,

                t46.DESCRIPTION AS discount_desc,              -- description,
                -- }}} add discount
                -- {{{ add discount award
                t62.DISCOUNT_AWARD_ID AS award_id,         -- discountAwardId,
                t63.DISPLAY_VALUE AS award_name,              -- displayValue,
                --       t62.RESELLER_VERSION_ID AS resellerVersionId,
                --       t66.DISPLAY_VALUE AS rtDiscountKey,
                --       t62.RT_DISCOUNT_ID AS rtDiscountId,
                t62.THRESHOLD AS threshold,
                t62.AMOUNT AS amount,
                --       t45.currency_code,
                --       t70.iso_code AS currencyIsoCode,
                --       t70.implied_decimal AS currencyImpliedDecimals,
                --       t62.ADDON_THRES1 AS addonThres1,
                --       t62.ADDON_THRES2 AS addonThres2,
                --       t62.ADDON_THRES3 AS addonThres3,
                --       t62.ADDON_THRES4 AS addonThres4,
                --       t68.DISPLAY_VALUE AS rewardEventType,
                --       t62.REWARD_NOTIF_TEXT AS rewardNotifText,
                --       t62.UNICODE_FLAG AS unicodeFlag,
                --       t63.LANGUAGE_CODE AS languageCode,

                t63.DESCRIPTION AS award_desc                   -- description
           FROM cbs_owner.RT_DISCOUNT_ITEM_KEY t41
                INNER JOIN cbs_owner.RT_DISCOUNT_ITEM_REF t42
                   ON t41.DISCOUNT_ITEM_ID = t42.DISCOUNT_ITEM_ID
                INNER JOIN
                cbs_owner.RT_DISCOUNT_ITEM_VALUES t43
                   ON     t42.DISCOUNT_ITEM_ID = t43.DISCOUNT_ITEM_ID
                      AND t42.RESELLER_VERSION_ID = t43.RESELLER_VERSION_ID
                -- {{{ add discount

                -- { modify
                INNER JOIN cbs_owner.RT_DISCOUNT_KEY t44
                   ON t42.RT_DISCOUNT_ID = t44.RT_DISCOUNT_ID
                INNER JOIN
                cbs_owner.RT_DISCOUNT_REF t45
                   ON     t44.RT_DISCOUNT_ID = t45.RT_DISCOUNT_ID
                      AND t45.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.RT_DISCOUNT_VALUES t46
                   ON     t44.RT_DISCOUNT_ID = t46.RT_DISCOUNT_ID
                      AND t46.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
                      AND t46.LANGUAGE_CODE = t43.LANGUAGE_CODE
                -- } modify

                INNER JOIN cbs_owner.ACCUMULATOR_KEY t4
                   ON t45.ACCUMULATOR_ID = t4.ACCUMULATOR_ID
                INNER JOIN
                cbs_owner.ACCUMULATOR_REF t5
                   ON     t4.ACCUMULATOR_ID = t5.ACCUMULATOR_ID
                      AND t5.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.ACCUMULATOR_VALUES t6
                   ON     t4.ACCUMULATOR_ID = t6.ACCUMULATOR_ID
                      AND t6.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                      AND t6.LANGUAGE_CODE = t46.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t7
                   ON     t7.enumeration_key = LOWER ('DISCOUNT_TYPE')
                      AND t7.VALUE = t45.DISCOUNT_TYPE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t8
                   ON     t8.enumeration_key = t7.enumeration_key
                      AND t8.VALUE = t7.VALUE
                      AND t8.LANGUAGE_CODE = t46.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_KEY t9
                   ON t45.CURRENCY_CODE = t9.CURRENCY_CODE
                LEFT OUTER JOIN
                cbs_owner.RATE_CURRENCY_REF t10
                   ON     t9.CURRENCY_CODE = t10.CURRENCY_CODE
                      AND t10.SERVICE_VERSION_ID = 1
                LEFT OUTER JOIN
                cbs_owner.RATE_CURRENCY_VALUES t11
                   ON     t9.CURRENCY_CODE = t11.CURRENCY_CODE
                      AND t11.SERVICE_VERSION_ID = 1
                      AND t11.LANGUAGE_CODE = t46.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.ACCUMULATOR_KEY t12
                   ON t45.ADDON_ACC_ID1 = t12.ACCUMULATOR_ID
                LEFT OUTER JOIN
                cbs_owner.ACCUMULATOR_REF t13
                   ON     t12.ACCUMULATOR_ID = t13.ACCUMULATOR_ID
                      AND t13.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.ACCUMULATOR_VALUES t14
                   ON     t12.ACCUMULATOR_ID = t14.ACCUMULATOR_ID
                      AND t14.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                      AND t14.LANGUAGE_CODE = t46.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.ACCUMULATOR_KEY t15
                   ON t45.ADDON_ACC_ID2 = t15.ACCUMULATOR_ID
                LEFT OUTER JOIN
                cbs_owner.ACCUMULATOR_REF t16
                   ON     t15.ACCUMULATOR_ID = t16.ACCUMULATOR_ID
                      AND t16.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.ACCUMULATOR_VALUES t17
                   ON     t15.ACCUMULATOR_ID = t17.ACCUMULATOR_ID
                      AND t17.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                      AND t17.LANGUAGE_CODE = t46.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.ACCUMULATOR_KEY t18
                   ON t45.ADDON_ACC_ID3 = t18.ACCUMULATOR_ID
                LEFT OUTER JOIN
                cbs_owner.ACCUMULATOR_REF t19
                   ON     t18.ACCUMULATOR_ID = t19.ACCUMULATOR_ID
                      AND t19.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.ACCUMULATOR_VALUES t20
                   ON     t18.ACCUMULATOR_ID = t20.ACCUMULATOR_ID
                      AND t20.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                      AND t20.LANGUAGE_CODE = t46.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.ACCUMULATOR_KEY t21
                   ON t45.ADDON_ACC_ID4 = t21.ACCUMULATOR_ID
                LEFT OUTER JOIN
                cbs_owner.ACCUMULATOR_REF t22
                   ON     t21.ACCUMULATOR_ID = t22.ACCUMULATOR_ID
                      AND t22.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.ACCUMULATOR_VALUES t23
                   ON     t21.ACCUMULATOR_ID = t23.ACCUMULATOR_ID
                      AND t23.RESELLER_VERSION_ID = t45.RESELLER_VERSION_ID
                      AND t23.LANGUAGE_CODE = t46.LANGUAGE_CODE
                -- }}} add discount

                LEFT OUTER JOIN cbs_owner.AUT_FINAL_KEY t47
                   ON t42.AUT_ID = t47.AUT_ID
                LEFT OUTER JOIN
                cbs_owner.AUT_FINAL_REF t48
                   ON     t47.AUT_ID = t48.AUT_ID
                      AND t48.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.AUT_FINAL_VALUES t49
                   ON     t47.AUT_ID = t49.AUT_ID
                      AND t49.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
                      AND t49.LANGUAGE_CODE = t43.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.AUT_GROUP_KEY t50
                   ON t42.AUT_GROUP_ID = t50.AUT_GROUP_ID
                LEFT OUTER JOIN
                cbs_owner.AUT_GROUP_REF t51
                   ON     t50.AUT_GROUP_ID = t51.AUT_GROUP_ID
                      AND t51.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.AUT_GROUP_VALUES t52
                   ON     t50.AUT_GROUP_ID = t52.AUT_GROUP_ID
                      AND t52.RESELLER_VERSION_ID = t42.RESELLER_VERSION_ID
                      AND t52.LANGUAGE_CODE = t43.LANGUAGE_CODE
                -- {{{ add discount award
                --  cbs_owner.DISCOUNT_AWARD_KEY t61
                INNER JOIN
                cbs_owner.DISCOUNT_AWARD_REF t62 --          ON     t61.DISCOUNT_AWARD_ID = t62.DISCOUNT_AWARD_ID
                   /*AND*/
                   ON     t62.RT_DISCOUNT_ID = t44.RT_DISCOUNT_ID
                      AND t45.RESELLER_VERSION_ID = t62.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DISCOUNT_AWARD_VALUES t63
                   ON     t62.DISCOUNT_AWARD_ID = t63.DISCOUNT_AWARD_ID
                      AND t62.RESELLER_VERSION_ID = t63.RESELLER_VERSION_ID
                --       INNER JOIN cbs_owner.RT_DISCOUNT_KEY t44
                --          ON t62.RT_DISCOUNT_ID = t44.RT_DISCOUNT_ID
                --       INNER JOIN cbs_owner.RT_DISCOUNT_REF t45
                --          ON     t44.RT_DISCOUNT_ID = t45.RT_DISCOUNT_ID
                --             AND t45.RESELLER_VERSION_ID = t62.RESELLER_VERSION_ID

                LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_KEY t69
                   ON t45.currency_code = t69.Currency_Code
                LEFT OUTER JOIN
                cbs_owner.RATE_CURRENCY_REF t70
                   ON     t69.currency_code = t70.currency_code
                      AND t70.service_version_id = 1
                INNER JOIN
                cbs_owner.RT_DISCOUNT_VALUES t66
                   ON     t44.RT_DISCOUNT_ID = t66.RT_DISCOUNT_ID
                      AND t66.RESELLER_VERSION_ID = t62.RESELLER_VERSION_ID
                      AND t66.LANGUAGE_CODE = t63.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_REF t67
                   ON     t67.table_name = 'DISCOUNT_AWARD_REF'
                      AND t67.field_name = LOWER ('REWARD_EVENT_TYPE')
                      AND t67.integer_value = t62.REWARD_EVENT_TYPE
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_VALUES t68
                   ON     t68.table_name = t67.table_name
                      AND t68.field_name = t67.field_name
                      AND t68.integer_value = t67.integer_value
                      AND t68.LANGUAGE_CODE = t63.LANGUAGE_CODE
          WHERE     t42.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t43.LANGUAGE_CODE = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_DISCOUNT_MODEL',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_OFFER_ACCUMULATOR_MAP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.OFFER_ACCUMULATOR_MAP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO ELC_USER.OFFER_ACCUMULATOR_MAP (RESELLER_VERSION_ID,
                                                  OFFER_NAME,
                                                  OFFER_ID,
                                                  ACCUMULATOR_NAME,
                                                  ACCUMULATOR_ID)
         SELECT t1.RESELLER_VERSION_ID,               -- AS resellerVersionId,
                t4.DISPLAY_VALUE AS offer_name,                   -- offerKey,
                t1.OFFER_ID AS offer_id,                           -- offerId,
                t7.DISPLAY_VALUE AS accumulator_name,       -- accumulatorKey,
                t1.ACCUMULATOR_ID AS accumulator_id           -- accumulatorId
           FROM cbs_owner.OFFER_ACCUMULATOR_MAP t1
                INNER JOIN cbs_owner.OFFER_KEY t2
                   ON t1.OFFER_ID = t2.OFFER_ID
                INNER JOIN
                cbs_owner.OFFER_REF t3
                   ON     t2.OFFER_ID = t3.OFFER_ID
                      AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.OFFER_VALUES t4
                   ON     t2.OFFER_ID = t4.OFFER_ID
                      AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                      AND t4.LANGUAGE_CODE = 1
                INNER JOIN cbs_owner.ACCUMULATOR_KEY t5
                   ON t1.ACCUMULATOR_ID = t5.ACCUMULATOR_ID
                INNER JOIN
                cbs_owner.ACCUMULATOR_REF t6
                   ON     t5.ACCUMULATOR_ID = t6.ACCUMULATOR_ID
                      AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.ACCUMULATOR_VALUES t7
                   ON     t5.ACCUMULATOR_ID = t7.ACCUMULATOR_ID
                      AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                      AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
          WHERE t1.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_OFFER_ACCUMULATOR_MAP',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_OFFER_BALANCE_MAP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.OFFER_BALANCE_MAP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;


      INSERT INTO ELC_USER.OFFER_BALANCE_MAP (BALANCE_NAME,
                                              BALANCE_ID,
                                              OFFER_NAME,
                                              OFFER_ID,
                                              RESELLER_VERSION_ID,
                                              BALANCE_ORDER,
                                              IS_SHADOW,
                                              IS_CORE,
                                              EXPIRATION_DATE,
                                              MIN_BALANCE,
                                              MAX_BALANCE,
                                              EXPIRATION_OPTION,
                                              DEFAULT_EXPIRATION_OFFSET,
                                              IS_SHARED,
                                              DEFAULT_LIMIT_TYPE,
                                              DEFAULT_LIMIT_VALUE,
                                              DEFAULT_LIMIT_PERIOD)
           SELECT t4.DISPLAY_VALUE AS balance_name,             -- balanceKey,
                  t1.BALANCE_ID AS balance_id,                   -- balanceId,
                  t7.DISPLAY_VALUE AS offer_name,                 -- offerKey,
                  t1.OFFER_ID AS offer_id,                         -- offerId,
                  t1.RESELLER_VERSION_ID AS reseller_version_id, -- resellerVersionId,
                  t1.BALANCE_ORDER AS balance_order,          -- balanceOrder,
                  --         t9.DISPLAY_VALUE AS shadowRealOpt,
                  CASE t9.DISPLAY_VALUE WHEN 'Real' THEN 0 ELSE 1 END
                     AS is_shadow,
                  t1.IS_CORE AS is_core,                            -- isCore,
                  t1.EXPIRATION_DATE AS expiration_date,    -- expirationDate,
                  t1.MIN_BALANCE AS min_balance,                -- minBalance,
                  t1.MAX_BALANCE AS max_balance,                -- maxBalance,
                  --         t1.GRANT_AMOUNT AS grantAmount,
                  --         t1.GRANT_START_DATE AS grantStartDate,
                  --         t1.GRANT_END_DATE AS grantEndDate,
                  --         t11.DISPLAY_VALUE AS grantExpirationType,
                  t13.DISPLAY_VALUE AS expiration_option,     -- expireOption,
                  t1.DEFAULT_EXPIRATION_OFFSET AS default_expiration_offset, -- defaultExpirationOffset,
                  --         t15.DISPLAY_VALUE AS balancePaymentMode,
                  t1.IS_SHARED AS is_shared,                       --isShared,
                  --         t1.ALLOW_INST_AS_SHADOW AS allowInstAsShadow,
                  t17.DISPLAY_VALUE AS default_limit_type, -- defaultLimitType,
                  t1.DEFAULT_LIMIT_VALUE AS default_limit_value, -- defaultLimitValue,
                  t19.DISPLAY_VALUE AS default_limit_period -- , -- defaultLimitPeriod,
             --         t22.DISPLAY_VALUE AS offerKeyByAccountOfferId,
             --         t1.ACCOUNT_OFFER_ID AS accountOfferId,
             --         t25.DISPLAY_VALUE AS balanceKeyByAccountOfferBalanc,
             --         t1.ACCOUNT_OFFER_BALANCE_ID AS accountOfferBalanceId,
             --         t1.USG_EXCL_INCL AS usgExclIncl,
             --         t1.RC_EXCL_INCL AS rcExclIncl,
             --         t1.NRC_EXCL_INCL AS nrcExclIncl
             FROM cbs_owner.OFFER_BALANCE_MAP t1
                  INNER JOIN cbs_owner.BALANCE_KEY t2
                     ON t1.BALANCE_ID = t2.BALANCE_ID
                  INNER JOIN
                  cbs_owner.BALANCE_REF t3
                     ON     t2.BALANCE_ID = t3.BALANCE_ID
                        AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                  INNER JOIN
                  cbs_owner.BALANCE_VALUES t4
                     ON     t2.BALANCE_ID = t4.BALANCE_ID
                        AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                        AND t4.LANGUAGE_CODE = 1
                  INNER JOIN cbs_owner.OFFER_KEY t5
                     ON t1.OFFER_ID = t5.OFFER_ID
                  INNER JOIN
                  cbs_owner.OFFER_REF t6
                     ON     t5.OFFER_ID = t6.OFFER_ID
                        AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                  INNER JOIN
                  cbs_owner.OFFER_VALUES t7
                     ON     t5.OFFER_ID = t7.OFFER_ID
                        AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                        AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
                  LEFT OUTER JOIN
                  cbs_owner.GENERIC_ENUMERATION_REF t8
                     ON     t8.enumeration_key = LOWER ('SHADOW_REAL_OPT')
                        AND t8.VALUE = t1.SHADOW_REAL_OPT
                  LEFT OUTER JOIN
                  cbs_owner.GENERIC_ENUMERATION_VALUES t9
                     ON     t9.enumeration_key = t8.enumeration_key
                        AND t9.VALUE = t8.VALUE
                        AND t9.LANGUAGE_CODE = t4.LANGUAGE_CODE
                  LEFT OUTER JOIN
                  cbs_owner.GUI_INDICATOR_REF t10
                     ON     t10.table_name = 'OFFER_BALANCE_MAP'
                        AND t10.field_name = LOWER ('GRANT_EXPIRATION_TYPE')
                        AND t10.integer_value = t1.GRANT_EXPIRATION_TYPE
                  LEFT OUTER JOIN
                  cbs_owner.GUI_INDICATOR_VALUES t11
                     ON     t11.table_name = t10.table_name
                        AND t11.field_name = t10.field_name
                        AND t11.integer_value = t10.integer_value
                        AND t11.LANGUAGE_CODE = t4.LANGUAGE_CODE
                  LEFT OUTER JOIN
                  cbs_owner.GUI_INDICATOR_REF t12
                     ON     t12.table_name = 'OFFER_BALANCE_MAP'
                        AND t12.field_name = LOWER ('EXPIRE_OPTION')
                        AND t12.integer_value = t1.EXPIRE_OPTION
                  LEFT OUTER JOIN
                  cbs_owner.GUI_INDICATOR_VALUES t13
                     ON     t13.table_name = t12.table_name
                        AND t13.field_name = t12.field_name
                        AND t13.integer_value = t12.integer_value
                        AND t13.LANGUAGE_CODE = t4.LANGUAGE_CODE
                  LEFT OUTER JOIN
                  cbs_owner.GENERIC_ENUMERATION_REF t14
                     ON     t14.enumeration_key =
                               LOWER ('BALANCE_PAYMENT_MODE')
                        AND t14.VALUE = t1.BALANCE_PAYMENT_MODE
                  LEFT OUTER JOIN
                  cbs_owner.GENERIC_ENUMERATION_VALUES t15
                     ON     t15.enumeration_key = t14.enumeration_key
                        AND t15.VALUE = t14.VALUE
                        AND t15.LANGUAGE_CODE = t4.LANGUAGE_CODE
                  LEFT OUTER JOIN
                  cbs_owner.GUI_INDICATOR_REF t16
                     ON     t16.table_name = 'OFFER_BALANCE_MAP'
                        AND t16.field_name = LOWER ('DEFAULT_LIMIT_TYPE')
                        AND t16.integer_value = t1.DEFAULT_LIMIT_TYPE
                  LEFT OUTER JOIN
                  cbs_owner.GUI_INDICATOR_VALUES t17
                     ON     t17.table_name = t16.table_name
                        AND t17.field_name = t16.field_name
                        AND t17.integer_value = t16.integer_value
                        AND t17.LANGUAGE_CODE = t4.LANGUAGE_CODE
                  LEFT OUTER JOIN
                  cbs_owner.GUI_INDICATOR_REF t18
                     ON     t18.table_name = 'OFFER_BALANCE_MAP'
                        AND t18.field_name = LOWER ('DEFAULT_LIMIT_PERIOD')
                        AND t18.integer_value = t1.DEFAULT_LIMIT_PERIOD
                  LEFT OUTER JOIN
                  cbs_owner.GUI_INDICATOR_VALUES t19
                     ON     t19.table_name = t18.table_name
                        AND t19.field_name = t18.field_name
                        AND t19.integer_value = t18.integer_value
                        AND t19.LANGUAGE_CODE = t4.LANGUAGE_CODE
                  LEFT OUTER JOIN cbs_owner.OFFER_KEY t20
                     ON t1.ACCOUNT_OFFER_ID = t20.OFFER_ID
                  LEFT OUTER JOIN
                  cbs_owner.OFFER_REF t21
                     ON     t20.OFFER_ID = t21.OFFER_ID
                        AND t21.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                  LEFT OUTER JOIN
                  cbs_owner.OFFER_VALUES t22
                     ON     t20.OFFER_ID = t22.OFFER_ID
                        AND t22.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                        AND t22.LANGUAGE_CODE = t4.LANGUAGE_CODE
                  LEFT OUTER JOIN cbs_owner.BALANCE_KEY t23
                     ON t1.ACCOUNT_OFFER_BALANCE_ID = t23.BALANCE_ID
                  LEFT OUTER JOIN
                  cbs_owner.BALANCE_REF t24
                     ON     t23.BALANCE_ID = t24.BALANCE_ID
                        AND t24.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                  LEFT OUTER JOIN
                  cbs_owner.BALANCE_VALUES t25
                     ON     t23.BALANCE_ID = t25.BALANCE_ID
                        AND t25.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                        AND t25.LANGUAGE_CODE = t4.LANGUAGE_CODE
            WHERE     t1.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                  AND t15.DISPLAY_VALUE = 'Postpaid'
         ORDER BY t1.BALANCE_ORDER;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_OFFER_BALANCE_MAP',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;


   PROCEDURE FILTER_OFFER_PRIORITY (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.OFFER_PRIORITY
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;


      INSERT INTO ELC_USER.OFFER_PRIORITY (OFFER_ID,
                                           OFFER_NAME,
                                           UPSELL_TEMPLATE_NAME,
                                           UPSELL_TEMPLATE_ID,
                                           RESELLER_VERSION_ID,
                                           UPSELL_TMP_DESC,
                                           UPSELL_TEMPLATE_MAP_ID,
                                           BUNDLE_NAME,
                                           BUNDLE_ID,
                                           UPSELL_TMP_OFFER_NAME,
                                           UPSELL_TMP_OFFER_ID,
                                           TARIFF_PRIORITY,
                                           RC_PRIORITY,
                                           DISCOUNT_PRIORITY,
                                           BALANCE_PRIORITY,
                                           DISPLAY_PRIORITY)
         SELECT T1.OFFER_ID,
                -- *** add offer
                T43.DISPLAY_VALUE AS offer_name,
                -- ### add offer
                t3.DISPLAY_VALUE AS upsell_template_name,             -- name,
                t1.UPSELL_TEMPLATE_ID,                 -- AS upsellTemplateId,
                t1.RESELLER_VERSION_ID,               -- AS resellerVersionId,
                --       t3.LANGUAGE_CODE AS languageCode,
                t3.DESCRIPTION AS upsell_tmp_desc,             -- description,
                -- add upsell template map
                t21.UPSELL_TEMPLATE_MAP_ID,         -- AS upsellTemplateMapId,
                --       t21.RESELLER_VERSION_ID AS resellerVersionId,
                --       t24.DISPLAY_VALUE AS upsellTemplateKey,
                --       t21.UPSELL_TEMPLATE_ID AS upsellTemplateId,
                t27.DISPLAY_VALUE AS bundle_name,                -- bundleKey,
                t21.BUNDLE_ID,                                 -- AS bundleId,
                t30.DISPLAY_VALUE AS upsell_tmp_offer_name,       -- offerKey,
                t21.OFFER_ID AS upsell_tmp_offer_id,               -- offerId,
                t21.TARIFF_PRIORITY,                     -- AS tariffPriority,
                t21.RC_PRIORITY,                             -- AS rcPriority,
                t21.DISCOUNT_PRIORITY,                 -- AS discountPriority,
                t21.BALANCE_PRIORITY,                   -- AS balancePriority,
                t21.DISPLAY_PRIORITY                     -- AS displayPriority
           FROM cbs_owner.OFFER_REF t1
                -- *** add offer
                INNER JOIN
                cbs_owner.OFFER_VALUES t43
                   ON     t1.OFFER_ID = t43.OFFER_ID
                      AND t43.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                -- ### add offer
                INNER JOIN
                cbs_owner.UPSELL_TEMPLATE_REF t2
                   ON     t2.UPSELL_TEMPLATE_ID = t1.UPSELL_TEMPLATE_ID
                      AND t2.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.UPSELL_TEMPLATE_VALUES t3
                   ON     t2.UPSELL_TEMPLATE_ID = t3.UPSELL_TEMPLATE_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                -- add upsell template map
                INNER JOIN
                cbs_owner.UPSELL_TEMPLATE_MAP t21
                   ON     T3.UPSELL_TEMPLATE_ID = T21.UPSELL_TEMPLATE_ID
                      AND t21.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                INNER JOIN cbs_owner.UPSELL_TEMPLATE_KEY t22
                   ON t21.UPSELL_TEMPLATE_ID = t22.UPSELL_TEMPLATE_ID
                INNER JOIN
                cbs_owner.UPSELL_TEMPLATE_REF t23
                   ON     t22.UPSELL_TEMPLATE_ID = t23.UPSELL_TEMPLATE_ID
                      AND t23.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.UPSELL_TEMPLATE_VALUES t24
                   ON     t22.UPSELL_TEMPLATE_ID = t24.UPSELL_TEMPLATE_ID
                      AND t24.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                      AND t24.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.BUNDLE_KEY t25
                   ON t21.BUNDLE_ID = t25.BUNDLE_ID
                LEFT OUTER JOIN
                cbs_owner.BUNDLE_REF t26
                   ON     t25.BUNDLE_ID = t26.BUNDLE_ID
                      AND t26.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.BUNDLE_VALUES t27
                   ON     t25.BUNDLE_ID = t27.BUNDLE_ID
                      AND t27.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                      AND t27.LANGUAGE_CODE = t24.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.OFFER_KEY t28
                   ON t21.OFFER_ID = t28.OFFER_ID
                LEFT OUTER JOIN
                cbs_owner.OFFER_REF t29
                   ON     t28.OFFER_ID = t29.OFFER_ID
                      AND t29.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.OFFER_VALUES t30
                   ON     t28.OFFER_ID = t30.OFFER_ID
                      AND t30.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                      AND t30.LANGUAGE_CODE = t24.LANGUAGE_CODE
          WHERE     t1.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_OFFER_PRIORITY',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_OFFER_RC_AWARD_MAP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.OFFER_RC_AWARD_MAP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO ELC_USER.OFFER_RC_AWARD_MAP (OFFER_RC_AWARD_MAP_ID,
                                               RESELLER_VERSION_ID,
                                               OFFER_NAME,
                                               OFFER_ID,
                                               RC_TERM_NAME,
                                               RC_TERM_ID,
                                               TERM_DATE_ACTIVE,
                                               TERM_DATE_INACTIVE,
                                               TERM_LEVEL_NAME,
                                               TERM_LEVEL_ID,
                                               BALANCE_NAME,
                                               BALANCE_ID,
                                               PERIOD_FREQUENCE_ID,
                                               PERIOD_FREQUENCE_NAME,
                                               APPLY_DAY,
                                               PRO_AWARD_INSF_RC_BAL,
                                               AMOUNT,
                                               CURRENCY_NAME,
                                               CURRENCY_CODE,
                                               UNIT_TYPE_NAME,
                                               UNIT_TYPE_ID,
                                               GRANT_ORDER,
                                               ACTION,
                                               AWARD_ACTIVATION_TYPE,
                                               AWARD_ACTIVATION_OFFSET,
                                               AWARD_EXPIRY_TYPE,
                                               AWARD_EXPIRY_OFFSET_TYPE,
                                               AWARD_EXPIRY_OFFSET,
                                               AWARD_EXPIRY_DATE,
                                               IS_ROLLABLE,
                                               ROLLOVER_GROUPING,
                                               MAXIMUM_GRANT_ROLLOVER,
                                               MAXIMUM_TOTAL_ROLLOVER,
                                               RC_MULTIPLICATIONS,
                                               CYCLES_ROLLOVER_EXPIRE,
                                               DEFAULT_SET_FUNCTION)
         SELECT t1.OFFER_RC_AWARD_MAP_ID AS offer_rc_award_map_id, -- offerRcAwardMapId,
                t1.RESELLER_VERSION_ID,               -- AS resellerVersionId,
                t4.DISPLAY_VALUE AS offer_name,                   -- offerKey,
                t1.OFFER_ID AS offer_id,                           -- offerId,
                t7.DISPLAY_VALUE AS rc_term_name,                -- rcTermKey,
                t1.RC_TERM_ID AS rc_term_id,                      -- rcTermId,
                -- *** add rc term level
                t6.DATE_ACTIVE AS term_date_active,             -- dateActive,
                t6.DATE_INACTIVE AS term_date_inactive,       -- dateInactive,
                T45.DISPLAY_VALUE AS TERM_LEVEL_NAME,
                T44.FIELD_NAME || '_' || T44.INTEGER_VALUE AS TERM_LEVEL_ID,
                -- ### add rc term level
                t10.DISPLAY_VALUE AS balance_name,              -- balanceKey,
                t1.BALANCE_ID AS balance_id,                     -- balanceId,
                --       t1.BILL_PERIOD AS billPeriod,
                -- *** NOTE: Khong co trong DIC, dung tam cua RATE RC
                --       t1.GENERATION_PERIOD_FREQUENCY AS periodFrequency,
                t63.FIELD_NAME || '_' || T63.INTEGER_VALUE
                   AS PERIOD_FREQUENCE_ID,
                T64.DISPLAY_VALUE AS PERIOD_FREQUENCE_NAME,
                -- ###

                t1.APPLY_DAY AS apply_day,                        -- applyDay,
                t1.PRO_AWARD_INSF_RC_BAL,             -- AS proAwardInsfRcBal,
                t1.AMOUNT AS amount,
                --       t14.SERVICE_VERSION_ID AS serviceVersionId,
                --       t14.ISO_CODE AS currencyIsoCode,
                --       t14.IMPLIED_DECIMAL AS currencyImpliedDecimal,
                t15.DISPLAY_VALUE AS currency_name,        -- rateCurrencyKey,
                t1.CURRENCY_CODE AS currency_code,            -- currencyCode,
                t18.DISPLAY_VALUE AS unit_type_name,          -- unitsTypeKey,
                t1.UNIT_TYPE AS unit_type_id,                     -- unitType,
                t20.DISPLAY_VALUE AS grant_order,               -- grantOrder,
                t22.DISPLAY_VALUE AS action,
                t24.DISPLAY_VALUE AS award_activation_type, -- awardActivationType,
                t1.AWARD_ACTIVATION_OFFSET AS award_activation_offset, -- awardActivationOffset,
                t26.DISPLAY_VALUE AS award_expiry_type,    -- awardExpiryType,
                t28.DISPLAY_VALUE AS award_expiry_offset_type, -- awardExpiryOffsetType,
                t1.AWARD_EXPIRY_OFFSET AS award_expiry_offset, -- awardExpiryOffset,
                t1.AWARD_EXPIRY_DATE AS award_expiry_date, -- awardExpiryDate,
                t1.IS_ROLLABLE AS is_rollable,                  -- isRollable,
                t30.DISPLAY_VALUE AS rollover_grouping,   -- rolloverGrouping,
                t1.MAXIMUM_GRANT_ROLLOVER AS maximum_grant_rollover, -- maximumGrantRollover,
                t1.MAXIMUM_TOTAL_ROLLOVER AS maximum_total_rollover, -- maximumTotalRollover,
                t1.RC_MULTIPLICATIONS AS rc_multiplications, -- rcMultiplications,
                t1.CYCLES_ROLLOVER_EXPIRE AS cycles_rollover_expire, -- cyclesRolloverExpire,
                t1.DEFAULT_SET_FUNCTION AS default_set_function -- defaultSetFunction
           FROM cbs_owner.OFFER_RC_AWARD_MAP t1
                INNER JOIN cbs_owner.OFFER_KEY t2
                   ON t1.OFFER_ID = t2.OFFER_ID
                INNER JOIN
                cbs_owner.OFFER_REF t3
                   ON     t2.OFFER_ID = t3.OFFER_ID
                      AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.OFFER_VALUES t4
                   ON     t2.OFFER_ID = t4.OFFER_ID
                      AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                      AND t4.LANGUAGE_CODE = 1
                INNER JOIN cbs_owner.RC_TERM_KEY t5
                   ON t1.RC_TERM_ID = t5.RC_TERM_ID
                INNER JOIN
                cbs_owner.RC_TERM_REF t6
                   ON     t5.RC_TERM_ID = t6.RC_TERM_ID
                      AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.RC_TERM_VALUES t7
                   ON     t5.RC_TERM_ID = t7.RC_TERM_ID
                      AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                      AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
                INNER JOIN cbs_owner.BALANCE_KEY t8
                   ON t1.BALANCE_ID = t8.BALANCE_ID
                INNER JOIN
                cbs_owner.BALANCE_REF t9
                   ON     t8.BALANCE_ID = t9.BALANCE_ID
                      AND t9.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.BALANCE_VALUES t10
                   ON     t8.BALANCE_ID = t10.BALANCE_ID
                      AND t10.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                      AND t10.LANGUAGE_CODE = t4.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.RATE_CURRENCY_KEY t13
                   ON t1.CURRENCY_CODE = t13.CURRENCY_CODE
                LEFT OUTER JOIN
                cbs_owner.RATE_CURRENCY_REF t14
                   ON     t13.CURRENCY_CODE = t14.CURRENCY_CODE
                      AND t14.SERVICE_VERSION_ID = 1
                LEFT OUTER JOIN
                cbs_owner.RATE_CURRENCY_VALUES t15
                   ON     t13.CURRENCY_CODE = t15.CURRENCY_CODE
                      AND t15.SERVICE_VERSION_ID = 1
                      AND t15.LANGUAGE_CODE = t4.LANGUAGE_CODE
                INNER JOIN cbs_owner.UNITS_TYPE_KEY t16
                   ON t1.UNIT_TYPE = t16.UNIT_TYPE
                INNER JOIN
                cbs_owner.UNITS_TYPE_REF t17
                   ON     t16.UNIT_TYPE = t17.UNIT_TYPE
                      AND t17.SERVICE_VERSION_ID = 1
                INNER JOIN
                cbs_owner.UNITS_TYPE_VALUES t18
                   ON     t16.UNIT_TYPE = t18.UNIT_TYPE
                      AND t18.SERVICE_VERSION_ID = t17.SERVICE_VERSION_ID
                      AND t18.LANGUAGE_CODE = t4.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_REF t19
                   ON     t19.table_name = 'OFFER_RC_AWARD_MAP'
                      AND t19.field_name = LOWER ('GRANT_ORDER')
                      AND t19.integer_value = t1.GRANT_ORDER
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_VALUES t20
                   ON     t20.table_name = t19.table_name
                      AND t20.field_name = t19.field_name
                      AND t20.integer_value = t19.integer_value
                      AND t20.LANGUAGE_CODE = t4.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_REF t21
                   ON     t21.table_name = 'OFFER_RC_AWARD_MAP'
                      AND t21.field_name = LOWER ('ACTION')
                      AND t21.integer_value = t1.ACTION
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_VALUES t22
                   ON     t22.table_name = t21.table_name
                      AND t22.field_name = t21.field_name
                      AND t22.integer_value = t21.integer_value
                      AND t22.LANGUAGE_CODE = t4.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_REF t23
                   ON     t23.table_name = 'OFFER_RC_AWARD_MAP'
                      AND t23.field_name = LOWER ('AWARD_ACTIVATION_TYPE')
                      AND t23.integer_value = t1.AWARD_ACTIVATION_TYPE
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_VALUES t24
                   ON     t24.table_name = t23.table_name
                      AND t24.field_name = t23.field_name
                      AND t24.integer_value = t23.integer_value
                      AND t24.LANGUAGE_CODE = t4.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_REF t25
                   ON     t25.table_name = 'OFFER_RC_AWARD_MAP'
                      AND t25.field_name = LOWER ('AWARD_EXPIRY_TYPE')
                      AND t25.integer_value = t1.AWARD_EXPIRY_TYPE
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_VALUES t26
                   ON     t26.table_name = t25.table_name
                      AND t26.field_name = t25.field_name
                      AND t26.integer_value = t25.integer_value
                      AND t26.LANGUAGE_CODE = t4.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_REF t27
                   ON     t27.table_name = 'OFFER_RC_AWARD_MAP'
                      AND t27.field_name = LOWER ('AWARD_EXPIRY_OFFSET_TYPE')
                      AND t27.integer_value = t1.AWARD_EXPIRY_OFFSET_TYPE
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_VALUES t28
                   ON     t28.table_name = t27.table_name
                      AND t28.field_name = t27.field_name
                      AND t28.integer_value = t27.integer_value
                      AND t28.LANGUAGE_CODE = t4.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t29
                   ON     t29.enumeration_key = LOWER ('ROLLOVER_GROUPING')
                      AND t29.VALUE = t1.ROLLOVER_GROUPING
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t30
                   ON     t30.enumeration_key = t29.enumeration_key
                      AND t30.VALUE = t29.VALUE
                      AND t30.LANGUAGE_CODE = t4.LANGUAGE_CODE
                -- add rc term level dictionary
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_REF t44
                   ON     t44.table_name = 'RC_TERM_REF'
                      AND t44.field_name = LOWER ('LEVEL_CODE')
                      AND t44.integer_value = t6.LEVEL_CODE
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_VALUES t45
                   ON     t45.table_name = t44.table_name
                      AND t45.field_name = t44.field_name
                      AND t45.integer_value = t44.integer_value
                      AND t45.LANGUAGE_CODE = t4.LANGUAGE_CODE
                -- add dic => period frequency
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_REF t63
                   ON     t63.table_name = 'RATE_RC'
                      AND t63.field_name = LOWER ('PERIOD_FREQUENCY')
                      AND t63.integer_value = t1.GENERATION_PERIOD_FREQUENCY
                LEFT OUTER JOIN
                cbs_owner.GUI_INDICATOR_VALUES t64
                   ON     t64.table_name = t63.table_name
                      AND t64.field_name = t63.field_name
                      AND t64.integer_value = t63.integer_value
                      AND t64.LANGUAGE_CODE = t4.LANGUAGE_CODE
                -- *** add offer_rc_term_map
                -- => Loai het nhung RC TERM khong duoc map trong GRAPH
                INNER JOIN
                CBS_OWNER.OFFER_RC_TERM_MAP t81
                   ON     t81.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                      AND T81.OFFER_ID = T1.OFFER_ID
                      AND T81.RC_TERM_ID = T1.RC_TERM_ID
          WHERE t1.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_OFFER_RC_AWARD_MAP',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_PRODUCT_OFFER (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.PRODUCT_OFFER
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;


      INSERT INTO ELC_USER.PRODUCT_OFFER (OFFER_ID,
                                          OFFER_NAME,
                                          OFFER_ABBREVIATION,
                                          UNBILL,
                                          B_NUMBER_ENRICH,
                                          PRODUCT_GROUP_TYPE,
                                          PARENT_ID,
                                          OFFER_TYPE,
                                          RESELLER_VERSION_ID,
                                          SALES_EFFECTIVE_TIME,
                                          SALES_EXPIRATION_TIME,
                                          CURRENCY_NAME,
                                          CURRENCY_CODE,
                                          UPSELL_TEMPLATE_ID,
                                          IS_INTERNAL)
         SELECT t1.OFFER_ID AS offer_id,                           -- offerId,
                t3.DISPLAY_VALUE AS offer_name,               -- displayValue,
                NULL AS offer_abbreviation,
                0 AS unbill,
                NULL AS b_number_enrich,
                NULL AS product_group_type,
                NULL AS parent_id,
                CASE T2.OFFER_TYPE
                   WHEN 2 THEN 'PO'
                   WHEN 3 THEN 'SO'
                   ELSE 'AO'
                END
                   AS offer_type,
                t2.RESELLER_VERSION_ID,
                -- add offer ref
                T2.SALES_EFFECTIVE_DT AS sales_effective_time,
                T2.SALES_EXPIRATION_DT AS sales_expiration_time,
                -- add currency
                t23.DISPLAY_VALUE AS currency_name,
                T2.CURRENCY_CODE,
                T2.UPSELL_TEMPLATE_ID,
                0
           FROM cbs_owner.OFFER_KEY t1
                INNER JOIN cbs_owner.OFFER_REF t2
                   ON t1.OFFER_ID = t2.OFFER_ID
                INNER JOIN
                cbs_owner.OFFER_VALUES t3
                   ON     t2.OFFER_ID = t3.OFFER_ID
                      AND t3.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN cbs_owner.SERVICE_CATEGORY_KEY t45
                   ON t2.SERVICE_CATEGORY_ID = t45.SERVICE_CATEGORY_ID
                INNER JOIN
                cbs_owner.SERVICE_CATEGORY_VALUES t46
                   ON     t2.SERVICE_CATEGORY_ID = t46.SERVICE_CATEGORY_ID
                      AND t46.LANGUAGE_CODE = t3.LANGUAGE_CODE
                      AND t46.service_version_id = 1
                -- add currency
                INNER JOIN
                cbs_owner.RATE_CURRENCY_REF t22
                   ON     T2.CURRENCY_CODE = t22.CURRENCY_CODE
                      AND T22.SERVICE_VERSION_ID = T46.SERVICE_VERSION_ID
                INNER JOIN
                cbs_owner.RATE_CURRENCY_VALUES t23
                   ON     t22.CURRENCY_CODE = t23.CURRENCY_CODE
                      AND t22.SERVICE_VERSION_ID = t23.SERVICE_VERSION_ID
                      AND T23.LANGUAGE_CODE = T3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_PRODUCT_OFFER',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_PROMO_PLAN (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.PROMO_PLAN
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;


      INSERT INTO ELC_USER.PROMO_PLAN (OFFER_ID,
                                       OFFER_NAME,
                                       PROMO_PLAN_NAME,
                                       PROMO_PLAN_ID,
                                       RESELLER_VERSION_ID,
                                       BONUS_ITEM_NAME,
                                       BONUS_ITEM_ID,
                                       DISCOUNT_ITEM_NAME,
                                       DISCOUNT_ITEM_ID)
         SELECT t1.OFFER_ID AS offer_id,                           -- offerId,
                t4.DISPLAY_VALUE AS offer_name,                   -- offerKey,
                t7.DISPLAY_VALUE AS promo_plan_name,    -- rtPromotionPlanKey,
                t1.RT_PROMOTION_PLAN_ID AS promo_plan_id, -- rtPromotionPlanId,
                t1.RESELLER_VERSION_ID AS reseller_version_id, -- resellerVersionId,
                -- {{{ add promo plan item map
                --       t21.RT_PROMO_PI_MAP_ID AS rtPromoPiMapId,
                --       t21.RESELLER_VERSION_ID AS resellerVersionId,
                --       t24.DISPLAY_VALUE AS rtPromotionPlanKey,
                --       t21.RT_PROMOTION_PLAN_ID AS rtPromotionPlanId,
                t27.DISPLAY_VALUE AS bonus_item_name,       -- rtBonusItemKey,
                t21.BONUS_ITEM_ID AS bonus_item_id,            -- bonusItemId,
                t30.DISPLAY_VALUE AS discount_item_name, -- rtDiscountItemKey,
                t21.DISCOUNT_ITEM_ID AS discount_item_id     -- discountItemId
           FROM cbs_owner.OFFER_RT_PROMO_PLAN_MAP t1
                INNER JOIN cbs_owner.OFFER_KEY t2
                   ON t1.OFFER_ID = t2.OFFER_ID
                INNER JOIN
                cbs_owner.OFFER_REF t3
                   ON     t2.OFFER_ID = t3.OFFER_ID
                      AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.OFFER_VALUES t4
                   ON     t2.OFFER_ID = t4.OFFER_ID
                      AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                      AND t4.LANGUAGE_CODE = 1
                INNER JOIN cbs_owner.RT_PROMOTION_PLAN_KEY t5
                   ON t1.RT_PROMOTION_PLAN_ID = t5.RT_PROMOTION_PLAN_ID
                INNER JOIN
                cbs_owner.RT_PROMOTION_PLAN_REF t6
                   ON     t5.RT_PROMOTION_PLAN_ID = t6.RT_PROMOTION_PLAN_ID
                      AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.RT_PROMOTION_PLAN_VALUES t7
                   ON     t5.RT_PROMOTION_PLAN_ID = t7.RT_PROMOTION_PLAN_ID
                      AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                      AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
                -- {{{ add promo plan item map
                INNER JOIN
                cbs_owner.RT_PROMOTION_PLAN_ITEM_MAP t21
                   ON     t1.RT_PROMOTION_PLAN_ID = T21.RT_PROMOTION_PLAN_ID
                      AND T1.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                INNER JOIN cbs_owner.RT_PROMOTION_PLAN_KEY t22
                   ON t21.RT_PROMOTION_PLAN_ID = t22.RT_PROMOTION_PLAN_ID
                INNER JOIN
                cbs_owner.RT_PROMOTION_PLAN_REF t23
                   ON     t22.RT_PROMOTION_PLAN_ID = t23.RT_PROMOTION_PLAN_ID
                      AND t23.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.RT_PROMOTION_PLAN_VALUES t24
                   ON     t22.RT_PROMOTION_PLAN_ID = t24.RT_PROMOTION_PLAN_ID
                      AND t24.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                      AND t24.LANGUAGE_CODE = 1
                LEFT OUTER JOIN cbs_owner.RT_BONUS_ITEM_KEY t25
                   ON t21.BONUS_ITEM_ID = t25.BONUS_ITEM_ID
                LEFT OUTER JOIN
                cbs_owner.RT_BONUS_ITEM_REF t26
                   ON     t25.BONUS_ITEM_ID = t26.BONUS_ITEM_ID
                      AND t26.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.RT_BONUS_ITEM_VALUES t27
                   ON     t25.BONUS_ITEM_ID = t27.BONUS_ITEM_ID
                      AND t27.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                      AND t27.LANGUAGE_CODE = t24.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.RT_DISCOUNT_ITEM_KEY t28
                   ON t21.DISCOUNT_ITEM_ID = t28.DISCOUNT_ITEM_ID
                LEFT OUTER JOIN
                cbs_owner.RT_DISCOUNT_ITEM_REF t29
                   ON     t28.DISCOUNT_ITEM_ID = t29.DISCOUNT_ITEM_ID
                      AND t29.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.RT_DISCOUNT_ITEM_VALUES t30
                   ON     t28.DISCOUNT_ITEM_ID = t30.DISCOUNT_ITEM_ID
                      AND t30.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                      AND t30.LANGUAGE_CODE = t24.LANGUAGE_CODE
          WHERE t1.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_PROMO_PLAN',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_RUM_MAP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.RUM_MAP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO ELC_USER.RUM_MAP (TARIFF_PLAN_MAPPING_ID,
                                    RESELLER_VERSION_ID,
                                    TARIFF_PLAN_NAME,
                                    TARIFF_PLAN_ID,
                                    TARIFF_SET_MEMBER_ID,
                                    TARIFF_SET_NAME,
                                    TARIFF_SET_ID,
                                    UNIT_TYPE_NAME,
                                    UNIT_TYPE_ID,
                                    RUM_ID,
                                    CURRENCY_NAME,
                                    CURRENCY_ID,
                                    TIME_TYPE_NAME,
                                    TIME_TYPE_ID,
                                    TARIFF_MODEL_NAME,
                                    TARIFF_MODEL_ID,
                                    IS_PRIMARY,
                                    RUM_TYPE,
                                    CONSUME_FLAG,
                                    STEP)
         SELECT t61.TARIFF_PLAN_MAPPING_ID AS tariff_plan_mapping_id, -- tariffPlanMappingId,
                t61.RESELLER_VERSION_ID,              -- AS resellerVersionId,
                t64.DISPLAY_VALUE AS tariff_plan_name,       -- tariffPlanKey,
                t61.TARIFF_PLAN_ID,                        -- AS tariffPlanId,
                --       t4.DISPLAY_VALUE AS tariffSetIdKey,
                --       t68.DISPLAY_VALUE AS defaultCurrencyCode,
                --       t61.TARIFF_SET_ID AS tariffSetId,
                --       t61.CHARGE_RATE_CODE AS chargeRateCode,
                -- *** add tariff set member
                t1.TARIFF_SET_MEMBER_ID AS tariff_set_member_id, -- tariffSetMemberId,
                --       t1.RESELLER_VERSION_ID AS reseller_version_id,    -- resellerVersionId,
                t4.DISPLAY_VALUE AS tariff_set_name,        -- tariffSetIdKey,
                t1.TARIFF_SET_ID AS tariff_set_id,             -- tariffSetId,
                -- *** add unit type
                t22.display_value AS unit_type_name,
                T20.UNIT_TYPE AS unit_type_id,
                CASE t22.DISPLAY_VALUE
                   WHEN 'SECONDS' THEN 'DUR'
                   WHEN 'SMS' THEN 'EVT'
                   WHEN 'MMS' THEN 'EVT'
                   WHEN 'OCTET' THEN 'VOL'
                   ELSE 'UNKNOWN'
                END
                   RUM_ID,
                T43.DISPLAY_VALUE AS currency_name,
                T6.CURRENCY_CODE AS currency_id,
                -- ### add unit type
                t10.DISPLAY_VALUE AS time_type_name,           -- timeTypeKey,
                t1.TIME_TYPE_ID AS time_type_id,                -- timeTypeId,
                t7.DISPLAY_VALUE AS tariff_model_name,           -- tariffKey,
                t1.TARIFF_ID AS tariff_model_id,                  -- tariffId,
                t1.IS_PRIMARY AS is_primary,                      -- isPrimary
                CASE
                   WHEN     t22.DISPLAY_VALUE = 'SECONDS'
                        AND t6.ADD_CON_AMOUNT > 0
                   THEN
                      'Tiered'
                   WHEN     t22.DISPLAY_VALUE = 'SECONDS'
                        AND t6.ADD_CON_AMOUNT = 0
                   THEN
                      'Flat'
                   WHEN t22.DISPLAY_VALUE = 'SMS'
                   THEN
                      'Event'
                   WHEN t22.DISPLAY_VALUE = 'MMS'
                   THEN
                      'Event'
                   WHEN t22.DISPLAY_VALUE = 'OCTET'
                   THEN
                      'Tiered'
                   ELSE
                      'UNKNOWN'
                END
                   AS RUM_TYPE,
                0 AS CONSUME_FLAG,
                1 AS STEP
           FROM cbs_owner.TARIFF_PLAN_MAPPING t61
                INNER JOIN cbs_owner.TARIFF_PLAN_KEY t62
                   ON t61.TARIFF_PLAN_ID = t62.TARIFF_PLAN_ID
                INNER JOIN
                cbs_owner.TARIFF_PLAN_REF t63
                   ON     t62.TARIFF_PLAN_ID = t63.TARIFF_PLAN_ID
                      AND t63.RESELLER_VERSION_ID = t61.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.TARIFF_PLAN_VALUES t64
                   ON     t62.TARIFF_PLAN_ID = t64.TARIFF_PLAN_ID
                      AND t64.RESELLER_VERSION_ID = t61.RESELLER_VERSION_ID
                      AND t64.LANGUAGE_CODE = 1
                INNER JOIN cbs_owner.TARIFF_SET_ID_KEY t2
                   ON t61.TARIFF_SET_ID = t2.TARIFF_SET_ID
                INNER JOIN
                cbs_owner.TARIFF_SET_ID_REF t3
                   ON     t2.TARIFF_SET_ID = t3.TARIFF_SET_ID
                      AND t3.RESELLER_VERSION_ID = t61.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.TARIFF_SET_ID_VALUES t4
                   ON     t2.TARIFF_SET_ID = t4.TARIFF_SET_ID
                      AND t4.RESELLER_VERSION_ID = t61.RESELLER_VERSION_ID
                      AND t4.LANGUAGE_CODE = t64.LANGUAGE_CODE
                INNER JOIN
                cbs_owner.RATE_CURRENCY_VALUES t68
                   ON     t3.DEFAULT_CURRENCY_CODE = t68.CURRENCY_CODE
                      AND t68.SERVICE_VERSION_ID = 1
                      AND t68.LANGUAGE_CODE = t64.LANGUAGE_CODE
                -- *** add tariff set member
                INNER JOIN
                cbs_owner.TARIFF_SET_MEMBER t1
                   ON     t1.TARIFF_SET_ID = t2.TARIFF_SET_ID
                      AND T1.RESELLER_VERSION_ID = T61.RESELLER_VERSION_ID
                LEFT OUTER JOIN cbs_owner.TARIFF_KEY t5
                   ON t1.TARIFF_ID = t5.TARIFF_ID
                LEFT OUTER JOIN
                cbs_owner.TARIFF_REF t6
                   ON     t5.TARIFF_ID = t6.TARIFF_ID
                      AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.TARIFF_VALUES t7
                   ON     t5.TARIFF_ID = t7.TARIFF_ID
                      AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                      AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
                INNER JOIN cbs_owner.TIME_TYPE_KEY t8
                   ON t1.TIME_TYPE_ID = t8.TIME_TYPE_ID
                INNER JOIN
                cbs_owner.TIME_TYPE_REF t9
                   ON     t8.TIME_TYPE_ID = t9.TIME_TYPE_ID
                      AND t9.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.TIME_TYPE_VALUES t10
                   ON     t8.TIME_TYPE_ID = t10.TIME_TYPE_ID
                      AND t10.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                      AND t10.LANGUAGE_CODE = t4.LANGUAGE_CODE
                -- *** add unit type
                INNER JOIN cbs_owner.UNITS_TYPE_KEY t20
                   ON t6.UNIT_TYPE = t20.UNIT_TYPE
                INNER JOIN
                cbs_owner.UNITS_TYPE_REF t21
                   ON     t20.UNIT_TYPE = t21.UNIT_TYPE
                      AND t21.SERVICE_VERSION_ID = 1
                INNER JOIN
                cbs_owner.UNITS_TYPE_VALUES t22
                   ON     t20.UNIT_TYPE = t22.UNIT_TYPE
                      AND t22.SERVICE_VERSION_ID = t21.SERVICE_VERSION_ID
                      AND t22.LANGUAGE_CODE = t4.LANGUAGE_CODE
                -- *** add currency
                INNER JOIN
                cbs_owner.RATE_CURRENCY_REF t42
                   ON     t6.CURRENCY_CODE = t42.CURRENCY_CODE
                      AND t42.SERVICE_VERSION_ID = t21.SERVICE_VERSION_ID
                INNER JOIN
                cbs_owner.RATE_CURRENCY_VALUES t43
                   ON     t42.CURRENCY_CODE = t43.CURRENCY_CODE
                      AND t42.SERVICE_VERSION_ID = t43.SERVICE_VERSION_ID
                      AND t43.LANGUAGE_CODE = t4.LANGUAGE_CODE
          WHERE t61.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_RUM_MAP',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_TARIFF_MODEL (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.TARIFF_MODEL
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO ELC_USER.TARIFF_MODEL (TARIFF_MODEL_ID,
                                         TARIFF_MODEL_NAME,
                                         RESELLER_VERSION_ID,
                                         STEP,
                                         TIER_FROM,
                                         TIER_TO,
                                         BEAT,
                                         FACTOR,
                                         CHARGE_BASE,
                                         DESCRIPTION)
         SELECT t1.TARIFF_ID AS tariff_model_id,                  -- tariffId,
                t3.DISPLAY_VALUE AS tariff_model_name,        -- displayValue,
                t2.RESELLER_VERSION_ID,               -- AS resellerVersionId,
                --       t5.SERVICE_VERSION_ID AS serviceVersionId,
                --       t6.DISPLAY_VALUE AS unitsTypeKey,
                --       t2.UNIT_TYPE AS unitType,
                --       t8.ISO_CODE AS currencyIsoCode,
                --       t8.IMPLIED_DECIMAL AS currencyImpliedDecimal,
                --       t9.DISPLAY_VALUE AS rateCurrencyKey,
                --       t2.CURRENCY_CODE AS currencyCode,

                -- *** add and modify
                1 AS STEP,
                0 AS TIER_FROM,
                t2.FIRST_CON_AMOUNT AS TIER_TO,             -- firstConAmount,
                t2.FIRST_CON_AMOUNT AS BEAT,                -- firstConAmount,
                t2.FIRST_CON_CHARGE AS FACTOR,              -- firstConCharge,
                t2.FIRST_CON_AMOUNT AS CHARGE_BASE,         -- firstConAmount,
                --       t2.ADD_CON_AMOUNT AS addConAmount,
                --       t2.ADD_CON_CHARGE AS addConCharge,
                -- ### add and modify


                --       t2.ALLOW_DISCOUNT AS allowDiscount,
                --       t2.IS_CHARGEBLE AS isChargeble,
                --       t2.CONVERSION_RQD AS conversionRqd,
                --       t11.DISPLAY_VALUE AS tariffCategory,
                --       t2.NON_MON_ALLOWED AS nonMonAllowed,
                --       t3.LANGUAGE_CODE AS languageCode,

                t3.DESCRIPTION AS description
           FROM cbs_owner.TARIFF_KEY t1
                INNER JOIN cbs_owner.TARIFF_REF t2
                   ON t1.TARIFF_ID = t2.TARIFF_ID
                INNER JOIN
                cbs_owner.TARIFF_VALUES t3
                   ON     t2.TARIFF_ID = t3.TARIFF_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                INNER JOIN cbs_owner.UNITS_TYPE_KEY t4
                   ON t2.UNIT_TYPE = t4.UNIT_TYPE
                INNER JOIN
                cbs_owner.UNITS_TYPE_REF t5
                   ON     t4.UNIT_TYPE = t5.UNIT_TYPE
                      AND t5.SERVICE_VERSION_ID = 1
                INNER JOIN
                cbs_owner.UNITS_TYPE_VALUES t6
                   ON     t4.UNIT_TYPE = t6.UNIT_TYPE
                      AND t6.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                      AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.RATE_CURRENCY_KEY t7
                   ON t2.CURRENCY_CODE = t7.CURRENCY_CODE
                INNER JOIN
                cbs_owner.RATE_CURRENCY_REF t8
                   ON     t7.CURRENCY_CODE = t8.CURRENCY_CODE
                      AND t8.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                INNER JOIN
                cbs_owner.RATE_CURRENCY_VALUES t9
                   ON     t7.CURRENCY_CODE = t9.CURRENCY_CODE
                      AND t9.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                      AND t9.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t10
                   ON     t10.enumeration_key = LOWER ('TARIFF_CATEGORY')
                      AND t10.VALUE = t2.TARIFF_CATEGORY
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t11
                   ON     t11.enumeration_key = t10.enumeration_key
                      AND t11.VALUE = t10.VALUE
                      AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1
                AND t6.DISPLAY_VALUE = 'SECONDS'
         UNION
         SELECT t1.TARIFF_ID AS tariffId,
                t3.DISPLAY_VALUE AS displayValue,
                t2.RESELLER_VERSION_ID AS resellerVersionId,
                --       t5.SERVICE_VERSION_ID AS serviceVersionId,
                --       t6.DISPLAY_VALUE AS unitsTypeKey,
                --       t2.UNIT_TYPE AS unitType,
                --       t8.ISO_CODE AS currencyIsoCode,
                --       t8.IMPLIED_DECIMAL AS currencyImpliedDecimal,
                --       t9.DISPLAY_VALUE AS rateCurrencyKey,
                --       t2.CURRENCY_CODE AS currencyCode,

                -- *** add and modify
                2 AS STEP,
                t2.FIRST_CON_AMOUNT AS TIER_FROM,            -- firstConAmount
                86868686 AS TIER_TO,
                --        t2.FIRST_CON_AMOUNT as firstConAmount,
                --        t2.FIRST_CON_CHARGE as firstConCharge,
                t2.ADD_CON_AMOUNT AS BEAT,                    -- addConAmount,
                t2.ADD_CON_CHARGE AS FACTOR,                  -- addConCharge,
                t2.ADD_CON_AMOUNT AS CHARGE_BASE,             -- addConAmount,
                -- ### add and modify


                --       t2.ALLOW_DISCOUNT AS allowDiscount,
                --       t2.IS_CHARGEBLE AS isChargeble,
                --       t2.CONVERSION_RQD AS conversionRqd,
                --       t11.DISPLAY_VALUE AS tariffCategory,
                --       t2.NON_MON_ALLOWED AS nonMonAllowed,
                --       t3.LANGUAGE_CODE AS languageCode,

                t3.DESCRIPTION AS description
           FROM cbs_owner.TARIFF_KEY t1
                INNER JOIN cbs_owner.TARIFF_REF t2
                   ON t1.TARIFF_ID = t2.TARIFF_ID
                INNER JOIN
                cbs_owner.TARIFF_VALUES t3
                   ON     t2.TARIFF_ID = t3.TARIFF_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                INNER JOIN cbs_owner.UNITS_TYPE_KEY t4
                   ON t2.UNIT_TYPE = t4.UNIT_TYPE
                INNER JOIN
                cbs_owner.UNITS_TYPE_REF t5
                   ON     t4.UNIT_TYPE = t5.UNIT_TYPE
                      AND t5.SERVICE_VERSION_ID = 1
                INNER JOIN
                cbs_owner.UNITS_TYPE_VALUES t6
                   ON     t4.UNIT_TYPE = t6.UNIT_TYPE
                      AND t6.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                      AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.RATE_CURRENCY_KEY t7
                   ON t2.CURRENCY_CODE = t7.CURRENCY_CODE
                INNER JOIN
                cbs_owner.RATE_CURRENCY_REF t8
                   ON     t7.CURRENCY_CODE = t8.CURRENCY_CODE
                      AND t8.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                INNER JOIN
                cbs_owner.RATE_CURRENCY_VALUES t9
                   ON     t7.CURRENCY_CODE = t9.CURRENCY_CODE
                      AND t9.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                      AND t9.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t10
                   ON     t10.enumeration_key = LOWER ('TARIFF_CATEGORY')
                      AND t10.VALUE = t2.TARIFF_CATEGORY
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t11
                   ON     t11.enumeration_key = t10.enumeration_key
                      AND t11.VALUE = t10.VALUE
                      AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1
                AND t6.DISPLAY_VALUE = 'SECONDS'
         UNION
         SELECT t1.TARIFF_ID AS tariffId,
                t3.DISPLAY_VALUE AS displayValue,
                t2.RESELLER_VERSION_ID AS resellerVersionId,
                --       t5.SERVICE_VERSION_ID AS serviceVersionId,
                --       t6.DISPLAY_VALUE AS unitsTypeKey,
                --       t2.UNIT_TYPE AS unitType,
                --       t8.ISO_CODE AS currencyIsoCode,
                --       t8.IMPLIED_DECIMAL AS currencyImpliedDecimal,
                --       t9.DISPLAY_VALUE AS rateCurrencyKey,
                --       t2.CURRENCY_CODE AS currencyCode,

                -- *** add and modify
                1 AS STEP,
                1 AS TIER_FROM,
                1 AS TIER_TO,
                t2.FIRST_CON_AMOUNT AS BEAT,                -- firstConAmount,
                t2.FIRST_CON_CHARGE AS FACTOR,              -- firstConCharge,
                t2.FIRST_CON_AMOUNT AS CHARGE_BASE,         -- firstConAmount,
                --    t2.ADD_CON_AMOUNT as addConAmount,
                --    t2.ADD_CON_CHARGE as addConCharge,
                -- ### add and modify


                --       t2.ALLOW_DISCOUNT AS allowDiscount,
                --       t2.IS_CHARGEBLE AS isChargeble,
                --       t2.CONVERSION_RQD AS conversionRqd,
                --       t11.DISPLAY_VALUE AS tariffCategory,
                --       t2.NON_MON_ALLOWED AS nonMonAllowed,
                --       t3.LANGUAGE_CODE AS languageCode,

                t3.DESCRIPTION AS description
           FROM cbs_owner.TARIFF_KEY t1
                INNER JOIN cbs_owner.TARIFF_REF t2
                   ON t1.TARIFF_ID = t2.TARIFF_ID
                INNER JOIN
                cbs_owner.TARIFF_VALUES t3
                   ON     t2.TARIFF_ID = t3.TARIFF_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                INNER JOIN cbs_owner.UNITS_TYPE_KEY t4
                   ON t2.UNIT_TYPE = t4.UNIT_TYPE
                INNER JOIN
                cbs_owner.UNITS_TYPE_REF t5
                   ON     t4.UNIT_TYPE = t5.UNIT_TYPE
                      AND t5.SERVICE_VERSION_ID = 1
                INNER JOIN
                cbs_owner.UNITS_TYPE_VALUES t6
                   ON     t4.UNIT_TYPE = t6.UNIT_TYPE
                      AND t6.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                      AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.RATE_CURRENCY_KEY t7
                   ON t2.CURRENCY_CODE = t7.CURRENCY_CODE
                INNER JOIN
                cbs_owner.RATE_CURRENCY_REF t8
                   ON     t7.CURRENCY_CODE = t8.CURRENCY_CODE
                      AND t8.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                INNER JOIN
                cbs_owner.RATE_CURRENCY_VALUES t9
                   ON     t7.CURRENCY_CODE = t9.CURRENCY_CODE
                      AND t9.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                      AND t9.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t10
                   ON     t10.enumeration_key = LOWER ('TARIFF_CATEGORY')
                      AND t10.VALUE = t2.TARIFF_CATEGORY
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t11
                   ON     t11.enumeration_key = t10.enumeration_key
                      AND t11.VALUE = t10.VALUE
                      AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1
                AND t6.DISPLAY_VALUE = 'SMS'
         UNION
         SELECT t1.TARIFF_ID AS tariffId,
                t3.DISPLAY_VALUE AS displayValue,
                t2.RESELLER_VERSION_ID AS resellerVersionId,
                --       t5.SERVICE_VERSION_ID AS serviceVersionId,
                --       t6.DISPLAY_VALUE AS unitsTypeKey,
                --       t2.UNIT_TYPE AS unitType,
                --       t8.ISO_CODE AS currencyIsoCode,
                --       t8.IMPLIED_DECIMAL AS currencyImpliedDecimal,
                --       t9.DISPLAY_VALUE AS rateCurrencyKey,
                --       t2.CURRENCY_CODE AS currencyCode,

                -- *** add and modify
                1 AS STEP,
                1 AS TIER_FROM,
                1 AS TIER_TO,
                t2.FIRST_CON_AMOUNT AS BEAT,                -- firstConAmount,
                t2.FIRST_CON_CHARGE AS FACTOR,              -- firstConCharge,
                t2.FIRST_CON_AMOUNT AS CHARGE_BASE,         -- firstConAmount,
                --    t2.ADD_CON_AMOUNT as addConAmount,
                --    t2.ADD_CON_CHARGE as addConCharge,
                -- ### add and modify


                --       t2.ALLOW_DISCOUNT AS allowDiscount,
                --       t2.IS_CHARGEBLE AS isChargeble,
                --       t2.CONVERSION_RQD AS conversionRqd,
                --       t11.DISPLAY_VALUE AS tariffCategory,
                --       t2.NON_MON_ALLOWED AS nonMonAllowed,
                --       t3.LANGUAGE_CODE AS languageCode,

                t3.DESCRIPTION AS description
           FROM cbs_owner.TARIFF_KEY t1
                INNER JOIN cbs_owner.TARIFF_REF t2
                   ON t1.TARIFF_ID = t2.TARIFF_ID
                INNER JOIN
                cbs_owner.TARIFF_VALUES t3
                   ON     t2.TARIFF_ID = t3.TARIFF_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                INNER JOIN cbs_owner.UNITS_TYPE_KEY t4
                   ON t2.UNIT_TYPE = t4.UNIT_TYPE
                INNER JOIN
                cbs_owner.UNITS_TYPE_REF t5
                   ON     t4.UNIT_TYPE = t5.UNIT_TYPE
                      AND t5.SERVICE_VERSION_ID = 1
                INNER JOIN
                cbs_owner.UNITS_TYPE_VALUES t6
                   ON     t4.UNIT_TYPE = t6.UNIT_TYPE
                      AND t6.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                      AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.RATE_CURRENCY_KEY t7
                   ON t2.CURRENCY_CODE = t7.CURRENCY_CODE
                INNER JOIN
                cbs_owner.RATE_CURRENCY_REF t8
                   ON     t7.CURRENCY_CODE = t8.CURRENCY_CODE
                      AND t8.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                INNER JOIN
                cbs_owner.RATE_CURRENCY_VALUES t9
                   ON     t7.CURRENCY_CODE = t9.CURRENCY_CODE
                      AND t9.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                      AND t9.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t10
                   ON     t10.enumeration_key = LOWER ('TARIFF_CATEGORY')
                      AND t10.VALUE = t2.TARIFF_CATEGORY
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t11
                   ON     t11.enumeration_key = t10.enumeration_key
                      AND t11.VALUE = t10.VALUE
                      AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1
                AND t6.DISPLAY_VALUE = 'MMS'
         UNION
         SELECT t1.TARIFF_ID AS tariffId,
                t3.DISPLAY_VALUE AS displayValue,
                t2.RESELLER_VERSION_ID AS resellerVersionId,
                --       t5.SERVICE_VERSION_ID AS serviceVersionId,
                --       t6.DISPLAY_VALUE AS unitsTypeKey,
                --       t2.UNIT_TYPE AS unitType,
                --       t8.ISO_CODE AS currencyIsoCode,
                --       t8.IMPLIED_DECIMAL AS currencyImpliedDecimal,
                --       t9.DISPLAY_VALUE AS rateCurrencyKey,
                --       t2.CURRENCY_CODE AS currencyCode,

                -- *** add and modify
                1 AS STEP,
                0 AS TIER_FROM,
                t2.FIRST_CON_AMOUNT AS TIER_TO,             -- firstConAmount,
                t2.FIRST_CON_AMOUNT AS BEAT,                -- firstConAmount,
                t2.FIRST_CON_CHARGE AS FACTOR,              -- firstConCharge,
                t2.FIRST_CON_AMOUNT AS CHARGE_BASE,         -- firstConAmount,
                --       t2.ADD_CON_AMOUNT AS addConAmount,
                --       t2.ADD_CON_CHARGE AS addConCharge,
                -- ### add and modify


                --       t2.ALLOW_DISCOUNT AS allowDiscount,
                --       t2.IS_CHARGEBLE AS isChargeble,
                --       t2.CONVERSION_RQD AS conversionRqd,
                --       t11.DISPLAY_VALUE AS tariffCategory,
                --       t2.NON_MON_ALLOWED AS nonMonAllowed,
                --       t3.LANGUAGE_CODE AS languageCode,

                t3.DESCRIPTION AS description
           FROM cbs_owner.TARIFF_KEY t1
                INNER JOIN cbs_owner.TARIFF_REF t2
                   ON t1.TARIFF_ID = t2.TARIFF_ID
                INNER JOIN
                cbs_owner.TARIFF_VALUES t3
                   ON     t2.TARIFF_ID = t3.TARIFF_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                INNER JOIN cbs_owner.UNITS_TYPE_KEY t4
                   ON t2.UNIT_TYPE = t4.UNIT_TYPE
                INNER JOIN
                cbs_owner.UNITS_TYPE_REF t5
                   ON     t4.UNIT_TYPE = t5.UNIT_TYPE
                      AND t5.SERVICE_VERSION_ID = 1
                INNER JOIN
                cbs_owner.UNITS_TYPE_VALUES t6
                   ON     t4.UNIT_TYPE = t6.UNIT_TYPE
                      AND t6.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                      AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.RATE_CURRENCY_KEY t7
                   ON t2.CURRENCY_CODE = t7.CURRENCY_CODE
                INNER JOIN
                cbs_owner.RATE_CURRENCY_REF t8
                   ON     t7.CURRENCY_CODE = t8.CURRENCY_CODE
                      AND t8.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                INNER JOIN
                cbs_owner.RATE_CURRENCY_VALUES t9
                   ON     t7.CURRENCY_CODE = t9.CURRENCY_CODE
                      AND t9.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                      AND t9.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t10
                   ON     t10.enumeration_key = LOWER ('TARIFF_CATEGORY')
                      AND t10.VALUE = t2.TARIFF_CATEGORY
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t11
                   ON     t11.enumeration_key = t10.enumeration_key
                      AND t11.VALUE = t10.VALUE
                      AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1
                AND t6.DISPLAY_VALUE = 'OCTET'
         UNION
         SELECT t1.TARIFF_ID AS tariffId,
                t3.DISPLAY_VALUE AS displayValue,
                t2.RESELLER_VERSION_ID AS resellerVersionId,
                --       t5.SERVICE_VERSION_ID AS serviceVersionId,
                --       t6.DISPLAY_VALUE AS unitsTypeKey,
                --       t2.UNIT_TYPE AS unitType,
                --       t8.ISO_CODE AS currencyIsoCode,
                --       t8.IMPLIED_DECIMAL AS currencyImpliedDecimal,
                --       t9.DISPLAY_VALUE AS rateCurrencyKey,
                --       t2.CURRENCY_CODE AS currencyCode,

                -- *** add and modify
                2 AS STEP,
                t2.FIRST_CON_AMOUNT AS TIER_FROM,            -- firstConAmount
                86868686 AS TIER_TO,
                --        t2.FIRST_CON_AMOUNT as firstConAmount,
                --        t2.FIRST_CON_CHARGE as firstConCharge,
                t2.ADD_CON_AMOUNT AS BEAT,                    -- addConAmount,
                t2.ADD_CON_CHARGE AS FACTOR,                  -- addConCharge,
                t2.ADD_CON_AMOUNT AS CHARGE_BASE,             -- addConAmount,
                -- ### add and modify


                --       t2.ALLOW_DISCOUNT AS allowDiscount,
                --       t2.IS_CHARGEBLE AS isChargeble,
                --       t2.CONVERSION_RQD AS conversionRqd,
                --       t11.DISPLAY_VALUE AS tariffCategory,
                --       t2.NON_MON_ALLOWED AS nonMonAllowed,
                --       t3.LANGUAGE_CODE AS languageCode,

                t3.DESCRIPTION AS description
           FROM cbs_owner.TARIFF_KEY t1
                INNER JOIN cbs_owner.TARIFF_REF t2
                   ON t1.TARIFF_ID = t2.TARIFF_ID
                INNER JOIN
                cbs_owner.TARIFF_VALUES t3
                   ON     t2.TARIFF_ID = t3.TARIFF_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                INNER JOIN cbs_owner.UNITS_TYPE_KEY t4
                   ON t2.UNIT_TYPE = t4.UNIT_TYPE
                INNER JOIN
                cbs_owner.UNITS_TYPE_REF t5
                   ON     t4.UNIT_TYPE = t5.UNIT_TYPE
                      AND t5.SERVICE_VERSION_ID = 1
                INNER JOIN
                cbs_owner.UNITS_TYPE_VALUES t6
                   ON     t4.UNIT_TYPE = t6.UNIT_TYPE
                      AND t6.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                      AND t6.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.RATE_CURRENCY_KEY t7
                   ON t2.CURRENCY_CODE = t7.CURRENCY_CODE
                INNER JOIN
                cbs_owner.RATE_CURRENCY_REF t8
                   ON     t7.CURRENCY_CODE = t8.CURRENCY_CODE
                      AND t8.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                INNER JOIN
                cbs_owner.RATE_CURRENCY_VALUES t9
                   ON     t7.CURRENCY_CODE = t9.CURRENCY_CODE
                      AND t9.SERVICE_VERSION_ID = t5.SERVICE_VERSION_ID
                      AND t9.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t10
                   ON     t10.enumeration_key = LOWER ('TARIFF_CATEGORY')
                      AND t10.VALUE = t2.TARIFF_CATEGORY
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t11
                   ON     t11.enumeration_key = t10.enumeration_key
                      AND t11.VALUE = t10.VALUE
                      AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1
                AND t6.DISPLAY_VALUE = 'OCTET';
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_TARIFF_MODEL',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_TARIFF_PLAN (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.TARIFF_PLAN
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO ELC_USER.TARIFF_PLAN (TARIFF_PLAN_MAPPING_ID,
                                        RESELLER_VERSION_ID,
                                        TARIFF_PLAN_NAME,
                                        TARIFF_PLAN_ID,
                                        DEFAULT_CURRENCY_NAME,
                                        DEFAULT_CURRENCY_CODE,
                                        CALENDAR_NAME,
                                        CALENDAR_ID,
                                        UNIT_TYPE_NAME,
                                        UNIT_TYPE_ID,
                                        TARIFF_SET_NAME,
                                        TARIFF_SET_ID,
                                        CHARGE_RATE_CODE)
         SELECT t1.TARIFF_PLAN_MAPPING_ID AS tariff_plan_mapping_id, -- tariffPlanMappingId,
                t1.RESELLER_VERSION_ID AS reseller_version_id, -- resellerVersionId,
                t4.DISPLAY_VALUE AS tariff_plan_name,        -- tariffPlanKey,
                t1.TARIFF_PLAN_ID AS tariff_plan_id,          -- tariffPlanId,
                t8.DISPLAY_VALUE AS default_currency_name, -- defaultCurrencyCode,
                -- *** add
                T8.CURRENCY_CODE AS default_currency_code,
                T23.DISPLAY_VALUE AS calendar_name,
                T3.CALENDAR_ID,
                t43.DISPLAY_VALUE AS unit_type_name,
                T3.UNIT_TYPE AS UNIT_TYPE_ID,
                -- ### add
                t7.DISPLAY_VALUE AS tariff_set_name,        -- tariffSetIdKey,
                t1.TARIFF_SET_ID AS tariff_set_id,             -- tariffSetId,
                t1.CHARGE_RATE_CODE AS charge_rate_code      -- chargeRateCode
           FROM cbs_owner.TARIFF_PLAN_MAPPING t1
                INNER JOIN cbs_owner.TARIFF_PLAN_KEY t2
                   ON t1.TARIFF_PLAN_ID = t2.TARIFF_PLAN_ID
                INNER JOIN
                cbs_owner.TARIFF_PLAN_REF t3
                   ON     t2.TARIFF_PLAN_ID = t3.TARIFF_PLAN_ID
                      AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.TARIFF_PLAN_VALUES t4
                   ON     t2.TARIFF_PLAN_ID = t4.TARIFF_PLAN_ID
                      AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                      AND t4.LANGUAGE_CODE = 1
                INNER JOIN cbs_owner.TARIFF_SET_ID_KEY t5
                   ON t1.TARIFF_SET_ID = t5.TARIFF_SET_ID
                INNER JOIN
                cbs_owner.TARIFF_SET_ID_REF t6
                   ON     t5.TARIFF_SET_ID = t6.TARIFF_SET_ID
                      AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.TARIFF_SET_ID_VALUES t7
                   ON     t5.TARIFF_SET_ID = t7.TARIFF_SET_ID
                      AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                      AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.RATE_CURRENCY_VALUES t8
                   ON     t6.DEFAULT_CURRENCY_CODE = t8.CURRENCY_CODE
                      AND t8.SERVICE_VERSION_ID = 1
                      AND t8.LANGUAGE_CODE = t4.LANGUAGE_CODE
                -- *** add calendar
                INNER JOIN
                cbs_owner.CALENDAR_REF t22
                   ON     t3.CALENDAR_ID = t22.CALENDAR_ID
                      AND T1.RESELLER_VERSION_ID = T22.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.CALENDAR_VALUES t23
                   ON     t22.CALENDAR_ID = t23.CALENDAR_ID
                      AND t22.RESELLER_VERSION_ID = t23.RESELLER_VERSION_ID
                -- add unit type
                INNER JOIN
                cbs_owner.UNITS_TYPE_REF t42
                   ON     t3.UNIT_TYPE = t42.UNIT_TYPE
                      AND t42.SERVICE_VERSION_ID = t8.SERVICE_VERSION_ID
                INNER JOIN
                cbs_owner.UNITS_TYPE_VALUES t43
                   ON     t42.UNIT_TYPE = t43.UNIT_TYPE
                      AND t42.SERVICE_VERSION_ID = t43.SERVICE_VERSION_ID
                      AND t43.LANGUAGE_CODE = t4.LANGUAGE_CODE
          WHERE t1.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_TARIFF_PLAN',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_TIME_MAP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.TIME_MAP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO ELC_USER.TIME_MAP (CALENDAR_ID,
                                     RESELLER_VERSION_ID,
                                     CALENDAR_TYPE,
                                     CALENDAR_NAME,
                                     DESCRIPTION)
         SELECT t1.CALENDAR_ID AS calendar_id,                  -- calendarId,
                t2.RESELLER_VERSION_ID AS reseller_version_id, -- resellerVersionId,
                t5.DISPLAY_VALUE AS calendar_type,            -- calendarType,
                --       t8.DISPLAY_VALUE AS dayTypeIdKey,
                --       t2.MONDAY_ID AS mondayId,
                --       t11.DISPLAY_VALUE AS dayTypeIdKeyByTuesdayId,
                --       t2.TUESDAY_ID AS tuesdayId,
                --       t14.DISPLAY_VALUE AS dayTypeIdKeyByWednesdayId,
                --       t2.WEDNESDAY_ID AS wednesdayId,
                --       t17.DISPLAY_VALUE AS dayTypeIdKeyByThursdayId,
                --       t2.THURSDAY_ID AS thursdayId,
                --       t20.DISPLAY_VALUE AS dayTypeIdKeyByFridayId,
                --       t2.FRIDAY_ID AS fridayId,
                --       t23.DISPLAY_VALUE AS dayTypeIdKeyBySaturdayId,
                --       t2.SATURDAY_ID AS saturdayId,
                --       t26.DISPLAY_VALUE AS dayTypeIdKeyBySundayId,
                --       t2.SUNDAY_ID AS sundayId,
                --       t3.LANGUAGE_CODE AS languageCode,
                t3.DISPLAY_VALUE AS calendar_name,            -- displayValue,
                t3.DESCRIPTION AS description
           FROM cbs_owner.CALENDAR_KEY t1
                INNER JOIN cbs_owner.CALENDAR_REF t2
                   ON t1.CALENDAR_ID = t2.CALENDAR_ID
                INNER JOIN
                cbs_owner.CALENDAR_VALUES t3
                   ON     t2.CALENDAR_ID = t3.CALENDAR_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t4
                   ON     t4.enumeration_key = LOWER ('CALENDAR_TYPE')
                      AND t4.VALUE = t2.CALENDAR_TYPE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t5
                   ON     t5.enumeration_key = t4.enumeration_key
                      AND t5.VALUE = t4.VALUE
                      AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t6
                   ON t2.MONDAY_ID = t6.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t7
                   ON     t6.DAY_TYPE_ID = t7.DAY_TYPE_ID
                      AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t8
                   ON     t6.DAY_TYPE_ID = t8.DAY_TYPE_ID
                      AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t9
                   ON t2.TUESDAY_ID = t9.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t10
                   ON     t9.DAY_TYPE_ID = t10.DAY_TYPE_ID
                      AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t11
                   ON     t9.DAY_TYPE_ID = t11.DAY_TYPE_ID
                      AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t12
                   ON t2.WEDNESDAY_ID = t12.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t13
                   ON     t12.DAY_TYPE_ID = t13.DAY_TYPE_ID
                      AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t14
                   ON     t12.DAY_TYPE_ID = t14.DAY_TYPE_ID
                      AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t15
                   ON t2.THURSDAY_ID = t15.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t16
                   ON     t15.DAY_TYPE_ID = t16.DAY_TYPE_ID
                      AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t17
                   ON     t15.DAY_TYPE_ID = t17.DAY_TYPE_ID
                      AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t18
                   ON t2.FRIDAY_ID = t18.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t19
                   ON     t18.DAY_TYPE_ID = t19.DAY_TYPE_ID
                      AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t20
                   ON     t18.DAY_TYPE_ID = t20.DAY_TYPE_ID
                      AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t21
                   ON t2.SATURDAY_ID = t21.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t22
                   ON     t21.DAY_TYPE_ID = t22.DAY_TYPE_ID
                      AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t23
                   ON     t21.DAY_TYPE_ID = t23.DAY_TYPE_ID
                      AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t24
                   ON t2.SUNDAY_ID = t24.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t25
                   ON     t24.DAY_TYPE_ID = t25.DAY_TYPE_ID
                      AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t26
                   ON     t24.DAY_TYPE_ID = t26.DAY_TYPE_ID
                      AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t26.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_TIME_MAP',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_TIME_MODEL (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.TIME_MODEL
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO ELC_USER.TIME_MODEL (CALENDAR_ID,
                                       CALENDAR_NAME,
                                       MODEL_TYPE,
                                       DAY_IN,
                                       DAY_TYPE_NAME,
                                       DAY_TYPE_ID,
                                       DESCRIPTION,
                                       TIME_SLOT_ID,
                                       TIME_SLOT_NAME,
                                       FROM_IN,
                                       TO_IN,
                                       TIME_TYPE_ID,
                                       TIME_TYPE_NAME,
                                       RESELLER_VERSION_ID)
         SELECT t1.CALENDAR_ID AS CALENDAR_ID,
                t3.DISPLAY_VALUE AS CALENDAR_NAME,
                t5.DISPLAY_VALUE AS MODEL_Type,
                0 AS DAY_IN,                                        -- DAY_IN,
                t8.DISPLAY_VALUE AS day_Type_NAME,
                t2.MONDAY_ID AS DAY_TYPE_ID,
                --       t11.DISPLAY_VALUE AS dayTypeIdKeyByTuesdayId,
                --       t2.TUESDAY_ID AS tuesdayId,
                --       t14.DISPLAY_VALUE AS dayTypeIdKeyByWednesdayId,
                --       t2.WEDNESDAY_ID AS wednesdayId,
                --       t17.DISPLAY_VALUE AS dayTypeIdKeyByThursdayId,
                --       t2.THURSDAY_ID AS thursdayId,
                --       t20.DISPLAY_VALUE AS dayTypeIdKeyByFridayId,
                --       t2.FRIDAY_ID AS fridayId,
                --       t23.DISPLAY_VALUE AS dayTypeIdKeyBySaturdayId,
                --       t2.SATURDAY_ID AS saturdayId,
                --       t26.DISPLAY_VALUE AS dayTypeIdKeyBySundayId,
                --       t2.SUNDAY_ID AS sundayId,
                t3.DESCRIPTION AS description,
                -- TIME SLOT
                t31.TIME_SLOT_ID AS time_Slot_Id,
                t33.DISPLAY_VALUE AS time_slot_NAME,
                CASE t32.BEGIN_TIME
                   WHEN 0
                   THEN
                      '00:00'
                   ELSE
                      TO_CHAR (TO_DATE (t32.BEGIN_TIME - 1, 'sssss'),
                               'hh24:mi')
                END
                   AS FROM_IN,
                CASE t32.END_TIME
                   WHEN 0
                   THEN
                      '00:00'
                   ELSE
                      TO_CHAR (TO_DATE (t32.END_TIME - 1, 'sssss'),
                               'hh24:mi')
                END
                   AS TO_IN,
                -- TIME TYPE
                t28.TIME_TYPE_ID AS time_Type_Id,
                t30.DISPLAY_VALUE AS TIME_TYPE_name,
                t2.RESELLER_VERSION_ID
           FROM cbs_owner.CALENDAR_KEY t1
                INNER JOIN cbs_owner.CALENDAR_REF t2
                   ON t1.CALENDAR_ID = t2.CALENDAR_ID
                -- DAY_TIME_MAPPING
                INNER JOIN cbs_owner.DAY_TIME_MAPPING t27
                   ON t2.MONDAY_ID = t27.DAY_TYPE_ID
                -- TIME_TYPE
                INNER JOIN cbs_owner.TIME_TYPE_KEY t28
                   ON t28.TIME_TYPE_ID = t27.TIME_TYPE_ID
                INNER JOIN cbs_owner.TIME_TYPE_REF t29
                   ON t28.TIME_TYPE_ID = t29.TIME_TYPE_ID
                INNER JOIN
                cbs_owner.TIME_TYPE_VALUES t30
                   ON     t29.TIME_TYPE_ID = t30.TIME_TYPE_ID
                      AND t29.RESELLER_VERSION_ID = t30.RESELLER_VERSION_ID
                -- TIME SLOT
                INNER JOIN cbs_owner.TIME_SLOT_KEY t31
                   ON t31.TIME_SLOT_ID = t27.TIME_SLOT_ID
                INNER JOIN cbs_owner.TIME_SLOT_REF t32
                   ON t31.TIME_SLOT_ID = t32.TIME_SLOT_ID
                INNER JOIN
                cbs_owner.TIME_SLOT_VALUES t33
                   ON     t32.TIME_SLOT_ID = t33.TIME_SLOT_ID
                      AND t32.RESELLER_VERSION_ID = t33.RESELLER_VERSION_ID
                --
                INNER JOIN
                cbs_owner.CALENDAR_VALUES t3
                   ON     t2.CALENDAR_ID = t3.CALENDAR_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t4
                   ON     t4.enumeration_key = LOWER ('CALENDAR_TYPE')
                      AND t4.VALUE = t2.CALENDAR_TYPE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t5
                   ON     t5.enumeration_key = t4.enumeration_key
                      AND t5.VALUE = t4.VALUE
                      AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t6
                   ON t2.MONDAY_ID = t6.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t7
                   ON     t6.DAY_TYPE_ID = t7.DAY_TYPE_ID
                      AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t8
                   ON     t6.DAY_TYPE_ID = t8.DAY_TYPE_ID
                      AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t9
                   ON t2.TUESDAY_ID = t9.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t10
                   ON     t9.DAY_TYPE_ID = t10.DAY_TYPE_ID
                      AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t11
                   ON     t9.DAY_TYPE_ID = t11.DAY_TYPE_ID
                      AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t12
                   ON t2.WEDNESDAY_ID = t12.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t13
                   ON     t12.DAY_TYPE_ID = t13.DAY_TYPE_ID
                      AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t14
                   ON     t12.DAY_TYPE_ID = t14.DAY_TYPE_ID
                      AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t15
                   ON t2.THURSDAY_ID = t15.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t16
                   ON     t15.DAY_TYPE_ID = t16.DAY_TYPE_ID
                      AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t17
                   ON     t15.DAY_TYPE_ID = t17.DAY_TYPE_ID
                      AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t18
                   ON t2.FRIDAY_ID = t18.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t19
                   ON     t18.DAY_TYPE_ID = t19.DAY_TYPE_ID
                      AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t20
                   ON     t18.DAY_TYPE_ID = t20.DAY_TYPE_ID
                      AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t21
                   ON t2.SATURDAY_ID = t21.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t22
                   ON     t21.DAY_TYPE_ID = t22.DAY_TYPE_ID
                      AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t23
                   ON     t21.DAY_TYPE_ID = t23.DAY_TYPE_ID
                      AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t24
                   ON t2.SUNDAY_ID = t24.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t25
                   ON     t24.DAY_TYPE_ID = t25.DAY_TYPE_ID
                      AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t26
                   ON     t24.DAY_TYPE_ID = t26.DAY_TYPE_ID
                      AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t26.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1
         UNION
         SELECT t1.CALENDAR_ID AS TIME_MODEL_ID,
                t3.DISPLAY_VALUE AS TIME_MODEL_IN,
                t5.DISPLAY_VALUE AS MODEL_Type,
                1 AS DAY_IN,                                        -- DAY_IN,
                t11.DISPLAY_VALUE AS day_Type_NAME,
                t2.TUESDAY_ID AS DAY_TYPE_ID,
                t3.DESCRIPTION AS description,
                -- TIME SLOT
                t31.TIME_SLOT_ID AS time_Slot_Id,
                t33.DISPLAY_VALUE AS time_slot_NAME,
                CASE t32.BEGIN_TIME
                   WHEN 0
                   THEN
                      '00:00'
                   ELSE
                      TO_CHAR (TO_DATE (t32.BEGIN_TIME - 1, 'sssss'),
                               'hh24:mi')
                END
                   AS FROM_IN,
                CASE t32.END_TIME
                   WHEN 0
                   THEN
                      '00:00'
                   ELSE
                      TO_CHAR (TO_DATE (t32.END_TIME - 1, 'sssss'),
                               'hh24:mi')
                END
                   AS TO_IN,
                -- TIME TYPE
                t28.TIME_TYPE_ID AS time_Type_Id,
                t30.DISPLAY_VALUE AS TIME_TYPE_OUT,
                t2.RESELLER_VERSION_ID
           FROM cbs_owner.CALENDAR_KEY t1
                INNER JOIN cbs_owner.CALENDAR_REF t2
                   ON t1.CALENDAR_ID = t2.CALENDAR_ID
                -- DAY_TIME_MAPPING
                INNER JOIN cbs_owner.DAY_TIME_MAPPING t27
                   ON t2.MONDAY_ID = t27.DAY_TYPE_ID
                -- TIME_TYPE
                INNER JOIN cbs_owner.TIME_TYPE_KEY t28
                   ON t28.TIME_TYPE_ID = t27.TIME_TYPE_ID
                INNER JOIN cbs_owner.TIME_TYPE_REF t29
                   ON t28.TIME_TYPE_ID = t29.TIME_TYPE_ID
                INNER JOIN
                cbs_owner.TIME_TYPE_VALUES t30
                   ON     t29.TIME_TYPE_ID = t30.TIME_TYPE_ID
                      AND t29.RESELLER_VERSION_ID = t30.RESELLER_VERSION_ID
                -- TIME SLOT
                INNER JOIN cbs_owner.TIME_SLOT_KEY t31
                   ON t31.TIME_SLOT_ID = t27.TIME_SLOT_ID
                INNER JOIN cbs_owner.TIME_SLOT_REF t32
                   ON t31.TIME_SLOT_ID = t32.TIME_SLOT_ID
                INNER JOIN
                cbs_owner.TIME_SLOT_VALUES t33
                   ON     t32.TIME_SLOT_ID = t33.TIME_SLOT_ID
                      AND t32.RESELLER_VERSION_ID = t33.RESELLER_VERSION_ID
                --
                INNER JOIN
                cbs_owner.CALENDAR_VALUES t3
                   ON     t2.CALENDAR_ID = t3.CALENDAR_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t4
                   ON     t4.enumeration_key = LOWER ('CALENDAR_TYPE')
                      AND t4.VALUE = t2.CALENDAR_TYPE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t5
                   ON     t5.enumeration_key = t4.enumeration_key
                      AND t5.VALUE = t4.VALUE
                      AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t6
                   ON t2.MONDAY_ID = t6.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t7
                   ON     t6.DAY_TYPE_ID = t7.DAY_TYPE_ID
                      AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t8
                   ON     t6.DAY_TYPE_ID = t8.DAY_TYPE_ID
                      AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t9
                   ON t2.TUESDAY_ID = t9.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t10
                   ON     t9.DAY_TYPE_ID = t10.DAY_TYPE_ID
                      AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t11
                   ON     t9.DAY_TYPE_ID = t11.DAY_TYPE_ID
                      AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t12
                   ON t2.WEDNESDAY_ID = t12.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t13
                   ON     t12.DAY_TYPE_ID = t13.DAY_TYPE_ID
                      AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t14
                   ON     t12.DAY_TYPE_ID = t14.DAY_TYPE_ID
                      AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t15
                   ON t2.THURSDAY_ID = t15.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t16
                   ON     t15.DAY_TYPE_ID = t16.DAY_TYPE_ID
                      AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t17
                   ON     t15.DAY_TYPE_ID = t17.DAY_TYPE_ID
                      AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t18
                   ON t2.FRIDAY_ID = t18.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t19
                   ON     t18.DAY_TYPE_ID = t19.DAY_TYPE_ID
                      AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t20
                   ON     t18.DAY_TYPE_ID = t20.DAY_TYPE_ID
                      AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t21
                   ON t2.SATURDAY_ID = t21.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t22
                   ON     t21.DAY_TYPE_ID = t22.DAY_TYPE_ID
                      AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t23
                   ON     t21.DAY_TYPE_ID = t23.DAY_TYPE_ID
                      AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t24
                   ON t2.SUNDAY_ID = t24.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t25
                   ON     t24.DAY_TYPE_ID = t25.DAY_TYPE_ID
                      AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t26
                   ON     t24.DAY_TYPE_ID = t26.DAY_TYPE_ID
                      AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t26.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1
         UNION
         SELECT t1.CALENDAR_ID AS TIME_MODEL_ID,
                t3.DISPLAY_VALUE AS TIME_MODEL_IN,
                t5.DISPLAY_VALUE AS MODEL_Type,
                2 AS DAY_IN,                                        -- DAY_IN,
                t14.DISPLAY_VALUE AS day_Type_NAME,
                t2.TUESDAY_ID AS DAY_TYPE_ID,
                t3.DESCRIPTION AS description,
                -- TIME SLOT
                t31.TIME_SLOT_ID AS time_Slot_Id,
                t33.DISPLAY_VALUE AS time_slot_NAME,
                CASE t32.BEGIN_TIME
                   WHEN 0
                   THEN
                      '00:00'
                   ELSE
                      TO_CHAR (TO_DATE (t32.BEGIN_TIME - 1, 'sssss'),
                               'hh24:mi')
                END
                   AS FROM_IN,
                CASE t32.END_TIME
                   WHEN 0
                   THEN
                      '00:00'
                   ELSE
                      TO_CHAR (TO_DATE (t32.END_TIME - 1, 'sssss'),
                               'hh24:mi')
                END
                   AS TO_IN,
                -- TIME TYPE
                t28.TIME_TYPE_ID AS time_Type_Id,
                t30.DISPLAY_VALUE AS TIME_TYPE_OUT,
                t2.RESELLER_VERSION_ID
           FROM cbs_owner.CALENDAR_KEY t1
                INNER JOIN cbs_owner.CALENDAR_REF t2
                   ON t1.CALENDAR_ID = t2.CALENDAR_ID
                -- DAY_TIME_MAPPING
                INNER JOIN cbs_owner.DAY_TIME_MAPPING t27
                   ON t2.MONDAY_ID = t27.DAY_TYPE_ID
                -- TIME_TYPE
                INNER JOIN cbs_owner.TIME_TYPE_KEY t28
                   ON t28.TIME_TYPE_ID = t27.TIME_TYPE_ID
                INNER JOIN cbs_owner.TIME_TYPE_REF t29
                   ON t28.TIME_TYPE_ID = t29.TIME_TYPE_ID
                INNER JOIN
                cbs_owner.TIME_TYPE_VALUES t30
                   ON     t29.TIME_TYPE_ID = t30.TIME_TYPE_ID
                      AND t29.RESELLER_VERSION_ID = t30.RESELLER_VERSION_ID
                -- TIME SLOT
                INNER JOIN cbs_owner.TIME_SLOT_KEY t31
                   ON t31.TIME_SLOT_ID = t27.TIME_SLOT_ID
                INNER JOIN cbs_owner.TIME_SLOT_REF t32
                   ON t31.TIME_SLOT_ID = t32.TIME_SLOT_ID
                INNER JOIN
                cbs_owner.TIME_SLOT_VALUES t33
                   ON     t32.TIME_SLOT_ID = t33.TIME_SLOT_ID
                      AND t32.RESELLER_VERSION_ID = t33.RESELLER_VERSION_ID
                --
                INNER JOIN
                cbs_owner.CALENDAR_VALUES t3
                   ON     t2.CALENDAR_ID = t3.CALENDAR_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t4
                   ON     t4.enumeration_key = LOWER ('CALENDAR_TYPE')
                      AND t4.VALUE = t2.CALENDAR_TYPE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t5
                   ON     t5.enumeration_key = t4.enumeration_key
                      AND t5.VALUE = t4.VALUE
                      AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t6
                   ON t2.MONDAY_ID = t6.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t7
                   ON     t6.DAY_TYPE_ID = t7.DAY_TYPE_ID
                      AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t8
                   ON     t6.DAY_TYPE_ID = t8.DAY_TYPE_ID
                      AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t9
                   ON t2.TUESDAY_ID = t9.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t10
                   ON     t9.DAY_TYPE_ID = t10.DAY_TYPE_ID
                      AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t11
                   ON     t9.DAY_TYPE_ID = t11.DAY_TYPE_ID
                      AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t12
                   ON t2.WEDNESDAY_ID = t12.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t13
                   ON     t12.DAY_TYPE_ID = t13.DAY_TYPE_ID
                      AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t14
                   ON     t12.DAY_TYPE_ID = t14.DAY_TYPE_ID
                      AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t15
                   ON t2.THURSDAY_ID = t15.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t16
                   ON     t15.DAY_TYPE_ID = t16.DAY_TYPE_ID
                      AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t17
                   ON     t15.DAY_TYPE_ID = t17.DAY_TYPE_ID
                      AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t18
                   ON t2.FRIDAY_ID = t18.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t19
                   ON     t18.DAY_TYPE_ID = t19.DAY_TYPE_ID
                      AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t20
                   ON     t18.DAY_TYPE_ID = t20.DAY_TYPE_ID
                      AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t21
                   ON t2.SATURDAY_ID = t21.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t22
                   ON     t21.DAY_TYPE_ID = t22.DAY_TYPE_ID
                      AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t23
                   ON     t21.DAY_TYPE_ID = t23.DAY_TYPE_ID
                      AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t24
                   ON t2.SUNDAY_ID = t24.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t25
                   ON     t24.DAY_TYPE_ID = t25.DAY_TYPE_ID
                      AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t26
                   ON     t24.DAY_TYPE_ID = t26.DAY_TYPE_ID
                      AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t26.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1
         UNION
         SELECT t1.CALENDAR_ID AS TIME_MODEL_ID,
                t3.DISPLAY_VALUE AS TIME_MODEL_IN,
                t5.DISPLAY_VALUE AS MODEL_Type,
                3 AS DAY_IN,                                        -- DAY_IN,
                t20.DISPLAY_VALUE AS day_Type_NAME,
                t2.THURSDAY_ID AS DAY_TYPE_ID,
                t3.DESCRIPTION AS description,
                -- TIME SLOT
                t31.TIME_SLOT_ID AS time_Slot_Id,
                t33.DISPLAY_VALUE AS time_slot_NAME,
                CASE t32.BEGIN_TIME
                   WHEN 0
                   THEN
                      '00:00'
                   ELSE
                      TO_CHAR (TO_DATE (t32.BEGIN_TIME - 1, 'sssss'),
                               'hh24:mi')
                END
                   AS FROM_IN,
                CASE t32.END_TIME
                   WHEN 0
                   THEN
                      '00:00'
                   ELSE
                      TO_CHAR (TO_DATE (t32.END_TIME - 1, 'sssss'),
                               'hh24:mi')
                END
                   AS TO_IN,
                -- TIME TYPE
                t28.TIME_TYPE_ID AS time_Type_Id,
                t30.DISPLAY_VALUE AS TIME_TYPE_OUT,
                t2.RESELLER_VERSION_ID
           FROM cbs_owner.CALENDAR_KEY t1
                INNER JOIN cbs_owner.CALENDAR_REF t2
                   ON t1.CALENDAR_ID = t2.CALENDAR_ID
                -- DAY_TIME_MAPPING
                INNER JOIN cbs_owner.DAY_TIME_MAPPING t27
                   ON t2.MONDAY_ID = t27.DAY_TYPE_ID
                -- TIME_TYPE
                INNER JOIN cbs_owner.TIME_TYPE_KEY t28
                   ON t28.TIME_TYPE_ID = t27.TIME_TYPE_ID
                INNER JOIN cbs_owner.TIME_TYPE_REF t29
                   ON t28.TIME_TYPE_ID = t29.TIME_TYPE_ID
                INNER JOIN
                cbs_owner.TIME_TYPE_VALUES t30
                   ON     t29.TIME_TYPE_ID = t30.TIME_TYPE_ID
                      AND t29.RESELLER_VERSION_ID = t30.RESELLER_VERSION_ID
                -- TIME SLOT
                INNER JOIN cbs_owner.TIME_SLOT_KEY t31
                   ON t31.TIME_SLOT_ID = t27.TIME_SLOT_ID
                INNER JOIN cbs_owner.TIME_SLOT_REF t32
                   ON t31.TIME_SLOT_ID = t32.TIME_SLOT_ID
                INNER JOIN
                cbs_owner.TIME_SLOT_VALUES t33
                   ON     t32.TIME_SLOT_ID = t33.TIME_SLOT_ID
                      AND t32.RESELLER_VERSION_ID = t33.RESELLER_VERSION_ID
                --
                INNER JOIN
                cbs_owner.CALENDAR_VALUES t3
                   ON     t2.CALENDAR_ID = t3.CALENDAR_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t4
                   ON     t4.enumeration_key = LOWER ('CALENDAR_TYPE')
                      AND t4.VALUE = t2.CALENDAR_TYPE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t5
                   ON     t5.enumeration_key = t4.enumeration_key
                      AND t5.VALUE = t4.VALUE
                      AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t6
                   ON t2.MONDAY_ID = t6.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t7
                   ON     t6.DAY_TYPE_ID = t7.DAY_TYPE_ID
                      AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t8
                   ON     t6.DAY_TYPE_ID = t8.DAY_TYPE_ID
                      AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t9
                   ON t2.TUESDAY_ID = t9.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t10
                   ON     t9.DAY_TYPE_ID = t10.DAY_TYPE_ID
                      AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t11
                   ON     t9.DAY_TYPE_ID = t11.DAY_TYPE_ID
                      AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t12
                   ON t2.WEDNESDAY_ID = t12.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t13
                   ON     t12.DAY_TYPE_ID = t13.DAY_TYPE_ID
                      AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t14
                   ON     t12.DAY_TYPE_ID = t14.DAY_TYPE_ID
                      AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t15
                   ON t2.THURSDAY_ID = t15.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t16
                   ON     t15.DAY_TYPE_ID = t16.DAY_TYPE_ID
                      AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t17
                   ON     t15.DAY_TYPE_ID = t17.DAY_TYPE_ID
                      AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t18
                   ON t2.FRIDAY_ID = t18.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t19
                   ON     t18.DAY_TYPE_ID = t19.DAY_TYPE_ID
                      AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t20
                   ON     t18.DAY_TYPE_ID = t20.DAY_TYPE_ID
                      AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t21
                   ON t2.SATURDAY_ID = t21.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t22
                   ON     t21.DAY_TYPE_ID = t22.DAY_TYPE_ID
                      AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t23
                   ON     t21.DAY_TYPE_ID = t23.DAY_TYPE_ID
                      AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t24
                   ON t2.SUNDAY_ID = t24.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t25
                   ON     t24.DAY_TYPE_ID = t25.DAY_TYPE_ID
                      AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t26
                   ON     t24.DAY_TYPE_ID = t26.DAY_TYPE_ID
                      AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t26.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1
         UNION
         SELECT t1.CALENDAR_ID AS TIME_MODEL_ID,
                t3.DISPLAY_VALUE AS TIME_MODEL_IN,
                t5.DISPLAY_VALUE AS MODEL_Type,
                4 AS DAY_IN,                                        -- DAY_IN,
                t20.DISPLAY_VALUE AS day_Type_NAME,
                t2.FRIDAY_ID AS DAY_TYPE_ID,
                t3.DESCRIPTION AS description,
                -- TIME SLOT
                t31.TIME_SLOT_ID AS time_Slot_Id,
                t33.DISPLAY_VALUE AS time_slot_NAME,
                CASE t32.BEGIN_TIME
                   WHEN 0
                   THEN
                      '00:00'
                   ELSE
                      TO_CHAR (TO_DATE (t32.BEGIN_TIME - 1, 'sssss'),
                               'hh24:mi')
                END
                   AS FROM_IN,
                CASE t32.END_TIME
                   WHEN 0
                   THEN
                      '00:00'
                   ELSE
                      TO_CHAR (TO_DATE (t32.END_TIME - 1, 'sssss'),
                               'hh24:mi')
                END
                   AS TO_IN,
                -- TIME TYPE
                t28.TIME_TYPE_ID AS time_Type_Id,
                t30.DISPLAY_VALUE AS TIME_TYPE_OUT,
                t2.RESELLER_VERSION_ID
           FROM cbs_owner.CALENDAR_KEY t1
                INNER JOIN cbs_owner.CALENDAR_REF t2
                   ON t1.CALENDAR_ID = t2.CALENDAR_ID
                -- DAY_TIME_MAPPING
                INNER JOIN cbs_owner.DAY_TIME_MAPPING t27
                   ON t2.MONDAY_ID = t27.DAY_TYPE_ID
                -- TIME_TYPE
                INNER JOIN cbs_owner.TIME_TYPE_KEY t28
                   ON t28.TIME_TYPE_ID = t27.TIME_TYPE_ID
                INNER JOIN cbs_owner.TIME_TYPE_REF t29
                   ON t28.TIME_TYPE_ID = t29.TIME_TYPE_ID
                INNER JOIN
                cbs_owner.TIME_TYPE_VALUES t30
                   ON     t29.TIME_TYPE_ID = t30.TIME_TYPE_ID
                      AND t29.RESELLER_VERSION_ID = t30.RESELLER_VERSION_ID
                -- TIME SLOT
                INNER JOIN cbs_owner.TIME_SLOT_KEY t31
                   ON t31.TIME_SLOT_ID = t27.TIME_SLOT_ID
                INNER JOIN cbs_owner.TIME_SLOT_REF t32
                   ON t31.TIME_SLOT_ID = t32.TIME_SLOT_ID
                INNER JOIN
                cbs_owner.TIME_SLOT_VALUES t33
                   ON     t32.TIME_SLOT_ID = t33.TIME_SLOT_ID
                      AND t32.RESELLER_VERSION_ID = t33.RESELLER_VERSION_ID
                --
                INNER JOIN
                cbs_owner.CALENDAR_VALUES t3
                   ON     t2.CALENDAR_ID = t3.CALENDAR_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t4
                   ON     t4.enumeration_key = LOWER ('CALENDAR_TYPE')
                      AND t4.VALUE = t2.CALENDAR_TYPE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t5
                   ON     t5.enumeration_key = t4.enumeration_key
                      AND t5.VALUE = t4.VALUE
                      AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t6
                   ON t2.MONDAY_ID = t6.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t7
                   ON     t6.DAY_TYPE_ID = t7.DAY_TYPE_ID
                      AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t8
                   ON     t6.DAY_TYPE_ID = t8.DAY_TYPE_ID
                      AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t9
                   ON t2.TUESDAY_ID = t9.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t10
                   ON     t9.DAY_TYPE_ID = t10.DAY_TYPE_ID
                      AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t11
                   ON     t9.DAY_TYPE_ID = t11.DAY_TYPE_ID
                      AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t12
                   ON t2.WEDNESDAY_ID = t12.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t13
                   ON     t12.DAY_TYPE_ID = t13.DAY_TYPE_ID
                      AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t14
                   ON     t12.DAY_TYPE_ID = t14.DAY_TYPE_ID
                      AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t15
                   ON t2.THURSDAY_ID = t15.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t16
                   ON     t15.DAY_TYPE_ID = t16.DAY_TYPE_ID
                      AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t17
                   ON     t15.DAY_TYPE_ID = t17.DAY_TYPE_ID
                      AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t18
                   ON t2.FRIDAY_ID = t18.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t19
                   ON     t18.DAY_TYPE_ID = t19.DAY_TYPE_ID
                      AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t20
                   ON     t18.DAY_TYPE_ID = t20.DAY_TYPE_ID
                      AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t21
                   ON t2.SATURDAY_ID = t21.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t22
                   ON     t21.DAY_TYPE_ID = t22.DAY_TYPE_ID
                      AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t23
                   ON     t21.DAY_TYPE_ID = t23.DAY_TYPE_ID
                      AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t24
                   ON t2.SUNDAY_ID = t24.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t25
                   ON     t24.DAY_TYPE_ID = t25.DAY_TYPE_ID
                      AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t26
                   ON     t24.DAY_TYPE_ID = t26.DAY_TYPE_ID
                      AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t26.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1
         UNION
         SELECT t1.CALENDAR_ID AS TIME_MODEL_ID,
                t3.DISPLAY_VALUE AS TIME_MODEL_IN,
                t5.DISPLAY_VALUE AS MODEL_Type,
                5 AS DAY_IN,                                        -- DAY_IN,
                t23.DISPLAY_VALUE AS day_Type_NAME,
                t2.SATURDAY_ID AS DAY_TYPE_ID,
                t3.DESCRIPTION AS description,
                -- TIME SLOT
                t31.TIME_SLOT_ID AS time_Slot_Id,
                t33.DISPLAY_VALUE AS time_slot_NAME,
                CASE t32.BEGIN_TIME
                   WHEN 0
                   THEN
                      '00:00'
                   ELSE
                      TO_CHAR (TO_DATE (t32.BEGIN_TIME - 1, 'sssss'),
                               'hh24:mi')
                END
                   AS FROM_IN,
                CASE t32.END_TIME
                   WHEN 0
                   THEN
                      '00:00'
                   ELSE
                      TO_CHAR (TO_DATE (t32.END_TIME - 1, 'sssss'),
                               'hh24:mi')
                END
                   AS TO_IN,
                -- TIME TYPE
                t28.TIME_TYPE_ID AS time_Type_Id,
                t30.DISPLAY_VALUE AS TIME_TYPE_OUT,
                t2.RESELLER_VERSION_ID
           FROM cbs_owner.CALENDAR_KEY t1
                INNER JOIN cbs_owner.CALENDAR_REF t2
                   ON t1.CALENDAR_ID = t2.CALENDAR_ID
                -- DAY_TIME_MAPPING
                INNER JOIN cbs_owner.DAY_TIME_MAPPING t27
                   ON t2.MONDAY_ID = t27.DAY_TYPE_ID
                -- TIME_TYPE
                INNER JOIN cbs_owner.TIME_TYPE_KEY t28
                   ON t28.TIME_TYPE_ID = t27.TIME_TYPE_ID
                INNER JOIN cbs_owner.TIME_TYPE_REF t29
                   ON t28.TIME_TYPE_ID = t29.TIME_TYPE_ID
                INNER JOIN
                cbs_owner.TIME_TYPE_VALUES t30
                   ON     t29.TIME_TYPE_ID = t30.TIME_TYPE_ID
                      AND t29.RESELLER_VERSION_ID = t30.RESELLER_VERSION_ID
                -- TIME SLOT
                INNER JOIN cbs_owner.TIME_SLOT_KEY t31
                   ON t31.TIME_SLOT_ID = t27.TIME_SLOT_ID
                INNER JOIN cbs_owner.TIME_SLOT_REF t32
                   ON t31.TIME_SLOT_ID = t32.TIME_SLOT_ID
                INNER JOIN
                cbs_owner.TIME_SLOT_VALUES t33
                   ON     t32.TIME_SLOT_ID = t33.TIME_SLOT_ID
                      AND t32.RESELLER_VERSION_ID = t33.RESELLER_VERSION_ID
                --
                INNER JOIN
                cbs_owner.CALENDAR_VALUES t3
                   ON     t2.CALENDAR_ID = t3.CALENDAR_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t4
                   ON     t4.enumeration_key = LOWER ('CALENDAR_TYPE')
                      AND t4.VALUE = t2.CALENDAR_TYPE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t5
                   ON     t5.enumeration_key = t4.enumeration_key
                      AND t5.VALUE = t4.VALUE
                      AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t6
                   ON t2.MONDAY_ID = t6.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t7
                   ON     t6.DAY_TYPE_ID = t7.DAY_TYPE_ID
                      AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t8
                   ON     t6.DAY_TYPE_ID = t8.DAY_TYPE_ID
                      AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t9
                   ON t2.TUESDAY_ID = t9.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t10
                   ON     t9.DAY_TYPE_ID = t10.DAY_TYPE_ID
                      AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t11
                   ON     t9.DAY_TYPE_ID = t11.DAY_TYPE_ID
                      AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t12
                   ON t2.WEDNESDAY_ID = t12.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t13
                   ON     t12.DAY_TYPE_ID = t13.DAY_TYPE_ID
                      AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t14
                   ON     t12.DAY_TYPE_ID = t14.DAY_TYPE_ID
                      AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t15
                   ON t2.THURSDAY_ID = t15.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t16
                   ON     t15.DAY_TYPE_ID = t16.DAY_TYPE_ID
                      AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t17
                   ON     t15.DAY_TYPE_ID = t17.DAY_TYPE_ID
                      AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t18
                   ON t2.FRIDAY_ID = t18.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t19
                   ON     t18.DAY_TYPE_ID = t19.DAY_TYPE_ID
                      AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t20
                   ON     t18.DAY_TYPE_ID = t20.DAY_TYPE_ID
                      AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t21
                   ON t2.SATURDAY_ID = t21.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t22
                   ON     t21.DAY_TYPE_ID = t22.DAY_TYPE_ID
                      AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t23
                   ON     t21.DAY_TYPE_ID = t23.DAY_TYPE_ID
                      AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t24
                   ON t2.SUNDAY_ID = t24.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t25
                   ON     t24.DAY_TYPE_ID = t25.DAY_TYPE_ID
                      AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t26
                   ON     t24.DAY_TYPE_ID = t26.DAY_TYPE_ID
                      AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t26.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1
         UNION
         SELECT t1.CALENDAR_ID AS TIME_MODEL_ID,
                t3.DISPLAY_VALUE AS TIME_MODEL_IN,
                t5.DISPLAY_VALUE AS MODEL_Type,
                6 AS DAY_IN,                                        -- DAY_IN,
                t26.DISPLAY_VALUE AS day_Type_NAME,
                t2.SUNDAY_ID AS DAY_TYPE_ID,
                t3.DESCRIPTION AS description,
                -- TIME SLOT
                t31.TIME_SLOT_ID AS time_Slot_Id,
                t33.DISPLAY_VALUE AS time_slot_NAME,
                CASE t32.BEGIN_TIME
                   WHEN 0
                   THEN
                      '00:00'
                   ELSE
                      TO_CHAR (TO_DATE (t32.BEGIN_TIME - 1, 'sssss'),
                               'hh24:mi')
                END
                   AS FROM_IN,
                CASE t32.END_TIME
                   WHEN 0
                   THEN
                      '00:00'
                   ELSE
                      TO_CHAR (TO_DATE (t32.END_TIME - 1, 'sssss'),
                               'hh24:mi')
                END
                   AS TO_IN,
                -- TIME TYPE
                t28.TIME_TYPE_ID AS time_Type_Id,
                t30.DISPLAY_VALUE AS TIME_TYPE_OUT,
                t2.RESELLER_VERSION_ID
           FROM cbs_owner.CALENDAR_KEY t1
                INNER JOIN cbs_owner.CALENDAR_REF t2
                   ON t1.CALENDAR_ID = t2.CALENDAR_ID
                -- DAY_TIME_MAPPING
                INNER JOIN cbs_owner.DAY_TIME_MAPPING t27
                   ON t2.MONDAY_ID = t27.DAY_TYPE_ID
                -- TIME_TYPE
                INNER JOIN cbs_owner.TIME_TYPE_KEY t28
                   ON t28.TIME_TYPE_ID = t27.TIME_TYPE_ID
                INNER JOIN cbs_owner.TIME_TYPE_REF t29
                   ON t28.TIME_TYPE_ID = t29.TIME_TYPE_ID
                INNER JOIN
                cbs_owner.TIME_TYPE_VALUES t30
                   ON     t29.TIME_TYPE_ID = t30.TIME_TYPE_ID
                      AND t29.RESELLER_VERSION_ID = t30.RESELLER_VERSION_ID
                -- TIME SLOT
                INNER JOIN cbs_owner.TIME_SLOT_KEY t31
                   ON t31.TIME_SLOT_ID = t27.TIME_SLOT_ID
                INNER JOIN cbs_owner.TIME_SLOT_REF t32
                   ON t31.TIME_SLOT_ID = t32.TIME_SLOT_ID
                INNER JOIN
                cbs_owner.TIME_SLOT_VALUES t33
                   ON     t32.TIME_SLOT_ID = t33.TIME_SLOT_ID
                      AND t32.RESELLER_VERSION_ID = t33.RESELLER_VERSION_ID
                --
                INNER JOIN
                cbs_owner.CALENDAR_VALUES t3
                   ON     t2.CALENDAR_ID = t3.CALENDAR_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_REF t4
                   ON     t4.enumeration_key = LOWER ('CALENDAR_TYPE')
                      AND t4.VALUE = t2.CALENDAR_TYPE
                LEFT OUTER JOIN
                cbs_owner.GENERIC_ENUMERATION_VALUES t5
                   ON     t5.enumeration_key = t4.enumeration_key
                      AND t5.VALUE = t4.VALUE
                      AND t5.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t6
                   ON t2.MONDAY_ID = t6.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t7
                   ON     t6.DAY_TYPE_ID = t7.DAY_TYPE_ID
                      AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t8
                   ON     t6.DAY_TYPE_ID = t8.DAY_TYPE_ID
                      AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t8.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t9
                   ON t2.TUESDAY_ID = t9.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t10
                   ON     t9.DAY_TYPE_ID = t10.DAY_TYPE_ID
                      AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t11
                   ON     t9.DAY_TYPE_ID = t11.DAY_TYPE_ID
                      AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t11.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t12
                   ON t2.WEDNESDAY_ID = t12.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t13
                   ON     t12.DAY_TYPE_ID = t13.DAY_TYPE_ID
                      AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t14
                   ON     t12.DAY_TYPE_ID = t14.DAY_TYPE_ID
                      AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t14.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t15
                   ON t2.THURSDAY_ID = t15.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t16
                   ON     t15.DAY_TYPE_ID = t16.DAY_TYPE_ID
                      AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t17
                   ON     t15.DAY_TYPE_ID = t17.DAY_TYPE_ID
                      AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t17.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t18
                   ON t2.FRIDAY_ID = t18.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t19
                   ON     t18.DAY_TYPE_ID = t19.DAY_TYPE_ID
                      AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t20
                   ON     t18.DAY_TYPE_ID = t20.DAY_TYPE_ID
                      AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t20.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t21
                   ON t2.SATURDAY_ID = t21.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t22
                   ON     t21.DAY_TYPE_ID = t22.DAY_TYPE_ID
                      AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t23
                   ON     t21.DAY_TYPE_ID = t23.DAY_TYPE_ID
                      AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t23.LANGUAGE_CODE = t3.LANGUAGE_CODE
                INNER JOIN cbs_owner.DAY_TYPE_ID_KEY t24
                   ON t2.SUNDAY_ID = t24.DAY_TYPE_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_REF t25
                   ON     t24.DAY_TYPE_ID = t25.DAY_TYPE_ID
                      AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.DAY_TYPE_ID_VALUES t26
                   ON     t24.DAY_TYPE_ID = t26.DAY_TYPE_ID
                      AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t26.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_TIME_MODEL',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_USAGE_ACTIVITY (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.USAGE_ACTIVITY
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO ELC_USER.USAGE_ACTIVITY (UA_ID,
                                           UA_NAME,
                                           RESELLER_VERSION_ID,
                                           UNIT_TYPE_NAME,
                                           UNIT_TYPE_ID,
                                           SUB_TYPE_NAME,
                                           SUB_TYPE_ID,
                                           APP_NAME,
                                           APP_ID,
                                           UA_INITIAL_NAME,
                                           UA_INITIAL_ID,
                                           TAX_CLASS_NAME,
                                           TAX_CLASS_ID,
                                           DESCRIPTION)
         SELECT t1.AUT_ID AS ua_id,                                  -- autId,
                t3.DISPLAY_VALUE AS ua_name,                  -- displayValue,
                t2.RESELLER_VERSION_ID,               -- AS resellerVersionId,
                --       t2.IS_PRERATED AS isPrerated,
                --       t2.OPEN_ITEM_ID AS openItemId,
                --       t2.IS_LATE_FEE_EXEMPT AS isLateFeeExempt,
                --       t27.SERVICE_VERSION_ID AS serviceVersionId,
                t28.DISPLAY_VALUE AS unit_type_name,          -- unitsTypeKey,
                t2.UNIT_TYPE AS unit_type_id,                     -- unitType,
                t13.DISPLAY_VALUE AS sub_type_name,           -- subTypeIdKey,
                t2.SUB_TYPE_ID AS sub_type_id,                   -- subTypeId,
                t16.DISPLAY_VALUE AS app_name,            -- applicationIdKey,
                t2.APPLICATION_ID AS app_id,                 -- applicationId,
                t19.DISPLAY_VALUE AS ua_initial_name,        -- autInitialKey,
                T19.INITIAL_AUT_ID AS ua_initial_id,
                --       t2.GENERATED_FROM AS generatedFrom,
                --       t2.ACTIVITY_CHAR_IDS AS activityCharIds,
                t22.DISPLAY_VALUE AS tax_class_name,           -- taxClassKey,
                t2.TAX_CLASS AS tax_class_id,                     -- taxClass,
                --       t33.DISPLAY_VALUE AS productLineKey,
                --       t2.PRODUCT_LINE_ID AS productLineId,
                --       t36.DISPLAY_VALUE AS ratableUnitClassKey,
                --       t2.RATABLE_UNIT_CLASS AS ratableUnitClass,
                --       t3.LANGUAGE_CODE AS languageCode,
                t3.DESCRIPTION AS description
           FROM cbs_owner.AUT_FINAL_KEY t1
                INNER JOIN cbs_owner.AUT_FINAL_REF t2
                   ON t1.AUT_ID = t2.AUT_ID
                INNER JOIN
                cbs_owner.AUT_FINAL_VALUES t3
                   ON     t2.AUT_ID = t3.AUT_ID
                      AND t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
                INNER JOIN cbs_owner.UNITS_TYPE_KEY t26
                   ON t2.UNIT_TYPE = t26.UNIT_TYPE
                INNER JOIN
                cbs_owner.UNITS_TYPE_REF t27
                   ON     t26.UNIT_TYPE = t27.UNIT_TYPE
                      AND t27.SERVICE_VERSION_ID = 1
                INNER JOIN
                cbs_owner.UNITS_TYPE_VALUES t28
                   ON     t26.UNIT_TYPE = t28.UNIT_TYPE
                      AND t28.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
                      AND t28.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.SUB_TYPE_ID_KEY t11
                   ON t2.SUB_TYPE_ID = t11.SUB_TYPE_ID
                LEFT OUTER JOIN
                cbs_owner.SUB_TYPE_ID_REF t12
                   ON     t11.SUB_TYPE_ID = t12.SUB_TYPE_ID
                      AND t12.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.SUB_TYPE_ID_VALUES t13
                   ON     t11.SUB_TYPE_ID = t13.SUB_TYPE_ID
                      AND t13.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
                      AND t13.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.APPLICATION_ID_KEY t14
                   ON t2.APPLICATION_ID = t14.APPLICATION_ID
                LEFT OUTER JOIN
                cbs_owner.APPLICATION_ID_REF t15
                   ON     t14.APPLICATION_ID = t15.APPLICATION_ID
                      AND t15.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.APPLICATION_ID_VALUES t16
                   ON     t14.APPLICATION_ID = t16.APPLICATION_ID
                      AND t16.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
                      AND t16.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.AUT_INITIAL_KEY t17
                   ON t2.GENERATED_FROM = t17.INITIAL_AUT_ID
                LEFT OUTER JOIN
                cbs_owner.AUT_INITIAL_REF t18
                   ON     t17.INITIAL_AUT_ID = t18.INITIAL_AUT_ID
                      AND t18.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.AUT_INITIAL_VALUES t19
                   ON     t17.INITIAL_AUT_ID = t19.INITIAL_AUT_ID
                      AND t19.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
                      AND t19.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.TAX_CLASS_KEY t20
                   ON t2.TAX_CLASS = t20.TAX_CLASS
                LEFT OUTER JOIN
                cbs_owner.TAX_CLASS_REF t21
                   ON     t20.TAX_CLASS = t21.TAX_CLASS
                      AND t21.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.TAX_CLASS_VALUES t22
                   ON     t20.TAX_CLASS = t22.TAX_CLASS
                      AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t22.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.PRODUCT_LINE_KEY t31
                   ON t2.PRODUCT_LINE_ID = t31.PRODUCT_LINE_ID
                LEFT OUTER JOIN
                cbs_owner.PRODUCT_LINE_REF t32
                   ON     t31.PRODUCT_LINE_ID = t32.PRODUCT_LINE_ID
                      AND t32.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.PRODUCT_LINE_VALUES t33
                   ON     t31.PRODUCT_LINE_ID = t33.PRODUCT_LINE_ID
                      AND t33.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t33.LANGUAGE_CODE = t3.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.RATABLE_UNIT_CLASS_KEY t34
                   ON t2.RATABLE_UNIT_CLASS = t34.RATABLE_UNIT_CLASS
                LEFT OUTER JOIN
                cbs_owner.RATABLE_UNIT_CLASS_REF t35
                   ON     t34.RATABLE_UNIT_CLASS = t35.RATABLE_UNIT_CLASS
                      AND t35.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.RATABLE_UNIT_CLASS_VALUES t36
                   ON     t34.RATABLE_UNIT_CLASS = t36.RATABLE_UNIT_CLASS
                      AND t36.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
                      AND t36.LANGUAGE_CODE = t3.LANGUAGE_CODE
          WHERE     t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t3.LANGUAGE_CODE = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_USAGE_ACTIVITY',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_USAGE_ACTIVITY_GROUP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.USAGE_ACTIVITY_GROUP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO ELC_USER.USAGE_ACTIVITY_GROUP (UA_MAP_ID,
                                                 UA_GROUP_NAME,
                                                 UA_GROUP_ID,
                                                 UA_NAME,
                                                 UA_ID,
                                                 RESELLER_VERSION_ID)
         SELECT t1.AUT_GROUP_MAP_ID AS ua_map_id,            -- autGroupMapId,
                t4.DISPLAY_VALUE AS ua_group_name,             -- autGroupKey,
                t1.AUT_GROUP_ID AS ua_group_id,                 -- autGroupId,
                --       t6.SERVICE_VERSION_ID AS serviceVersionId,
                --       t7.DISPLAY_VALUE AS applicationIdKey,
                --       t1.APPLICATION_ID AS applicationId,
                t10.DISPLAY_VALUE AS ua_name,                  -- autFinalKey,
                t1.AUT_ID AS ua_id,                                  -- autId,
                t1.RESELLER_VERSION_ID AS reseller_Version_Id
           FROM cbs_owner.AUT_GROUP_MAP t1
                INNER JOIN cbs_owner.AUT_GROUP_KEY t2
                   ON t1.AUT_GROUP_ID = t2.AUT_GROUP_ID
                INNER JOIN
                cbs_owner.AUT_GROUP_REF t3
                   ON     t2.AUT_GROUP_ID = t3.AUT_GROUP_ID
                      AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.AUT_GROUP_VALUES t4
                   ON     t2.AUT_GROUP_ID = t4.AUT_GROUP_ID
                      AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                      AND t4.LANGUAGE_CODE = 1
                LEFT OUTER JOIN cbs_owner.APPLICATION_ID_KEY t5
                   ON t1.APPLICATION_ID = t5.APPLICATION_ID
                LEFT OUTER JOIN
                cbs_owner.APPLICATION_ID_REF t6
                   ON     t5.APPLICATION_ID = t6.APPLICATION_ID
                      AND t6.SERVICE_VERSION_ID = 1
                LEFT OUTER JOIN
                cbs_owner.APPLICATION_ID_VALUES t7
                   ON     t5.APPLICATION_ID = t7.APPLICATION_ID
                      AND t7.SERVICE_VERSION_ID = 1
                      AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
                LEFT OUTER JOIN cbs_owner.AUT_FINAL_KEY t8
                   ON t1.AUT_ID = t8.AUT_ID
                LEFT OUTER JOIN
                cbs_owner.AUT_FINAL_REF t9
                   ON     t8.AUT_ID = t9.AUT_ID
                      AND t9.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.AUT_FINAL_VALUES t10
                   ON     t8.AUT_ID = t10.AUT_ID
                      AND t10.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                      AND t10.LANGUAGE_CODE = t4.LANGUAGE_CODE
          WHERE t1.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_USAGE_ACTIVITY_GROUP',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_USAGE_ACTIVITY_TRANS (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.USAGE_ACTIVITY_TRANS
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;


      INSERT INTO ELC_USER.USAGE_ACTIVITY_TRANS (AUT_TRANS_ID,
                                                 UA_NAME,
                                                 UA_ID,
                                                 RESELLER_VERSION_ID,
                                                 UNIT_TYPE_NAME,
                                                 UNIT_TYPE_ID,
                                                 UA_INITIAL_NAME,
                                                 UA_INITIAL_ID,
                                                 PRIORITY,
                                                 ACCOUNT_GROUP_NAME,
                                                 ACCOUNT_GROUP_ID,
                                                 SUBS_GROUP_NAME,
                                                 SUBS_GROUP_ID,
                                                 MARKET_GROUP_NAME,
                                                 MARKET_GROUP_ID,
                                                 ZONE_GROUP_NAME,
                                                 ZONE_GROUP_ID,
                                                 ACCESS_METHOD_GROUP_NAME,
                                                 ACCESS_METHOD_GROUP_ID,
                                                 SPECIAL_FEATURE_GROUP_NAME,
                                                 SPECIAL_FEATURE_GROUP_ID,
                                                 OFFLINE_GROUP_NAME,
                                                 OFFLINE_GROUP_ID)
         SELECT t1.AUT_TRANS_ID,                             -- AS autTransId,
                t8.DISPLAY_VALUE AS ua_name,                   -- autFinalKey,
                t2.FINAL_AUT_ID AS ua_id,                       -- finalAutId,
                t2.RESELLER_VERSION_ID,               -- AS resellerVersionId,
                --       t4.SERVICE_VERSION_ID AS serviceVersionId,
                -- *** unit type
                t28.DISPLAY_VALUE AS unit_Type_name,
                t4.UNIT_TYPE AS unit_Type_id,
                -- ### unit type
                t5.DISPLAY_VALUE AS ua_initial_name,         -- autInitialKey,
                t2.INITIAL_AUT_ID AS ua_initial_id,           -- initialAutId,
                t2.PRIORITY AS priority,
                --       t10.AUT_TRANS_SET_ID AS autTransSetId,
                t12.DISPLAY_VALUE AS account_group_name,     -- accountSegKey,
                T12.EXPRESSION_TEMPLATE_ID AS account_group_id,
                t14.DISPLAY_VALUE AS subs_group_name,     -- subscriberSegKey,
                T14.EXPRESSION_TEMPLATE_ID AS subs_group_id,
                t16.DISPLAY_VALUE AS market_group_name,       -- marketSegKey,
                T16.EXPRESSION_TEMPLATE_ID AS market_group_id,
                t18.DISPLAY_VALUE AS zone_group_name,       -- locationSegKey,
                T18.EXPRESSION_TEMPLATE_ID AS zone_group_id,
                t20.DISPLAY_VALUE AS access_method_group_name, -- accessMethodSegKey,
                T20.EXPRESSION_TEMPLATE_ID AS access_method_group_id,
                t22.DISPLAY_VALUE AS special_feature_group_name, -- specialFeatureSegKey,
                T22.EXPRESSION_TEMPLATE_ID AS special_feature_group_id,
                t24.DISPLAY_VALUE AS offline_group_name,      -- offlineSegKey
                T24.EXPRESSION_TEMPLATE_ID AS offline_group_id
           FROM cbs_owner.AUT_TRANSLATION_KEY t1
                INNER JOIN cbs_owner.AUT_TRANSLATION t2
                   ON t1.AUT_TRANS_ID = t2.AUT_TRANS_ID
                INNER JOIN cbs_owner.AUT_INITIAL_KEY t3
                   ON t2.INITIAL_AUT_ID = t3.INITIAL_AUT_ID
                INNER JOIN
                cbs_owner.AUT_INITIAL_REF t4
                   ON     t3.INITIAL_AUT_ID = t4.INITIAL_AUT_ID
                      AND t4.SERVICE_VERSION_ID = 1
                INNER JOIN
                cbs_owner.AUT_INITIAL_VALUES t5
                   ON     t3.INITIAL_AUT_ID = t5.INITIAL_AUT_ID
                      AND t5.SERVICE_VERSION_ID = t4.SERVICE_VERSION_ID
                      AND t5.LANGUAGE_CODE = 1
                INNER JOIN cbs_owner.AUT_FINAL_KEY t6
                   ON t2.FINAL_AUT_ID = t6.AUT_ID
                INNER JOIN
                cbs_owner.AUT_FINAL_REF t7
                   ON     t6.AUT_ID = t7.AUT_ID
                      AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.AUT_FINAL_VALUES t8
                   ON     t6.AUT_ID = t8.AUT_ID
                      AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t8.LANGUAGE_CODE = t5.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.AUT_TRANSLATION_SET t9
                   ON     t9.AUT_TRANS_ID = t2.AUT_TRANS_ID
                      AND t9.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t9.AUT_TRANS_SET_ID IN
                             (SELECT aut_trans_set_id
                                FROM cbs_owner.aut_translation_set_map
                               WHERE expression_template_id IN
                                        (SELECT expression_template_id
                                           FROM cbs_owner.expression_template_id_ref
                                          WHERE segmentation_key_id = 0))
                LEFT OUTER JOIN
                cbs_owner.AUT_TRANSLATION_SET_MAP t10
                   ON     t10.AUT_TRANS_SET_ID = t9.AUT_TRANS_SET_ID
                      AND t10.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.EXPRESSION_TEMPLATE_ID_REF t11
                   ON     t11.EXPRESSION_TEMPLATE_ID =
                             t10.EXPRESSION_TEMPLATE_ID
                      AND t11.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.EXPRESSION_TEMPLATE_ID_VALUES t12
                   ON     t12.EXPRESSION_TEMPLATE_ID =
                             t11.EXPRESSION_TEMPLATE_ID
                      AND t12.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t12.LANGUAGE_CODE = t5.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.AUT_TRANSLATION_SET t25
                   ON     t25.AUT_TRANS_ID = t2.AUT_TRANS_ID
                      AND t25.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t25.AUT_TRANS_SET_ID IN
                             (SELECT aut_trans_set_id
                                FROM cbs_owner.aut_translation_set_map
                               WHERE expression_template_id IN
                                        (SELECT expression_template_id
                                           FROM cbs_owner.expression_template_id_ref
                                          WHERE segmentation_key_id = 1))
                LEFT OUTER JOIN
                cbs_owner.AUT_TRANSLATION_SET_MAP t26
                   ON     t26.AUT_TRANS_SET_ID = t25.AUT_TRANS_SET_ID
                      AND t26.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.EXPRESSION_TEMPLATE_ID_REF t13
                   ON     t13.EXPRESSION_TEMPLATE_ID =
                             t26.EXPRESSION_TEMPLATE_ID
                      AND t13.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.EXPRESSION_TEMPLATE_ID_VALUES t14
                   ON     t14.EXPRESSION_TEMPLATE_ID =
                             t13.EXPRESSION_TEMPLATE_ID
                      AND t14.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t14.LANGUAGE_CODE = t5.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.AUT_TRANSLATION_SET t27
                   ON     t27.AUT_TRANS_ID = t2.AUT_TRANS_ID
                      AND t27.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t27.AUT_TRANS_SET_ID IN
                             (SELECT aut_trans_set_id
                                FROM cbs_owner.aut_translation_set_map
                               WHERE expression_template_id IN
                                        (SELECT expression_template_id
                                           FROM cbs_owner.expression_template_id_ref
                                          WHERE segmentation_key_id = 2))
                LEFT OUTER JOIN
                cbs_owner.AUT_TRANSLATION_SET_MAP t28
                   ON     t28.AUT_TRANS_SET_ID = t27.AUT_TRANS_SET_ID
                      AND t28.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.EXPRESSION_TEMPLATE_ID_REF t15
                   ON     t15.EXPRESSION_TEMPLATE_ID =
                             t28.EXPRESSION_TEMPLATE_ID
                      AND t15.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.EXPRESSION_TEMPLATE_ID_VALUES t16
                   ON     t16.EXPRESSION_TEMPLATE_ID =
                             t15.EXPRESSION_TEMPLATE_ID
                      AND t16.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t16.LANGUAGE_CODE = t5.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.AUT_TRANSLATION_SET t29
                   ON     t29.AUT_TRANS_ID = t2.AUT_TRANS_ID
                      AND t29.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t29.AUT_TRANS_SET_ID IN
                             (SELECT aut_trans_set_id
                                FROM cbs_owner.aut_translation_set_map
                               WHERE expression_template_id IN
                                        (SELECT expression_template_id
                                           FROM cbs_owner.expression_template_id_ref
                                          WHERE segmentation_key_id = 3))
                LEFT OUTER JOIN
                cbs_owner.AUT_TRANSLATION_SET_MAP t30
                   ON     t30.AUT_TRANS_SET_ID = t29.AUT_TRANS_SET_ID
                      AND t30.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.EXPRESSION_TEMPLATE_ID_REF t17
                   ON     t17.EXPRESSION_TEMPLATE_ID =
                             t30.EXPRESSION_TEMPLATE_ID
                      AND t17.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.EXPRESSION_TEMPLATE_ID_VALUES t18
                   ON     t18.EXPRESSION_TEMPLATE_ID =
                             t17.EXPRESSION_TEMPLATE_ID
                      AND t18.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t18.LANGUAGE_CODE = t5.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.AUT_TRANSLATION_SET t31
                   ON     t31.AUT_TRANS_ID = t2.AUT_TRANS_ID
                      AND t31.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t31.AUT_TRANS_SET_ID IN
                             (SELECT aut_trans_set_id
                                FROM cbs_owner.aut_translation_set_map
                               WHERE expression_template_id IN
                                        (SELECT expression_template_id
                                           FROM cbs_owner.expression_template_id_ref
                                          WHERE segmentation_key_id = 4))
                LEFT OUTER JOIN
                cbs_owner.AUT_TRANSLATION_SET_MAP t32
                   ON     t32.AUT_TRANS_SET_ID = t31.AUT_TRANS_SET_ID
                      AND t32.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.EXPRESSION_TEMPLATE_ID_REF t19
                   ON     t19.EXPRESSION_TEMPLATE_ID =
                             t32.EXPRESSION_TEMPLATE_ID
                      AND t19.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.EXPRESSION_TEMPLATE_ID_VALUES t20
                   ON     t20.EXPRESSION_TEMPLATE_ID =
                             t19.EXPRESSION_TEMPLATE_ID
                      AND t20.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t20.LANGUAGE_CODE = t5.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.AUT_TRANSLATION_SET t33
                   ON     t33.AUT_TRANS_ID = t2.AUT_TRANS_ID
                      AND t33.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t33.AUT_TRANS_SET_ID IN
                             (SELECT aut_trans_set_id
                                FROM cbs_owner.aut_translation_set_map
                               WHERE expression_template_id IN
                                        (SELECT expression_template_id
                                           FROM cbs_owner.expression_template_id_ref
                                          WHERE segmentation_key_id = 5))
                LEFT OUTER JOIN
                cbs_owner.AUT_TRANSLATION_SET_MAP t34
                   ON     t34.AUT_TRANS_SET_ID = t33.AUT_TRANS_SET_ID
                      AND t34.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.EXPRESSION_TEMPLATE_ID_REF t21
                   ON     t21.EXPRESSION_TEMPLATE_ID =
                             t34.EXPRESSION_TEMPLATE_ID
                      AND t21.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.EXPRESSION_TEMPLATE_ID_VALUES t22
                   ON     t22.EXPRESSION_TEMPLATE_ID =
                             t21.EXPRESSION_TEMPLATE_ID
                      AND t22.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t22.LANGUAGE_CODE = t5.LANGUAGE_CODE
                LEFT OUTER JOIN
                cbs_owner.AUT_TRANSLATION_SET t35
                   ON     t35.AUT_TRANS_ID = t2.AUT_TRANS_ID
                      AND t35.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t35.AUT_TRANS_SET_ID IN
                             (SELECT aut_trans_set_id
                                FROM cbs_owner.aut_translation_set_map
                               WHERE expression_template_id IN
                                        (SELECT expression_template_id
                                           FROM cbs_owner.expression_template_id_ref
                                          WHERE segmentation_key_id = 6))
                LEFT OUTER JOIN
                cbs_owner.AUT_TRANSLATION_SET_MAP t36
                   ON     t36.AUT_TRANS_SET_ID = t35.AUT_TRANS_SET_ID
                      AND t36.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.EXPRESSION_TEMPLATE_ID_REF t23
                   ON     t23.EXPRESSION_TEMPLATE_ID =
                             t36.EXPRESSION_TEMPLATE_ID
                      AND t23.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.EXPRESSION_TEMPLATE_ID_VALUES t24
                   ON     t24.EXPRESSION_TEMPLATE_ID =
                             t23.EXPRESSION_TEMPLATE_ID
                      AND t24.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                      AND t24.LANGUAGE_CODE = t5.LANGUAGE_CODE
                -- *** unit type
                INNER JOIN cbs_owner.UNITS_TYPE_KEY t26
                   ON t4.UNIT_TYPE = t26.UNIT_TYPE
                INNER JOIN
                cbs_owner.UNITS_TYPE_REF t27
                   ON     t26.UNIT_TYPE = t27.UNIT_TYPE
                      AND t27.SERVICE_VERSION_ID = t4.SERVICE_VERSION_ID
                INNER JOIN
                cbs_owner.UNITS_TYPE_VALUES t28
                   ON     t26.UNIT_TYPE = t28.UNIT_TYPE
                      AND t28.SERVICE_VERSION_ID = t27.SERVICE_VERSION_ID
                      AND t28.LANGUAGE_CODE = t5.LANGUAGE_CODE
          WHERE t2.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_USAGE_ACTIVITY_TRANS',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_USAGE_PLAN (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.USAGE_PLAN
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;


      INSERT INTO ELC_USER.USAGE_PLAN (USAGE_PLAN_NAME,
                                       USAGE_PLAN_ID,
                                       OFFER_NAME,
                                       OFFER_ID,
                                       RESELLER_VERSION_ID,
                                       USAGE_ITEM_NAME,
                                       USAGE_ITEM_ID,
                                       ASSUME_CONSUMPTION,
                                       INHIBIT_REFUND,
                                       UA_NAME,
                                       UA_ID,
                                       TARIFF_PLAN_NAME,
                                       TARIFF_PLAN_ID,
                                       DESCRIPTION)
         SELECT t7.DISPLAY_VALUE AS usage_plan_name,          -- usagePlanKey,
                t1.USAGE_PLAN_ID AS usage_plan_id,             -- usagePlanId,
                t4.DISPLAY_VALUE AS offer_name,                   -- offerKey,
                t1.OFFER_ID AS offer_id,                           -- offerId,
                t1.RESELLER_VERSION_ID AS reseller_version_id, -- resellerVersionId,
                -- *** add usage plan item map
                --       t7.DISPLAY_VALUE AS usagePlanKey,
                --       t21.USAGE_PLAN_ID AS usagePlanId,
                t27.DISPLAY_VALUE AS usage_item_name,         -- usageItemKey,
                t21.USAGE_ITEM_ID AS usage_item_id,            -- usageItemId,
                --       t21.RESELLER_VERSION_ID AS resellerVersionId,
                --       t21.IS_USAGE_SPLIT AS isUsageSplit,
                --       t21.RESERVATION_AMT AS reservationAmt,
                --       t21.RESERVATION_LIFETIME AS reservationLifetime,
                --       t21.RESERVATION_MAX_NUM AS reservationMaxNum,
                --       t21.RESERVATION_MIN_AMT AS reservationMinAmt,
                --       t21.RESERVATION_MAX_AMT AS reservationMaxAmt,
                t21.ASSUME_CONSUMPTION AS assume_consumption, -- assumeConsumption,
                t21.INHIBIT_REFUND AS inhibit_refund,        -- inhibitRefund,
                -- *** add usage item
                --       t25.USAGE_ITEM_ID AS usageItemId,
                --       t26.RESELLER_VERSION_ID AS resellerVersionId,
                t46.DISPLAY_VALUE AS ua_name,                  -- autFinalKey,
                t26.AUT_ID AS ua_id,                                 -- autId,
                t49.DISPLAY_VALUE AS tariff_plan_name,       -- tariffPlanKey,
                t26.TARIFF_PLAN_ID AS tariff_plan_id,         -- tariffPlanId,
                --       t26.IS_DEFAULT_ACTIVITY AS isDefaultActivity,
                --       t26.CHARGE_CODE AS chargeCode,
                --       t27.LANGUAGE_CODE AS languageCode,
                --       t27.DISPLAY_VALUE AS displayValue,
                t27.DESCRIPTION AS description
           FROM cbs_owner.OFFER_USAGE_PLAN_MAP t1
                INNER JOIN cbs_owner.OFFER_KEY t2
                   ON t1.OFFER_ID = t2.OFFER_ID
                INNER JOIN
                cbs_owner.OFFER_REF t3
                   ON     t2.OFFER_ID = t3.OFFER_ID
                      AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.OFFER_VALUES t4
                   ON     t2.OFFER_ID = t4.OFFER_ID
                      AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                      AND t4.LANGUAGE_CODE = 1
                INNER JOIN cbs_owner.USAGE_PLAN_KEY t5
                   ON t1.USAGE_PLAN_ID = t5.USAGE_PLAN_ID
                INNER JOIN
                cbs_owner.USAGE_PLAN_REF t6
                   ON     t5.USAGE_PLAN_ID = t6.USAGE_PLAN_ID
                      AND t6.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.USAGE_PLAN_VALUES t7
                   ON     t5.USAGE_PLAN_ID = t7.USAGE_PLAN_ID
                      AND t7.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                      AND t7.LANGUAGE_CODE = t4.LANGUAGE_CODE
                -- *** add usage plan item map
                INNER JOIN
                cbs_owner.USAGE_PLAN_ITEM_MAP t21
                   ON     T21.RESELLER_VERSION_ID = T1.RESELLER_VERSION_ID
                      AND T21.USAGE_PLAN_ID = T5.USAGE_PLAN_ID
                INNER JOIN cbs_owner.USAGE_ITEM_KEY t25
                   ON t21.USAGE_ITEM_ID = t25.USAGE_ITEM_ID
                INNER JOIN
                cbs_owner.USAGE_ITEM_REF t26
                   ON     t25.USAGE_ITEM_ID = t26.USAGE_ITEM_ID
                      AND t26.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.USAGE_ITEM_VALUES t27
                   ON     t25.USAGE_ITEM_ID = t27.USAGE_ITEM_ID
                      AND t27.RESELLER_VERSION_ID = t21.RESELLER_VERSION_ID
                      AND t27.LANGUAGE_CODE = t7.LANGUAGE_CODE
                -- *** add usage item
                INNER JOIN cbs_owner.AUT_FINAL_KEY t44
                   ON t26.AUT_ID = t44.AUT_ID
                INNER JOIN
                cbs_owner.AUT_FINAL_REF t45
                   ON     t44.AUT_ID = t45.AUT_ID
                      AND t45.RESELLER_VERSION_ID = t26.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.AUT_FINAL_VALUES t46
                   ON     t44.AUT_ID = t46.AUT_ID
                      AND t46.RESELLER_VERSION_ID = t26.RESELLER_VERSION_ID
                      AND t46.LANGUAGE_CODE = t27.LANGUAGE_CODE
                INNER JOIN cbs_owner.TARIFF_PLAN_KEY t47
                   ON t26.TARIFF_PLAN_ID = t47.TARIFF_PLAN_ID
                INNER JOIN
                cbs_owner.TARIFF_PLAN_REF t48
                   ON     t47.TARIFF_PLAN_ID = t48.TARIFF_PLAN_ID
                      AND t48.RESELLER_VERSION_ID = t26.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.TARIFF_PLAN_VALUES t49
                   ON     t47.TARIFF_PLAN_ID = t49.TARIFF_PLAN_ID
                      AND t49.RESELLER_VERSION_ID = t26.RESELLER_VERSION_ID
                      AND t49.LANGUAGE_CODE = t27.LANGUAGE_CODE
          WHERE t1.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_USAGE_PLAN',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;

   PROCEDURE FILTER_ZONE_GROUP (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      DELETE ELC_USER.ZONE_GROUP
       WHERE RESELLER_VERSION_ID = I_RESELLER_VERSION_ID;

      INSERT INTO ELC_USER.ZONE_GROUP (GROUP_ID,
                                       GROUP_NAME,
                                       ZONE_A,
                                       ZONE_B,
                                       EXPRESSION_GROUP_ID,
                                       RESELLER_VERSION_ID,
                                       PRIORITY,
                                       HOME_OPPS_ID,
                                       HOME_OPPS_NAME)
         SELECT t1.EXPRESSION_TEMPLATE_ID AS GROUP_ID,
                t4.DISPLAY_VALUE AS group_name,
                --
                t41.LOCATION_A AS ZONE_A,
                t41.LOCATION_B AS ZONE_B,
                --
                t1.EXPRESSION_GROUP_ID AS expression_Group_Id,
                t1.RESELLER_VERSION_ID AS reseller_Version_Id,
                T3.PRIORITY AS priority,
                --
                --       t22.ATTRIBUTE_ID AS attributeId,
                --       t22.ATTRIBUTE_QUALIFIER AS attributeQualifier,
                --       t22.VALUE AS VALUE,
                --       t22.ATTR_SRC AS attrSrc,
                --
                --       t41.LI_RELATION_ID AS liRelationId,

                --       t41.SERVICE_VERSION_ID AS serviceVersionId,
                --       t41.LIA AS lia,
                --       t41.LIB AS lib,
                --       t41.HOME_TPPS_ID AS homeTppsIdNum,
                --       t47.DISPLAY_VALUE AS homeTppsId,
                t41.HOME_OPPS_ID AS home_Opps_Id,
                t44.DISPLAY_VALUE AS home_Opps_name                       -- ,
           --       t41.ROAM_OPPS_ID AS roamOppsId,
           --       t41.ROAM_TPPS_ID AS roamTppsId,
           --       t41.NCF_OPPS_ID AS ncfOppsId,
           --       t41.NCF_TPPS_ID AS ncfTppsId,
           --       t41.USSD_CALLBACK_ID AS ussdCallbackId,
           --       t41.LR_CHARACTERISTIC AS lrCharacteristic,
           --       t41.GPRS AS gprs,
           --       t41.GPRS_ROAM AS gprsRoam
           FROM cbs_owner.EXPRESSION_TEMPLATE t1
                INNER JOIN cbs_owner.EXPRESSION_TEMPLATE_ID_KEY t2
                   ON t1.EXPRESSION_TEMPLATE_ID = t2.EXPRESSION_TEMPLATE_ID
                INNER JOIN
                cbs_owner.EXPRESSION_TEMPLATE_ID_REF t3
                   ON     t2.EXPRESSION_TEMPLATE_ID =
                             t3.EXPRESSION_TEMPLATE_ID
                      AND t3.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                INNER JOIN
                cbs_owner.EXPRESSION_TEMPLATE_ID_VALUES t4
                   ON     t2.EXPRESSION_TEMPLATE_ID =
                             t4.EXPRESSION_TEMPLATE_ID
                      AND t4.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                      AND t4.LANGUAGE_CODE = 1
                --
                INNER JOIN
                cbs_owner.EXPRESSION t22
                   ON     t1.EXPRESSION_GROUP_ID = t22.EXPRESSION_GROUP_ID
                      AND T22.RESELLER_VERSION_ID = t1.RESELLER_VERSION_ID
                --
                INNER JOIN cbs_owner.LI_RELATION t41
                   ON t22.VALUE = T41.HOME_OPPS_ID
                LEFT OUTER JOIN cbs_owner.LI_RELATION_ID_KEY t42
                   ON t41.HOME_OPPS_ID = t42.LI_RELATION_ID
                LEFT OUTER JOIN
                cbs_owner.LI_RELATION_ID_REF t43
                   ON     t41.HOME_OPPS_ID = t43.LI_RELATION_ID
                      AND t41.SERVICE_VERSION_ID = t43.SERVICE_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.LI_RELATION_ID_VALUES t44
                   ON     t41.HOME_OPPS_ID = t44.LI_RELATION_ID
                      AND t41.SERVICE_VERSION_ID = t44.SERVICE_VERSION_ID
                      AND t44.LANGUAGE_CODE = 1
                LEFT OUTER JOIN cbs_owner.LI_RELATION_ID_KEY t45
                   ON t41.HOME_TPPS_ID = t45.LI_RELATION_ID
                LEFT OUTER JOIN
                cbs_owner.LI_RELATION_ID_REF t46
                   ON     t41.HOME_TPPS_ID = t46.LI_RELATION_ID
                      AND t41.SERVICE_VERSION_ID = t46.SERVICE_VERSION_ID
                LEFT OUTER JOIN
                cbs_owner.LI_RELATION_ID_VALUES t47
                   ON     t41.HOME_TPPS_ID = t47.LI_RELATION_ID
                      AND t41.SERVICE_VERSION_ID = t47.SERVICE_VERSION_ID
                      AND t44.LANGUAGE_CODE = t47.LANGUAGE_CODE
          WHERE     t1.RESELLER_VERSION_ID = I_RESELLER_VERSION_ID
                AND t41.SERVICE_VERSION_ID = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'FILTER_ZONE_GROUP',
            'CBS_OWNER_FILTER',
            'ERROR CODE: ' || SQLCODE || '; DETAIL: ' || SQLERRM,
            4);
   END;
END CBS_OWNER_FILTER;
/

GRANT EXECUTE ON ELC_USER.CBS_OWNER_FILTER TO CBS_OWNER;
