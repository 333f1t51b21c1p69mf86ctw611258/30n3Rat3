/* Formatted on 29/04/2014 10:30:39 (QP5 v5.227.12220.39754) */
--DROP TABLE RESELLER_VERSION;

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

-- *** NOTE
ALTER TABLE RESELLER_VERSION
ADD (IS_NEW NUMBER(1) DEFAULT 0);

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
    
commit;