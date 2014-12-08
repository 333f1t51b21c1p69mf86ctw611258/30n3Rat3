DROP PACKAGE STUFF;

CREATE OR REPLACE PACKAGE          STUFF
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

   PROCEDURE ADD_PART_BY_DAY (I_TABLE_NAME          VARCHAR2,
                              I_TABLESPACE_NAME     VARCHAR2,
                              I_PARTITION_PREFIX    VARCHAR2,
                              I_DATAFILE_DIR        VARCHAR2,
                              I_DATAFILE_PREFIX     VARCHAR2);
END STUFF;

/
