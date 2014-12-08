DROP PACKAGE CBS_OWNER_FILTER;

CREATE OR REPLACE PACKAGE          CBS_OWNER_FILTER
AS
   /******************************************************************************
      NAME:       CBS_OWNER_FILTER
      PURPOSE:

      REVISIONS:
      Ver        Date        Author           Description
      ---------  ----------  ---------------  ------------------------------------
      1.0        27/03/2014      manucian86       1. Created this package.
   ******************************************************************************/

   PROCEDURE LETS_GO (I_RESELLER_VERSION_ID IN NUMBER);

   PROCEDURE START_JOB_FILTER_NEW_PCAT_DATA (i_reseller_version_id NUMBER);

END CBS_OWNER_FILTER;

/

GRANT EXECUTE ON CBS_OWNER_FILTER TO CBS_OWNER;
