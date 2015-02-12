BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'VNP_DATA.UTIL_PREPARE_HRC_PART');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'VNP_DATA.UTIL_PREPARE_HRC_PART'
      ,start_date      => TO_TIMESTAMP_TZ('2014/12/10 09:11:33.000000 +07:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=Daily;INTERVAL=1;ByHour=00;ByMinute=00'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'BEGIN VNP_DATA.STUFF.ADD_PART_BY_DAY ( ''HOT_RATED_CDR'', ''vnp_data_hrc'', ''VNP_DATA_HRC'', ''/cdr/u01/app/oracle/oradata/eonerate/vnp_data/'', ''hot_rated_cdr'' ); END;'
      ,comments        => 'PREPARE HOT_RATED_CDR PARTITION'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'VNP_DATA.UTIL_PREPARE_HRC_PART'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'VNP_DATA.UTIL_PREPARE_HRC_PART'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'VNP_DATA.UTIL_PREPARE_HRC_PART'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'VNP_DATA.UTIL_PREPARE_HRC_PART'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'VNP_DATA.UTIL_PREPARE_HRC_PART'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'VNP_DATA.UTIL_PREPARE_HRC_PART'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'VNP_DATA.UTIL_PREPARE_HRC_PART'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'VNP_DATA.UTIL_PREPARE_HRC_PART'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'VNP_DATA.UTIL_PREPARE_HRC_PART');
END;
/
