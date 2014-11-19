BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'VNP_COMMON.JOB_FILTER_NEW_PCAT_DATA');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'VNP_COMMON.JOB_FILTER_NEW_PCAT_DATA'
      ,start_date      => NULL
      ,repeat_interval => NULL
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'STORED_PROCEDURE'
      ,job_action      => 'VNP_COMMON.ELC_USER_FILTER.LETS_GO'
      ,comments        => NULL
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'VNP_COMMON.JOB_FILTER_NEW_PCAT_DATA'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'VNP_COMMON.JOB_FILTER_NEW_PCAT_DATA'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'VNP_COMMON.JOB_FILTER_NEW_PCAT_DATA'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'VNP_COMMON.JOB_FILTER_NEW_PCAT_DATA'
     ,attribute => 'MAX_RUNS');
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'VNP_COMMON.JOB_FILTER_NEW_PCAT_DATA'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'VNP_COMMON.JOB_FILTER_NEW_PCAT_DATA'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'VNP_COMMON.JOB_FILTER_NEW_PCAT_DATA'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'VNP_COMMON.JOB_FILTER_NEW_PCAT_DATA'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'VNP_COMMON.JOB_FILTER_NEW_PCAT_DATA'
     ,attribute => 'number_of_arguments'
     ,value     => 1);

  SYS.DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE
    ( job_name             => 'VNP_COMMON.JOB_FILTER_NEW_PCAT_DATA'
     ,argument_position    => 1
     ,argument_value       => '2');
END;
/
