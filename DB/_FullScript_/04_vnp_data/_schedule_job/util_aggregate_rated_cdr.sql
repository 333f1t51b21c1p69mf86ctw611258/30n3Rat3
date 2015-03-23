BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'VNP_DATA.UTIL_AGGREGATE_RATED_CDR');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'VNP_DATA.UTIL_AGGREGATE_RATED_CDR'
      ,start_date      => TO_TIMESTAMP_TZ('2015/03/16 16:13:05.000000 +07:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY;INTERVAL=5;BySecond=00'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN AGGREGATE_RATED_CDR(''1503''); END;'
      ,comments        => 'AGGREGATE DATA RATED_CDR'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'VNP_DATA.UTIL_AGGREGATE_RATED_CDR'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'VNP_DATA.UTIL_AGGREGATE_RATED_CDR'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'VNP_DATA.UTIL_AGGREGATE_RATED_CDR'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'VNP_DATA.UTIL_AGGREGATE_RATED_CDR'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'VNP_DATA.UTIL_AGGREGATE_RATED_CDR'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'VNP_DATA.UTIL_AGGREGATE_RATED_CDR'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'VNP_DATA.UTIL_AGGREGATE_RATED_CDR'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'VNP_DATA.UTIL_AGGREGATE_RATED_CDR'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'VNP_DATA.UTIL_AGGREGATE_RATED_CDR');
END;
/
