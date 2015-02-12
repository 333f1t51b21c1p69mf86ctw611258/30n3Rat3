DROP PACKAGE BODY VNP_DATA.REFORMAT_ENRICH;

CREATE OR REPLACE PACKAGE BODY VNP_DATA.reformat_enrich AS

  PROCEDURE ENRICH_BU_1(NUMBER_RECORD OUT NUMBER,TIME_PROCESS OUT NUMBER) AS

  V_A_NUMBER VARCHAR2(20);
  V_NEW_BU VARCHAR2(10);
   v_code NUMBER;
   v_errm VARCHAR2(64);
   V_CDR_TIME DATE;
   l_rowid    ROWID;
   timestart NUMBER default dbms_utility.get_time();
  CURSOR c1
   IS
     SELECT A_NUMBER,CDR_START_TIME,ROWID
     FROM VNP_DATA.TEMP_RATED_CDR_1;
     --FOR UPDATE of BU_ID,OLD_BU_ID;

  BEGIN

    OPEN c1;
      LOOP
       FETCH c1 INTO V_A_NUMBER,V_CDR_TIME,l_rowid;
       --dbms_output.put_line(V_A_NUMBER);
       EXIT WHEN c1%NOTFOUND;
          BEGIN
            V_NEW_BU:='';

            SELECT AGENT_CODE INTO V_NEW_BU  FROM
            (SELECT AGENT_CODE FROM VNP_VIEW.SUB_POST WHERE MSISDN=V_A_NUMBER AND V_CDR_TIME BETWEEN START_DATETIME AND END_DATETIME ORDER BY START_DATETIME DESC)
            WHERE ROWNUM<=1;

            --dbms_output.put_line(V_NEW_CHANGE_CODE);

            UPDATE VNP_DATA.TEMP_RATED_CDR_1 SET BU_ID = V_NEW_BU WHERE ROWID = l_rowid;


            EXCEPTION WHEN OTHERS THEN
            --dbms_output.put_line('1-'||SQLERRM);
            --v_code := SQLCODE;
            --v_errm := SUBSTR(SQLERRM, 1 , 64);
            --INSERT INTO ACTION_LOG (log_user_name,log_action,log_description,log_level)
           --VALUES ('REFORMAT_ENRICH-ENRICH_BU',V_A_NUMBER,v_code||'-'||v_errm,0);

            NULL;

          END;



      END LOOP;
      NUMBER_RECORD:=c1%ROWCOUNT;
   CLOSE c1;
   COMMIT;

 TIME_PROCESS:=(dbms_utility.get_time()-timestart)/100;


    EXCEPTION WHEN OTHERS THEN
            ROLLBACK;
            dbms_output.put_line('2'||SQLERRM);
            INS_ACT_LOG ('REFORMAT_ENRICH-ENRICH_BU','EXCEPTION',SQLERRM,0);

  END ENRICH_BU_1;

PROCEDURE ENRICH_BU_2(NUMBER_RECORD OUT NUMBER,TIME_PROCESS OUT NUMBER) AS

  V_A_NUMBER VARCHAR2(20);
  V_NEW_BU VARCHAR2(10);
   v_code NUMBER;
   v_errm VARCHAR2(64);
   V_CDR_TIME DATE;
   l_rowid    ROWID;
      timestart NUMBER default dbms_utility.get_time();

  CURSOR c1
   IS
     SELECT A_NUMBER,CDR_START_TIME,ROWID
     FROM VNP_DATA.TEMP_RATED_CDR_2;
     --FOR UPDATE of BU_ID,OLD_BU_ID;

  BEGIN

    OPEN c1;
      LOOP
       FETCH c1 INTO V_A_NUMBER,V_CDR_TIME,l_rowid;
       --dbms_output.put_line(V_A_NUMBER);
       EXIT WHEN c1%NOTFOUND;
          BEGIN
            V_NEW_BU:='';

            SELECT AGENT_CODE INTO V_NEW_BU  FROM
            (SELECT AGENT_CODE FROM VNP_VIEW.SUB_POST WHERE MSISDN=V_A_NUMBER AND V_CDR_TIME BETWEEN START_DATETIME AND END_DATETIME ORDER BY START_DATETIME DESC)
            WHERE ROWNUM<=1;

            --dbms_output.put_line(V_NEW_CHANGE_CODE);

            UPDATE VNP_DATA.TEMP_RATED_CDR_2 SET BU_ID = V_NEW_BU WHERE ROWID = l_rowid;


            EXCEPTION WHEN OTHERS THEN
            --dbms_output.put_line('1-'||SQLERRM||V_A_NUMBER);
            --v_code := SQLCODE;
            --v_errm := SUBSTR(SQLERRM, 1 , 64);
            --INSERT INTO ACTION_LOG (log_user_name,log_action,log_description,log_level)
           --VALUES ('REFORMAT_ENRICH-ENRICH_BU',V_A_NUMBER,v_code||'-'||v_errm,0);

            NULL;

          END;



      END LOOP;
      NUMBER_RECORD:=c1%ROWCOUNT;
   CLOSE c1;
   COMMIT;

  TIME_PROCESS:=(dbms_utility.get_time()-timestart)/100;

    EXCEPTION WHEN OTHERS THEN
            ROLLBACK;
            dbms_output.put_line('2'||SQLERRM);
            INS_ACT_LOG ('REFORMAT_ENRICH-ENRICH_BU_2','EXCEPTION',SQLERRM,0);

  END ENRICH_BU_2;

