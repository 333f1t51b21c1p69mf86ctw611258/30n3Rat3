/* Formatted on 4/6/2014 6:16:11 PM (QP5 v5.227.12220.39754) */
SELECT * FROM reseller_version;

CREATE TABLE reseller_version
AS
   SELECT RESELLER_VERSION_ID,
          RESELLER_ID,
          MAJOR_VERSION_NUM,
          MINOR_VERSION_NUM,
          ACTIVE_DATE,
          INACTIVE_DATE,
          SERVICE_VERSION_ID,
          STATUS
     FROM CBS_OWNER.RESELLER_VERSION
    WHERE reseller_id = 9 AND (inactive_date IS NOT NULL OR status = 3);

INSERT INTO ELC_USER.RESELLER_VERSION (RESELLER_VERSION_ID,
                                       RESELLER_ID,
                                       MAJOR_VERSION_NUM,
                                       MINOR_VERSION_NUM,
                                       ACTIVE_DATE,
                                       INACTIVE_DATE,
                                       SERVICE_VERSION_ID,
                                       STATUS)
   SELECT RESELLER_VERSION_ID,
          RESELLER_ID,
          MAJOR_VERSION_NUM,
          MINOR_VERSION_NUM,
          ACTIVE_DATE,
          INACTIVE_DATE,
          SERVICE_VERSION_ID,
          STATUS
     FROM CBS_OWNER.RESELLER_VERSION
    WHERE reseller_id = 9    /*AND (inactive_date IS NOT NULL OR status = 3)*/;