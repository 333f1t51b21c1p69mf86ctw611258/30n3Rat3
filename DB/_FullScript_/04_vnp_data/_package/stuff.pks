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

   PROCEDURE ADD_PART_BY_DAY (I_TABLE_NAME          VARCHAR2,
                              I_TABLESPACE_NAME     VARCHAR2,
                              I_PARTITION_PREFIX    VARCHAR2,
                              I_DATAFILE_DIR        VARCHAR2,
                              I_DATAFILE_PREFIX     VARCHAR2);

   PROCEDURE MOVE_TO_HOT_RATED;

   PROCEDURE MOVE_TO_HOT_RATED_2;

   PROCEDURE AGGREGATE_HRC_12;

   PROCEDURE MOVE_HRC_12_TO_HRC;
   
   PROCEDURE AGGREGATE_HRC_34;

   PROCEDURE MOVE_HRC_34_TO_HRC;

   PROCEDURE MOVE_TEMP1_TO_1;

   PROCEDURE MOVE_TEMP2_TO_2;

   PROCEDURE AGGR_MOVE_TO_HOT;
END STUFF;
/
