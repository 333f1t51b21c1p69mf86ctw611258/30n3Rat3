DROP PACKAGE BODY VNP_COMMON.DML_TABLE;

CREATE OR REPLACE PACKAGE BODY VNP_COMMON.DML_TABLE
IS
   FUNCTION INS_SFTP_FILE (
      in_SFTP_FILE   IN VNP_COMMON.SFTP_FILE.SFTP_FILE%TYPE,
      in_SLU         IN VNP_COMMON.SFTP_FILE.SLU%TYPE,
      in_SEQ         IN VNP_COMMON.SFTP_FILE.SEQ%TYPE,
      in_FILE_SIZE   IN VNP_COMMON.SFTP_FILE.FILE_SIZE%TYPE,
      in_STATUS      IN VNP_COMMON.SFTP_FILE.STATUS%TYPE,
      in_RETRY       IN VNP_COMMON.SFTP_FILE.RETRY%TYPE,
      in_NOTE        IN VNP_COMMON.SFTP_FILE.NOTE%TYPE)
      RETURN NUMBER
   IS
      n_count    PLS_INTEGER;
      n_result   PLS_INTEGER := 0;
   BEGIN
      SELECT COUNT (1)
        INTO n_count
        FROM sftp_file
       WHERE sftp_file = in_sftp_file;

      IF n_count = 0
      THEN
         INSERT INTO VNP_COMMON.SFTP_FILE (SFTP_FILE,
                                           SLU,
                                           SEQ,
                                           FILE_SIZE,
                                           STATUS,
                                           RETRY,
                                           NOTE,
                                           CREATED_TIME,
                                           MODIFIED_TIME)
              VALUES (in_SFTP_FILE,
                      in_SLU,
                      in_SEQ,
                      in_FILE_SIZE,
                      in_STATUS,
                      in_RETRY,
                      in_NOTE,
                      SYSDATE,
                      SYSDATE);

         n_result := SQL%ROWCOUNT;
      ELSE
         n_result := 99;
      END IF;

      RETURN n_result;
   END INS_SFTP_FILE;

   PROCEDURE UPD_SFTP_FILE (
      in_SFTP_FILE   IN VNP_COMMON.SFTP_FILE.SFTP_FILE%TYPE,
      in_SLU         IN VNP_COMMON.SFTP_FILE.SLU%TYPE,
      in_SEQ         IN VNP_COMMON.SFTP_FILE.SEQ%TYPE,
      in_FILE_SIZE   IN VNP_COMMON.SFTP_FILE.FILE_SIZE%TYPE,
      in_STATUS      IN VNP_COMMON.SFTP_FILE.STATUS%TYPE,
      in_RETRY       IN VNP_COMMON.SFTP_FILE.RETRY%TYPE,
      in_NOTE        IN VNP_COMMON.SFTP_FILE.NOTE%TYPE)
   IS
   BEGIN
      UPDATE VNP_COMMON.SFTP_FILE
         SET SLU = in_SLU,
             SEQ = in_SEQ,
             FILE_SIZE = in_FILE_SIZE,
             STATUS = in_STATUS,
             RETRY = in_RETRY,
             NOTE = in_NOTE,
             MODIFIED_TIME = SYSDATE
       WHERE SFTP_FILE = in_SFTP_FILE;
   END UPD_SFTP_FILE;

   PROCEDURE INS_SFTP_LASTEST (
      in_SLU                IN VNP_COMMON.SFTP_LASTEST.SLU%TYPE,
      in_DATE_FOLDER        IN VNP_COMMON.SFTP_LASTEST.DATE_FOLDER%TYPE,
      in_LASTEST_CDR_TIME   IN VNP_COMMON.SFTP_LASTEST.LASTEST_CDR_TIME%TYPE)
   IS
   BEGIN
      INSERT
        INTO VNP_COMMON.SFTP_LASTEST (SLU, DATE_FOLDER, LASTEST_CDR_TIME)
      VALUES (in_SLU, in_DATE_FOLDER, in_LASTEST_CDR_TIME);
   END INS_SFTP_LASTEST;

   PROCEDURE UPD_SFTP_LASTEST (
      in_SLU                IN VNP_COMMON.SFTP_LASTEST.SLU%TYPE,
      in_DATE_FOLDER        IN VNP_COMMON.SFTP_LASTEST.DATE_FOLDER%TYPE,
      in_LASTEST_CDR_TIME   IN VNP_COMMON.SFTP_LASTEST.LASTEST_CDR_TIME%TYPE)
   IS
   BEGIN
      UPDATE VNP_COMMON.SFTP_LASTEST
         SET LASTEST_CDR_TIME = in_LASTEST_CDR_TIME
       WHERE SLU = in_SLU AND DATE_FOLDER = in_DATE_FOLDER;
   END UPD_SFTP_LASTEST;

   PROCEDURE MERGE_SFTP_LASTEST (
      in_SLU                IN VNP_COMMON.SFTP_LASTEST.SLU%TYPE,
      in_DATE_FOLDER        IN VNP_COMMON.SFTP_LASTEST.DATE_FOLDER%TYPE,
      in_LASTEST_CDR_TIME   IN VNP_COMMON.SFTP_LASTEST.LASTEST_CDR_TIME%TYPE)
   IS
   BEGIN
      MERGE INTO VNP_COMMON.SFTP_LASTEST A
           USING (SELECT in_SLU AS SLU,
                         in_DATE_FOLDER AS DATE_FOLDER,
                         in_LASTEST_CDR_TIME AS LASTEST_CDR_TIME
                    FROM DUAL) B
              ON (A.SLU = B.SLU AND A.DATE_FOLDER = B.DATE_FOLDER)
      WHEN NOT MATCHED
      THEN
         INSERT     (SLU, DATE_FOLDER, LASTEST_CDR_TIME)
             VALUES (in_SLU, in_DATE_FOLDER, in_LASTEST_CDR_TIME)
      WHEN MATCHED
      THEN
         UPDATE SET                               --            A.SLU = B.SLU,
                    --            A.DATE_FOLDER = B.DATE_FOLDER,
                    A.LASTEST_CDR_TIME = B.LASTEST_CDR_TIME;
   END MERGE_SFTP_LASTEST;
END DML_TABLE;
/
