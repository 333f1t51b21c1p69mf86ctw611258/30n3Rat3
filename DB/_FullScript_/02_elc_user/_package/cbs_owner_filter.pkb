DROP PACKAGE BODY CBS_OWNER_FILTER;

CREATE OR REPLACE PACKAGE BODY          CBS_OWNER_FILTER
AS
   /******************************************************************************
      NAME:       cbs_owner_filter
      PURPOSE:

      REVISIONS:
      Ver        Date        Author           Description
      ---------  ----------  ---------------  ------------------------------------
      1.0        27/03/2014      manucian86       1. Created this package body.
   ******************************************************************************/

   -- DONE
   PROCEDURE LETS_GO (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      EXECUTE IMMEDIATE
            'CALL VNP_COMMON.ELC_USER_FILTER.LETS_GO@EONERATE_VNP_COMMON ('
         || i_reseller_version_id
         || ')';

      INS_ACTION_LOG (
         'LETS_GO',
         'CBS_OWNER_FILTER',
         'LETS_GO ( ' || i_reseller_version_id || ' ) => SUCCESSFUL',
         2);
   EXCEPTION
      --      WHEN NO_DATA_FOUND
      --      THEN
      --         NULL;
      WHEN OTHERS
      THEN
         INS_ACTION_LOG (
            'LETS_GO',
            'CBS_OWNER_FILTER',
               'LETS_GO ( '
            || i_reseller_version_id
            || ' ) => ERROR CODE: '
            || SQLCODE
            || '; DETAIL: '
            || SQLERRM,
            4);
   END;

   PROCEDURE START_JOB_FILTER_NEW_PCAT_DATA (i_reseller_version_id NUMBER)
   IS
   BEGIN
      DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE (
         job_name            => '"ELC_USER"."JOB_FILTER_NEW_PCAT_DATA"',
         argument_position   => 1,
         argument_value      => i_reseller_version_id);

      -- Run job synchronously.
      DBMS_SCHEDULER.run_job (
         job_name              => '"ELC_USER"."JOB_FILTER_NEW_PCAT_DATA"',
         use_current_session   => FALSE);
   END;
END CBS_OWNER_FILTER;

/

GRANT EXECUTE ON CBS_OWNER_FILTER TO CBS_OWNER;
