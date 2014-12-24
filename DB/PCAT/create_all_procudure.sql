/* Formatted on 4/6/2014 10:55:19 AM (QP5 v5.227.12220.39754) */
DROP PROCEDURE FILTER_PCAT;

CREATE OR REPLACE PROCEDURE FILTER_PCAT (I_RESELLER_VERSION_ID IN NUMBER)
AS
BEGIN
   UPDATE CHANGE_FLAG
      SET IS_CHANGING = 1;

   COMMIT;

   --


   UPDATE CHANGE_FLAG
      SET IS_CHANGING = 0;

   COMMIT;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      NULL;
   WHEN OTHERS
   THEN
      UPDATE CHANGE_FLAG
         SET IS_CHANGING = 0;

      COMMIT;
END;
/

DROP PROCEDURE INS_ACTION_LOG;

CREATE OR REPLACE PROCEDURE INS_ACTION_LOG (IN_LOG_TITLE      VARCHAR2,
                                            IN_LOG_GROUP      VARCHAR2,
                                            IN_LOG_CONTENT    VARCHAR2,
                                            IN_LOG_LEVEL      NUMBER)
--   1: DEBUG Level
--   2: INFO Level
--   3: WARN Level
--   4: ERROR Level
--   5: FATAL Level

IS
BEGIN
   INSERT INTO ACTION_LOG (LOG_TITLE,
                           LOG_GROUP,
                           LOG_CONTENT,
                           LOG_LEVEL)
        VALUES (IN_LOG_TITLE,
                IN_LOG_GROUP,
                IN_LOG_CONTENT,
                IN_LOG_LEVEL);

   COMMIT;
END;
/