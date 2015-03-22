/* Formatted on 12/22/2014 2:32:23 PM (QP5 v5.215.12089.38647) */
BEGIN
   SYS.DBMS_SCHEDULER.DROP_JOB (job_name => 'VNP_DATA.UTIL_MOVE_HRC_34_TO_HRC');
END;
/

BEGIN
   SYS.DBMS_SCHEDULER.CREATE_JOB (
      job_name          => 'VNP_DATA.UTIL_MOVE_HRC_34_TO_HRC',
      start_date        => SYSDATE, -- TO_TIMESTAMP_TZ('2014/12/10 09:11:33.000000 +07:00','yyyy/mm/dd hh24:mi:ss.ff tzr'),
      repeat_interval   => 'FREQ=Hourly;INTERVAL=1;ByMinute=00',
      end_date          => NULL,
      job_class         => 'DEFAULT_JOB_CLASS',
      job_type          => 'PLSQL_BLOCK',
      job_action        => 'BEGIN VNP_DATA.STUFF.MOVE_HRC_34_TO_HRC; END;',
      comments          => 'MOVE DATA FROM HRC_3, 4 TO HRC');
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (
      name        => 'VNP_DATA.UTIL_MOVE_HRC_34_TO_HRC',
      attribute   => 'RESTARTABLE',
      VALUE       => FALSE);
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (
      name        => 'VNP_DATA.UTIL_MOVE_HRC_34_TO_HRC',
      attribute   => 'LOGGING_LEVEL',
      VALUE       => SYS.DBMS_SCHEDULER.LOGGING_OFF);
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL (
      name        => 'VNP_DATA.UTIL_MOVE_HRC_34_TO_HRC',
      attribute   => 'MAX_FAILURES');
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL (
      name        => 'VNP_DATA.UTIL_MOVE_HRC_34_TO_HRC',
      attribute   => 'MAX_RUNS');

   BEGIN
      SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (
         name        => 'VNP_DATA.UTIL_MOVE_HRC_34_TO_HRC',
         attribute   => 'STOP_ON_WINDOW_CLOSE',
         VALUE       => FALSE);
   EXCEPTION
      -- could fail if program is of type EXECUTABLE...
      WHEN OTHERS
      THEN
         NULL;
   END;

   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (
      name        => 'VNP_DATA.UTIL_MOVE_HRC_34_TO_HRC',
      attribute   => 'JOB_PRIORITY',
      VALUE       => 3);
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL (
      name        => 'VNP_DATA.UTIL_MOVE_HRC_34_TO_HRC',
      attribute   => 'SCHEDULE_LIMIT');
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (
      name        => 'VNP_DATA.UTIL_MOVE_HRC_34_TO_HRC',
      attribute   => 'AUTO_DROP',
      VALUE       => TRUE);

   SYS.DBMS_SCHEDULER.ENABLE (name => 'VNP_DATA.UTIL_MOVE_HRC_34_TO_HRC');
END;
/