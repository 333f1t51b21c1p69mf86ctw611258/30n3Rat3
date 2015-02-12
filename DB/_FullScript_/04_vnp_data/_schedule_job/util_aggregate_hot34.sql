/* Formatted on 27/1/2015 16:38:00 (QP5 v5.215.12089.38647) */
BEGIN
   SYS.DBMS_SCHEDULER.DROP_JOB (job_name => 'VNP_DATA.UTIL_AGGREGATE_HRC_34');
END;
/

BEGIN
   SYS.DBMS_SCHEDULER.CREATE_JOB (
      job_name          => 'VNP_DATA.UTIL_AGGREGATE_HRC_34',
      start_date        => SYSDATE, -- TO_TIMESTAMP_TZ('2014/12/10 09:11:33.000000 +07:00','yyyy/mm/dd hh24:mi:ss.ff tzr'),
      repeat_interval   => 'FREQ=MINUTELY;INTERVAL=5;BySecond=00',
      end_date          => NULL,
      job_class         => 'DEFAULT_JOB_CLASS',
      job_type          => 'PLSQL_BLOCK',
      job_action        => 'BEGIN VNP_DATA.STUFF.AGGREGATE_HRC_34; END;',
      comments          => 'AGGREGATE DATA FROM HRC_3, 4');
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (
      name        => 'VNP_DATA.UTIL_AGGREGATE_HRC_34',
      attribute   => 'RESTARTABLE',
      VALUE       => FALSE);
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (
      name        => 'VNP_DATA.UTIL_AGGREGATE_HRC_34',
      attribute   => 'LOGGING_LEVEL',
      VALUE       => SYS.DBMS_SCHEDULER.LOGGING_OFF);
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL (
      name        => 'VNP_DATA.UTIL_AGGREGATE_HRC_34',
      attribute   => 'MAX_FAILURES');
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL (
      name        => 'VNP_DATA.UTIL_AGGREGATE_HRC_34',
      attribute   => 'MAX_RUNS');

   BEGIN
      SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (
         name        => 'VNP_DATA.UTIL_AGGREGATE_HRC_34',
         attribute   => 'STOP_ON_WINDOW_CLOSE',
         VALUE       => FALSE);
   EXCEPTION
      -- could fail if program is of type EXECUTABLE...
      WHEN OTHERS
      THEN
         NULL;
   END;

   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (
      name        => 'VNP_DATA.UTIL_AGGREGATE_HRC_34',
      attribute   => 'JOB_PRIORITY',
      VALUE       => 3);
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL (
      name        => 'VNP_DATA.UTIL_AGGREGATE_HRC_34',
      attribute   => 'SCHEDULE_LIMIT');
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (
      name        => 'VNP_DATA.UTIL_AGGREGATE_HRC_34',
      attribute   => 'AUTO_DROP',
      VALUE       => TRUE);

   SYS.DBMS_SCHEDULER.ENABLE (name => 'VNP_DATA.UTIL_AGGREGATE_HRC_34');
END;
/