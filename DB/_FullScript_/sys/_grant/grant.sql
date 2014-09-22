/* Formatted on 9/18/2014 11:14:30 AM (QP5 v5.215.12089.38647) */
-- *** CBS_OWNER

GRANT EXECUTE ON ELC_USER.CBS_OWNER_FILTER TO cbs_owner;


-- *** ELC_USER

GRANT CREATE JOB TO elc_user;

-- GRANT MANAGE SCHEDULER TO elc_user;

GRANT CREATE DATABASE LINK TO elc_user;

--GRANT EXECUTE ON VNP_COMMON.ELC_USER_FILTER@EONERATE_VNP_COMMON TO ELC_USER;



-- *** VNP_COMMON

GRANT CREATE JOB TO vnp_common;

GRANT EXECUTE ON VNP_DATA.RR_UPDATE_COUNTER TO vnp_common;

BEGIN
   FOR R IN (SELECT OWNER, TABLE_NAME
               FROM ALL_TABLES
              WHERE OWNER = 'VNP_DATA')
   LOOP
      EXECUTE IMMEDIATE
            'GRANT SELECT, INSERT, DELETE, UPDATE ON '
         || R.OWNER
         || '.'
         || R.TABLE_NAME
         || ' TO VNP_COMMON';
   END LOOP;
END;

BEGIN
   FOR R IN (SELECT OWNER, TABLE_NAME
               FROM ALL_TABLES
              WHERE OWNER = 'VNP_COMMON')
   LOOP
      EXECUTE IMMEDIATE
            'GRANT SELECT, INSERT, DELETE, UPDATE ON '
         || R.OWNER
         || '.'
         || R.TABLE_NAME
         || ' TO VNP_DATA';
   END LOOP;
END;

BEGIN
   FOR R IN (SELECT OWNER, TABLE_NAME
               FROM ALL_TABLES
              WHERE OWNER = 'VNP_COMMON')
   LOOP
      EXECUTE IMMEDIATE
            'GRANT SELECT, INSERT, DELETE, UPDATE ON '
         || R.OWNER
         || '.'
         || R.TABLE_NAME
         || ' TO VNP_COMMON_PROP';
   END LOOP;
END;