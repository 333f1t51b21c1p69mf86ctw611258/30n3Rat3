DROP PACKAGE VNP_DATA.STUFF;

CREATE OR REPLACE PACKAGE VNP_DATA.STUFF
AS
   /******************************************************************************
      NAME:       STUFF
      PURPOSE:

      REVISIONS:
      Ver        Date        Author           Description
      ---------  ----------  ---------------  ------------------------------------
      1.0        6/6/2014      manucian86       1. Created this package.
   ******************************************************************************/

   PROCEDURE COMPENSATE (IN_MONTH VARCHAR2, IN_YEAR VARCHAR2);

   PROCEDURE COMPENSATE_THIS_MONTH;

   PROCEDURE COMPENSATE_PREVIOUS_MONTH;
END STUFF;
/
