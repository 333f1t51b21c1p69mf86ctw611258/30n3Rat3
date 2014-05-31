DROP PACKAGE CBS_OWNER_FILTER;

CREATE OR REPLACE PACKAGE          cbs_owner_filter
AS
   /******************************************************************************
      NAME:       cbs_owner_filter
      PURPOSE:

      REVISIONS:
      Ver        Date        Author           Description
      ---------  ----------  ---------------  ------------------------------------
      1.0        27/03/2014      manucian86       1. Created this package.
   ******************************************************************************/

   PROCEDURE LETS_GO (I_RESELLER_VERSION_ID IN NUMBER);

   PROCEDURE CHANGE_CHANGING_STATUS (I_CHANGING_STATUS NUMBER);

END cbs_owner_filter;

/
DROP PACKAGE BODY CBS_OWNER_FILTER;

CREATE OR REPLACE PACKAGE BODY          cbs_owner_filter
AS
   /******************************************************************************
      NAME:       cbs_owner_filter
      PURPOSE:

      REVISIONS:
      Ver        Date        Author           Description
      ---------  ----------  ---------------  ------------------------------------
      1.0        27/03/2014      manucian86       1. Created this package body.
   ******************************************************************************/

   PROCEDURE LETS_GO (I_RESELLER_VERSION_ID IN NUMBER)
   IS
   BEGIN
      CHANGE_CHANGING_STATUS (1);

      --
		

      CHANGE_CHANGING_STATUS (0);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
      WHEN OTHERS
      THEN
         CHANGE_CHANGING_STATUS (0);
   END;

   PROCEDURE CHANGE_CHANGING_STATUS (I_CHANGING_STATUS NUMBER)
   IS
   BEGIN
      UPDATE CHANGE_FLAG
         SET IS_CHANGING = I_CHANGING_STATUS;

      COMMIT;
   END;
END cbs_owner_filter;

/
