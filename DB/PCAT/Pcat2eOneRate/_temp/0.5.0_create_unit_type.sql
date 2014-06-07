/* Formatted on 05/03/2014 11:05:08 (QP5 v5.215.12089.38647) */
SELECT * FROM unit_type;

CREATE TABLE unit_type
AS
   SELECT t1.UNIT_TYPE AS unit_type_id,
          t2.IS_USAGE AS is_Usage,
          t2.IS_RC AS is_Rc,
          t2.IS_DEFAULT AS is_Default,
          t2.IS_INTERNAL AS is_Internal,
          t3.DISPLAY_VALUE AS type_name,
          t3.DESCRIPTION AS description
     FROM cbs_owner.UNITS_TYPE_KEY t1
          INNER JOIN cbs_owner.UNITS_TYPE_REF t2
             ON t1.UNIT_TYPE = t2.UNIT_TYPE
          INNER JOIN cbs_owner.UNITS_TYPE_VALUES t3
             ON     t2.UNIT_TYPE = t3.UNIT_TYPE
                AND t2.SERVICE_VERSION_ID = t3.SERVICE_VERSION_ID
    WHERE t2.SERVICE_VERSION_ID = 1 AND t3.LANGUAGE_CODE = 1;