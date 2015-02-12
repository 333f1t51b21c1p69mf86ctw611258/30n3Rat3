/* Formatted on 1/30/2015 11:11:55 AM (QP5 v5.269.14213.34746) */
BEGIN
   SYS.DBMS_SCHEDULER.DROP_JOB (
      job_name   => 'VNP_DATA.UTIL_AGGR_MOVE_12_TO_HOT');
END;
/

BEGIN
   SYS.DBMS_SCHEDULER.CREATE_JOB (
      job_name          => 'VNP_DATA.UTIL_AGGR_MOVE_12_TO_HOT',
      start_date        => SYSDATE, -- TO_TIMESTAMP_TZ('2014/12/10 09:11:33.000000 +07:00','yyyy/mm/dd hh24:mi:ss.ff tzr'),
      repeat_interval   => 'FREQ=MINUTELY;INTERVAL=30;BySecond=00',
      end_date          => NULL,
      job_class         => 'DEFAULT_JOB_CLASS',
      job_type          => 'PLSQL_BLOCK',
      job_action        => 'BEGIN VNP_DATA.STUFF.AGGR_MOVE_TO_HOT; END;',
      comments          => 'AGGREGATE, MOVE DATA FROM HRC_1, 2 TO HRC');
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (
      name        => 'VNP_DATA.UTIL_AGGR_MOVE_12_TO_HOT',
      attribute   => 'RESTARTABLE',
      VALUE       => FALSE);
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (
      name        => 'VNP_DATA.UTIL_AGGR_MOVE_12_TO_HOT',
      attribute   => 'LOGGING_LEVEL',
      VALUE       => SYS.DBMS_SCHEDULER.LOGGING_OFF);
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL (
      name        => 'VNP_DATA.UTIL_AGGR_MOVE_12_TO_HOT',
      attribute   => 'MAX_FAILURES');
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL (
      name        => 'VNP_DATA.UTIL_AGGR_MOVE_12_TO_HOT',
      attribute   => 'MAX_RUNS');

   BEGIN
      SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (
         name        => 'VNP_DATA.UTIL_AGGR_MOVE_12_TO_HOT',
         attribute   => 'STOP_ON_WINDOW_CLOSE',
         VALUE       => FALSE);
   EXCEPTION
      -- could fail if program is of type EXECUTABLE...
      WHEN OTHERS
      THEN
         NULL;
   END;

   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (
      name        => 'VNP_DATA.UTIL_AGGR_MOVE_12_TO_HOT',
      attribute   => 'JOB_PRIORITY',
      VALUE       => 3);
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL (
      name        => 'VNP_DATA.UTIL_AGGR_MOVE_12_TO_HOT',
      attribute   => 'SCHEDULE_LIMIT');
   SYS.DBMS_SCHEDULER.SET_ATTRIBUTE (
      name        => 'VNP_DATA.UTIL_AGGR_MOVE_12_TO_HOT',
      attribute   => 'AUTO_DROP',
      VALUE       => TRUE);

   SYS.DBMS_SCHEDULER.ENABLE (name => 'VNP_DATA.UTIL_AGGR_MOVE_12_TO_HOT');
END;
/