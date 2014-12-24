BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'VNP_DATA.COMPENSATE_PREVIOUS_MONTH');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'VNP_DATA.COMPENSATE_PREVIOUS_MONTH'
      ,start_date      => TO_TIMESTAMP_TZ('2014/06/06 10:50:02.000000 +07:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY; BYMONTHDAY=1; INTERVAL=5;'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin STUFF.COMPENSATE_PREVIOUS_MONTH; end;'
      ,comments        => 'Compensate previous month'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'VNP_DATA.COMPENSATE_PREVIOUS_MONTH'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'VNP_DATA.COMPENSATE_PREVIOUS_MONTH'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'VNP_DATA.COMPENSATE_PREVIOUS_MONTH'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'VNP_DATA.COMPENSATE_PREVIOUS_MONTH'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'VNP_DATA.COMPENSATE_PREVIOUS_MONTH'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'VNP_DATA.COMPENSATE_PREVIOUS_MONTH'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'VNP_DATA.COMPENSATE_PREVIOUS_MONTH'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'VNP_DATA.COMPENSATE_PREVIOUS_MONTH'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'VNP_DATA.COMPENSATE_PREVIOUS_MONTH');
END;
/
