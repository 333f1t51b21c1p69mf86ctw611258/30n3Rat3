/* Formatted on 3/31/2014 9:47:20 AM (QP5 v5.215.12089.38647) */
SELECT * FROM reseller_version;

UPDATE reseller_version
   SET status = 1
 WHERE reseller_version_id = 2;

COMMIT;

DROP TABLE RESELLER_VERSION;

CREATE TABLE reseller_version
AS
   SELECT t1.RESELLER_VERSION_ID AS reseller_version_id, -- resellerVersionId,
          t4.DISPLAY_VALUE AS reseller_name,                   -- resellerKey,
          t1.RESELLER_ID AS reseller_id,                        -- resellerId,
          --       t1.MAJOR_VERSION_NUM AS majorVersionNum,
          --       t1.MINOR_VERSION_NUM AS minorVersionNum,
          t1.ACTIVE_DATE,                                    -- AS activeDate,
          t1.INACTIVE_DATE,                                -- AS inactiveDate,
          --       t1.SERVICE_VERSION_ID AS serviceVersionId,
          t1.STATUS AS status
     FROM cbs_owner.RESELLER_VERSION t1
          INNER JOIN cbs_owner.RESELLER_KEY t2
             ON t1.RESELLER_ID = t2.RESELLER_ID
          INNER JOIN cbs_owner.RESELLER_REF t3
             ON     t2.RESELLER_ID = t3.RESELLER_ID
                AND t3.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
          INNER JOIN cbs_owner.RESELLER_VALUES t4
             ON     t2.RESELLER_ID = t4.RESELLER_ID
                AND t4.SERVICE_VERSION_ID = t1.SERVICE_VERSION_ID
                AND t4.LANGUAGE_CODE = 1
    WHERE                                   /*t1.RESELLER_VERSION_ID = 2 AND*/
         t1.SERVICE_VERSION_ID = 1;