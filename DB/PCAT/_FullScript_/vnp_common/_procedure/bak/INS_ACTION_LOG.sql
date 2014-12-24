/* Formatted on 28/04/2014 09:36:43 (QP5 v5.227.12220.39754) */
DROP PROCEDURE VNP_COMMON.INS_ACTION_LOG;

CREATE OR REPLACE PROCEDURE VNP_COMMON.INS_ACTION_LOG (
   IN_LOG_TITLE      VARCHAR2,
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