/* Formatted on 16/3/15 15:23:26 (QP5 v5.240.12305.39476) */
-- *** CBS_OWNER

GRANT EXECUTE ON ELC_USER.CBS_OWNER_FILTER TO cbs_owner;

GRANT EXECUTE ON VNP_COMMON.ELC_USER_FILTER_2 TO cbs_owner;

-- *** ELC_USER

GRANT CREATE JOB TO elc_user;

GRANT CREATE JOB TO vnp_common;
GRANT CREATE JOB TO vnp_data;
GRANT CREATE JOB TO emonitor;

GRANT CREATE TABLESPACE TO vnp_common;
GRANT CREATE TABLESPACE TO vnp_data;

GRANT EXECUTE ON sys.DBMS_LOCK TO vnp_data;

-- GRANT MANAGE SCHEDULER TO elc_user;

GRANT CREATE DATABASE LINK TO elc_user;
GRANT CREATE DATABASE LINK TO vnp_common;
GRANT CREATE DATABASE LINK TO vnp_data;

GRANT CREATE DATABASE LINK TO vnp_view;

-- cho phep vnp_common truncate tat ca cac bang
-- phai gan quyen DROP ANY TABLE
GRANT DROP ANY TABLE TO VNP_COMMON;

--GRANT EXECUTE ON VNP_COMMON.ELC_USER_FILTER@EONERATE_VNP_COMMON TO ELC_USER;

-- *** VNP_COMMON

GRANT CREATE JOB TO vnp_common;

GRANT EXECUTE ON VNP_DATA.RR_UPDATE_COUNTER TO vnp_common;
GRANT EXECUTE ON VNP_DATA.RR_UPDATE_COUNTER_2 TO vnp_common;
GRANT EXECUTE ON VNP_DATA.RR_UPDATE_COUNTER_DEV TO vnp_common;
GRANT EXECUTE ON VNP_DATA.RR_UPDATE_COUNTER_DEV_2 TO vnp_common;

GRANT SELECT ANY TABLE,
      INSERT ANY TABLE,
      DELETE ANY TABLE,
      UPDATE ANY TABLE
   TO VNP_DATA;

BEGIN
   FOR R IN (SELECT OWNER, TABLE_NAME
               FROM ALL_TABLES
              WHERE OWNER = 'CBS_OWNER')
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
   FOR R IN (SELECT OWNER, VIEW_NAME
               FROM ALL_VIEWS
              WHERE OWNER = 'CBS_OWNER')
   LOOP
      EXECUTE IMMEDIATE
            'GRANT SELECT ON '
         || R.OWNER
         || '.'
         || R.VIEW_NAME
         || ' TO VNP_COMMON';
   END LOOP;
END;

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
              WHERE OWNER = 'VNP_DATA')
   LOOP
      EXECUTE IMMEDIATE
            'GRANT SELECT ON '
         || R.OWNER
         || '.'
         || R.TABLE_NAME
         || ' TO VNP_VIEW';
   END LOOP;
END;

BEGIN
   FOR R IN (SELECT OWNER, TABLE_NAME
               FROM ALL_TABLES
              WHERE OWNER = 'VNP_COMMON')
   LOOP
      EXECUTE IMMEDIATE
            'GRANT SELECT ON '
         || R.OWNER
         || '.'
         || R.TABLE_NAME
         || ' TO VNP_VIEW';
   END LOOP;
END;

BEGIN
   FOR R IN (SELECT OWNER, TABLE_NAME
               FROM ALL_TABLES
              WHERE OWNER = 'CBS_OWNER')
   LOOP
      EXECUTE IMMEDIATE
            'GRANT SELECT ON '
         || R.OWNER
         || '.'
         || R.TABLE_NAME
         || ' TO VNP_VIEW';
   END LOOP;
END;

BEGIN
   FOR R IN (SELECT OWNER, TABLE_NAME
               FROM ALL_TABLES
              WHERE OWNER = 'VNP_COMMON_2')
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
         || ' TO VNP_COMMON_2';
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
         || ' TO VNP_COMMON_2';
   END LOOP;
END;

--- VNP_USER

BEGIN
   FOR R IN (SELECT OWNER, TABLE_NAME
               FROM ALL_TABLES
              WHERE OWNER = 'VNP_USER')
   LOOP
      EXECUTE IMMEDIATE
            'GRANT SELECT ON '
         || R.OWNER
         || '.'
         || R.TABLE_NAME
         || ' TO VNP_VIEW';
   END LOOP;
END;

BEGIN
   FOR R IN (SELECT OWNER, TABLE_NAME
               FROM ALL_TABLES
              WHERE OWNER = 'VNP_USER')
   LOOP
      EXECUTE IMMEDIATE
            'GRANT SELECT ON '
         || R.OWNER
         || '.'
         || R.TABLE_NAME
         || ' TO VNP_COMMON';
   END LOOP;
END;

BEGIN
   FOR R IN (SELECT OWNER, TABLE_NAME
               FROM ALL_TABLES
              WHERE OWNER = 'VNP_USER')
   LOOP
      EXECUTE IMMEDIATE
            'GRANT SELECT ON '
         || R.OWNER
         || '.'
         || R.TABLE_NAME
         || ' TO VNP_DATA';
   END LOOP;
END;