PROCEDURE ENRICH_BU_TEST(NUMBER_RECORD OUT NUMBER,TIME_PROCESS OUT NUMBER) AS

  V_A_NUMBER VARCHAR2(20);
  V_NEW_BU VARCHAR2(10);
   v_code NUMBER;
   v_errm VARCHAR2(64);
   V_CDR_TIME DATE;
   l_rowid    ROWID;
      timestart NUMBER default dbms_utility.get_time();

  CURSOR c1
   IS
     SELECT A_NUMBER,CDR_START_TIME,ROWID
     FROM VNP_DATA.TEMP_RATED_CDR_TEST;
     --FOR UPDATE of BU_ID,OLD_BU_ID;

  BEGIN

    OPEN c1;
      LOOP
       FETCH c1 INTO V_A_NUMBER,V_CDR_TIME,l_rowid;
       --dbms_output.put_line(V_A_NUMBER);
       EXIT WHEN c1%NOTFOUND;
          BEGIN
            V_NEW_BU:='';

            SELECT AGENT_CODE INTO V_NEW_BU  FROM
            (SELECT AGENT_CODE FROM VNP_VIEW.SUB_POST WHERE MSISDN=V_A_NUMBER AND V_CDR_TIME BETWEEN START_DATETIME AND END_DATETIME ORDER BY START_DATETIME DESC)
            WHERE ROWNUM<=1;

            --dbms_output.put_line(V_NEW_CHANGE_CODE);

            UPDATE VNP_DATA.TEMP_RATED_CDR_TEST SET BU_ID = V_NEW_BU WHERE ROWID = l_rowid;


            EXCEPTION WHEN OTHERS THEN
            --dbms_output.put_line('1-'||SQLERRM||V_A_NUMBER);
            --v_code := SQLCODE;
            --v_errm := SUBSTR(SQLERRM, 1 , 64);
            --INSERT INTO ACTION_LOG (log_user_name,log_action,log_description,log_level)
           --VALUES ('REFORMAT_ENRICH-ENRICH_BU',V_A_NUMBER,v_code||'-'||v_errm,0);

            NULL;

          END;



      END LOOP;
      NUMBER_RECORD:=c1%ROWCOUNT;
   CLOSE c1;
   COMMIT;

  TIME_PROCESS:=(dbms_utility.get_time()-timestart)/100;

    EXCEPTION WHEN OTHERS THEN
            ROLLBACK;
            dbms_output.put_line('2'||SQLERRM);
            INS_ACT_LOG ('REFORMAT_ENRICH-ENRICH_BU','EXCEPTION',SQLERRM,0);

  END ENRICH_BU_TEST;
   PROCEDURE PROCESS_RC_TMP AS
  V_RESELLER_VERSION NUMBER;
  BEGIN
    V_RESELLER_VERSION:=0;
    BEGIN
      SELECT MAX(RESELLER_VERSION_ID) INTO V_RESELLER_VERSION  FROM VNP_COMMON.RESELLER_VERSION WHERE STATUS=3 AND ACTIVE_DATE IS NOT NULL;
      EXCEPTION WHEN OTHERS THEN
                NULL;
      
    END;
    dbms_output.put_line(V_RESELLER_VERSION);
    IF V_RESELLER_VERSION > 0 THEN
     dbms_output.put_line('here');
      MERGE INTO /*+ PARALLEL(HOT_RC_C1RT_TMP) */ HOT_RC_C1RT_TMP RC
      USING (select offer_id,short_name,reseller_version_id from vnp_common.product_offer ) p 
      ON ( RC.offer_id = P.offer_id and reseller_version_id=V_RESELLER_VERSION) 
      WHEN MATCHED THEN
      UPDATE SET RC.short_name = P.short_name;
    END IF;
    IF SQL%ROWCOUNT > 0 THEN
      MOVE_TMP_2_HOT_RC;
    END IF;
    EXCEPTION WHEN OTHERS THEN
            ROLLBACK;
            --dbms_output.put_line('2'||SQLERRM);
  END PROCESS_RC_TMP;

  PROCEDURE MOVE_TMP_2_HOT_RC AS
  V_ROW NUMBER;
  BEGIN
    SELECT COUNT(1) INTO V_ROW FROM HOT_RC_C1RT_TMP;
    
    INSERT /*+  PARALLEL(HOT_RC_C1RT,4)  */ INTO HOT_RC_C1RT 
      SELECT * FROM HOT_RC_C1RT_TMP;
    IF V_ROW = SQL%ROWCOUNT THEN
      COMMIT;
      EXECUTE IMMEDIATE 'TRUNCATE TABLE HOT_RC_C1RT_TMP';
    END IF;
    EXCEPTION WHEN OTHERS THEN
            ROLLBACK;
            --dbms_output.put_line('2'||SQLERRM);
  END MOVE_TMP_2_HOT_RC;

END REFORMAT_ENRICH;
/
