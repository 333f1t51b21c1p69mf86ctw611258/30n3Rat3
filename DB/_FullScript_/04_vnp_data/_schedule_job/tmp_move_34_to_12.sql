/* Formatted on 1/28/2015 5:35:19 PM (QP5 v5.215.12089.38647) */
BEGIN
   SYS.DBMS_SCHEDULER.DROP_JOB (job_name => 'VNP_DATA.tmp_move_34_to_12');
END;
/

BEGIN
   SYS.DBMS_SCHEDULER.CREATE_JOB (
      job_name          => 'VNP_DATA.tmp_move_34_to_12',
      start_date        => SYSDATE, -- TO_TIMESTAMP_TZ('2014/12/10 09:11:33.000000 +07:00','yyyy/mm/dd hh24:mi:ss.ff tzr'),
      repeat_interval   => 'FREQ=Monthly;INTERVAL=1;BYMONTHDAY=1;ByHour=00;ByMinute=00',
      end_date          => NULL,
      job_class         => 'DEFAULT_JOB_CLASS',
      job_type          => 'PLSQL_BLOCK',
      job_action        => 'BEGIN 
                                INSERT INTO hot_rated_cdr_1
                                   SELECT * FROM hot_rated_cdr_temp1;

                                COMMIT;

                                INSERT INTO hot_rated_cdr_2
                                   SELECT * FROM hot_rated_cdr_temp2;

                                COMMIT;
                            END;',
      comments          => 'AAAAA');
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (name        => 'VNP_DATA.tmp_move_34_to_12',
                                     attribute   => 'RESTARTABLE',
                                     VALUE       => FALSE);
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (
      name        => 'VNP_DATA.tmp_move_34_to_12',
      attribute   => 'LOGGING_LEVEL',
      VALUE       => SYS.DBMS_SCHEDULER.LOGGING_OFF);
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL (
      name        => 'VNP_DATA.tmp_move_34_to_12',
      attribute   => 'MAX_FAILURES');
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL (
      name        => 'VNP_DATA.tmp_move_34_to_12',
      attribute   => 'MAX_RUNS');

   BEGIN
      SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (
         name        => 'VNP_DATA.tmp_move_34_to_12',
         attribute   => 'STOP_ON_WINDOW_CLOSE',
         VALUE       => FALSE);
   EXCEPTION
      -- could fail if program is of type EXECUTABLE...
      WHEN OTHERS
      THEN
         NULL;
   END;

   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (name        => 'VNP_DATA.tmp_move_34_to_12',
                                     attribute   => 'JOB_PRIORITY',
                                     VALUE       => 3);
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL (
      name        => 'VNP_DATA.tmp_move_34_to_12',
      attribute   => 'SCHEDULE_LIMIT');
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (name        => 'VNP_DATA.tmp_move_34_to_12',
                                     attribute   => 'AUTO_DROP',
                                     VALUE       => TRUE);

   SYS.DBMS_SCHEDULER.ENABLE (name => 'VNP_DATA.tmp_move_34_to_12');
END;
/