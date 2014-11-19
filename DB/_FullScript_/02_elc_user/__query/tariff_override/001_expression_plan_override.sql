/* Formatted on 29/04/2014 10:32:12 (QP5 v5.227.12220.39754) */
CREATE TABLE expression_plan_override
AS
   SELECT t1.EXPRESSION_PLAN_OVERRIDE_ID AS expressionPlanOverrideId,
          t2.RESELLER_VERSION_ID AS resellerVersionId,
          t5.DISPLAY_VALUE AS expressionTemplateIdKey,
          t5.DESCRIPTION AS description,
          t2.EXPRESSION_TEMPLATE_ID AS expressionTemplateId,
          t2.FINAL_PLAN_ID AS finalPlanId,
          t2.INITIAL_PLAN_ID AS initialPlanId,
          t2.PLAN_TYPE AS planType,
          t9.DISPLAY_VALUE AS initialPlanKey,
          t8.DISPLAY_VALUE AS overrideTemplateKey,
          t2.OVERRIDE_TEMPLATE_ID AS overrideTemplateId,
          t2.PRIORITY AS priority
     FROM cbs_owner.EXPRESSION_PLAN_OVERRIDE_KEY t1
          INNER JOIN
          cbs_owner.EXPRESSION_PLAN_OVERRIDE t2
             ON t1.EXPRESSION_PLAN_OVERRIDE_ID =
                   t2.EXPRESSION_PLAN_OVERRIDE_ID
          INNER JOIN cbs_owner.EXPRESSION_TEMPLATE_ID_KEY t3
             ON t2.EXPRESSION_TEMPLATE_ID = t3.EXPRESSION_TEMPLATE_ID
          INNER JOIN
          cbs_owner.EXPRESSION_TEMPLATE_ID_REF t4
             ON     t3.EXPRESSION_TEMPLATE_ID = t4.EXPRESSION_TEMPLATE_ID
                AND t4.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.EXPRESSION_TEMPLATE_ID_VALUES t5
             ON     t3.EXPRESSION_TEMPLATE_ID = t5.EXPRESSION_TEMPLATE_ID
                AND t5.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t5.LANGUAGE_CODE = 1
          INNER JOIN cbs_owner.OVERRIDE_TEMPLATE_KEY t6
             ON t2.OVERRIDE_TEMPLATE_ID = t6.OVERRIDE_TEMPLATE_ID
          INNER JOIN
          cbs_owner.OVERRIDE_TEMPLATE_REF t7
             ON     t6.OVERRIDE_TEMPLATE_ID = t7.OVERRIDE_TEMPLATE_ID
                AND t7.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
          INNER JOIN
          cbs_owner.OVERRIDE_TEMPLATE_VALUES t8
             ON     t6.OVERRIDE_TEMPLATE_ID = t8.OVERRIDE_TEMPLATE_ID
                AND t8.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t8.LANGUAGE_CODE = t5.LANGUAGE_CODE
          INNER JOIN
          cbs_owner.TARIFF_PLAN_VALUES t9
             ON     t2.INITIAL_PLAN_ID = t9.TARIFF_PLAN_ID
                AND t9.RESELLER_VERSION_ID = t2.RESELLER_VERSION_ID
                AND t9.LANGUAGE_CODE = t5.LANGUAGE_CODE
    WHERE t2.RESELLER_VERSION_ID = 2;