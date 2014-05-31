DROP PROCEDURE VNP_DATA.INS_ACT_LOG;

CREATE OR REPLACE PROCEDURE VNP_DATA.INS_ACT_LOG (
   log_user_name     IN VARCHAR2,
   log_action        IN VARCHAR2,
   log_description   IN VARCHAR2,
   log_level         IN NUMBER)
IS
   /******************************************************************************
        NAME:       INS_ACT_LOG
        PURPOSE:

        REVISIONS:
        Ver        Date        Author           Description
        ---------  ----------  ---------------  ------------------------------------
        1.0        02/01/2014      manucian86       1. Created this procedure.
     ******************************************************************************/

   CURRENT_LOG_LEVEL   CONSTANT PLS_INTEGER := 0;
BEGIN
   IF (log_level >= CURRENT_LOG_LEVEL)
   THEN
      INSERT INTO ACTION_LOG (log_user_name,
                              log_action,
                              log_description,
                              log_time,
                              log_level)
           VALUES (log_user_name,
                   log_action,
                   log_description,
                   SYSDATE,
                   log_level);

      COMMIT;
   END IF;
END;
/
